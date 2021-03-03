Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF09032BF17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577647AbhCCSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbhCCOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:53:41 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B1C0604C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u14so23988576wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nQ26BmiCafa3FcoFatnT2ebufwkcfecUnddyGMPtQw=;
        b=ekehDAxn4FmhM98+yYpuGr+pA1hZiyxKHaz1+qp1m9jcuqFRBZQsPLha7siQv0+1AI
         UcB0fGztuRW2T/+vypyQ2fF/flUEcLr2YxVrw7NGWFB8Qc5kOp/lUj/AlXGGLz0ozNRU
         2v6vt12cwVQbyoKU1wSUPesepL8hNle0APTEXZEVgDmrwhnz6OSv+d1p0yjI7AjykTXs
         hYq6AckV1NKVnpq7gUULvwJje5EYarukB0/FBNMnqFknQdDpKgkScPj6lQDSeyw/LDtJ
         4X/A1PmKxfjass0cgIkKvsDDyPl+7qYdUwiMpstxELNBsc1SWI269fZ8fL0PnuCH9g5d
         5XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nQ26BmiCafa3FcoFatnT2ebufwkcfecUnddyGMPtQw=;
        b=rakS8pXclkuehXjyuvuFNhAC2GyB2i6A/qCAY1EO/huA37sb09cRFnjeS5vMG/HD0n
         bm6hAP20sO1VpycdITBbwgVXXO45EUqT1IaHs8/PLLQPX3KbHzgsNuI+0zCu7L1wj5/d
         RJQoLOI7KoBA8o1um9B2Uq2IQ+bw6MCpTtPVsZGD28ftcg3M6MQancmt16j/YuWNWSHs
         MUmue55tUhmodiVeZsSW+n34U1UlTBhoUrRLplNehQOl7Zhb8WsXhamOdRRIHpxGUbYL
         dTx8k6WhoH5vMqY8TWkbNLGByAJyEz4RJu2NZQ5dBr4j5iZHuJSAO3FVPTqcDgty5w6f
         7Big==
X-Gm-Message-State: AOAM533FgTMMrir4Rw1l9a70UqhtcNSM8+b5UIxqosfmrlFuYgIdegOf
        +B1wJ2gd4Zk+3VbUZUwFbMGBLQ==
X-Google-Smtp-Source: ABdhPJwRp4SUIDdZh0ks87Egn0EpEVb1DjR0onSjQk0goGxGTDAmM9M6831gGZ3GEUPi/6eeuMGsNg==
X-Received: by 2002:a5d:544c:: with SMTP id w12mr28465741wrv.310.1614782866386;
        Wed, 03 Mar 2021 06:47:46 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@avagotech.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 28/30] scsi: mpt3sas: mpt3sas_base: Fix misspelling of _base_put_smid_default_atomic()
Date:   Wed,  3 Mar 2021 14:46:29 +0000
Message-Id: <20210303144631.3175331-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/mpt3sas/mpt3sas_base.c:4185: warning: expecting prototype for _base_put_smid_default(). Prototype was for _base_put_smid_default_atomic() instead

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MPT-FusionLinux.pdl@avagotech.com
Cc: MPT-FusionLinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 504ed856d4797..69586ab16cb65 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4172,7 +4172,7 @@ _base_put_smid_hi_priority_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 }
 
 /**
- * _base_put_smid_default - Default, primarily used for config pages
+ * _base_put_smid_default_atomic - Default, primarily used for config pages
  * use Atomic Request Descriptor
  * @ioc: per adapter object
  * @smid: system request message index
-- 
2.27.0

