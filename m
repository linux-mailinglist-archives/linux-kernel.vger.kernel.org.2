Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6993B1D09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFWPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:04:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E6C061574;
        Wed, 23 Jun 2021 08:02:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y7so3009204wrh.7;
        Wed, 23 Jun 2021 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3hVmf9aigJiJe+G0nwlGCjbRNQ3NnCl05yym4RSiNU=;
        b=Dqarz+0+st1+sDQaaJCsLBr7OvLopq+iBh64AufUyJt7seHdV2ZNUi9fl16Tfr/K0N
         LZYg3apWXPI+X6UovFLcvG8OGzAE8AkGRUUkI+pxGLmsmVwdx/D8Q+se4RczqLGVqJsR
         7ndxWq+DJRlQxuuUX5+jaWFUTEErGuUYRQzx80MPBxghSWEro/l+xgaoXF9ZSHXmfyET
         e81YpYYxTTVBMLSyoXJkBYI1yR5na4yadhFwu6hp6daG6Op5BkUm5qMvHGOPDdQ3/Gcw
         mnynGB8ZMqn7Hwhz0iToTtbWOyecQ1LXc3uAZH4wZhc6dzhcYhnutvZZ6E7fJK7Tbz6G
         1org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3hVmf9aigJiJe+G0nwlGCjbRNQ3NnCl05yym4RSiNU=;
        b=G+QT8VNOXFUZx+curTZTbu5rk48vmcDR5f+tCt8T6B7a+qR80VLF1VfyE/pel8u9W+
         2yO8yvb9LrP/cbLpaH3puBqWBgNKi1qHZWaj6dfQdO/zqyhwNFTGHIs7l5g3zL3NFO2H
         yqLAD6FDRjVz813Y9q6C2Ye8P2yKloSvFn7cPHa3q6aBMJxrTYeVcwokR+dJ3pHZNNKW
         0w6kdWeq0W74IQSgDgL+RWewnrA/P/UdDLxg969g3RT78DTsdxtMoR12vYxERA3qI4sa
         HVh+KKAzR/bNepibb6s26xBBHH4EKV1tMMXxK1rF6uuwwq6OyqLxgVUNjd/AS87qd1CX
         46ZQ==
X-Gm-Message-State: AOAM533kY4Rn1P4NIfuaru8KIgkEddIITBCfWicY3gbwvOg/d+YSql+K
        7CORf9d+TUOFe5R2qgabcg==
X-Google-Smtp-Source: ABdhPJwR6NAgHi9WhWSGr2ZJf47k7RAykEWoVlHDEM1hQJCl8B5SmvBzxYsqiMWvFytiJYNTsmW3jw==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr494015wru.217.1624460535385;
        Wed, 23 Jun 2021 08:02:15 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id h206sm5954863wmh.33.2021.06.23.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:02:15 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add sdmmc/sdio/emmc reset controls for RK3328
Date:   Wed, 23 Jun 2021 17:02:08 +0200
Message-Id: <20210623150208.187201-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210623120001.164920-1-knaerzche@gmail.com>
References: <20210623120001.164920-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DW MCI controller driver will use them to reset the IP block before
initialisation.

Fixes: d717f7352ec6 ("arm64: dts: rockchip: add sdmmc/sdio/emmc nodes for RK3328 SoCs")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index aa11bce576a4..a0321897bd5f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -858,6 +858,8 @@ sdmmc: mmc@ff500000 {
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
+		resets = <&cru SRST_MMC0>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -870,6 +872,8 @@ sdio: mmc@ff510000 {
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
+		resets = <&cru SRST_SDIO>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -882,6 +886,8 @@ emmc: mmc@ff520000 {
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
+		resets = <&cru SRST_EMMC>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
-- 
2.27.0

