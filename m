Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF53E1B76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhHEShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbhHEShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:37:46 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EEC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:37:31 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e13-20020a056830200db02904f06fa2790cso6143984otp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvrxKZYRMUNaIM73Q8/hmJCyEJRyuiPhNen0QxFebio=;
        b=JoqrEDdRhsXgSLt7gGqPtrE4wBhOEPH1YlruY4CLD5KKsG2IEYBCzZKlvYWiJgzxxU
         t7cytlDSCjYrv5sFHQXJ24hDadvHMQlbfT0tOXmcO6qB7zKwCofPGRJbqeDz8nJzsR2k
         owcz66lAB2XiLCfhtHXove2fCReEBkEgPOh6A8ADkrxEaGdXVzTDGOaoX02JAd+1W8nd
         LrJfaWHTql1O8R3p56QbnMnd1REyvK1pqMxH9qpSxzxnGtysP5IJxlZ7whwCgSYeIu4A
         2VuVyFI6CutYSv6d5R1CpVOLnddW2NfP3fY+2vQEzUMI1J6eyGwCjNibuVciQzqcEfkH
         4xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QvrxKZYRMUNaIM73Q8/hmJCyEJRyuiPhNen0QxFebio=;
        b=lJl5kQeRiNcM1SvglzhnhaO2+rhmQTCmHNRHH6uJEbPXwBPZTEarT/DH/C1kJDOXLz
         jBVreeG0f3RrrNG54NTDT/RGmwSSS3EeL1Fw8b7i8t5lvdbFhisdFt/rCiITXfkL25yy
         MnzuybuTrgsQ0FTiNMEgS0a5Se1UJb69mXXeDHoqwvwFeeuQBR/LxMuoiO2r1+L1txck
         r9IqJ8STAGl+Avq7iG2xQJkb0xYCKd6RqjZdT/Wl8wyM0SlE+qyh5lWg2vOCq3NJJvB6
         ZDtgw+5fRv1FsgC/hKLfJzq5y5BsR5EsodsTwT3GTGDiOrxeDXwSqSn6aHVqUHa7faC4
         I8Xg==
X-Gm-Message-State: AOAM533V6T8XHOAdw/Qc6WAq8Z0X3pTrOzo2ZIByjcnPkcTxdqGiqeAU
        YOTMJtdHn4DxyYcrhf885BU=
X-Google-Smtp-Source: ABdhPJyAz5rGwFqmcIDM9ag05G5hLjx+WnSupeEdTUi7d282tKZ9S70iLrJy/787kqNrhfJNdyg1bQ==
X-Received: by 2002:a9d:7a52:: with SMTP id z18mr4793067otm.299.1628188651446;
        Thu, 05 Aug 2021 11:37:31 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id q32sm1156726oiw.37.2021.08.05.11.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:37:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/5] staging: r8188eu: Remove more empty routines
Date:   Thu,  5 Aug 2021 13:37:16 -0500
Message-Id: <20210805183717.23007-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
References: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removing some empty routines in os_dep/osdep_service.c, new routines
become empty. These include rtw_mfree_stainfo(),
_rtw_free_sta_xmit_priv_lock(), and rtw_mfree_recv_priv_lock.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_recv.c    |  6 ------
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 18 ------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 47e19c506584..aef32f029537 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -96,18 +96,12 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	return res;
 }
 
-static void rtw_mfree_recv_priv_lock(struct recv_priv *precvpriv)
-{
-}
-
 void _rtw_free_recv_priv (struct recv_priv *precvpriv)
 {
 	struct adapter	*padapter = precvpriv->adapter;
 
 	rtw_free_uc_swdec_pending_queue(padapter);
 
-	rtw_mfree_recv_priv_lock(precvpriv);
-
 	rtw_os_recv_resource_free(precvpriv);
 
 	vfree(precvpriv->pallocated_frame_buf);
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index b7c39d5e316c..fc963bee37be 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -127,24 +127,6 @@ inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
-void	_rtw_free_sta_xmit_priv_lock(struct sta_xmit_priv *psta_xmitpriv);
-void	_rtw_free_sta_xmit_priv_lock(struct sta_xmit_priv *psta_xmitpriv)
-{
-}
-
-static void	_rtw_free_sta_recv_priv_lock(struct sta_recv_priv *psta_recvpriv)
-{
-}
-
-void rtw_mfree_stainfo(struct sta_info *psta);
-void rtw_mfree_stainfo(struct sta_info *psta)
-{
-
-	_rtw_free_sta_xmit_priv_lock(&psta->sta_xmitpriv);
-	_rtw_free_sta_recv_priv_lock(&psta->sta_recvpriv);
-
-}
-
 static void rtw_mfree_sta_priv_lock(struct sta_priv *pstapriv)
 {
 #ifdef CONFIG_88EU_AP_MODE
-- 
2.32.0

