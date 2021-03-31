Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21D834FF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhCaLgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:36:37 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:45674 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235326AbhCaLgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1617190574; x=1648726574;
  h=from:to:cc:subject:date:message-id;
  bh=GpEtldFBDf54jf22CJOCHlno2xZ7A1zNBsfmGfbuT/w=;
  b=qzfmA8/cBwm1iNh1vd1CzXPBm6jBr4+9LzhqL7sPy9te6jMKhAPsLInv
   E+Kdogsf9DeK4xCYJCkAlV34XvjABrziPTqCPOpGDH4hu433fOpIszgBx
   RbABiy1gO+cleNKvu5qIgpd/kvDpuY3PfWh+ZGXYsvs/ObhkKN0kJuVn/
   rxjfTOk6IOoPuVa/40ytvYsBsApnhelBpeg1JK+NCWA2UeilFJu+3upYc
   I68BzLopN3VlfQ2DHvaUkeV1nGuQPZJrvLE7/9p9VoaQVBs7zDIWNLY6m
   ot7j7BazgDk/vGYmWV1x1W1tTybMwEoMZVuq7m1kWmo1/V3wj3abjmWER
   A==;
IronPort-SDR: VbaQnYDfuJS8/xsgGeNtqm6OHDJkqjtOfjtyYuxgdG5cMt/3t9D2Q1L/c1xE+iQa65w5lGGMpe
 U5/rh0iiBWoya6SS2COYgfOo6GI4Py1LqAT4mY39rNLO3DtcYKXkFLHeOM81aJhJ64KQEu86HE
 c36pkzE/Vdn/mHByHY9fmR1KMwAUudC8bgeIVflyPbXBG5fxBx6DZ8fykPz4c6a3Fg1XRKBH0P
 31TTJz/ioB8AAUvUwLP6/1QBZYOihQbw8WENWWmQe4kzuQQNdAgrmgndaleBDCF9vkO9cy7kKY
 Wb0=
X-IronPort-AV: E=Sophos;i="5.81,293,1610406000"; 
   d="scan'208";a="16742377"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Mar 2021 13:36:10 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 31 Mar 2021 13:36:10 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 31 Mar 2021 13:36:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1617190570; x=1648726570;
  h=from:to:cc:subject:date:message-id;
  bh=GpEtldFBDf54jf22CJOCHlno2xZ7A1zNBsfmGfbuT/w=;
  b=PmixRswLGUHJHlRarjrF5wgcRIbsCyGaN6qSnXhg3APiA+iXtw+c6r76
   OBSDL7EoD6xF8NNAWIUEpfE8czJ+PbC/papUHm4rFuFuHN0lFmUGABgXn
   qjvttKRM/GuiAAG3D/bpDjs+yUmBl2BdXBkai5foPRd+j7NncxKY6HzjD
   y+OB9beR1jeGu79shioe5PIF3eVotWkacImv/4yYnSFhOzl0R58czS8I6
   iY2eBr/2EcM1N4HEXak2leG/qo1521ovO+z3cJaZMqIvTZ/4IXQaDNKiX
   lCAjSQwpXV1170NW9TAtXOYdsJg1FDuF16StSHW8YRDCF+re+nhUMZaXr
   A==;
IronPort-SDR: Sj0A9gsdUhKBI7A6Fe6zUsGp3n5F9LpH6skTeRglIKSOf2/8cjMuFrjB6cUlb2JRnI3wI+kamd
 swV267Lu9uLR/5vE1O1L2Jhhv3tOiI3NB4m/f6h2w50G6Gv4qwEcqHX3oTRKc3dkKI8HzMAaEa
 V9rfZ+dCmhWIYr449+bpDopkGO7pbs5RrzAxDjf5rqp7iVBZll/HjRtyC8p9dNLuD92+8aODYM
 r0JfciakYEzNK9WCmFytC7c2obP0FYsG3FkKJdtcfgvD/le2c7Ul2Hw1bi7sRGTGVTBfHJVmbS
 hjQ=
X-IronPort-AV: E=Sophos;i="5.81,293,1610406000"; 
   d="scan'208";a="16742376"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Mar 2021 13:36:10 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 70929280075;
        Wed, 31 Mar 2021 13:36:10 +0200 (CEST)
X-CheckPoint: {60645E92-3-486672D-C0FA7804}
X-MAIL-CPID: 82C3068857B2EF64120095EB0E7DD1BB_2
X-Control-Analysis: str=0001.0A782F29.60645EAA.0097,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/3] gpio: tqmx86: really make IRQ optional
Date:   Wed, 31 Mar 2021 13:35:43 +0200
Message-Id: <11a8323c249ae6ea7584402ab0fb74551b6a4b7d.1617189926.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617189926.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1617189926.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <cover.1617189926.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1617189926.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tqmx86 MFD driver was passing IRQ 0 for "no IRQ" in the past. This
causes warnings with newer kernels.

Prepare the gpio-tqmx86 driver for the fixed MFD driver by handling a
missing IRQ properly.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/gpio/gpio-tqmx86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 5022e0ad0fae..0f5d17f343f1 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -238,8 +238,8 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
 		return irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -278,7 +278,7 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	if (irq) {
+	if (irq > 0) {
 		struct irq_chip *irq_chip = &gpio->irq_chip;
 		u8 irq_status;
 
-- 
2.17.1

