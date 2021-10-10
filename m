Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D776427F99
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhJJHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhJJHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 03:10:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491EC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 00:08:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e7so7715718pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NnvNITiJrBSPHawLF3zDlRAc4rrEXIDC7UHTgO1Ku1I=;
        b=q12ZZL84Tkbasfna4BmFiJlCpPt18tKqcP6uP2W9BOXWKfV1gurpiQYaWra73AzouX
         VpCyCWrPiGING82efBBsZMAeEAgsk1iYeLCqHQrHNXyLNrPRwQJSxSzxrf/hickh+FiP
         dErt4DFQh83+V9ocCx0FRnwn49CkaCj+a8vNAbVLWamQqQ2tvoJYR0oGZO7lq35lJNR0
         5B8YQapoguD9wrYFWDbeUW9W3Sh7SXnYisZAytcCRuPL/BxEsllS1m/aiyMx+M1TCAyH
         MTrhvX7H73CcpSdlbYsKunl1WAwMhoR/Oj3hEGc2S/ZIlFaMKG5UbvyMrExbiRLrBrW+
         BF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NnvNITiJrBSPHawLF3zDlRAc4rrEXIDC7UHTgO1Ku1I=;
        b=WLeS/bHEB1uCOJqI14QaleqcoO6j6NbH9bChDYlOi5MVT1EG4XTEwYcpah22fd5H7X
         F9lOA5n3+uhXJqNKmCOJFpjbmkvp6c4b52uzA+q4Tqgap3MlGyx/kkIcQhkloAiQl7nZ
         uPr5X51+Afm5L6Pgf2ngRpnm5SsWxFvBk1N24nn4GJgpIVL1tsXACzf6Ut+LVAzdiRLr
         IXY7M7k6Si4mIeIlRBL36syM0PwrW95TqmNuSW2WYco1Q7wT7EgU2K5mzMQ1Oww58ueP
         5/TQGXzV0ie3QypzHAn5VqHduVqgLywUUSuMy9zZA7svqm0ws+bGLEIccT705y8TfsaC
         Rx/A==
X-Gm-Message-State: AOAM533tdPUANmIDO72m42gGeNE2NBYd+VHM4xxlkaAN9FSY4QrPm7y2
        8DSPj48QuRiEda2CKlcS1v8=
X-Google-Smtp-Source: ABdhPJxmema94gfSVmx7Z5qkzmZ8GJKpcNBrAq+qgHtEunarpfEtV8sKR3ZN5n+giEId3FhFp9zRcg==
X-Received: by 2002:a63:d19:: with SMTP id c25mr12667130pgl.393.1633849731682;
        Sun, 10 Oct 2021 00:08:51 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id u24sm3844457pfm.81.2021.10.10.00.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 00:08:51 -0700 (PDT)
Date:   Sun, 10 Oct 2021 12:38:45 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        hdegoede@redhat.com, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: hal: remove duplicate check
Message-ID: <YWKRfYpTioAmTWa0@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'bPerformance' from if condition check. As on previous
if condition it is already check for same variable.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_DIG.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index beda7b8a7c6a..7e92c373cddb 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -544,7 +544,7 @@ void odm_DIG(void *pDM_VOID)
 	/* 1 Adjust initial gain by false alarm */
 	if (pDM_Odm->bLinked && bPerformance) {

-		if (bFirstTpTarget || (FirstConnect && bPerformance)) {
+		if (bFirstTpTarget || FirstConnect) {
 			pDM_DigTable->LargeFAHit = 0;

 			if (pDM_Odm->RSSI_Min < DIG_MaxOfMin) {
--
2.32.0

