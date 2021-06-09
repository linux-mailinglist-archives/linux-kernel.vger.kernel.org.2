Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2663A10FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbhFIKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbhFIKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:25:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2950C061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:23:45 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d2so26810096ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSIr/zgD0QKUjYJIhEJ6XI1VLo+32XT0J4ID1IoyWD4=;
        b=fqAD6isZzOpdAF9uAsnzbY6yrKqxk+H25yKbeNb+ngubcNcT0kFOdS+WdP63PHHUxC
         HmbNlTSi/IukvVImU0SQ0hRYfsU7yaQJLtUvzSHrwZ0Y76HCXjKyn5yYlU2/MUumCPF9
         9yi1u57wsD0zu6bpxQ8wDnxKEWL44I8LVjqcf1pBBa9ABKrCbo7Qhopx41SgKr/WdwkX
         gb/v8WSzmih9Gs954Py1V0YsjmVOH+nZR8Nc1tkBdN+y+JWwfsvBgCU6cWA/mBIrDt/p
         emaGFZFxeNq9knd/y1BAHZfbpwU+TH6k35FucKISH2vnlRbwQrIy4SpUNkrrzEFUSDo1
         0L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSIr/zgD0QKUjYJIhEJ6XI1VLo+32XT0J4ID1IoyWD4=;
        b=kmAzxFh2DFYQ77JPQd9dc2Ofvvktrj7XAn1ryOIUzKHL2ra/Bh8fpJhM8UY61d/JLk
         Cnji+RVLzQCp1InI8HAjN4oHOIrusA4jswYWgVc9OOEuupJxvu2ydkS11WkYy56DeLIP
         +uzZ5S0qNRdX4A4ZxrVE5dajLkUZPAPIBl+MwSU4WVyfUQyShQhZjFWf+ILne3fEc49U
         aXAqiDCZNpebLE55P7fJAHlmx4oTCgJLC0x1yFDj8gukXelxvs2L9N+dzny9VwAMEEEr
         +CjUlhmcYTPJQcIUXxlRnk9whgCABX6ZKYi9isXo7k9fvv5nR/di7sfFYGM4BDZ/Dfm4
         64mg==
X-Gm-Message-State: AOAM531hOnAbhO7abl2+ikGWQCERtFS7Fn4gonrWe3e3OfGYFiWGfSOL
        UDZ/rH+/yYIobAy+wBkWFHvDiYpog5rTW7lw
X-Google-Smtp-Source: ABdhPJxRpAglWaXtGp3R3fiw+lgOGV4wZw8PB/hRjO196/Gjs3ftPKT5ETRh0FArSEmyNuoX6BcBEg==
X-Received: by 2002:a05:651c:1185:: with SMTP id w5mr21510897ljo.379.1623234221556;
        Wed, 09 Jun 2021 03:23:41 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m4sm302966ljp.9.2021.06.09.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:23:41 -0700 (PDT)
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
Subject: [PATCH 5/7] tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()
Date:   Wed,  9 Jun 2021 12:23:22 +0200
Message-Id: <20210609102324.2222332-6-jens.wiklander@linaro.org>
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
 drivers/char/tpm/tpm_ftpm_tee.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac6994..6e3235565a4d 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -254,11 +254,11 @@ static int ftpm_tee_probe(struct device *dev)
 	pvt_data->session = sess_arg.session;
 
 	/* Allocate dynamic shared memory with fTPM TA */
-	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
-				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
-				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						 MAX_COMMAND_SIZE +
+						 MAX_RESPONSE_SIZE);
 	if (IS_ERR(pvt_data->shm)) {
-		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
+		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
 		rc = -ENOMEM;
 		goto out_shm_alloc;
 	}
-- 
2.31.1

