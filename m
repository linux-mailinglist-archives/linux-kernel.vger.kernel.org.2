Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CFA3F9C62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhH0Q1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234869AbhH0Q1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:27:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CF5460E99;
        Fri, 27 Aug 2021 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630081589;
        bh=XcwTyPvhF+XagpNWN7XvIWRONRDMX7PNgx8dms2IJKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zZZwsdvfC7UF7x+yUhUHwnTwKtpiNvR4VVtzho/JTxPj4NPhZYfg0Ydm+LN7dcqjW
         Yo9yzWfF8ihkG8lAgVtZgd8kImnR+AljgNnmYfH0a//+/1kjFPiDIqWSYqD3irahdP
         lxW+FiuwQVytiAGGKS2FDN6m2OqxMboskcpEkeVE=
Date:   Fri, 27 Aug 2021 18:26:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8723bs: remove sdio_write_mem()
Message-ID: <YSkSLrmhb4AcKlWu@kroah.com>
References: <cover.1630080164.git.hello@bryanbrattlof.com>
 <39bc74b0303bb31cef0ac44b9ae2b2aa7abbe645.1630080164.git.hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bc74b0303bb31cef0ac44b9ae2b2aa7abbe645.1630080164.git.hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 04:13:15PM +0000, Bryan Brattlof wrote:
> The sdio_write_mem() function is unused in the driver. We can remove it.
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_ops.c   | 11 -----------
>  drivers/staging/rtl8723bs/include/rtw_io.h |  1 -
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index a545832a468e..b784a390c8e1 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -356,16 +356,6 @@ static void sdio_read_mem(
>  	sdio_readN(intfhdl, addr, cnt, rmem);
>  }
> 
> -static void sdio_write_mem(
> -	struct intf_hdl *intfhdl,
> -	u32 addr,
> -	u32 cnt,
> -	u8 *wmem
> -)
> -{
> -	sdio_writeN(intfhdl, addr, cnt, wmem);
> -}
> -
>  /*
>   * Description:
>   *Read from RX FIFO
> @@ -474,7 +464,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct _io_ops *ops)
>  	ops->_write16 = &sdio_write16;
>  	ops->_write32 = &sdio_write32;
>  	ops->_writeN = &sdio_writeN;
> -	ops->_write_mem = &sdio_write_mem;
>  	ops->_write_port = &sdio_write_port;
>  }
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
> index e98083a07a66..87f36b7e880f 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_io.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_io.h
> @@ -91,7 +91,6 @@ struct _io_ops {
>  		int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
> 
>  		void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
> -		void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
> 
>  		void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
> 
> --
> 2.30.2
> 
> 
> 

THis changed from the previous version in ways you did not document
anywhere.  Please fix up in your v4 notes.
