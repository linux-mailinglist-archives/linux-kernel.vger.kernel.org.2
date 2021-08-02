Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901E33DCE74
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 03:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhHBBBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 21:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhHBBBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 21:01:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD963C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 18:01:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y7so19964350eda.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cm0KptdwqXyK8TKHm7XLOYj0tPg3467M28lr2Jc9UKw=;
        b=NMGzGGll+c8iBi74hvvQphtdZMvCr/lFuC9oAc02SMtvdeC9I1M7//GaegrTqgCh9P
         WS8s1Do6DBBEGhxirmyFDPVAVApkJ/Pnb/kpN50Qi8DKezPnq/r8pRfrIl+hNBr30rr4
         1trn73kZbWsD+9tbGrVhry3tP49kYH8AiyTzssYt53c+CnWAqsgrtxZ0ZfweD7bRx0Bu
         lOnJtcYdkssF+pawKmOrPa3YKTpmS1+Em78NIhPfFhGtppD1ffOntpznkkYX3gMvxMB1
         gYXImrQo2gEQfn7ydaIO1jGCGwqMXk5YGA4RI2T4fZnxGq0Jqce5PNPocKc8SEbAaQY/
         fUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cm0KptdwqXyK8TKHm7XLOYj0tPg3467M28lr2Jc9UKw=;
        b=kiZal+F4xLNDZIBH5rFq0j594+QV6tH5jOlLAOsA/PZy8Q+5qMJF/CHiYdRAMruTp6
         xccHcH33oLqgWuUGm9OVpvPPRobZc9Oi42we4HGlL4CjTXn8xrFdRFb3qKQSmipNMWRm
         9pME332Ei3aKcmGgXOEb+hpaXbAcHDHIXW/AGibP+eW6B0yxqwkew6qy1MMLwp+7Mvu6
         Klb/MSHwkJ5lwI3GOXa9Y+NVsyCIBdwoIeY20340ZtFNVfn/PDiltkKMaEGZjENDvhwv
         QGezG/lTZiLkLpOmmdbgvVA9YXOZk2IPV+wyMexC6Ztp6L0n28fy5SC0y2wiI3x25pMV
         6UBA==
X-Gm-Message-State: AOAM5304Bs8p8Px7bdADBq8Ef50Qm8cJxVA4npiBEDc1jbNM1udYhPX3
        zoISQryKSCtmbi7ew35QlSQzxd2x3vU=
X-Google-Smtp-Source: ABdhPJynj8LmyDz/Daft4vU1vB7w1EuZ83MIj7eQXyeFaMRRI6EUc3/+ILVAb66BYJIUO4EkHTXZlg==
X-Received: by 2002:a05:6402:c81:: with SMTP id cm1mr16718210edb.355.1627866059365;
        Sun, 01 Aug 2021 18:00:59 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id dh8sm4898756edb.14.2021.08.01.18.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 18:00:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Remove set but unused variables
Date:   Mon,  2 Aug 2021 03:00:56 +0200
Message-Id: <20210802010056.20543-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused variables. Issues detected by sparse.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c        | 4 ----
 drivers/staging/r8188eu/os_dep/osdep_service.c | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d692f1477cc8..dfe7a3621efe 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -759,7 +759,6 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext;
 	u8 timer_cancelled = 0;
 
 	spin_lock_bh(&pmlmepriv->lock);
@@ -854,9 +853,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		p2p_ps_wk_cmd(adapter, P2P_PS_SCAN_DONE, 0);
 
 	rtw_os_xmit_schedule(adapter);
-
-	pmlmeext = &adapter->mlmeextpriv;
-
 }
 
 void rtw_dummy_event_callback(struct adapter *adapter, u8 *pbuf)
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 99ddc535e5ea..f1257999e855 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -390,7 +390,7 @@ u64 rtw_division64(u64 x, u64 y)
 
 void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 {
-	u32 ori_len = 0, dup_len = 0;
+	u32 dup_len = 0;
 	u8 *ori = NULL;
 	u8 *dup = NULL;
 
@@ -409,7 +409,6 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 
 keep_ori:
 	ori = *buf;
-	ori_len = *buf_len;
 
 	/* replace buf with dup */
 	*buf_len = 0;
-- 
2.32.0

