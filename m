Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1398533ECB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhCQJOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCQJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:13:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD5C061762
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v4so992514wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCn5H1/QIbfIGeplEbT1o6zOISUD7vSXkO5mBkf4PfU=;
        b=Z23F2lfnZHIs7s7AqP3HTgAl6LmZWclA5RVsNpn8IsUOzzgA/Y1G/xEywmR5rTZURj
         LDpoYlz/DT9LnOkK4VHUBY8u/JOiy1wseCY0kEvoUZFQzK8ZKAH+8s59Q594l0parmKx
         +v4E3ZWFOhNfyFKUy+nR7yoiiF/mfTN/WyzKrT6oQ73Q58UgHO/s4RfXPO+qvl25fLp1
         F9S6AwqR/ziE3kPa/lVy8JPH/buY0YVMY/9NlGibqSWEe4r4h4dVaZi5RanB89O+LHvw
         tqPpZGm4wZm3TKj6qDr0inGpBV8zRZ/rpx3yHxRxAgfLdghkBFMzOzR4W55xvI1MrOFl
         pnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCn5H1/QIbfIGeplEbT1o6zOISUD7vSXkO5mBkf4PfU=;
        b=hegIOl3Mc5kYn/wI9LaQh8tkIo3nEJXWxOJZvg4YBKN2gQI43/RSz3qaK59nk/kF3r
         J/n2j+wkcuxejIhfhv5XQYhOtv21Km5uhaoZAbkuHzssqWBS6K3vCa5GpyooXphWMU85
         MyjXhfFPJKJwyleM+VVEJfQL+3T6jImLXeR/TsxMapWX31eXGIwsXiXhc/Ye2/zt0l7P
         8dbZQbiQeGluXPibxvfVBDEeNFf+/Ka2B9Inxwcce6mpdfwgytzdEWACkgYiYbK7yk15
         +9QGDHpwjYr8ehBKWDwYHLfdfIRseA6N4ck9QHFKlPxMbRtBhLTyyj+vo2wP22updsle
         GkjQ==
X-Gm-Message-State: AOAM533Eu7E6aj/6Y3c94Kp8lfdXVybSjULxI1mXafJ4tb3SC54EQTM7
        hH/jrV6uMPFn/CBGr51TGa/dxw==
X-Google-Smtp-Source: ABdhPJxRav9dSnwsd2DWKrGi/Awk4vHnMvcslJTEsCpGHU6jEtb1uuH3ikGUKdTXwYpH5pu1l+qP2g==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr3196351wro.324.1615972396331;
        Wed, 17 Mar 2021 02:13:16 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:13:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 36/36] scsi: cxlflash: vlun: Fix some misnaming related doc-rot
Date:   Wed, 17 Mar 2021 09:12:30 +0000
Message-Id: <20210317091230.2912389-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/cxlflash/vlun.c:48: warning: Function parameter or member 'release' not described in 'marshal_clone_to_rele'
 drivers/scsi/cxlflash/vlun.c:48: warning: Excess function parameter 'rele' description in 'marshal_clone_to_rele'
 drivers/scsi/cxlflash/vlun.c:238: warning: Function parameter or member 'bali' not described in 'validate_alloc'
 drivers/scsi/cxlflash/vlun.c:238: warning: Excess function parameter 'ba_lun_info' description in 'validate_alloc'
 drivers/scsi/cxlflash/vlun.c:308: warning: Function parameter or member 'to_clone' not described in 'ba_clone'
 drivers/scsi/cxlflash/vlun.c:308: warning: Excess function parameter 'to_free' description in 'ba_clone'
 drivers/scsi/cxlflash/vlun.c:369: warning: Function parameter or member 'lli' not described in 'init_vlun'
 drivers/scsi/cxlflash/vlun.c:369: warning: Excess function parameter 'lun_info' description in 'init_vlun'

Cc: "Manoj N. Kumar" <manoj@linux.ibm.com>
Cc: "Matthew R. Ochs" <mrochs@linux.ibm.com>
Cc: Uma Krishnan <ukrishn@linux.ibm.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/cxlflash/vlun.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/cxlflash/vlun.c b/drivers/scsi/cxlflash/vlun.c
index f1406ac77b0d5..01917b28cdb65 100644
--- a/drivers/scsi/cxlflash/vlun.c
+++ b/drivers/scsi/cxlflash/vlun.c
@@ -41,7 +41,7 @@ static void marshal_virt_to_resize(struct dk_cxlflash_uvirtual *virt,
 /**
  * marshal_clone_to_rele() - translate clone to release structure
  * @clone:	Source structure from which to translate/copy.
- * @rele:	Destination structure for the translate/copy.
+ * @release:	Destination structure for the translate/copy.
  */
 static void marshal_clone_to_rele(struct dk_cxlflash_clone *clone,
 				  struct dk_cxlflash_release *release)
@@ -229,7 +229,7 @@ static u64 ba_alloc(struct ba_lun *ba_lun)
 
 /**
  * validate_alloc() - validates the specified block has been allocated
- * @ba_lun_info:	LUN info owning the block allocator.
+ * @bali:		LUN info owning the block allocator.
  * @aun:		Block to validate.
  *
  * Return: 0 on success, -1 on failure
@@ -300,7 +300,7 @@ static int ba_free(struct ba_lun *ba_lun, u64 to_free)
 /**
  * ba_clone() - Clone a chunk of the block allocation table
  * @ba_lun:	Block allocator from which to allocate a block.
- * @to_free:	Block to free.
+ * @to_clone:	Block to clone.
  *
  * Return: 0 on success, -1 on failure
  */
@@ -361,7 +361,7 @@ void cxlflash_ba_terminate(struct ba_lun *ba_lun)
 
 /**
  * init_vlun() - initializes a LUN for virtual use
- * @lun_info:	LUN information structure that owns the block allocator.
+ * @lli:	LUN information structure that owns the block allocator.
  *
  * Return: 0 on success, -errno on failure
  */
-- 
2.27.0

