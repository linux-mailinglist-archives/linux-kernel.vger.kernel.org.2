Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426903C28AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhGIRqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhGIRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:45:56 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD28C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:43:12 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x70so2315444oif.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MQYZkcj7PXPFMtimh+m2etrFEIiXsdDPmjJZdcGVj4=;
        b=aPLvukXvM1FC1LRyGwGij2jsF0yLRd2cT7TUSZ9bJjAuIx7TS6y1IoNHeazRuQn85I
         Jc4Y/rWLe/HH7cOVQ5c2ZFKi7VE4/DpiCGUIfhF6Ed3MzuONdNd4oI5Seg3zxUR1uuPs
         c5P56uAWAUPBxF7TixgekcTiQgC7z4ontqYTr4TDTW+mOzhk1asHrbq0b7MZoMgtqt/d
         E037IyDwpnUwhZCVeNVlqQmXXSnT/nHH2lle5RUJKxSEwWJSBIRwLyPxTffkxPetlk41
         o3aQoaz83tpiiizb8rQJfxikdr3BkQtZ5sxiZlQaw5j5lxy4GtGPf3XM/vjROYvudJVL
         fnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MQYZkcj7PXPFMtimh+m2etrFEIiXsdDPmjJZdcGVj4=;
        b=AFsZEx0IzfkBsB2rftUMJuhtPQ+sUX5ZhQWJvn4rnrKZGwLpw2+01QymMLiIF9yvgB
         ZWU02y+729pLlA5s7DvNs4PgWTlVAEHLFp3tmn3JsG3+/GdkD6uRwiB9fp1uZ6GOsDsY
         ry6jSGwYZ15OlxfrB5ZoqB3pbMLw9MlE6WdhJOMUgQrfcYAE6KMs+V6Aiz9FLMI/OK6w
         eZzzBA/zZKhgdlH3D7/Pva/pFA11lPqqN/zJ60e2bdF9WxPr3z+vMC/RkvqEoqV5HzpD
         e/H3U4vCA6BfcrCL/ME85/dzVc6DM+lcIbBMks/0DwKpL3ETbkihyLqpmcSz+Z7/+adm
         wrRA==
X-Gm-Message-State: AOAM5304HvKKjAc06Yjh9Sdk+/uhrMPoJ74feGKOSKNDm0KLm8Hflbjq
        QyyQLgI+nDy2882kpnoM5T37Hg==
X-Google-Smtp-Source: ABdhPJyOlx52v2F41NFeyBTfCQWv3yZmy4Xt3t0F8QUUXQJEotXoT2vCvvP2SOrukmrSPeG6ziau1A==
X-Received: by 2002:a05:6808:d8:: with SMTP id t24mr14549348oic.105.1625852591772;
        Fri, 09 Jul 2021 10:43:11 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 100sm1263446otv.32.2021.07.09.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:43:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi S <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] soc: qcom: aoss: Add generic compatible
Date:   Fri,  9 Jul 2021 10:41:42 -0700
Message-Id: <20210709174142.1274554-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210709174142.1274554-1-bjorn.andersson@linaro.org>
References: <20210709174142.1274554-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems we don't need platform specific implementation for the AOSS
QMP, so let's introduce a generic compatible to avoid having to update
the driver for each platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/soc/qcom/qcom_aoss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 934fcc4d2b05..92a1af70a649 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -602,6 +602,7 @@ static const struct of_device_id qmp_dt_match[] = {
 	{ .compatible = "qcom,sm8150-aoss-qmp", },
 	{ .compatible = "qcom,sm8250-aoss-qmp", },
 	{ .compatible = "qcom,sm8350-aoss-qmp", },
+	{ .compatible = "qcom,aoss-qmp", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qmp_dt_match);
-- 
2.29.2

