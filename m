Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E73280CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhCAO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhCAO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:27:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC32C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:27:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w7so13693145wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsK7wcStp/rgDy1K2qABtEboVh5EJgzeHxaVpOps17w=;
        b=rGTo3G9TbieyBQcSH43lIyspwDglhsPVwIG5q8gXseogS0Im62QRNea9n+0mAknFcI
         O65O4fwplqUufUEOjXVP/L2ZvjbPkoWaOduvQdbGv0Oqthjjj1GVG0/nqbF85u9SfEWg
         /hLHbinSPC+gDYecc7yV5o03QNdfB7i/nSIe/DoZKhkQkOQTeyFwoQ25pF53w9EY8Izk
         lgN8qR17Ao4BFNzmm9HtdW3sQOpmVcth7+EbUHYSncf0L19jG11RH2rx9XVaBk8XFdYG
         BgmHmXERTibLNWBfZtIQeQyLnYo9sekbo62WIyEReZ9y2tXt3CwVwyreVLjt007fIIC9
         sW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsK7wcStp/rgDy1K2qABtEboVh5EJgzeHxaVpOps17w=;
        b=q6wam+SKHWkM92wRN+iB2SIZ7WJ/3LzQKsxmCX1CeQyziY8CYqgjAE3vcQfoo0pFs+
         xR0ypj/Et1BgfFBmX5I/0TQQn26YfuMPVUOr6BDhL1eLnTEaVJ/iiYXYhNzMacvTKpRU
         cVzunPacAzZRgP3v5XNmSeNTWcil9sGbH+BUWItK0wApJJtgKadlbjRAsBHr8E+SxmNO
         pJayQhGOQnd1KmAhFXy0xoypCMykF9sdFK67G+iy+6hx1by2s+blloKdrDUn9R44s6tn
         VH5mMlmfkIlR+of7MNe1CKxEbnE170geJvygrzKvcE9Bg67tc5rLj1KJO2W665xauxng
         UguQ==
X-Gm-Message-State: AOAM531DF5Ld5rorFLI8+bBzRaN3d2EWhqtbmrrMVVhHyUJZ2stJjigB
        VYUq3vrVpolBAqCPXqd4l9YccCn6goj6Pw==
X-Google-Smtp-Source: ABdhPJy1fItIvMkASnnJ8FTA8BrdhFS1R0i+fpIIC3LIzBAOBSg4q9hpeoYaYNRs3BxydnLU6TGkEw==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr16191769wmj.147.1614608822319;
        Mon, 01 Mar 2021 06:27:02 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id c128sm8941wme.3.2021.03.01.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:27:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH] irq/irq_sim: shrink devm_irq_domain_create_sim()
Date:   Mon,  1 Mar 2021 15:26:59 +0100
Message-Id: <20210301142659.8971-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't have to use a custom devres structure if all we manage is a
single pointer - we can use devm_add_action_or_reset() for that and
shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 kernel/irq/irq_sim.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 48006608baf0..ee40a84641e5 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -24,10 +24,6 @@ struct irq_sim_irq_ctx {
 	struct irq_sim_work_ctx	*work_ctx;
 };
 
-struct irq_sim_devres {
-	struct irq_domain	*domain;
-};
-
 static void irq_sim_irqmask(struct irq_data *data)
 {
 	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
@@ -216,11 +212,11 @@ void irq_domain_remove_sim(struct irq_domain *domain)
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove_sim);
 
-static void devm_irq_domain_release_sim(struct device *dev, void *res)
+static void devm_irq_domain_remove_sim(void *data)
 {
-	struct irq_sim_devres *this = res;
+	struct irq_domain *domain = data;
 
-	irq_domain_remove_sim(this->domain);
+	irq_domain_remove_sim(domain);
 }
 
 /**
@@ -238,20 +234,17 @@ struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
 					      struct fwnode_handle *fwnode,
 					      unsigned int num_irqs)
 {
-	struct irq_sim_devres *dr;
+	struct irq_domain *domain;
+	int ret;
 
-	dr = devres_alloc(devm_irq_domain_release_sim,
-			  sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return ERR_PTR(-ENOMEM);
+	domain = irq_domain_create_sim(fwnode, num_irqs);
+	if (IS_ERR(domain))
+		return domain;
 
-	dr->domain = irq_domain_create_sim(fwnode, num_irqs);
-	if (IS_ERR(dr->domain)) {
-		devres_free(dr);
-		return dr->domain;
-	}
+	ret = devm_add_action_or_reset(dev, devm_irq_domain_remove_sim, domain);
+	if (!ret)
+		return ERR_PTR(ret);
 
-	devres_add(dev, dr);
-	return dr->domain;
+	return domain;
 }
 EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
-- 
2.29.1

