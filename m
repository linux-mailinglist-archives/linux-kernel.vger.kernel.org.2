Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F2837495E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhEEU1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhEEU1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1416AC06138E
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:26:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v12so3206393wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsTr8xhyvOq2/KUMVDYhNF2zkO3qagBOj+gKv7W+VAE=;
        b=xwhYVR3pXtNBDDAdWPckdTbhc5SdSF3gpi71wNopA7snaNRwF0AJMIdZMpCIXIBdpd
         01HVLi77gO/8O5MqHXuCxsinWxrIH4ny3UpahG3+YeIks5nGfDodRRLuRvJveqYzS+LX
         QyB1aX0tKGnEhFmKnVTrO/8iGDbbElMyKb19z0ZF9GKqE9Ahb5yyNwnFXHiANMS/p5qL
         Mvpdds1lJEE/mwRVhaaTckHWQQ0slAT3pp6/oC6deyNLoNSPWJbqfrOcFWXAN/6jM6oe
         VeHCy39MoUH9PXf64zgrwhYEfz0iGEn/NBQCbgeKa8GjBKL/CKIHw4hr58TU1QA3UpvH
         QA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsTr8xhyvOq2/KUMVDYhNF2zkO3qagBOj+gKv7W+VAE=;
        b=DAqihFPMpfgaq/qKU9WiXEhA8e+CqvkMhGr1OvhFs7duJC+DkW71LmgOK7qSXBt89x
         WOODoPVdYbDFXtB2YUvka/qEjp3E30Bv+Fjm8muce1l3/TQsp6h3g9fYYyCOMUsuABof
         qp8xWuH5yr4wJNfsrsLvOI7Tx1iYqvTUQF8UZAgZB1T7+3dCd7hE3X17lP4WZq6zmo+/
         AWVmsOVDGqtdrzZTF80MALngdTrIHpcZtR03Ah0BkIvh/JvGsiqM5vXuW0xK0qEWiLjZ
         ConZZi/9lwo9TG9QVq7EX36NlZKfsk4DFes0PvNaoPPBD1m6UpkVMKjRLmwCyTjIcPHb
         zxwA==
X-Gm-Message-State: AOAM531nHLplMe+clYcZyM6RH3vCG6CarJhs17Jpm7BL3ybJrmz5e8nq
        gWhhnRnxKjGql11UF4gwD79cpQ==
X-Google-Smtp-Source: ABdhPJzJwSWhqGP8eX2CBd79ELjEJRHC/2Mz/y4/G3T2FEYUUPGebl79MKevNoKTcP0DX7ZqC1c+zg==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr875780wrp.243.1620246390870;
        Wed, 05 May 2021 13:26:30 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a15sm497245wrr.53.2021.05.05.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:26:30 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chohnstaedt@innominate.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 07/11] crypto: ixp4xx: Do not initialize static to NULL
Date:   Wed,  5 May 2021 20:26:14 +0000
Message-Id: <20210505202618.2663889-8-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes all checkpatch report about static init.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/ixp4xx_crypto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index 5b8ffa4db45d..954696a39875 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -221,10 +221,10 @@ static const struct ix_hash_algo hash_alg_sha1 = {
 };
 
 static struct npe *npe_c;
-static struct dma_pool *buffer_pool = NULL;
-static struct dma_pool *ctx_pool = NULL;
+static struct dma_pool *buffer_pool;
+static struct dma_pool *ctx_pool;
 
-static struct crypt_ctl *crypt_virt = NULL;
+static struct crypt_ctl *crypt_virt;
 static dma_addr_t crypt_phys;
 
 static int support_aes = 1;
@@ -275,7 +275,7 @@ static DEFINE_SPINLOCK(desc_lock);
 static struct crypt_ctl *get_crypt_desc(void)
 {
 	int i;
-	static int idx = 0;
+	static int idx;
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc_lock, flags);
-- 
2.26.3

