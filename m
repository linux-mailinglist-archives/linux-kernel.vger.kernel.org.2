Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080283A3AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhFKEFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 00:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhFKEFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:05:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3719C0617AE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 21:03:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j12so1403456pgh.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 21:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8NTjSTyDbstdRnS22JDnlh2GM3XC/zF1/Aj3ovyt0Ug=;
        b=GknmA9cuNibjqKF8cukI4rUCo+B6fVFFXRyPcRKfLjX4ZXbTFbCl6gWfshWkURvf84
         EvbRrBCv+iiKrKfsCmSPKE20I6McwpduzhDQ4gfI/sotqwG8MS70vsQrBcMu48EtoZte
         QmI35afo4IbvUL//F1J6XMpC446kgR7PkfVXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8NTjSTyDbstdRnS22JDnlh2GM3XC/zF1/Aj3ovyt0Ug=;
        b=PCzVRgOq37ZxsQztBHqcj+0hoFm92KMuTKrBhErRR0/uQaRaBmSPDXU0ZkU9tmHQoP
         eY1YKqux3j9tUb/JTGlrSfF1N7Q+lWTSTTONXhFAqPG3fiF8fozc5wu+UhPMdRaSkMAg
         QUpfFLvFgzZxywTjfCBx+pA5j+/HXqjpSMaBZiCVrnMGtiOPJQBFqWpJ56sRVkq4o+ht
         TaAMFqWrixNoD3VW3wm0CzW4rNIb+OQCIvhffFmMhUDm+7fIJ2TPwNpMs5jvA7ZQx++E
         Gf8HtJ8ESpsl6Ec7P57HO7T9ikQUhAN7Qv4AFg1zmtyLfSKFS3Mp7Sd71fOZ1xA3M++Q
         nuIw==
X-Gm-Message-State: AOAM530qY2wkzuki8LtGJ/2Ysycv61hlE4WWMJiQN5IAbZ3K9wMHm8SN
        PItNnSMO4UiX64PmhE8n/uHssAhOO/q2n19z
X-Google-Smtp-Source: ABdhPJygCJuW3iIEdkZVUkAyJQQoZ3+nFNvq3EnLuT+EJTj7D6lLuOFZJ9Gosw6bD409Elv0aczATQ==
X-Received: by 2002:a65:528d:: with SMTP id y13mr1648004pgp.276.1623384183064;
        Thu, 10 Jun 2021 21:03:03 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:db52:e918:e5f9:9e14])
        by smtp.gmail.com with UTF8SMTPSA id a25sm3599170pff.54.2021.06.10.21.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 21:03:02 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     houlong.wei@mediatek.com, enric.balletbo@collabora.com,
        yong.wu@mediatek.com, chunkuang.hu@kernel.org,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 8/8] dts: mtk-mdp: remove mediatek,vpu property from primary MDP device
Date:   Fri, 11 Jun 2021 14:01:45 +1000
Message-Id: <20210611140124.v2.8.Ib681f06d5189351b7fda0e3dcd6b15f3863a0071@changeid>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611040145.2085329-1-eizan@chromium.org>
References: <20210611040145.2085329-1-eizan@chromium.org>
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
index 814f56d59e2f..4020748ae446 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1055,7 +1055,6 @@ mdp_rdma0: rdma@14001000 {
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
-			mediatek,vpu = <&vpu>;
 		};
 
 		mdp_rdma1: rdma@14002000 {
-- 
2.32.0.272.g935e593368-goog

