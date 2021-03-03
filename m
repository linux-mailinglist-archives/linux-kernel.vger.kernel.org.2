Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956B932BEFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576934AbhCCRr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbhCCOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:48:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600ADC0613A6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:46:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e23so5393819wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vp3LPfDWxhdq4CveN15ZDZ5FBUzcaMZimN4dQHLGxEA=;
        b=U0t3uAQ1g04sV8BV3udjZX3FLFf7m9474Vpho7imY1X2KE7eofeW6q49vDhw/hQz+Y
         QClDNQdYSGdtzEjKxmTwHqipmi56/yu0l1y6dq72qV4dBoRXIx0DTSpTMkSLOSbaW/gg
         2mlTzK/hAtuoXindUm6/q579w/4/xdH6VWao6xlLmQHyTuejaumQfYdNtlTx3Pv64CsO
         +jcf71+zePwLC00WaR+8AMQXM6PKHGkWNbs2mAQeJJSrrAvZTCXL6z1+DWwnwAXQx0+/
         Rp28RPvUhO0iKKGfjR7ufQz64mM69E2bMD8kWgUfwfGDva7dYsgwxXdASdbWjSGt5Lqa
         ICaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vp3LPfDWxhdq4CveN15ZDZ5FBUzcaMZimN4dQHLGxEA=;
        b=nzQgVzdcTDuaTbNBydJkryG9PItS+ueuPiILguB+CVPJO3zkqUiM18hs80STNl5Ets
         JKLAisy6XVrevS+4mddQGXrgVEgBXjdFIYvfiyjGKDVlroc7HyZSf0J1IPkCyGg/4an0
         +2nz4hy5VfJbOFsBfg18FpPmA2MnBBCv7De//wTcX0Vy39H9dBFOXa3rPN59DWq+cHZZ
         OvqghWQ5EQjxf1kVxvPKaMeeRtN2BaBY2vd0cMi8FzCGIs066dqyd8ci8pr9XeH0BQqq
         8utxeOQ3X7pMpK8+U3DhJG9NXU1MC6k3Urwg8Cfb4l/AB0nq0B+jmIg+wSaBjTsaQgkE
         poCg==
X-Gm-Message-State: AOAM531PkIsRflHoO+v1qxCtd8g+T1Z1x6B7dpC7lkKhRuIR1PAuuIsk
        og1aV4O8k5MvATmmwNQbaII/bA==
X-Google-Smtp-Source: ABdhPJzy1ig3CiMz5pH8IM8oo6QRsHmv3YgS8sVxcDf9UGyBapGjgLkMoSQUT8Fxn/34Lvdo/cjCxg==
X-Received: by 2002:a1c:e184:: with SMTP id y126mr9487057wmg.163.1614782818007;
        Wed, 03 Mar 2021 06:46:58 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:46:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Prakash Gollapudi <bprakash@broadcom.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 10/30] scsi: bnx2fc: bnx2fc_hwi: Fix typo in bnx2fc_indicate_kcqe()
Date:   Wed,  3 Mar 2021 14:46:11 +0000
Message-Id: <20210303144631.3175331-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1344: warning: expecting prototype for bnx2fc_indicae_kcqe(). Prototype was for bnx2fc_indicate_kcqe() instead

Cc: Saurav Kashyap <skashyap@marvell.com>
Cc: Javed Hasan <jhasan@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Prakash Gollapudi <bprakash@broadcom.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index b37b0a9ec12de..0103f811cc252 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -1331,7 +1331,7 @@ static void bnx2fc_init_failure(struct bnx2fc_hba *hba, u32 err_code)
 }
 
 /**
- * bnx2fc_indicae_kcqe - process KCQE
+ * bnx2fc_indicate_kcqe() - process KCQE
  *
  * @context:	adapter structure pointer
  * @kcq:	kcqe pointer
-- 
2.27.0

