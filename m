Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5A3F1002
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhHSBfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhHSBfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:35:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 18:34:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v2so6169153edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 18:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFPIaFZ0EFL3LdreWHVYcsMYnslZyIMVhhTaiagDQ0M=;
        b=Kazu3KHY36brXdPWa9ji6/2nsYT5DQt4AtvmUPt/9EsYODW3AFnUHQCGlR/FLg8DYh
         yEhcbeLoC73786B90EGz+zZ6+hF+6BgZdULEumOXPIcC0onFfukGSQ/Ro+i9X//qEQI3
         QXDHQtz/lU2NlAM+GIpmEOzZI+r9+GgckswXz4H7QTGGrZQ/PEbhAJyqTjZFVbWpaINF
         OSVLVFzwLIhzwdhlJYi/Ud1qRyQCDcIP5b6L+hyTnXDsmHQ/HsoBXbjbEaZyijlOsRwz
         FJAQeqKig0OiFR9QX5p6g/2S9I3TuUaR0cUSr4XweyGN9iO7OFvEHBAXqW9lPSWVXrau
         Hcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFPIaFZ0EFL3LdreWHVYcsMYnslZyIMVhhTaiagDQ0M=;
        b=I5qpszwCweCwH0t+Lr0AduLLNRFr/rw+xI0/nfEPULcJX1P5qH/T1Oaojde0e3l4e+
         pLEwpO3xvaTfV5MvwlZNkLTufm7N9t819Q2wugogMeiqZZ7DL4oyDgzE8feerLrx36ui
         AvRXrwdpAWQC5LJT1iGVrqKrvzZfXyGOnNLpZeXQrVf+qwkYK84Gl9AVzhRCp+ldNX0U
         4ERHvTPYMDRWyb0/Ood9Gysgjwkpo3uSQQfwYNyRnGX4EirfalFCGdGbCsPrbj7Ve/eb
         6hXUURRexqfJmXv21/i9/+1oYC84WrAEV/a1/zuSsgRKNpQtG0wZmX5U85/GCoU9TDEx
         T2JA==
X-Gm-Message-State: AOAM531sXQyJdVuOJ7DwFtLP04d7Rjm1CJIvAUrAs7Gh++UIpgkY7Brd
        dfr2SrRKoeGkQmeOJ/WyL+Y=
X-Google-Smtp-Source: ABdhPJxboThhpsVQk1YsZr8UvRyLVd8I7QhjDRfxdc+UqG3X+ED0EtptZqG6wYkO0Jr92XGOK/KIlA==
X-Received: by 2002:aa7:d951:: with SMTP id l17mr13281750eds.92.1629336873423;
        Wed, 18 Aug 2021 18:34:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id v6sm551892ejk.117.2021.08.18.18.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 18:34:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH 1/6] staging: r8188eu: remove _dbg_dump_tx_info function
Date:   Thu, 19 Aug 2021 03:34:31 +0200
Message-ID: <9701067.u0aNz3o6e4@localhost.localdomain>
In-Reply-To: <20210818234253.208271-2-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk> <20210818234253.208271-2-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2021 1:42:48 AM CEST Phillip Potter wrote:
> Remove _dbg_dump_tx_info from hal/rtl8188e_xmit.c as it is just a
> dumping function that contains a lot of unclear DBG_88E calls, and has
> no other external effect, other than calling a function that ultimately
> determines whether or not to dump/trigger the DBG_88E calls. Also remove
> its declaration and single call site.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 31 -------------------
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  1 -
>  .../staging/r8188eu/include/rtl8188e_xmit.h   |  3 --
>  3 files changed, 35 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
> index 164ec6650dec..d2b55d581f95 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
> @@ -42,34 +42,3 @@ void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
>  					RTW_SCTX_DONE_CCX_PKT_FAIL);
>  	}
>  }
> -
> -void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
> -		       struct tx_desc *ptxdesc)
> -{
> -	u8 dmp_txpkt;
> -	bool dump_txdesc = false;
> -	rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(dmp_txpkt));
> -
> -	if (dmp_txpkt == 1) {/* dump txdesc for data frame */
> -		DBG_88E("dump tx_desc for data frame\n");
> -		if ((frame_tag & 0x0f) == DATA_FRAMETAG)
> -			dump_txdesc = true;
> -	} else if (dmp_txpkt == 2) {/* dump txdesc for mgnt frame */
> -		DBG_88E("dump tx_desc for mgnt frame\n");
> -		if ((frame_tag & 0x0f) == MGNT_FRAMETAG)
> -			dump_txdesc = true;
> -	}
> -
> -	if (dump_txdesc) {
> -		DBG_88E("=====================================\n");
> -		DBG_88E("txdw0(0x%08x)\n", ptxdesc->txdw0);
> -		DBG_88E("txdw1(0x%08x)\n", ptxdesc->txdw1);
> -		DBG_88E("txdw2(0x%08x)\n", ptxdesc->txdw2);
> -		DBG_88E("txdw3(0x%08x)\n", ptxdesc->txdw3);
> -		DBG_88E("txdw4(0x%08x)\n", ptxdesc->txdw4);
> -		DBG_88E("txdw5(0x%08x)\n", ptxdesc->txdw5);
> -		DBG_88E("txdw6(0x%08x)\n", ptxdesc->txdw6);
> -		DBG_88E("txdw7(0x%08x)\n", ptxdesc->txdw7);
> -		DBG_88E("=====================================\n");
> -	}
> -}
> diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
> index 50c4b9382761..b279309405a2 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
> @@ -330,7 +330,6 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
>  	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);
>  
>  	rtl8188eu_cal_txdesc_chksum(ptxdesc);
> -	_dbg_dump_tx_info(adapt, pxmitframe->frame_tag, ptxdesc);
>  	return pull;
>  }
>  
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
> index ff8b73441c52..d2099da1a41a 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
> @@ -153,7 +153,4 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
>  void dump_txrpt_ccx_88e(void *buf);
>  void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
>  
> -void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
> -		       struct tx_desc *ptxdesc);
> -
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




