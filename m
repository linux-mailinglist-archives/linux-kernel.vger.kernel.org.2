Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66744395E22
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhEaNzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:55:06 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:16610 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhEaNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:36:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622468094; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Mm4ccRTf4qPETdpv0td27lQMGxExBSb44+JIcH4RFl1sH84W6LMql2MYHrn1tb3WrF
    j5fNB1Po+P/sW5Zfet8lKfCDq6zhWAmlJM8pmnGepG7BuSqLFCv7f4Z0xNSCv4mCA6Lh
    nrH9kmJjhsinSeU+9rtW1DYbYVJhKZYovAEldV1bl43Ys0iqyQgB/QibEPbGjrrbNkZ0
    BKdKXHY3owGLsUCMdYXzPd4KaGKNFuE3EaNgepWU56F5rJQJgksLoHhIj2enBaCyys1C
    VNHNOSYoof/TUZQ+C8kAdUoZ6GjbRGT7kjNPZ+3LyLlZ2GJWRqyjjnFeB5iDEv1PRII1
    BA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468094;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=K2eJgpXpY/tpzZTBI+UgcYaqxpRI58FPkFkDl3yfQRM=;
    b=L2QTHmym/F7Lxg3E6KcUa+IxaA7OcknTYd/SwpXFlBBofwwWbmnzYxvI8JIyL+Srog
    uWIvY19dyb/jacemNW2Uxtth9dY62zME+wO4aVSDobi9zt/lqM8ECizQSA7c7DChh0v0
    VAAQoQ7u1IjLVbZHrajedxf0qI3avAC/mBfMctlP3DU4DMw2e4e0oK/xL8c9Hhw3Lq94
    1mR9ECuV3nP8nKASWp7uRi4Tzlqib/uePUbxv4rl2sO0VSmk0JUGtVQqX1psRmesh9Tk
    D0XxX5Vaqs4CmzIh7Tf2RYjFvs1i9P0t3gMrrNINebsmn8XrfLGJFZ4epSnaSr0EHVlH
    Cf3g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468094;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=K2eJgpXpY/tpzZTBI+UgcYaqxpRI58FPkFkDl3yfQRM=;
    b=jtWyRGL4G9GLbyaZPahM0gkJxKnnJzuAdtv4T0LB7epZi2vNFMBdWXKG45lALq1UjQ
    ItrgLnrmHIFkG5PZoYMiOVTnhZc97c69h5YwZMqZMXTIm5WcmfD6U3SkfzYfN27+UASM
    2rRi5JAZ2UBxJwDVeHhx9eZc4crvEGTJgHPpYm/9rIj+mIb1u4Zs4twc9Kaf8qHc2JLp
    q9AqoBk3if9DGIZ6T0cWH0VP/TSSLHdP4S3fG9ePz47UaFVMKu/mmrj8yFOuTcO2aCfV
    NYDuxoVididt8fp+ie4mpiA2g72cfJMBWHcVzybZ1L3ADeaq62GAeHVsu6ZI/psE/7qd
    YpxQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526Kcak="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x4VDYsKx9
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
Subject: [PATCH v2 2/6] extcon: sm5502: Implement i2c_driver->probe_new()
Date:   Mon, 31 May 2021 15:34:34 +0200
Message-Id: <20210531133438.3511-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531133438.3511-1-stephan@gerhold.net>
References: <20210531133438.3511-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sm5022_muic_i2c_probe() does not use the i2c_device_id,
so implement i2c_driver->probe_new() instead of probe().

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/extcon/extcon-sm5502.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index f0d155cf7518..907ecd01ebb7 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -563,8 +563,7 @@ static void sm5502_init_dev_type(struct sm5502_muic_info *info)
 	}
 }
 
-static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
-				 const struct i2c_device_id *id)
+static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 {
 	struct device_node *np = i2c->dev.of_node;
 	struct sm5502_muic_info *info;
@@ -704,7 +703,7 @@ static struct i2c_driver sm5502_muic_i2c_driver = {
 		.pm	= &sm5502_muic_pm_ops,
 		.of_match_table = sm5502_dt_match,
 	},
-	.probe	= sm5022_muic_i2c_probe,
+	.probe_new = sm5022_muic_i2c_probe,
 	.id_table = sm5502_i2c_id,
 };
 
-- 
2.31.1

