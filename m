Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E12354761
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbhDEUIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhDEUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:08:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B82C061793
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:08:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r14-20020a05600c35ceb029010fe0f81519so4672514wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8aknEMXfHwgN2+JZLeFSPHnrU6CH5XTJuE/06jhcA4M=;
        b=PeMmuOhPfspxHBXQBSuaj+W2sB7MTucUvkDloX4KsqMG5rMb8sTP7aROvNS+Gka7qb
         WUj8as9h5MfSEWB4jkxHpaOVzbN2SOWFTueVB3rObZ6IGLNQUogIhEqB8V9MTjSwZ+vg
         XlUxk5+sCp4l3fhbVpulvFSTrqbGeoV7T1cbaUzOFjfVf50fPGi3FfOPqa83TAXB0/Y8
         WATdKCCeoSZeOOqLCgmJ+LKff428wbCuoZCpWZTiOXWkxaYA/5f+lsLA+f+BD7Cd7Pdh
         vpiR92fJ1S6XBbuCHhJy5yeddomOSuzZ4NI4llOFRZevhS2xNLPghAxoKbj6ow1yEQkw
         JmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aknEMXfHwgN2+JZLeFSPHnrU6CH5XTJuE/06jhcA4M=;
        b=P2pkMyKlH7XE4FprH7jxbpvtH9SgPBCi2r3Jhe7c/TAkE3taFyCR3GvgWVbWBS45wL
         XCEF53A8ty6YtOwTGgu6/n/Gm0h4iOe/xezd2kr6Er4VP67qjZzb1iLyLh7MZp73bkoe
         gchVYLSDQxPO7B7Pk43EKFz/z8OzkieTDyoAxoORI07K6qQQi2G79NY9kIn+m0TI0qbi
         ZhCrM2ytN+9HF5P+3+TdGnqI0K/9Mrta8H5+qMUDxzXcFZ1NuuQ11D1rIFxyvmUT3E11
         Cndq5y9BuxXIj3p165plyrQpWxCnjUBpIRtO3sLun9Lii9VJC1CpIuHE1wAlG52d4nS/
         KATg==
X-Gm-Message-State: AOAM532pw+6EvaZvXl2guL2oaD1+Rg/Zjq0Rfl6wcwpROpCcSiPgyVUx
        HxIhIMSQy/No8nEuRusCdwhSKg==
X-Google-Smtp-Source: ABdhPJzPj8X6QTxHPnI9UzmRqR2H2VyXqprQJZiKTL4Sys9bnTOxc1P7fNfj75aFRhkg1Gxn6jMDlQ==
X-Received: by 2002:a1c:197:: with SMTP id 145mr727322wmb.48.1617653306403;
        Mon, 05 Apr 2021 13:08:26 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id v185sm609420wmb.25.2021.04.05.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 13:08:25 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: mediatek: mt8167: add smi_common node
Date:   Mon,  5 Apr 2021 22:08:18 +0200
Message-Id: <20210405200821.2203458-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210405200821.2203458-1-fparent@baylibre.com>
References: <20210405200821.2203458-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the smi_common node.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 9d765034dfb0..4b951f81db9e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -131,5 +131,14 @@ mmsys: mmsys@14000000 {
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		smi_common: smi@14017000 {
+			compatible = "mediatek,mt8167-smi-common";
+			reg = <0 0x14017000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_COMMON>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+		};
 	};
 };
-- 
2.31.0

