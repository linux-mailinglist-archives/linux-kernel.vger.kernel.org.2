Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1723038ACD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbhETLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:22810 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbhETL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621509957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YiWxmdNZVNEURRgHh2zS/Lk3DU9vi6+Q4ThNObccfZ5jRlapuLMJpuT1Deif8qC20t
    myjhZvIkdGVHF80kNq4vou0WRYMlQ2VTIAGcQJ/+p22p9p7uZN3tsMNXkWV7gKvUFkWh
    uMLaCTXOgyeHqCzIOzgjbOqFF4pWgM4+Co7A++oePlvHPFZyGIhIENbXhcI6ihb1UFtg
    4E2ZgDFr2nFefJvCaGj4s8E/4OH7jJG5hsb34n5P322ly06ehc+RnQMEklKEOT8pKO83
    L08xhT56dDQxIenOu4yyxwSAmRqwxHiJnbMawWqMl2DX6K+ybpQJDX4oItZTgdgvtBnE
    oGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509957;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=K2eJgpXpY/tpzZTBI+UgcYaqxpRI58FPkFkDl3yfQRM=;
    b=BC/cN54UTLVdsLnEB5NDfvyBHbU/HsZ1C18Lm3/7wsYcmzGG7cdfkq9Xt7dadFWLdK
    MrkMmEVY6IPKKCaX7kz8PZ9/WCYmruXve7+4a7yZWVya7SALuJk3eOOKelhLfEM64Ums
    BKbOgCMLl/wJFu5emuLKNKJAXvmkogvVHGPRqbkRE14QzlWlZOJoIG00zyEC6uHflJTa
    k5haT0yVfPgvDHhzRnSTs9AR8/KjmVyLCUfeF17fvk/mwdzPIp6Mak8zwZtJvQmvmfgI
    JcLBAs7aRz+FNFFfTKS8Wo+jQg8rgGhzZMZ9+7GQBaaC7jdoCv7jOR2zcD0AZfrUyQRJ
    3Grw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509957;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=K2eJgpXpY/tpzZTBI+UgcYaqxpRI58FPkFkDl3yfQRM=;
    b=l0hvOrJFU5Wyyv2GpR8HC9dov2u20XUE6Lcm1XhRSqSuGP9AkyuqpQxhOwfyXRdBmS
    mRPeAlV1O+vfUeez2yTkzW7V0LTRBEGrcp/zzqIYWE5Koj8HFmC7X5qhrHAfWmc02w9V
    /ftsHy5PJOAovb9wGSSq2AsVV93y+r9YmHISjDWwiWKcOdqB815/Jw08pqLuPWSydaL3
    2kMekAtB2zuDhFVQWbO1lwSZVd5nXVAb98qNG6/Lu34Dt543UIrOlE4HkhZJ6cWdzUmg
    3pCRcNQaq5SxBXgeh6+mcnyiKIltWtX2acDW2JlFgNvGEB3FmYroSlzGODWsnY4PHLVN
    POoQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6FtFQ="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 400bd8x4KBPv22U
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 May 2021 13:25:57 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/6] extcon: sm5502: Implement i2c_driver->probe_new()
Date:   Thu, 20 May 2021 13:23:30 +0200
Message-Id: <20210520112334.129556-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520112334.129556-1-stephan@gerhold.net>
References: <20210520112334.129556-1-stephan@gerhold.net>
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

