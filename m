Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC538AF29
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbhETMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbhETMvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D1EC06137C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y14so15343218wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=940Pm8CefdQzyyIg56xRkqD6T8o98OEZl2VZ5CfbfUg=;
        b=gsD4YvNGz6XEiS8m2K0f4bKq1QMIQRDXUhSl3sV8sFCEHSHo/Vqa4aqmflJzFfz7dB
         VRJ4K9DcbF+hkb08JKUH+rbVDcZamjjDFSjgXZ/v+3BAl8xb4WbRmaLJSps5pce0dEnS
         RuxwdEkiWfwm+aq24EO+8Sk2AKhpwUUfgQ0tNoogyN/G6W28VmfT4Ff5aWwg6tWWF/cq
         N3WdZdhAM6C52dFABJk16yJDMXcoeaVcnPMGIXX8Qe3A+p7Yl9rS9u6N1jkY8L4Qq5gK
         IvQzwPOwlUgYkcoCLxptgCPiQPXvOrL+3yKgAkEUCZw1bfgzRCMbyR23e19YGdjGAcWO
         8l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=940Pm8CefdQzyyIg56xRkqD6T8o98OEZl2VZ5CfbfUg=;
        b=XzhAr1rf6gzCPmpiSH4ToObmMFugLmGMRUsI9ZvXFNHtTIezcG/I8sFc3f3N6I5YO/
         oBYcwkrlcIXimiFOdSPT0s9Fa5UorNSQ9wYVIuDW6yJhRDhA1vjQPtLMIGChOWqwx0yH
         STC+faIf+E2Yp1XmWtd9F/1qIsVO+xcaDp1qVoPpXBykrAw0lhmu8PqUQF0l/cIYd6lX
         hEx6SEP9l+38Se0vqzSmnHKkK6IcovBbKWKDiWQeU4sSsxdo1av/aKwn1JBISKVicdcx
         d/6faYoibqPmcrJ8dMc01uYisgMpAVzGbofee2Zmy3YiN9JpqzJcR8eIMZqgc5lSkw3l
         lqMQ==
X-Gm-Message-State: AOAM530pYvbY2gGaNzJLRkv7tBk3DYSMCF9dAMTC8LQVe0cTFwaXrDxk
        luoUS9Pt2zp58dscYQFBzDHk1w==
X-Google-Smtp-Source: ABdhPJxZlfpA2q3fQh/gHectPuex1dWdbLtpJHYBH3TSDl/TuBOqqjGHREb245epFxVX90loTEAfFw==
X-Received: by 2002:a5d:5249:: with SMTP id k9mr4008493wrc.301.1621512842936;
        Thu, 20 May 2021 05:14:02 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        van Doorn <leendert@watson.ibm.com>,
        Dave Safford <safford@watson.ibm.com>,
        Reiner Sailer <sailer@watson.ibm.com>,
        Kylene Hall <kjhall@us.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 07/16] char: tpm: tpm1-cmd: Fix a couple of misnamed functions
Date:   Thu, 20 May 2021 13:13:38 +0100
Message-Id: <20210520121347.3467794-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/tpm/tpm1-cmd.c:325: warning: expecting prototype for tpm_startup(). Prototype was for tpm1_startup() instead
 drivers/char/tpm/tpm1-cmd.c:621: warning: expecting prototype for tpm_continue_selftest(). Prototype was for tpm1_continue_selftest() instead

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: van Doorn <leendert@watson.ibm.com>
Cc: Dave Safford <safford@watson.ibm.com>
Cc: Reiner Sailer <sailer@watson.ibm.com>
Cc: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/tpm/tpm1-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ca7158fa6e6cd..f7dc986fa4a0a 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -312,7 +312,7 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 #define TPM_ST_CLEAR 1
 
 /**
- * tpm_startup() - turn on the TPM
+ * tpm1_startup() - turn on the TPM
  * @chip: TPM chip to use
  *
  * Normally the firmware should start the TPM. This function is provided as a
@@ -611,7 +611,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 
 #define TPM_ORD_CONTINUE_SELFTEST 83
 /**
- * tpm_continue_selftest() - run TPM's selftest
+ * tpm1_continue_selftest() - run TPM's selftest
  * @chip: TPM chip to use
  *
  * Returns 0 on success, < 0 in case of fatal error or a value > 0 representing
-- 
2.31.1

