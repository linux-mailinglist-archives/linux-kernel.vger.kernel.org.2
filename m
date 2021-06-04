Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB12339C0F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFDUCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:02:16 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:64394 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhFDUCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:02:06 -0400
Received: by mail-pj1-f73.google.com with SMTP id h32-20020a17090a29a3b0290161dfc5d1bfso6516882pjd.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kd1E77D6aPxR9eaBjS43P1vtWPIox0q43LsvhH1VUfg=;
        b=slBbxZ7y6pnAglU6rF2VZ7Pn/uFpNALrK5ZbJmvrcqUfyvWtXQ4DJzEXClxVSHSKV3
         j0rQodPMbpzXNW3zZ5ZPmY/UAaEYEl43nnkF6gvU2QI00dCLmKbZ89OHwqY+6EaXkFIL
         nsKVawzGjmYw2Y61BKJx9hPcsO5o0kGVoiCvlvwSuDWWw0l2XZiTOxCEVtik8mj/x484
         1++e5KQki6hBpinevssj6mAO8A7nwvBuJcb25kB+ff++tObZaFuKQ/OYy3Esgx4SV8ke
         /lWfjoDmxGeuuQ1sarp1OGCXpsd2Q1r9oDF0ys16ljSPzBvyJa2FSgJe0dD1ds3XxGA3
         e8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kd1E77D6aPxR9eaBjS43P1vtWPIox0q43LsvhH1VUfg=;
        b=FjaxZGkPHI7S9Qe69dWpWrgJKTVocQ1RPbwTWgyJ06yi8wX5Q9s4Zz3V03BNNWMIRl
         6hLsSHOH4jqNz+Gl+B6/X8oNqW0gX//qgnpsra7K5R5eTrqNgYQ75qlC1JJwG6oEuyjb
         3JruoRG2PEtioU+QMxSHknXDG2nubaowec4DLD5T4j+lXowc16IKHyStwPCw2uC+iUI0
         yeJApYE65NcIryh3I0DHdp/d23nYrMcxSSCuGnBZXMJRH5dWQgZaJo04pSOBYL7nOUnG
         213wf/VDxqaDe7C6olMtLhtulSRG4GCP3xIXzCT/R5uPB4J0jplqK6ciuMrOpp/IjZQh
         y5Iw==
X-Gm-Message-State: AOAM532JuCECaztVTiGUeSaaCqet5CksWXAlZWJIdBxWqStEI9+MGinn
        PBd+ylIuNkINFm7cG5FiX/8a5ZTI7Iw=
X-Google-Smtp-Source: ABdhPJyFd5ZwvoVxCS1V14luiBtciIHgcOru+4XK3wB3hc+geHyGYCQsnOy5fsYAo81EETM/7MtLS2AJewc=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a62:380b:0:b029:2e9:9eb1:ba71 with SMTP id
 f11-20020a62380b0000b02902e99eb1ba71mr6023434pfa.80.1622836759568; Fri, 04
 Jun 2021 12:59:19 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:56 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-7-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 06/10] ufshcd: handle error from blk_ksm_register()
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
 drivers/scsi/ufs/ufshcd-crypto.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
index d70cdcd35e43..0fcf9d6752f8 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.c
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -233,6 +233,15 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
 void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
 					    struct request_queue *q)
 {
-	if (hba->caps & UFSHCD_CAP_CRYPTO)
-		blk_ksm_register(&hba->ksm, q);
+	if (hba->caps & UFSHCD_CAP_CRYPTO) {
+		/*
+		 * This WARN_ON should never trigger since &hba->ksm won't be
+		 * "empty" (i.e. will support at least 1 crypto capability), a
+		 * UFS device's request queue doesn't support integrity, and
+		 * it also satisfies all the block layer constraints (i.e.
+		 * supports SG gaps, doesn't have chunk sectors, has a
+		 * sufficiently large supported max_segments per bio)
+		 */
+		WARN_ON(!blk_ksm_register(&hba->ksm, q));
+	}
 }
-- 
2.32.0.rc1.229.g3e70b5a671-goog

