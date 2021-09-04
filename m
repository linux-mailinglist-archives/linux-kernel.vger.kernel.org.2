Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30714009E1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 07:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhIDFpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 01:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhIDFpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 01:45:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290E5C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 22:44:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w8so1123883pgf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 22:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uBcl0oFTcsg+IJHeJ3hoqpsIqHeVx3Yjgs9nxKf6e0s=;
        b=ncYWYM4Fa33zgBPCY8QkFrC9CMQrJzsnaQC9/XhhBEODlO9dQebfwtZLDdi/C64nBq
         UWVJi8aLEITeApRGeW9Zf1FZwO78dKgG5j75XZX1/P2FK+hNxIVzIXDiSFsSVLGB2nbZ
         lfphBq6m0O6lUgXXEgshOCKYdj2+rvoSKDVlWbvseN50vseLCpuvpESJXxC3e2rhKKAc
         SZft8tfOxOwP3NcU6GO9HWRes7+UA1rOJnk9Sl/JsN+gOWmcyLnCMqVOlgdDNOndWVEM
         DajOJtlQgxb0X6B4P8m21lG6pj+76JqGE38muy9eC/RK5l2pWIO/haRaRubeIKBUKowH
         5D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uBcl0oFTcsg+IJHeJ3hoqpsIqHeVx3Yjgs9nxKf6e0s=;
        b=MHDj0wcz5OYABCB014gCfiVAarsVtdCcxP4WXSAxVlUKQEUCe90rMDHkixPy6J8nVf
         VtDnR0hAJPvzsU8rTapRtf7z0GOrufv2zuIEm41m4LuLfkQlbLDmKTGabEXMfm5SQc/k
         CVCFuENmW6v4H9WV0pDZI1LRuDox35OFsWP7aRgYglu06lRhcD+yZEfXAad6XQu+z4Ot
         w/PA6Dnlk0aTyHuZdeCh9uWCLMPnKGmF9IKsORIAFYg31wfztw+vc3fEIiFWssRYyJZP
         YVDHCOvzWxNaEb7/LH7B/25717SlOh/ZROze/+Mw6y/zPIyljBOhASZGh9KFkWYJA84Q
         mSoQ==
X-Gm-Message-State: AOAM533OLD7gMhlXCa3EKOrhJvELHwSpl7DHuAhRfGGKiK1YHb3yRO0i
        +ES6mvfBUtDPncM/+i9tQfQ=
X-Google-Smtp-Source: ABdhPJy15WNZaqsKxKlp00nk5tpjeh7ygstxwW8sUggLurHtQGlK4QKtGFfw7lVLTyernHZHrfu9dg==
X-Received: by 2002:a63:5902:: with SMTP id n2mr2281599pgb.305.1630734283267;
        Fri, 03 Sep 2021 22:44:43 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id v190sm1024647pfv.166.2021.09.03.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 22:44:42 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:14:37 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: hal:  remove condition with no effect
Message-ID: <YTMHxQJXKZHE5mg0@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning: Remove the condition with no effect
(if == else) in odm.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index ed94f64d878d..a115bbfa8429 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -565,13 +565,8 @@ void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
 	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
 	pDM_DigTable->FAHighThresh	= DM_false_ALARM_THRESH_HIGH;
-	if (pDM_Odm->BoardType == ODM_BOARD_HIGHPWR) {
-		pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
-		pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
-	} else {
-		pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
-		pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
-	}
+	pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
+	pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
 	pDM_DigTable->BackoffVal = DM_DIG_BACKOFF_DEFAULT;
 	pDM_DigTable->BackoffVal_range_max = DM_DIG_BACKOFF_MAX;
 	pDM_DigTable->BackoffVal_range_min = DM_DIG_BACKOFF_MIN;
@@ -1345,10 +1340,8 @@ static void FindMinimumRSSI(struct adapter *pAdapter)
 	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0)
 		pdmpriv->MinUndecoratedPWDBForDM = 0;
-	if (check_fwstate(pmlmepriv, _FW_LINKED)) /*  Default port */
-		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
-	else /*  associated entry pwdb */
-		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
+
+	pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
 }

 void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
--
2.32.0

