Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4818C3A110B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhFIK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:27:01 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:41961 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhFIK0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:26:52 -0400
Received: by mail-lj1-f182.google.com with SMTP id z22so15033431ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z41Cr+HEWGY0CsHaBd8pm3xNtEWwWXvXTvPBLBMGN/o=;
        b=wxnDktWnokbe9vdca0sig349xZwGFRxYuFMA+W0zn7C/YzUSGShW9nf9GwP+zBWewr
         KcIhMUvVU7R6230pLSzbrXrkFRT/Krbs6bdsqTll3nVZEW43N6ica7F+OuHFDn1OihUc
         hBhJPbDM0gVwJ1TfOFHiHSuSlWi2MY5Ve5RS1pVhKTTTTnrxXlZGZRLcToK4DORu19mq
         TPhX6S+52cWPuBj74jpI+I2yLXiv8faJT7DJz0Isu5f+C3H4wfp6hr/sqtLAOxm621j0
         yRad3i1pPSmuIGfc5oOhDfFuQZGEpYj3jjjJ0TUkjmlv8E8CK6Zso99mhY4Nk9tmdoPB
         vDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z41Cr+HEWGY0CsHaBd8pm3xNtEWwWXvXTvPBLBMGN/o=;
        b=ldBbgEHZCDxAxYkxZvhbNJasy0qvuflK3B4mZeovipJre2f6BNLC57xBkLXS03MTKT
         dXUtUNeezGmroZN65o6AmyqM3MVwJKAyXoSjppzI8CkGcAGY7lYYWMrP6kBfQFa/hU3C
         KZnQjWB826Tky2n7TgkG6ScFpT7OaNuGdRSIbPww3bHziGox08VgJ30bZk2XIB5Kdmoc
         0E5+QcCXbVmNwJ0rBTjYY07dLlKp0l+M2dZDqNjmRzoGo20b2xCY9bi4ze96sPyP274U
         SvkssW4QYMIO+gRPo0XKtvNH0GjeaxfVB3kETh6dNMp+nfCMow5/1PifP52K+CCEopZA
         2Jfg==
X-Gm-Message-State: AOAM5336tgpUkbBlW0AjAJ2qqjylF3bsKyhGhStOg+97jy+GIyhuGq0m
        iwdcN+D4/VIQcGeNg0bg2UXZ6E5xpAsWekE3
X-Google-Smtp-Source: ABdhPJzypUn77FFisUbpoXFQUpt73CwKxfl7HpnfNmeGK3YRsOitn1ppydvc0cplYjzX2lC2zkT2mw==
X-Received: by 2002:a2e:bc1b:: with SMTP id b27mr4023293ljf.65.1623234222427;
        Wed, 09 Jun 2021 03:23:42 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m4sm302966ljp.9.2021.06.09.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:23:42 -0700 (PDT)
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
Subject: [PATCH 6/7] firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
Date:   Wed,  9 Jun 2021 12:23:23 +0200
Message-Id: <20210609102324.2222332-7-jens.wiklander@linaro.org>
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
 drivers/firmware/broadcom/tee_bnxt_fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index ed10da5313e8..56d00ddd4357 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -212,10 +212,9 @@ static int tee_bnxt_fw_probe(struct device *dev)
 
 	pvt_data.dev = dev;
 
-	fw_shm_pool = tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
-				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	fw_shm_pool = tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM_SZ);
 	if (IS_ERR(fw_shm_pool)) {
-		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
+		dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
 		err = PTR_ERR(fw_shm_pool);
 		goto out_sess;
 	}
-- 
2.31.1

