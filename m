Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE933F85D3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbhHZKvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234327AbhHZKvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:51:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3BF2606A5;
        Thu, 26 Aug 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629975014;
        bh=6dJzEXQA1Uf6AiMMx1L4sJuNorAspoUQIT8dxjE1u64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+R+OW5TJVwA5EQoJcbP0SUfORf8RcGgP7LuVVPDy/hMe+3QRSQLIG39CtkCwKbhr
         R/BT+bcNjvqw5Z8wu5OshYmexSo/59MXECcDbH6xUSH/7lxB/1Tcn90IfVbOfly1yt
         /VKGAeyxHzQO6NV/NCWyVmruu3q3x9IwxicHuElc=
Date:   Thu, 26 Aug 2021 12:50:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Message-ID: <YSdx4ixYYAyZkOzR@kroah.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <d06f3173e0a4c6f5449d5551cbfb0202849332b7.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06f3173e0a4c6f5449d5551cbfb0202849332b7.1629789580.git.paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:27:35AM +0300, Pavel Skripkin wrote:
> _rtw_read16 function can fail in case of usb transfer failure. But
> previous function prototype wasn't designed to return an error to
> caller. It can cause a lot uninit value bugs all across the driver code,
> since rtw_read16() returns local stack variable to caller.
> 
> Fix it by changing the prototype of this function. Now it returns an
> int: 0 on success, negative error value on failure and callers should pass
> the pointer to storage location for register value.
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_debug.c      |  7 +++-
>  drivers/staging/r8188eu/core/rtw_io.c         |  9 ++---
>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  4 +-
>  drivers/staging/r8188eu/hal/odm_interface.c   |  4 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 29 +++++++++++----
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  5 ++-
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 37 ++++++++++++++++---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   | 22 +++++++++--
>  .../staging/r8188eu/include/odm_interface.h   |  2 +-
>  drivers/staging/r8188eu/include/rtw_io.h      |  6 +--
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 28 +++++++++++---
>  11 files changed, 115 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
> index 8b7d3eb12bd0..a41675e101ac 100644
> --- a/drivers/staging/r8188eu/core/rtw_debug.c
> +++ b/drivers/staging/r8188eu/core/rtw_debug.c
> @@ -91,7 +91,12 @@ int proc_get_read_reg(char *page, char **start,
>  				proc_get_read_addr, (u8) tmp);
>  		break;
>  	case 2:
> -		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n", proc_get_read_addr, rtw_read16(padapter, proc_get_read_addr));
> +		error = rtw_read16(padapter, proc_get_read_addr, (u16 *) &tmp);
> +		if (error)
> +			return len;
> +
> +		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n",
> +				proc_get_read_addr, (u16) tmp);
>  		break;
>  	case 4:
>  		len += snprintf(page + len, count - len, "rtw_read32(0x%x)=0x%x\n", proc_get_read_addr, rtw_read32(padapter, proc_get_read_addr));
> diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
> index 2714506c8ffb..fd64893c778d 100644
> --- a/drivers/staging/r8188eu/core/rtw_io.c
> +++ b/drivers/staging/r8188eu/core/rtw_io.c
> @@ -45,18 +45,15 @@ int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
>  	return _read8(pintfhdl, addr, data);
>  }
>  
> -u16 _rtw_read16(struct adapter *adapter, u32 addr)
> +int __must_check _rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
>  {
> -	u16 r_val;
>  	struct io_priv *pio_priv = &adapter->iopriv;
>  	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
> -	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
> +	int (*_read16)(struct intf_hdl *pintfhdl, u32 addr, u16 *data);
>  
>  	_read16 = pintfhdl->io_ops._read16;

Why do you need this extra pointer abstraction anyway?  Please unwind
that first, which will make this function go away (or get easier to
understand at the least...)

thanks,

greg k-h
