Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18A2455BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbhKRMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244675AbhKRMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:51:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A4C06121D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:48:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r8so11311509wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aVyUtXcdz7QxHPyS2w5eETDfqlriTQ4tFPGsRNeCcvk=;
        b=jsGazaMauv2TecWWXLkP6S8jRjHZznKOjVjOeVhS/pU/XPUt8hkqz7OLE8r4CZ1Qas
         V/Jtg6IoYtIN50bm4AmEim5ZgKnuvi/FOX2TLByiht1AonUE1RpI26Xe2uMWsHXxiy5V
         H3ovhF1ZNBIOSeaievDIj9Xz5PFIg79LTClu54/9uiw42Uhmg+U4RZQic0CfPbgaP0O2
         bsal2fwyyWD4v2as0Pc01xGo+yH2yeGZ7GNDfCSb3QpsX9ttLOQ/m4G/tSZPkrBqzqw1
         Ob9JlSBiYabb/7drCJNoTJfcLH3QAT4/66mZQStuAYZbjgbxp4WNtftKucjXGaSJ18V+
         hkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aVyUtXcdz7QxHPyS2w5eETDfqlriTQ4tFPGsRNeCcvk=;
        b=mz4TkvbJNlsA1aUyaq2jy107ovbVxI8t7DZB/giXr04KmhT2ecMlYBpLzyv39Boyhf
         ZR0Nv60MgB6hyxvOUuY1kkz1cNvSeA3sgPJHhZ9nIpQUnac/CO4Nstos6pWGYi+KlMy2
         WwoW9bUuvEgOXBw2Ah8GbUQAnNyK2fLY/Gb2NgIEN+cGzIh1a+v3ym4tWLPkfKIQlFfE
         6qvFnKwjHlgIZ1xKmF/ugnTFzKfODO8hzFmmw/Q66NLyErYkBq0I3Rgw8qkR0o8zE2Yf
         Agb2NFSV9ubKVDmZAZXEDo7/29rx77W6ONrOSLa45K+1i/eYrPVC46+XkyoDdcb9MYVw
         w8lA==
X-Gm-Message-State: AOAM531/bMDvq1v8BnS6jIeJT0VxZl6R6k0PQGicaYRhx9Zw/AVlk6s2
        xhkrDBZ0b+cbYqqrQ2/tw1gfkw==
X-Google-Smtp-Source: ABdhPJy2f9DtCMg4OcWFm26oWicRoIZWvNHJN5PRI5t5tNCVFSVpy0va7aFjALpPoOB96q+7/vwBVw==
X-Received: by 2002:a05:6000:2a2:: with SMTP id l2mr30092829wry.110.1637239706601;
        Thu, 18 Nov 2021 04:48:26 -0800 (PST)
Received: from xps7590.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id h2sm2955635wrz.23.2021.11.18.04.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 04:48:26 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 3/4] arm64: dts: qcom: apq8016-sbc: Remove clock-lanes property from &camss node
Date:   Thu, 18 Nov 2021 13:48:18 +0100
Message-Id: <20211118124819.1902427-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118124819.1902427-1-robert.foss@linaro.org>
References: <20211118124819.1902427-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-lanes property is no longer used as it is not programmable by
the CSIPHY hardware block of Qcom ISPs and should be removed.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index a5320d6d30e7..b7a578aafcbb 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -253,7 +253,6 @@ ports {
 		port@0 {
 			reg = <0>;
 			csiphy0_ep: endpoint {
-				clock-lanes = <1>;
 				data-lanes = <0 2>;
 				remote-endpoint = <&ov5640_ep>;
 				status = "okay";
@@ -289,7 +288,6 @@ camera_rear@3b {
 
 		port {
 			ov5640_ep: endpoint {
-				clock-lanes = <1>;
 				data-lanes = <0 2>;
 				remote-endpoint = <&csiphy0_ep>;
 			};
-- 
2.32.0

