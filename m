Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1D35C43F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbhDLKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhDLKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:43:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE16C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:42:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w23so14465952edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jL6kS6yKwLQwJYSHVW/F2daax6+6XOr6VTQzmb6EBo=;
        b=grQwB2SoiIeDwtYG2crFnvYSGLpshKob/rVzA9X42caOcKViYGNiv/RZqYiTcEMWRj
         XHE7Qx9ehqe/M3XyJSS4ZsNt5Vp7kxFhUlfScBvgAUQA4vZL6UwfVxNZwQLssswxDIwy
         3/yZhymlZAFmuflzJ3YisVUe2FwLy0QO9NvPBR+iMLe255CV3olS8XxLXMnLKbMPPdnS
         /rxWIaj8MTdS3nBhMR7xUMMdEdMqVW/nIVLAXF7B3eMyeG//ZebPH8ssiObXzfMqeKsZ
         h5wSUTkFm6EbCP9/EAMuwku1rS9/iiEgug9oh9Q9+H21tHD26pN3y4VOOnI5W6y+Xyem
         /qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jL6kS6yKwLQwJYSHVW/F2daax6+6XOr6VTQzmb6EBo=;
        b=kHebMcUg2t7zmyWko0n+qXYiIVaBG7jconGI+EWZxQ/ssyKm29couDxEFDLGLAEx1q
         nzUR4V0AI49Wv2bzt/u/VW0MUc34Pr08ocNggzxOFQL5GV/Oa6tMkplJ7Ky4TADlCps1
         rLG3jlM+90WLjMw+qghrbyInU8nXeOsQeL+QqqtHHMZta7SN7HZgQ2uhOxHwNVDscqF5
         1EurDB173J67nYAR8udMJVIO9NcOAILlPO7YsMgvsiBVg9ky55PZgBBJIMOdNXljLj46
         MQQN1EV56Of9qgiMyKKYKidgsXTfJWiz81Cnyzrx+lPdpO5KeN+WGXffNZdX3yhgrkL4
         QrfA==
X-Gm-Message-State: AOAM530qy6yrwhPa1Z7jlRgzX8uj6WvMS+UNYI9oTy7XhiddoNFE3uxP
        SgQq2qKgNjUoe40PFeaH9dE=
X-Google-Smtp-Source: ABdhPJxkvvnNv7rb7A72mcRagj7QOZnACB/JRprcWLnJ0QfR2j22urztnyJ+aZf+tnDxoTwToMAZfg==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr28743255edw.303.1618224171909;
        Mon, 12 Apr 2021 03:42:51 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id mp36sm5330293ejc.48.2021.04.12.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 03:42:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove function
