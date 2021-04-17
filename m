Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3EF362F99
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhDQLbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhDQLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CDDC061760;
        Sat, 17 Apr 2021 04:30:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mh2so24292030ejb.8;
        Sat, 17 Apr 2021 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xfofUqGW184RoX+HJlYABRYXL1WMbu1EY10rrB3ZnHQ=;
        b=Ium/YVGKp3vWIeN2GUFPBLqBAhQ+Wfwwp4G+dt//qxoFNibjceK2x8kD3S09uXSkad
         s+ehi2o0Wiqq5CJuEyv6Qa0V7izN9RLOee7CnKMhefCYbjP0/PHkWLl3OfiZKngeBv42
         58sT+tiEIIO2/xWqj/oSDcMPmqCzjoHcuKTi4j16C42pY1qFmFy38uy0nRTi1zKmFo72
         2wpYajeMx+FKybbGBPmzk3XFJKQSegTgrqBwoMz50VT3WSqWcUfq1p6N1r+vMpTfBmIW
         iHM162i4TddJoG5lszcnqBJ37sRg2Qvggewkv6gWGUDxu99iF+DsoysLCTLgggCRuY6A
         v/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xfofUqGW184RoX+HJlYABRYXL1WMbu1EY10rrB3ZnHQ=;
        b=TUfd9qk5f9sXXgCe1eaG0zV9HsOvQMwDqu+1yLuyffopePOWWdC0DXNfvbj5VYuOKL
         s5J6hZy3dsp1+zsvtQcDxIPnozIG1v8ONzuLauKy04niFJDoDx3MU5Knb0j6hzZuO6TY
         wb7zHdA/TISTXgTFctTpNGPoDDEwKyQW+3o3BVis8j6xwM1cxaB0oJTsb67MXU4stKBC
         T+PSpN2nUjE9K+EfYuLseYrsnBnijsYJC4CqTQ8vl/bFyS3TXmx6wy0zFbMJRN+FW59C
         bI6n2AxlKheyMZORgUGjVIB4QE/y+/U1oG47KBwUM/WK+fQDdBiDx472umGodht+ZcNj
         eyrQ==
X-Gm-Message-State: AOAM530/s56lYmysxt7ohKFfnKqeiQxA5nFBgohS5QMvwRAZ0/ZsrF3O
        SFw0w7NF6yEO3O/6e8wcD9U=
X-Google-Smtp-Source: ABdhPJxgeEsuEz6w/Lu8YQ+IlHOsvGCNYad/N3+Mg/Mg4mYZTtwUge9G7CBAs9b3+epYXvfxNtQ0Jw==
X-Received: by 2002:a17:907:9116:: with SMTP id p22mr12935768ejq.516.1618659016671;
        Sat, 17 Apr 2021 04:30:16 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:16 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/15] dt-bindings: arm: rockchip: add more compatible strings to pmu.yaml
Date:   Sat, 17 Apr 2021 13:29:49 +0200
Message-Id: <20210417112952.8516-13-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

