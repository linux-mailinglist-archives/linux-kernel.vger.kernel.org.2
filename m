Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FA3498E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCYSGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhCYSFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:05:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0891561A34;
        Thu, 25 Mar 2021 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616695545;
        bh=Q2tZBsdPQDvnqOQufuHyqZzw7WUjXHdEbtYO9wUPA7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gK2Mo16kFK2WfM9n6gTrjftef34tnwJgP7HsrrgPcXKzlYS8cPachnYvIvYfua/Fr
         NPJ6+XdFhrf58gRkMtarbGkgUiAHXzJZYh2EDujNrpBjRjAMUb6oY73F//QQKe3J9F
         ogm058TZ9aKB9VlRWNsJ7Q2h3paYOvYS3GpTC9+0zP/iGi6hrVsHVxKaIkYArqefG2
         FodBD88EoGjcIaszvzO0XQjtid76v/CXaOVNp3NBIYa1I9YrG66VwuZBVDEq5UEWnM
         A8WCl5EiCdxnaxcl1sMUmwu0qsabLUcOt5kI7UwlEnCkLqSOwQOD2YkbkCTT8YpXeQ
         xyi/CJRGJEdHA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPUMX-001Maj-Rc; Thu, 25 Mar 2021 19:05:41 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 (RESEND) 2/7] staging: hisilicon,hisi-spmi-controller.yaml cleanup schema
Date:   Thu, 25 Mar 2021 19:05:34 +0100
Message-Id: <4e4a80d3a1b84a354d3c40be374a1689ae6c0fb1.1616695231.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616695231.git.mchehab+huawei@kernel.org>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some properties already defined at SPMI bus, and
place the type for the spmi-channel.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../hisilicon,hisi-spmi-controller.yaml        | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
index 21f68a9c2df1..6b755039a74c 100644
--- a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
@@ -16,7 +16,11 @@ description: |
   The PMIC part is provided by
   drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
 
+allOf:
+  - $ref: spmi.yaml#
+
 properties:
+
   $nodename:
     pattern: "spmi@[0-9a-f]"
 
@@ -26,13 +30,8 @@ properties:
   reg:
     maxItems: 1
 
-  "#address-cells":
-    const: 2
-
-  "#size-cells":
-    const: 0
-
   spmi-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       number of the Kirin 970 SPMI channel where the SPMI devices are connected.
 
@@ -40,18 +39,16 @@ required:
   - compatible
   - reg
   - spmi-channel
-  - "#address-cells"
-  - "#size-cells"
 
 patternProperties:
-  "^pmic@[0-9a-f]$":
+  "@[0-9a-f]$":
     description: |
       PMIC properties, which are specific to the used SPMI PMIC device(s).
       When used in combination with HiSilicon 6421v600, the properties
       are documented at
       drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -63,7 +60,6 @@ examples:
         compatible = "hisilicon,kirin970-spmi-controller";
         #address-cells = <2>;
         #size-cells = <0>;
-        status = "ok";
         reg = <0x0 0xfff24000 0x0 0x1000>;
         spmi-channel = <2>;
 
-- 
2.30.2

