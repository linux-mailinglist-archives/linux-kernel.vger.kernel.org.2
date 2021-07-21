Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3D3D1791
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbhGUT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhGUT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53ABC061575;
        Wed, 21 Jul 2021 13:08:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so1654766wmq.3;
        Wed, 21 Jul 2021 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Axto6lQ2+nrph0X1bVranPKMH1bIvsVkx0NZvngC7c=;
        b=FGd5xGSWm0HOZejRS1CKbRrRfp4f9OHkviymUztPGVbz8lkVywuQ7yhPIRWCEZpgMZ
         a7Ds/jC9ijZdOXK8sSDPMWNa3mTlb7Qm9XCuszQABm/J1XwZ1f3vjPYYUfYOSTe32Dhi
         7vIRno6xrQc6v+a0RDvfAm4Qc1hdjD98etLR2K0ydNSAKFVKxUQyQTBj0D9KRWfHDbwm
         +UFsh+smhf8xmlElCwoQgwchFZV3mgzQ3I+lcUWPoiMsduK240RGJMRHzs8bCPHxX7Ew
         jVigodWydTAnkGJhcZAM96eMq6QLeonxEl46oInEw6TdJe851er/Ic8848iiDAojuQKR
         z9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Axto6lQ2+nrph0X1bVranPKMH1bIvsVkx0NZvngC7c=;
        b=n/zBQUsdjjmeSmPxZZwb34PXWTmgDICebmNRdM0YoVqxvJWlRfOH3uP6R3hk/SBEpi
         vgMaYbSnV9h/AuYB0cims6TbrK/MKtQvfhbfrsl9v4hKCwmCbncGScKqAMe9MtpE9RSq
         GTYSvofAcI+esg+vZKlCkuu0s/v16vjpsf4L2LlQWVyS8xIhRHxBQs7L6jL6hTCMgd1U
         Cy+fPFhCidUZB7733SnG5WuSaVFg0nQEMvLFHlhfKmCqZOC3A5H+rN207qv6GpY4cEnc
         ZYeIuwObecdn9dvkz5TPY4EJDMO+PKqyVgjtL2oioIaqvHEOOj/myuk76FU7L1kvkB34
         YDig==
X-Gm-Message-State: AOAM531uRn1rZD35ILqEP+w5Emb7vkTt87v6ecZbv3ORgKVXjuDTUL3y
        kW2X2R6QtITb8oUqwhF9XUM=
X-Google-Smtp-Source: ABdhPJxRAR2ME7BbdLUxY5mKNVXe30C/6s/O5OXZ4H9yrWvG9+kuPhZAAzOgl/uqFIZxl0lirjWmtA==
X-Received: by 2002:a05:600c:b47:: with SMTP id k7mr40127576wmr.155.1626898135054;
        Wed, 21 Jul 2021 13:08:55 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-46-198.static.triera.net. [86.58.46.198])
        by smtp.gmail.com with ESMTPSA id k24sm28927162wrh.30.2021.07.21.13.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Date:   Wed, 21 Jul 2021 22:08:32 +0200
Message-Id: <20210721200832.916644-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210721200832.916644-1-jernej.skrabec@gmail.com>
References: <20210721200832.916644-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 has 32 GiB eMMC. Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index a1dd8f472cc8..c23b7c37406b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -98,6 +98,16 @@ &mmc0 {
 	status = "okay";
 };
 
+&mmc2 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc1v8>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.32.0

