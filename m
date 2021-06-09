Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7652F3A1101
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbhFIK0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:26:41 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:36501 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbhFIK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:26:36 -0400
Received: by mail-lj1-f170.google.com with SMTP id 131so31006476ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBza1mKhlqsg6etHF8D7TfcQzqGCBqmRr7/AGAencgU=;
        b=IABFa0bjwccpp/bNIj/Ur6wWmjvpwTQ4uvwHXETm960Yor7fI7C0+IUiKkqzhdMHYt
         iIbNcwWw7mSP3CTqJM5WCz9e1fVOkqqyJ6IbJ7vb4F0AOABdAqzfgZynRLN+8RPYb3s4
         i8P1Mbi9AiOyCUoNtiLGY1WaWlwAMtRFzd33qTh+ik4miJF8Nyfg1ll+Pyr+6KOk03+/
         NxPSZaHEVcrddgn2hJqbpig76yiGdjbrffGibYYLE58P0dgOSFhz0/bgc7JeNwIYwxn1
         ULxNvboBP4WgP5Ou48sQjvhcfGoKYsGZbxYJsszS0eBdqj3Y1FLFX8d/tR8aJ7iJCT1P
         lXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBza1mKhlqsg6etHF8D7TfcQzqGCBqmRr7/AGAencgU=;
        b=CZUqeIHJG7OFba1ND0lmGYlefO2ThBvgkDxBEP649ADJkElXrpFUbbSJwrbQVF022u
         9IqO7cmoS+UYxengPUdOMf5HYtzrxjCTT1jd7iXoOGbvgxHI/p/yd12KZnJrXfO6zk7+
         iabTgwDE0kqhiSsotaCSCBB5plaQSpGL5Z2MUJ8rwk6jEaGlsgXk08zrv+KxGN9Ara/a
         jyUrCBaRqtU/wKX4JJZpuOz3LzYDN0LItBAMBoSEOPH+PLqMYMHkjBCyPH5BKNm6xxay
         ToEB5SanvncRuac00mub3D9BOYRqGviiKHutLel96f6EFsoLqwh/pNMS3SAxk4/jq6rm
         ClKQ==
X-Gm-Message-State: AOAM532D44FFz2MnHGOAdnPxh0XN7wtH8UkxK/HmVLo3bcUQt+orT0Zw
        MBq4B832THn4De/n3SXtvj7FosDDEYvCXawv
X-Google-Smtp-Source: ABdhPJxJ/g/8K2URkWfxiXdN18FhFhzSSYRq1MrmDLL0fZZa78RlccOZrwenL4lGTKNI4NcOB4D9Nw==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr6919196ljg.179.1623234220818;
        Wed, 09 Jun 2021 03:23:40 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m4sm302966ljp.9.2021.06.09.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:23:40 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 4/7] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date:   Wed,  9 Jun 2021 12:23:21 +0200
Message-Id: <20210609102324.2222332-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
the old deprecated tee_shm_alloc() function which required specific
TEE_SHM-flags.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/char/hw_random/optee-rng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index 135a82590923..a948c0727b2b 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -145,10 +145,10 @@ static int optee_rng_init(struct hwrng *rng)
 	struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
 	struct tee_shm *entropy_shm_pool = NULL;
 
-	entropy_shm_pool = tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_SZ,
-					 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	entropy_shm_pool = tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						    MAX_ENTROPY_REQ_SZ);
 	if (IS_ERR(entropy_shm_pool)) {
-		dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
+		dev_err(pvt_data->dev, "tee_shm_alloc_kernel_buf failed\n");
 		return PTR_ERR(entropy_shm_pool);
 	}
 
-- 
2.31.1

