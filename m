Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D520401252
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhIFBCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhIFBCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BBC061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b10so7352395wru.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbugpY3IHp5tB0HSnRdP0+hb80LsALpTqBP2HkV4C5s=;
        b=zLY612ZMhk0CO6TBUNdpEMj+f5yl/u9qIp9wM/k+c2c4mxnHyBzgyHw1zcuCBEuayc
         Q2Hf6GxeQlOtiDwmILtiMld+bcSzCF0Kj4bTnwjaghhfA01XnuCEtAM4ANhgqwTzrniD
         Gfav0W5tDcezAE0W4cAYtMqVBMTiJy1No7B1xEhl7LulvE4Ord6z3k2ogAShqDP4DnKO
         oHgP/vNhJYsSMB0eU8AGN2SV2Tm3Zg3hpGphG5Lc4RvHqs/JbhUKXdkaNyCXX0DeqHRP
         a1Vw9IFh+/e/7LlUWQ0x3tSrlOKbavcolSJWTA5crnbxwRhxcP37gp5P2zouanv5bLRe
         T3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbugpY3IHp5tB0HSnRdP0+hb80LsALpTqBP2HkV4C5s=;
        b=NXeAd83cr4RgIUTAbANaGD/OVx+QulM+f7YQklMxYcFt6psa/3ASuPoNbb7PHgKmbS
         eIOpfLjJ9cEXhOS3lytiPJE1tZeks5v4bzjDpwzTDN+WIf2ftR4Pb8wGNfWK47JX2KTm
         eOMKHeNrn/IYE2oQjJuWmL7qUTEHqhOFYP9ovD4t1+DyCP4RfI4IbJ4/CP+zZn/vu2A/
         Ypc6j1CmqJMGjujAtaVDKm6L0b8oVLTB27gVYDQXOXJkNUnJFkxdFehXWOa2tI2QppAe
         R3NofVkfusr+qCzAMvke57TVjULn7c+n1RdhpeJW6pHTnDpXMgouvoTnDZ/c4QFBtkJr
         ReiA==
X-Gm-Message-State: AOAM530IzOavt0SsqGhYJvuyOhyM5S/YdCTBsitYPso8a5d2GOtJt+gj
        gU5wjzsp2CmBUXLXmAxm2LidCA==
X-Google-Smtp-Source: ABdhPJxa4IkTf4eyCtEBXt1jAwJS3aRRrCf8ZPVqza8hCAE+yzZWuZbjz9AkAc4R96S6ZiFxqEulrQ==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr10437587wro.435.1630890076416;
        Sun, 05 Sep 2021 18:01:16 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:16 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 09/14] staging: r8188eu: remove rtw_hal_xmitframe_enqueue function
Date:   Mon,  6 Sep 2021 02:01:01 +0100
Message-Id: <20210906010106.898-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_hal_xmitframe_enqueue from hal/hal_intf.c and its one
caller from core/rtw_recv.c, and remove its declaration from
include/hal_intf.h as well. This is just a wrapper function that calls
the function pointer hal_xmitframe_enqueue in struct hal_ops if it
is set, which it never is.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_recv.c    | 2 --
 drivers/staging/r8188eu/hal/hal_intf.c     | 8 --------
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 3 files changed, 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 019c5364905b..ba69cf9facfe 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -966,8 +966,6 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 
 				pxmitframe->attrib.triggered = 1;
 
-				rtw_hal_xmitframe_enqueue(padapter, pxmitframe);
-
 				if (psta->sleepq_len == 0) {
 					pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 8b90bf4f5e58..b4fea82bce87 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -177,14 +177,6 @@ u8 rtw_hal_intf_ps_func(struct adapter *adapt,
 	return _FAIL;
 }
 
-s32 rtw_hal_xmitframe_enqueue(struct adapter *padapter,
-			      struct xmit_frame *pxmitframe)
-{
-	if (padapter->HalFunc.hal_xmitframe_enqueue)
-		return padapter->HalFunc.hal_xmitframe_enqueue(padapter, pxmitframe);
-	return false;
-}
-
 s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
 {
 	if (adapt->HalFunc.hal_xmit)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index c4c04f929225..b30968a94fbf 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -299,8 +299,6 @@ u32	rtw_hal_inirp_deinit(struct adapter *padapter);
 
 u8	rtw_hal_intf_ps_func(struct adapter *padapter,
 			     enum hal_intf_ps_func efunc_id, u8 *val);
-s32 rtw_hal_xmitframe_enqueue(struct adapter *padapter,
-			      struct xmit_frame *pxmitframe);
 
 s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
 s32	rtw_hal_mgnt_xmit(struct adapter *padapter,
-- 
2.31.1

