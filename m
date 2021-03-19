Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9484C341B10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSLEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:04:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41082 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCSLEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:04:00 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNCv7-0003Du-Rl; Fri, 19 Mar 2021 11:03:57 +0000
Date:   Fri, 19 Mar 2021 12:03:56 +0100
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
Message-ID: <20210319110356.p4jtyvzuuwwixq5g@wittgenstein>
References: <CAMp4zn9oEb6bJJLQWjSE1AFg6TqwkF3FOvFk2VSkKd+0Kj7TCg@mail.gmail.com>
 <20210301110907.2qoxmiy55gpkgwnq@wittgenstein>
 <20210301132156.in3z53t5xxy3ity5@wittgenstein>
 <202103011515.3A941F6@keescook>
 <20210318145454.d2xbetk2werv7j2u@wittgenstein>
 <20210318203912.GA26982@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318203912.GA26982@ircssh-2.c.rugged-nimbus-611.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:39:13PM +0000, Sargun Dhillon wrote:
> On Thu, Mar 18, 2021 at 03:54:54PM +0100, Christian Brauner wrote:
> > Sorry, I just found that mail.
> > 
> > On Mon, Mar 01, 2021 at 03:44:06PM -0800, Kees Cook wrote:
> > > On Mon, Mar 01, 2021 at 02:21:56PM +0100, Christian Brauner wrote:
> > > > On Mon, Mar 01, 2021 at 12:09:09PM +0100, Christian Brauner wrote:
> > > > > On Sat, Feb 20, 2021 at 01:31:57AM -0800, Sargun Dhillon wrote:
> > > > > > We've run into a problem where attaching a filter can be quite messy
> > > > > > business because the filter itself intercepts sendmsg, and other
> > > > > > syscalls related to exfiltrating the listener FD. I believe that this
> > > > > > problem set has been brought up before, and although there are
> > > > > > "simpler" methods of exfiltrating the listener, like clone3 or
> > > > > > pidfd_getfd, but these are still less than ideal.
> > > 
> > > I'm trying to make sure I understand: the target process would like to
> > > have a filter attached that blocks sendmsg, but that would mean it has
> > > no way to send the listener FD to its manager?
> > 
> > With pidfd_getfd() that wouldn't be a problem, I think which is what I
> > was trying to say. Unless the supervising task doen't have enough
> > privilege over the supervised task which seems like an odd scenario but
> > is technically possible, I guess.
> > 
> > > 
> > > And you'd want to have listening working for sendmsg (otherwise you
> > > could do it with two filters, I imagine)?
> > > 
> > > > > 	int fd_filter = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_DETACHED, &prog);
> > > > > 
> > > > > 	BARRIER_WAIT_SETUP_DONE;
> > > > > 
> > > > > 	int ret = seccomp(SECCOMP_ATTACH_FILTER, 0, INT_TO_PTR(fd_listener));
> > > > 
> > > > This obviously should've been sm like:
> > > > 
> > > > struct seccomp_filter_attach {
> > > > 	union {
> > > > 		__s32 pidfd;
> > > > 		__s32 pid;
> > > > 	};
> > > > 	__u32 fd_filter;
> > > > };
> > > > 
> > > > and then
> > > > 
> > > > int ret = seccomp(SECCOMP_ATTACH_FILTER, 0, seccomp_filter_attach);
> > > 
> > > Given the difficulty with TSYNC, I'm not excited about adding an
> > > "apply this filter to another process" API. :)
> > 
> > Just to give a more complete reason for suggesting something like this
> > without trying to argue that we must have this:
> > 
> > seccomp() has so far been an API that is caller-centric and by that I
> > mean that the caller loaded it's seccomp profile and sandboxed itself. As
> > such seccomp is an example of "caller-managed" security. This security
> > model has obvious advantages and fits into the general fork()-like world
> > of unix. But imho that self-management model breaks down as soon as a
> > file descriptor that can be used to refer to the object in question
> > enters into the picture. For seccomp this "breaking point" was the
> > seccomp notifier fd.
> > 
> > Because with the introduction of that fd we have introduced the concept
> > of supervisor and supervisee for seccomp which imho didn't really exist
> > in the same way before. It's pretty obvious from the type of language
> > that we now use both in userspace and in kernelspace when we talk about
> > the seccomp notifier.
> > 
> > At the current point we're somewhere in the middle between caller-managed
> > and supervised seccomp which brings up funny probelms and edge-cases.
> > One of them most obvious examples is in fact the question how to get the
> > seccomp notify fd out of the supervised task. This clearly points to the
> > fact that we're missing one of the fundamentals of an fd-based
> > supervision model: open(). This is why I was suggesting the
> > SECCOMP_ATTACH_FILTER command. It's in a sense an open-call for the
> > seccomp notify fd.
> > 
> > That all being said I know that it can be weird to implement this and if
> > you prefer we go with another simpler model to work around such things
> > than I fully understand.
> > 
> > Christian
> 
> So, beyond clone3 to get pidfds being kind of awkward, how do you see this

