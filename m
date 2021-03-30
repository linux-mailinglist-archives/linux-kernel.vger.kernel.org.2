Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3434DDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhC3Bq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhC3BqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:46:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D8FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:46:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x126so11023875pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LuoE4GN3G28a59qj3b0AjCTzyHLDWWgDnhGjPnnBk8=;
        b=mH2J9hJB2gPQAKBnprK9o1OOgRTXXumcQ6JmuiU7O3g8VwxwnjFuJIw/ygQDMZflyc
         nIQ9mwnaWltQjsPTwOKAGLBu9qCJfxL0cVM8/qpyrjuWAQfHhrvMiKK0fPgsSsxf5PWP
         RqgDjkZsBSb7lvc8/pPPCqkwG7XnJYI3QpjVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LuoE4GN3G28a59qj3b0AjCTzyHLDWWgDnhGjPnnBk8=;
        b=nYmfw1aEKCBBvegAK/jZimFwV2Kg+siUQh7+B523BEfByTgxVslPz9wcPUQcsO7Pf1
         MVqVsAXlSTgxjOALM5aXHlvLgipKUNANEegvWTQOwz6ChCv+28k+qHmwS5xkOoYtEqkA
         Wk9G1Ojbrc0Fbd0L/aDFcg+lcdSZMIlyrr1VssDRM4uOH5ajRwwSRVo07Lhja4CbQhPs
         IulxrBLwn54747UO7U5V5R67tYgLrxmcs7PxS0jU+LOd9pxxfhpFlL1mzYmP56DfZ4yj
         D58gyGKY8tZ3EtX0EOBxoxh3vmIXd8YtPplQqitwA1y0JDCf1O4xlt+zlxnk3yO2Hdue
         wESA==
X-Gm-Message-State: AOAM531mleQyHFg5XyfW80vQ43XJiDN6KuBCI7AtBfaApP43iV5jmwKn
        oRvi59GldRHtKLofyUVuSd4ing==
X-Google-Smtp-Source: ABdhPJzLvAnFfM2AnTEqQf8nxNp+tk0H8EWFMpvuNRuwJVNf0TOpAd3SUh0kgr34C+kA8W3BYbNziA==
X-Received: by 2002:a62:33c6:0:b029:225:5266:28df with SMTP id z189-20020a6233c60000b0290225526628dfmr14377043pfz.7.1617068776385;
        Mon, 29 Mar 2021 18:46:16 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:647:4c01:5790:305c:8c84:377e:2eeb])
        by smtp.gmail.com with ESMTPSA id 138sm19138480pfv.192.2021.03.29.18.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 18:46:16 -0700 (PDT)
From:   Sujit Kautkar <sujitka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Sujit Kautkar <sujitka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: Move rmtfs memory region
Date:   Mon, 29 Mar 2021 18:46:10 -0700
Message-Id: <20210330014610.1451198-1-sujitka@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rmtfs memory region so that it does not overlap with system
RAM (kernel data) when KAsan is enabled. This puts rmtfs right
after mba_mem which is not supposed to increase beyond 0x94600000

Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 07c8b2c926c0..fe052b477b72 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -45,7 +45,7 @@ trips {
 
 /* Increase the size from 2MB to 8MB */
 &rmtfs_mem {
-	reg = <0x0 0x84400000 0x0 0x800000>;
+	reg = <0x0 0x94600000 0x0 0x800000>;
 };
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 1ea3344ab62c..ac956488908f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -110,9 +110,9 @@ tz_mem: memory@80b00000 {
 			no-map;
 		};
 
-		rmtfs_mem: memory@84400000 {
+		rmtfs_mem: memory@94600000 {
 			compatible = "qcom,rmtfs-mem";
-			reg = <0x0 0x84400000 0x0 0x200000>;
+			reg = <0x0 0x94600000 0x0 0x200000>;
 			no-map;
 
 			qcom,client-id = <1>;
-- 
2.29.2

