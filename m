Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25432BF23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577868AbhCCSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359690AbhCCOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:50:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC10C0613BD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u16so5969836wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDE9Hso9rTWT1GYUBR1hNJUg1ULbOjkFaTyN9Yx/tJU=;
        b=Ay4gpWRdV55KCDG5yeY+hI0q+5Y4Fa/UHNNLmN9p+xw6ttt7Od+kE21YM2LRh0rhwR
         GDyRAWBbJ9SFTJ8VYueqVHNtBqaFns7eS1Xvj7/s9DpkE1ucIgvp0GwCfDRDTeXUb9WR
         iCzK0Vo2pMUpOgKvDqIqhJUMi0kC1C7XtHzx63HC57Oc9kKSgys7yo/GOJmBk7ZvGWG1
         KcWocQ4VjLi5aeh7bcnsBRA04tSITnca0pR8TeC7ZwNoploKJQ6CzZGnT+eepODpPhNE
         O4NSiVSDOvM3ilEDpTpIax2oB3UR3KNDAGP+WgddgBqFg2SHOeq11xISLOHJDGvOy/c9
         cUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDE9Hso9rTWT1GYUBR1hNJUg1ULbOjkFaTyN9Yx/tJU=;
        b=H54VbFt+py7pQgcKBXQjBdGEHhM3ks2eCm5AXWo6HTiwih1fw4FlZQF0WrE9X6ZNkp
         bHOtW4jfvCxY3dTCF5SPrJv4bss7ZB8kFkqZ2J28d/kdAtVarn9nTZ26s8/PG4v+dR8c
         BzDDEGuVAr4TLaCtY1uzyeKpZTDrx20Lucl3ZkZoda0u7wjs3g80t4eItsS+4289jaaY
         yfA0mwHo3Wiu9DZ5mw+Kdh2z4QfMVr9UI98JE4s3L/7qbv+P+MGuebVwBaGNzZHcmobQ
         TQBkghaRVEYp4cTGC20K5kLcwqXtlNi9LTzeIwauCQqchlxyvT/njnh2au0m33zJk2yP
         9vLg==
X-Gm-Message-State: AOAM530NFUTvYSRDwY+kJK8DmME4+uqZtnuaJgEja0WTwJgqFIo+I0n0
        j9CS/2xuH5reEeOPAozYvXyGeQ==
X-Google-Smtp-Source: ABdhPJxGkO2wN5DSSua5V4AC/FHxC3IVSL/vCIJa5Px6KbB1NQlcTLKWka4biT2QL1cGujHEIE6dqg==
X-Received: by 2002:adf:c101:: with SMTP id r1mr27901092wre.38.1614782847631;
        Wed, 03 Mar 2021 06:47:27 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Prakash Gollapudi <bprakash@broadcom.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 20/30] scsi: bnx2fc: bnx2fc_tgt: Fix misnaming of bnx2fc_free_session_resc()
Date:   Wed,  3 Mar 2021 14:46:21 +0000
Message-Id: <20210303144631.3175331-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bnx2fc/bnx2fc_tgt.c:831: warning: expecting prototype for bnx2i_free_session_resc(). Prototype was for bnx2fc_free_session_resc() instead

Cc: Saurav Kashyap <skashyap@marvell.com>
Cc: Javed Hasan <jhasan@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Prakash Gollapudi <bprakash@broadcom.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index a3e2a38aabf2f..9200b718085c4 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -819,7 +819,7 @@ static int bnx2fc_alloc_session_resc(struct bnx2fc_hba *hba,
 }
 
 /**
- * bnx2i_free_session_resc - free qp resources for the session
+ * bnx2fc_free_session_resc - free qp resources for the session
  *
  * @hba:	adapter structure pointer
  * @tgt:	bnx2fc_rport structure pointer
-- 
2.27.0

