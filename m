Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF73A3EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhFKJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhFKJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:13:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A5C061574;
        Fri, 11 Jun 2021 02:11:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y7so5233799wrh.7;
        Fri, 11 Jun 2021 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDB2i0wBVPcnS2u+xI1ot510mox1TR01qapW1qdqsus=;
        b=Y/wtqMxO6uLJ8+X1nLzSXuRctHIazuvsQV7LapvxjsQTQOIbuFXeZxKHMAlCoIidM2
         2XyygutwS1R6NDxQEQvw12wGMHQtX1t6ET8arrrIvKNt5QGbHDebnxp9C3Kqe1o2z19K
         h60HckMCAsF1vRzhLhWXWxj6Si9WkekzEOuwzPAkjgwkWMSdDQ42EATBd/LF2t6Cfh6F
         X4dvjYuAmn8H3cqvw+/qQnYwI1Hb49yW9lcMR4SNe0S43g5OHvONsyR9RGWrEDT9Mf2j
         9DmjNi34XAyCQ6e3lBZiMN4aoNz6fIrwWOTxFF3ufhLC0z14iFXPtXYR664QuaB2k2i0
         grXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDB2i0wBVPcnS2u+xI1ot510mox1TR01qapW1qdqsus=;
        b=moJ+6+QtgH0o85sXSC9hRaq5RoPVc6erdaR8vVlAFOGOqWOxJUaHdaKqiIiFceBzOD
         6qvzUDWPYE/VZQc7IClp5u5tJiT2nWhctzmMvVX2/MaGMkYCYlXJOvQCyLIHNa5ZiQMR
         XQbrjsf2WSwkgqlEEKAy1wuAv0qYZSr5ZbQ2SerYpRHlQMNvliW8jGQiBK7zGSQl6ElZ
         GS/rW7kfj9iSSl5df/1PErSPfPiBjo2wVNQfzZhZObQKY1E94eF1XRNVtBHDfFFmQAB5
         6EHu7wM5rU41YOjAXa7wvtTN5j+ev1/J/x5s8OEwq701z9aCnaOQe5qqBH4S5jIfvyGX
         +wlQ==
X-Gm-Message-State: AOAM533e9rs9kItOuRZkHf0TtrycNRz6XNxG6HY9xABVrFv42HbWWdEm
        Zj2KCbtdugj9Jza6DhybHqU=
X-Google-Smtp-Source: ABdhPJxEn2YmsWM1t1hNM1Y/ksni5jQP0dcxtjx6goiQaEfTMDJljhKXzhtw28E90xJkPK+YNpVt1Q==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr2948003wrt.218.1623402696642;
        Fri, 11 Jun 2021 02:11:36 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id l13sm6667737wrz.34.2021.06.11.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 02:11:36 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] ARM: dts: owl-s500: Add ethernet support
Date:   Fri, 11 Jun 2021 12:11:32 +0300
Message-Id: <222ee0c2cb431619f558dce9726585ac92f65e00.1623401998.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
References: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet MAC device tree node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/owl-s500.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index cd635f222d26..739b4b9cec8c 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -324,5 +324,15 @@ mmc2: mmc@b0238000 {
 			dma-names = "mmc";
 			status = "disabled";
 		};
+
+		ethernet: ethernet@b0310000 {
+			compatible = "actions,s500-emac", "actions,owl-emac";
+			reg = <0xb0310000 0x10000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_ETHERNET>, <&cmu CLK_RMII_REF>;
+			clock-names = "eth", "rmii";
+			resets = <&cmu RESET_ETHERNET>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.32.0

