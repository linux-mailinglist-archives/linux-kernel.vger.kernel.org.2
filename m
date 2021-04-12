Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9E35C37A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhDLKOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbhDLKMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:12:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64577C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:12:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m3so14371832edv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mF+6SGO1JLL8M4234s6vYG5jQ2k4t0YfQWKHCjz7COY=;
        b=dPe43xTptCxH/ooeJ+PlNENISk5DTUt4gdP5FIiRkXxTA/CRz+ITFNzkn33yehExKV
         jo+VCt8J+OxFPF/6YWy1ZXa+vjNM5S4ZtVpueShKdagx9ZIB/p0o8JvygqK0OZDLnMcT
         QGST+WaZdtAMZsKLC9SVfkx9GDhTudQ8I9qjVbgyoX4vnvvSDikoig1VgqleyaGVbeWt
         253u+b3ivBDVQBtptksigzV5YE7swNAheTq8RKGowWW9DnSSRxDK9EijJS2HAcZDZo4b
         PQHHKzj8M8G8NYKYP/9EypOoajqSIolCkAuDmUt5PBOLSr8b+ciHev20/o17ZcWiN8Q9
         MSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mF+6SGO1JLL8M4234s6vYG5jQ2k4t0YfQWKHCjz7COY=;
        b=fXSUgWobRL94+PbYBkhknHtumsu/WA2ugaG+L5VFblXGZQnBVzM68gur7RdaGGShkF
         1BGxZMbfYXOp4eY1nhnGZTw8t8Gfk4N8hpU/7seIrT5rdSBh8mWgle1WKIZOXhgsF/xi
         3SnIj0BIRD414WnSt0pzhHlDDbSQ9DEgGZ7gZgy8p0hx4M/V5QDPGQoWSVUtPM50osRh
         StfV6VmlgtGsGzBCCPY8oY51+vJRUStBPWWllJC7O31/U1z2Zqrv455OjpDEshXCBhTF
         1EZv9F5kE7QkLlIE+k4Bx3emXHcGZdGNqDElLmiXYEU7HVwmG9EmUDZqhTHP2WKJyyGF
         Afqw==
X-Gm-Message-State: AOAM530TZuC4dJmWfiJTsxROlZynxabZ0xXHhxBOkwNo0tObKDGfojmt
        L/l8I69AGFOtfHBYvIbagDo=
X-Google-Smtp-Source: ABdhPJxAJG31dXCdts6fVyOxmHsmyqRMGHD1zCqAfamsliKBSAzI2E+EV1fILkDCp1ukdr7aGj2Mmg==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr22951918eds.52.1618222356109;
        Mon, 12 Apr 2021 03:12:36 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id i16sm4948733ejc.106.2021.04.12.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 03:12:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove function
Date:   Mon, 12 Apr 2021 12:12:34 +0200
Message-ID: <4388012.RVq5xMhMDq@linux.local>
In-Reply-To: <YHQWG2f34jhA41lK@kroah.com>
References: <20210411184813.22836-1-fmdefrancesco@gmail.com> <YHQWG2f34jhA41lK@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 12, 2021 11:42:51 AM CEST Greg KH wrote:
> On Sun, Apr 11, 2021 at 08:48:13PM +0200, Fabio M. De Francesco wrote:
> > Remove cmpk_handle_query_config_rx() because it just initializes a
> > local
> > variable and then returns "void".
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/rtl8192u/r819xU_cmdpkt.c | 40 ------------------------
> >  1 file changed, 40 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > b/drivers/staging/rtl8192u/r819xU_cmdpkt.c index
> > 4cece40a92f6..d5a54c2d3086 100644
> > --- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > +++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > @@ -249,46 +249,6 @@ static void cmpk_handle_interrupt_status(struct
> > net_device *dev, u8 *pmsg)> 
> >  	DMESG("<---- cmpk_handle_interrupt_status()\n");
> >  
> >  }
> > 
> > -/*--------------------------------------------------------------------
> > --------- - * Function:    cmpk_handle_query_config_rx()
> > - *
> > - * Overview:    The function is responsible for extract the message
> > from - *		firmware. It will contain dedicated info in
> > - *		ws-06-0063-rtl8190-command-packet-specification. 
Please
> > - *		refer to chapter "Beacon State Element".
> > - *
> > - * Input:       u8    *pmsg	-	Message Pointer of the 
command packet.
> > - *
> > - * Output:      NONE
> > - *
> > - * Return:      NONE
> > - *
> > - * Revised History:
> > - *  When		Who	Remark
> > - *  05/12/2008		amy	Create Version 0 porting from 
windows code.
> > - *
> > -
> > *---------------------------------------------------------------------
> > ------ - */
> > -static void cmpk_handle_query_config_rx(struct net_device *dev, u8
> > *pmsg) -{
> > -	struct cmpk_query_cfg	rx_query_cfg;
> > -
> > -	/* 1. Extract TX feedback info from RFD to temp structure 
buffer. */
> > -	/* It seems that FW use big endian(MIPS) and DRV use little 
endian in
> > -	 * windows OS. So we have to read the content byte by byte or
> > transfer
> > -	 * endian type before copy the message copy.
> > -	 */
> > -	rx_query_cfg.cfg_action		= (pmsg[4] & 0x80) >> 7;
> > -	rx_query_cfg.cfg_type		= (pmsg[4] & 0x60) >> 5;
> > -	rx_query_cfg.cfg_size		= (pmsg[4] & 0x18) >> 3;
> > -	rx_query_cfg.cfg_page		= (pmsg[6] & 0x0F) >> 0;
> > -	rx_query_cfg.cfg_offset		= pmsg[7];
> > -	rx_query_cfg.value		= (pmsg[8]  << 24) | 
(pmsg[9]  << 16) |
> > -					  (pmsg[10] <<  8) 
| (pmsg[11] <<  0);
> > -	rx_query_cfg.mask		= (pmsg[12] << 24) | 
(pmsg[13] << 16) |
> > -					  (pmsg[14] <<  8) 
| (pmsg[15] <<  0);
> > -}
> > -
> > 
> >  /*--------------------------------------------------------------------
> >  --------->  
> >   * Function:	cmpk_count_tx_status()
> >   *
> 
> Always test-build your patches as they can not break the build.  You
> obviously did not do that here, why not?
>
I can't see that where the build of rtl8192u is broken. 
The following lines are from the compilation log:

git/kernels/staging> make -j8 drivers/staging/rtl8192u/
 [...]
 CC [M]  drivers/staging/rtl8192u/r819xU_cmdpkt.o
 CC [M]  drivers/staging/rtl8192u/r819xU_cmdpkt.o
 [...]
 LD [M]  drivers/staging/rtl8192u/r8192u_usb.o

No errors are reported.

What am I missing?

Thanks,

Fabio
> 
> thanks,
> 
> greg k-h




