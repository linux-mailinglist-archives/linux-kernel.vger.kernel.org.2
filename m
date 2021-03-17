Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F933EC96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCQJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCQJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:13:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9430C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso2951478wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cUaH1b/K2O6ERJ+bzFiuL6brJDSqamBpVZhrZptGlg=;
        b=Im7bMn59N95huVs4Cu4fmRc+YGmxvRCVAMpXXHJhZWc1pJOWrIaZSXIMXl5w8V/lSr
         YJvntp3NAD6/3rrIW26RPA/WItV8qBpPgULuGC28khbozZ3k0Wat4XlD95GvkSkAcv/C
         m9I9ObxabwTJhuGmzCzb+q2778Y7BK4eg8xjD2eNFMcmovc078KN0GGDrR5MuMfEm50a
         tymDrTgN/8qneiFeUnZPu26PhGPvhZWbj9LIZIRCHW7UoMBpiwULAAe899JKIAj5ns7y
         GBvbRmTzzUbXt2Pm5fvtFywSkRAIhrl/c7jj55xm2xPaZIDxCWy/vgce1cC3REk9Wmc5
         fvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cUaH1b/K2O6ERJ+bzFiuL6brJDSqamBpVZhrZptGlg=;
        b=AFGU0HSf6zsQvdGiFKIqm8LkH60azPeF0zHeg400ol2CQw8t0L8Q0uBL4BbFNifMHS
         Mr2p3y43i5HSB2p8XkVCvgAQmb5SH3R7GnotFmxbMY888Ii1VBeQfggOjjV6d7G8H668
         vkyeCvP+VGKBMPrcB65u/MZW3zpruCvPUWmdO7KrzHA/BBkYfdEBjnpnkLlmUqFF99sR
         gtADSCe7u+Xm834fiFDAtRabeo57VG4jCKhAEW/lzM1G8ASvZNGbnW2sOFRVZr+1GBox
         iT6ozhgpCTFFAqihFs1WzAAv92QXTjXwq9IjssWb0vPEByQUhSl+zl9NiHL/SlcV+BNZ
         XNdw==
X-Gm-Message-State: AOAM531GciIZfpIqMQ1RF06PRcO9RBjoXxr1OT+WyCzHma2PGINHbgQM
        tZNaSJl+9UySmC0mqZNiUlBZIA==
X-Google-Smtp-Source: ABdhPJwIk5rpoN3LmJQkdEKCG9jZDzdAiOO4zRK9qdElTovUN0ILJhHR+J3PBnW2y3jZYlqEt4zoMg==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr2748623wma.39.1615972378673;
        Wed, 17 Mar 2021 02:12:58 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 18/36] scsi: fnic: fnic_fcs: Kernel-doc headers must contain the function name
Date:   Wed, 17 Mar 2021 09:12:12 +0000
Message-Id: <20210317091230.2912389-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/fnic/fnic_fcs.c:308: warning: expecting prototype for Check if the Received FIP FLOGI frame is rejected(). Prototype was for is_fnic_fip_flogi_reject() instead

Cc: Satish Kharat <satishkh@cisco.com>
Cc: Sesidhar Baddela <sebaddel@cisco.com>
Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/fnic/fnic_fcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index e0cee4dcb4391..881c4823d7e24 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -296,7 +296,7 @@ void fnic_handle_event(struct work_struct *work)
 }
 
 /**
- * Check if the Received FIP FLOGI frame is rejected
+ * is_fnic_fip_flogi_reject() - Check if the Received FIP FLOGI frame is rejected
  * @fip: The FCoE controller that received the frame
  * @skb: The received FIP frame
  *
-- 
2.27.0

