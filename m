Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D9E305F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhA0PD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbhA0PAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:00:21 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48695C0698D4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:51:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r12so3013835ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtnlfnM1gUAXVxSsCOu/wsiGW/5dkOKL2/2b79ivYgU=;
        b=RJuEcSI6cCc0QJ49iSKGj0TOr7ltx1HlnR9TU2LU6KHrj3l810ZPZtNH1AQcQZoWhE
         LzazDEZogfsgn6BHD+RfWEbsLFX2H/O1vt0dACAtGl/nIhJ1LsoPhEnV+9Zzftc04zUh
         +/AZ9k1DJThvm5fhjNxjpcwAR63yy45bASw8VhtDUsgm27ykNwNoXvQRdQm3pS52msMX
         GYsNdNi0dEY1m8pN45i1lnTTpwnA2cmeomquB2eUpwz2MzvDDSiRcBdjwaD1w+K/brZS
         bZlDRCsL3Ob3U6pKRbJ9CqIaVJcLagtATu+yLqrUhgymA399TBlrhLeddcOISzWn7q+W
         qk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtnlfnM1gUAXVxSsCOu/wsiGW/5dkOKL2/2b79ivYgU=;
        b=CMW3ixR6sXVexMXGzCucTDk39flSkFL1GZZdkOV3AxZ18cxngRiMQOP067dW8S0tnx
         VxhHjCrruhDPN8EXzYSp18XabdlAq3zbY2dZ0gk/QOtGnjpiVEK2WDCEuS3p1dgvAxYR
         ABCTWialvUurh59/IMnZWOkONnOGPN//YpTVqxOVpllQjTLPnPqyGwBEST+ksHqDxX0F
         fE/ANS4Lsi5gof2uRn+2Ek/6i3IPAXhUqtPfGskrF6XVqR2xc/Iayh0EXdxzIH/W+ZyH
         EHn3QwRaYBgwO8qXP2L98WHZArd8SVgR4LTRVKfMfd1FfKo8AtS/doT5R2BQSZ5OEM4S
         8WWw==
X-Gm-Message-State: AOAM530yibBj2NgmfWcIMbba4JpzvzKbc7UWP85kuFBCm1k93Geo8+qt
        UbJ8/i/mmvwpA0IvRd5nyZQpgA==
X-Google-Smtp-Source: ABdhPJzdtnL5JDv6Pyd7UzxniWmf/ESKWK6se9fQBojXD8gE7/2Lz8FamOwSEnSEUfSW8XRiWz+MxQ==
X-Received: by 2002:a17:906:a20e:: with SMTP id r14mr7027269ejy.404.1611759060060;
        Wed, 27 Jan 2021 06:51:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:62e7:589a:1625:7acc])
        by smtp.gmail.com with ESMTPSA id ah12sm947799ejc.70.2021.01.27.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:50:59 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        arnd@arndb.de, Anson.Huang@nxp.com, michael@walle.cc,
        agx@sigxcpu.org, max.oss.09@gmail.com,
        angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v3 21/22] arm64: dts: sdm845-db845c: Configure regulators for camss node
Date:   Wed, 27 Jan 2021 15:49:29 +0100
Message-Id: <20210127144930.2158242-22-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210127144930.2158242-1-robert.foss@linaro.org>
References: <20210127144930.2158242-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator to camss device tree node.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
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

