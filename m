Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903AC44FD52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhKODFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhKODE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:04:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B45BC061766
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 19:02:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so2549894pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 19:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTQKF545WIEv8NdbUMDtNn/xAn3UO8csU7nGyHdHUKs=;
        b=KTR1gjsiglaMRgP/7eQtLxW0PKTm6j+UrgdfSMdVyf7zz5QsSkvRO0Zh3L04t5aPeO
         nJhDNMyRqxCwH/qujK9VJtoSWsqgwGHf2BxFuebhcUFY8qnixgSlBoV370HLRDviuI8m
         YtsfHcyV9Vop6JlS9+9zCbsro5QqtCrto6mbGgEN7AFf1X9z4s+Dea45FHxVpfnUn3Kn
         DA20xb0AzDeinywAb0sOy1+SIjPEk6kf2IOxI6npkegNKeYjrF8PdHmTemxuDwIx0Nud
         SkUYy3OfjHSpdYI+95gPACxbzZ2DQQ3q0fd1bY73bjH/IVNhAlUJ4V3jZC2dM1pcZFPy
         a57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTQKF545WIEv8NdbUMDtNn/xAn3UO8csU7nGyHdHUKs=;
        b=OVKsgE78vomIHSBJjRPc2cBW5JTAQJ4lTQtUrLeVrG9oy3pdk27jJiKw/DhQevT93j
         qqMWZWKKgzKLL8FtrN2oaBS6FkNAwdawMw1mSFtw/sshMgWjQuTXdtnJm4xqBYkHrQWO
         oYdNnfKnX/x32Ti43LoqTVEUsmOPNhD4wwB9f/8X/LYn0SEKTePvDem5fP8uzoVyvF0j
         mjsh1C8AqBh59u4JxSle0V62LZd9Y/UgAzJjxBE4eBscqqTr3YlEIPus5LvYfM5rUVXH
         DZFlZeCuUtuWTodpauvNYLzvo3bkZoX9k3aUFxOAB0oNGxsfMs0MOVwy0VxUbg/PEQlA
         BSOA==
X-Gm-Message-State: AOAM530f9U4yHTPXB1rh5cDv6V4A+3WCyyoDYpG8vhIXLeGFI/30OYKC
        DAb7qx3XWDHoCoXCgjisz8usVw==
X-Google-Smtp-Source: ABdhPJwQ0EOqOL31j8Wqhc+LAHhYt2fcvFgI4lRQO2/c0y7AoYkzEsYOUhxC2qY3akhJL5KNWYw2aA==
X-Received: by 2002:a17:90a:9294:: with SMTP id n20mr41537292pjo.69.1636945320760;
        Sun, 14 Nov 2021 19:02:00 -0800 (PST)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id hg4sm16696068pjb.1.2021.11.14.19.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:02:00 -0800 (PST)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@chromium.org, philipchen@chromium.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH] arm64: dts: sc7180: Fix ps8640 power sequence for Homestar rev4
Date:   Mon, 15 Nov 2021 11:01:55 +0800
Message-Id: <20211115030155.9395-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When powering up the ps8640, we need to deassert PD right
after we turn on the vdd33 regulator. Unfortunately, the vdd33
regulator takes some time (~4ms) to turn on. Add in the delay
for the vdd33 regulator so that when the driver deasserts PD
that the regulator has had time to ramp.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
index fb27106bbb4a..0de0c97f5728 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
@@ -15,3 +15,7 @@ / {
 	model = "Google Homestar (rev4+)";
 	compatible = "google,homestar", "qcom,sc7180";
 };
+
+&pp3300_brij_ps8640 {
+	regulator-enable-ramp-delay = <4000>;
+};
-- 
2.25.1

