Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F318A349B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCYV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCYV1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4731C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w7so5661025ybq.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXfRUgmRe7kH6AU5n/x2XWTuNQDYYUL8f3DAKwSKEzw=;
        b=AnRR1mnKpdEoFdG1gN035lAY93R2KGeI6lEzSv4jdsznjZwNgsmypdE7iioWFPasJ9
         kkpo9QDUQhkLE5C/7Im6GCZo6xSTN4rTX93pOPcxYDT55LOOCRgw0oZ5Hl6+jy62ShYu
         6OutHCkIzXZoEU0+M0hWhBgE/PbHpI0Tv3Xc20Z50n1j891rZd1mijgvr8lVeuv649yP
         JGok9RRTZQ8m/AoapgbgajjfTsU+JR+/E5B0C6KuqYkzh7Vh5vYDsWGyARRnQ1bLwF9n
         7YhbC+dut7xa7s27Pv/EkiHvBju9UKIIgcaFyDyeJk6LvSYkF5dQX8znbwtFWD0PsWGi
         6/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXfRUgmRe7kH6AU5n/x2XWTuNQDYYUL8f3DAKwSKEzw=;
        b=DFHs+R8pDmNzna/I9f//OLnnh299LBN4uwHb1sXt3xivCOvXDVdXS55uA2bbGH5GDU
         3s3bvma5NOdXSJCgjQOTe7Dvh7MPXRuA7C3cSdIW49TtdUElGYQyvMDEL6ZBkkRbsfqr
         05/uWVF1h+sCLe0oiDtV34qTC1biOj/EzMKrQ6uS+bTR1Y22UK7Gyl916ADHEhU62sO6
         r04yIlcsb/AgShag5GSDqBKZeOFaIHX8VupSdg5x6wXjjnDtQTed6kl/t1rsmf97o+wk
         +PIhKnxY3LclUrECdSc7/FEi8Y4QaVfYDTi/lgqwolMTcl1j1PVD4uJQggAXs/dsHv7B
         cBvg==
X-Gm-Message-State: AOAM533sroM2y136DF97FnTrq4KM1uifmHZPecXJAvDrlB1RE17EJiY2
        OfDkoiQDzsxYc7YOSQSO1CoU/rWSWe4=
X-Google-Smtp-Source: ABdhPJz7DN29DrVMX+YcK1AWw6+N8szReisPV6zaP6Y2M4RZL7AZWIt95VSCM5um9M2HM8lBbP8Iet4DGCA=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:a0cd:: with SMTP id i13mr15307478ybm.302.1616707632232;
 Thu, 25 Mar 2021 14:27:12 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:03 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-3-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 2/8] dm,mmc,ufshcd: handle error from blk_ksm_register()
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
 drivers/md/dm-table.c            | 3 ++-
 drivers/mmc/core/crypto.c        | 6 ++++--
 drivers/scsi/ufs/ufshcd-crypto.c | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index db18a58adad7..1225b9050f29 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1372,7 +1372,8 @@ static void dm_update_keyslot_manager(struct request_queue *q,
 
 	/* Make the ksm less restrictive */
 	if (!q->ksm) {
-		blk_ksm_register(t->ksm, q);
+		if (WARN_ON(!blk_ksm_register(t->ksm, q)))
+			dm_destroy_keyslot_manager(t->ksm);
 	} else {
 		blk_ksm_update_capabilities(q->ksm, t->ksm);
 		dm_destroy_keyslot_manager(t->ksm);
diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
index 419a368f8402..616103393557 100644
--- a/drivers/mmc/core/crypto.c
+++ b/drivers/mmc/core/crypto.c
@@ -21,8 +21,10 @@ void mmc_crypto_set_initial_state(struct mmc_host *host)
 
 void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
 {
-	if (host->caps2 & MMC_CAP2_CRYPTO)
-		blk_ksm_register(&host->ksm, q);
+	if (host->caps2 & MMC_CAP2_CRYPTO) {
+		if (WARN_ON(!blk_ksm_register(&host->ksm, q)))
+			host->caps2 &= ~MMC_CAP2_CRYPTO;
+	}
 }
 EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
 
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
index d70cdcd35e43..f47a72fefe9e 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.c
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -233,6 +233,8 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
 void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
 					    struct request_queue *q)
 {
-	if (hba->caps & UFSHCD_CAP_CRYPTO)
-		blk_ksm_register(&hba->ksm, q);
+	if (hba->caps & UFSHCD_CAP_CRYPTO) {
+		if (WARN_ON(!blk_ksm_register(&hba->ksm, q)))
+			hba->caps &= ~UFSHCD_CAP_CRYPTO;
+	}
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

