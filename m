Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87C42BE63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhJMLCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhJMLBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:01:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DBFC0613A9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t11so1524620plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbohWyUs/XEVgJ1sMzx5GgNA+CoHQz7FKaMhz+WvP7Q=;
        b=aWBDPo+XkPYlTM+uRegDzpoN/h679h+9ZFX3Yb9ikiuC3BwoIicwyXzxblfl25u0t3
         i5hZ37SfyfUxoCbkac0k50s5cSs+jzDSeCG1Bwom8E1qXnf7oRa/WW4UXuQJKHy9zOy5
         5vZ+mQlfFWydlI+nust7zAkVmD06HPzMi3IKNbqqaqjqwpRkSX6hnIuyx93XDMABUq9t
         NLcA5PhZSyybf5HxtP0nkCgOemXMKS/zVuXkIJWwjtgsj/EGXw/qfjU6ztOIFUxMU3WM
         q4DQ5WcKsw8MsEXV8uFB8pkhHcMU2nMiMrv8xOxmku5gk0KIWuF73+3c4DueG3kbPVnE
         G9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbohWyUs/XEVgJ1sMzx5GgNA+CoHQz7FKaMhz+WvP7Q=;
        b=QcZcALuoOEIYTNy9LR38hKQ54jjhhhWJ5/igoRdJUEwIq5RLGOAo+gH48+rLwtAWmK
         bGWGF+i3t9bZbjFlHJ6lcbY99wno2isIby6LgB/wY7YSFSFPGSJ0rJy0FcMCe4gfVtyL
         wuZZrUnsU3M0/8EAL0EKfqpakg7WFBv+Mz3hmXStg+Yewz2XEIxIolCJiQpWMgXzNRRS
         ZH+OiKLdTGzoT6eYfaTmHvhho4cszCiK1JamMjd/n42UQXvmm6HnePtYkQ1cnv5mHfCC
         aBqARYoYdiizdG2MuYRtYukrMC3NPapkDbwxBkY1chNvzDoC5HXtRMfJH6orq3XwV6yy
         +jEA==
X-Gm-Message-State: AOAM532bvw4i7MmHOrte8vJVC+qIUsCf4Q2IHijHgugCZWn37nNBkrcO
        OycPAqJuK0pGqGhq7ES5zblR7Q==
X-Google-Smtp-Source: ABdhPJwywYk4PJNAhFCjlu9JSdHG6UaMaytxyWqC5ooJQNf7ZtdtOTA3vvINGm9UW5P007G9L1NphA==
X-Received: by 2002:a17:902:6947:b0:13e:8e8d:cc34 with SMTP id k7-20020a170902694700b0013e8e8dcc34mr35131854plt.88.1634122633168;
        Wed, 13 Oct 2021 03:57:13 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:57:12 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v4 17/20] crypto: qce: Print a failure msg in case probe() fails
Date:   Wed, 13 Oct 2021 16:25:38 +0530
Message-Id: <20211013105541.68045-18-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print a failure message (dev_err) in case the qcom qce crypto
driver probe() fails.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 576c416461f9..cb8c77709e1e 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -281,6 +281,8 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	icc_set_bw(qce->mem_path, 0, 0);
 err_mem_path_put:
 	icc_put(qce->mem_path);
+
+	dev_err(dev, "%s failed : %d\n", __func__, ret);
 	return ret;
 }
 
-- 
2.31.1

