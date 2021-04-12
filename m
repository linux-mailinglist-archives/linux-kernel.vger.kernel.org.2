Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0B35C2E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbhDLJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243858AbhDLJnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:43:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3C66120B;
        Mon, 12 Apr 2021 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220573;
        bh=QQcwfSQicEJoFkfez95/GrPUforwFqy4SFX5gB8Wgo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMflWhuZ8YBXzWup5dObfP5kwM8oRRETd719RfpoI8u3yjFdzfZriVrHdsHgVJLhe
         ZQ654AVca8LXFWC1cAL+t6JMXoj+BlqQmW8+Vuq4EAYAYxTMgcbH1j9EntnDeN6hvf
         aFPcyaQMIbn7sZcxo1kxTz4p6mzYSlN1krWh+AQE=
Date:   Mon, 12 Apr 2021 11:42:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove function
Message-ID: <YHQWG2f34jhA41lK@kroah.com>
References: <20210411184813.22836-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411184813.22836-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 08:48:13PM +0200, Fabio M. De Francesco wrote:
> Remove cmpk_handle_query_config_rx() because it just initializes a local
> variable and then returns "void".
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8192u/r819xU_cmdpkt.c | 40 ------------------------
>  1 file changed, 40 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> index 4cece40a92f6..d5a54c2d3086 100644
> --- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> +++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> @@ -249,46 +249,6 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
>  	DMESG("<---- cmpk_handle_interrupt_status()\n");
>  }
>  
> -/*-----------------------------------------------------------------------------
> - * Function:    cmpk_handle_query_config_rx()
> - *
> - * Overview:    The function is responsible for extract the message from
> - *		firmware. It will contain dedicated info in
> - *		ws-06-0063-rtl8190-command-packet-specification. Please
> - *		refer to chapter "Beacon State Element".
> - *
> - * Input:       u8    *pmsg	-	Message Pointer of the command packet.
> - *
> - * Output:      NONE
> - *
> - * Return:      NONE
> - *
> - * Revised History:
> - *  When		Who	Remark
> - *  05/12/2008		amy	Create Version 0 porting from windows code.
> - *
> - *---------------------------------------------------------------------------
> - */
> -static void cmpk_handle_query_config_rx(struct net_device *dev, u8 *pmsg)
> -{
> -	struct cmpk_query_cfg	rx_query_cfg;
> -
> -	/* 1. Extract TX feedback info from RFD to temp structure buffer. */
> -	/* It seems that FW use big endian(MIPS) and DRV use little endian in
> -	 * windows OS. So we have to read the content byte by byte or transfer
> -	 * endian type before copy the message copy.
> -	 */
> -	rx_query_cfg.cfg_action		= (pmsg[4] & 0x80) >> 7;
> -	rx_query_cfg.cfg_type		= (pmsg[4] & 0x60) >> 5;
> -	rx_query_cfg.cfg_size		= (pmsg[4] & 0x18) >> 3;
> -	rx_query_cfg.cfg_page		= (pmsg[6] & 0x0F) >> 0;
> -	rx_query_cfg.cfg_offset		= pmsg[7];
> -	rx_query_cfg.value		= (pmsg[8]  << 24) | (pmsg[9]  << 16) |
> -					  (pmsg[10] <<  8) | (pmsg[11] <<  0);
> -	rx_query_cfg.mask		= (pmsg[12] << 24) | (pmsg[13] << 16) |
> -					  (pmsg[14] <<  8) | (pmsg[15] <<  0);
> -}
> -
>  /*-----------------------------------------------------------------------------
>   * Function:	cmpk_count_tx_status()
>   *
> -- 
> 2.31.1
> 
> 

Always test-build your patches as they can not break the build.  You
obviously did not do that here, why not?

thanks,

greg k-h
