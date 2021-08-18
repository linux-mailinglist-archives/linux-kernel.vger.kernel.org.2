Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13303F0EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHRXni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbhHRXne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:43:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220AC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2882608wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3l1mIE8Kc2LpwqsUqo3+DKrFDs0qzMDPtyhsueNmW6k=;
        b=VbqbyyGoRoQvkCDZaHxaMX198A9EZKfhy9TXP8NpwmZ9IHf40km9oUV0Di6mFALyOw
         H6RRuXPYBTPgrhNEc0zPFfzguX3Z/+JOU7y//2NDKH0NvMGTnBq3v8isbMOCnh0pu5aC
         1hBD6hFsRaA1IUi3WdsAlBcOjqSLclQ51lTDe11+nzNGKco6c3B9hytWtsU8mBRJiak1
         lhfwQod78V1INpx5o9gxghW7cZvJ1hHb+5HUgEfb2oHVMpSbkgmXuIcybzOn1jD70pRc
         otZUh7DglafzM/HsxqzWUc/xZ/zVl6m0K4N00M2+mbkdOigUhSABZV4YDCFKOLZ4Mbqc
         wq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3l1mIE8Kc2LpwqsUqo3+DKrFDs0qzMDPtyhsueNmW6k=;
        b=odht57iRTHpnCO5Lo8w28ik2Z6ZPDC2hQWE1ku24zRLOw5FnsLww+bJuXbV5RrNJva
         zMHRVuMjQUYPURtwkyFBamFwsLUd3fxp3MbhZozwZ9cc+ANZ9GCTkGUAJvVy2ntuQW+Y
         vXGTMmq+1d4Fa+KiG3x2KmHSn3awymyG7ogpzIsDxO/KUa1pQYnbtm7Yn5JvPDppT7xr
         UNJ4L1cZWCX2sgVZ7RDXsXDEna/fzJNFcD2bmNbbDrJY5TlZrvCvCemGudYTYQYwFZm0
         5BSPNNBSboNX3x5Dg29d0b/NLzRD0FRRuN8IdVMkforphhi8fQjlaDppOHs5W3wb55nL
         W9ig==
X-Gm-Message-State: AOAM532KsRm/EElZRywUuv0yxcytpxyZvjLNWWjs0fSTbeFD6+fjCfLi
        lpyRMfTnXgOSHhtz+6URfsRkQg==
X-Google-Smtp-Source: ABdhPJwseAAbozfm6u6XRpvr7Xof0oVkzGoYsKLPXAI08lTRzRaPglP/D2DEwgckpBxS5dOuabQIYA==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr10901970wmi.69.1629330177636;
        Wed, 18 Aug 2021 16:42:57 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1194926wrt.77.2021.08.18.16.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:42:57 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 4/6] staging: r8188eu: remove empty function rtl8188eu_free_xmit_priv
Date:   Thu, 19 Aug 2021 00:42:51 +0100
Message-Id: <20210818234253.208271-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234253.208271-1-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty function rtl8188eu_free_xmit_priv from hal/rtl8188eu_xmit.c
and its declaration from include/rtl8188e_xmit.h, as well as the one
place where it is stored in the free_xmit_priv function pointer of the
HalFunc struct inside padapter. This is safe, as the wrapper function
checks for NULL before calling this function via the function pointer.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 4 ----
 drivers/staging/r8188eu/hal/usb_halinit.c       | 1 -
 drivers/staging/r8188eu/include/rtl8188e_xmit.h | 1 -
 3 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index b279309405a2..d22b16cc5a30 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -19,10 +19,6 @@ s32	rtl8188eu_init_xmit_priv(struct adapter *adapt)
 	return _SUCCESS;
 }
 
-void	rtl8188eu_free_xmit_priv(struct adapter *adapt)
-{
-}
-
 static u8 urb_zero_packet_chk(struct adapter *adapt, int sz)
 {
 	u8 set_tx_desc_offset;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 2cd835cb90f6..5cdabf43d4fd 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2243,7 +2243,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->inirp_deinit = &rtl8188eu_inirp_deinit;
 
 	halfunc->init_xmit_priv = &rtl8188eu_init_xmit_priv;
-	halfunc->free_xmit_priv = &rtl8188eu_free_xmit_priv;
 
 	halfunc->init_recv_priv = &rtl8188eu_init_recv_priv;
 	halfunc->free_recv_priv = &rtl8188eu_free_recv_priv;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index e7eb19c4ee9d..f1f2ccfc765e 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -136,7 +136,6 @@ struct txrpt_ccx_88e {
 void rtl8188e_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc,
 			       u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull);
 s32 rtl8188eu_init_xmit_priv(struct adapter *padapter);
-void rtl8188eu_free_xmit_priv(struct adapter *padapter);
 s32 rtl8188eu_hal_xmit(struct adapter *padapter, struct xmit_frame *frame);
 s32 rtl8188eu_mgnt_xmit(struct adapter *padapter, struct xmit_frame *frame);
 s32 rtl8188eu_xmit_buf_handler(struct adapter *padapter);
-- 
2.31.1

