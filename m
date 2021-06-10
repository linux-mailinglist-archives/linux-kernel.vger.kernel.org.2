Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA453A357E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFJVLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhFJVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DFAC061574;
        Thu, 10 Jun 2021 14:09:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l1so1257089ejb.6;
        Thu, 10 Jun 2021 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAZcz+DwiPgsJv8w/JODrV0BpE2FfY50vdCDOY0uLFE=;
        b=mAAzYoXggxf6zO3nrr8Z6cRU2Z5ht1Z0FpXUA/0lFucbR/d3i+y4DC6W+nMal5Bxr0
         ILSxVhJ7vxeBbr7Jqj+LB79xmsVWrg0kPCTHwocG7oowki21U+02BTUjntlrwjumQJgb
         VdHWP6QwGFpLxta0UjqPOIhbvmvZ4kUi2iEg9HpNwBw/XLE917cfZqd0eRVzuV5SZTj1
         Bug7+E9EKvdwtW3pXfDWiAUAwaxLvs+VVyvkuUggIH1Z/DcDOr3jeWSw+fNPRqxK8n7X
         FDh0b0KtkRWkJRUoBcUxBjGtFH6Uh5NZbBiK83XTBzbtt1wuouWQPUVKdg/XlTYoee33
         Gryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAZcz+DwiPgsJv8w/JODrV0BpE2FfY50vdCDOY0uLFE=;
        b=Vt4ff4fc+fnJuRLHFM8LQPibbNm+p68qpEF8S/0CR3ej1tbmRSNtQFuPwbLxqU22Qt
         F3YI4qkWEwD2LDLhSfFY4zcjba1hNRvsznGd7FcJD8IWIZBJRML42eCSycPXaRrErxxY
         pAVpEsgGjl6TTzj/dQOw0H1FIqOAguPTLTL5KxH7mlqC8hSJJ0Nu8G4qR7pXvBBGR3LJ
         X9aIuoH4vYYjS/vItq4prV2cywZy82uMMYNVSckFp0U+bRdHsMDfc1A7zpXx/voqDNPu
         cIatbhGHdTr3ot085pm5mBSmXYy/RMGbHxWWYimOI8W9TSa/NurWqjGHHth0RLgxujE5
         KaOA==
X-Gm-Message-State: AOAM533BdM4DDPNCzK2nf4QVe7iJ5hyBYVnak++YC6hSBqcdFG9Q98EL
        SGqg3Di3feb1U6dKW8y7guU=
X-Google-Smtp-Source: ABdhPJxWvYXXeJzoNiHFJZ0cXn8JWB1fnf6okrGg5W2EtzXq+DmAHe8KY+QxFf1nBDi4/z53Km4zfQ==
X-Received: by 2002:a17:906:8345:: with SMTP id b5mr460073ejy.14.1623359365911;
        Thu, 10 Jun 2021 14:09:25 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id c18sm1836294edt.97.2021.06.10.14.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:09:25 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: owl-s500: Add ethernet support
Date:   Fri, 11 Jun 2021 00:09:21 +0300
Message-Id: <926456e8a3700b257605534cf711a0bfb667fc36.1623358117.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
References: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet MAC device tree node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
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

