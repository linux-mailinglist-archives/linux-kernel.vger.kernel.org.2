Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B096B42BE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhJMLCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhJMLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:01:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0EBC0613B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e7so1961026pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIeSWkawFiY3EKsKgOHORiHIHpztrgHhtcjht+dbDL8=;
        b=F8EQQVS8lD2AmJe6NmVXJvx1DuV+9AXwJi6WVNUKBOPFyc9z+oQ+SEWtsm7ZAbsZUG
         Vwhju67oKN6l9EQAAWSlvo+EAWzpahGrZInHXAygLxRvfSlcnlIFpbNXndQzn2F58tre
         0Z9V7MJzPNy10twHrMiheNKA7QRd8SbMMYIPKRLbbRvZan/otoGnY7cnMkfnopgWHf7S
         wwKDQ8Sk32bAYfuT7vF6wOmnRFdVOty610dWcCc4SBGXg3pIw1p0ppJCrLdsHDidOc9c
         UOYhylRG9EsOEss1bmwScqx13yJRKQueS3OvylNWOfLQpWmTRvsSprH/eQHZM4tCGIFX
         7AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIeSWkawFiY3EKsKgOHORiHIHpztrgHhtcjht+dbDL8=;
        b=4lta1iMcyljbvmKnbhDG/lLulXqfrb5dXRYQ9AYFaRPHzKuy+zI1vDiKOkPufJG/r6
         DalETCNTGHRDIEG8vYyu7JGbXNB732Mr1shUoL4yANMSS46M3JtAV88GY1Dk3HwSAgF1
         q5IxeNPpduA2GA0sC6a+yEAopnQ5zDF0LVh3Wq6BzfbOKowl6ZcsrpU7tJR7PvQoa62x
         Vk5BAz+q5fjOq8S6zuiqIbDS1jbMommZZs/YzFATumRJHMKI6hasyKC/WOJaER6287tk
         fhjG0HnZlc82i091TEiUmZbuE7p/f4ndCV9XZnDr+UoPpwfTaJgweK0KyzqTdPHwNnte
         /LLA==
X-Gm-Message-State: AOAM530fo9OGMYhCtGlj8gI6LaLh90tOcqBQygtG9N2D1jMULJq5Rjjt
        bQsEiyc7cNwIke5B35xeyCwDfQ==
X-Google-Smtp-Source: ABdhPJyn/6vHcY71500LqC+ZB4kTKev7QGx8YUDta7MQFz8PtPTUQEw7o/zGmliHgnQWK4XYVdpXQg==
X-Received: by 2002:a63:392:: with SMTP id 140mr27804274pgd.189.1634122642326;
        Wed, 13 Oct 2021 03:57:22 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:57:22 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 19/20] crypto: qce: Add 'sm8250-qce' compatible string check
Date:   Wed, 13 Oct 2021 16:25:40 +0530
Message-Id: <20211013105541.68045-20-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'sm8250-qce' compatible string check in qce crypto
driver as we add support for sm8250 crypto device in the
device-tree in the subsequent patch.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index c6f686126fc9..4c55eceb4e7f 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -306,6 +306,7 @@ static int qce_crypto_remove(struct platform_device *pdev)
 static const struct of_device_id qce_crypto_of_match[] = {
 	{ .compatible = "qcom,ipq6018-qce", },
 	{ .compatible = "qcom,sdm845-qce", },
+	{ .compatible = "qcom,sm8250-qce", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-- 
2.31.1

