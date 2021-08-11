Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6D3E94D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhHKPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhHKPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:44:40 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E254C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:44:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id e14so2847789qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRtBef971rlq+8t7ebK6ZE1NaJkGBl7DnNtW7SBA9xA=;
        b=u3PKjEwz1LOxB4TlJNjVspaUcNxLQXUDhrpCG4PBK8kHPjKPMmIfOTU4VFMQk78mUJ
         93WvQ0wgXg35lPc8QMzOnV/slOp3YAFrDlR37cwED6NPwZYELlId429OvcSsCrkPZN6e
         HcIJXFzSNpYc9DlEDWm05INzGvzffgzy0mCXuqCQn7C+VIOaAXrkfohI43v9+PvAwV97
         6PzP7Ecx+HYVLGUCSgEcCmd0SxioNTphzSkU0F4X5stjti2ojWEs9yDkzL8zJP9wZ5f1
         JfOaXeZhpL9aol99cq/DRHuCfU6yqgI0/wgHOxAhOwtJodioLeKlG0cDRQl/FDNbO+yB
         hwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uRtBef971rlq+8t7ebK6ZE1NaJkGBl7DnNtW7SBA9xA=;
        b=gjEARMbhdsdql/2BSK8vEz9697vfr1M9iwOjc2g6GC6eOZ8oJja+fmqUFguR8/2dyz
         mk8snRR/BxOSW9Mb0RDvzkECFNSo4W1BccPOFD2iHaFL+2v/MSYawwzRhbw8PYOUtr93
         u4I07rr8fkPNiGinFm5z9BWBYj6pwbkSus0Ng8NG0Xs68DdbEBXmFBzRliDJWZcb0HHW
         cD0h6a4wHOkc0194+csu7Nye6uiVJPxMeF8g2lwwBq5caigIesOICPOHWPzzckPBPRB7
         2XJBqZpX5t0dv9VaTfwCboJ0NSCUeSrbYHeKC/TSL1Gmtnh8SEWeHWes13OHij95+NfJ
         rbHA==
X-Gm-Message-State: AOAM532K5PqZxyG/FvILF4INeAk0U1wJoqvh6xzi8ja3tpiwo8Q57q/p
        QDWhUQ1t+XySM8TShs2Qw+c2DPoAGCU=
X-Google-Smtp-Source: ABdhPJx6Q2ijPB9OXwpp5+oYtGZR5MO+FpVtmgJPExDml8eaqHACCvccX28V+MTDQ+O3BFMfhKJaAg==
X-Received: by 2002:a37:7801:: with SMTP id t1mr35161384qkc.162.1628696655152;
        Wed, 11 Aug 2021 08:44:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17sm6385896qtk.82.2021.08.11.08.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:44:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 08:44:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] staging: r8188eu: Remove wrapper around vfree
Message-ID: <20210811154412.GA1005754@roeck-us.net>
References: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
 <20210802192721.23110-3-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802192721.23110-3-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:27:17PM -0500, Larry Finger wrote:
> This call is so simple that there is no need, or use, for a wrapper.
> 

Except the wrapper was presumably there to map generic code to Linux
code, and the patch doesn't add an include <linux/vmalloc.h> anywhere.
This results in widespread build errrors such as

drivers/staging/r8188eu/core/rtw_mlme.c: In function '_rtw_free_mlme_priv':
drivers/staging/r8188eu/core/rtw_mlme.c:129:17: error: implicit declaration of function 'vfree'

for all architectures where <linux/vmalloc.h> isn't included indirectly.

Guenter

> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> v2 - no change
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c         |  4 +---
>  drivers/staging/r8188eu/core/rtw_mp.c           |  3 +--
>  drivers/staging/r8188eu/core/rtw_recv.c         |  5 +----
>  drivers/staging/r8188eu/core/rtw_sta_mgt.c      |  2 +-
>  drivers/staging/r8188eu/core/rtw_xmit.c         | 10 +++-------
>  drivers/staging/r8188eu/hal/odm_interface.c     |  2 +-
>  drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  2 +-
>  drivers/staging/r8188eu/include/osdep_service.h |  2 --
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c    |  4 ++--
>  drivers/staging/r8188eu/os_dep/osdep_service.c  |  7 +------
>  drivers/staging/r8188eu/os_dep/usb_intf.c       |  2 +-
>  11 files changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 3a83cf9731a0..c3763d9e448a 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -129,9 +129,7 @@ void _rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
>  	if (pmlmepriv) {
>  		rtw_mfree_mlme_priv_lock (pmlmepriv);
>  
> -		if (pmlmepriv->free_bss_buf) {
> -			rtw_vmfree(pmlmepriv->free_bss_buf, MAX_BSS_CNT * sizeof(struct wlan_network));
> -		}
> +		vfree(pmlmepriv->free_bss_buf);
>  	}
>  
>  }
> diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
> index a12c6e0ad002..c579f2e2fd62 100644
> --- a/drivers/staging/r8188eu/core/rtw_mp.c
> +++ b/drivers/staging/r8188eu/core/rtw_mp.c
> @@ -922,8 +922,7 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
>  		pxmitbuf++;
>  	}
>  
> -	if (pxmitpriv->pallocated_xmit_extbuf)
> -		rtw_vmfree(pxmitpriv->pallocated_xmit_extbuf, num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
> +	vfree(pxmitpriv->pallocated_xmit_extbuf);
>  
>  	if (padapter->registrypriv.mp_mode == 0) {
>  		max_xmit_extbuf_size = 6000;
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 610cc699caf9..08e095cd08b8 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -115,12 +115,9 @@ void _rtw_free_recv_priv (struct recv_priv *precvpriv)
>  
>  	rtw_os_recv_resource_free(precvpriv);
>  
> -	if (precvpriv->pallocated_frame_buf) {
> -		rtw_vmfree(precvpriv->pallocated_frame_buf, NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
> -	}
> +	vfree(precvpriv->pallocated_frame_buf);
>  
>  	rtw_hal_free_recv_priv(padapter);
> -
>  }
>  
>  struct recv_frame *_rtw_alloc_recvframe (struct __queue *pfree_recv_queue)
> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> index feaf39fddf7c..3b1a6a689d95 100644
> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> @@ -233,7 +233,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
>  		rtw_mfree_sta_priv_lock(pstapriv);
>  
>  		if (pstapriv->pallocated_stainfo_buf)
> -			rtw_vmfree(pstapriv->pallocated_stainfo_buf, sizeof(struct sta_info)*NUM_STA+4);
> +			vfree(pstapriv->pallocated_stainfo_buf);
>  		}
>  
>  	return _SUCCESS;
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 408d2b9955b9..87aa45c0305a 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -252,11 +252,9 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
>  		pxmitbuf++;
>  	}
>  
> -	if (pxmitpriv->pallocated_frame_buf)
> -		rtw_vmfree(pxmitpriv->pallocated_frame_buf, NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
> +	vfree(pxmitpriv->pallocated_frame_buf);
>  
> -	if (pxmitpriv->pallocated_xmitbuf)
> -		rtw_vmfree(pxmitpriv->pallocated_xmitbuf, NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
> +	vfree(pxmitpriv->pallocated_xmitbuf);
>  
>  	/*  free xmit extension buff */
>  	_rtw_spinlock_free(&pxmitpriv->free_xmit_extbuf_queue.lock);
> @@ -267,9 +265,7 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
>  		pxmitbuf++;
>  	}
>  
> -	if (pxmitpriv->pallocated_xmit_extbuf) {
> -		rtw_vmfree(pxmitpriv->pallocated_xmit_extbuf, num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
> -	}
> +	vfree(pxmitpriv->pallocated_xmit_extbuf);
>  
>  	rtw_free_hwxmits(padapter);
>  
> diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
> index 507baf9fd913..38f6ae410e53 100644
> --- a/drivers/staging/r8188eu/hal/odm_interface.c
> +++ b/drivers/staging/r8188eu/hal/odm_interface.c
> @@ -85,7 +85,7 @@ void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length)
>  /*  length could be ignored, used to detect memory leakage. */
>  void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length)
>  {
> -	rtw_vmfree(pPtr, length);
> +	vfree(pPtr);
>  }
>  
>  s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index 62d8a7ca3a9a..a8e2081f3540 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -363,7 +363,7 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
>  			} while (!rstatus && (loop++ < 10));
>  		}
>  		rtw_IOL_cmd_buf_dump(Adapter, data_len, pbuf);
> -		rtw_vmfree(pbuf, data_len+10);
> +		vfree(pbuf);
>  	}
>  	DBG_88E("###### %s ######\n", __func__);
>  }
> diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
> index 4575f5da5f70..446f43ac08d3 100644
> --- a/drivers/staging/r8188eu/include/osdep_service.h
> +++ b/drivers/staging/r8188eu/include/osdep_service.h
> @@ -214,10 +214,8 @@ extern unsigned char RSN_TKIP_CIPHER[4];
>  #define rtw_update_mem_stat(flag, sz) do {} while (0)
>  u8 *_rtw_vmalloc(u32 sz);
>  u8 *_rtw_zvmalloc(u32 sz);
> -void _rtw_vmfree(u8 *pbuf, u32 sz);
>  #define rtw_vmalloc(sz)			_rtw_vmalloc((sz))
>  #define rtw_zvmalloc(sz)			_rtw_zvmalloc((sz))
> -#define rtw_vmfree(pbuf, sz)		_rtw_vmfree((pbuf), (sz))
>  
>  void *rtw_malloc2d(int h, int w, int size);
>  
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 5f4355cb03e7..11301e0f287a 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -5575,7 +5575,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
>  		return -ENOMEM;
>  
>  	if (copy_from_user(ext, dwrq->pointer, len)) {
> -		rtw_vmfree(ext, len);
> +		vfree(ext);
>  		return -EFAULT;
>  	}
>  
> @@ -5614,7 +5614,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
>  
>  FREE_EXT:
>  
> -	rtw_vmfree(ext, len);
> +	vfree(ext);
>  
>  	return ret;
>  }
> diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
> index 8d89b98545cf..ec877615bdf7 100644
> --- a/drivers/staging/r8188eu/os_dep/osdep_service.c
> +++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
> @@ -53,11 +53,6 @@ inline u8 *_rtw_zvmalloc(u32 sz)
>  	return pbuf;
>  }
>  
> -inline void _rtw_vmfree(u8 *pbuf, u32 sz)
> -{
> -	vfree(pbuf);
> -}
> -
>  void *rtw_malloc2d(int h, int w, int size)
>  {
>  	int j;
> @@ -296,7 +291,7 @@ void rtw_free_netdev(struct net_device *netdev)
>  	if (!pnpi->priv)
>  		goto RETURN;
>  
> -	rtw_vmfree(pnpi->priv, pnpi->sizeof_priv);
> +	vfree(pnpi->priv);
>  	free_netdev(netdev);
>  
>  RETURN:
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 270de35f1d35..2c372c9ad7e7 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -702,7 +702,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>  		if (pnetdev)
>  			rtw_free_netdev(pnetdev);
>  		else if (padapter)
> -			rtw_vmfree((u8 *)padapter, sizeof(*padapter));
> +			vfree(padapter);
>  		padapter = NULL;
>  	}
>  exit:
