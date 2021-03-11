Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A938337C27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhCKSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCKSKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:10:41 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D1C061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:10:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mj10so48152107ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iW1Mo0snzu57fgRZmoRiaaFH2x3HHvb/t9DylSyqSd4=;
        b=Yu4nO4UwRPguKAePAMzbMPgsQLguQby44EycxETxUYd46e3KHe9AhxBG6JnrKPobU8
         g6PmQqLfPtKzS9TbzOMsj8XsmyQUsNu3FJWz2gpPIJxJmMfMqjfYOdElJD7JbMczA2AR
         uSBo8EB4DkqdrT1poalnxmXuRXvJYZZ3WJ1AD9aqe0pWb6+wx+wyxZxt+2yd22pbzlRs
         Gii0buk4QCdS2cnyLmLHXyv1mXihFCbvaeTIVkJYmPLcKa2y0Aj5jc6Rtll4WEdYmHIS
         1mHUBLClxzwtAOQdmxi/Hq3U/KFaNH4rbANA0/Z5ZI+9ZZNitE4atIZn0wJp/7otaiWy
         ynCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iW1Mo0snzu57fgRZmoRiaaFH2x3HHvb/t9DylSyqSd4=;
        b=Igl+YXvSnBOydAmvmt8kscTHhl4lj5bCoIX/ZMgB251jDhe2z6KXYN9D2lVdEXN8WJ
         srIt2Ez4o0xMYEqxox9Ygtv+djNC3dwJpB0XbCL+uwXsdESjGzzvv+09gb29bShoDuyo
         TEM2ejCIumF34D4EPdZo85zwXoVUDn3x/ExILYLrPOxP8ZZvyqVLYsJZkkbdG/cZRAQ1
         iSSjlzXeaM5OB3MTz7Wg0ZtQ/Gj4UieAH2fSKahEB1OjOUChU2lkeBLuj1UuRiMg/p/A
         JeuzqZKo9gvdXI4jp945I1lcQFJzwqztQ0CkQahsXrFxEDxUyFfzg/akAbWwjo109i9b
         drQA==
X-Gm-Message-State: AOAM532cwbVctrMwvMg+sNVwzVP4H2OgwKJvwwAsZq2BxblzS9CDMWgl
        dlzu2LmQEReGzSSaSXtGOAn+XA==
X-Google-Smtp-Source: ABdhPJyZMnQHJoHqKoYgpKxMkhvlU4sQ/DL95jlfMZF3xK+zNp8mxRAH29j6wSf7XWBOQq6h/XR3rw==
X-Received: by 2002:a17:906:30d9:: with SMTP id b25mr4297529ejb.348.1615486239536;
        Thu, 11 Mar 2021 10:10:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:3e3:5f00:8e01:34c:da50:eb7e])
        by smtp.gmail.com with ESMTPSA id a22sm1741290ejr.89.2021.03.11.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:10:39 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v7 21/22] arm64: dts: sdm845-db845c: Configure regulators for camss node
Date:   Thu, 11 Mar 2021 19:09:47 +0100
Message-Id: <20210311180948.268343-22-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311180948.268343-1-robert.foss@linaro.org>
References: <20210311180948.268343-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator to camss device tree node.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---


Changes since v5:
 - Andrey: Add r-b



 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c4ac6f5dc008..7e3c9fe4955d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1108,6 +1108,10 @@ &cci {
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

