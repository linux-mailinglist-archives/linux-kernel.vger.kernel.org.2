Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DDB38AF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbhETMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbhETMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B2C05BD08
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so15343291wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9y0gA0fQbXJNYgnBVvxDNn1I72crBojCN5pP1eoOBYo=;
        b=Dwjglu8dczKMPgon22oVb+PqpR5pfGiatS1J8lHv3Tm2d5IFGvKPpgDv/4ZMkOwPVC
         ZTaUDNJ0J+iL2lu+ytEGrHhNIoOGn/XJsKydfIy4ubJiGpc0FtKzCansYm/9za14wffG
         NcYRb4JImwkI4pwyBSu3qznpjTxSRX4StIAoslnQ46kBzQaUtJj6UOJ5NPcGtKOHjGq+
         0CgTssMzSA9521Q7OVGuKVlH2ogq9iSFRGYXHph8KNwU3gMZW4DCLZPB1MMIDvTm+v7p
         kEIMSQPM7sC8KoM+bPPRc5YEkeaIfzN4TGHTiqFxIcdJXl5Fy0X+Jf1ewskE8UmxvRYc
         339g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9y0gA0fQbXJNYgnBVvxDNn1I72crBojCN5pP1eoOBYo=;
        b=WUZ0LKBIQj/PbbQl7iaPTJqeZwAe6/uzCYkN9Q/u5DucsLURWdQrjDWbE6V5qpZt0i
         95EGt9a3QqS9V146nVZUCNCTELCtKeQv/3z5e6gB2nDZltykC8D8mbW5T7HjmvCWuaEz
         V1pFPUWvgFoVB00RhzieWat/D6cgdqPSpIADJDBlq53iT7UYIBM76+I2tusXJC2jOA3H
         /mLWSysQhu+DdlMaoppkNYAQ227i0g5s1AccAy06mzG+o8NqhwPEl+bs5Ab5RSZ79wIv
         J5T7AShdqdQdertUH/8VXb41qSxdso6Q7KoTR25IAowEsLAB3d9q9waf4tV4yhdE2Dec
         WcQg==
X-Gm-Message-State: AOAM530VT1ROhg93DKJUcUpDa9p56yTyjf0lqPcjkkW2CFaDtSmY+FWu
        M56GLoMB8/Qd7eHMsgy3HN/0vg==
X-Google-Smtp-Source: ABdhPJwaNdYgAYB+0XLU/rHo3whTXtJZreRhrDbouJQj0lUenFGdNCKjcXPpYdI64az4oL5s3RQdNQ==
X-Received: by 2002:adf:faca:: with SMTP id a10mr4047923wrs.9.1621512844027;
        Thu, 20 May 2021 05:14:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 08/16] char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
Date:   Thu, 20 May 2021 13:13:39 +0100
Message-Id: <20210520121347.3467794-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Function parameter or member 'dev' not described in 'ftpm_tee_probe'
 drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Excess function parameter 'pdev' description in 'ftpm_tee_probe'
 drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Function parameter or member 'dev' not described in 'ftpm_tee_remove'
 drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Excess function parameter 'pdev' description in 'ftpm_tee_remove'
 drivers/char/tpm/tpm_ftpm_tee.c:349: warning: expecting prototype for ftpm_tee_shutdown(). Prototype was for ftpm_plat_tee_shutdown() instead

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac69948..2d9c0ecd43f0a 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -209,7 +209,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
 
 /**
  * ftpm_tee_probe() - initialize the fTPM
- * @pdev: the platform_device description.
+ * @dev: the platform_device description.
  *
  * Return:
  *	On success, 0. On failure, -errno.
@@ -305,7 +305,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
 
 /**
  * ftpm_tee_remove() - remove the TPM device
- * @pdev: the platform_device description.
+ * @dev: the platform_device description.
  *
  * Return:
  *	0 always.
@@ -342,7 +342,7 @@ static int ftpm_plat_tee_remove(struct platform_device *pdev)
 }
 
 /**
- * ftpm_tee_shutdown() - shutdown the TPM device
+ * ftpm_plat_tee_shutdown() - shutdown the TPM device
  * @pdev: the platform_device description.
  */
 static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
-- 
2.31.1

