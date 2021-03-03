Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E932BF19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577668AbhCCSAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbhCCOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:53:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E5C0604C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id w7so5393354wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVGY+2eVCzb/plLTl5wPYqGdorDqWqmvQcwoi8RclRE=;
        b=LU402gc4bmHicdpFm3WTCCDyVaNj3gfK0eQ//P/3UXc0RO37znWGJtNg9MHCyf7uJH
         WgXVe1rH2uCSKfu8f95QI1C32rE6gGg/NHcHQAhkNLAnICzS/SGjdgfoWW9VX9hpqP1A
         Adf3dXrYLsIusqq0czBOqaw/2ZsHx3aVmfG9V6QfgmHpAFsjZR/ZKKsyJNAst3ZwIJDI
         5hqRtUnX1KOZR2Ci/ZCMafK472Enx+NgS8k0j01WsZvZRaOt0NKwQYLRDswC6AahQdlk
         ufusJWii89hzbTXZluOqEiZynfI9/y5VZeYtOV59PtPqykJHtbuJQbd7U6tEmFGFrl4O
         tplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVGY+2eVCzb/plLTl5wPYqGdorDqWqmvQcwoi8RclRE=;
        b=SKX19DY+udVQccn0WoNB6ksZk8gGDtDFPJCrLxx3H8wa0OGOf9DZRQljppCz2WebWM
         d3WO2K8bt/6DEgbGcYpDmDpmGoX9tdVGDmps4kUJKYe1cAsY5ZtbsnJWjqROhMLXnha0
         uFxUah2nApIuUn1RWlgJqGaXPSKJttpNtyItcKYrNDWYrzdyfee5DpUAZCO2Hqy7U9UD
         KkjKvSrPiJAwHCT5JYtxg8AzciowBZzeNTFgS5RE8Z4OD8fhRLtMVxEfR21OgxRnsVwY
         a5elgJIQIQPpdhxa28jXq5tBtbrBzjZBdbmecE/YhRO8WgKHBon8RuQaP/gWEa2k+69K
         buqA==
X-Gm-Message-State: AOAM531MM7qoZlx5JlhuVptXcpcUyQd4BP+XMa7uv1M/V5eymLSegb7+
        bhkUYMfP77yGDvro089+UIbl8Q==
X-Google-Smtp-Source: ABdhPJy+7UfIOPpgeTPojOLx8GUyLfk9FGzs0T3v9/Bdp6I9M66m5yG0d1EAmp8cuc7Aci1NZr8jOA==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr9672843wmi.112.1614782868292;
        Wed, 03 Mar 2021 06:47:48 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 29/30] scsi: lpfc: lpfc_nportdisc: Fix misspelling of lpfc_defer_acc_rsp()
Date:   Wed,  3 Mar 2021 14:46:30 +0000
Message-Id: <20210303144631.3175331-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_nportdisc.c:345: warning: expecting prototype for lpfc_defer_tgt_acc(). Prototype was for lpfc_defer_acc_rsp() instead

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 135d8e8a42ba2..ffd41cc7c96c6 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -329,7 +329,7 @@ lpfc_defer_pt2pt_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *link_mbox)
 }
 
 /**
- * lpfc_defer_tgt_acc - Progress SLI4 target rcv PLOGI handler
+ * lpfc_defer_acc_rsp - Progress SLI4 target rcv PLOGI handler
  * @phba: Pointer to HBA context object.
  * @pmb: Pointer to mailbox object.
  *
-- 
2.27.0

