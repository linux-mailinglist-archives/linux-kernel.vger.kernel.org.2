Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4E3DEF97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhHCOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236483AbhHCOBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:01:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E95C860EC0;
        Tue,  3 Aug 2021 14:01:36 +0000 (UTC)
Date:   Tue, 3 Aug 2021 16:01:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     keescook@chromium.org, ktkhai@virtuozzo.com,
        jamorris@linux.microsoft.com, varad.gautam@suse.com,
        legion@kernel.org, dbueso@suse.de, linux-kernel@vger.kernel.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] ipc: add set_ownership() and permissions() callbacks for
 posix mqueue sysctl
Message-ID: <20210803140133.vksebmgqhlbqipla@wittgenstein>
References: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
 <20210729145348.hvvhu6lmlcn5js4y@wittgenstein>
 <20210803103150.GA607784@www>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803103150.GA607784@www>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 03:31:50AM -0700, CGEL wrote:
> O Thu, Jul 29, 2021 at 04:53:48PM +0200, Christian Brauner wrote:
> > 
> > Yeah, we did that work specifically for the network namespace but knew
> > there were quite a few places that would need fix up. This makes sense
> > to me.
> > 
> > Please add tests for this patch though. Also make sure to run them in a
> > tight loop on a kernel with memory and log debugging enabled.
>   For now i have rebuilt the kernel turning on the config items you
>   suggested and some other kernel hacking and locking debug configs.
>   I tested this by a shell script concurrently writing the mqueue sysctl
>   files and checking the value. Do you mean that i should add some test code in this patch?
>   Can you give some examples for this tests code?

Yep, I'd prefer to see tests with this. This should be fairly easy to
test. There are a bunch of ways. A really trivial skeleton for a test in
tools/testing/selftstes/mqueue/ could be:

- Create a new mount and ipc namespace and mount mqueue in there.
  Read and remember the /proc/sys/fs/mqueue/queues_max value.
- Now create a new user + mount namespace pair in a child process.
- Mount mqueue filesystem in there.
- Set /proc/sys/fs/mqueue/queues_max to 1.
- Call mq_open with O_CREAT in the child process the first time and
  expect success keeping the fd open.
- Call mq_open with O_CREAT in the child process a second time and
  expect failure because of:

	if (ipc_ns->mq_queues_count >= ipc_ns->mq_queues_max &&
	    !capable(CAP_SYS_RESOURCE)) {
		error = -ENOSPC;
		goto out_unlock;
	}
	ipc_ns->mq_queues_count++;
	spin_unlock(&mq_lock);

- Reap the child in the parent expecting success.
- Verify that the /proc/sys/fs/mqueue/queues_max value in the parent is
  identical to the value you read before creating the child.

This should be a very rough test that at least the fundamentals of this
change are sane.

This doesn't have to be complex.

Here's the code from a test I've written for mount_setattr() to create
an unpriv mount + userns which might be the annoying part:

#include "../../kselftest_harness.h"
#include "../pidfd.h" /* for wait_for_pid() */

static ssize_t write_nointr(int fd, const void *buf, size_t count)
{
	ssize_t ret;

	do {
		ret = write(fd, buf, count);
	} while (ret < 0 && errno == EINTR);

	return ret;
}

static int write_file(const char *path, const void *buf, size_t count)
{
	int fd;
	ssize_t ret;

	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
	if (fd < 0)
		return -1;

	ret = write_nointr(fd, buf, count);
	close(fd);
	if (ret < 0 || (size_t)ret != count)
		return -1;

	return 0;
}

static int create_and_enter_userns(void)
{
	uid_t uid;
	gid_t gid;
	char map[100];

	uid = getuid();
	gid = getgid();

	if (unshare(CLONE_NEWUSER))
		return -1;

	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
	    errno != ENOENT)
		return -1;

	snprintf(map, sizeof(map), "0 %d 1", uid);
	if (write_file("/proc/self/uid_map", map, strlen(map)))
		return -1;


	snprintf(map, sizeof(map), "0 %d 1", gid);
	if (write_file("/proc/self/gid_map", map, strlen(map)))
		return -1;

	if (setgid(0))
		return -1;

	if (setuid(0))
		return -1;

	return 0;
}

static int prepare_unpriv_mountns(void)
{
	if (create_and_enter_userns())
		return -1;

	if (unshare(CLONE_NEWNS))
		return -1;

	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
		return -1;

	if (unshare(CLONE_NEWIPC))
		return -1;

	return 0;
}

TEST(mqueue_sysctls)
{
	int ret;
	pid_t pid;

	if (unshare(CLONE_NEWNS))
		return -1;

	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
		return -1;

	if (unshare(CLONE_NEWIPC))
		return -1;

	/* Mount new mqueue instance, read and stash sysctl value. */

	pid = fork();
	ASSERT_GE(pid, 0) {
		TH_LOG("%s - Failed to fork", strerror(errno));
	}

	if (pid == 0) {
		ASSERT_EQ(prepare_unpriv_mountns(), 0);

		/* mount new mqueue instance, setup sysctls and perform mq_open() tests. */

		exit(EXIT_SUCCESS);
	}

	ASSERT_EQ(wait_for_pid(pid), 0);


	/* Read sysctl value again making sure it's still the same as before. */
}

TEST_HARNESS_MAIN

> 
> > The whole sysctl retire stuff can't be called from rcu contexts and that's easy to
> > miss. 
>   for this patch, retire_mq_sysctls() is called by free_ipc_ns(), and free_ipc_ns() is 
>   triggered by schedule_work(&free_ipc_work) in kthread context.
>   Can you give some comments on the chance this code running on rcu
>   context?

I really just prefer to see sysctl namespacing changes compiled with all
manner of debugging options enabled as they can quite easily uncover
bugs where the sysctl cleanup helpers are called from invalid contexts.
That has happened to me when I worked on some sysctl changes a while
back and thought I had followed all codepaths diligently to make sure
that nothing calls the sysctl cleanup code from invalid contexts. I only
caught the codepath that did because I had all of the options turned on.
