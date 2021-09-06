Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987A9401FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhIFSz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbhIFSzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC854C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id x11so15168932ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZ+jGlU52R+dGiD1XqdEMOHCz9GkCMtVwRo9Px3Ek0c=;
        b=Wtaj04NE/9p79YdiOTnbgbnSPryE3RcTaEy4bBb7/CqPET3ijXCvy1qGItaGdxYgmJ
         1lxnktaVel4LY/yfXXOO3ECEMtO3jb0SqdJu8hkA6iTKq183b+N1ZpBnkkhXF/8cX+FO
         MZpntaKskB/yglGiJW+nAyiXdSnnj03lsM8X4YgkiftxATQycoO2Sa6UoPNRAEJgehF0
         DHx6E1LeVXiUzZPkQ/QWS91fcICny3Fn1DfF4YF4EeNH69/nmRK8BS4YrT3KbV5SEY7p
         n2r4Uxc+IiRREt1DVjEwLxt3zqjC3yffzRWLLchxuqAdjdtMJh3Fih5u4twS0Nz46m5P
         uMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZ+jGlU52R+dGiD1XqdEMOHCz9GkCMtVwRo9Px3Ek0c=;
        b=RdNMK2ImR8Nnjao8vUcIVrv3t9ngE10OJacrY8yXrIaALR7KvKQAG0uMGRNQZcUIXX
         dQ2+yjbhIfxkxRXAaiBh8OWAuWWYo/YU/lUNyDo3iw1L8yH9bnshv/kKwA+jZdjokmi2
         z99bXwrAdUQogfS2drtfViEjBlZgoGJJKgX+pLZVkZh1HDIoQBeqBQwi8a4EpwL0Ei6b
         8gx7MKCV0PTo3dPar9zZSUKfJrXVoPfh50GqSbKVP6oK1F6r3yKxDtoqHw5lwGxDX4sx
         96sWlU8YOs6seO0h/AT3MaW6Nm+RYoZvv69XtJLeTpl6GjcMh4e4dyRpCVwlzPIisIVH
         cioQ==
X-Gm-Message-State: AOAM530E805diSmdTVZIBJllJnETq/MZIuuCB8QZkZ+arIC95jpwZ6IB
        8hRki0bQ3a2awSwsV5VrFKg=
X-Google-Smtp-Source: ABdhPJxE171L9SfstSamajQiExQr6WnW/FeqRWbOkdUIKHuWL1NDTqarMZqLwyi4DLsWw+CMs4Lfpg==
X-Received: by 2002:a17:906:ae91:: with SMTP id md17mr15164081ejb.553.1630954445458;
        Mon, 06 Sep 2021 11:54:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 04/40] staging: r8188eu: remove dm_deinit from hal_ops
Date:   Mon,  6 Sep 2021 20:52:51 +0200
Message-Id: <20210906185327.10326-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dm_deinit from hal_ops and remove its wrapper
rtw_hal_dm_deinit(). Call rtl8188e_deinit_dm_priv() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 7 -------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 --
 drivers/staging/r8188eu/include/hal_intf.h      | 4 ----
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 2 +-
 4 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index a3b3dd11ba6e..d467e734a699 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -12,13 +12,6 @@ void rtw_hal_free_data(struct adapter *adapt)
 		adapt->HalFunc.free_hal_data(adapt);
 }
 
-void rtw_hal_dm_deinit(struct adapter *adapt)
-{
-	/*  cancel dm  timer */
-	if (adapt->HalFunc.dm_deinit)
-		adapt->HalFunc.dm_deinit(adapt);
-}
-
 u32 rtw_hal_power_on(struct adapter *adapt)
 {
 	if (adapt->HalFunc.hal_power_on)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 765c8c4321f1..355878ec270d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1784,8 +1784,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
 
-	pHalFunc->dm_deinit = &rtl8188e_deinit_dm_priv;
-
 	pHalFunc->set_bwmode_handler = &PHY_SetBWMode8188E;
 	pHalFunc->set_channel_handler = &PHY_SwChnl8188E;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 7d502701be27..61f4a6bcb7dc 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -143,8 +143,6 @@ struct hal_ops {
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void	(*free_recv_priv)(struct adapter *padapter);
 
-	void	(*dm_deinit)(struct adapter *padapter);
-
 	void	(*set_bwmode_handler)(struct adapter *padapter,
 				      enum ht_channel_width Bandwidth,
 				      u8 Offset);
@@ -250,8 +248,6 @@ void rtl8188eu_init_default_value(struct adapter *adapt);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 
-void rtw_hal_dm_deinit(struct adapter *padapter);
-
 u32 rtw_hal_power_on(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index c5dc02d30349..039c05ffbc57 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -913,7 +913,7 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 	_cancel_timer_ex(&padapter->recvpriv.signal_stat_timer);
 	/* cancel dm timer */
-	rtw_hal_dm_deinit(padapter);
+	rtl8188e_deinit_dm_priv(padapter);
 }
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
-- 
2.33.0

