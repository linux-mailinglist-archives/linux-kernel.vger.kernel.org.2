Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92E3D8670
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 06:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhG1EHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 00:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhG1EHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 00:07:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63806C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:07:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so2347059pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pks90ivSERYpMZj4hwgFuxICQ3PbMdWHSdug+r6DdN0=;
        b=fN6OB9+rOqF2+0AFhpPtM/haCGqRJ7JsODJOFsCEcERuuTE3aB5cIrjUKdhQwJ8CII
         LVp+mM1J0c/7BLHTLg9gnQhyGP3nQ64G6jaiMP97sFY7vxwaItPm8n+1OvUMvyB7jQfC
         NX7Gls4xWfl4rgH6SxBlHQNP3qk4b4mbNEF98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pks90ivSERYpMZj4hwgFuxICQ3PbMdWHSdug+r6DdN0=;
        b=D07UQ2YLxpYGzF7tIJRUcbxe/UQfKXlMIbvet+ZwdBdBUEAIvQMZS83jnaVtVgnNBu
         48ZQWR2uZnTATD1rVlFT/4polg1P2P/jDJuLSciHS6tw3NVHJQcff//9sOB6V1yjgRLt
         YCOUTRUHWWIIAbF0I6BlvWMBhksSRhViRIy1gdwV7amLC8aPkT8klihIeD7nLW3H4k/r
         IPpStxPetHDQW/ZVmaoZe4Abf1SLnUuBULSTAmbXYWcps+T92erW6fNcGVxOyY/+DaPB
         k3/KMyomWwr8T2kYeFHtIPdFTvYxL0oNvoqq2B9/IMwKXCL/VlAFPyLIfR90gxH29WeS
         rgxg==
X-Gm-Message-State: AOAM532y5TRRKKwMJoSOv3o8LxQkmqG5naiiAi/Yf24uNojTcRAzB1O8
        dfurf94FkVaYcvCi3/NMJkgXVcVhb8mzGQ==
X-Google-Smtp-Source: ABdhPJzA5Yn7qXrzqWhBBZSJiX8eTQpgB2GRbV65UIQ8yec4OJwIMR1tPd7b67aFSc/ImJX+yARX9g==
X-Received: by 2002:a17:902:ab98:b029:12b:acc0:e18c with SMTP id f24-20020a170902ab98b029012bacc0e18cmr21358229plr.10.1627445236800;
        Tue, 27 Jul 2021 21:07:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5176:76cc:2193:9b8f])
        by smtp.gmail.com with ESMTPSA id 6sm5536012pfg.108.2021.07.27.21.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 21:07:16 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
Date:   Wed, 28 Jul 2021 12:07:09 +0800
Message-Id: <20210728040710.2891955-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 1796164fac7e ("dt-bindings: mmc: document alias support"),
a way to specify fixed index numbers was provided. This patch use aliases
to mmc nodes so the partition name for eMMC and SD card will be consistent
across boots.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v3->v4: change commit message based on review in v3.
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ae549d55a94fc..8e9cf36a9a41a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -13,6 +13,8 @@
 / {
 	aliases {
 		serial0 = &uart0;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
 	};
 
 	chosen {
-- 
2.32.0.432.gabb21c7263-goog

