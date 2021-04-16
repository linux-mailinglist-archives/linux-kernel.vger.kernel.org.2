Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0524E361B65
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhDPIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbhDPIIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:08:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE3BC061574;
        Fri, 16 Apr 2021 01:07:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so40796367ejz.11;
        Fri, 16 Apr 2021 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dW71RUeT0a6iBVCowrrCy27Ig3MirCGSJbJRZ5FSubM=;
        b=PbpOP3vGz5DLPcykfNpuEqOgQ7euRr1YJ4mv0QKHrtOsDULR10X2KVqYS0vphNODtE
         tlD0smBqv2AaXqVA75h8IoEMglQdGMIvs/hhiN6wdGXWFP7dgFjmJszlH8YywYH6STZj
         uCJM3SdyBIHkCiGI5ssPV4IZkj5bXNBR2okTdrjaXCqO4A3pu3FoaaiKBPiP+78tzJfA
         HEQNF4E2WUTWbG2GZgDW/k0vHWh9tTLcqGDqdq/sjNYPrJLt+5b8nGBGRcQ45CxXz4/W
         zlTaClVP4vzxqvwJWdnDt0xdpR4Z4gQRFMy7z8r/05QJbB6pUqm8v0J4VrR5tgpGR0fn
         oyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dW71RUeT0a6iBVCowrrCy27Ig3MirCGSJbJRZ5FSubM=;
        b=GeaOTlwlrgP+gw/zUQ6KUqEaqv5Np4aoEC2VE4yfE7uxFan1EySGXWxBWFGBYtfYNx
         Txf2UwMYFTmGF4v1GspP9GrwVbFbF2i0+FEraacC3hbrkbmgTxpmtNpcSfHalhXfzbrW
         GPXnsVZ6bAUvAnPlJ0KCir+iBV1rtPo409QwC6wXDCKV8GrntikSnrv9scysThxNRGxC
         bPV2rnel74gMQPHA3wAoqgUzzMBRZY/5jQwn3jd338z8HW480saAOiUjo79X8n/CBWa3
         19mFHWAzPC8iwW0R93/WkNplr+UCzaTNzpNvv4nqIfKZYWH8/dNVJC9v2dQ9OiGvbbHE
         U9Fg==
X-Gm-Message-State: AOAM53312rfq1ebvbquygJXfDQ5zBQQlraKPUEV1G7cJrx3D7Vwlpr0p
        lnpG8DnDWLOnIkSRqpFXHqU=
X-Google-Smtp-Source: ABdhPJznwZS4qVKmloH7SP7EsHwDRkIeAKU8RRrzkuHSVxIS6x73VsHdXcti+LmnUyqceNDbZmaXkg==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr7420791ejj.494.1618560477849;
        Fri, 16 Apr 2021 01:07:57 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.07.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:07:57 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/15] dt-bindings: arm: rockchip: add more compatible strings to pmu.yaml
Date:   Fri, 16 Apr 2021 10:03:39 +0200
Message-Id: <20210416080342.18614-13-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible strings below are already in use in the Rockchip
dtsi files, but were somehow never added to a document, so add

"rockchip,px30-pmu", "syscon", "simple-mfd"
"rockchip,rk3288-pmu", "syscon", "simple-mfd"
"rockchip,rk3328-pmu", "syscon", "simple-mfd"
"rockchip,rk3399-pmu", "syscon", "simple-mfd"

for pmu nodes to pmu.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
index 0b816943d..678be9011 100644
--- a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
@@ -19,7 +19,11 @@ select:
     compatible:
       contains:
         enum:
+          - rockchip,px30-pmu
           - rockchip,rk3066-pmu
+          - rockchip,rk3288-pmu
+          - rockchip,rk3328-pmu
+          - rockchip,rk3399-pmu
 
   required:
     - compatible
@@ -28,7 +32,11 @@ properties:
   compatible:
     items:
       - enum:
+          - rockchip,px30-pmu
           - rockchip,rk3066-pmu
+          - rockchip,rk3288-pmu
+          - rockchip,rk3328-pmu
+          - rockchip,rk3399-pmu
       - const: syscon
       - const: simple-mfd
 
-- 
2.11.0

