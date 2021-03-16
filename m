Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDB33CB88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhCPCfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:35:40 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56182 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbhCPCfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:35:33 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ACF9B891AC;
        Tue, 16 Mar 2021 15:35:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615862129;
        bh=N8RPjIWX7pyqYW4bY3X8jjB0RdGiZOTWA7jASK4pWIk=;
        h=From:To:Cc:Subject:Date;
        b=jgk+ANoEt5LTBJHOej6zwS3KSWsn+rqsyB+Cw/EauI8J0rPWOpU8dVeEcFtnFCL0A
         Y3VYz3XZ6KNge1IBGsxU4FDgci981p/4AleCf2TvTlklAV4BQBLom7Vf+h5rBEtXxN
         rI/l2vLrDIy70zztqxG+NntZ95CAopkxlcaeT5DTOPPQ6dRiYR6nsFVC/IyY01Zwh7
         O3vSp8YtWQxStjZ/KAq7Y9ACrzVcA4yFFhYZXivpglFimrlYxpxt8atP77J1wujdFa
         MuElAQJWNajwGHLBFFC1/8yNKji0tN2rXYNmzQuQXOR5NM39CscJmUabO7i1NL8C3t
         uyk+l4OsDPdbA==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B605019710000>; Tue, 16 Mar 2021 15:35:29 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 5B37113EED0;
        Tue, 16 Mar 2021 15:35:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7FFCF284092; Tue, 16 Mar 2021 15:35:29 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] dt-bindings: Add vendor prefix and trivial device for BluTek BPA-RS600
Date:   Tue, 16 Mar 2021 15:35:23 +1300
Message-Id: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
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

