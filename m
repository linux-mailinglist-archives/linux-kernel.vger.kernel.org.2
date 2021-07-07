Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686763BE298
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhGGFcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhGGFch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:32:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E08C061574;
        Tue,  6 Jul 2021 22:29:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so1160979ota.4;
        Tue, 06 Jul 2021 22:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2/VCny+7roa/qDx4+LioHYLuiJaBAqS67A/5Ibrteg=;
        b=TgNlxfAa2KumScY0vvuJn19IDDZ2xOETgMzWcfQE7PyXL7wFwzIBZAiRAKJ2DqVJSQ
         8UKRw6Fmnxj+nwJtjuPyvWCCUQ8uRzQn26mHsPObP4Tbg6Dq5KVXgv/0qo8Rd0BOOjPS
         Aa7N8vAOP6q5rronoMtD6xpc59lJIRNNqayJGrXIwV3YztGb/fUm3Ytj4+7udLfMeeDU
         1RWGWW2p1NTiDDPctah2Nhdxqm0f+qGwZ/jZtHWFzvtLEnEjIr2GCXCJNUdDbq5wQJ4O
         z+Sr84AD5/pGWLoN4LUr8AYUAAwRespO5n9OXXymCOe5WGLTFjnhLvoZsbd9JW4QFj7Y
         fwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2/VCny+7roa/qDx4+LioHYLuiJaBAqS67A/5Ibrteg=;
        b=bOwSTvbEo0FAH8KPpatS44gKJ1iz6NWFTntSlrFYKr8zjgqUFJP4LtDE7HTs9U10G2
         aCg9YKZGUH5/dtvA8eWzwxYxUo9QPNxiG4nlp172LJItZEqcw+eKKTXylC5MSN4tmWPD
         j1biZ9yep4YdgD3nnvKJRU3WeAqyXIPXy39FXR47HjkXGv0Ix7mdf81FBjW1fkRFz1u+
         tQnZOcOB4zo4LUxwkXFaYuXNmQGLeRDur1PvUwsibB1fQAiZyCkUk0YPrGh/eDerBCz3
         sw4MwW85+gt/OfhEBz6O7FiqdZxfXyfSqBg3ft055JF6wfRnsuf417nsfLmNGrc/c1WV
         VzkQ==
X-Gm-Message-State: AOAM530yLNR27EJA2XbIPJ2pbre2o6Ff2ur+A24vvgJXZLn0vPuiJ+Ev
        wG858MSRB1aGC9NEQceUL875B7l64fA=
X-Google-Smtp-Source: ABdhPJyzGSny68ABQAWfOVo8CAV4au7CH2TggC3mgVuABwbJfXC9CqceP+JMeVdhAddvTzzCvYLm3A==
X-Received: by 2002:a9d:5545:: with SMTP id h5mr13867701oti.333.1625635797589;
        Tue, 06 Jul 2021 22:29:57 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:57 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 6/9] mmc: handle error from blk_ksm_register()
Date:   Tue,  6 Jul 2021 22:29:40 -0700
Message-Id: <20210707052943.3960-7-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

Handle any error from blk_ksm_register() in the callers. Previously,
the callers ignored the return value because blk_ksm_register() wouldn't
fail as long as the request_queue didn't have integrity support too, but
as this is no longer the case, it's safer for the callers to just handle
the return value appropriately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/mmc/core/crypto.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
index 419a368f8402..c87be58a5548 100644
--- a/drivers/mmc/core/crypto.c
+++ b/drivers/mmc/core/crypto.c
@@ -21,8 +21,17 @@ void mmc_crypto_set_initial_state(struct mmc_host *host)
 
 void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
 {
-	if (host->caps2 & MMC_CAP2_CRYPTO)
-		blk_ksm_register(&host->ksm, q);
+	if (host->caps2 & MMC_CAP2_CRYPTO) {
+		/*
+		 * This WARN_ON should never trigger since &host->ksm won't be
+		 * "empty" (i.e. will support at least 1 crypto capability), an
+		 * MMC device's request queue doesn't support integrity, and all MMC
+		 * devices that currently support inline encryption also satisfy all the
+		 * block layer constraints (i.e. support SG gaps, don't have chunk
+		 * sectors, have a sufficiently large supported max_segments per bio)
+		 */
+		WARN_ON(!blk_ksm_register(&host->ksm, q));
+	}
 }
 EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
 
-- 
2.25.1

