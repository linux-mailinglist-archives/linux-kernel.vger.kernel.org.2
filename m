Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46438917D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354496AbhESOlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354466AbhESOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:40:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED7EC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:38:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t30so9591869pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJ0dnnuzoeTgYR3s2q2rVPLNWq3NbJZWo1BzkyjqRwk=;
        b=m/uNEaF4R7ZLKlP+RvsBZ6ySpgoBfW9IhsmyZRm+U/pmrvLJqYTNlH3QSTPCpAuSmO
         HLG9idUpUwqxrUXKT8fy3VkUEX4Clg+j1G3F3oRphZT015VY9VW4mDxVLw1jrVWlYLg4
         l+Yepm0Q4PAEDPlaXreWKjyIadN3GS6vP3+6BrriHpX2+2ixo2jfbBrhL5042AdG6fF8
         a92FGRUgwn6+A1ueB6EOLQI3IZ4nehva2+WUXsaFkoyVk8iW9TAFy8Eizfd0fUJ2A1Oy
         LIUny2yugyprMwHK0/YFxCEuIaKXH5+DVXLlawjlVrGyidJURzVQqIPVLtCwx5ZHP9ya
         FBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJ0dnnuzoeTgYR3s2q2rVPLNWq3NbJZWo1BzkyjqRwk=;
        b=Gti8Tki0OTysaCuxq/6jb20ZSk4lTpR9skUxstC3pe/VjSJwdA1bejIvtfrpIk2sp/
         bMkGeXYdPf/RQsmuRmn0RHymoO+yb2s7S2WBGrMI93Ycz/hS997z5JJZZDDL/4zz/PYI
         qjCLDp+DZWiCjnfnrGD9SFug3XTQGO2eZvAT4lvjZRi7q/SkOaKLNkJzlM02AmYVTohy
         c8ESKfaiNzmiyNbwI5cVEYrmlu4/K2ds1IOofSf3pzGBzm6po6rGIDFBEsHj31zmRkU4
         mHbFMrVfvNF09W2xe/EvytDm6qOuCyd6FmC1wrOCGY3hwWBXHPxZztkzgw+A1ZrkFqk/
         KB7w==
X-Gm-Message-State: AOAM532FTpTBacI4aIZnsiP9nurDu5XcMSZkrW/jHrH09V+IDACjtU3L
        EkByIyL7ikUh5vUhtbBmc5u/tw==
X-Google-Smtp-Source: ABdhPJyVdhAIfoRX/kxSiK99dNqfNVL0mpMBrPr8LftZML2nuwc6WPF3Q0BOEZM9nkUVY+/3v6Hlcg==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr11326507pgs.101.1621435138781;
        Wed, 19 May 2021 07:38:58 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:38:58 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v3 14/17] crypto: qce: Print a failure msg in case probe() fails
Date:   Wed, 19 May 2021 20:06:57 +0530
Message-Id: <20210519143700.27392-15-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print a failure message (dev_err) in case the qcom qce crypto
driver probe() fails.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 8c3c68ba579e..aecb2cdd79e5 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -300,6 +300,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 err_clks_core:
 	clk_disable_unprepare(qce->core);
 err_out:
+	dev_err(dev, "%s failed : %d\n", __func__, ret);
 	return ret;
 }
 
-- 
2.31.1

