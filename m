Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967F344FD43
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 03:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhKOCxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 21:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhKOCxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:53:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98393C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:50:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id np3so11584554pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTQKF545WIEv8NdbUMDtNn/xAn3UO8csU7nGyHdHUKs=;
        b=xnwL9CgNsexzlT2llqqeRccotpktnnLwncyi8BsuXEvL21WSAQOjVVkxXGSuHuPgrY
         n5VviS+yG3tw+yMa3OVTG769loAkPMngx5z9F6SsQVf33kJysqfOEM6kEr9rugBe0eVu
         zo/uFKJisuhzpN1Nxe4YsCgLvmYTuukgGz4v/iVJB6bgL5lSwGK4pXF3WUOy6NyVh+Uy
         Bx3ASqLyiQPNw/5BXuEY4XHIbUX+SqDy4a5veOoXw87UUM1mb6T1zl7yMFmwCVlq9CGW
         Eiiqhu1fgjVIwG8BiHAU6A+b3S84H4KY9DtCHDTAoxbCG7j76a4qoOYktGCYEBwpITIV
         3dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTQKF545WIEv8NdbUMDtNn/xAn3UO8csU7nGyHdHUKs=;
        b=qaBG69jSo5vpu7Gq8N4ts83AO3QysJvzL2HxwFbdujbtNc3OHy3pgc28rLMNi8smjz
         1CX6ok7IcEpmAIQQadHSzRNCLFlMlK1bQOxji0pW1lwk1tc9J6FMJoc+YjMJBeL7hqxG
         kUp181LdTngzQIcuANYcKy1P/2RvBMhzBkdKXg/w2PpnIZj9Tg/6R6X3wHgKxaATqoge
         s3A0Vzc9g1sk9FSBrw127YgyL+e83BOfA7yE5B7wdMjrZrzlpVeLn3rPrD4TsEzuYMEc
         Go2nBHm77zibeXBofyukJNKHN85+x9BdOfwzNvVFpZhou2H1YMWj+0d7+8wxqyUttLg/
         w/mw==
X-Gm-Message-State: AOAM530lS9+R6ascKCYtoOBiMVXTQirdCb7y7alixEnCnscuplPHmS5P
        1PYUnCEHgotX20HavhYxEhYP3Q==
X-Google-Smtp-Source: ABdhPJz9lnphc4vhvYMArsSyNpyQN3UcfLrSJp3rtQA5c7BraubLe7ZY6GUT5ZRY0J+4cnlnvi776A==
X-Received: by 2002:a17:902:e88a:b0:141:dfde:eed7 with SMTP id w10-20020a170902e88a00b00141dfdeeed7mr31667800plg.17.1636944649180;
        Sun, 14 Nov 2021 18:50:49 -0800 (PST)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id p19sm14817056pfo.92.2021.11.14.18.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 18:50:48 -0800 (PST)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@chromium.org, philipchen@chromium.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH] FROMLIST: arm64: dts: sc7180: Fix ps8640 power sequence for Homestar rev4
Date:   Mon, 15 Nov 2021 10:50:34 +0800
Message-Id: <20211115025034.8603-1-yangcong5@huaqin.corp-partner.google.com>
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

