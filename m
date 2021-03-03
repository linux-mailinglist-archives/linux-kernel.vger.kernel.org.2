Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2432BF06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577188AbhCCRs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhCCOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:51:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD20C061A2D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b18so17491180wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JU+OzGlISHB+ge1qgBUvVjRrdCnCO3htiJjDL9pREeI=;
        b=HMc50qQh9cd09cYIG6QD01/h5niTz8bCPw+HzI7Uoq2lfsa5UdM82wOWPB4CaMvNCB
         D12iH/DnSU77N2Wqbifg4N4gogw7biGBujJaDOOOiGZhRwfOO9/+QwDOIsjZ3A2D39sd
         AGaYWCydcZHeKZSrddaxPyCsL15QNbl9PodDCfhfbujtibFR27Sz7pNwfQX8x9JWpuTY
         jhpgpYvM0NrNPI3eRk3SCJRj4XKVTE9doLezAu3T3lLtPAXeZwbKnc64RqecWYidCBTK
         OOluURq+Rj5P4br22cS8LNl8wuFHlc6nCUh5hVplBTIqdybzDQH22lNeleZDOjJULbAO
         /DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JU+OzGlISHB+ge1qgBUvVjRrdCnCO3htiJjDL9pREeI=;
        b=G1x/ePcWBPkiyGXMTZvW+4j2IaKCRsyibFDDaVb7VG3Ueq6Tp5EDs2NC6BeJrQbnZu
         gXaY4Oa2qmS7bcLj0UP81Y4K657uX52c5ZS7teJ/XMe9fjEJxaaxVGkthYX6ZT1/48+q
         KqBttr8IZgY7SQPTfig8+43QXwoaGnAynlbOZd+ufASv7ApMvNfEeqAuyhFWNcBDjcNf
         ZtvgnlHR7mTg+0YIli0P3NOXxv/BBEuffeSeoq4OC/2nBOPj9QwYJ2v6hiq/59rXjaHi
         0cba7tKJOSzr3hz5IbvoFWypv/kTdITwH798ne4CapGtLhePrk/l1M5Dh+ovPObhj6Jb
         B+hg==
X-Gm-Message-State: AOAM5337cp99u/4BRfcnOl/vZkEN2Y0Mqxi0dl2vJBkqFMUlKDcGF/JV
        IB0IMe9sF+Zbmdrx831sEuE1gw==
X-Google-Smtp-Source: ABdhPJxhtMo2M6F/ShADs7uYEfBexSffsMa/v3IkcujKLhJKFjIkQau6EXGVtp2IPZS/6KsyLAriMg==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr28035909wrl.344.1614782862246;
        Wed, 03 Mar 2021 06:47:42 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 24/30] scsi: aacraid: rx: Fix misspelling of _aac_rx_init()
Date:   Wed,  3 Mar 2021 14:46:25 +0000
Message-Id: <20210303144631.3175331-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/rx.c:544: warning: expecting prototype for aac_rx_init(). Prototype was for _aac_rx_init() instead

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/rx.c b/drivers/scsi/aacraid/rx.c
index cdccf9abcdc40..e06ff83b69ce2 100644
--- a/drivers/scsi/aacraid/rx.c
+++ b/drivers/scsi/aacraid/rx.c
@@ -532,7 +532,7 @@ int aac_rx_select_comm(struct aac_dev *dev, int comm)
 }
 
 /**
- *	aac_rx_init	-	initialize an i960 based AAC card
+ *	_aac_rx_init	-	initialize an i960 based AAC card
  *	@dev: device to configure
  *
  *	Allocate and set up resources for the i960 based AAC variants. The 
-- 
2.27.0

