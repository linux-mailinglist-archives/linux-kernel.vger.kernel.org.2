Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114E1325990
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhBYWVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhBYWQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:16:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B5C0611BE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t26so4775283pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cge3eZalVU3QXwcXD2bh+wsAu9KLGsZ822XLaD+I44Q=;
        b=ZdT47CBacpmBkk+VLQhjQwkHSwrVyrkbBfJkAxdP+sLjX8BnTacysyA5s3BQM8/nT9
         IucaI5xcNVUXpVdZoU7Em0k/7LG7kA4aRW98lSqOHlHyAX8tw7gocXKgv4ssJbLOsuSG
         tYhBCHnjwUc9uPVf9pxYv8EZucpojBexDDlWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cge3eZalVU3QXwcXD2bh+wsAu9KLGsZ822XLaD+I44Q=;
        b=XjRgFxPTVi6I7yDZO63DlPHnmsCJ1hITk37NGEhSM3FLCjT98l0htwZYgcVILUaWBM
         5ifp15gqMbJoCOweL5kqtPVE1S6vzNbz/g4XaxKbjTq7BXIoxn4iFhWkrNGv0z+AanEO
         sgPSiaRDWyGIcKXS7VLWawHFTI1S6QKyDfIYWcDuSX9tfTKPV+n30pu/S8sRe5bxyFxt
         KKMhtOUwS5QMCwdr6qauvyClRcMxdTCtBXUXyaMh23Fr45nQuFc8W1UABXwoIHT/o20/
         9xvkmazDPoTml+ugAQ7P8P8kNdH4lkejKeMzsjImw5NlFI7Am7Dcab08uQ/qZq4KObhv
         xpdw==
X-Gm-Message-State: AOAM5339hH//qagB3jAamkMd431C+ZpkkjKvZkg9EBBKcFI+5SJomWiz
        6J2M9kunpeKN8mYpAA5AM9pHtw==
X-Google-Smtp-Source: ABdhPJz8Wqa7cSKzixSn+t1eySMbGA+fzx4oBzvVxchvAMMViLENivwHfcz+AB0et6Y86QuqLPQ4og==
X-Received: by 2002:a65:6645:: with SMTP id z5mr11223pgv.273.1614291231430;
        Thu, 25 Feb 2021 14:13:51 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:8414:45a5:94c4:d35d])
        by smtp.gmail.com with ESMTPSA id jt21sm6713301pjb.51.2021.02.25.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:13:51 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] arm64: dts: qcom: sc7180: Set up lazor r3+ as sc7180-lite SKUs
Date:   Thu, 25 Feb 2021 14:13:07 -0800
Message-Id: <20210225141022.10.Ia3795e192f5bbe17e6714e45fcb0bf5acdbd4c17@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210225221310.1939599-1-dianders@chromium.org>
References: <20210225221310.1939599-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

Lazor rev3 and later use the 'lite' version of the SC7180 SoC.

Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
[dianders: Adjust commit message which referred to downstream history]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts  | 5 ++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 4 +++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts     | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
index 6985beb97e53..dcb41afdc82a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
@@ -5,7 +5,10 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor-lazor-r3.dts"
+/dts-v1/;
+
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
 
 / {
 	model = "Google Lazor (rev3+) with KB Backlight";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
index 0881f8dd02c9..be44900602d7 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
@@ -5,7 +5,9 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor-lazor-r3.dts"
+/dts-v1/;
+
+#include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
index 1b9d2f46359e..b474df47cd70 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
 
 / {
 	model = "Google Lazor (rev3+)";
-- 
2.30.1.766.gb4fecdf3b7-goog

