Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32D63F12AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhHSFIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSFIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:08:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6892C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:08:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q3so6841806edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77nT17Qwz5Ti/66HuChnzgubrYZ1JTKCItJbjSMqiXU=;
        b=CYud7j9sUPtxv14PLjjICnvzOgSw0EQxoddBj3s9QALzQz9l3aNqVMGwEI22zhkHzz
         osv0CqVQ1+KsrD8cwigvNwbxjzPLY0uXuYRZSj/G4hgo41nfmewL3lAIK7s2XRe4CnCI
         zAIaDaCBU2DrKQUrgpkco5r6E1RirTA0sWfFc+63JuMIff+Dr8rD1zzNuyyk/V5E0uRb
         kjibVGw9p/yWUKjIKeJTNs9rU8qsWN0MP7ITSZbezwyx5X84EmAt7hWyLICjgq7mgAwU
         8TuXDiUe4s+FsLua5o/8XaZ2zwlQzABCj0VG7FYd/qAxy8R9R6iF6KP1baE5x0qMAt2b
         EzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77nT17Qwz5Ti/66HuChnzgubrYZ1JTKCItJbjSMqiXU=;
        b=jEkVRe8gjQlaQvxo6uhz8sajkxlQO7SibpRdbb2APddTNXgcCDQVnb0vyCY0JLwVCr
         22Me+UVe/2rchx7LhJ3HteiFO3Egbsqo5zWrdeUUISqeHQCNG2nNVkowqizvY7Jz7eez
         FNZQbaLOsrsETHRzk9FeyQ8XeYZlByEM7HDY1ImMC/Ap0OctWvy4z3CEndUKaDywmfTJ
         tYYfkHzc46heD11Z6ZCU7znNcbl4FDobS1uU4T/XQB57HVZNxobTg1lhzr+MA29SwQla
         FnIMyQvbVnVirFWhnAZeJoRsgD2sl80C6huuU8IVgpuFq2t6GxgFKNUoKr5biLeyXBw7
         tkxg==
X-Gm-Message-State: AOAM533X4BEGcZAdyxnOp6zAlI2yCuzx5/y28FHAxHKBV6sdZt4Id2vI
        SzraQfthjoZUCCJnalXWfFU=
X-Google-Smtp-Source: ABdhPJwUZFGY90ko4Yo4ULND1iGaJGXALOX8w/5QRAdc8GOpi9Br4wB+Ay9HQKnhkdbnXf9B49CNIw==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr14212122edt.321.1629349692558;
        Wed, 18 Aug 2021 22:08:12 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id j22sm728484ejt.11.2021.08.18.22.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 22:08:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Remove empty rtw_mfree_xmit_priv_lock()
Date:   Thu, 19 Aug 2021 07:08:08 +0200
Message-Id: <20210819050808.28825-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_mfree_xmit_priv_lock() because it is empty. Remove its only
call from within _rtw_free_xmit_priv().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index e1de7448771c..f242f3ffca70 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -207,10 +207,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	return res;
 }
 
-static void  rtw_mfree_xmit_priv_lock(struct xmit_priv *pxmitpriv)
-{
-}
-
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 {
 	int i;
@@ -220,8 +216,6 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 	u32 max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
 
-	rtw_mfree_xmit_priv_lock(pxmitpriv);
-
 	if (!pxmitpriv->pxmit_frame_buf)
 		return;
 
-- 
2.32.0

