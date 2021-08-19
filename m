Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEA3F1004
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 03:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhHSBjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhHSBjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:39:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3541C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 18:38:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so9214999ejz.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uxvhx5qQEKKi3Un1EErfZdduybbw8VIvWqfruEYV5Xg=;
        b=lZv7tQlPuYTvi3z3D1uNsFp5PKBGrL1wbF8bwvQBYXsREHAFSa5M0R8f9EZo1AyYcC
         hvf4bCYipsBQs6l56TzQI2YepEgsNlRDvuctWk9k9K3RvfxM0KUVpb2Iahpj26e2C7T8
         vlq5SNzSkoH/B4ChIOwCVD9blQtxrZ9cI2fxWb9hWeY9pFH3qVbjastJU1CBwZGSFgFL
         0/+IuTksjGbiJMAmFOkbPDK+WAlmybO1WFVR97Hll6TOTzbfqaqL8BRJyfPa0fohmnDz
         +NRYHBSAu/m8LfjkUyY88VAHtDbbkMJ5H2f5nbRrvse5hjKa8V3tCR5I8OLjZ8OQDx4x
         e/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uxvhx5qQEKKi3Un1EErfZdduybbw8VIvWqfruEYV5Xg=;
        b=EiAWfXTUzRmtb0QqyscwVGCRaqEv2FRmwJeY28qnBv1u48mfNPuySRhVZsjdJbLJBo
         c4xsrCmypaB/vdmvx9VqmP29AbGmvgNsuZ2fWoJd0iwTDSw+a5IXNRzh/GC3U/QRa98D
         KOt4zkEnVSmWiSTXIegPFuaHbNOGn20FRu7amou+K7xTAn4ZTYLq9+dLdFZCa5dUm/kt
         /yBD0oSM1RLXaouEYQhUD0fAfzKmN1QpYmcD6iEYiPTzXY712RSLkvsfRtWyuzeYOQFl
         r2beNUvhmp3A7i8C9UhjhlxcYzIjmDSrogMmq297OkZ/uuU+MYpZUSE/uUEp62L8nKVs
         M1Wg==
X-Gm-Message-State: AOAM532VKmb2yepSkjY0j7/lA8cdSbOcsQH1IfdcVT0JJG0xsxfzJjh3
        o6ZOKhdxT4WyGZ5/wJHfdO4=
X-Google-Smtp-Source: ABdhPJzvZCWdzjpF0V3e2EgViiP0yS/G0OeBvs4n4H+vbbbB6xbaThxpmrOspDmDvwIiP5+PweR4Uw==
X-Received: by 2002:a17:906:410c:: with SMTP id j12mr12857231ejk.553.1629337123290;
        Wed, 18 Aug 2021 18:38:43 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id w11sm898729edc.5.2021.08.18.18.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 18:38:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH 2/6] staging: r8188eu: remove unused function dump_txrpt_ccx_88e
Date:   Thu, 19 Aug 2021 03:38:41 +0200
Message-ID: <3469308.GW2Jk8YpuN@localhost.localdomain>
In-Reply-To: <20210818234253.208271-3-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk> <20210818234253.208271-3-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2021 1:42:49 AM CEST Phillip Potter wrote:
> Remove unused function dump_txrpt_ccx_88e from hal/rtl8188e_xmit.c and
> remove its declaration in include/rtl8188e_xmit.h, as this function is
> not called from anywhere, and is thus dead code.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 22 -------------------
>  .../staging/r8188eu/include/rtl8188e_xmit.h   |  1 -
>  2 files changed, 23 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
> index d2b55d581f95..46b871f3f631 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
> @@ -7,28 +7,6 @@
>  #include "../include/drv_types.h"
>  #include "../include/rtl8188e_hal.h"
>  
> -void dump_txrpt_ccx_88e(void *buf)
> -{
> -	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
> -
> -	DBG_88E("%s:\n"
> -		"tag1:%u, pkt_num:%u, txdma_underflow:%u, int_bt:%u, int_tri:%u, int_ccx:%u\n"
> -		"mac_id:%u, pkt_ok:%u, bmc:%u\n"
> -		"retry_cnt:%u, lifetime_over:%u, retry_over:%u\n"
> -		"ccx_qtime:%u\n"
> -		"final_data_rate:0x%02x\n"
> -		"qsel:%u, sw:0x%03x\n",
> -		__func__, txrpt_ccx->tag1, txrpt_ccx->pkt_num,
> -		txrpt_ccx->txdma_underflow, txrpt_ccx->int_bt,
> -		txrpt_ccx->int_tri, txrpt_ccx->int_ccx,
> -		txrpt_ccx->mac_id, txrpt_ccx->pkt_ok, txrpt_ccx->bmc,
> -		txrpt_ccx->retry_cnt, txrpt_ccx->lifetime_over,
> -		txrpt_ccx->retry_over, txrpt_ccx_qtime_88e(txrpt_ccx),
> -		txrpt_ccx->final_data_rate, txrpt_ccx->qsel,
> -		txrpt_ccx_sw_88e(txrpt_ccx)
> -	);
> -}
> -
>  void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
>  {
>  	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
> index d2099da1a41a..20b55e3850ba 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
> @@ -150,7 +150,6 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
>  				 struct xmit_priv *pxmitpriv,
>  				 struct xmit_buf *pxmitbuf);
>  
> -void dump_txrpt_ccx_88e(void *buf);
>  void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
>  
>  #endif /* __RTL8188E_XMIT_H__ */
> -- 
> 2.31.1
> 
At a quick look it looks good. 

Built with "make C=2 -j8 drivers/staging/r8188eu/ W=1"
on x86-64, it does not introduce any errors or warnings, so...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio



