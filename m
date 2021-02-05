Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776AF3109A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBEK5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhBEKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:52:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D25C0698DA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:45:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m13so7094834wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUGwtlmgXSNtLs4jeYoyMy0OUjwWufxEelxvIP0w1pA=;
        b=Fwx1ouohDc1t1SRm9bp+trJ4XgAH3o7xsafjqV8b3Z8BSs756P7sNCFXezdm+oIYEI
         1LzOAiYEi+yiOCxpqno4ZeEsNAqi+Nh/dwKU78S6R1oCjsivIrNO8HgfsoT9pJ1OjJ7e
         JKEqgDe4l5a1f7yfz3WXlAd8CDZa0LzSO523xHV68YrOnqQSmp2OD94YDz6AusIsE0ce
         EAAdKhmGiJ+HbqbjZl7IuyRb6CHTVG2iu6e/4uEBiY/PtLkgw4ODHU25u96w7GhlYM1i
         ixzulomlgu5/0ZZkIVlEpymV1wlpo84KNks75nbunUNfvMxrEU4xO+otpS/e2ndtUn7D
         Dzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUGwtlmgXSNtLs4jeYoyMy0OUjwWufxEelxvIP0w1pA=;
        b=n9JQXQZG6LrV0729cgtJvb50Ws/hzq2pUIt/MrxQqy126isBtXRGrXtkKWr8vL+gUN
         jQnUqDBCPDG2cHXeNjnRz1ADSepd4sovh7Yol+hyOOS4CcFeONO5pJwnqZVsWlV1ea9T
         OrXFILD3suMNgFDxrX6dH7sDm2a/SPyaMTOinWnigTOJZbLbeRe9fOlnK2n8Fu1jbWvm
         4la2a4atbaGLkVSwql6nRoc2x2TiZqI9fAbeD4wWyiFFNNW471zS/Nri4576V16yMV3q
         tMQVluLc2OFGy0E/wVO4TqLrvB/0fcg7VeOPEvslK2DjxMl3PHqUqL5iBk0hz4RORKiF
         7r0w==
X-Gm-Message-State: AOAM532N7lQTjhK4agp7hPD7mrZUeGpZ6f2e4O3nRd+MK4YrfDs/0nBD
        LE0qushxSvxNbeKDOepqgHvq9A==
X-Google-Smtp-Source: ABdhPJwTcctxZeQ/VmfTFSbXLstzOjpQA92T6jyVM+woDgkju33ipwaN46VApTeLxaZTphfjXZb1Tw==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr4270526wru.314.1612521924035;
        Fri, 05 Feb 2021 02:45:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:38fd:e0db:ea01:afc8])
        by smtp.gmail.com with ESMTPSA id u4sm11300233wrr.37.2021.02.05.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:45:23 -0800 (PST)
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
Subject: [PATCH v4 18/22] MAINTAINERS: Change CAMSS documentation to use dtschema bindings
Date:   Fri,  5 Feb 2021 11:44:10 +0100
Message-Id: <20210205104414.299732-19-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210205104414.299732-1-robert.foss@linaro.org>
References: <20210205104414.299732-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the complexity of describing multiple hardware generations
in one document, switch to using separate dt-bindings.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cdf1556c6007..7c5a494d9113 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14686,7 +14686,7 @@ M:	Todor Tomov <todor.too@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/qcom_camss.rst
-F:	Documentation/devicetree/bindings/media/qcom,camss.txt
+F:	Documentation/devicetree/bindings/media/*camss*
 F:	drivers/media/platform/qcom/camss/
 
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
-- 
2.27.0

