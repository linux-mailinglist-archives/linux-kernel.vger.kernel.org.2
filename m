Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081B531E2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhBQWqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 17:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhBQWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:34:53 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09FC061788
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 14:34:11 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 100so174256otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1qY5r9Z3a/mo/EMdt37YP9TIpp8gvqH0wcp8KFskVA=;
        b=ypCbFUrXzJ9e7MwrAEKWLRFspEeuU/M2Rj2Dh+IJKNXw+HfWcyHOsJwCX7JdRTKFwI
         xuebPqyQzADc92+qBvp9YCL9SWCOFm8CCJiB7nugTvc3SV2LSq9sWYcHyoKC4lTqqo/V
         E5eGFzNJ1SxSgvQmyX3kqaoCcwY1YUGGANkWGc8uBdHc9XlW9fpV7QRihBXCTxMpSDiF
         imnUO5WJc4z0gyA03kZn0IFMjzwRMbR4d6IeZu0QwpZznJDEOLdTiRa5wpPEQg5GIfIs
         usOSdF4oi8NckD+sptnEGs1LpOC+3AzkfROhO2p5g7gAn9sKF5JNjYFr4oefsDaw2PpO
         G6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1qY5r9Z3a/mo/EMdt37YP9TIpp8gvqH0wcp8KFskVA=;
        b=Q47aguzdHrLiu5WQqZxWbHDiux9r0aPINQ7NO1//SFrd4Fnmwx46J2LbFxDYWU+2w4
         WCQH+50S+Igsbta1hxcMOxVZ2KXZbm6zsvRdhnp1+a2wOyEk4o71r6giPROzTMXUabIQ
         r4msz2Uv/v9RVtjiKHrLzH7JMy7P5znrABP4YtxPugE0gjNB0s1ZNgGd575/DCt+kbZF
         pADXFmt9J/DTY+mup+wUt94Rxgl3OkTBINY5KfJE9HkAAKrzZYJmkWc7p6GcZD9Wj4US
         Vp/oKh+q5jtvSyWRXq1h4GeSNygXHMAIFPXyXrtivRfQQ3uKxrb5dJjSt/NtC3Vts+5L
         daUw==
X-Gm-Message-State: AOAM531sTqEFjMDJCKD+1qV+DfxhI+ZtriY768VSfQ3jM1hhWhDbRda1
        UXWaj/YtaSjlHMnSYizxQ+Xnuw==
X-Google-Smtp-Source: ABdhPJw5Drm2g1d7LBICt7NWdPD4P2Qi6i3UPteyalyiWVgvxGKB4FWlsp2JvgNWSGVPMFgfeZrU6Q==
X-Received: by 2002:a9d:6016:: with SMTP id h22mr942346otj.63.1613601251160;
        Wed, 17 Feb 2021 14:34:11 -0800 (PST)
Received: from blackbox.Home ([2806:10b7:2:8299::3])
        by smtp.gmail.com with ESMTPSA id q2sm686232otc.28.2021.02.17.14.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 14:34:10 -0800 (PST)
From:   =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linaro.org>
Subject: [PATCH] arm64: dts: qcom: db410c: Update firmware-name for wcnss and mpss
Date:   Wed, 17 Feb 2021 16:34:06 -0600
Message-Id: <20210217223406.1422005-1-anibal.limon@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20200108055735.660475-1-bjorn.andersson@linaro.org>
References: <20200108055735.660475-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Enable the mpss remoteproc node and specify the firmware-name for this
and the wcnss remoteproc on the Dragonboard 410c.

Link: https://lore.kernel.org/r/20200108055735.660475-1-bjorn.andersson@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[rebased and moved to use pronto label]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Aníbal Limón <anibal.limon@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 3c7f97539390..8f1ada75d3ed 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -301,6 +301,11 @@ &lpass {
 	status = "okay";
 };
 
+&mpss {
+	status = "okay";
+	firmware-name = "qcom/msm8916/mba.mbn", "qcom/msm8916/modem.mdt";
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -308,6 +313,7 @@ &pm8916_resin {
 
 &pronto {
 	status = "okay";
+	firmware-name = "qcom/msm8916/wcnss.mdt";
 };
 
 &sdhc_1 {
-- 
2.30.0

