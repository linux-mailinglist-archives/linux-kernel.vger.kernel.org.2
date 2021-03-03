Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02732BEF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576581AbhCCRrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbhCCOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:48:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28EC0613E8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:46:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e10so23729346wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQl7mbrrhEKHC32TkV4fz8OFde4Lv3Zz/lWsaXzMeiU=;
        b=jP6UzxQWWLZBBh1M+Mr7owpCzEHSd63thoMd19rKf62xiOl9dDBnKZ0en9mOwRrD1o
         Q5P5LKTT+tUTRE/6uSIHmVUWxV0qC4zUYcM7qV82ZnVZeWCeyaMAUmgJS+Vsd3ZRLjmy
         dZaOSh8OikJ2677ZdCplpZMPTxu91oBlWaPtHx5C+kP7XzMU+4S6k/wBms/Eg0a+tez4
         ZtFpbmbSE9Ri0YK40ds52QW0yx/wBkvPWKI8jrZlMQHnDlA/FKtwaDGHOfDcjqWnPAnV
         WGG/5fiZMF0Nzo0Grd+wyY55Pv0wn5FP7ovMaPJOf4qwXRGaRaWRTsc9lQhdPoPz+85l
         TmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQl7mbrrhEKHC32TkV4fz8OFde4Lv3Zz/lWsaXzMeiU=;
        b=onR/OIdmrTndBdTADxNDz/3YuzvZJvYPyRxZoeWqevS6a+C2dpNDbVJhtya9zkTasT
         WQSUIT4MZhO779jf4BcBalvKrTnVs8R+94XJVKX54+bsL9WixOg9GXxPojM7qcebw0cR
         SqLXlFD2Vst+TjIf/ipFBc536qGOpUgpMOYBOG+9UnKBH+Qk3LnyqPyP9kfhvaSfxF+0
         uM8pp5FysSoVYe1kL6cblB72zRzQCG83MDcUV3FCxjqD+3vOi9bGtyHrLVa7c/6Aomj/
         2L9CQE50JtP7jNgr6RaCcfx/CRuQnqJpUz3COpFo+yCEAhhTOx3kUNQfyjUqrs6O4YVy
         OKJA==
X-Gm-Message-State: AOAM531wcIjSAyOtt5dMkFHIoLkfOjsWOs7LyDQcM1dLZm5l2SdDRnJk
        4T33ypoM5hqFvHXNqMTcXU4Ekw==
X-Google-Smtp-Source: ABdhPJxoSvJV6na+LIJDkg36WaYm1zxX4VejesfMcT4qguGDAPY2K2EfM0rY+0T2Wz/oYqLtE80dOA==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr27327939wra.47.1614782809025;
        Wed, 03 Mar 2021 06:46:49 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:46:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 07/30] scsi: aacraid: aachba: Fix a few incorrectly named functions
Date:   Wed,  3 Mar 2021 14:46:08 +0000
Message-Id: <20210303144631.3175331-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/aachba.c:796: warning: expecting prototype for aac_probe_container(). Prototype was for aac_probe_container_callback1() instead
 drivers/scsi/aacraid/aachba.c:850: warning: expecting prototype for InqStrCopy(). Prototype was for inqstrcpy() instead
 drivers/scsi/aacraid/aachba.c:1814: warning: expecting prototype for Process topology change(). Prototype was for aac_get_safw_ciss_luns() instead

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/aachba.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 4ca5e13a26a62..8e06604370c4c 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -786,8 +786,8 @@ static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(stru
 }
 
 /**
- *	aac_probe_container		-	query a logical volume
- * @scsicmd: the scsi command block
+ *	aac_probe_container_callback1	-	query a logical volume
+ *	@scsicmd: the scsi command block
  *
  *	Queries the controller about the given volume. The volume information
  *	is updated in the struct fsa_dev_info structure rather than returned.
@@ -838,7 +838,7 @@ struct scsi_inq {
 };
 
 /**
- *	InqStrCopy	-	string merge
+ *	inqstrcpy	-	string merge
  *	@a:	string to copy from
  *	@b:	string to copy to
  *
@@ -1804,7 +1804,7 @@ static inline void aac_free_safw_ciss_luns(struct aac_dev *dev)
 }
 
 /**
- *	aac_get_safw_ciss_luns()	Process topology change
+ *	aac_get_safw_ciss_luns() - Process topology change
  *	@dev:		aac_dev structure
  *
  *	Execute a CISS REPORT PHYS LUNS and process the results into
-- 
2.27.0

