Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEFA3DD56C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhHBMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhHBMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:13:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3CC061796
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 05:13:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t3so17263138plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evSHLz+4lNWA1wocPlr6Y/PTZYLO3lc3/HELCGdrACQ=;
        b=YSApFs5j+k2H73a+L1BNT9+q1XyqgEUnnviS0LX9f02fjTbK8BRORyy0OeqXf+2Akr
         gRQ3CKxc282UmhLCDUaMoWNYAH4s+tHIBAUt+nfSy+8YSj3aWgh9LUUOomOW0YoyDucB
         19bj4rIWcNxSb7uGQ4IBbe2n/FdrYR01+kxM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evSHLz+4lNWA1wocPlr6Y/PTZYLO3lc3/HELCGdrACQ=;
        b=e8lxlwJEF66s0A5Pz2QCDeZCrYmlX2cYbzAVrYLNjL0U0Gi4RZGit2ZqZS8wEVUetm
         64DAIcmioBK8aS1b1Vb+YmSdxXPdxraDbnoIV7n/T1Wk290b8a+TSMZobH5gR/3MFaq+
         +n+8BI/vaX/DGvyMKC7IgSlTw/k04g60Z5SW0mmHWcGd83Mals0ny2CQcUccrPJztBt3
         OekwU+3ln/K+Vpo2J9N2RxtJpsFIj/7P04SMpMnuRbSaPE9i9PdOFwrLYtiks09OgqMF
         I1NHtmyASiK75N6rou2+GDJ7jYLAzsY9L5IbsKFv2okaCCwYLsSIaH72YszbH/V6zctT
         LCTA==
X-Gm-Message-State: AOAM532EjQiRiuUID26BIEg3+AfuktZnNIKxx6a4Q8z152o2xU2E0mCw
        Yr3ZTNcg5mAhIunuPgK4r0+XHokvSdWPuQ==
X-Google-Smtp-Source: ABdhPJyMcEQ1oS5cazN7DJMVgqfk+TFt9nioGxs8aVS0gcCs7ra+9cu8JMdrbm9zXFDO7EkpYs3szw==
X-Received: by 2002:a17:90a:c912:: with SMTP id v18mr16846980pjt.135.1627906407125;
        Mon, 02 Aug 2021 05:13:27 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:cd34:e942:c094:baef])
        by smtp.gmail.com with UTF8SMTPSA id n12sm13435252pgr.2.2021.08.02.05.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 05:13:26 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     wenst@chromium.org, houlong.wei@mediatek.com, yong.wu@mediatek.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        chunkuang.hu@kernel.org, Eizan Miyamoto <eizan@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v6 8/9] dts: mtk-mdp: remove mediatek,vpu property from primary MDP device
Date:   Mon,  2 Aug 2021 22:12:14 +1000
Message-Id: <20210802220943.v6.8.Ib681f06d5189351b7fda0e3dcd6b15f3863a0071@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210802121215.703023-1-eizan@chromium.org>
References: <20210802121215.703023-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is no longer used by the mediatek MDP driver.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d502073b551f..872427748110 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1010,7 +1010,6 @@ mdp_rdma0: rdma@14001000 {
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
 			mediatek,larb = <&larb0>;
-			mediatek,vpu = <&vpu>;
 		};
 
 		mdp_rdma1: rdma@14002000 {
-- 
2.32.0.554.ge1b32706d8-goog

