Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB53435333D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhDCJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbhDCJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2DC0617A7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e18so6533856wrt.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bzab+wyS6KvStbR7zDn+0HIWgAiRTCX8kg+zp342XE=;
        b=oKK4ATlPz63YglMxho0RkFxIej+0VLGq+6NFX1sb964k1dmGO9Fz3xWV8tEMFIZqLr
         gnLires1JRCiu8MyDpR0eBNr3Ui3k60NnVfxHP6pSzzur6dkB3/l3bXrT/zr8pxebLn1
         fEWO88PQ7vV2t8jHgakO2gxORfdvrmiup+vDUq1WawjVNQQxTrO20/3lVyV7pTp/px6n
         2d08aU6zQC9/ivIr7zBEEhNNDxn5oVdsLdukFqGR568DqpzZ9cGyUcUI2VLhD1E6pNgB
         vCbhpzWlgjQTxbw6XXW3Xo62oHXMSDlk7O4ORDOFBNBwvMPMT+qzR8iHCP2gw17n0pDj
         gedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bzab+wyS6KvStbR7zDn+0HIWgAiRTCX8kg+zp342XE=;
        b=EbN1R57LZWpdWLAz61LVqSzdyhnupOSBMwuv4JwvyG4VKcnbBuxsmAwpA9+PHotqVT
         7uZFvTjvugwnhWSitUnaidDHoGCL7powj3vKP3IWb95nb9Fs41xBDmHWmv1OunrWxDcu
         aVA+S8XmNP0XLjiKBRlvVyJQ8u5rjmvImY1xSegEFSIERg1db4dsYMk5+ah06FsbaYZB
         thsnXtSB36DO2dmvqppmHiT94ZRg9A2smU4ZQSDFXw1HC3tl6i1WtFKahOl6+Lshstyr
         Mcgsk32ngbSOjdQxCe77fi5XtMemB8jDCjJRjT4U8K/k0YRAjwWtVVZvrMOEYWaQ6rmh
         6Ogw==
X-Gm-Message-State: AOAM533FM3qLTMG7GuhrM056taKccNqSKWl3iUgMmWIQ5K8dq2PkWTWx
        KdwA3UhiPdtmYmKL6v8bbuzMm/CBbPc=
X-Google-Smtp-Source: ABdhPJx6aiQNiY9q0OrelcNpOzAhVydSO1/VdWy7CuSw+s+79hNE8KaEJ8sn871vxO836lvbRrzhuQ==
X-Received: by 2002:adf:deca:: with SMTP id i10mr1609520wrn.319.1617441291952;
        Sat, 03 Apr 2021 02:14:51 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id s21sm15207799wmc.10.2021.04.03.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 24/30] staging: rtl8723bs: remove commented RT_TRACE call in core/rtw_ioctl_set.c
Date:   Sat,  3 Apr 2021 11:13:46 +0200
Message-Id: <22243acbf44c80ffb578d9a56cbec293f7c02de5.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented RT_TRACE call in core/rtw_ioctl_set.c

Remove all of the RT_TRACE logs in the core/rtw_ioctl_set.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 7d858cae2395..14eb01df69b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -451,9 +451,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 
 		/* SecClearAllKeys(adapter); */
 
-		/* RT_TRACE(COMP_OID_SET, DBG_LOUD, ("set_infrastructure: fw_state:%x after changing mode\n", */
-		/* 									get_fwstate(pmlmepriv))); */
-
 		spin_unlock_bh(&pmlmepriv->lock);
 	}
 	return true;
-- 
2.20.1

