Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1711C438396
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 13:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJWLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhJWLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 07:54:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A2C061764;
        Sat, 23 Oct 2021 04:52:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so1641759wrv.9;
        Sat, 23 Oct 2021 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5g7LNB9PKrMXYsm9B8HodKHsmgzIAvDx8IU/Xp0JoTg=;
        b=b4RP+Zp6Om8EpLnADXuM6Yvvr0IVFuwSNqiYTXgzi7fZ5dkakWbzLdwUOfbyinlxQN
         q9OyXN+GcGc/uKnBvypCvGAlhx/vE/NCS0J024a/3J0wy+dPKXXx1OMsFDP+KM6i7rFg
         slo1BaIB6SnYcUx2xB1fUq76h9Y/rA46Y+Idby6hb+e0GMLXbBsCkpea3gGhbdP0mUxD
         o59EPzrY6U+VTqpJ+zYPGbsd8KoxnEk1Lq0nG++Wq8NgS2IogWwUQYL4kN/YlNBwibko
         QjxMMqgUtK8vapnLPmfQ63X23EYy9WFDq3S33lnMr4aIWMt11gI2oodiMbTRNW3uVLsu
         fvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5g7LNB9PKrMXYsm9B8HodKHsmgzIAvDx8IU/Xp0JoTg=;
        b=06pJPaOY/ZAApr0DRuNOr944qcmER5gZecYSOFqKKJsLzDOOFZTTTr26y8XEJ0B2Ve
         wN8/O1a/uzdxWpsoJTL2xEYnOgMqFtlm/40przpGXo0KSCTMdNiYvKN75Bw5AxQX2MXs
         MWuhaNIkNCHLYzyL8oRLz8PTL9bF+kwhjM3l4Zq0UljfjxY4Iaq60/GigYhyVKww4FAL
         7goka78UeOwZwE0Q/zfL5pkENFhKXQN/9eY2/4Ph7S+QdgjUo7snpV+PhNfnZIZM9BCy
         lDp5OLRRjXV/s+AaPM7Yv68Z9u41wv9mJCl8sOf3G1s3bvxAbGC97dUL9zvEl1rNYr7m
         DNMA==
X-Gm-Message-State: AOAM531vJEzhALgk8uVcWQsz3pce0RBes+k3O0lxOiG226tkmgVE9JLe
        cJuJoIntbGnWsLCezMSySiSVXi0Mjg==
X-Google-Smtp-Source: ABdhPJyMOSbjzz7o7KoZBbz5NCagHo5vZTD9XLhdvIdeMwxA3+wK+2GbmIAUukSqDCow4Cdsd/Diog==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr3720392wrv.356.1634989930659;
        Sat, 23 Oct 2021 04:52:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u13sm11009791wri.50.2021.10.23.04.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 04:52:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] optee: Fix spelling mistake "reclain" -> "reclaim"
Date:   Sat, 23 Oct 2021 12:52:09 +0100
Message-Id: <20211023115209.19115-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are spelling mistakes in pr_err error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tee/optee/ffa_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 6defd1ec982a..45424824e0f9 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -333,7 +333,7 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
 
 	rc = ffa_ops->memory_reclaim(global_handle, 0);
 	if (rc)
-		pr_err("mem_reclain: 0x%llx %d", global_handle, rc);
+		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
 
 	return rc;
 }
@@ -355,7 +355,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 	optee_shm_rem_ffa_handle(optee, global_handle);
 	rc = ffa_ops->memory_reclaim(global_handle, 0);
 	if (rc)
-		pr_err("mem_reclain: 0x%llx %d", global_handle, rc);
+		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
 
 	shm->sec_world_id = 0;
 
-- 
2.32.0

