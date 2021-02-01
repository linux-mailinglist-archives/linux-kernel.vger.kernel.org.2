Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A1130AE5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBARsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232504AbhBARsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612201612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=90Pe1IFa7Uh5YWMi0j6zvJtWB8Z5Lfs1n6DGSvaHYaE=;
        b=XcBHTgHQY/sR9gBemTcTtE5qjwPmIY54ioWpIVV4v00oM+ExvKbcqwveZU09EWsb441Qzo
        d4EI8IGXagPkcd1ybU5pI64gS5Y7QXWjV4MFsPTzoZqxNIvUdV/WSYSBznkpaHgcs7gYXN
        jeFzgH24dewgIDR8v0dSAwwo96r13u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-WMATai73Mw-jCea5OzDWlg-1; Mon, 01 Feb 2021 12:46:50 -0500
X-MC-Unique: WMATai73Mw-jCea5OzDWlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E849C2A1;
        Mon,  1 Feb 2021 17:46:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 68BE51975E;
        Mon,  1 Feb 2021 17:46:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  1 Feb 2021 18:46:48 +0100 (CET)
Date:   Mon, 1 Feb 2021 18:46:41 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v4 1/4] introduce set_restart_fn() and arch_set_restart_data()
Message-ID: <20210201174641.GA17871@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201174555.GA17819@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparation. Add the new helper which sets restart_block->fn and calls
the dummy arch_set_restart_data() helper.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/select.c                    | 10 ++++------
 include/linux/thread_info.h    | 13 +++++++++++++
 kernel/futex.c                 |  3 +--
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/hrtimer.c          |  2 +-
 kernel/time/posix-cpu-timers.c |  2 +-
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 37aaa8317f3a..945896d0ac9e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1055,10 +1055,9 @@ static long do_restart_poll(struct restart_block *restart_block)
 
 	ret = do_sys_poll(ufds, nfds, to);
 
-	if (ret == -ERESTARTNOHAND) {
-		restart_block->fn = do_restart_poll;
-		ret = -ERESTART_RESTARTBLOCK;
-	}
+	if (ret == -ERESTARTNOHAND)
+		ret = set_restart_fn(restart_block, do_restart_poll);
+
 	return ret;
 }
 
@@ -1080,7 +1079,6 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		struct restart_block *restart_block;
 
 		restart_block = &current->restart_block;
-		restart_block->fn = do_restart_poll;
 		restart_block->poll.ufds = ufds;
 		restart_block->poll.nfds = nfds;
 
@@ -1091,7 +1089,7 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		} else
 			restart_block->poll.has_timeout = 0;
 
-		ret = -ERESTART_RESTARTBLOCK;
+		ret = set_restart_fn(restart_block, do_restart_poll);
 	}
 	return ret;
 }
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index c8a974cead73..495fb6a94e58 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/restart_block.h>
+#include <linux/errno.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 /*
@@ -57,6 +58,18 @@ enum syscall_work_bit {
 
 #ifdef __KERNEL__
 
+#ifndef arch_set_restart_data
+#define arch_set_restart_data(restart) do { } while (0)
+#endif
+
+static inline long set_restart_fn(struct restart_block *restart,
+					long (*fn)(struct restart_block *))
+{
+	restart->fn = fn;
+	arch_set_restart_data(restart);
+	return -ERESTART_RESTARTBLOCK;
+}
+
 #ifndef THREAD_ALIGN
 #define THREAD_ALIGN	THREAD_SIZE
 #endif
diff --git a/kernel/futex.c b/kernel/futex.c
index c47d1015d759..1ec50f9681a6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2724,14 +2724,13 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		goto out;
 
 	restart = &current->restart_block;
-	restart->fn = futex_wait_restart;
 	restart->futex.uaddr = uaddr;
 	restart->futex.val = val;
 	restart->futex.time = *abs_time;
 	restart->futex.bitset = bitset;
 	restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
 
-	ret = -ERESTART_RESTARTBLOCK;
+	ret = set_restart_fn(restart, futex_wait_restart);
 
 out:
 	if (to) {
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f4ace1bf8382..daeaa7140d0a 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -848,9 +848,9 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	if (flags == TIMER_ABSTIME)
 		return -ERESTARTNOHAND;
 
-	restart->fn = alarm_timer_nsleep_restart;
 	restart->nanosleep.clockid = type;
 	restart->nanosleep.expires = exp;
+	set_restart_fn(restart, alarm_timer_nsleep_restart);
 	return ret;
 }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 743c852e10f2..30f936431c56 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1939,9 +1939,9 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	}
 
 	restart = &current->restart_block;
-	restart->fn = hrtimer_nanosleep_restart;
 	restart->nanosleep.clockid = t.timer.base->clockid;
 	restart->nanosleep.expires = hrtimer_get_expires_tv64(&t.timer);
+	set_restart_fn(restart, hrtimer_nanosleep_restart);
 out:
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a71758e34e45..9abe15255bc4 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1480,8 +1480,8 @@ static int posix_cpu_nsleep(const clockid_t which_clock, int flags,
 		if (flags & TIMER_ABSTIME)
 			return -ERESTARTNOHAND;
 
-		restart_block->fn = posix_cpu_nsleep_restart;
 		restart_block->nanosleep.clockid = which_clock;
+		set_restart_fn(restart_block, posix_cpu_nsleep_restart);
 	}
 	return error;
 }
-- 
2.25.1.362.g51ebf55

