Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC28832BF56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835163AbhCCSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244820AbhCCPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:11:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501B0C0613E1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:46:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f12so20166243wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFi9T+E/g8V3YsAnSZJJVAc9TXJo52o0NpqktVEIKdw=;
        b=ZYh5jmZHnR3UgmUDrFZUwUXHTN8rG1lpAeCiLfkVk9wOllZP5B463CAeaE5CPiTXBU
         PaTq0vpL/WvMIVCrJYsTd+pzenjEU8khfmgTqOO/tIPAlUxH8evimfYnKpAV9rWLYmgn
         0Mx9jZPaVk6bqWHDW7FD8pU8UxX0Cg0M4ZyX60LoeCA4Ptpq6f+wV+BTqTmVBlFtWL1U
         5Sm+fPLpMJM74M5LwXxINJ0h7bfItbIlkq1FynPDAPq+GM8kZGez0JGWfYiWsOwiAos7
         LaV5E0NzoR5E8lrcq83Zaf9SKITfXrvj3c5+VL3jBoJOIeGTRCsLGuviwbiLhj9eVTy5
         6LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFi9T+E/g8V3YsAnSZJJVAc9TXJo52o0NpqktVEIKdw=;
        b=EQMUBz5Dd/7D9oIZ4Bm1x3t5/2/KgE9EjKfoOKRp9RhS5Uz6C/2O38VZ5lJLB1H5TC
         /OPVPIkqXS/ifugCZz2kADe6tT8rWb30n0bVn+UMlgOcR3b4XtRfHa8rOeSMb+gzvW4r
         +EoaZnQiFU+zobrAyWR9HOgOHC12pv5BHH++l+qdgFGhJJ3dtQn1xsQO0zIGhvIZKeZe
         qQhWSM87U0n38bIdkGRxQ02tlfJRgraWwfM8ma4hD5y8crgZHCOJeRiAWf0S2gD5hYlu
         q6PdEGNL0OwVbryQAanQYgdDQOCrk2I+5RWkMHG6LXxLGYfzNvF2XpMHpM/aq97h1mkS
         TCYQ==
X-Gm-Message-State: AOAM530GeN2NXFsSaAjswnj6rdRGUIexElofDMAF7JkSaBBjaBAOLTVs
        qvj15rIFXpAw9bSc8FpWkNxFxw==
X-Google-Smtp-Source: ABdhPJyFEYZyODmwSj8L4In3YWPgE8FpGflz9nPBfBP0ld8nT3CDiDCvShIovuKdMp8S9fyjSsQWKQ==
X-Received: by 2002:adf:d1ce:: with SMTP id b14mr27612863wrd.126.1614782803009;
        Wed, 03 Mar 2021 06:46:43 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:46:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Atul Mukker <Atul.Mukker@lsi.com>,
        Sreenivas Bagalkote <Sreenivas.Bagalkote@lsi.com>,
        Manoj Jose <Manoj.Jose@lsi.com>, megaraidlinux@lsi.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 04/30] scsi: megaraid: megaraid_mbox: Fix function name megaraid_queue_command_lck() in description
Date:   Wed,  3 Mar 2021 14:46:05 +0000
Message-Id: <20210303144631.3175331-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/megaraid/megaraid_mbox.c:1438: warning: expecting prototype for megaraid_queue_command(). Prototype was for megaraid_queue_command_lck() instead

Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Atul Mukker <Atul.Mukker@lsi.com>
Cc: Sreenivas Bagalkote <Sreenivas.Bagalkote@lsi.com>
Cc: Manoj Jose <Manoj.Jose@lsi.com>
Cc: megaraidlinux@lsi.com
Cc: megaraidlinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index d57e93872d7b5..b1a2d3536add6 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -1427,7 +1427,7 @@ mbox_post_cmd(adapter_t *adapter, scb_t *scb)
 
 
 /**
- * megaraid_queue_command - generic queue entry point for all LLDs
+ * megaraid_queue_command_lck - generic queue entry point for all LLDs
  * @scp		: pointer to the scsi command to be executed
  * @done	: callback routine to be called after the cmd has be completed
  *
-- 
2.27.0

