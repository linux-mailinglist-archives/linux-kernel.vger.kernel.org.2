Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90F397A53
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhFATBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFATBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:01:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F91C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:00:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h12so7382024plf.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d70mWsIG9EaxVCKWsokKSvhrP1b5Ectf8KCIC91GlHM=;
        b=JQQazUOBGRua3zTuzOQeUQ8DRK6EQpuJmBVaIAhAcctV2/I23SVlW1qX8sLyKjhRd6
         TO7y0Ab1zc3CYU/t1ii7CBgGjzxOw/O+3hXg3v55J+37emS9eNyHV9LqC7S/f+cKuEcx
         Vajipcsu6YfZPmQHoQNCR4r+/YK/x/I6y6ouE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d70mWsIG9EaxVCKWsokKSvhrP1b5Ectf8KCIC91GlHM=;
        b=tZ6jrgSy5tJ5ggKvBM5TNKCFGKdtXZpvE17U+BY0vkgLgbQpuebfTPLs4jxGjQ3eXP
         X9SCKZbG0D6xugAqUD2/L2e2IB4jJufSMGsf/77zA5FzO3fu3S287CzCQi/Yiyph8jec
         8V0GX9IjxnwUm/6m7+AEWQPzy7eSDchRb7ACORqKXTWYzT6GovVH7TAWg9E9dhTv3uGZ
         d4fxfMMGt6E3JEu2k2wCFD5Pt41UGcCJtRM1jFckcw5Q5JIWVzczPlww05NtVu+AJLRn
         Mq05Ydrqedr9YTgWALevXzc3WBWvx4hI/IbhyBM/aqNaVrwotvZTpqM+UuMMCiKXn5Df
         BI0Q==
X-Gm-Message-State: AOAM533KylN0n7ckyZoSeckxrgDUxJUSYMu9ReF55msx5CkG8AD9ApwT
        F74kaJC+YEs7f4sg9GMCl5TIQw==
X-Google-Smtp-Source: ABdhPJyE5vO18OlwMKxn3ult3kWG1P3QdabymJEaRkG4o+qtMD6kSLOjI56Zf7Oc0krRYtNHhCRBWw==
X-Received: by 2002:a17:902:e007:b029:ef:9dd2:be6 with SMTP id o7-20020a170902e007b02900ef9dd20be6mr27303658plo.12.1622574002315;
        Tue, 01 Jun 2021 12:00:02 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ee82:b2a7:c8bd:18e7])
        by smtp.gmail.com with ESMTPSA id a10sm2709753pjs.39.2021.06.01.12.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:00:02 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] arm64: dts: qcom: Remove cros-pd-update on Trogdor
Date:   Tue,  1 Jun 2021 11:59:58 -0700
Message-Id: <20210601185959.3101132-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This compatible string isn't present upstream. Let's drop the node as it
isn't used.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 24d293ef56d7..c134feb02eec 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -564,10 +564,6 @@ i2c_tunnel: i2c-tunnel {
 			#size-cells = <0>;
 		};
 
-		pdupdate {
-			compatible = "google,cros-ec-pd-update";
-		};
-
 		typec {
 			compatible = "google,cros-ec-typec";
 			#address-cells = <1>;

base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
https://chromeos.dev

