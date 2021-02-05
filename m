Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8303109C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBELDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhBEKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:55:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ECDC0698E6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:45:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m1so5529780wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtnlfnM1gUAXVxSsCOu/wsiGW/5dkOKL2/2b79ivYgU=;
        b=AMjieip+i8IyHf+fHPKCAqXPvt2zmy6t8q3fKSH337KjeyhgBkoERmTqMjRhO7jR2Y
         7NQ+gwbxnrLSOCbAGfyQhMdy5gIl32oxauYqb2b3tJYUOTy8FnqPgJ6/+Z85+L2sNoV2
         +djNzR/IETaH5kGTzVjgFMInmKUC23fdVCzqwjEELq4ZupZFDBqS35gak0FWbNFQV0H1
         9m2OFmOyhpjF5sRXvE42uXmKz7asU/xNGQzjFleTaOE9YW35S6d7yBMRZkdy28lt3gUC
         ZdwIiExQaqBgKlJ4Mrg+R3sG40lBKX2d+yQsAFtshEdpQKyVPXQZHp/nSS+qKUL3wWpc
         /ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtnlfnM1gUAXVxSsCOu/wsiGW/5dkOKL2/2b79ivYgU=;
        b=bC+TMB1JYLcGw5pPjRPJwzFoGd3xr5rsVKVQ2hXIVTQqCdOb75WxPG+Tnc7sdfBqvX
         DxboFJOj4Qq5+iDnSyPi5irLwDgRteCsF0aSZaXcCiEZNLj4b1SBE+5/pdy27waAZ0cu
         K8GFuSqps3yCZrk/fK9aQS5473S7Z3JvzCyd01b9OMZwFc7z7Nd+2hD9bXo8aQNs0eeg
         C1agotqm0i5HuFcTAYRiuY9meuCqZgcc5k4VqvukIV1IczzAbQGOPikfiUU+KBVw4wiz
         rYgrtVDoHzxSrANk84SOv2z+HmTFM+1h1xRI1K1jnKdkBC1ASir9vwqqaGr/AMSRW8vv
         x43w==
X-Gm-Message-State: AOAM5300EnkB1xujZcUrOOlnlY23OefE2edlvCQbEH9jYxChGfbqCCKO
        0FDE+Lcfna6+b4xSzPOXNE7ysQ==
X-Google-Smtp-Source: ABdhPJyPmX9Sl9XA4LzpOD16JxKn1WN7DDMPq7VRg5MRcd9VexeiXGL4nCIJqznXMqqPJ9kcyoHrXw==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr2989205wmj.57.1612521928986;
        Fri, 05 Feb 2021 02:45:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:38fd:e0db:ea01:afc8])
        by smtp.gmail.com with ESMTPSA id u4sm11300233wrr.37.2021.02.05.02.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:45:28 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v4 21/22] arm64: dts: sdm845-db845c: Configure regulators for camss node
Date:   Fri,  5 Feb 2021 11:44:13 +0100
Message-Id: <20210205104414.299732-22-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210205104414.299732-1-robert.foss@linaro.org>
References: <20210205104414.299732-1-robert.foss@linaro.org>
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

