Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6E3F5D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhHXMGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236621AbhHXMGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E122961262;
        Tue, 24 Aug 2021 12:05:26 +0000 (UTC)
Date:   Tue, 24 Aug 2021 14:05:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Ran Xiaokai <cgel.zte@gmail.com>
Cc:     dbueso@suse.de, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH] tests: add mqueue sysctl tests for user namespace
Message-ID: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
References: <20210803140133.vksebmgqhlbqipla@wittgenstein>
 <20210823032909.45736-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823032909.45736-1-ran.xiaokai@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 08:29:09PM -0700, Ran Xiaokai wrote:
> when a ipc namespace is created in a user namespace, the mqueue sysctl
> files should be writalbe to the owner of the user namespace. Even the
> owner is not a global privileged user.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---

Ran,

Sorry for not replying to your other mail earlier. I read it but I
simply did not have time to respond in any meaningful way to it.

Assuming the test-run works and David is happy with the test too I can
pick it up together with the main patch.

>  tools/testing/selftests/Makefile                   |   1 +
>  tools/testing/selftests/mqueue_sysctl/Makefile     |   7 +
>  tools/testing/selftests/mqueue_sysctl/config       |   2 +
>  .../selftests/mqueue_sysctl/mq_sysctl_test.c       | 172 +++++++++++++++++++++

I think you need to add the binary to .gitignore btw.

