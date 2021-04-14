Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3F35EE78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349687AbhDNHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347766AbhDNHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:31:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:31:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b26so8008691pfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkE+tUp6UsBCCxbBvu8r9DHfy7MsyvFZbkTXtiMUc7Y=;
        b=gii7RoZ49IIoSWVe1COL5vMS71V3xnCWPJjnK+lTr1qBusdSeBx5/8V+yzGPc/g/zW
         36Jc8phM8bogF+m/VxLxaLnMholBZ0tvVsteluUatQPvkfsoFzOGONobtt3BLX6J7SGi
         UfkrMpW87Odp4LZFLp39NCQ85WAcRNbQYM+Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkE+tUp6UsBCCxbBvu8r9DHfy7MsyvFZbkTXtiMUc7Y=;
        b=OJ6DZ2IxoKv70TOaUHt1L4IL9NY+CxyAHVE+plifuK+Ghm5zKlKTojtH5QGyn9kJjv
         bZY2pxdeP6RH32+vYU2OPG09cBIFgVs68joeOjOso4wSu/e9P0QmxPAtnClULqy1uVEx
         G20FSZPKsVcnOWGe7rrtsqEIRFXNSJnnAOxBnwfcGqaX41Ucx7j/j6gqVFr7+sZEqj1E
         +dL+A7dtm7F/qNVTBj/o3n7X2BsdQOc8sEciWz12vmxIVIbuFLaPEm8rYVyD/rqz5Z/4
         OskZY/RItUeash8shh2AKH2SCda69a6Rx8gQAeR7fN+BagI/wQvfgZlYV1/dqYvfUoVE
         VpyA==
X-Gm-Message-State: AOAM532FCR84Aom9OFxmfFz1b59Z1IdFsnSFqGTxNUbCqL0kC2mu67j8
        REX44Sf27n8R9ky1fkfIh8YGiA==
X-Google-Smtp-Source: ABdhPJwEGnEqaexqjkmF0jnwqOT/4IqXEYg+VEHsl4HeRmez+g7eLeJt2uCKLuvltEbqrAcE2HBnew==
X-Received: by 2002:aa7:83d8:0:b029:249:79c9:fd49 with SMTP id j24-20020aa783d80000b029024979c9fd49mr19643098pfn.72.1618385473359;
        Wed, 14 Apr 2021 00:31:13 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:bd66:f13a:bfbf:21fa])
        by smtp.gmail.com with ESMTPSA id w191sm15632757pfd.25.2021.04.14.00.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 00:31:13 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: mt8183: Add power-domains properity to mfgcfg
Date:   Wed, 14 Apr 2021 15:31:08 +0800
Message-Id: <20210414073108.3899082-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mfgcfg clock is under MFG_ASYNC power domain

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

Changes in v2:
Fix a wrong power domain reference (scpsys to spm).

Link(v1): https://patchwork.kernel.org/project/linux-mediatek/patch/20210224091742.1060508-1-ikjn@chromium.org/#23997681

---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 0ff7b67a6806..64813634c3df 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1116,6 +1116,7 @@ mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
 			#clock-cells = <1>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_MFG_ASYNC>;
 		};
 
 		mmsys: syscon@14000000 {
-- 
2.31.1.295.g9ea45b61b8-goog

