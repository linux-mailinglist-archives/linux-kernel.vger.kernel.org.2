Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422773A34F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFJUiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:38:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB51FC061574;
        Thu, 10 Jun 2021 13:36:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a20so3718972wrc.0;
        Thu, 10 Jun 2021 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovco3PpcsCRFLz7XWhFur39Fbm6Occier1ZOhj+tK4s=;
        b=FyUMrYtdqqbVoML213lbgmZbQ15Du10yjy30XgHTkQPAxOBU8c3wbVtz65fcjnBtR+
         mFIIRe27HGRD1DgZJb6dn2AMdd/N0Yb/6rlePdkXyhdI76AonYv3jmP5/03wyKEokXrE
         0YOZhd9ydoE7ehuZRcaoAVSC9+D15i6Gr7kWSNBpj/tqQJe+OC6bl1ODYNYC7uxbhmwF
         fbvvxkmonr02aldQrnSo1pei/ytiTv+HX+HxBGSyDlRytEt8iHtDmLQMFizDgmnxW8Ur
         Ul2srzcs+sUAlbVbhn9JS4PjKVWN1ffUFihWb/531QyoqTEF5Wvw2d65YFpLMuxvhb0C
         ZSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovco3PpcsCRFLz7XWhFur39Fbm6Occier1ZOhj+tK4s=;
        b=GSkcMjdFHqEMNASSXPbWukTqGLAicUnkprmGHw+/0myH85AwTuFPkwIzs0oZzMDBQx
         g3xL0cVdynUkUU3kIl2Cxt7RZehx1Vo5/sPpfrvGgeG9I0UNr9Yd/T4seQUYrfOeTgAL
         vRts5BK8vEG5OVg1HSK6FMvRtntQWkp50XJYM5bnbnOsZjOfEkb00JpOYnih1C55PfB3
         3KFZKvlDn4K46hqwyvGhwbT0k3bGVpzRKzuw8PA+73T1lBRg3C2b5GiLKiOkT3PSclPR
         q8eRikVNsu1ZCXsse0nh0pILvYq3HGbbkWAmTpN/5UvZosYSgksp5YjMzbwkNKe/Wd4m
         73zg==
X-Gm-Message-State: AOAM531L3g1Yw8fDgI+CSlc6KPLavMuQ3M/umSjl201cJgcCDMGITnHU
        XAR9S4qwr1/yfY4r7p3pXQ0=
X-Google-Smtp-Source: ABdhPJxfuuB5r9CJcuGaAflu7XAF7aOlpLzmr2SENSvRxJ32gjY8FP0CgTxW4Cnhr48XZPlzy+SxBw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr305200wrx.144.1623357361529;
        Thu, 10 Jun 2021 13:36:01 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id u16sm4999771wru.56.2021.06.10.13.36.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 13:36:00 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: arm: bcm: add NSP devices to SoCs
Date:   Thu, 10 Jun 2021 21:35:11 +0100
Message-Id: <20210610203524.2215918-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610203524.2215918-1-mnhagan88@gmail.com>
References: <20210610203524.2215918-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the SoC names are added. This patch expands these to add
the devices.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml | 59 +++++++++++++++----
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
index 476bc23a7f75..78dfa315f3d0 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
@@ -22,16 +22,55 @@ properties:
   $nodename:
     const: '/'
   compatible:
-    items:
-      - enum:
-          - brcm,bcm58522
-          - brcm,bcm58525
-          - brcm,bcm58535
-          - brcm,bcm58622
-          - brcm,bcm58623
-          - brcm,bcm58625
-          - brcm,bcm88312
-      - const: brcm,nsp
+    oneOf:
+      - description: BCM58522 based boards
+        items:
+          - enum:
+              - brcm,bcm958522er
+          - const: brcm,bcm58522
+          - const: brcm,nsp
+
+      - description: BCM58525 based boards
+        items:
+          - enum:
+              - brcm,bcm958525er
+              - brcm,bcm958525xmc
+          - const: brcm,bcm58525
+          - const: brcm,nsp
+
+      - description: BCM58535 based boards
+        items:
+          - const: brcm,bcm58535
+          - const: brcm,nsp
+
+      - description: BCM58622 based boards
+        items:
+          - enum:
+              - brcm,bcm958622hr
+          - const: brcm,bcm58622
+          - const: brcm,nsp
+
+      - description: BCM58623 based boards
+        items:
+          - enum:
+              - brcm,bcm958623hr
+          - const: brcm,bcm58623
+          - const: brcm,nsp
+
+      - description: BCM58625 based boards
+        items:
+          - enum:
+              - brcm,bcm958625hr
+              - brcm,bcm958625k
+          - const: brcm,bcm58625
+          - const: brcm,nsp
+
+      - description: BCM88312 based boards
+        items:
+          - enum:
+              - brcm,bcm988312hr
+          - const: brcm,bcm88312
+          - const: brcm,nsp
 
 additionalProperties: true
 
-- 
2.26.3

