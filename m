Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7641FD0E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhJBQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhJBQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 12:22:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5AC0613EF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 09:20:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oj16so655537pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4rLuo2ykiHXggmeHqYRj08h89CMbpW00i+4hL2kTmc=;
        b=Zt5xeF9HzCVGHVXKypIC1N9e6gFdZxQjTDO05pMhNdfZxoVI515qfvoqGJqgKyZn9u
         pP3Dp5b9dCrR0pPPcfA+cVU3qeG9Z6n4JbpR7CGLbbdq0IWKDui8Y61h1v7TCSkc0Tiv
         fZUHPUzps+vfU6jN/YV0rwjE1i3IMgZS8zzSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4rLuo2ykiHXggmeHqYRj08h89CMbpW00i+4hL2kTmc=;
        b=NKMj2iexjjRF4iKGOULlsZ2whPPvJZAc0LwmW1KVivX8jeULNTa/0Bgf8eEGLtOXSJ
         z+eEZKzj0wqt4H/Uax6bNNuNQzeKWguDbpJwMW8N0c7rHavUOz3ejyNtXuOsVldNvNXn
         edFJ7wB2+oOWB7AN61rTlYqJZcSBfTKniCaRgETRde+kiPTTIdtaucnH5Hp2FgpcM5zT
         xZdkIKK5ixYNcskYuWbszyiqlnRRo4u3MplnF7i0wZewMerhxcRAiOaTwVe6kXuAo5bM
         D+GE5iOp6oGCjWft/iBiPahInBWZxHxDJuWdqnbFCuv2w12jbLpoHckloAnAj8W85ogo
         8ZGw==
X-Gm-Message-State: AOAM531tLIQQ/J8pPgLBWLL3JJho20pHfv3XO8XQuyrjEK37uxzC0edt
        LbFxSTURnOJ0+S5IhIOlQBFN2Q==
X-Google-Smtp-Source: ABdhPJzRoDmBHnGFqBTldPEU7mvie17JJefDNDPsAGw6oqPncVA8o03SuuO6+KqT5JsacYzh5eyBUw==
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr20095582pjj.27.1633191618169;
        Sat, 02 Oct 2021 09:20:18 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id nr14sm5223729pjb.24.2021.10.02.09.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 09:20:17 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH] gpiolib: Move setting the flow handler and don't set it at all if there is a parent domain
Date:   Sun,  3 Oct 2021 01:20:00 +0900
Message-Id: <20211002162000.3708238-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling irq_domain_set_info() before irq_domain_alloc_irqs_parent()
can cause a null pointer dereference as the parent domain isn't
ready yet.

Move irq_domain_set_info() to after irq_domain_alloc_irqs_parent().
A side effect of this is that irq_domain_set_info() will now overwrite
the flow handler from the parent domain. So if there is a parent
domain do not set the flow handler anymore.

This allows gpio-msc313.c to level it's irq domain on top of the
new irq controller in later SigmaStar SoCs without crashing.

Link: https://lore.kernel.org/linux-arm-kernel/20210914100415.1549208-1-daniel@0x0f.com/
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Suggested-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpiolib.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d1b9b721218f..993eeced6b4f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1103,19 +1103,6 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	}
 	chip_dbg(gc, "found parent hwirq %u\n", parent_hwirq);
 
-	/*
-	 * We set handle_bad_irq because the .set_type() should
-	 * always be invoked and set the right type of handler.
-	 */
-	irq_domain_set_info(d,
-			    irq,
-			    hwirq,
-			    gc->irq.chip,
-			    gc,
-			    girq->handler,
-			    NULL, NULL);
-	irq_set_probe(irq);
-
 	/* This parent only handles asserted level IRQs */
 	parent_arg = girq->populate_parent_alloc_arg(gc, parent_hwirq, parent_type);
 	if (!parent_arg)
@@ -1137,6 +1124,27 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 			 parent_hwirq, hwirq);
 
 	kfree(parent_arg);
+
+	if (!ret) {
+		/* If there is a parent domain leave the flow handler alone */
+		if (d->parent)
+			irq_domain_set_hwirq_and_chip(d,
+						      irq,
+						      hwirq,
+						      gc->irq.chip,
+						      gc);
+		/* Otherwise set the flow handler supplied by the gpio driver */
+		else
+			irq_domain_set_info(d,
+					    irq,
+					    hwirq,
+					    gc->irq.chip,
+					    gc,
+					    girq->handler,
+					    NULL, NULL);
+		irq_set_probe(irq);
+	}
+
 	return ret;
 }
 
-- 
2.33.0

