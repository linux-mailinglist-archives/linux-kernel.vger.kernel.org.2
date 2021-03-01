Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E258F327CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhCALJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:09:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38881 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhCALJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:09:53 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lGgQG-00084S-Rm; Mon, 01 Mar 2021 11:09:08 +0000
Date:   Mon, 1 Mar 2021 12:09:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Hariharan Ananthakrishnan <hari@netflix.com>,
        Keerti Lakshminarayan <keerti@netflix.com>,
        Kyle Anderson <kylea@netflix.com>,
        Linux Containers List <containers@lists.linux-foundation.org>,
        stgraber@ubuntu.com, Andy Lutomirski <luto@amacapital.net>
Subject: Re: seccomp: Delay filter activation
Message-ID: <20210301110907.2qoxmiy55gpkgwnq@wittgenstein>
References: <CAMp4zn9oEb6bJJLQWjSE1AFg6TqwkF3FOvFk2VSkKd+0Kj7TCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn9oEb6bJJLQWjSE1AFg6TqwkF3FOvFk2VSkKd+0Kj7TCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 01:31:57AM -0800, Sargun Dhillon wrote:
> We've run into a problem where attaching a filter can be quite messy
> business because the filter itself intercepts sendmsg, and other
> syscalls related to exfiltrating the listener FD. I believe that this
> problem set has been brought up before, and although there are
> "simpler" methods of exfiltrating the listener, like clone3 or
> pidfd_getfd, but these are still less than ideal.

(You really like sending patches and discussion points in the middle of
the merge window. :D I think everyone's panicked about getting their PRs
in shape so it's not unlikely that this sometimes gets lost on the list. :))

It hasn't been a huge problem for us, especially since we added
pidfd_getfd() this seemed like a straightforward problem to solve by
selecting a fix fd number that is to be used for the listener. But I can
see why it is annoying.

> 
> One of the ideas that's been talked about (I want to say back at LSS
> NA) is the idea of "delayed activation". I was thinking that it might
> be nice to have a mechanism to do delayed attach, either activated on
> execve / fork, or an ioctl on the listenerfd to activate the filter
> and have a flag like SECCOMP_FILTER_FLAG_NEW_LISTENER_INACTIVE, which
> indicates that the listener should be setup, but not enforcing, and
> another ioctl to activate it.
> 
> The later approach is preferred due to simplicity, but I can see a
> situation where you could accidentally get into a state where the
> filter is not being enforced. Additionally, this may have unforeseen
> implications with CRIU.

(If you were to expose an ioctl() that allows userspace to query the
notifer state then CRIU shouldn't have a problem restoring the notifier
in the correct state. Right now it doesn't do anyting fancy about the
notifier, it just restores the task with the filter. It just has to
learn about the new feature and that's fine imho.)

> 
> I'm curious whether this is a problem others share, and whether any of
> the aforementioned approaches seem reasonable.

So when I originally suggested the delayed activation I I had another
related idea that I think I might have mentioned too: if we're already
considering delaying filter activation I like to discuss the possibility
of attaching a seccomp filter to a task.

Right now, if one task wants to attach to another task they need to
recreate the whole seccomp filter and load it. That's not just pretty
expensive but also only works if you have access to the rules that the
filter was generated with. For container that's usually some sort of
pseudo seccomp filter configuration language dumped into a config file
from which it can be read.

So right now the status quo is:

struct sock_filter filter[] = {
        BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, nr)),
        BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, nr, 0, 1),
        BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF), /* Get me a listener fd */
        BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
};
struct sock_fprog prog = {
        .len = (unsigned short)ARRAY_SIZE(filter),
        .filter = filter,
};
int fd = seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);

and then the caller must send the fd to the manager or the manager uses
pidfd_getfd().

But, why not get a bit crazy^wcreative; especially since seccomp() is
already a multiplexer. We introduce a new seccomp flag:

#define SECCOMP_FILTER_DETACHED

and a new seccomp command:

#define SECCOMP_ATTACH_FILTER

And now we could do something like:

pid_t pid = fork();
if (pid < 0)
	return;

if (pid == 0) {
	// do stuff
	BARRIER_WAKE_SETUP_DONE;

	// do more unrelated stuff

	BARRIER_WAIT_SECCOMP_FILTER;
	execve(exec-something);
} else {
	
	int fd_filter;

	struct sock_filter filter[] = {
	        BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, nr)),
	        BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, nr, 0, 1),
	        BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
	};
	
	struct sock_fprog prog = {
	        .len = (unsigned short)ARRAY_SIZE(filter),
	        .filter = filter,
	};
	
	int fd_filter = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_DETACHED, &prog);

	BARRIER_WAIT_SETUP_DONE;

	int ret = seccomp(SECCOMP_ATTACH_FILTER, 0, INT_TO_PTR(fd_listener));

	BARRIER_WAKE_SECCOMP_FILTER;
}

And now you have attached a filter to another task. This would be super
elegant for a container manager. The container manager could also stash
the filter fd and when attaching to a container the manager can send the
attaching task the fd and the attaching task can do:

int ret = seccomp(SECCOMP_ATTACH_FILTER, 0, INT_TO_PTR(fd_filter));

too and would be attached to the same filter as the target task.

And for the listener fd case a container manager could simply set
SECCOMP_RET_USER_NOTIF as before

	struct sock_filter filter[] = {
	        BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, nr)),
	        BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, nr, 0, 1),
		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
	        BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
	};

and now fd_filter simply functions as the notifier fd after
seccomp(SECCOMP_ATTACH_FILTER) that's basically the fancy version of my
delayed notifier activiation idea.

I'm sure there's nastiness to figure out but I would love to see
something like this.

Christian
