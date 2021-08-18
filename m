Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE863F0EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhHRXnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbhHRXnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:43:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86B3C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso2884868wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bR1XQziYaxxggs454QagkzYHitfa/m72LyqIxLJLvBc=;
        b=JN2y9UvqvD0NqZJ+QLi7g55jlQ0MVWas7kCogzY0ChhwrNSdYuBki89wpUmkudukVD
         Aafq8myThtsbsiUtHvXtxJKwIG/08dz7U4/0upCE98A16CX50EBo8Cyw7QiunMIJKZGB
         djpwwzjuKXjgqg1KECf4wHooQdsXGHEPQJAkWiHEbAD+mj+6RU2rnSU6sGGGuA5LZeUC
         ueoddFbc8SLcDAua3ODJfnIvgGCi5F4a6KpMNVPmpbtOJiw/M5QKRsejumhSGXCCORQ2
         U873pfkCD1mS9L5/g5rdlfdFtDGbY73irvNRtCsiGXnQGPp3xfAEHK0iEyvliWWvmjYc
         44jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bR1XQziYaxxggs454QagkzYHitfa/m72LyqIxLJLvBc=;
        b=dY8XyrCFYci2qc1TfC1tcZrvcxG/4laFgpjTduZXHvtwH10trqI87xhggNjcSovfsb
         lSnOLKWtvaMAbr0uma+xTvGTsmjB4ukJOXyfh1QU4VIKDdeH4Y9xBTFBmTAErX3NEI/A
         J1Ve7J7d4Cjc6KwqiCQMmDElhJjAp7Szd6rHTd1D5LXrtZtADSSDij3HA1GL97zuWm1Q
         6rNz2eWbFqu6qo74dEc+ZzGhP5Y/KD2rEuBkpW2WaY4Z8dYZLAs7nTBej0YMdMvvQkc5
         M5j/SV6FtQQnaRIT12Jmq2hIAPIy+yco8HIun4+2YL+6vqnc6TTic40FJKwxVPdVXfi1
         N7fQ==
X-Gm-Message-State: AOAM532Oyz3YYhHDrv2yXZoqa4NeR6DlhgUjr/4slJbmQEwYTd0hIRzp
        kbzqlmTRZYT6hyccG1A8AbohHg==
X-Google-Smtp-Source: ABdhPJw8ZMTeSwK8JutVDicEaheXzOGFdj2VKiu2a3HbS1BlCDofHGH6wQK5sxOoSzHTLdhuvTz02w==
X-Received: by 2002:a05:600c:3b06:: with SMTP id m6mr5707103wms.35.1629330178497;
        Wed, 18 Aug 2021 16:42:58 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1194926wrt.77.2021.08.18.16.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:42:58 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 5/6] staging: r8188eu: remove function rtw_hal_free_xmit_priv
Date:   Thu, 19 Aug 2021 00:42:52 +0100
Message-Id: <20210818234253.208271-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234253.208271-1-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function rtw_hal_free_xmit_priv in hal/hal_intf.c and its
declaration in include/hal_intf.h, as well as the single call line in
core/rtw_xmit.c. This function now essentially checks a function
pointer which will always be NULL (due to previous patches) and
therefore will never be called.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 2 --
 drivers/staging/r8188eu/hal/hal_intf.c     | 6 ------
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index cdfcf94e4986..69f997f44c07 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -220,8 +220,6 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 	u32 max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
 
-	rtw_hal_free_xmit_priv(padapter);
-
 	rtw_mfree_xmit_priv_lock(pxmitpriv);
 
 	if (!pxmitpriv->pxmit_frame_buf)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 47af081bafcd..a6d589e89aeb 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -226,12 +226,6 @@ s32 rtw_hal_init_xmit_priv(struct adapter *adapt)
 	return _FAIL;
 }
 
-void rtw_hal_free_xmit_priv(struct adapter *adapt)
-{
-	if (adapt->HalFunc.free_xmit_priv)
-		adapt->HalFunc.free_xmit_priv(adapt);
-}
-
 s32 rtw_hal_init_recv_priv(struct adapter *adapt)
 {
 	if (adapt->HalFunc.init_recv_priv)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 37ddb9745350..8a2420095b84 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -356,7 +356,6 @@ s32	rtw_hal_mgnt_xmit(struct adapter *padapter,
 			  struct xmit_frame *pmgntframe);
 
 s32	rtw_hal_init_xmit_priv(struct adapter *padapter);
-void	rtw_hal_free_xmit_priv(struct adapter *padapter);
 
 s32	rtw_hal_init_recv_priv(struct adapter *padapter);
 void	rtw_hal_free_recv_priv(struct adapter *padapter);
-- 
2.31.1