>  4 files changed, 182 insertions(+)
>  create mode 100644 tools/testing/selftests/mqueue_sysctl/Makefile
>  create mode 100644 tools/testing/selftests/mqueue_sysctl/config
>  create mode 100644 tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index bc3299a..2031591 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -36,6 +36,7 @@ TARGETS += mincore
>  TARGETS += mount
>  TARGETS += mount_setattr
>  TARGETS += mqueue
> +TARGETS += mqueue_sysctl
>  TARGETS += nci
>  TARGETS += net
>  TARGETS += net/forwarding
> diff --git a/tools/testing/selftests/mqueue_sysctl/Makefile b/tools/testing/selftests/mqueue_sysctl/Makefile
> new file mode 100644
> index 0000000..44b6633
> --- /dev/null
> +++ b/tools/testing/selftests/mqueue_sysctl/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -O2
> +LDLIBS = -lrt
> +
> +TEST_GEN_PROGS := mq_sysctl_test
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/mqueue_sysctl/config b/tools/testing/selftests/mqueue_sysctl/config
> new file mode 100644
> index 0000000..68b2794
> --- /dev/null
> +++ b/tools/testing/selftests/mqueue_sysctl/config
> @@ -0,0 +1,2 @@
> +CONFIG_USER_NS=y
> +CONFIG_POSIX_MQUEUE_SYSCTL=y
> \ No newline at end of file
> diff --git a/tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c b/tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c
> new file mode 100644
> index 0000000..48023d5
> --- /dev/null
> +++ b/tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sched.h>
> +#include <sys/mount.h>
> +#include <mqueue.h>
> +#include <sys/wait.h>
> +#include <string.h>
> +
> +#include "../kselftest_harness.h"
> +
> +static ssize_t write_nointr(int fd, const void *buf, size_t count)
> +{
> +	ssize_t ret;
> +
> +	do {
> +		ret = write(fd, buf, count);
> +	} while (ret < 0 && errno == EINTR);
> +
> +	return ret;
> +}
> +
> +static int write_file(const char *path, const void *buf, size_t count)
> +{
> +	int fd;
> +	ssize_t ret;
> +
> +	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
> +	if (fd < 0)
> +		return -1;
> +
> +	ret = write_nointr(fd, buf, count);
> +	close(fd);
> +	if (ret < 0 || (size_t)ret != count)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int create_and_enter_userns(void)
> +{
> +	uid_t uid;
> +	gid_t gid;
> +	char map[100];
> +
> +	uid = getuid();
> +	gid = getgid();
> +
> +	if (unshare(CLONE_NEWUSER))
> +		return -1;
> +
> +	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
> +				errno != ENOENT)
> +		return -1;
> +
> +	snprintf(map, sizeof(map), "0 %d 1", uid);
> +	if (write_file("/proc/self/uid_map", map, strlen(map)))
> +		return -1;
> +
> +	snprintf(map, sizeof(map), "0 %d 1", gid);
> +	if (write_file("/proc/self/gid_map", map, strlen(map)))
> +		return -1;
> +
> +	if (setgid(0))
> +		return -1;
> +
> +	if (setuid(0))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int prepare_unpriv_mountns(void)
> +{
> +	if (create_and_enter_userns())
> +		return -1;
> +
> +	if (unshare(CLONE_NEWNS))
> +		return -1;
> +
> +	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
> +		return -1;
> +
> +	if (unshare(CLONE_NEWIPC))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int wait_for_pid(pid_t pid)
> +{
> +	int status, ret;
> +
> +again:
> +	ret = waitpid(pid, &status, 0);
> +	if (ret == -1) {
> +		if (errno == EINTR)
> +			goto again;
> +
> +		return -1;
> +	}
> +
> +	if (!WIFEXITED(status))
> +		return -1;
> +
> +	return WEXITSTATUS(status);
> +}
> +
> +int get_mq_queues_max(void)

can be made static

> +{
> +	int fd;
> +	char buf[16];
> +	int val = -1;
> +
> +	fd = open("/proc/sys/fs/mqueue/queues_max", O_RDONLY);
> +	if (fd >= 0) {
> +		if (read(fd, buf, sizeof(buf)) > 0)
> +			val = atoi(buf);
> +
> +		close(fd);
> +		return val;
> +	}
> +	return val;
> +}
> +
> +TEST(mqueue_sysctl)
> +{
> +	pid_t pid;
> +	int qmax1, qmax2;
> +
> +	chdir(getenv("HOME"));

Hm, don't do that. I would suggest using a temporary directory. Sm like:

char template[] = P_tmpdir "/mqueue_sysctl_XXXXXX";

if (!mkdtemp(template))
	// handle error

int fd = openat(-1, template, O_CLOEXEC | O_DIRECTORY);

mkdirat(fd, "mqueue", ...);

and then at exit:

unlinkat(fd, "mqueue", AT_REMOVEDIR);
remove(template);

etc.

Christian

> +	/* read and stash the original sysctl value */
> +	qmax1 = get_mq_queues_max();
> +	ASSERT_GE(qmax1, 0);
> +
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		ASSERT_EQ(prepare_unpriv_mountns(), 0);
> +
> +		if (mkdir("./mqueue", 755) && errno != EEXIST)
> +			SKIP(return, "mkdir /dev/mqueue failed");
> +
> +		ASSERT_EQ(mount("none", "./mqueue", "mqueue", MS_NOATIME, NULL), 0);
> +
> +		/* modify the sysctl value in new ipc namesapce */
> +		ASSERT_EQ(write_file("/proc/sys/fs/mqueue/queues_max", "1", 1), 0);
> +
> +		ASSERT_GE(mq_open("/new_ns1",  O_RDWR | O_CREAT, 0644, NULL), 0);
> +
> +		/* mq_open() should fail as exceeding of queues_max */
> +		ASSERT_EQ(mq_open("/new_ns2",  O_RDWR | O_CREAT, 0644, NULL), -1);
> +
> +		ASSERT_EQ(mq_unlink("/new_ns1"), 0);
> +		ASSERT_EQ(umount("./mqueue"), 0);
> +
> +		exit(0);
> +	}
> +
> +	ASSERT_EQ(wait_for_pid(pid), 0);
> +
> +	qmax2 = get_mq_queues_max();
> +	ASSERT_EQ(qmax1, qmax2);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.15.2
> 
