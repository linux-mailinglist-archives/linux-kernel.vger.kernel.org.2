Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC9E3FA710
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhH1RzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhH1RzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:55:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A68C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:54:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x19so1677401pfu.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=c1G2etAo7RXizmOfzbwL5cJQFEkKfK8BqKZoS+nPauQ=;
        b=E/R8t3XZI/5mgoy6q/2sninrfivvVRMNytclY5+w2rNZgcmetRzMO1rD8RoOQCvxFF
         OrpXRzpzT00CEvPGF94Dsxz8bjnl767jjxrchvSvs2GiyfBuS/UExPhBAZWRDtPOjtjF
         V2EqJ3NUmO1sYOHdHmBOVG/vCostMW+PdvdmxVQVKb3X/aWecNcvWyIt6AV2jYyE6HdS
         yzj7PhUuCh1j1VxjsYBQWQ18g/rDq4ButH7KGd+CbSBxULRR+Gotgf79qsHlr7Glbrad
         mdelxgUtaoyZCEIAwOumugPbwTMc6irrmtBOnGNCDYNCnWAXzVcRRTARWaXx5AHs/Gc4
         38+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c1G2etAo7RXizmOfzbwL5cJQFEkKfK8BqKZoS+nPauQ=;
        b=dwHhzL+n/z1FcC4U+iwAVMxwrys5ejVqSXmfnZJTVYeS/XJnRm8UitXZhQRQbXWhWy
         VHuCYUuuUkN4D4XrrhRAK0lNSZR8qaNe9oq6br5d7bUbUzyp4KLz4Kh4HluZOci9p7Qo
         t/Ewnr5bHPH+lPid7u7U3wUojpDGFJnpXAXI5waADMv9Lecyc/fq2JkaEwVKc8elP6/R
         /lh5mi5X/IEr6gWKs6cTXXPtJykS9usOyWKmiga3uCy8tdFQFTK5g/grWb4Uq0/x+TP1
         ie1ww8WOhYrbBv/tpLVgEy8bKaHZdNcHF0Y0p5ecAKKq69Jg2yzZOd52sahksqS/dLAQ
         awSw==
X-Gm-Message-State: AOAM533k0ngM25utO4nQLzf+mMCEZCdw581U9+j4wNtseh1n58y06pC4
        rVdYTnktmosTHnyZcy4jcl8=
X-Google-Smtp-Source: ABdhPJxAMhP8rcvBotU/D99aaqe+WpNdcTMWDE9Rn228MIaSl7HZXjzVkvftav1zSuThaFKHsd1Ckw==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr13112527pgt.125.1630173270431;
        Sat, 28 Aug 2021 10:54:30 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id y140sm2294700pfc.139.2021.08.28.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 10:54:30 -0700 (PDT)
Date:   Sat, 28 Aug 2021 23:24:24 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        straube.linux@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove null check before vfree
Message-ID: <YSp4UP1+HrhmDA3C@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove NULL check. NULL check before freeing function is not needed.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index f6dffed53a60..4726771a8403 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -155,9 +155,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 		/*===============================*/

-		if (pstapriv->pallocated_stainfo_buf)
-			vfree(pstapriv->pallocated_stainfo_buf);
-		}
+		vfree(pstapriv->pallocated_stainfo_buf);

 	return _SUCCESS;
 }
--
2.32.0

