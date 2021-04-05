Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160CE35475E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbhDEUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhDEUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:08:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C73C061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:08:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a76so3013980wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzJH7Fk4Fc61upKjMDDFY31BpQ2CJ0Y/l0pKp7AosC0=;
        b=mODRn7zvxl0fGW6yidpUQBRF97c/OL+PBw/eoFfwBcpqF5W6k26SYTHEjDXBWxi2bT
         TYQyvSBlDlFu6LSvRqq+gQjAU9sJUS1Zn6f2p1Tr9SysGLQ4OHC7YzjwSFZfzKxq2Wv4
         7Mm7oIyndndB6lp2nFL1eEkyv1MSQo/Va3rEgZ1FORGHaDQPTLWNbWjjBpZH1xwjp3dh
         BV3cygGjErNUadI2ZyLGiFNdNDcSXX6n4WEFDdMsDIF4NhrJvoeWbby2EUzII+U6wFZV
         Sbwb1vq8Iu9eDwYQruPqUY99gvUvcY9/uPRlPEWwU+UoglD0GmSdPuNw36McAhos1TXr
         jdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzJH7Fk4Fc61upKjMDDFY31BpQ2CJ0Y/l0pKp7AosC0=;
        b=dv5BJBw5UJDaAKzXLkHs9CiuQdtCa7U5hIXnpLLNdDRznBtTd17NNgrfXCGl/UOLFa
         7yO8SuRPy94kx6Y3R4KNDmeOv6Jn5g3Yvy3TJuXrfzn+soLkdqrLS58sGpSSDbkHFJ8P
         iPMRHHiSAFhMMDdGtW1mKWeoBhij3Gaf45/wW915sQrFHG04hjmaff2NqjoAFSrPLhAp
         vnSCVyYCvpdNaJkM2oEEkCQQRV3LXcDPTQkBJlzjnu2Iu/I0KXANPFmJfoy0UhcpxQQC
         BmgWibLY8Qurl2bwDFK0axDOez/uzgPtyAUqHoUZMPB6b0NrBTc86pl0Uh3tdb7SsMtY
         710w==
X-Gm-Message-State: AOAM532bi1mzT/PLgBzzM4Sl+iFA6R1TYz9C9Ffwoz76Ij2Ce1s9svxQ
        pRCceuxpGLqvWFSLvmfZ+vQ/Ug==
X-Google-Smtp-Source: ABdhPJxjoSeWcA1NNDsqV2aXCmphXzWc6o535OR+3DoQcmV5mwnWNxuP21QvzdZfY/H1pw/6atiHKg==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr717892wmc.6.1617653305072;
        Mon, 05 Apr 2021 13:08:25 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id v185sm609420wmb.25.2021.04.05.13.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 13:08:24 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: mediatek: mt8167: add mmsys node
Date:   Mon,  5 Apr 2021 22:08:17 +0200
Message-Id: <20210405200821.2203458-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for MMSYS.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 156fbdad01fb..9d765034dfb0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -125,5 +125,11 @@ pio: pinctrl@1000b000 {
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		mmsys: mmsys@14000000 {
+			compatible = "mediatek,mt8167-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
2.31.0

