Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE540B483
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhINQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhINQYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:24:41 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E07C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:23:23 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h133so19768924oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fo5eTbyUAHMaSsOWQYct0Sbh06FrAn9VAuVuFrAy4Kg=;
        b=civ4NdxLkD2SvEeKXS9/qFJGoTwNILe2x7zlhd2cPN30FYHDT7b7SLu+lxAOpNOjqK
         qw9s+1WyVVDzbOT1n8RK+mw1/09tx2ITRHMqdJ+C1kQHoE6qfWpFblc3vFzmKKnXJVUp
         FDtoc2U7px9ZGus0P9UCniHqHkzm3oNJwEWcfffBipgpNywvqwPIzzid03mGOgfsIfsh
         BcDbk7zuyRvDYF3b7rnfbQRz/QN/RdJrtk5JnBMR5yFsrMgk3qzJrCmkb62NyqmR9mlX
         0lkyUoTi9OHGFiORa2anU10xp6mtIFalbApoXB/MVKJ10vpf/140hrwBB98TVXpDpFQq
         Dgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fo5eTbyUAHMaSsOWQYct0Sbh06FrAn9VAuVuFrAy4Kg=;
        b=F83ZV2Obqr5efElPs6iOWK9ycwTUuw7e6Ri6WT11KVlm4qB9n2LnXmnSi/En/jynu1
         58mCwXYcCeb59mnowN3iiyajxD6C1SG0lSBsu6nNvNI7Qbp1c8jgdUMtZHkRPsRgG3Zj
         xIEyim5JP+BQBh+KBRz36d3oh2EloEWkbt0j8j+qhI1GNV0HgMXDO5XQhJYNWHhfRYpf
         TvnTX32aLxkpYMwGQGsAWmBbSc/JbAw6tF5hX2CnmmD35DtOM2dCsqkTJpv55SlMxT2c
         lvyJXTkwcaZ9ADyceTKofZsmNfhHQwEjBmJdfhv4xBuLzbXn48cxzTp1vNMqpHWtzxg8
         9fvg==
X-Gm-Message-State: AOAM532OEfbTMxRGUNLTHC2fbPvZlBbHiCgn9RaZs6g8Xq9M20ITeh03
        OVuBHX+zILvjCUskWFyK8goAbOFoftRoQyCb
X-Google-Smtp-Source: ABdhPJxS+JQL8FT4rErSWjDZ5aKOrGSDsFsVolzZ1IJkj+XOR0Qg8lAS9PbtOZjF93bPUY9ha1HhAw==
X-Received: by 2002:a05:6808:613:: with SMTP id y19mr2069271oih.176.1631636603180;
        Tue, 14 Sep 2021 09:23:23 -0700 (PDT)
Received: from DESKTOP-UL9N8HT.localdomain (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id x198sm2669000ooa.43.2021.09.14.09.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:23:22 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steev Klimaszewski <steev@kali.org>
Subject: [PATCH] arm64: dts: qcom: c630: add second channel for wifi
Date:   Tue, 14 Sep 2021 11:24:39 -0500
Message-Id: <20210914162439.31113-1-steev@kali.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Lenovo Yoga C630, the WiFi/BT chip can use both RF
channels/antennas, so add the regulator for it.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index d7591a4621a2..1b048afd9d90 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -230,6 +230,9 @@ vreg_l22a_2p85: ldo22 {
 		};
 
 		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vdda_qusb_hs0_3p1:
@@ -724,6 +727,7 @@ &wifi {
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 };
-- 
2.33.0

