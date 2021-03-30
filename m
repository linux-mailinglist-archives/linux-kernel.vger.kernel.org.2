Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C545934E62F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhC3LOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhC3LNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E4DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h13so17712822eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHFVGmCk8APP/nFxGGghK7OrCGZZOftzd/QVZZ+DNV4=;
        b=Mcb/hw3Kx+7S1W5lYYZs/qGwzPSmfbExpap3XODd8HpygNV2QpSn3Fp4SiN3Usz1ya
         Zc2hNS4slfx0AYnx9MhY+jLvm5gEfbuREtNf5M5sKtG2U98gX3bNVaW2HaKvAb3jrRf4
         KrjpHYbVNzdZEsKr5NGeggP0G813XoRO1Zkf/CgTLfGpZiWkILpy1aTnV91F+1EWd0/D
         bIh4wACmro1k/do2zqMEDE+lABlYXcKrh+4vvg1I2CEzjVppcOGf/ibEETyDw2IQhx4w
         8wha4fNjByzsP01ZiVC+1w/cnd2iRXYX49PTzcPhTSFKTkoKDgObYs4bJlZ957mZW9rh
         yQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHFVGmCk8APP/nFxGGghK7OrCGZZOftzd/QVZZ+DNV4=;
        b=adepMyqyxHmEOSOOdYsFJkfJp7gzE2EKV2PaP8KgTNa1r44GxYHEw6cHo0AXZgxgpL
         MuI4OKS1sw1ld64j2UkxaXHBi4KG+PbnntR93BQoWihp9UVgfzLE1bUjW6HvYAgPKzDg
         UZHIv2HTxD7b1KjGPDbNDYSczs4xRHBv0kWxGhpmSKPfCEy3PGMCOrIcSRo0uz1FpDwf
         laVoasr7m9pyue0XuYYZG4HtcQ7KI9fYaZ6x9Mp165lBVH6T61h2x55tk3Lx76z6KeAj
         lCaEDhuWuEgkDr2iXyg9lj/li9ltOT009pS3iEWEJQlPVFahK5e2KR0BgrQFu0kpRprW
         I94w==
X-Gm-Message-State: AOAM530rq2bno37DsZcvFTYU7MAl/1QHA0iiSNFBDBWUg3uUWln1Wd5k
        /77OZS8e1dY4kk6+v9A5EXHMIg==
X-Google-Smtp-Source: ABdhPJxAHBAqsNFIxMspNLxFlUfpcOuBjHjwaao+muIOxtYO+jt/N6arYyT1HpP8tJaEnJLA4DFCWA==
X-Received: by 2002:aa7:de11:: with SMTP id h17mr32348683edv.83.1617102818831;
        Tue, 30 Mar 2021 04:13:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/10] nvmem: convert comma to semicolon
Date:   Tue, 30 Mar 2021 12:12:33 +0100
Message-Id: <20210330111241.19401-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yongjun <zhengyongjun3@huawei.com>

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 2 +-
 drivers/nvmem/snvs_lpgpr.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index f6e9f96933ca..4fcb63507ecd 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -141,7 +141,7 @@ static int sdam_probe(struct platform_device *pdev)
 	sdam->sdam_config.dev = &pdev->dev;
 	sdam->sdam_config.name = "spmi_sdam";
 	sdam->sdam_config.id = NVMEM_DEVID_AUTO;
-	sdam->sdam_config.owner = THIS_MODULE,
+	sdam->sdam_config.owner = THIS_MODULE;
 	sdam->sdam_config.stride = 1;
 	sdam->sdam_config.word_size = 1;
 	sdam->sdam_config.reg_read = sdam_read;
diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index c527d26ca6ac..4692aa985bd6 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -123,7 +123,7 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->dev = dev;
 	cfg->stride = 4;
 	cfg->word_size = 4;
-	cfg->size = dcfg->size,
+	cfg->size = dcfg->size;
 	cfg->owner = THIS_MODULE;
 	cfg->reg_read  = snvs_lpgpr_read;
 	cfg->reg_write = snvs_lpgpr_write;
-- 
2.21.0

