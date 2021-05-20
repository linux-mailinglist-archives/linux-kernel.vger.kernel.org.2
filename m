Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648B638ACD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbhETLte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:36425 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbhETL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621509957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MsUia02C2E5uBy4+Fgebfy1n9euxibf2rdR5VWakwLOfpwB1sioJQHhJaiZjViN3ld
    T1IN/lJlEiEwj8YvcSLW/l+DlLAygHBtuNLhH47d0cKIzcDnOF5Qx9TALdjvUzTRjwai
    2Eins/LJpAW7crD4Xb+M4WopPuiG7XKEBW+zq+dsF4f+JtgyfR6YVpbkIRWhu25coRHH
    L2Azrbs8aihYBDVWBN1uTbyfgw86m8/S6zwF4QSZ1dEQab/7pcV/kAQrkF39yUGU6Y2I
    fVVdtys6ZtsAzSzlx9Gi8dwTw9febGB+tgXN0DGWiadj26VXYOfgIXxobbEiMDxM3Elw
    /RYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509957;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QMFQUItGXEg8WHkHGki0AdlafSjTgNyjXY25dbfzkdI=;
    b=G/a/QLKV4dDSGl68+Tmjb3uPE8kAvmzlA07lt7rKWqutw+b8EfL1IQaY1NSyl9WuFj
    vRIOvnutCwMH/mPB4Vx+Hj2rV0SBqfO8+irY3FuJLjowr+0xl91luqoyA12ejvvkX4kP
    Xz1ho+B0iHqEZng15bddy1vX+MMJcKdq9YefKQa8R63bGw+XvGskpsM31avL4zLuq3+/
    A3mRgEKwRG5PGI0LezC74NG23OECleOjlUICIqejbtDijcKfBfYx+7deW8KT7W5gVTcq
    +ks9yAlwNzND7a8l12gV1zZtp1tatulbxRQQ0vuFEpckCfZYDUfzUlQpShYO8p5bDEEv
    UdOw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509957;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QMFQUItGXEg8WHkHGki0AdlafSjTgNyjXY25dbfzkdI=;
    b=oqHa/IjJwKkR2EZrtuOO4N/noUs1TqmRxywTBLou/+9EK2rQAPFEp6TtTERStxkZnQ
    +12dP5gjotsYrTqqmCWYfkKDqzMQ7Q9W2XhKq0XJzHQChAdAVZLWX7SF/gJu+MuOl4Sm
    yQbW8kfEZHhvHGyT3zP1GMZmMB0xU4nlHDbjefmjiEm/Mt3GXrMAeF6rt0VgSsb0POkt
    ZHW1zaMcoNG+PFK1C7h+rWXWjpCqcEI3ZT2iOGI++m5+WPHpmiKlYjyI/YWugdyFwDHp
    IKnU0GcYuZ/T0MdSbg/XnwpCx3muUBl+QIqwugcGpxKbFLylCZ4nt1wAeJ7KgVWootC1
    aJFw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6FtFQ="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 400bd8x4KBPu22T
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 May 2021 13:25:56 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/6] extcon: sm5502: Use devm_regmap_add_irq_chip()
Date:   Thu, 20 May 2021 13:23:29 +0200
Message-Id: <20210520112334.129556-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520112334.129556-1-stephan@gerhold.net>
References: <20210520112334.129556-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regmap_add_irq_chip() to avoid having to remove the
irqchip explicitly in sm5502_muic_i2c_remove().

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/extcon/extcon-sm5502.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index db41d1c58efd..f0d155cf7518 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -600,8 +600,8 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
 
 	/* Support irq domain for SM5502 MUIC device */
 	irq_flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT | IRQF_SHARED;
-	ret = regmap_add_irq_chip(info->regmap, info->irq, irq_flags, 0,
-				  &sm5502_muic_irq_chip, &info->irq_data);
+	ret = devm_regmap_add_irq_chip(info->dev, info->regmap, info->irq, irq_flags,
+				       0, &sm5502_muic_irq_chip, &info->irq_data);
 	if (ret != 0) {
 		dev_err(info->dev, "failed to request IRQ %d: %d\n",
 				    info->irq, ret);
@@ -661,15 +661,6 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static int sm5502_muic_i2c_remove(struct i2c_client *i2c)
-{
-	struct sm5502_muic_info *info = i2c_get_clientdata(i2c);
-
-	regmap_del_irq_chip(info->irq, info->irq_data);
-
-	return 0;
-}
-
 static const struct of_device_id sm5502_dt_match[] = {
 	{ .compatible = "siliconmitus,sm5502-muic" },
 	{ },
@@ -714,7 +705,6 @@ static struct i2c_driver sm5502_muic_i2c_driver = {
 		.of_match_table = sm5502_dt_match,
 	},
 	.probe	= sm5022_muic_i2c_probe,
-	.remove	= sm5502_muic_i2c_remove,
 	.id_table = sm5502_i2c_id,
 };
 
-- 
2.31.1

