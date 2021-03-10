Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D12334B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhCJW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCJW1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:27:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E08FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:27:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so25105059wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=87k2e/RW0d520c+kOrMfvUjoXVowQB+P8Fhwo1lIzWg=;
        b=MPdn/zzkA9cSAtCRL3Zk323wBXDzpRAhZ6bKHmhjnCBn8t5yjtjnqYbNxD84jPi8uE
         gCghBbBxxMjLwLs3pspgnf4POv9fSc2v97h5U3SCvsL3kNJuurE9aly+gjmXZ+QytWoF
         bhvtdLFuFFBVKY2fX3XbES6t+ilkpUkjfTVjEKUc4ByYZX5fuJr4Cg0O9vEGNkL2THgW
         Kw6tYvNVgXfMr0KVdv5AXLaIplS4gZ79dajTXnra4jplzrQK95l+zFLgQzjFqYl6HMSr
         PFVUpQ5kDqAMENyll+e8BCvPuQncXS8xO1g+RylwNy7zPngtd65idL215ZYTf8slmNlr
         1pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=87k2e/RW0d520c+kOrMfvUjoXVowQB+P8Fhwo1lIzWg=;
        b=GytRQ8fBj6FjujgU/rqyGc9++9sfcla6cAMUagXwem0S8A45adfBZdd73W1+xAQfcC
         usSk3wPUPkmJHQbaRqiUg8O4qW1TnKQvpzcvHwZcv9NWks8zo1059Ih8HyxVRUw+y3UA
         GrMNDqGaqJesarPb/R7ch2ef+EOd6106Ni9eumYUV2qE7p1E9TIo6unRQfPGTby98Hv9
         otrmtj/Zrt+MzsWLvKiE2Szs5jQ5acPc6YSamuOPuDTA8DF1nRzTigbT6v9eBAobFX3o
         Q4iFzTwrEpB9KdBkS7xXe91v9m4yiy+tXLOi8Z8nu2mVvPu/WNsPB/8hg1wgSbcVOQVL
         BQRg==
X-Gm-Message-State: AOAM530Gb0N3GaEJ3UvFAbUtYrX9U22jPvpkO2eSyqIf7wKjZveeZOLx
        zpDGKpI/eVUaC/KtJxegjwY=
X-Google-Smtp-Source: ABdhPJxlGD3c8eGIZ+4Qd29Gun6laMCmO2yRYRW9dNlFLOzHNu62vhwO1y+Qz2RBFflEzIZN1Oz6kg==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr5681195wro.249.1615415254202;
        Wed, 10 Mar 2021 14:27:34 -0800 (PST)
Received: from agape.jhs ([5.171.72.165])
        by smtp.gmail.com with ESMTPSA id z82sm744157wmg.19.2021.03.10.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:27:33 -0800 (PST)
Date:   Wed, 10 Mar 2021 23:27:31 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: align and beautify comments
Message-ID: <20210310222728.GA3246@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

WARNING: Block comments use * on subsequent lines
+	/*
+		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
--
WARNING: Block comments use * on subsequent lines
+/*
+op_mode

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 32 ++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index b6f944b37b08..6d203814260f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -719,11 +719,11 @@ static void update_hw_ht_param(struct adapter *padapter)
 
 	DBG_871X("%s\n", __func__);
 
-	/* handle A-MPDU parameter field */
-	/*
-		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
-		AMPDU_para [4:2]:Min MPDU Start Spacing
-	*/
+	/* handle A-MPDU parameter field
+	 *
+	 *	AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
+	 *	AMPDU_para [4:2]:Min MPDU Start Spacing
+	 */
 	max_AMPDU_len = pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x03;
 
 	min_MPDU_spacing = (
@@ -1815,17 +1815,17 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 }
 
 /*
-op_mode
-Set to 0 (HT pure) under the following conditions
-	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
-	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
-Set to 1 (HT non-member protection) if there may be non-HT STAs
-	in both the primary and the secondary channel
-Set to 2 if only HT STAs are associated in BSS,
-	however and at least one 20 MHz HT STA is associated
-Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
-	(currently non-GF HT station is considered as non-HT STA also)
-*/
+ * op_mode
+ * Set to 0 (HT pure) under the following conditions
+ *	  - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
+ *	  - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
+ * Set to 1 (HT non-member protection) if there may be non-HT STAs
+ *	  in both the primary and the secondary channel
+ * Set to 2 if only HT STAs are associated in BSS,
+ *	  however and at least one 20 MHz HT STA is associated
+ * Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
+ *	  (currently non-GF HT station is considered as non-HT STA also)
+ */
 static int rtw_ht_operation_update(struct adapter *padapter)
 {
 	u16 cur_op_mode, new_op_mode;
-- 
2.20.1

