Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5944C6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 19:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhKJSUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 13:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhKJSUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 13:20:15 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 10:17:27 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y5so3404430pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wst9WkhAE8w1i/iSuQ87C93Angtcy1Vxyzjf0uVZUto=;
        b=asUSG0RWhW2jWvbq6j4Ej9ikPSJaUQSEOYrJMLM0+6I1GuHPOGWkSiwni4tKNBOQvx
         JWYtr0LqOfW0kNrFuGCK015moQRZtxfPsCtcP2P9kQNQEE43W+NNxIC50h7SpIkAxknW
         6CJ6oTFwQIgvJKWuG0WaoxSKqPBxa5cMhYAQFY7nG5UsEveLi9kHC/n7izVoWK9UMWmG
         L+kCo5S4vf7v7Ih9TASliMzze94ck6dpK+NKzxJjW+WgUMyCvLgRKSkiCn2yrTliAXQE
         T3j1PcCZ+Co0b5QE8mEh4fHL0sf2btHtjb01yDHrr+aQ+cBI1eanf56NrPeHLsiblh94
         jJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wst9WkhAE8w1i/iSuQ87C93Angtcy1Vxyzjf0uVZUto=;
        b=NNwbJD5ySe1EdKwDC3wX90syFQ14I5fdK+I1GiQTl7ekGC+uGGzPsXEJ1v2HpPs3xK
         d9G16p8Viv6M2qogLYqoWxR48YSEUwKluoGXpRazGFC+Y4g9mlVsiLgTWlZtmda9WJ6o
         g3gnoYfTL0h0B3rRDn/WL4G3wXblM7WrIkRqPVQGCahG2gTHtZN2Gsl9pl687HsItFGi
         E4FsLJVN7F2KJdDDrfQynDDH/qEV6hRLD8fHyc4YCa7D9AqwrKyyMJ4A7tUyVhCL/I+P
         PNjcLQjNjEdFLxatxdoQH2GagzzHgQiD7FcLzkf9+zZTU1krq5jftuwKgtfGpy9aB6ev
         +M8Q==
X-Gm-Message-State: AOAM530qgXrG5WRSXiKTpz4QDP4OoaqfQgmxmkVuQeOLb6j4AHQcF6uZ
        pelijNupL9VLp2ASNizB0vY=
X-Google-Smtp-Source: ABdhPJwrYIjMbU4ewGuA3wIyTKMdc7otU+FFoJxpWYkloMx8VIiOCMTVADOkxI1xhRdMOJbIgCIang==
X-Received: by 2002:a63:7e42:: with SMTP id o2mr549436pgn.296.1636568246842;
        Wed, 10 Nov 2021 10:17:26 -0800 (PST)
Received: from Sauravs-MacBook-Air.local ([59.95.84.75])
        by smtp.gmail.com with ESMTPSA id nn4sm298205pjb.38.2021.11.10.10.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 10:17:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 23:47:15 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove goto statement
Message-ID: <YYwMq15pQYf7nvt9@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the goto statement from _rtw_init_recv_priv(). In this function goto
can be replace by return statement. As on goto label exit, function
only return it is not performing any cleanup. Avoiding goto will
improve the function readability.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 51a13262a226..b38af76f3a67 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -58,10 +58,8 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)

 	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);

-	if (!precvpriv->pallocated_frame_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!precvpriv->pallocated_frame_buf)
+		return _FAIL;

 	precvpriv->precv_frame_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);

@@ -89,7 +87,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	precvpriv->signal_stat_sampling_interval = 1000; /* ms */

 	rtw_set_signal_stat_timer(precvpriv);
-exit:

 	return res;
 }
--
2.33.0

