Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787D735E369
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346767AbhDMQEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:04:06 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43753 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbhDMQEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:04:01 -0400
Received: by mail-ed1-f42.google.com with SMTP id e7so19977221edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQXso/p7dQH9LxNX2FtlDtx7UZcy3CyevPkVQcW7NTY=;
        b=BCRSpiiRGXMfq3IM+ymGVZceX3iV7LKj1QO880OajNpEarYdi7UDRKRhkzpBmktmUY
         +rdSbi2FJ1GUxCxR2lfMFDNDTc3NqCgqovMfD8gP7TfWqc4rZYX+AD5sluVhFxWh2fy/
         x2jIzEdp1gLPwOlrSWi2WDVor3G6OMCnhsBow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQXso/p7dQH9LxNX2FtlDtx7UZcy3CyevPkVQcW7NTY=;
        b=F37rGF6Oy7gowNJBKE2T6LBj+L5Ja6U+FszkAsZ1oalrRx5WQgvhGceB/zKGrtiw+o
         yREhhEQaFk2RcISubGeBPyabzg1g5rT4WrDCiwW/eqipyuZzpjhLIWBOwpD1AWSKndhA
         NW1X+QHf9mRRPDatqbBR7GbKOKSPjBrYFYiw7BP0LDZypzXMojOefLezT1MZ6lXMkXt/
         spA1vvNw3xnMtfeezKwOoOmPOUmb8lF0aKEQVkwvNrfODaZ17IEYw+l+UtV7TQd4c4bq
         UichrhxMyFh+ENXNC9Qbrrh26ludGX+Me/56wUsd9ksrX56duwNuRQpsNXS/w3dcwBnK
         E1Aw==
X-Gm-Message-State: AOAM530RlqpeYBAK1PSuG7Zb5HzeWQZ4nyAolXDbXvdjDnhf1xcVej3r
        YgCCQuMq6B9z/ijh9Zp7OXyJHg==
X-Google-Smtp-Source: ABdhPJwRoGjbckoXCLP7mhFP1t9lFmFkJ/iC5xwcq9r/6hH3ykhAY6B76oQyIkxLwjJiBAG5cfRkNA==
X-Received: by 2002:a05:6402:1284:: with SMTP id w4mr35216250edv.181.1618329760637;
        Tue, 13 Apr 2021 09:02:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:9880:57f0:ba7c:cdd5:fff7:623c])
        by smtp.gmail.com with ESMTPSA id gb4sm8162852ejc.122.2021.04.13.09.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:02:40 -0700 (PDT)
From:   Rodrigo Campos <rodrigo@kinvolk.io>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
Subject: [PATCH 0/1] seccomp: Erroneous return on interrupted addfd ioctl()
Date:   Tue, 13 Apr 2021 18:01:50 +0200
Message-Id: <20210413160151.3301-1-rodrigo@kinvolk.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With Alban and Mauricio (on Cc), we are adding seccomp userspace notify support
to runc and found a kernel bug while testing it. The issue is the following: if
the addfd ioctl() in the seccomp agent is interrupted (like with SIGURG) then
the target process is erroneously and prematurely unblocked and a 0 is returned
to the target process.

This happens on all kernels that support addfd (>= v5.9). The problem is the
following, things should happen in this specific order to hit the bug.

The agent is written in go, so the runtime sends SIGURG quite often. If we are
interrupted when the addfd ioctl is in this wait[1]:
        ret = wait_for_completion_interruptible(&kaddfd.completion);

Then the "complete(&knotif->ready);" was just run. So, we proceed to take the
lock and delete the addfd element from the list[2]. The kaddfd.list is empty
now.

After that, the other side (the target process) will be woken up (because we
issued the "complete(&knotif->ready)") and take the lock, but the "if" to add
the fd will be false as the element is already deleted (the list is empty)[3].

Then, we don't execute the "goto wait" and we proceed to return to the other
side values set in n, that is 0 initialized. So, the other side sees 0 as a
response (error is 0 and val is 0).

