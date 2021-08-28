Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071103FA588
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhH1Lni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbhH1Lnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:43:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC5C061756;
        Sat, 28 Aug 2021 04:42:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s25so13994626edw.0;
        Sat, 28 Aug 2021 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ciX02sKxaW+KjLp+s3okHNDZBthMGDh/mH1d3hrxIA=;
        b=V9AKmYFIV7JdCz7tciME01bsr2lmA9FLBiLCa09DPKevVGPDygozgA8TLqI3eNA++U
         IxTR5IJWgsQAKmGy2JSHTmG3ww2fKMHvgjWervpO+15BDCMGgezfbY2hpa9lcQSTi+ot
         y8kZtCEc67u+YJxUH8kdHJAaE+DisA+49If8EvwqOqlXKf7AVhGB14XlXXcxastjwk4z
         vRP6dSC1UCurgMqtRkWxUQVNRldJR3EPrqrSjUUukaLWPtZL49IDFQrDlefJaduDT3Pl
         XdIkIuaM/+I/BbDIamxWViT9RhbViLpIa0u0B6H65K/o7V0BPByJnZhk/5z2wGhEsBvb
         0Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ciX02sKxaW+KjLp+s3okHNDZBthMGDh/mH1d3hrxIA=;
        b=BUfQq9SD1k3CpJVq8lvNtC6qcbxRbumBH8bB+YeTYTtC+Gt/Iz/H5uwMA5Gvl0bD24
         NvSsM7ss/jVKV9rqTygFAFtuSlHI9M7uoboueNNkx2iZZDRwOSujZCFRdlFN1sfxGgDj
         hlFvmbcCoIuFQwtouy60+o0mMxWLXfbN9sbUldtklEyXT0IehTwBgA7FDAX1VhpfGv6/
         A4Vgakh8l/qRmWIA5iEEOddVTW38WVUr9jSEdVpzjeZimDeUbkIA29psJFt1/NdAhNBs
         gQwKAuCjEi+jeb1DksveOJ2x5xLLOLVaTFF9bBpoKR8qAXnCSL4d2YqujqN9/sPcSNPr
         AdPw==
X-Gm-Message-State: AOAM5333FY70VaFwHOrcO2QdYfgFxj/nIHYeme4TeuFjGHc31bAXla1f
        ots7bAEaKN02Fyn8xZLO+is=
X-Google-Smtp-Source: ABdhPJxXvjZLvMXdKIomq2YJq7EFB2BI2ZlLHohbN0UqLAGKOI8RbvgVeH9b4sOcOtPK1viZUstnmA==
X-Received: by 2002:a05:6402:1c8a:: with SMTP id cy10mr14752604edb.112.1630150965957;
        Sat, 28 Aug 2021 04:42:45 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v1sm4286639ejd.31.2021.08.28.04.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:42:45 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: change rv1108 gmac nodename
Date:   Sat, 28 Aug 2021 13:42:40 +0200
Message-Id: <20210828114240.12231-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rv1108 gmac node is checked with rockchip-dwmac.yaml,
snps,dwmac.yaml and ethernet-controller.yaml.
The nodename should have a pattern: "^ethernet(@.*)?$",
so change to nodename.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 140434384..668fb1513 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -557,7 +557,7 @@
 		status = "disabled";
 	};
 
-	gmac: eth@30200000 {
+	gmac: ethernet@30200000 {
 		compatible = "rockchip,rv1108-gmac";
 		reg = <0x30200000 0x10000>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.20.1

