Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1A40C9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhIOQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhIOQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:07:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E76C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:06:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso4232516otv.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ISVv1atSRTyYqw35Va1vQyD5cjgJi0F9b5ypn+Ek17k=;
        b=FNKt/2RVm35X+MKmP0UvQfr8+x6j8k5p/H6MwV0U8RF+9Q+2K9FwQiwt0DvA0cEyI/
         gQBdFbqKvslpE3cHCOm9uaxWcmidZGipyFWy40r7rjovw3EYPMLdliNKJJChaunXSdAi
         dbbnNoffAl8EoNYdO2Oa1FP0IEi2mAzQEjBpVmSuQ7YGnM3J1Vyf1G6xFEy04V75x5Qh
         Vhyd/Ux7ACAWjzbtBBO88/zDobpOZ2qijNxx6IPsbkDMWvcUp4MT845LJsy9VWSCT6gg
         l8NZA9cJPs2L8lqDW8yDePBA+KWGTB+AXH/TADMH9sAOh5mK4kEv86vIGES+4NEWQ9Au
         5ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ISVv1atSRTyYqw35Va1vQyD5cjgJi0F9b5ypn+Ek17k=;
        b=zakMK7BtZtY0SKiGpkbb56LIuaxtoToX2jxNkuVpbgYB035xMUxSMhVFkpU1KpAeGR
         mgP5Lfn4yR7nPqu0DTcgT96Yh2lHBkGCKdTyTrZfDihNzrgi7VYDUGlAn3DT0ry1NhJk
         qTrCkBsjI1XoEvoeE3rrYwJv152/8OeXh/SmOgc4CMqKFuCUMeRJyoA7vHEn8Sn4Bq+p
         iSVB2h7ns9NnzBnAGu7AU7yJSKWmixJje+b2guPRsmTTPRosRKK6l5GL4si9lYse460X
         H2rieuJLl96rY4/9GxrwhYkKKOac0hSDgLwv1t/cbdAjzGaSVBR6kbfMvVGOqMwB+eMV
         ii0Q==
X-Gm-Message-State: AOAM5310FmTsQUFbJf7zH6PfP08ydgYYf5lgXUrHiFK5AMPWYx6BJpSR
        29iEkm3IhdC5fONUOHcRquGNV3Y28So=
X-Google-Smtp-Source: ABdhPJyVkbAyqqHjYzoVgnBBeNWM9UBbJpVryIa+1MgbDiKM9Ppa9i4KBFs5ocWqrIypvV9rVVIffg==
X-Received: by 2002:a9d:7c88:: with SMTP id q8mr630037otn.367.1631721999749;
        Wed, 15 Sep 2021 09:06:39 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1007? (2603-8090-2005-39b3-0000-0000-0000-1007.res6.spectrum.com. [2603:8090:2005:39b3::1007])
        by smtp.gmail.com with ESMTPSA id h19sm73054otr.75.2021.09.15.09.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:06:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6f89f419-edaf-296a-1021-cdc12f218e7a@lwfinger.net>
Date:   Wed, 15 Sep 2021 11:06:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v5 10/19] staging: r8188eu: remove the helpers of
 usb_write_port()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
 <20210915124149.27543-11-fmdefrancesco@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20210915124149.27543-11-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 07:41, Fabio M. De Francesco wrote:
