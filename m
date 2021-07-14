Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0617F3C8112
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhGNJQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238411AbhGNJP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:15:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73418613B5;
        Wed, 14 Jul 2021 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626253985;
        bh=hj/ipUvkpkeKWt7EJnZrwj31HELGkpjHJJ3w+DNn5xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N05c9EA49loOayM48FOSgyBmKnpTO0cJq4bHkqxqcr5fGor4uor+bAuYrqKZrz9cS
         tbndrKtMFSH27eswtv2WM/Ty80uTJZTsLFBgnBsMOsESI0/1n979dWfSd2x6EU2LLO
         V0o0XpSfUKphKaoxC1E0uVBjPAC5GNfVKdFxZdwQfSdbIHKpJvdYgCd2qz4r2SSDYc
         u9aPK12jTB8f3TryDcNQHebdEQZ3xgfeJoRaqoiiwgfhdDefqAOtGe7jcY8oJ0wXme
         zAJ7nrNvyvZ3XHx4lTbWBSo1PzZme9fc1OnceL1kUuHu/W964P9J8qTzgXCDK5/Fvt
         302CUFXBqed+g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3awx-007q2H-23; Wed, 14 Jul 2021 11:13:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 1/9] staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
Date:   Wed, 14 Jul 2021 11:12:53 +0200
Message-Id: <1e7ec01a61916a03e7165e684d8d5b7dc58970f0.1626253775.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626253775.git.mchehab+huawei@kernel.org>
References: <cover.1626253775.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the standard name ("gpios"), use "interrupts".

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c              | 2 +-
 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 35ef3d4c760b..9a7e095246f7 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -233,7 +233,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 
 	ddata->dev = dev;
 
-	ddata->gpio = of_get_gpio(np, 0);
+	ddata->gpio = of_get_named_gpio_flags(np, "interrupts", 0, NULL);
 	if (ddata->gpio < 0)
 		return ddata->gpio;
 
diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index 8e355cddd437..252b600f02a8 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -34,7 +34,7 @@ properties:
 
   interrupt-controller: true
 
-  gpios:
+  interrupts:
     maxItems: 1
     description: GPIO used for IRQs
 
@@ -71,7 +71,7 @@ examples:
 
       #interrupt-cells = <2>;
       interrupt-controller;
-      gpios = <&gpio28 0 0>;
+      interrupts = <&gpio28 0 0>;
 
       regulators {
         #address-cells = <1>;
-- 
2.31.1

