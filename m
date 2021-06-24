Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012433B24E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFXCYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:24:53 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:47513 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhFXCYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:24:52 -0400
X-Greylist: delayed 60082 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 22:24:51 EDT
X-QQ-mid: bizesmtp42t1624501343tsdvmezl
Received: from localhost.localdomain (unknown [182.148.13.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 24 Jun 2021 10:22:20 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: vRxJyNZKtn7YycPXZKXuImxRmH5Y77vBon3cs/Dr/3AI5ud9YzzIvs+PxVSYI
        NsuRYfgk7rurLeSuG3MNHSQbZDmJzV590YhnA4wFoQs4VcanH7qN0TG+bgZDa5up0cC2us9
        mZqaV6oDcOdnNB0B5kJOaMUeIRXwOaSjnZe8f2dVYcgGC5FrMMxYmQaJSu7rBcxH1G02tXK
        AG2mBYzs41SPpPqNdgHU7olUM4M7rQcIW6DyE/iCk6Gwleq/vGM2lHZpWlI6rN1+dDgZe1f
        TlZwzZu+sWuQLlp9nDL9jlE4ijqdLqIY6hJyYlnoXTq1wtcIwjPCUlS2Br4Qycl4hLhvx84
        D3HLdd+
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     bgolaszewski@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, wjc@cdjrlc.com
Subject: [PATCH] gpio: Prefer unsigned int to bare use of unsigned
Date:   Thu, 24 Jun 2021 10:22:13 +0800
Message-Id: <20210624022213.65140-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:
    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
 drivers/gpio/gpio-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 524b668eb1ac..31a336b86ff2 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -229,14 +229,14 @@ static int mxs_gpio_init_gc(struct mxs_gpio_port *port, int irq_base)
 	return rv;
 }
 
-static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
 {
 	struct mxs_gpio_port *port = gpiochip_get_data(gc);
 
 	return irq_find_mapping(port->domain, offset);
 }
 
-static int mxs_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
+static int mxs_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct mxs_gpio_port *port = gpiochip_get_data(gc);
 	u32 mask = 1 << offset;
-- 
2.31.1



