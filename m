Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B703E950A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhHKPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhHKPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:51:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5EFC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:50:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w14so4111802pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDZhi9XpYgHTgorc2OqZWb4+Dn8Pza3yr4fx29G3AVQ=;
        b=AEhoJhKmbeC5GgV/97p6O3udQIf4Q0+7UWbeiwxH/z2QhJS1n08h/2R9xiJSMIntYa
         jUcaTPjZmw81jxg1qJ0Dn7ZH9KlZ/iBUA6paPTTGu8hsRLbZOG37ihXMKMgx+qLtOHmV
         zsf7LflKfdG+d9qhGCuI39zJuskFnQWfkFH9nF57XJrWiqF2AWqsbRWa8lhveq5MIR0g
         huktQryGoKV94jJRKZyWLzD2/EpCHN0HEIz3iMfs1SzMy6rS9HMoQ4MASWAqyDYP0XGD
         q05OGGsTZfA7O3Ye8sKwVzTZ9mpH6lsNI6+0+BJZcTXGeTwG/bzwwxQaIN1OcY2N/u1w
         12QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDZhi9XpYgHTgorc2OqZWb4+Dn8Pza3yr4fx29G3AVQ=;
        b=TaDq3LO6pCqs7DtBWWSOu9h6HbNZ6P8JPoOCKhDKoXt9v/i6N/U8q1WrIOX/DM2w3y
         sXp+uqPAAzUFi6OaDIhglEG0eJjtTihBG3RZRljsOGnwIXAL2yV5Uqx13PzCDM96bNsG
         +hHJOz99JfjobjjxpvPiQZv3unpWD6BsBX5zcRgC0L7kRE9SL2FnX+Nn59dn2zBhj45P
         ycV6VM3Rzla80w/tTnTmlitnfaEz70/xqH6aXpLJpesjrHVN6Wu8imiqY3a/11fML+Ds
         jJHWzwKPUZCV6sMfOhdGJwZjcwEEm2If9DmiQqgX1kp0oZQ66bAjw/IFta0Tne+rckui
         M7hw==
X-Gm-Message-State: AOAM533fah07J27E1UiBIsIRinooQHLCCJfHAtdwmWVpEQmkmuwvciVi
        AMQfpFyCAj+CZOhT9Al90vs=
X-Google-Smtp-Source: ABdhPJx/bKBPLeqiUivcetWojcjlMjWbbWVWvVHI1P/0NrskerG0pKvcLv5q0OqS39aXMykT5VZj0A==
X-Received: by 2002:a63:4005:: with SMTP id n5mr230189pga.140.1628697041515;
        Wed, 11 Aug 2021 08:50:41 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a2sm17301269pgb.19.2021.08.11.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:50:40 -0700 (PDT)
Date:   Wed, 11 Aug 2021 08:51:32 -0700
From:   CGEL <cgel.zte@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     keescook@chromium.org, ktkhai@virtuozzo.com,
        jamorris@linux.microsoft.com, varad.gautam@suse.com,
        legion@kernel.org, dbueso@suse.de, linux-kernel@vger.kernel.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] ipc: add set_ownership() and permissions() callbacks for
 posix mqueue sysctl
Message-ID: <20210811155132.GA13845@www>
References: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
 <20210729145348.hvvhu6lmlcn5js4y@wittgenstein>
 <20210803103150.GA607784@www>
 <20210803140133.vksebmgqhlbqipla@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803140133.vksebmgqhlbqipla@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:01:33PM +0200, Christian Brauner wrote:
> - Create a new mount and ipc namespace and mount mqueue in there.
>   Read and remember the /proc/sys/fs/mqueue/queues_max value.
> - Now create a new user + mount namespace pair in a child process.
> - Mount mqueue filesystem in there.
> - Set /proc/sys/fs/mqueue/queues_max to 1.
> - Call mq_open with O_CREAT in the child process the first time and
>   expect success keeping the fd open.
> - Call mq_open with O_CREAT in the child process a second time and
>   expect failure because of:
> 
> 	if (ipc_ns->mq_queues_count >= ipc_ns->mq_queues_max &&
> 	    !capable(CAP_SYS_RESOURCE)) {
> 		error = -ENOSPC;
> 		goto out_unlock;
> 	}
> 	ipc_ns->mq_queues_count++;
> 	spin_unlock(&mq_lock);
> 
> - Reap the child in the parent expecting success.
> - Verify that the /proc/sys/fs/mqueue/queues_max value in the parent is
>   identical to the value you read before creating the child.

Hi, Christian                                                                                                                                                                                                             
Thanks for your patient explanation of the kselftest code.                                                   
Please give comments on this test code. 

int get_mq_queues_max(void)
{
	int fd;
	char buf[16];
	int val = -1;

	fd = open("/proc/sys/fs/mqueue/queues_max", O_RDONLY);
	if (fd >= 0) {
		if (read(fd, buf, sizeof(buf)) > 0)
			val = atoi(buf);

		close(fd);
		return val;
	}
	return val;
}

TEST(mqueue_sysctl)
{
	pid_t pid;
	int qmax1, qmax2;
	
	/*
	> - Create a new mount and ipc namespace and mount mqueue in there.
	This test code is intended to run as non-root user,
	so unshare(CLONE_NEWNS) is not allowed, so i skip this step.
	 */

	chdir(getenv("HOME"));
	/* read and stash the original sysctl value */
	qmax1 = get_mq_queues_max();
	ASSERT_GE(qmax1, 0);

	pid = fork();
	ASSERT_GE(pid, 0);

	if (pid == 0) {
		ASSERT_EQ(prepare_unpriv_mountns(), 0);
	
	/*
	A new mqueue filesystem instance will be mounted by kernel internally 
	when a ipc namespace created. I don't quite get the point here why we should 
	mount mqueue manually?
	 */
		if (mkdir("./mqueue", 755) && errno != EEXIST)
			SKIP(return, "mkdir /dev/mqueue failed");

		ASSERT_EQ(mount("none", "./mqueue", "mqueue", MS_NOATIME, NULL), 0);

		/* modify the sysctl value in new ipc namesapce */
		ASSERT_EQ(write_file("/proc/sys/fs/mqueue/queues_max", "1", 1), 0);

		ASSERT_GE(mq_open("/new_ns1",  O_RDWR | O_CREAT, 0644, NULL), 0);

		/* mq_open() should fail as exceeding of queues_max */
		ASSERT_EQ(mq_open("/new_ns2",  O_RDWR | O_CREAT, 0644, NULL), -1);

		ASSERT_EQ(mq_unlink("/new_ns1"), 0);
		ASSERT_EQ(umount("./mqueue"), 0);

		exit(0);
	}

	ASSERT_EQ(wait_for_pid(pid), 0);

	qmax2 = get_mq_queues_max();
	ASSERT_EQ(qmax1, qmax2);
}

TEST_HARNESS_MAIN

for this test code ,i add a new file mq_sysctl_test.c, a makefile and a config file 
with content
CONFIG_USER_NS=y
CONFIG_POSIX_MQUEUE_SYSCTL=y

but i am not sure which directory to place thess files,
for the original tools/testing/selftests/mqueue/
i think this directory don't need a config file, but for this test code,
this config file is needed,
do you have any suggestion on which directory this test code should place?


