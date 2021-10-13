Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139BB42BE58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhJMLBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhJMLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:01:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DBEC0617B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f5so1919299pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqGUwXsYMELmrAtaUueoKDZTvSzuO0sYrAVvVt3/FFs=;
        b=OUev4I/UWIe6xc1YRHFcpA8o0qW2I327gqPM6GaTj5zmGAL5HPwfT7tNFVnmHP/W5x
         FoZumFY6MdoWMs9VsHrUNMqQNgkIIf1G/C1aOABsDSNnZqR9wLuNSDhXmwN8HFSGDy37
         mcYxM0UmuST0WmKRfnpHOijGnykinnrlBvNDpcn56XNL9Mgho0TPHO1hAms94jRwu/rK
         kPX43AmO8jbqGXBfVnWtWwi4BBqROsN/EWVx6fguJND9IMjupUHbOoKHhStpfJcYqGqN
         xIUvlZ+W0ABMehGCu4/CGRwaTHQwSIUH6LC0EkMgqhwfBUgA0VC65m+XBLziNtLzt3Wd
         VLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqGUwXsYMELmrAtaUueoKDZTvSzuO0sYrAVvVt3/FFs=;
        b=4JsFR4LMCIDIEMlX9qfCKEmYFhajpZ+TjoPQwM7egjPfT/7rA2WyjNYlV6g8XTuq5+
         1XnZF7IwId2lYtynVw8d6ZbI9KYXhoEhPFLDCmYN88EjWj+m7WHz+aLr9TpFZorFRb55
         eHIbPVm7IVxI3Ag+4sz6ilSRKxLnE4sM7A1wfnAvpfHbnD58uetyKJzcotFdpTTlbP5N
         nEoZeUgo8LqdTn3vsOnX+e70/Ykad2anSYL6u9cdH1rRrp3Xqti+ifwrlC4QiyYD9uqb
         QmRBxlqZ5sANuPZqhW++8aUsaYu+flJUS/OXZymbXjB3yN7YWyMRX3x9puFteUfRgHPu
         VlLg==
X-Gm-Message-State: AOAM531RwqQs4vuXcsUx4Si8qEKIAVGSHHwXi4sutKgFkowlXcXcbK9L
        8RXELB5R19hqs9eRgI+pZpVB/A==
X-Google-Smtp-Source: ABdhPJz6H8h2HFXjZ+w1IYSTUDNnuHwhEEL7s/kpupJbUkWgc19FC6+cv0YmPpu1plBwErcL8FCnmQ==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr27452891pgi.24.1634122624619;
        Wed, 13 Oct 2021 03:57:04 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:57:04 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 15/20] crypto: qce: Add new compatibles for qce crypto driver
Date:   Wed, 13 Oct 2021 16:25:36 +0530
Message-Id: <20211013105541.68045-16-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we decided to use soc specific compatibles for describing
the qce crypto IP nodes in the device-trees, adapt the driver
now to handle the same.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 033c7278aa5d..2ab0b97d718c 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -298,8 +298,8 @@ static int qce_crypto_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
-	{ .compatible = "qcom,crypto-v5.1", },
-	{ .compatible = "qcom,crypto-v5.4", },
+	{ .compatible = "qcom,ipq6018-qce", },
+	{ .compatible = "qcom,sdm845-qce", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-- 
2.31.1

