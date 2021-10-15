Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA442EF73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhJOLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbhJOLPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:15:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF79FC061755;
        Fri, 15 Oct 2021 04:13:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t9so39409963lfd.1;
        Fri, 15 Oct 2021 04:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSI5oUUXkL8OiMsYr9YZBaNLQBQQhatS/MOSPJ3+9wg=;
        b=gJWR5ocJpGyJ1rfcWDdYR43oHq+aWAa1Fme6AHiJbTqUSSo4BusdfozTCw5qv5Be63
         KSClH0AbCFmfVB/9Z3MltgnmdoHEhPyx6MY41gc8LkLCYeGDtYsR9HBHEaMfP73EcayH
         Ji3/L89ZrSk2QnVWfUDSZbqaNeuDxeJADv4kYqTf3w2Y4EROEHJP6ThomtlygFZ6yoOr
         N34LPXYwB70QNTwLvJRp+okDqvT4oaoAx2wjyOeslde9jtc+zfzyjNxU3p0Tq2CmrTtd
         txaAFgp34lZg0AsRgmo9Buc/JL9JHot4jSlIRFf3Ex4MHaHHzZY4JfdmSH/l7IKsviHp
         r3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSI5oUUXkL8OiMsYr9YZBaNLQBQQhatS/MOSPJ3+9wg=;
        b=3Gd0eVE/uZ232GFeauu/7WlJ2IzTqHW9bF9azRh9DmtTkvvy8l6VEqbuESzbn40Vdf
         y/toLnXT5h5KSXziPCCoZA8Xv4FjCacfmJPvrjkc4tFOFzOUTbaWVCfd0Wha8sBaFOVN
         xOTL+cTTMYHSIyBhjyrUSul/8bCNI+PXbh1ohz3Q0/q4v3YVbevOwooHoGL6ywdhlRmT
         AfNH5VpAOJVOnmvqsXAL3kMFrMeu7+kSdopc6nE3ogHxs5x5WDRQMY6QrYqL4JOvKb/K
         6BIDpfkqoqGqC/YSvrzdSnl5W+ie5Ah3JYyMosL07p095E4kcQH9QB+eX884YxpY3Kgi
         /S3A==
X-Gm-Message-State: AOAM5318IxLl7xaFTUj86IkPYsyqzmqiel37OYLMLXLDWWRbnbWD9dhG
        unjsddXGFfavKO/ccEfVLBc=
X-Google-Smtp-Source: ABdhPJw77iypYK9/c3uV5UaLuCOp2Nt1OGbb7nWeNVQ88UZsY4IQoCm0pPU1HgtX2gb74GRrjdfB6Q==
X-Received: by 2002:a05:6512:12c6:: with SMTP id p6mr10393057lfg.40.1634296424290;
        Fri, 15 Oct 2021 04:13:44 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id s25sm534647ljd.63.2021.10.15.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 04:13:43 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: enable spdif on Quartz64 A
Date:   Fri, 15 Oct 2021 13:13:02 +0200
Message-Id: <20211015111303.1365328-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015111303.1365328-1-frattaroli.nicolas@gmail.com>
References: <20211015111303.1365328-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a244f7b87e38..d272839405c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -58,6 +58,25 @@ led-diy {
 		};
 	};
 
+	spdif_sound: spdif-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_dit>;
+		};
+	};
+
+	spdif_dit: spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+
 	vcc12v_dcin: vcc12v_dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -458,6 +477,10 @@ &sdmmc0 {
 	status = "okay";
 };
 
+&spdif {
+	status = "okay";
+};
+
 &tsadc {
 	/* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-mode = <1>;
-- 
2.33.0

