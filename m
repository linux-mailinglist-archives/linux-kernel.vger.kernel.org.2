Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9332593F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhBYWHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:07:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBYWHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:07:06 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614290784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y1kOxZAz1PS35rSHX1Q1Ehy2Rvgctil+MlY8VvUpVeM=;
        b=bqphPTJ9Qo1TuGLHrUjO6wVHCBNeSADaPV0XwqTE0Bpab+6ikJi7H4vu4atASKb6IH3Qw1
        opUOyrZLWDCrk5wexObxu0agdUNkZ0/0wa/UGytDwneezeO6dVSiD25bE5Y7KtDUxTW8qQ
        S4C9fBAX+mqy+1kifk9Ayc7eWMfuOTmcz/AnROBaLFpDgfVd17tHR9gkGVJJW1orOI3fq4
        U1EY2Q1x165411WMmukJXegwyAb1nSg8TU5+v0ybpPkriAJH2IG1+kZEzlMpmCa4kV/t26
        H5xt62luD8p0t77Zqc05I+AKPCMnKCzHOyLFHdj+A/Jx6rn5ESxRi1CUUE2nnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614290784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y1kOxZAz1PS35rSHX1Q1Ehy2Rvgctil+MlY8VvUpVeM=;
        b=PCci/Pr0JkVNcGiz0S5XvXVc3KWN8mW8tJ2wd55lhAvIGql3p7Ek93TByeCcpMB3zO1eEO
        tMScaHc5VP7yBiAQ==
To:     Paul Mackerras <paulus@samba.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] powerpc: low_i2c: change @lock to raw_spinlock_t
Date:   Thu, 25 Feb 2021 23:06:23 +0100
Message-Id: <20210225220623.30543-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c transfers are occurring with local interrupts disabled:

smp_core99_give_timebase()
  local_irq_save();
  smp_core99_cypress_tb_freeze()
    pmac_i2c_xfer()
      kw_i2c_xfer()
        spin_lock_irqsave(&host->lock, flags)

This is a problem because with PREEMPT_RT a spinlock_t can sleep,
causing the system to hang. Convert the spinlock_t to the
non-sleeping raw_spinlock_t.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index f77a59b5c2e1..ba89c95ef290 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -116,7 +116,7 @@ struct pmac_i2c_host_kw
 	int			polled;
 	int			result;
 	struct completion	complete;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct timer_list	timeout_timer;
 };
 
@@ -346,14 +346,14 @@ static irqreturn_t kw_i2c_irq(int irq, void *dev_id)
 	struct pmac_i2c_host_kw *host = dev_id;
 	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	raw_spin_lock_irqsave(&host->lock, flags);
 	del_timer(&host->timeout_timer);
 	kw_i2c_handle_interrupt(host, kw_read_reg(reg_isr));
 	if (host->state != state_idle) {
 		host->timeout_timer.expires = jiffies + KW_POLL_TIMEOUT;
 		add_timer(&host->timeout_timer);
 	}
-	spin_unlock_irqrestore(&host->lock, flags);
+	raw_spin_unlock_irqrestore(&host->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -362,7 +362,7 @@ static void kw_i2c_timeout(struct timer_list *t)
 	struct pmac_i2c_host_kw *host = from_timer(host, t, timeout_timer);
 	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	raw_spin_lock_irqsave(&host->lock, flags);
 
 	/*
 	 * If the timer is pending, that means we raced with the
@@ -377,7 +377,7 @@ static void kw_i2c_timeout(struct timer_list *t)
 		add_timer(&host->timeout_timer);
 	}
  skip:
-	spin_unlock_irqrestore(&host->lock, flags);
+	raw_spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static int kw_i2c_open(struct pmac_i2c_bus *bus)
@@ -470,9 +470,9 @@ static int kw_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
 			unsigned long flags;
 
 			u8 isr = kw_i2c_wait_interrupt(host);
-			spin_lock_irqsave(&host->lock, flags);
+			raw_spin_lock_irqsave(&host->lock, flags);
 			kw_i2c_handle_interrupt(host, isr);
-			spin_unlock_irqrestore(&host->lock, flags);
+			raw_spin_unlock_irqrestore(&host->lock, flags);
 		}
 	}
 
@@ -508,7 +508,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	}
 	mutex_init(&host->mutex);
 	init_completion(&host->complete);
-	spin_lock_init(&host->lock);
+	raw_spin_lock_init(&host->lock);
 	timer_setup(&host->timeout_timer, kw_i2c_timeout, 0);
 
 	psteps = of_get_property(np, "AAPL,address-step", NULL);
-- 
2.20.1

