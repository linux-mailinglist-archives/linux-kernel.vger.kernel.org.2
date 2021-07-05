Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAAA3BBA55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhGEJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhGEJlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:41:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 644A1613E2;
        Mon,  5 Jul 2021 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625477942;
        bh=hj/ipUvkpkeKWt7EJnZrwj31HELGkpjHJJ3w+DNn5xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5W9y8FNS0GsXdo3jOLUyBX2mZ/21MCauWtXQ4BqBOumkewWjt71OlgDbXa+rCrsm
         I6nz+94YfuXoxBxRP6XfALcBY5pzgR03rzpPMV9++qFil3XJ7x5C5qb20Nlcg5kl7W
         RLa0cPesaBo3dRFe3HGLXhMl32wPSOSlILbTPxwUo0oH8vEzKjw/O8iJhdxYXZDd+t
         GaopQMIoweXoEhE7T2x3p56aKGUk+vwRnsjAF1qP6MvS7lV28ExZfIGEB+kONIkUHj
         /C8Mlb10LoBpoEGb9T7ugqLAUXhFVRim8KYwp7G0qV0tllZb9FzAejaVrrJw/7KMUl
         sa6Kv31HGj0DQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m0L43-002tok-5R; Mon, 05 Jul 2021 11:38:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 1/9] staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
Date:   Mon,  5 Jul 2021 11:38:42 +0200
Message-Id: <0df3e0572f80a9e47d66ca59bb82dc9f622fa456.1625477735.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625477735.git.mchehab+huawei@kernel.org>
References: <cover.1625477735.git.mchehab+huawei@kernel.org>
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

