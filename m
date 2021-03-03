Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3632BEFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576886AbhCCRr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343492AbhCCOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:48:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23536C0613F0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:46:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j2so11119416wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dlf3qjgdWUqI4rrG7I4PZpuEcemDbJUwXNtCIJSW+Q=;
        b=VRFsB6LsxDa4mu0P/0q40CbV2aqVAxp2BphRbLYBE2Pw1hA9l5ZafJhY3iNKUGG5C4
         0hoWWOPblsjroACqkfasVgWPXak7sJccOkIkEmY7unpV/qhaqfUn+f0mEQnnxu14GzYF
         yppzBvbbUnnvfsiuXKYuORDg8l5QD67qqGW1bSBt1ne/kzScXjELVwEKJKWHFRZlb6SR
         8JXmS/BdZ93z2rqJSj+9rb4muhY1VH0z86KzPtMyJg1TLeeiah5QXRZbWPNxJiuJlHDP
         NJsg1rr46qF/21OCg0E84/VAh0l2/B+gWWjWIr7IXfD221Q3AHgz8Gi4DFUju0jBQHBz
         rzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dlf3qjgdWUqI4rrG7I4PZpuEcemDbJUwXNtCIJSW+Q=;
        b=R2upcNMniNBQK6FXzgWL1OQvLHZos/55hwzWDkH8texcwnN9Uwf8eeGdGDOoRrMIuh
         49wnT12bRW+1aIMAy9rtcyMJVTgzyWycc8ZB9y59aVUIMfrnANFhSCebVjMHQG1vv9qQ
         zpjz579Aq3VRyBem7iboK7gzezmnDvbT7jf+SSIDd7dhVD+rzvAp7tbMwlpGdMYLGncw
         VHoR3lZZmlu98j5QOPHUIiTbV5L3IGH1/Q3YWqFt7YuqnGO1HOcI5N5tVvih09LYBjMw
         pRY442jm+tcSCs4ysv1Clx/D99518afNG/wBeM+/jM6wSG8tERp9poVZdSROb+bZ/v9M
         GeMA==
X-Gm-Message-State: AOAM5307gA0MbU6U/JTJZ3+VHuT7bqGKM7LV0YxbhUt1NkpQiCLLoOF8
        IdKtDVndjutXamJGOJ7UC8e52w==
X-Google-Smtp-Source: ABdhPJz/WYxvodqQ21nmeRvaNQXvGsQcURiK2zDbxI1ZoOdOVNEurMuEUdeHxSFNQjt0l7/GWMQ+Sg==
X-Received: by 2002:adf:a2d3:: with SMTP id t19mr27315610wra.299.1614782814810;
        Wed, 03 Mar 2021 06:46:54 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:46:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 09/30] scsi: aacraid: commctrl: Fix incorrect spelling of aac_send_raw_srb()
Date:   Wed,  3 Mar 2021 14:46:10 +0000
Message-Id: <20210303144631.3175331-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/commctrl.c:480: warning: expecting prototype for aac_send_raw_scb(). Prototype was for aac_send_raw_srb() instead

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/commctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 1b1da162f5f6b..e7cc927ed952d 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -472,7 +472,7 @@ static int check_revision(struct aac_dev *dev, void __user *arg)
 
 
 /**
- * aac_send_raw_scb
+ * aac_send_raw_srb()
  *	@dev:	adapter is being processed
  *	@arg:	arguments to the send call
  */
-- 
2.27.0

