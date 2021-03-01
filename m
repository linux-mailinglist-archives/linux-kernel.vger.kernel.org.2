Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D97329FE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574795AbhCBDuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbhCAVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:40:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF7C061225
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so10720457plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2YXFSeXixYB8zUM5VCycjoeNDwItv8NZkkhWlNBgNc=;
        b=ogNOIWyhzVewiAj+Pf/C235RxH6yaxggrI14Ck01MrtgOAAY4u0b+URQ6g66Haspfw
         JMliee/qwuuqX+gziq/276ENgScQNDEN2CntayjhC3fJnxfe06rypc9wMQWGOxG/HtmT
         sWL7zLxYtRhKn2arIsCLN1NcoQpJohwkmZ3Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2YXFSeXixYB8zUM5VCycjoeNDwItv8NZkkhWlNBgNc=;
        b=RkxURcj2wk0dsH9zqRhM7sWFNbvELRJsON/tWR+3+mfSsVI5Mq5dqtPphucUijzTn4
         obbHpdRy+GSoDekwAYO5vVqRGggr7oRqta6B+lgWrJ1NcEvOGBKqB13BblfNwGuxNPwK
         7m9Pfnbv+UoXNJjFrPckej865E7MJDi2hYXVSCPaYbLqGSdx69iYBrmeND0a5pCknVyE
         iVXFuFxG8g5O+sVfa8QYovk9C/lfMs+szogKpyLHs05WV6kpQZp25JxpEeMJQwu+OnVK
         MLYrL/Gc0E7KseGoXeWldaxrAVFeQJ5yIvcG47n5NAspyVje6dAvfjTTRiwAraS9oYQL
         REaQ==
X-Gm-Message-State: AOAM5303dKHNnl6+wDJlOChIPOhB3LVMyQmwqbeBDa4st2LKXCW4o2Vq
        4sWVnTPZ5HuvdJ2QE5J82lPqIw==
X-Google-Smtp-Source: ABdhPJxZxS2ruSSIovAo5LqVTbKuJSAPd4ebyV3vD/2C0QPUBoq/fCxB5zz8iE2s3Xevo+iJ1kLJhg==
X-Received: by 2002:a17:90b:438a:: with SMTP id in10mr869323pjb.165.1614634494541;
        Mon, 01 Mar 2021 13:34:54 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:34:54 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] arm64: dts: qcom: Disable camera clk on sc7180-trogdor devices by default
Date:   Mon,  1 Mar 2021 13:34:30 -0800
Message-Id: <20210301133318.v2.6.I22522b0c9db505ee43ed08e8d5d9e8fe632e7447@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301213437.4165775-1-dianders@chromium.org>
References: <20210301213437.4165775-1-dianders@chromium.org>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 2e5e3a8f210a..8ae9606351a6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -570,6 +570,10 @@ cr50: tpm@0 {
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

