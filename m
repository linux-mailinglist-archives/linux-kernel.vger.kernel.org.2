Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237193FD3D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbhIAGcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhIAGcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:32:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C5C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:31:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3847452pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5h8JhN06hXlaVyx3hFBU5a8G4De/w/8E/ESpLy4LETE=;
        b=os9r9XJ9NPyAXT8I690FE9+Yf3VYe2DJRZzGDYok70TMbOVB9C9CEe1FnpuUlfkEXx
         XSOx+A2Vep9NlGV3BblMRswDRuzLEl51gny/mOyQOxvV0b6zZyHqyc6pkjJf9V8hz1fu
         Xz+sy+/K+gueFYoyqz7l4vZFSbP2enAOjH6Xsg+OE1B7uiHn8LKvwqlVdMKCVIan/fag
         aGQnbLk1A06gf18MhrLxw8EOxRnl8YU3KvxEQxZeXuA7fQCcMzIESC2k7nX2Bp6JNABr
         GPvb39XCRzhxiqrYN6Cdle/tlMvF38gxjzKiq93zZh/N15nf55E7KVATbelktJr6oSRZ
         f5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5h8JhN06hXlaVyx3hFBU5a8G4De/w/8E/ESpLy4LETE=;
        b=kS2LCNwNNxFJ7nn6S/sxE0LMgo8wR+h/hqefZEl9uS0xRY5Wm42t2KyBu2a0J5fTCP
         slP7JbU4vE7PxOcttJDEhb5X1fGfrXbR1MhvJedki1TaqE+b+pIDilIkvSkXx9riEwp4
         fRebIa4PaxtDuBKv1tM/h+8vfRjNwkpB4IonsLbSnqDInzioJzFC6hRcVi8nkaWwe6sO
         mxu5lFhx9fzRBcZOO0hPLV6A5Wd7CL4L9Dqq5AXUCRkqgZPzrHdk3sM77o71ZtOuO6bE
         Xw7/XZGQmEAyQbXUh/zAxDm69gVeo9AEdwGBujwLDZISUgZ38mgJ51EdUEweWjtDMx9G
         JFjA==
X-Gm-Message-State: AOAM5322pY2qVcK/TNiLaRLCM2qGn3dD+9RMJnUULj/rIHQRizauhmIH
        N/HgYF71ZqfK8Jr6JLN2pIl9Fw==
X-Google-Smtp-Source: ABdhPJwrOcm3m7oTaht+lo0H6c2jUdqX+mzC+kgi7smgR+R3EyVQOdAAX03Q+TOoFO95KVkk0xxR+g==
X-Received: by 2002:a17:90b:f97:: with SMTP id ft23mr9846098pjb.135.1630477904843;
        Tue, 31 Aug 2021 23:31:44 -0700 (PDT)
Received: from localhost ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id x22sm7631298pfm.102.2021.08.31.23.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 23:31:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Orito Takao <orito.takao@socionext.com>
Subject: [RFC PATCH] irqchip/gic, gic-v3: Ensure data visibility in peripheral
Date:   Wed,  1 Sep 2021 14:31:15 +0800
Message-Id: <20210901063115.383026-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an interrupt line is assered, GIC handles interrupt with the flow
(with EOImode == 1):

  gic_handle_irq()
   `> do_read_iar()                          => Change int state to active
   `> gic_write_eoir()                       => Drop int priority
   `> handle_domain_irq()
       `> generic_handle_irq_desc()
       `> handle_fasteoi_irq()
           `> handle_irq_event()             => Peripheral handler and
	                                        de-assert int line
           `> cond_unmask_eoi_irq()
	       `> chip->irq_eoi()
	           `> gic_eoimode1_eoi_irq() => Change int state to inactive

In this flow, it has no explicit memory barrier between the functions
handle_irq_event() and chip->irq_eoi(), it's possible that the
outstanding data has not reached device in handle_irq_event() but the
callback chip->irq_eoi() is invoked, this can lead to state transition
for level triggered interrupt:

  Flow                             |  Interrupt state in GIC
  ---------------------------------+-------------------------------------
  Interrupt line is asserted       |  'inactive' -> 'pending'
  do_read_iar()                    |  'pending'  -> 'pending & active'
  handle_irq_event()               |  Write peripheral register but it's
                                   |    not visible for device, so the
				   |    interrupt line is still asserted
  chip->irq_eoi()                  |  'pending & active' -> 'pending'
                                  ...
  Produce spurious interrupt       |
      with interrupt ID: 1024      |
                                   |  Finally the peripheral reigster is
				   |  updated and the interrupt line is
				   |  deasserted: 'pending' -> 'inactive'

To avoid this potential issue, this patch adds wmb() barrier prior to
invoke EOI operation, this can make sure the interrupt line is
de-asserted in peripheral before deactivating interrupt in GIC.  At the
end, this can avoid spurious interrupt.

Reported-by: Orito Takao <orito.takao@socionext.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++++
 drivers/irqchip/irq-gic.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4debe64e1..fcd1477e2274 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -530,6 +530,8 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
+	/* Ensure the data is written to peripheral */
+	wmb();
 	gic_write_eoir(gic_irq(d));
 }
 
@@ -541,6 +543,8 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	 */
 	if (gic_irq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
 		return;
+	/* Ensure the data is written to peripheral */
+	wmb();
 	gic_write_dir(gic_irq(d));
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d329ec3d64d8..3e9d4b6dc31b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -222,6 +222,8 @@ static void gic_eoi_irq(struct irq_data *d)
 	if (hwirq < 16)
 		hwirq = this_cpu_read(sgi_intid);
 
+	/* Ensure the data is written to peripheral */
+	wmb();
 	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
@@ -236,6 +238,8 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	if (hwirq < 16)
 		hwirq = this_cpu_read(sgi_intid);
 
+	/* Ensure the data is written to peripheral */
+	wmb();
 	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_DEACTIVATE);
 }
 
-- 
2.25.1

