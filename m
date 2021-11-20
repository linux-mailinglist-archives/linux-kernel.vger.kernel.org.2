Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39480457C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 08:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhKTHir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 02:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbhKTHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:37:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717FCC06173E;
        Fri, 19 Nov 2021 23:34:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so9208035wmd.1;
        Fri, 19 Nov 2021 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AdnhaQhzfGCZNq/tu9wW0n+da9d5ZXWaDiFgN3D1ig0=;
        b=AML7rh3/uPAl+zqRmG7YQFDf8fuylqlF2+YRC/reS0GFrRBeIoRh+pbHtlUIOgdR21
         Bh0fWatFQZWjahSp26vrv6Li6jSTZwMdSHwLi52m91rPaP4H0dhr/tJF0jojow6zohYW
         ipxtj3XuXQmXtG3AVwfWP2j3M4uz9vgipxbaVJBPVwbRrtj8ppOf+JcIvzAjBeEtN1Ch
         ujb3bCPNEbcKLhtv6kA2mGitKVvftvcOD711eTPVUfEzqkJnCq61+0vIv7iThvKbFgFY
         SH2ByDZfFqG8lGnbwAqHP9T4rHkOL9KdNsuhgHLLA6a4Tl7+nSsFl+iRXiThI/CFKwa0
         8OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AdnhaQhzfGCZNq/tu9wW0n+da9d5ZXWaDiFgN3D1ig0=;
        b=W/xOa2Wsxs/+Phe4cjnNBtKmQkYBEinyj5eoYn83FDwE00eDEmptuJgluLfA87yo+s
         KtBxog/V6GVWrDNZwDk1KMagRQizAg3YLVoGMapzBpn2ejP/X0g25D6vDpfdCmn9sZdJ
         nF6cR2e4gQm7TJjr/yd3lfTfOJNpxPWjT84adH6pnZkog/nBml6Y8HapaeqYmLAAifj9
         oWYQhU6+f8i1Asdrb9pD8l9/71N8iFDsUvIx2K3PmWFGg9R1SCwgQWcC8ndIDTlOeIZj
         cusqfzZrnvwkq3jL2+9lB3C1URYWMrC1G7C0b8U9524p+iSc+jL3PqSLSwumhlA31rE9
         hjMA==
X-Gm-Message-State: AOAM533tddSf7t1uVmeRC9RI2HROmeiOxDHRyOTN1d9HgSSy5bgRuNff
        kEvHuaMKLVdPOHXTRvZJxEA=
X-Google-Smtp-Source: ABdhPJw0EDXD2g6MUp3ag4xl2QcO+EC2a77rBd/hj6pxFRbbup6+sYCfeMb3J0ikgEdF4pjc9Exxhw==
X-Received: by 2002:a1c:f60a:: with SMTP id w10mr956018wmc.53.1637393694006;
        Fri, 19 Nov 2021 23:34:54 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id a141sm13776345wme.37.2021.11.19.23.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 23:34:53 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] arm64: dts: allwinner: a64: Add CEC clock to HDMI
Date:   Sat, 20 Nov 2021 08:34:47 +0100
Message-Id: <20211120073448.32480-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120073448.32480-1-jernej.skrabec@gmail.com>
References: <20211120073448.32480-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Experimentation determined that HDMI CEC controller inside DW HDMI block
depends on 32k clock from RTC. If this clock is tampered with, HDMI CEC
communication starts or stops working, depending on situation.

SoC user manual doesn't say anything about CEC, so this was overlooked.
Fix this by adding dependency to RTC 32k clock.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 5ba379078500..741bd19fa8ec 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1220,8 +1220,8 @@ hdmi: hdmi@1ee0000 {
 			reg-io-width = <1>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
-				 <&ccu CLK_HDMI>;
-			clock-names = "iahb", "isfr", "tmds";
+				 <&ccu CLK_HDMI>, <&rtc 0>;
+			clock-names = "iahb", "isfr", "tmds", "cec";
 			resets = <&ccu RST_BUS_HDMI1>;
 			reset-names = "ctrl";
 			phys = <&hdmi_phy>;
-- 
2.34.0

