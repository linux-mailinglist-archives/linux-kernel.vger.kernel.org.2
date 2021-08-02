Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A13DE007
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhHBT15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhHBT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:27:49 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B44C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:27:39 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n16so18809270oij.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QDVapNDbIFTOhd1dRUtCk+ZGWeywoaH6X/4Xc4mtgzk=;
        b=b7px10MbaKdwmQCaEHLBhpRD4ZWVd6Vh+mwNjq4aeWPuMkuuzhlQf5cZ4RPJLrIMjx
         mdK8snn9/M6l3sXQ891FtkVmAeAsk/mHSZ1nCejGxf7h9253l1Cj7TcOMYUHIZpa5owT
         b0BOn12IUvrshWfSX76A+g2bRNhOcGdjHQgm7uTtB8wAgTvcnnGRauNkfK4gZyTCUo/J
         g7CTWa8ulFLS4MQ38/JXhpK7wlCpmogxMXhABGW6mt1FgbGv2jt8Xx7PVgGYVPaw24SI
         yUHAYMYs//8VBjZGOXKv3Ph2Wmt9ISXRxcsXbL+TgHLlsYR7dWZQgbSSE04S7UpoWgnL
         A1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QDVapNDbIFTOhd1dRUtCk+ZGWeywoaH6X/4Xc4mtgzk=;
        b=kUVuNGjpgiN6c5sBu4zTSsLw0ycEDJo3pi6xd5bED7Eej7ZA0qQHTmjARqKVmmbqP/
         ZbOMVm3cWs1OERYkQqTy2kyDXIz8URXiDQkLc56UAQXoB5ZidVht0BqZR3TwHQI8rN8I
         hBYA5WbIo4WLmV30TLTtbJILI5czLwPXjQ300uE640H9bbYjALH4yYx6hKhK8IhBoQCh
         N4B7ys+XP3MhZnpeaHuqxNmihtR4J5RpyYmBkWjSPAMPCWn1/GtTn4TOZgbXXtRrartp
         YmBmqQB1m4+tgrJ5zFr6N7T4vZIenePYVIxVakVsgd+tjQ7nDmtfeNjNqDLUtjxE5IOO
         zvIw==
X-Gm-Message-State: AOAM533FI2wIipsznQcz4+FU/UXCvXroUTlaEW476nFfym6MXFLN6wII
        MPIdi1v3I0wH8oAn6j3bTsk=
X-Google-Smtp-Source: ABdhPJxYQCR0xlT+r/Pro4CpThmarXmAAX0PzS9ocZdkkQepGr6D0yMKLnW+4CrskLuMq8qcwZb1mA==
X-Received: by 2002:a05:6808:1523:: with SMTP id u35mr11936947oiw.132.1627932458441;
        Mon, 02 Aug 2021 12:27:38 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id i188sm1981035oih.7.2021.08.02.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:27:37 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 6/6] staging: r8188eu: Remove more empty routines
Date:   Mon,  2 Aug 2021 14:27:21 -0500
Message-Id: <20210802192721.23110-7-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
References: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
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
v2 - no change
---
 drivers/staging/r8188eu/core/rtw_recv.c    |  6 ------
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 18 ------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index a4cb08d41b8c..7f12b494b949 100644
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
index 29df34fd74f1..f60cd4420ea4 100644
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
 /*  this function is used to free the memory of lock || sema for all stainfos */
 void rtw_mfree_all_stainfo(struct sta_priv *pstapriv);
 void rtw_mfree_all_stainfo(struct sta_priv *pstapriv)
-- 
2.32.0

