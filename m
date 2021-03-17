Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB733EC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCQJN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhCQJMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF3C061763
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t9so996179wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TrWWm0u4bkRuEOT45xP86ethIB2XLy+WRaBoR2YJ+Y=;
        b=VIU7VFuz5FaJXnrl9FYPf3rxVYPBQWgLnoJoYBjIu9hzCiLb2B7JVy56eYs6thk9pp
         nh8uALrJCoQWEGtoLIqMttVd2Gsig45UXefS1V8Dz6B4oPieaTqX8td379g90niYUFbJ
         goG0QarAtS3jmh6e5kQmM+C6LHSBySWO7ovtr3QSVC21mDhxEIgSFY7Uzb0GMeb5Vt51
         K1zcE86PVNtkzSMJjp0c1Ba/1iClc4t/qBAVz5PPxLKbMZPJp0Elc2TonTJREObJc3Hi
         JFngZUqZhXxF8RS+wR8kjCNsZi7mfDYTaQDlgCnkV6bAsIsEvcMnSRdzBJdcjFI7Pbb8
         As0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TrWWm0u4bkRuEOT45xP86ethIB2XLy+WRaBoR2YJ+Y=;
        b=HyiMj/0u2Gvbih/MFQMji3bJxG8gcemu/1NchbG6+8bqKD2C0uHUupKFlGZ8xf5IIw
         hgnDdQKQQFT5Oz1V8zzjW+6cqIDpaNo86cg+WSQB2pahofQqIfemoKbSt4uDr6vUHE18
         0cwxQqDauzAGK70oMI8O/xCmgF53ML1w0iDrRLB57EIE66lkKeHsEhsvmp0SFoYuG1nP
         lJ0L2YQDecRus24BYJCaoiik4/bZeL0pY/isnZoq8MB1wJpbrAwHQZWu0Q0Y+X+A7LZ7
         O0i+zUAHqbW2uMpwCtkmxCLAQyV255GGiZsVgvNifW4KUZvzmbad/SEVH03hgUZf25Jt
         wZtQ==
X-Gm-Message-State: AOAM532PZFRc2mKkHgyAlz/sxK5QKUNuozhMH7X1ysfnE+kkodTWS3aB
        d9Yk+7M9K9+wyiEuyed7C9htGg==
X-Google-Smtp-Source: ABdhPJwBBf2pDosK0iW19obpUhKOTMSrb6xpMCOntwaCTpUr7GR90px+cj4jvKue9GwRILV9AXevtQ==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr3375157wrn.346.1615972372441;
        Wed, 17 Mar 2021 02:12:52 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux GmbH <hare@suse.com>,
        "Leonard N. Zubkoff" <lnz@dandelion.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 12/36] scsi: myrs: Add missing ':' to make the kernel-doc checker happy
Date:   Wed, 17 Mar 2021 09:12:06 +0000
Message-Id: <20210317091230.2912389-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/myrs.c:1965: warning: Function parameter or member 'dev' not described in 'myrs_is_raid'
 drivers/scsi/myrs.c:1978: warning: Function parameter or member 'dev' not described in 'myrs_get_resync'
 drivers/scsi/myrs.c:2002: warning: Function parameter or member 'dev' not described in 'myrs_get_state'

Cc: Hannes Reinecke <hare@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linux GmbH <hare@suse.com>
Cc: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/myrs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 48e399f057d5c..588c0de006b02 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1958,7 +1958,7 @@ static struct myrs_hba *myrs_alloc_host(struct pci_dev *pdev,
 
 /**
  * myrs_is_raid - return boolean indicating device is raid volume
- * @dev the device struct object
+ * @dev: the device struct object
  */
 static int
 myrs_is_raid(struct device *dev)
@@ -1971,7 +1971,7 @@ myrs_is_raid(struct device *dev)
 
 /**
  * myrs_get_resync - get raid volume resync percent complete
- * @dev the device struct object
+ * @dev: the device struct object
  */
 static void
 myrs_get_resync(struct device *dev)
@@ -1995,7 +1995,7 @@ myrs_get_resync(struct device *dev)
 
 /**
  * myrs_get_state - get raid volume status
- * @dev the device struct object
+ * @dev: the device struct object
  */
 static void
 myrs_get_state(struct device *dev)
-- 
2.27.0

