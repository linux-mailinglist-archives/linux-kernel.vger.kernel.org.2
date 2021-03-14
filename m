Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03F33A616
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhCNQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 12:33:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:33:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e26so5107838pfd.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqh8uRAc9wSSWjuXVMjvvDEKhTxEPbk8XqKk0z5UyJU=;
        b=k/oOQXEJcr3OC19xDkDQjmCRoeFafxUsokEk0VCuhReTrth5vTp+rNKVGOYKRVBM/p
         r726SbB42OUlI2RqNhOFgr6RZkIENttrdjSjUrteSQEGjXjkK/Tye2Q7OekvuDz1v7XV
         P2JLBRjIsoFJwSaRdZJgKy+W2e2nm4eb4m5KQR4T7xLLb2sVK8lO84InLAuTC8qlLLgd
         hFwySqLZOh6YtNid2LcaXfaF4I70qFOVJNEGI8usn7lQMmLr8tneBVXHoeMySbTXwDc2
         CNqOQTN9lzyOrHbxE6L+2rNvS/VaSuBJ37JsTZmh5N5ZTGU55Bvxic0NO2O5TkO3Kvmh
         UHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqh8uRAc9wSSWjuXVMjvvDEKhTxEPbk8XqKk0z5UyJU=;
        b=VWNXUmHzddpPBUoAT4yVY142gnxtee2KfH/MCgC53rznOcEIpZ6BKTLwwVwuYrVZay
         PP2P/qE4w21o3ZKiY6iSQ0XiOLE19IGuqqijfvFx/Y68GNQZI5a+p1M5KeXK25QGpR7I
         tFmYMmI06HhqmBV3LsS/dkkX65+fZ74snvJZaiabvtlGrY5TWFrc/Tdu+83kGe//0mSN
         MR1TdICUNNhht7vqdb1wvva2FyVJvRG4kwWfpsj2YQekJ0A79SJK/DFq6Foqd2uSxJK0
         jx8Bo6QNm9urxXt1Ob2hm7fKB5oTiunSn087JBSiPuAv4Jxw5rclSxX9TMyILhB9njHs
         XprA==
X-Gm-Message-State: AOAM532KSwATWSPT2gBsWnAnqMacIp6bmScs5gZqCx62ntkEW5vkzrxr
        ZgkWEyewuGW1pIp/+okNa9oiTFnb8KFnJcS+
X-Google-Smtp-Source: ABdhPJx3vPymGqhG6ZgMzyeA1zNIj216/lWGiLKAV5ovWyQ9G8lw6cW9WcAcblB1SA3OrTB/I1MGNQ==
X-Received: by 2002:aa7:8f04:0:b029:1f7:d71b:6a51 with SMTP id x4-20020aa78f040000b02901f7d71b6a51mr7114176pfr.4.1615739622611;
        Sun, 14 Mar 2021 09:33:42 -0700 (PDT)
Received: from ubuntu.localdomain ([182.156.244.6])
        by smtp.gmail.com with ESMTPSA id y20sm11217914pfo.210.2021.03.14.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:33:42 -0700 (PDT)
From:   Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     anupamakpatil123@gmail.com, bkkarthik@pesu.pes.edu,
        Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: tee: optee: removed repeated words in comments
Date:   Sun, 14 Mar 2021 09:18:50 -0700
Message-Id: <20210314161854.4541-1-anupamakpatil123@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the word "the" is repeated in the file core.c
so it has been removed. Likewise the word "of"
is repeated in optee_smc.h and have removed it.

Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
---
 drivers/tee/optee/core.c      | 2 +-
 drivers/tee/optee/optee_smc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index cf4718c6d35d..2ccb091cd643 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -422,7 +422,7 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 
 	/*
 	 * TODO This isn't enough to tell if it's UP system (from kernel
-	 * point of view) or not, is_smp() returns the the information
+	 * point of view) or not, is_smp() returns the information
 	 * needed, but can't be called directly from here.
 	 */
 	if (!IS_ENABLED(CONFIG_SMP) || nr_cpu_ids == 1)
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 80eb763a8a80..49e8e027dc5b 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -162,7 +162,7 @@ struct optee_smc_call_get_os_revision_result {
  * Have config return register usage:
  * a0	OPTEE_SMC_RETURN_OK
  * a1	Physical address of start of SHM
- * a2	Size of of SHM
+ * a2	Size of SHM
  * a3	Cache settings of memory, as defined by the
  *	OPTEE_SMC_SHM_* values above
  * a4-7	Preserved
-- 
2.25.1

