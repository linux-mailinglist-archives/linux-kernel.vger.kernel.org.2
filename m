Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0D343224
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 12:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCULna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhCULnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 07:43:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2522C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 04:43:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so16693666ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TDSs0Wdws3Dw1QRt+KH/0C9LcbA2OE9+PNRlmoNP6DY=;
        b=a/UFs9KHU/efP1ZlxzYbmsMsY7371zSPuE7qMbp2ceV0HCtNvLuM02SijCoBveSEAu
         vdmghvfm20Tj6C6PIxD/QJ/xNzrKrGCYENqtrhoCacfy4sdQakDp4PyCGY/Yl8Oa6zQD
         JLIclKW7d8twLZYoATSXf5zpU4SiQ7Tw3f7UP/S5yN39R/5VzbHU7q1r1DvOimhq2DSF
         izCF1zmmLMhMrrIno4UyBMm9aGVQL6YpOoMQUkIrq5YdRcU+20MHGmeQivPqKz2ITsr4
         IG4MZeyfdrpEAYRR6m3DJ25Q//+q+s06VaFL7GaeYHzuhk5Xn6xsUKdFr2G9QkVKD+9Q
         7s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=TDSs0Wdws3Dw1QRt+KH/0C9LcbA2OE9+PNRlmoNP6DY=;
        b=jQE5XC8sZjFrXt3Yq71adyVebkQUyd7JKJIwOOKGCg4Fm1dp+z35dQRPajse2wyEXk
         XC+ABFJbCQfq/v95uSTWr5mM9jLQ0rF0hc2TVi065izyzHi1H/Vzy2uJbtj58jjk1+d4
         gD3zQaTOyIpUJ73WCj1gXiSuizv3DCpY2PCsjTxrom+pq2YPC/sIz2QHKeFc7TlXbv5P
         a7lQuZ1N7PtP+abfFcoz8xUlp2xCGBxYIzVyf5IFRiCBFNJ3mVh/SAvUAsGTggLwOWmO
         qmKEQ6M0vJJbZxIU6vZbYIrZBbsiuK8OCeVEqEbiOoeCX6nERugA30qQquArX3DLjbYN
         +BOQ==
X-Gm-Message-State: AOAM530fGdj/cnHgYdoEXZ4i2EpDYsWVVupvEQw2HM5VgBVHjq9sq5OW
        NJNXiaxAd8LIxpE4SaHKF80=
X-Google-Smtp-Source: ABdhPJxseaSemOOH8IkeaYt2ggXpGzgZFPn0Idm52oxXl7qPr93mnhtxcNnKieSPAw6vTlLRNBd06Q==
X-Received: by 2002:a17:906:2692:: with SMTP id t18mr13913791ejc.16.1616326998408;
        Sun, 21 Mar 2021 04:43:18 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id jv19sm6930576ejc.74.2021.03.21.04.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 04:43:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Mar 2021 12:43:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ updates & fixes
Message-ID: <20210321114315.GA290313@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-03-21

   # HEAD: 81e2073c175b887398e5bca6c004efa89983f58d genirq: Disable interrupts for force threaded handlers

A change to robustify force-threaded IRQ handlers to always disable interrupts,
plus a DocBook fix.

[ Note: the force-threaded IRQ handler change has been accelerated 
  from the normal schedule of such a change to keep the bad 
  pattern/workaround of spin_lock_irqsave() in handlers or 
  IRQF_NOTHREAD as a kludge from spreading. ]

 Thanks,

	Ingo

------------------>
Andy Shevchenko (1):
      genirq/irq_sim: Fix typos in kernel doc (fnode -> fwnode)

Thomas Gleixner (1):
      genirq: Disable interrupts for force threaded handlers


 kernel/irq/irq_sim.c | 4 ++--
 kernel/irq/manage.c  | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 48006608baf0..40880c350b95 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -159,7 +159,7 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
  * irq_domain_create_sim - Create a new interrupt simulator irq_domain and
  *                         allocate a range of dummy interrupts.
  *
- * @fnode:      struct fwnode_handle to be associated with this domain.
+ * @fwnode:     struct fwnode_handle to be associated with this domain.
  * @num_irqs:   Number of interrupts to allocate.
  *
  * On success: return a new irq_domain object.
@@ -228,7 +228,7 @@ static void devm_irq_domain_release_sim(struct device *dev, void *res)
  *                              a managed device.
  *
  * @dev:        Device to initialize the simulator object for.
- * @fnode:      struct fwnode_handle to be associated with this domain.
+ * @fwnode:     struct fwnode_handle to be associated with this domain.
  * @num_irqs:   Number of interrupts to allocate
  *
  * On success: return a new irq_domain object.
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dec3f73e8db9..21ea370fccda 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1142,11 +1142,15 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 	irqreturn_t ret;
 
 	local_bh_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 	local_bh_enable();
 	return ret;
 }
