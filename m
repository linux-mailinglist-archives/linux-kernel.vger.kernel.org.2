Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5583E8D97
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhHKJzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhHKJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:55:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC7C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:55:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l11so1957471plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6aFhk4VBnUxKiSh74rnzFjdVbL5hkkNG4lbiv/FS9vM=;
        b=AGng1O4ZhfGEnjC8W+4ppY/OxIGNbvgU15/3i3WmBMANPppI8GDm88ddHuZYTyjtvS
         aWVanaly4xWg5lt+hfr8j7RZiVBrCfoXoipokFiWrvXmeWn+sTmkvBkPUoZTrkF2pjTO
         lttalCC+ZBJMgXccPEHdIuF4wzUZ2PdKexFveDXJyhKlo9ZLbgxynvJ0TRBBQuoCZ8YF
         Wd2F9zI7sccT0sjXsxB1dddlRnBdHGx6/1DAZbLd0R5srAGm+seyzmojK4luCDOjRM6Z
         KDAgJbwtNIjJRXWIpyFvRA0afRnMmcnOPpjwA7iqoS0FPG2GjEHpDeLDROWQPigVs4L/
         4S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6aFhk4VBnUxKiSh74rnzFjdVbL5hkkNG4lbiv/FS9vM=;
        b=dFsroAcDMdOBkbzJvfSTs9cV7BItUb+bJ2vecs0fkZo+na/psWE3Pf3D4E70AnfcrU
         SCKs/ctsbrmRd++STDY9VIGH50OXKmTL/cQf2ELldxQxu8fKBGfd71e4BQS2LtWzmoIy
         kMKpL12D7gxc2lUAS+VT8UkH+JoQkN6deCLWr70MhljxhyVcf7/eyEp5yVAHj+GyEQTF
         c7SYiza8UTBiWVxuJFKMNSzTCRj7EFkMGzepMA7KgB+oJypBkZr6536VZkyoHaxyzXxd
         a3NelHZzs4BbS4GmmWm/GHQ+tzCQNKJEZI1iIBii2JER204lgMHX+78zY9cEazmgQ2JR
         Lx1g==
X-Gm-Message-State: AOAM532HEYRIpx0kqffQHnSUjpbaMGkVkeo8KYZOaL7DDVuJxRP8DVgd
        EoHH9fWdzluwXqmWQ5HVjEM=
X-Google-Smtp-Source: ABdhPJws4X0JiI5n+Tjcm80+ocpJa6q6B1UpyZp8Mc+koMlKZ9gAdDBaDTTVqNnl5JTWoJaX8ARsYQ==
X-Received: by 2002:a17:90b:18f:: with SMTP id t15mr9531896pjs.168.1628675707595;
        Wed, 11 Aug 2021 02:55:07 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id z20sm6076767pfr.121.2021.08.11.02.55.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:55:07 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH] clocksource: skip check while watchdog hung up or unstable
Date:   Wed, 11 Aug 2021 17:55:04 +0800
Message-Id: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

After patch 1f45f1f3 (clocksource: Make clocksource validation work
for all clocksources), md_nsec may be 0 in some scenarios, such as
the watchdog is delayed for a long time or the watchdog has a
time-warp.

We found a problem when testing nvme disks with fio, when multiple
queue interrupts of a disk were mapped to a single CPU. IO interrupt
processing will cause the watchdog to be delayed for a long time
(155 seconds), the system reports TSC unstable and switches the clock
to hpet. It seems that this scenario cannot be handled by optimizing
softirq. Therefore, when md_nsec returns 0, the machine or watchdog
should be in unstable state，the verification result not unreliable.
Is it possible for us to skip the current check at this time?
1. If the watchdog is delayed because the system is busy, and the
   clocksource is switched to hpet due to a wrong judgment, the
   performance degradation may directly cause the machine to be
   unavailable and cause more problems.
2. If watchdog has time-warp, we should not rely on hpet to directly
   mark TSC as unstable.

Later we register watchdog to other CPU, if other CPU is not busy, we
can also check the stability of TSC.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 kernel/time/clocksource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b89c76e1c02c..9b9014d67f1d 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -399,6 +399,13 @@ static void clocksource_watchdog(struct timer_list *unused)
 		cs->cs_last = csnow;
 		cs->wd_last = wdnow;
 
+		if (!wd_nsec) {
+			pr_warn("timekeeping watchdog on CPU%d seems hung up or unstable:");
+			pr_warn("'%s' wd_now: %llx wd_last: %llx mask: %llx\n",
+				watchdog->name, wdnow, wdlast, watchdog->mask);
+			continue;
+		}
+
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
-- 
2.30.0

