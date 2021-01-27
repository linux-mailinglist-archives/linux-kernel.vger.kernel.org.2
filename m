Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9DA305EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhA0OyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhA0Ov6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:51:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66933C061794
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:50:14 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r12so3010066ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PC2sXSUCVtuCTR4UN7c8iTkNydyknx8hb/BTqhYKVYU=;
        b=Km3FGXSMXegLYd9zspWBInmTdsgIkQhiYRxkxdGmVyeVyr1CbuwV4uNYN7kIYHpq4d
         DI8D3oeLAi05nI6WBz/NjGoAr34SYhb8fqvMZrwGMpqkc3c2EcgUobx+MLALjy7B/RM3
         D5a4FR9GfTJ+5eOvKLwemmSjAs80Qqf2BjYOGuvWwOUZDFyU0RBTn+nDrSRMH8ug1+/s
         RsZzV0g8g+2hkTdCZsZWpYoebC5in+4nJDvZeHXCxziAnwHXmtpSgU7YtP82UW3PguCz
         zPXuHx1eZyWaJzzep3tv5vRACLrYvT/p/rGS/JWHUHu4CBJpOnk0IR8BPc0HkeVlY5Y/
         e7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PC2sXSUCVtuCTR4UN7c8iTkNydyknx8hb/BTqhYKVYU=;
        b=oF4Ag0Qf6tvZ6pSKu1jtvMT7jtsU1uvLGY5/F6iNWiOu+On15LkWUZblec1V8B5+wU
         e1IAlMtnU3Q+Ev1AVfRzBWbTDyy5NBtwwf1inlQCQtpqWzDLRoYYrV/+SXk/cTmrkXii
         7QL729si+C7wlaDrmuruj61SXOmIMislpEPCr1geUcNVZV+/1NDGMiVhIDHT1GJ3yNSe
         zRVWhye9nkS9i+2g9nlIqfu4DHWM2JwGb3Xa04HRFGAOdcG6SUpRh4EX+vSnhIHQMSOs
         uto1DyNki+WLRAweQ7VF2+ZsPPhpY7C4hWbFQ/Kj4LS7f93CguRbQdSwOA9Kag5wE+KK
         Vcaw==
X-Gm-Message-State: AOAM533Ci0heER6i8huE6lQlbu5DNqvSCJWPwwttLPTjefMnX1VkuIDt
        efcCIfemgXPytN5pxo6HFkvdig==
X-Google-Smtp-Source: ABdhPJxAHCiajGCbjkts2e/RBSSDX+s9uDFyIFPZhWJHEsFMk6I5oWKRECflrA4RYWy1GbJEPTD7zg==
X-Received: by 2002:a17:906:f755:: with SMTP id jp21mr7073115ejb.22.1611759013158;
        Wed, 27 Jan 2021 06:50:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:62e7:589a:1625:7acc])
        by smtp.gmail.com with ESMTPSA id ah12sm947799ejc.70.2021.01.27.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:50:12 -0800 (PST)
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
Subject: [PATCH v3 03/22] media: camss: Add CAMSS_845 camss version
Date:   Wed, 27 Jan 2021 15:49:11 +0100
Message-Id: <20210127144930.2158242-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210127144930.2158242-1-robert.foss@linaro.org>
References: <20210127144930.2158242-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enum representing the SDM845 SOC, which incorporates version
170 of the Titan architecture ISP.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 3a0484683cd6..46e986452824 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -66,6 +66,7 @@ enum camss_version {
 	CAMSS_8x16,
 	CAMSS_8x96,
 	CAMSS_660,
+	CAMSS_845,
 };
 
 struct camss {
-- 
2.27.0

