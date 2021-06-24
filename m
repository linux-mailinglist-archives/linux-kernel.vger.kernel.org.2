Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A53B2AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFXJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhFXJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72554613EB;
        Thu, 24 Jun 2021 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624525373;
        bh=1KL+QKiZ5XswHrkZfs1iQcYf609xqeKrKk66g0OR33c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPjhs09jqRAELqMbHbUYOMyKVfK6jm1w8W6RDtw+vrzLtJ94Wy9oCqQsim6ZJvEnY
         QgtF2gT77+L/IE3FzEp4aihnnLh4PIkFNPDuSX8gkoVGwsYkv7XhsNxJsX0cXeKJLf
         d8E9BncpsJIo8oZ49aYtlXCwCtqxb07ty+VGxv2EWmWpe4dtOTawp0gjHdVZtGQWN0
         FXyPBXF/VTt6c4JZcc1h2eoHcGExdkNkHXc5UlPIjKARa5gZ1RFeNeNt5zHTTG8SUM
         3SOSTozQ4xovpcDOFywADZKO6D+bFVcOq7xZP102eNceTYyegZ9kJ+JwPNeCeBywUx
         SvRgnW1klE2Qw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwLG6-003jrt-ND; Thu, 24 Jun 2021 11:02:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH RESEND v6 2/8] staging: hisi-spmi-controller: rename spmi-channel property
Date:   Thu, 24 Jun 2021 11:01:06 +0200
Message-Id: <ed45fc5d84d7b531343ee5d3466ebfac26217da0.1624525118.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624525118.git.mchehab+huawei@kernel.org>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spmi-channel is not used on other drivers. So, rename it,
in order to document that this is specific to those devices.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c        |  2 +-
 .../hikey9xx/hisilicon,hisi-spmi-controller.yaml       | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 0d42bc65f39b..5bd23262abd6 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -290,7 +290,7 @@ static int spmi_controller_probe(struct platform_device *pdev)
 		goto err_put_controller;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "spmi-channel",
+	ret = of_property_read_u32(pdev->dev.of_node, "hisilicon,spmi-channel",
 				   &spmi_controller->channel);
 	if (ret) {
 		dev_err(&pdev->dev, "can not get channel\n");
diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
index 6b755039a74c..f882903769f9 100644
--- a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
@@ -14,7 +14,7 @@ description: |
   It is a MIPI System Power Management (SPMI) controller.
 
   The PMIC part is provided by
-  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
+  ./Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
 
 allOf:
   - $ref: spmi.yaml#
@@ -30,7 +30,7 @@ properties:
   reg:
     maxItems: 1
 
-  spmi-channel:
+  hisilicon,spmi-channel:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       number of the Kirin 970 SPMI channel where the SPMI devices are connected.
@@ -38,10 +38,12 @@ properties:
 required:
   - compatible
   - reg
-  - spmi-channel
+  - hisilicon,spmi-channel
 
 patternProperties:
   "@[0-9a-f]$":
+    type: object
+
     description: |
       PMIC properties, which are specific to the used SPMI PMIC device(s).
       When used in combination with HiSilicon 6421v600, the properties
@@ -61,7 +63,7 @@ examples:
         #address-cells = <2>;
         #size-cells = <0>;
         reg = <0x0 0xfff24000 0x0 0x1000>;
-        spmi-channel = <2>;
+        hisilicon,spmi-channel = <2>;
 
         pmic@0 {
           reg = <0 0>;
-- 
2.31.1

