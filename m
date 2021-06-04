Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1939C0F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFDUCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:02:22 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42845 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhFDUCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:02:21 -0400
Received: by mail-yb1-f202.google.com with SMTP id 22-20020a250d160000b0290532b914c9f4so13155531ybn.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pgZaEyBtBsTzFRJDI8Jnnog0gKADt58CJnoqBCP+in8=;
        b=uUV7BqO4f+Zte/lFb383yyVYOK3VdXuD3Okwqz87OPd2B5NgUxxaz3ZxJyVyMfYOgY
         9ZE5AgKFLwNVu2wqFDTPs77c+t9PbozjYepuv1BD8/amxLlelOC4N762wZRM75mO3lVR
         +zfxCnxGAMJfSJ+A4aHfeATlTMM2VyItnu3Pr7UzFN7nJKdf26X8LdHY/maLK/99t0zt
         s4kaQhIr6a1YQEvCT11A5fhX0e19eKkFow3v7vcMQe0ZzksnSRmGjvJfxgn55pbpOshX
         84Qx/HB6cA9Sgnjpc1iG4+8J+p/foxRGtsH8ebHDgiauvDmr3kFmyDKFIgNT+WaUMdE9
         BzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pgZaEyBtBsTzFRJDI8Jnnog0gKADt58CJnoqBCP+in8=;
        b=Tv3ZYc8TGlDsFdXp/kvCnSx0/aeDiDuKVWQY2uZzOLzelcp9JIz0V+vmrW9CXfYVEA
         ZqWX1Mw81XcGazrFjLL3eB/D7ShoWrJE2mFS5wpuvdE/JIPFJEsxCEEzHzSeOVWj2rr3
         WzT6aZ3t4Z9OuAXa3r5iE5dTTWz4DrSr5+4Ic2VbOwXej1hxEDpt4TVXuut3Ld3eIQre
         1tJVcfO0n2Pesz3f3M+8LunKycoKhg1/hDBnIDcyBQs/xP/IwhStU5SP1lfLyheCdUi5
         mgl4UxxO7XcHL67gLy0NxEQk5jXFYQiO+EuCOR+I8mkPJ6laMKM7KvEnjvj6JQhdsWEE
         cdCw==
X-Gm-Message-State: AOAM533ByxKLhdMgm1l8uWUdSNZBwjz0iWDPCD/s/s3pP1SjQg8Zs/Ku
        PcU7dljA1gsI4C+3Og6VVl6XZSQfH+A=
X-Google-Smtp-Source: ABdhPJy3hxJvjiN/TAAfv2M9Py0zD+C14+X3vu2qbb0PQB99gWO5CrTeHtdS1YqnXjKPQIXY/tSGHL83z8c=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:4d04:: with SMTP id a4mr7276497ybb.311.1622836774525;
 Fri, 04 Jun 2021 12:59:34 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:57 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-8-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 07/10] mmc: handle error from blk_ksm_register()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 419a368f8402..cccd8c7d7e7a 100644
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
+		 * MMC device's request queue doesn't support integrity, and
+		 * it also satisfies all the block layer constraints (i.e.
+		 * supports SG gaps, doesn't have chunk sectors, has a
+		 * sufficiently large supported max_segments per bio)
+		 */
+		WARN_ON(!blk_ksm_register(&host->ksm, q));
+	}
 }
 EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

