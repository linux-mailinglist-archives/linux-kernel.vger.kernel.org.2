Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9E45A14B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhKWLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhKWLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:24:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6586EC06175A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:21:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so1839170pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq8nc34v9wy9BHUcdNCchv5TcJtzwaMW4yDN1UOKTXs=;
        b=JpDT/+FDBCbI5IBaWeaKfzyOwUUOyTt+Vw1ovqm0zuzKZZrjqWO3dJqGL1pzmsZRcz
         WEzphSwzny6i8imySPh8owk0bZ7mV09ROF7m2cIZELwxwLD3zWFbiIveEf0Sy/YacdFK
         n/sQubJ/NkmPIgp5pbeN1xtI08xQWQungcwqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq8nc34v9wy9BHUcdNCchv5TcJtzwaMW4yDN1UOKTXs=;
        b=ysbtpZYcFb2q65adDslpV2//QR/INFg3hmI5cxO9bI6AwnEfeKTXRt5IDE9j2/tS+C
         kYSgQeAO470kVmBEB87s2MtF86MetTFyh1v4jbausSl9A4TT9pUPD4a/KHTCMDx6gEZZ
         K/LTicjmU3+AnC3BPmij+hwrIstmLewN4mew0uXXd7I2ANuemrq/+16AkbgG+5/MOI8J
         aRsc0471owuJ0SNXftLyNn7IwJ6CZJCtX2jkS+VdRY23GCk2LtvfZTApwmiCqdOvAFJ8
         QQGk1F9dVYC4an9IP7lpz0FwfmNNX0+psZXXvxZXxO997YS7s/THG4NSyapkpt/pArf5
         Tb4A==
X-Gm-Message-State: AOAM532mX95WbjgohFgwce3ukUbvqKR2+BGBEaF76Pz44Xs6R3TM1/tR
        R+QZkG49u3a8To9tX6i3hkOHsg==
X-Google-Smtp-Source: ABdhPJxp5J8vQC13ZWDo2EQlaskUNOPku9PaqV5etdp5QIpELJ9fUxb88Pk4hXN6hRe8tLOckb6fGg==
X-Received: by 2002:a17:902:7d96:b0:142:87dc:7dd3 with SMTP id a22-20020a1709027d9600b0014287dc7dd3mr5260273plm.11.1637666477920;
        Tue, 23 Nov 2021 03:21:17 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:d1ae:c331:ed2a:15e9])
        by smtp.gmail.com with ESMTPSA id 63sm11093914pfz.119.2021.11.23.03.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:21:17 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        - <devicetree-spec@vger.kernel.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, senozhatsky@chromium.org,
        tfiga@chromium.org
Subject: [PATCH 3/3] arm64: dts: mt8183: use restricted swiotlb for scp mem
Date:   Tue, 23 Nov 2021 19:21:04 +0800
Message-Id: <20211123112104.3530135-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211123112104.3530135-1-hsinyi@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use restricted-dma-pool for mtk_scp's reserved memory. And set the
io-tlb-segsize to 4096 since the driver needs at least 2560 slabs to
allocate memory.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 94c13c45919445..de94b2fd7f33e7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -109,9 +109,9 @@ reserved_memory: reserved-memory {
 		ranges;
 
 		scp_mem_reserved: scp_mem_region {
-			compatible = "shared-dma-pool";
+			compatible = "restricted-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
-			no-map;
+			io-tlb-segsize = <4096>;
 		};
 	};
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

