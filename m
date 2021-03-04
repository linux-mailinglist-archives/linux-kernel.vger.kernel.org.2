Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC732D295
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhCDMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbhCDMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:07:03 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA82C061221
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 04:06:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bm21so30060174ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 04:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45F+RVQGNOeOIqHAD42S1RQW90kRIpbUumPYEAuK2qw=;
        b=YbaOEWimUScRLtMtmVudJlYtARyqJDuzL0rzBNhn7Exjbmm5rh0ATdHRSXPgI1AO+o
         d0sPkSaxndAbEJsGrLZ4OmA0yxXh7haRztLEmNv0g9YNdkOvz/6+9MJnJjrdwRVftrIC
         UeQg2pApUq668NeWCEv6TvUHS6rD1EOVAJD8QI5AssEA10/1c5vuTEzIq9LrTnOsoMR1
         YPvZ4NU+laCR30aVOBSwQtV/5a4m6SdazuY9T5fvfpPhDZGxQZXdMfBinraqph5POU4M
         5443qpvAy5/AxcvACAvMNCOTafjxi6lD5uFoTIc1qr2dPjhhaLxHzYDQxfADyvMEyhzY
         oyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45F+RVQGNOeOIqHAD42S1RQW90kRIpbUumPYEAuK2qw=;
        b=sctqsAnJXj6VAcoLlhx0rfT8mSSEh6BMWC7wn7SUvpgfEuc4IRzbvxZJHxQSq6s9DD
         GXh1RvUGaGBLSxx//TgdBMPbhsZjZA/RHMogrc+VKToT4w8AYuL+Zgt141IWKmO0LHG4
         i+sUG7VOqjurK6/1Q4Bb9FPG7P2+xMHv5lLe9BVXjqTU1aLrOU2Kyb66W3hFM6rAjDGv
         m7vtfJzYlwTsaLqrQ/ByjqADn9SrjI7SiGP3BEe6VQli/cuYgPs/igw21+ENE2dZIxc1
         DL7PWF68Ta58rSr09iRH8/QURNNZCFnb/cNCaCNHBOtPk0H4VMQXTG7XzbSbtsNLcbMT
         kelA==
X-Gm-Message-State: AOAM530JEnu8Vv9euVbx7oJumw2r7wsrt/YMf0tOiLyehD3wUWgrGFBR
        V2qTCsR4CxyEz+9BzoiG6GhHIw==
X-Google-Smtp-Source: ABdhPJzW3QIh+CAEbIAYrDqqYMaGNPCc7KvAEOxiPd+BpOa8ivSgimxSb4CWVwosCOvnKUejs28biQ==
X-Received: by 2002:a17:906:13c4:: with SMTP id g4mr3920304ejc.390.1614859566562;
        Thu, 04 Mar 2021 04:06:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:470a:340b:1b:29dd])
        by smtp.gmail.com with ESMTPSA id cf6sm20464447edb.92.2021.03.04.04.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 04:06:06 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v6 21/22] arm64: dts: sdm845-db845c: Configure regulators for camss node
Date:   Thu,  4 Mar 2021 13:03:27 +0100
Message-Id: <20210304120326.153966-22-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210304120326.153966-1-robert.foss@linaro.org>
References: <20210304120326.153966-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator to camss device tree node.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---


Changes since v5
 - Andrey: Add r-b


 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index a943b3f353ce..5842ab65789c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1106,6 +1106,10 @@ &cci {
 	status = "okay";
 };
 
+&camss {
+	vdda-supply = <&vreg_l1a_0p875>;
+};
+
 &cci_i2c0 {
 	camera@10 {
 		compatible = "ovti,ov8856";
-- 
2.27.0

