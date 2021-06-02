Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0F399222
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhFBSFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhFBSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:05:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB53C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 11:03:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 76so3237313qkn.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANAeE0VrfGPo3nZoQc7JNldEPh+NOYQtryVGV16Nb/M=;
        b=Hn4oSGrcAoVc5WZUoD1f57fz1Rxk4gIUN9BNSzzTxf3ThAA8tJ1CDIGQ0YCW4JFom1
         +u27UgUv13u5ZTABJcXzjBs4NMsGM6j1uIFwsdLdHJRzkFWCrmPHcT0Wkyak25UBHLWv
         p12mHy8p0qgZY4lfDlQ76V53adijiiJ9EWC1FlO1GSNsis8qvuTSq19T1P48+anpmjVI
         2/UXyQFqNHv467RFR5l2k69AQUkljVOa1hknhvGgGX1L66NU9zBHDrVi4dpNMayF4IUP
         8gLdIKfFTACVfCtpx0GPMBWrqco1TLD86PDM+QJNesR40EDvtRIeT0IpmbszrHVdc5cD
         SfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANAeE0VrfGPo3nZoQc7JNldEPh+NOYQtryVGV16Nb/M=;
        b=dO4u66T8+ghyWefZHakiwpKu5h3NCpYu9YztGGDh1mSrzrYtPAihY7refFhTIyaosH
         CVLK56/ZS3wFd5WYheSmGx1hNgmbBA1aAfeIMtByIGXtmE5u/ep8FUx2wvWC560WYVRd
         /E1Cw60qNTQ71jTIzRMNC0ArBZijxKcRjI+hLbRSiH7Vacz1s1xdw2dwwkLGP586IQoc
         Vg/4M4ORpU5IIVECEpOFZOjiZDsNNqGFcRihfPvelW6xfjMzm5zTUq4tF8mStMyRHpma
         I3tv3YArrMTkZltRJAa2ZNriMBOVNWyAoiu6lIdKSZ+6dzg9ysW9IpoCrvOnQbaO8gSj
         ud4w==
X-Gm-Message-State: AOAM533fFGDkK08mtvnuAcf/gKiasN3nJod/Aac8Nl+kCQPS9Wspv8Xz
        KLSD4bJ3JjLtu6rnIrhWlixFA7iPf4M=
X-Google-Smtp-Source: ABdhPJwlkeWPOYX2y5/WvipYuRcwWejxc8AKFHmGt5uBx0KtgffYsUGpDrDlcMWetL7yUqrbIBWYpQ==
X-Received: by 2002:a05:620a:1230:: with SMTP id v16mr28999544qkj.14.1622657022784;
        Wed, 02 Jun 2021 11:03:42 -0700 (PDT)
Received: from tannerlove.nyc.corp.google.com ([2620:0:1003:1000:56ea:5ee7:bba5:d755])
        by smtp.gmail.com with ESMTPSA id f130sm316511qke.37.2021.06.02.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:03:42 -0700 (PDT)
From:   Tanner Love <tannerlove.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Romain Perier <romain.perier@gmail.com>,
        Tanner Love <tannerlove@google.com>
Subject: [PATCH] genirq: change force_irqthreads from bool test to static key
Date:   Wed,  2 Jun 2021 14:03:38 -0400
Message-Id: <20210602180338.3324213-1-tannerlove.kernel@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tanner Love <tannerlove@google.com>

With CONFIG_IRQ_FORCED_THREADING=y, testing the bool force_irqthreads
could incur a cache line miss in invoke_softirq().

Replace the test with a static key to avoid the potential cache miss.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Tanner Love <tannerlove@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/ide/ide-iops.c    | 7 +++----
 include/linux/interrupt.h | 4 +++-
 kernel/irq/manage.c       | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index f2be127ee96e..f86cdb8451e6 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -109,7 +109,6 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad,
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	unsigned long flags;
-	bool irqs_threaded = force_irqthreads;
 	int i;
 	u8 stat;
 
@@ -117,7 +116,7 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad,
 	stat = tp_ops->read_status(hwif);
 
 	if (stat & ATA_BUSY) {
-		if (!irqs_threaded) {
+		if (!force_irqthreads) {
 			local_save_flags(flags);
 			local_irq_enable_in_hardirq();
 		}
@@ -133,13 +132,13 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad,
 				if ((stat & ATA_BUSY) == 0)
 					break;
 
-				if (!irqs_threaded)
+				if (!force_irqthreads)
 					local_irq_restore(flags);
 				*rstat = stat;
 				return -EBUSY;
 			}
 		}
-		if (!irqs_threaded)
+		if (!force_irqthreads)
 			local_irq_restore(flags);
 	}
 	/*
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850a6dc7..9e676c351f23 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -13,6 +13,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
+#include <linux/jump_label.h>
 
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -504,7 +505,8 @@ extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 # ifdef CONFIG_PREEMPT_RT
 #  define force_irqthreads	(true)
 # else
-extern bool force_irqthreads;
+DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
+#  define force_irqthreads	(static_branch_unlikely(&force_irqthreads_key))
 # endif
 #else
 #define force_irqthreads	(0)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c14356543d9..395945e54929 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -25,12 +25,12 @@
 #include "internals.h"
 
 #if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
-__read_mostly bool force_irqthreads;
-EXPORT_SYMBOL_GPL(force_irqthreads);
+DEFINE_STATIC_KEY_FALSE(force_irqthreads_key);
+EXPORT_SYMBOL_GPL(force_irqthreads_key);
 
 static int __init setup_forced_irqthreads(char *arg)
 {
-	force_irqthreads = true;
+	static_branch_enable(&force_irqthreads_key);
 	return 0;
 }
 early_param("threadirqs", setup_forced_irqthreads);
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