The target process, then, sees a response even when we didn't answer the
notification, we just tried to add an fd.

I attach the strace output when hitting the bug. The target is issuing openat in
a loop, for "/dev/null-%d" with %d being the iteration we are at. The strace
shows that openat returned 0 for the iteration 27246.

The agent in go checks the notification is valid (SECCOMP_IOCTL_NOTIF_ID_VALID)
and then runs the addfd ioctl, that is interrupted by the go runtime. Then, it
is resumed and returns ENOENT. This makes sense, as the notification was already
responded (incorrectly) by the interrupted addfd ioctl, so when we run it again
now the notification doesn't exist.

There are two ways that come to mind to solve this problem. One is the patch in
the next email (tested, fixes the issue). The other one is the first patch in
the joint patchset that we sent with Sargun some days ago ("seccomp: Refactor
notification handler to prepare for new semantics")[4]. That patch alone also
fixes the issue.

Both patches are quite simple, although the one attached here doesn't change
semantics and the other ("seccomp: Refactor notification handler to prepare for
new semantics") does.

The patch that we apply should be cc stable too. This patch is based on
for-linus/seccomp, affect 5.9+ kernels and applies cleany to 5.10.y, 5.11.y and
current 5.12 (probably to others too, this part hasn't changed recently).

Rodrigo Campos (1):
  seccomp: Always "goto wait" if the list is empty

 kernel/seccomp.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)


[1]: https://github.com/torvalds/linux/blob/89698becf06d341a700913c3d89ce2a914af69a2/kernel/seccomp.c#L1615
[2]: https://github.com/torvalds/linux/blob/89698becf06d341a700913c3d89ce2a914af69a2/kernel/seccomp.c#L1628-L1639 
[3]: https://github.com/torvalds/linux/blob/89698becf06d341a700913c3d89ce2a914af69a2/kernel/seccomp.c#L1113 
[4]: https://lore.kernel.org/lkml/20210318051733.2544-2-sargun@sargun.me/ 

Strace on the target:
...
[pid  3211] openat(-1, "/dev/null-27246", O_RDONLY) = 0

Strace on the agent (golang):
...
[pid  3214] pread64(10, "/dev/null-27246\0001\371\1Ag\177\0\0\0\0\0\0\1\0\0\0"..., 4096, 140724461935344) = 4096
[pid  3214] close(10)                   = 0
[pid  3214] ioctl(4, SECCOMP_IOCTL_NOTIF_ID_VALID, 0x7f7a1a7fbdc8) = 0
[pid  3214] write(2, "\33[37mDEBU\33[0m[0091] doing replac"..., 66 <unfinished ...>
[pid  3141] <... nanosleep resumed>NULL) = 0
[pid  3214] <... write resumed>)        = 66
[pid  3141] getpid( <unfinished ...>
[pid  3214] write(1, "using notify_fd: 4, srcfd: 8\n", 29 <unfinished ...>
[pid  3141] <... getpid resumed>)       = 3140
[pid  3214] <... write resumed>)        = 29
[pid  3141] tgkill(3140, 3214, SIGURG <unfinished ...>
[pid  3214] ioctl(4, SECCOMP_IOCTL_NOTIF_ADDFD <unfinished ...>
[pid  3141] <... tgkill resumed>)       = 0
[pid  3214] <... ioctl resumed>, 0x7f7a1a7fbde0) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
[pid  3141] nanosleep({tv_sec=0, tv_nsec=20000},  <unfinished ...>
[pid  3214] --- SIGURG {si_signo=SIGURG, si_code=SI_TKILL, si_pid=3140, si_uid=0} ---
[pid  3214] rt_sigreturn({mask=[]})     = 16
[pid  3214] ioctl(4, SECCOMP_IOCTL_NOTIF_ADDFD, 0x7f7a1a7fbde0) = -1 ENOENT (No such file or directory)

-- 
2.30.2

