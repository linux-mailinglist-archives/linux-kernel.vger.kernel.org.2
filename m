Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5763341AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhCJPhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhCJPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:37:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:37:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id dm26so28617623edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=apyUMBZZE0k4eMvODh0ON7nsxjy7HSDAUMAXl0tkWDo=;
        b=K05yxDPuVCoK64qGr2BTqW6abWbLFv0gvRaqNyUvHjh79JCiZ1MD7Pu6fwLDjVdIt0
         hBXh5yrhChxLJWT8cnMG11j+/kfeqdYIf3+SglwKEO35/wGsITOpGinx8ZV30TMQxkr7
         wN6RLpJBSP1vPQVBNMS9VHC6Df8xpZf6cAfEFVuwX0iQsYpSqg4rQc/DgWuSz2wbRjBj
         dSqGuqgHRaMXiZzdwWucBrvOWuzWRi82CHUoeB/P6Wx2yjzlDGbjx5l25uThIl7a+W4e
         ZCMV4NS2X8zMWXouzSZ6K7lxW4xKPws146G+0lvu1Eivky3pZtACnx3m/Fk54+2uhjYn
         IHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=apyUMBZZE0k4eMvODh0ON7nsxjy7HSDAUMAXl0tkWDo=;
        b=lsOMq2y1/q64Xaq3JwHWw8MtG4iHBtaxi/7Vz47trHQyIxCd3LPgGELPTCRiWoUOev
         JoC8Vaqv3+joxKlc1I4luUFSukrsAX2HINdJfsSVfv1Vaml21asJrDwkZ26xkWdiQG9T
         d4MpmtTAmuc++3s5dEDRarJKpKxWFJea0Wz0FbLmDftGmf8rtWwnBuBn+jUIgghDpprV
         CbGxcvwNZendBqXIIWUsdsTCn+MsbTOHZBwm+Uo7rozV7fU2sC7IuU49C6CknBOsHu1y
         EANBSO8Tbz9rOHC/Ccq6vbXgsG9KAhUAevd4ftHgKLmb/A2Hbj8g2SXRm+769rYO9gGu
         ANfA==
X-Gm-Message-State: AOAM533x/J+VZQE9CM2mRLam/r8d0fPQxK7nEhTdRjqOB8dcwDzVQlvo
        8xB3rApATGjiVKC1scMML84j7azQ6RcTSg==
X-Google-Smtp-Source: ABdhPJznorbhhqtXwiCFqJVJaEElQN7crQXZjkF8flPJfMkUyMzbRDsgVnigw6af+kuGN97l68FqRQ==
X-Received: by 2002:aa7:cdcf:: with SMTP id h15mr3962516edw.28.1615390644585;
        Wed, 10 Mar 2021 07:37:24 -0800 (PST)
Received: from agape.jhs ([151.47.162.135])
        by smtp.gmail.com with ESMTPSA id v8sm10951448edq.76.2021.03.10.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 07:37:24 -0800 (PST)
Date:   Wed, 10 Mar 2021 16:37:21 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: align comments
Message-ID: <20210310153717.GA5741@agape.jhs>
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
 drivers/staging/rtl8723bs/core/rtw_ap.c | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index b6f944b37b08..3a0e4f64466a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -721,9 +721,9 @@ static void update_hw_ht_param(struct adapter *padapter)
 
 	/* handle A-MPDU parameter field */
 	/*
-		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
-		AMPDU_para [4:2]:Min MPDU Start Spacing
-	*/
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
+ *op_mode
+ *Set to 0 (HT pure) under the following conditions
+ *	 - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
+ *	 - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
+ *Set to 1 (HT non-member protection) if there may be non-HT STAs
+ *	 in both the primary and the secondary channel
+ *Set to 2 if only HT STAs are associated in BSS,
+ *	 however and at least one 20 MHz HT STA is associated
+ *Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
+ *	 (currently non-GF HT station is considered as non-HT STA also)
+ */
 static int rtw_ht_operation_update(struct adapter *padapter)
 {
 	u16 cur_op_mode, new_op_mode;
-- 
2.20.1