Date:   Mon, 12 Apr 2021 12:42:50 +0200
Message-ID: <5043782.cgFr61IFxu@linux.local>
In-Reply-To: <YHQfS3rb81ElJ6uQ@kroah.com>
References: <20210411184813.22836-1-fmdefrancesco@gmail.com> <4388012.RVq5xMhMDq@linux.local> <YHQfS3rb81ElJ6uQ@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 12, 2021 12:22:03 PM CEST Greg KH wrote:
> On Mon, Apr 12, 2021 at 12:12:34PM +0200, Fabio M. De Francesco wrote:
> > On Monday, April 12, 2021 11:42:51 AM CEST Greg KH wrote:
> > > On Sun, Apr 11, 2021 at 08:48:13PM +0200, Fabio M. De Francesco 
wrote:
> > > > Remove cmpk_handle_query_config_rx() because it just initializes a
> > > > local
> > > > variable and then returns "void".
> > > > 
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/staging/rtl8192u/r819xU_cmdpkt.c | 40
> > > >  ------------------------
> > > >  1 file changed, 40 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > > > b/drivers/staging/rtl8192u/r819xU_cmdpkt.c index
> > > > 4cece40a92f6..d5a54c2d3086 100644
> > > > --- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > > > +++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > > > @@ -249,46 +249,6 @@ static void
> > > > cmpk_handle_interrupt_status(struct
> > > > net_device *dev, u8 *pmsg)>
> > > > 
> > > >  	DMESG("<---- cmpk_handle_interrupt_status()\n");
> > > >  
> > > >  }
> > > > 
> > > > -/*----------------------------------------------------------------
> > > > ----
> > > > --------- - * Function:    cmpk_handle_query_config_rx()
> > > > - *
> > > > - * Overview:    The function is responsible for extract the
> > > > message
> > > > from - *		firmware. It will contain dedicated 
info in
> > > > - *		ws-06-0063-rtl8190-command-packet-specification.
> > 
> > Please
> > 
> > > > - *		refer to chapter "Beacon State Element".
> > > > - *
> > > > - * Input:       u8    *pmsg	-	Message Pointer of the
> > 
> > command packet.
> > 
> > > > - *
> > > > - * Output:      NONE
> > > > - *
> > > > - * Return:      NONE
> > > > - *
> > > > - * Revised History:
> > > > - *  When		Who	Remark
> > > > - *  05/12/2008		amy	Create Version 0 porting 
from
> > 
> > windows code.
> > 
> > > > - *
> > > > -
> > > > *------------------------------------------------------------------
> > > > ---
> > > > ------ - */
> > > > -static void cmpk_handle_query_config_rx(struct net_device *dev, u8
> > > > *pmsg) -{
> > > > -	struct cmpk_query_cfg	rx_query_cfg;
> > > > -
> > > > -	/* 1. Extract TX feedback info from RFD to temp structure
> > 
> > buffer. */
> > 
> > > > -	/* It seems that FW use big endian(MIPS) and DRV use little
> > 
> > endian in
> > 
> > > > -	 * windows OS. So we have to read the content byte by byte or
> > > > transfer
> > > > -	 * endian type before copy the message copy.
> > > > -	 */
> > > > -	rx_query_cfg.cfg_action		= (pmsg[4] & 0x80) >> 7;
> > > > -	rx_query_cfg.cfg_type		= (pmsg[4] & 0x60) >> 5;
> > > > -	rx_query_cfg.cfg_size		= (pmsg[4] & 0x18) >> 3;
> > > > -	rx_query_cfg.cfg_page		= (pmsg[6] & 0x0F) >> 0;
> > > > -	rx_query_cfg.cfg_offset		= pmsg[7];
> > > > -	rx_query_cfg.value		= (pmsg[8]  << 24) |
> > 
> > (pmsg[9]  << 16) |
> > 
> > > > -					  (pmsg[10] <<  8)
> > | 
> > | (pmsg[11] <<  0);
> > | 
> > > > -	rx_query_cfg.mask		= (pmsg[12] << 24) |
> > 
> > (pmsg[13] << 16) |
> > 
> > > > -					  (pmsg[14] <<  8)
> > | 
> > | (pmsg[15] <<  0);
> > | 
> > > > -}
> > > > -
> > > > 
> > > >  /*----------------------------------------------------------------
> > > >  ----
> > > >  --------->
> > > >  
> > > >   * Function:	cmpk_count_tx_status()
> > > >   *
> > > 
> > > Always test-build your patches as they can not break the build.  You
> > > obviously did not do that here, why not?
> > 
> > I can't see that where the build of rtl8192u is broken.
> > The following lines are from the compilation log:
> > 
> > git/kernels/staging> make -j8 drivers/staging/rtl8192u/
> > 
> >  [...]
> >  CC [M]  drivers/staging/rtl8192u/r819xU_cmdpkt.o
> >  CC [M]  drivers/staging/rtl8192u/r819xU_cmdpkt.o
> >  [...]
> >  LD [M]  drivers/staging/rtl8192u/r8192u_usb.o
> > 
> > No errors are reported.
> > 
> > What am I missing?
> 
> The function is used elsewhere in this file :(
>
You're right, it is used in a "switch" statement later in the file.
Now I've also understood why it built with no errors:
it built because, notwithstanding that modification, for some reason I have 
still the original version of the file.
I don't know why, maybe I've made some stupid error with Git...

Thanks,

Fabio



