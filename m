Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB56325979
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBYWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhBYWPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:15:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF57C061222
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:46 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t11so4757205pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zwBjkMJGS+IZy9ICNLfkk+HUIUBip1htcidFl5tiVI=;
        b=I9rrQuSWljAocoj3aBTjQbt23RCc4NWStkE1NQQWHcvcOTMYCyqueUZpcAUTf+1oeM
         TwERyBQxNaMYn8RGasiE4K38NXr1/3sd5hoC93g7jgAjCDssvI0Zrm8N+H/5ywoBd2Jf
         SrxCEa7jtXwradokv9npIYFgQ+ZPLmQMHMFQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zwBjkMJGS+IZy9ICNLfkk+HUIUBip1htcidFl5tiVI=;
        b=VCfWL8lC6R8gMZM8CLHx7P4UzdneJKBKrv2oEKGfSuXdmpoGHDHWGiEVH/VVJAI3Sv
         BpSBgn66JXosQ9dwEwMRWFQGxNeAH/Zeqe4Li+GVrluVtmPv3kseqyAv1boQ5005paYv
         9I83YoJHkDokdAfwYdXgypWbgKgDRsbbYB4t13Xs+024HIPRoBmx/mxQhQv3QU6z3WNB
         V8/V6YNmlOCQIkIayqbVkA/uFIoNnFqKgxHU+0ppSq+GRbZu+VHaPjBjHDRlntT4TUCS
         YIBaZZLKCkKYeqPhzwIXbn/OM5yiqMAyjGmsXil4Z4rzcBtub3SxP5R0gJc96af9t6IE
         9XFw==
X-Gm-Message-State: AOAM530tHH9IPR5evbPc4FTTC4vK687Yp9TssE9Sec3mA1mXc7ouB/RG
        mOv8ucQqNXxRsvFjI9xtmP51Eg==
X-Google-Smtp-Source: ABdhPJzPwuxhRV7o3IjGNASfZ9IF3YgqtfSTyEPkoaLmVLbNt7x4brgGIBQYDX75FCqFVH/8ItV5wA==
X-Received: by 2002:a63:4761:: with SMTP id w33mr60066pgk.118.1614291225926;
        Thu, 25 Feb 2021 14:13:45 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:8414:45a5:94c4:d35d])
        by smtp.gmail.com with ESMTPSA id jt21sm6713301pjb.51.2021.02.25.14.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:13:45 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] arm64: dts: qcom: Disable camera clk on sc7180-trogdor devices by default
Date:   Thu, 25 Feb 2021 14:13:03 -0800
Message-Id: <20210225141022.6.I22522b0c9db505ee43ed08e8d5d9e8fe632e7447@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210225221310.1939599-1-dianders@chromium.org>
References: <20210225221310.1939599-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

We only want to use this clk driver on CoachZ devices. Disable it for
all other Trogdor boards.  NOTE: CoachZ devices aren't yet supported
upstream so until it is this is just disabled for all trogdor.

Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
[dianders:adjusted since no coachz upstream yet]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index f3a99c801582..69bf600e1c9f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -568,6 +568,10 @@ cr50: tpm@0 {
 	};
 };
 
+&camcc {
+	status = "disabled";
+};
+
 &dsi0 {
 	status = "okay";
 	vdda-supply = <&vdda_mipi_dsi0_1p2>;
-- 
2.30.1.766.gb4fecdf3b7-goog

