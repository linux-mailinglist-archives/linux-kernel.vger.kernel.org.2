Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241D933E843
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCQEDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCQECn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:02:43 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0BAC061760
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:02:42 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7D4DA891AE;
        Wed, 17 Mar 2021 17:02:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615953758;
        bh=IWnzGbdhoY3I/3H/FRPN91hsW4fCSbI+PNT01Z3SHRk=;
        h=From:To:Cc:Subject:Date;
        b=h9YHDvJwJSvEngk0brf5/B6d6nJasHnYcVQxBa4Z5onpW6CXCaS5cFG5tv7YnOIxp
         EdGFACYsvFRvzkvMlXQxJvfbmiLslyz44VfqLTh1bv1qeH+49Ab8ndqAeH69bVwu6x
         9OFNUYOvkesIKGs6SpdBDa4Qn0fCmORMN+QnjktY50+0Si57K603NH22SvXZbvlKzZ
         HylRZYeEaqzxQnpNmNQX8XTigI6jMC14BaENbK+V0mkcfxzejY3ET2H7Mr31AxbXqH
         hyQRYgKpHzgDwipNaChBCR5xqb5O7+e9xBddwb/AMbxWMlRYeLGieBtbDQA8aifVH3
         PdoznljYXdeJA==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60517f5e0000>; Wed, 17 Mar 2021 17:02:38 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 5331413EF08;
        Wed, 17 Mar 2021 17:02:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3D6F4284092; Wed, 17 Mar 2021 17:02:38 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix and trivial device for BluTek BPA-RS600
Date:   Wed, 17 Mar 2021 17:02:29 +1300
Message-Id: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dESyimp9J3IA:10 a=ueuSTYl9OFj5rdJX3qQA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix "blutek" for BluTek Power.
Add trivial device entry for BPA-RS600.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - None
    Changes in v2:
    - None

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
index a327130d1faa..569236e9bed0 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -50,6 +50,8 @@ properties:
           - atmel,atsha204a
             # i2c h/w elliptic curve crypto module
           - atmel,atecc508a
+            # BPA-RS600: Power Supply
+          - blutek,bpa-rs600
             # Bosch Sensortec pressure, temperature, humididty and VOC s=
ensor
           - bosch,bme680
             # CM32181: Ambient Light Sensor
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..d9d7226f5dfe 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -169,6 +169,8 @@ patternProperties:
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^blutek,.*":
+    description: BluTek Power
   "^boe,.*":
     description: BOE Technology Group Co., Ltd.
   "^bosch,.*":
--=20
2.30.2

