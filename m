Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680103051CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhA0FQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbhA0EzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:55:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95660C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c132so767912pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmjtKFjHTUarfxu+lL0d5qeXmAGAmFw4kcflRE2ZaXY=;
        b=XVJOs4QHR+H8Ih7yjKd1WM+pL+RphjK4kSpQF56nU1UIDdoY4eVpUJBR+38H/KTHxX
         XOL9WxZXJ4wxzeZTNLjOSM8OHbxUX2yGW2jF36pKr07LRDZRMEtwZOFKRvZ6bxssZkyB
         wlRYopNtHq5PMiRl1z7h9tBkOMavw2nH1ad1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmjtKFjHTUarfxu+lL0d5qeXmAGAmFw4kcflRE2ZaXY=;
        b=IPrsiiXIn7k9sTNHeN6asTGJ7e7pYCg7oTlyIr1vSpbZlB9gKDlah0o2mA2W6Z+He+
         3gsg9iCZUM2BKx9uSifseO3msbwZIeCnNR8UZs/9EIDAPxQ0rANnikRPTRvDD43TpvZa
         TBefQS/3aiMCDHcj4H30Lb1CJepI6uVtuKNoHfzVCQoKXL2eb5xUHj28W0bCHg14UTCX
         Ks0rRJz4FfKWjwKnY0b+lpW8Kaooshu7yg8a2w3dCReBnNg8CqbErDu+VJ/PHaUAfx0I
         JN6gQF5ZQHsz8HIdcynVcvpBHNtuC+YxWlhLvWs7qJLH5G3beRivprmwbHJ8IsMlQPcg
         pBwg==
X-Gm-Message-State: AOAM533fZwFg5vmgEFPPZjeQqom+DLhNWkuFq10NYKZ6C3btUg83ir88
        Cb29r+NWPCuQX9NQQK9aXQljVQ==
X-Google-Smtp-Source: ABdhPJx4yF5Zj6KuoOFQLvTsPUKYfKrEzTHR49F4EG7T/rAXtxPo121Qzb4bSIV+4HFYyIAB7z9ATg==
X-Received: by 2002:a65:64d6:: with SMTP id t22mr9164071pgv.42.1611723274151;
        Tue, 26 Jan 2021 20:54:34 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id a141sm684484pfa.189.2021.01.26.20.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 20:54:33 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v10 1/9] arm64: dts: mt8183: rename rdma fifo size
Date:   Wed, 27 Jan 2021 12:54:14 +0800
Message-Id: <20210127045422.2418917-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210127045422.2418917-1-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

property name must include only lowercase and '-'

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
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

