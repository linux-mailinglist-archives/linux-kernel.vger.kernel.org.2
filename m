Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E9354766
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhDEUIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbhDEUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:08:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86283C0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:08:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so6206937wrz.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufQs2y0GBwgw7m0MhJTgtFAbHPutYUxFjCpTMhooQfg=;
        b=MRq1WUxPFgF+Cs5EgYUOsD3R2vpiujpm+kGD9l34xo2KTiFNld0V9y1x5GNvacaVaG
         n9kl8wT6n0xT3lTK9SVx5XeEF9GK2WxYf5bLTuMJtSjpPVsJDHq7iiG1eoezrkeHiZ0r
         dg7sI2ADz9yVJ0oJhTk/DM28PboLllHecZTVQb/jI3USzDiITW+XYI295LuZd/6C37PS
         QcKse72YV/07gLbWCVAlwQ3ThVQOjWotlP9OcB8Jnc4UOiycKQxLRXt0nRWMXVze2hHw
         moPEZ9BUSkXcwpoTYpbnQyncKhkK2KtB7Ga82MR6kbEyXlNXq1r6ooeX+/S/0Peez6VE
         XFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufQs2y0GBwgw7m0MhJTgtFAbHPutYUxFjCpTMhooQfg=;
        b=P+Wzs1SH+w7WHqyAK344d1BIvnP4egYQ1LPLHUUU2huVrF35Eo+1YQ+pbDdcrB56gn
         Q7/1T6XIUg0t7+KSL2+XMkoLoVpjrc/kJqke2U3vRg2gxdHOoGIqWu3KZyLhogEK/VwS
         4q6ctWG7jnIA2FHpg8O9T+qWHvD400kurazk9cN/lJJAnx5HGrBM8PQfi0P5M6ama/oN
         LtmXQz0bqv2DSRQur9K79/Zpn3ATmzTyrO9wjtHRglZdP3fTCK/b8T8k5E8O+nX+VZKR
         71iu8h5LOjYoiyEKCsAr1C1M28p/mudySQPFu6E+EOcCND90k0XCkdWUSfueNqOE0/kk
         9pvQ==
X-Gm-Message-State: AOAM531P93+Yphs4jst2YuKdYFMGRfYqffz5Jndhy40VXbok72Wq0IQj
        HIwIGpJUj+AD+KwyIXoN8UQnFg==
X-Google-Smtp-Source: ABdhPJzEXHOtw1Doi7xuzKLw96hEFfLJr5a0TsJ0YqgqlCvQ2W5ad0fVOww5uP6iFptbJD0eje7BFQ==
X-Received: by 2002:a5d:558b:: with SMTP id i11mr30210250wrv.176.1617653309236;
        Mon, 05 Apr 2021 13:08:29 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id v185sm609420wmb.25.2021.04.05.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 13:08:28 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: mediatek: mt8167: add iommu node
Date:   Mon,  5 Apr 2021 22:08:20 +0200
Message-Id: <20210405200821.2203458-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210405200821.2203458-1-fparent@baylibre.com>
References: <20210405200821.2203458-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the MT8167's IOMMU.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 9b352031c5f6..3ba03ca749b2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -173,5 +173,14 @@ larb2: larb@16010000 {
 			clock-names = "apb", "smi";
 			power-domains = <&spm MT8167_POWER_DOMAIN_VDEC>;
 		};
+
+		iommu: m4u@10203000 {
+			cell-index = <0>;
+			compatible = "mediatek,mt8167-m4u";
+			reg = <0 0x10203000 0 0x1000>;
+			mediatek,larbs = <&larb0 &larb1 &larb2>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_LOW>;
+			#iommu-cells = <1>;
+		};
 	};
 };
-- 
2.31.0

