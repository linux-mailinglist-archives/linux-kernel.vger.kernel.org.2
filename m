Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754E342C71D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhJMRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbhJMRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:00:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228E0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:58:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w6so2994806pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNIscZN4pNeT8xlXkzpt1e9k3wuAf/h4QxrluxNZacc=;
        b=ym+HmUToOB0nIJ/6QJjlzffUg+ZcWGWEvFUbu1MlwxwjY9RT3TdDlfYqbIveutngzk
         u7Bj6p8alGws5CgUK5Y/qLqGBp9KYjczUgLzX87/cEPgc8cfB0zC6cVkJ26gkYjrV5NX
         NAcRDulgmaoJdYJ4c/XkzcieuK+CvkZMerl36a+RIJtgVcr6ZkGNUVpg3fvE/oQ84Nxy
         YULfAUGPPko6tWz52u3wMjgc9gbV1FQV4Qp13wUj0yLUyNQGyPoTkKLFFaaygFXqqZcx
         nZ9iMVPTFBpM99FYTwi4VhoyhCeTOEOUteL4cu1tcY35jb7HCWSH7N1eo8PCFXnhRegV
         WxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNIscZN4pNeT8xlXkzpt1e9k3wuAf/h4QxrluxNZacc=;
        b=wdXmQJdRECMPHbE29gEWrWLRgtf381JKb2sRYK6n2xIC0ElXdUtvK2fXiIyWHvNwPA
         Yhxy54oxaQdcfr6xgKw0HMCRD1Xj3DFd7E5iVEQtFV/HiwB9RToubH8+mCFiepaVl5Vd
         zhzgoauohR2CjgXvkui7gYEYEnI2DhbTwBhadHJSnM0tKxeAsMmWSMk4uC5anMVNr01L
         SWOlYWqk7mSmhXGHxLo2r+eDW9414oG56nKXdtxPjMsn67Iyjz9D/Bxf/nNvmPPisebI
         pnQMQch/xxOc4GbaFVBro/zmZI26x/YIzzKrqFJy2/CnSVqjey/Vg0ano69Wierph0Yq
         SsCw==
X-Gm-Message-State: AOAM530qJAMGCkTh4pH5EgBwEYgyzljAB/lKhwpCpdJ5ok+Z+37lGPzG
        z/URE8XPG7mahpznG5FzAWY+Rg==
X-Google-Smtp-Source: ABdhPJycuIqU30EM3ra9hlqSMZ7W8ZLMQTmaR6xBqWr0oIay7sNaTF6yyf/UJRlmDRa+BiVFJ6PdUQ==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr203416pgc.97.1634144323611;
        Wed, 13 Oct 2021 09:58:43 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id z11sm6661602pjl.45.2021.10.13.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:58:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/2] crypto: qce: Add 'sm8150-qce' compatible string check
Date:   Wed, 13 Oct 2021 22:28:22 +0530
Message-Id: <20211013165823.88123-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013165823.88123-1-bhupesh.sharma@linaro.org>
References: <20211013165823.88123-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'sm8150-qce' compatible string check in qce crypto
driver as we add support for sm8150 crypto device in the
device-tree in the subsequent patch.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 4c55eceb4e7f..ecbe9f7c6c0a 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -306,6 +306,7 @@ static int qce_crypto_remove(struct platform_device *pdev)
 static const struct of_device_id qce_crypto_of_match[] = {
 	{ .compatible = "qcom,ipq6018-qce", },
 	{ .compatible = "qcom,sdm845-qce", },
+	{ .compatible = "qcom,sm8150-qce", },
 	{ .compatible = "qcom,sm8250-qce", },
 	{}
 };
-- 
2.31.1

