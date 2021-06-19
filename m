Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822243AD9EE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhFSMRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFSMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:17:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15901C061574;
        Sat, 19 Jun 2021 05:14:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n7so13915485wri.3;
        Sat, 19 Jun 2021 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tT6MCWeV6BQgvZ+j2c2HpQ6MvhqUDKTfYP31/O4QO0E=;
        b=M2tK5P0N53k4gpKaGXAvDVOyf3Sb8I106WxSOuZFf6MFNbfCTM0P+HmkAiUkRqy7yS
         aq/jOkBMjrsBC5mBqil/wjupkbT6lKLc9rJ2Q5Lj0j21TbESJD8xI1ks0QBn+pySnDCN
         eEKrSOsaLJAEOP+MKYcYLnpnXbg3xDOEHq83DOK2d3MCKwpXiveSGSc6oGZWjYj43qug
         CQwuQGIBQDib59537sGyy9nPJi6Mqt0Q8/mQHR+QV96+Ai4fGEjPOVpOxo/JOUP+4Lln
         t5mSX8ry7c+SzN9+YIyOZeYZT+o1N1nZXGsi0fckk2EGvK5L/RlVI0edDrG9W+4W0Yzo
         uPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tT6MCWeV6BQgvZ+j2c2HpQ6MvhqUDKTfYP31/O4QO0E=;
        b=a/ep+/hJht2CHPY6v37Az9SPDCAdZtZ4q9x2uwEecL8QixTD67794Qd92yCYNFmmv5
         cirEUrbY1DLcIL0iccf2ZS8BUEP4sAi+2d3o5wVNPPgrKUsbc+Rh0ZoO88r33tAkEqrw
         9tinkV2/XjZlHqZaU9CYRtIa0hTJQ9pu94jegIsM1u03ou+8qMy6JVC8wCqgILDr+Cba
         PR2wYcul7yEErkpUfxsKl+/nNo82fu2BXolgADCCcLkkxNzkzaedzKmy+AGmLgCNfh3w
         OEEILkWv9AkXeDaUXqgjHCGFiiF7tvDS9qbcvLCfMRRuew1cRxRXL8NlGZrBeGl8ePqx
         3SMg==
X-Gm-Message-State: AOAM531Mzbzdfz/3pVDgdUSDRBSrFBFAsw97NTmvHdxTTWz9RDMLAnQ1
        +gjqzpGZQA1cUIldztVgyQ==
X-Google-Smtp-Source: ABdhPJxUiGMu5WBQ4VXfWg8B7qQiq6uUEWS0R0e+kZAw/OyhE5FL42QCsnsvh8hxnZs/yDUKybmLyQ==
X-Received: by 2002:a5d:5108:: with SMTP id s8mr17806912wrt.311.1624104893018;
        Sat, 19 Jun 2021 05:14:53 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id f12sm13818512wru.81.2021.06.19.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:14:52 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Re-add regulator-boot-on, regulator-always-on for vdd_gpu on rk3399-roc-pc
Date:   Sat, 19 Jun 2021 14:14:46 +0200
Message-Id: <20210619121446.7802-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This might be a limitation of either the current panfrost driver
devfreq implementation or how the gpu is implemented in RK3399 SoC.
The gpu regulator must never get disabled or the registers get
(randomly?) inaccessable by the driver. (see all other RK3399 boards)

Fixes: ec7d731d81e7 ("arm64: dts: rockchip: Add node for gpu on rk3399-roc-pc")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index da3021dc0ff3..8b27ee4be755 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -494,6 +494,8 @@ vdd_gpu: regulator@41 {
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
 		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc3v3_sys>;
 
 		regulator-state-mem {
-- 
2.27.0

