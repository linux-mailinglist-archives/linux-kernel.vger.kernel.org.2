Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E873C1D79
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 04:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhGIC1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 22:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhGIC1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 22:27:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46ECC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 19:24:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d12so7372778pfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xa1QT/xqQMd9LJuGZv9EOkrq3F7P8S0t9twyB2ttUeY=;
        b=Ih95Vv7sGBr3BHG6ejkyqiWc4YDQyURZhb3iXOesOn/6nVRUGD02x3zezztxDSoXIx
         /blNBqXk6teH1HU4a19/wFKgte5ugaHIjoIJ/D5hjezzmyzoh9gyzR69lbWcotcReOtE
         uyXgu7sa8Vcqj7G+hDzfGwLazos/WY4PQO3+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xa1QT/xqQMd9LJuGZv9EOkrq3F7P8S0t9twyB2ttUeY=;
        b=kjBp8pYA05oltaKBLgnyW5gRC0FGk4d62AxitllEwaEpow47m7S/gwddzY3US0hRn8
         3IC1qjHuX6rFuh/GQHV0SANTNY+RQAgeAcINPWyFlXx6JJeKt4MtDoEMOjYPnRvhRbEU
         d/16lGfiG5sK8ldYrPYeVG+vtBR8dD9vqL8MlSX7KKB+yUzQazVCps5JuL+p8b45yo3A
         DhNFe7RAhgVFvr8BlPhivxUYhLTbkX2Gjp4BfWqrgLS/Sfm9/sFXde26MIvhea6u7owU
         Spgvy6XL7G001ortS6s1Mg/n4hFI02O1SGV+WRO8Kzrq0LuRk6bDNmY3Mtt/Dv9gYpuP
         gEHw==
X-Gm-Message-State: AOAM533n9jLm0da+948+ew9Uo4k5sIAZc0KALSWyxFoygPsomRWrGVAt
        5uJwGiH5t9kl+WoRNsRAUC+7qnFW3NZ/Iw==
X-Google-Smtp-Source: ABdhPJwZbjcIIk5gkbelY5NVALNeX+vFLNHPUdir3ykq4PvaBeBKBcrN8a8sMY7S44A1UhZJpupjmw==
X-Received: by 2002:aa7:9436:0:b029:30b:30ba:5942 with SMTP id y22-20020aa794360000b029030b30ba5942mr34190104pfo.47.1625797475039;
        Thu, 08 Jul 2021 19:24:35 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:d956:2966:7910:2bd2])
        by smtp.gmail.com with UTF8SMTPSA id z15sm4791808pgc.13.2021.07.08.19.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 19:24:34 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     wenst@chromium.org, chunkuang.hu@kernel.org, yong.wu@mediatek.com,
        enric.balletbo@collabora.com, houlong.wei@mediatek.com,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 8/8] dts: mtk-mdp: remove mediatek,vpu property from primary MDP device
Date:   Fri,  9 Jul 2021 12:23:24 +1000
Message-Id: <20210709122040.v5.8.Ib681f06d5189351b7fda0e3dcd6b15f3863a0071@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709022324.1607884-1-eizan@chromium.org>
References: <20210709022324.1607884-1-eizan@chromium.org>
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
2.32.0.93.g670b81a890-goog