> From: Pavel Skripkin <paskripkin@gmail.com>
> 
> Remove the unnecessary _rtw_write_port() and usb_write_port() and embed
> their code into the caller (i.e., rtw_write_port()).
> 
> _rtw_write_port() is a mere redefinition of rtw_write_port() and it is
> unneeded. usb_write_port() was the only functions assigned to the
> (*_usb_write_port) pointer, so we can simply remove it and make a direct
> call.
> 
> This patch is in preparation for the _io_ops structure removal.
> 
> Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_io.c         | 20 +------------------
>   drivers/staging/r8188eu/hal/usb_ops_linux.c   |  1 -
>   drivers/staging/r8188eu/include/rtw_io.h      |  4 +---
>   .../staging/r8188eu/include/usb_ops_linux.h   |  1 -
>   .../staging/r8188eu/os_dep/usb_ops_linux.c    |  3 +--
>   5 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
> index ac72f894da75..3a5e9dbfcb12 100644
> --- a/drivers/staging/r8188eu/core/rtw_io.c
> +++ b/drivers/staging/r8188eu/core/rtw_io.c
> @@ -87,24 +87,6 @@ void _rtw_read_port_cancel(struct adapter *adapter)
>   		_read_port_cancel(pintfhdl);
>   }
>   
> -u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
> -{
> -	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
> -	struct io_priv *pio_priv = &adapter->iopriv;
> -	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
> -	u32 ret = _SUCCESS;
> -
> -
> -
> -	_write_port = pintfhdl->io_ops._write_port;
> -
> -	ret = _write_port(pintfhdl, addr, cnt, pmem);
> -
> -
> -
> -	return ret;
> -}
> -
>   u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem, int timeout_ms)
>   {
>   	int ret = _SUCCESS;
> @@ -114,7 +96,7 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pme
>   	rtw_sctx_init(&sctx, timeout_ms);
>   	pxmitbuf->sctx = &sctx;
>   
> -	ret = _rtw_write_port(adapter, addr, cnt, pmem);
> +	ret = rtw_write_port(adapter, addr, cnt, pmem);
>   
>   	if (ret == _SUCCESS)
>   		ret = rtw_sctx_wait(&sctx);
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index a104e3fac7d1..4fea21c0f7af 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -562,7 +562,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
>   {
>   
>   	memset((u8 *)pops, 0, sizeof(struct _io_ops));
> -	pops->_write_port = &usb_write_port;
>   	pops->_read_port_cancel = &usb_read_port_cancel;
>   	pops->_write_port_cancel = &usb_write_port_cancel;
>   
> diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
> index 600c6e7a375b..f2b1978b6e80 100644
> --- a/drivers/staging/r8188eu/include/rtw_io.h
> +++ b/drivers/staging/r8188eu/include/rtw_io.h
> @@ -262,7 +262,7 @@ int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val);
>   int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val);
>   
>   void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> -u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
> +u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>   u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
>   			     u8 *pmem, int timeout_ms);
>   void _rtw_write_port_cancel(struct adapter *adapter);
> @@ -275,8 +275,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
>   	_rtw_write16_async((adapter), (addr), (val))
>   #define rtw_write32_async(adapter, addr, val)				\
>   	_rtw_write32_async((adapter), (addr), (val))
> -#define rtw_write_port(adapter, addr, cnt, mem)				\
> -	_rtw_write_port((adapter), (addr), (cnt), (mem))
>   #define rtw_write_port_and_wait(adapter, addr, cnt, mem, timeout_ms)	\
>   	_rtw_write_port_and_wait((adapter), (addr), (cnt), (mem), (timeout_ms))
>   #define rtw_write_port_cancel(adapter) _rtw_write_port_cancel((adapter))
> diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
> index 37e0614fd15c..bdc596fe5854 100644
> --- a/drivers/staging/r8188eu/include/usb_ops_linux.h
> +++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
> @@ -30,7 +30,6 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
>   
>   void usb_read_port_cancel(struct intf_hdl *pintfhdl);
>   
> -u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem);
>   void usb_write_port_cancel(struct intf_hdl *pintfhdl);
>   
>   #endif
> diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> index 9afb4df71969..36ef06f88fdd 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> @@ -124,14 +124,13 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
>   
>   }
>   
> -u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
> +u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
>   {
>   	unsigned long irqL;
>   	unsigned int pipe;
>   	int status;
>   	u32 ret = _FAIL;
>   	struct urb *purb = NULL;
> -	struct adapter *padapter = (struct adapter *)pintfhdl->padapter;
>   	struct dvobj_priv	*pdvobj = adapter_to_dvobj(padapter);
>   	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
>   	struct xmit_buf *pxmitbuf = (struct xmit_buf *)wmem;
> 

Patch 1 failed to apply to Greg's staging-testing branch. Particularly with the 
changes with large number of patches, you need to remove the commits in 
question, got a 'git pull', and then test that your changes still apply.

Larry


