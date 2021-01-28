Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE83074A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhA1LYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhA1LYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:24:02 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1313C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id o20so3806559pfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eu89qGTwFP4V4tI5Jw2nlSDAYSqs2MPYZr62DflexSA=;
        b=SgW66yAVGV8jb7+r6die2alQTgr8PtesUGVhZcPTecXyX/E5hBS2Ng19+xBk3s3wRF
         YEGIZI4ON2g5fItWvAfYicr70oPSzyyijhgAWNJN+Pw7f/gLrWeSdXxM7f6Os6dkNEOJ
         j/IbwTnZPELR78RUVDitb8Xtgm/bpCMvzteK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eu89qGTwFP4V4tI5Jw2nlSDAYSqs2MPYZr62DflexSA=;
        b=fL8/CDN4bc5+A/fGfxGqDFvd6+GBQagEKYb8NwD6YW4kjRPnySHLXFbI9FUnyjfvtH
         RazXAFa2lqE4+UVkvtBWO65fE2nEP+x2zD17gqOzQG2WKnVw6KygW751NsW/GflAOzxQ
         Vp8gKulpfknXyC9j40fioWezVkZicpCWlXG4kK7jLS8x/b3D/DWvdFgeWQOR/zu80CXJ
         GIuJT+Gx5ydpPTLV1rwY39msTsN7IvtYnqZp9SR57mNCqsGR6flM8tEwH0f/wCZGRyZ1
         4H78mafsZ4XdhhmbGUuUdEwG2Ueuqutl3LKL670lVUMvoItuzZHHLDUgpVrO/BmYMYff
         rQfw==
X-Gm-Message-State: AOAM533RxtFgJCAP65PuyuZcipq/lZ7kEGTixkPe0Zdad3rhe1C9k7HU
        uGHkoiYi49SRgy2HwJvGKhDqLQ==
X-Google-Smtp-Source: ABdhPJwKmdmcbE9OPMHzqr5LpAToRYhlpvlfYvavs0v6LyeSvK5TicG1LDmjwxq+HPL1qIux1oN53g==
X-Received: by 2002:aa7:93a2:0:b029:1bf:23a3:a945 with SMTP id x2-20020aa793a20000b02901bf23a3a945mr15462516pff.70.1611833002370;
        Thu, 28 Jan 2021 03:23:22 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id j198sm3138315pfd.71.2021.01.28.03.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:23:21 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v12 1/8] arm64: dts: mt8183: rename rdma fifo size
Date:   Thu, 28 Jan 2021 19:23:07 +0800
Message-Id: <20210128112314.1304160-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128112314.1304160-1-hsinyi@chromium.org>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

property name must include only lowercase and '-'

Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5b782a4769e7e..6c84ccb709af6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1011,7 +1011,7 @@ rdma0: rdma@1400b000 {
 			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
 			mediatek,larb = <&larb0>;
-			mediatek,rdma_fifo_size = <5120>;
+			mediatek,rdma-fifo-size = <5120>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
 		};
 
@@ -1023,7 +1023,7 @@ rdma1: rdma@1400c000 {
 			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
 			mediatek,larb = <&larb0>;
-			mediatek,rdma_fifo_size = <2048>;
+			mediatek,rdma-fifo-size = <2048>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
 		};
 
-- 
2.30.0.280.ga3ce27912f-goog