Afaict we're talking about getting a file descriptor out of another
task. So just for my understanding what does clone3()'s way of returning
pidfds have to do with this and why is returning a pidfd in clone3()
awkward?

> pattern actually working? How does the filter installer let the supervisor

Sorry, what pattern are you referring to, i.e. is this a
critique/questions of my attach api proposal or of my statement about
using pidfd_getfd() to retrieve the fd? I think I'm just a little
confused about where you chose to place your reply in the thread. :)
Just to reiterate briefly: my preferred variant is to have an api
similar to what I proposed above where we can essentially prepare a
filter for another task and attach it to that task. In that model the fd
is retrieved directly by the supervisor without any need for cooperation
from the supervisee. After that you just need simply barriers (pipe,
socket etc.) to synchronize with the supervisee. For example, a
supervise does all the setup it wants and then sends a message over a
socket or pipe to the supervisor signaling it's ready and then the parent
attaches the child to its seccomp filter via some form of the command I
proposed above.

> know that it's ready for extraction? pause() + signaling the parent?

> 
> In the case that you're not fork-execing, how do you communicate to the 
> notifier? My coworkers have been working on this code, where they need to 
> connect to a daemon that does the supervision, and it's gnarly[1]. They're 
> looking at adding sendmsg to the filter list, and that complicates things.
> 
> I think that pidfd_getfd works well if the child has some way to signal to the 
> parent that it's ready and that the filter has been installed, but when your 
> filter intercepts connect, and sendmsg, and the supervisor is not your parent 
> (and your parent is some compiled, COTS software), it becomes complicated to 
> handle this.
> 
> I believe that the OCI spec[2] is going to run into this class of problem unless 
> we introduce an out of band signaling mechanism. I think a valid way to handle 
> this is do a send() of the fd number (literal), and wait for the other side to 
> pidfd_getfd the seccomp filter, and wait for the socket to be closed to continue,
> but I think we should maybe create an example (I volunteer) showing how to do this.

So at first it seems were looking at very different cases here:

- Supervisor and supervisee do not have a child-parent relationship
- Supervisor and supervisee do have a child-parent relationship

But in both scenarios you must have a way for the supervisor and
supervisee to communicate with each other. If you don't then I'd be
curious how you manage to supervise the setup process of the supervisee
even independent of the seccomp notifier. (Your first link seems to show
a non-child-parent supervisor-supervisee relationship and you
communicate  between supervisor and supervisee via a socket.)

I think you have two immediate ways of solving this problem (Possibly
more but I would need to think a bit more and I think that the two
solutions would solve most cases.):
1. Send the fd number and use pidfd_getfd() (Which is also what Rodrigo
   mentioned.).
   This can technically be a problem when somehow the supervisee is
   blocked from using any kind of write method to a pipe which I find to
   be a very artifical example.
   And in fact looking at [1] runC is writing to a fifo after the
   seccomp profile has been loaded so a similar method of telling the
   parent which fd number to retrieve should always work.
2. Use a shared memory location: Have the supervisor create a file
   created via memfd_create(). Send that fd to the supervisee. (Make the
   fd close-on-exec in case you for some reason want to block close()
   which again looking at [1] would mean you'd violate assumptions about
   what syscalls are available after loading the seccomp profile.)
   Have the supervisee mmap() that location (In case you're blocking
   write which again, doesn't work with current assumption.). Have it
   load it's seccomp profile. Write the fd number to that memory
   location. The mmap() memory will be cleared on exec so no need to
   have munmap() available.

But again, I prefer a model I suggested above.

[1]: https://github.com/opencontainers/runc/blob/4d4d19ce528ac40cc357ef92cd3a6931dba19316/libcontainer/standard_init_linux.go#L192

Christian
