Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF432BF04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577159AbhCCRsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359588AbhCCOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:49:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92AC0613B2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n22so5409166wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHGLMgmESXIFZCs0JUgZJMepuDsyuMDs79DqzpopOh4=;
        b=lBZHN8bPn8ofPtdUDEJ9YHpgj9Y5X9y4JEPsFoxiXXsOoaBiEw7ABoTWgRRMkeTh4L
         L8dYeKAZ04n2f2OIyrIhaHoY7l++4dm/3AUZLiFo2dfGV/iEuQZP55N6fRrjG8zYkTWU
         euyHo8Yvjnd8bI0HMhSOOJI9oGLvDNM/A23TYmyn4Zmh2FrZzNSQ+nA0+5RQoe8eAUeL
         fhsF9IePdsCJfsqQeTNpErqcHANrWkvpwGb82NRgFMln2r4vEAv9tdBiLA+q29a+zmKF
         aX6v0Kc/1/Mg1A6sroXBtZSwvxYSDW6Xr7Qqts1qxZL5RY89YQppWO5OFg+1Zk2ctl/9
         WjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHGLMgmESXIFZCs0JUgZJMepuDsyuMDs79DqzpopOh4=;
        b=Ns2vT+3xelLaulf6yt3MMQo9KePgnb2lwhSepegqvu8e9oC0f6YAazHWCUiSQlTkkI
         tWydCDYV8meqOI0ATNk0keMazJHYleHyfAC4MsiE04SDBCulLaUBBveh3Hg98R6GTGcT
         rMOH2lYmElqvFXykGvhVm+RHyn9CjJSENabKKFNQV3Kx8Sv23Jb4QbeljRzKwXXlUOMh
         /+N5JxpOl5CRT5HM9cuXXnRNpP/A+CqcUdcblWivZre2XxWZRgEr/P0E/7XL57Wtk6I5
         VeJ1AdyFV8PemLFzYnV7UDdjcKg2rBDBUVnuCgx6E62tJqvsLgjwPyqz9trgJirVpvJm
         qlCw==
X-Gm-Message-State: AOAM5314IvN/9uJ4V25CPES9RlLASVaQvp3aWEGLJXkFltHjgJawnakU
        uKSQg4+7Z9/nIkxhXCuTciPw+fQElTdasA==
X-Google-Smtp-Source: ABdhPJwT5ycXh7v72pauBAfT/7F41M3dC7pMHTlOeEz2LNBHe69VWsAs12AKit5DPIkGD21Kk0wVyQ==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr9543941wmk.130.1614782842402;
        Wed, 03 Mar 2021 06:47:22 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
        linux-scsi@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 16/30] scsi: aacraid: commsup: Repair formatting issue in aac_handle_sa_aif()'s header
Date:   Wed,  3 Mar 2021 14:46:17 +0000
Message-Id: <20210303144631.3175331-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/commsup.c:334: warning: expecting prototype for fib_deallocate(). Prototype was for fib_dealloc() instead
 drivers/scsi/aacraid/commsup.c:1961: warning: expecting prototype for aac_handle_sa_aif       Handle a message from the firmware(). Prototype was for aac_handle_sa_aif() instead

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/commsup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 0ae0d1fa2b507..54eb4d41bc2c2 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -323,7 +323,7 @@ void aac_fib_init(struct fib *fibptr)
 }
 
 /**
- *	fib_deallocate		-	deallocate a fib
+ *	fib_dealloc		-	deallocate a fib
  *	@fibptr: fib to deallocate
  *
  *	Will deallocate and return to the free pool the FIB pointed to by the
@@ -1950,7 +1950,7 @@ void aac_src_reinit_aif_worker(struct work_struct *work)
 }
 
 /**
- *	aac_handle_sa_aif	Handle a message from the firmware
+ *	aac_handle_sa_aif -	Handle a message from the firmware
  *	@dev: Which adapter this fib is from
  *	@fibptr: Pointer to fibptr from adapter
  *
-- 
2.27.0

