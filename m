Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4999832BF1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577694AbhCCSAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhCCOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:52:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B86C0610D1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a18so15769158wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2TKUb2pogZTiHfW1B3rSfT1K4dqbyioORwhrvyDot2U=;
        b=V76hOPhXM6n5sbOdIqGsjKx734PDA7I8KWpnyU8FWKAug7Pj0Px0y471jB/N6/CdNa
         IsAvwi/zf+gmdb6jKPF4ji88EBd31IVzUDogPcq+evJBZ9OIlIAF4Mnhpzqvz3GCVWAP
         wVqCvtPftp+r1GyofFJ90omac4zmPp61m/OVXH4CWLimoWmxW4ECudMlmaWA8jfTvOK2
         s2yvI7RiCBoHPytDXFFGxht6R8JjnZrW9bpgYICfk6kAvVJzFvDMrZ/FTdRqCiQXNz+N
         V+80wHC1lvIxVpX3S5GO3Q13exKF8VRgKm7FTQoompxV/XiPpKYIlhHztPHBApE+sisl
         P7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2TKUb2pogZTiHfW1B3rSfT1K4dqbyioORwhrvyDot2U=;
        b=oua4Tdb5gx1k00fSmioUzQZXizD+WWHohdhdC9rMtYrE87rPykhftgzZZNpZiXok7E
         Jrb4bo36rhwRQiw3CgSQSrYoc83ILnzJuA3MAzrV6qBBPvey/Q6gx2H210kzHuceZebi
         WfOMrAJApHYpfCP8DTsPy6tNBtcl2092fOqwsTctcomC/GeYMTtXPvZJx+TFKhd91zUG
         z4v670RMEx6djFbKcz2k+ZohCeVQG3BC3akdjRaQ/GHoMBgLMSSuzeFdifXLXWNFXV8P
         6oZmNJBH5JDH/kVnHgv0Y2Szyi+Zz5cLVtDBu8wORAw2OHAuZt7WV4gKAI4FVmYMU7mk
         5PUw==
X-Gm-Message-State: AOAM5307/ysCdh1XdDcYBLRDguodPA6gTjjz+3M5Tl96BoRdXAk+CwBt
        i+R8PA4TdMgtG/dZ0oQYIMbR75uNN8YDcg==
X-Google-Smtp-Source: ABdhPJw225riBzew0Mb2AeNkQjzBr+B1EbV2TITo29vZCKSCpEKWuoeRKUETvWTN3PR3CFsBhnMEAg==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr27330944wra.47.1614782863232;
        Wed, 03 Mar 2021 06:47:43 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 25/30] scsi: lpfc: lpfc_ct: Fix formatting and misspelling issues
Date:   Wed,  3 Mar 2021 14:46:26 +0000
Message-Id: <20210303144631.3175331-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_ct.c:153: warning: Function parameter or member 'ct_req' not described in 'lpfc_ct_reject_event'
 drivers/scsi/lpfc/lpfc_ct.c:153: warning: Function parameter or member 'rx_id' not described in 'lpfc_ct_reject_event'
 drivers/scsi/lpfc/lpfc_ct.c:153: warning: Function parameter or member 'ox_id' not described in 'lpfc_ct_reject_event'
 drivers/scsi/lpfc/lpfc_ct.c:283: warning: Function parameter or member 'ctiocbq' not described in 'lpfc_ct_handle_mibreq'
 drivers/scsi/lpfc/lpfc_ct.c:283: warning: Excess function parameter 'ctiocb' description in 'lpfc_ct_handle_mibreq'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_ct.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index dd0b432f7ac5a..37b0c20249988 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -137,11 +137,11 @@ lpfc_ct_unsol_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 }
 
 /**
- * lpfc_ct_reject_event : Issue reject for unhandled CT MIB commands
- * @ndlp : pointer to a node-list data structure.
- * ct_req : pointer to the CT request data structure.
- * rx_id : rx_id of the received UNSOL CT command
- * ox_id : ox_id of the UNSOL CT command
+ * lpfc_ct_reject_event - Issue reject for unhandled CT MIB commands
+ * @ndlp: pointer to a node-list data structure.
+ * @ct_req: pointer to the CT request data structure.
+ * @rx_id: rx_id of the received UNSOL CT command
+ * @ox_id: ox_id of the UNSOL CT command
  *
  * This routine is invoked by the lpfc_ct_handle_mibreq routine for sending
  * a reject response. Reject response is sent for the unhandled commands.
@@ -272,7 +272,7 @@ lpfc_ct_reject_event(struct lpfc_nodelist *ndlp,
 /**
  * lpfc_ct_handle_mibreq - Process an unsolicited CT MIB request data buffer
  * @phba: pointer to lpfc hba data structure.
- * @ctiocb: pointer to lpfc CT command iocb data structure.
+ * @ctiocbq: pointer to lpfc CT command iocb data structure.
  *
  * This routine is used for processing the IOCB associated with a unsolicited
  * CT MIB request. It first determines whether there is an existing ndlp that
-- 
2.27.0

