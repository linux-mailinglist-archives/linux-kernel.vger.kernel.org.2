Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A5395E21
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhEaNzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:55:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:32608 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhEaNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622468094; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Sf6AYmToRi+Z6IoqYiJgpLnNA2QKb47pQHrZp+/mZh3I9pE09yVclN4HK7CVslVPno
    2eDBe5WPKMVe92/7eoOtIzrkHw3bc69XPwXM8glX7Tynn/E4ypL4Kc1YYtXj/EuQpEe9
    wbNJRO108yCM7HIjMGzmqPiA2PaW+1E9iHNoHA15ZqOxM7uXhDmqxyPE3eVXzylYa5rH
    Wvzah0Hs/5gWZAJsTGsLM5RJmLT8jEBXJdGykFGBAurm6n8Fc+cq/3bw2dzK5jYJSX8S
    OJnUEVDY5d9l7xx4lioP3FNag3SLZDdkyO+oqY+yWFOF+U8CLY8RV27jBfRm2xP6omsY
    XPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468094;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QMFQUItGXEg8WHkHGki0AdlafSjTgNyjXY25dbfzkdI=;
    b=Zx3VrWps+A0QZjNbs69IA84Ww45u/4jLx7kzF+ds2Pd4JYNSMJQJs0UmhhB/bcJmdx
    H0bU8+tkzYdSx5Dde0VWoQrNPqVdDYEueU2qq2myfxioItSp8Y3Mi5tBZty+8gr1O+ZP
    6xJ8gj+mQdVOTZwMUmdXHLs1OAF+/BOEh/r8/z0cs0PQR6vJc4Udi4cqQFhn7uumQveC
    Rdssp9EJreY8V5hPz7eiKtAxMZRKE3e3pndXpTJZa7Q4PajNZnxLGXKHrLsgYPfQIAD1
    ydNo2xKlm73sbKgR2h13be2ZcMAOO6N7l4/qUy7nipv+0EPkyZHJkEb2xPViHBraN7y6
    6Z5A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468094;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QMFQUItGXEg8WHkHGki0AdlafSjTgNyjXY25dbfzkdI=;
    b=Cyx+UEs03+8qWuTbRUJcLPNtspAsRz+2ybGZJ66T4Dji631GpOHUBuYMwW5MGuaUXE
    PLDIWU5ZFRROBZir6IviRphnPupugZt40HrWxVNHMJlDpZrO5mahtzNyv2o1Qf7SPaJq
    nGR6vNOITr+C8zdgPUJ69B7CSTPwbY/gh9d9Q77vNzqbRJV86zFDxT24kETzYApavFcs
    2d/eL7lHOaV/wl/s9ZUhAGZwrKxpkWGDeZ1Ke48Mk6BE/sW/rJp1K7Kuw6iYMiFzV0VV
    tNKxlFI7FSBUT7STwa2Q1puGmKUFbjUTZTEnhf+BlzJIMpZCYk2M4HicB6DNYegiUXUH
    iTYA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526Kcak="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x4VDYsKx8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 31 May 2021 15:34:54 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/6] extcon: sm5502: Use devm_regmap_add_irq_chip()
Date:   Mon, 31 May 2021 15:34:33 +0200
Message-Id: <20210531133438.3511-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531133438.3511-1-stephan@gerhold.net>
References: <20210531133438.3511-1-stephan@gerhold.net>
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

