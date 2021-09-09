Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AE8404523
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350822AbhIIFqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhIIFqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:46:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFCDC061575;
        Wed,  8 Sep 2021 22:45:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s11so676297pgr.11;
        Wed, 08 Sep 2021 22:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZHxlrTXJ7AAihhldB7v8/BTxeSZA6cYlmAkaX0K7CQ=;
        b=aLvkreXMs//4FiVaA37L0GNJTT2okctoDfreSDyhmXI/sv1a7j6h+BUGhsM8GlhwAf
         oYGUhrK3WpHvgqD7pNsFh6j+1GCEdIcWSIWcPdbnOAS+LBz9ZhYh/Zv6Oe+FG36db6ij
         Wpb5dGCgWiRuMWMwSa8JB9FhH+I24AqZ/D60skblBk/jNFS9rl4ocQRjTDRV7CkwfACn
         e1vSzoqVe2csBrvv7uNYtV4PPLfIhhpzyAMezjcpUiEZAM/3g1HV5xX+miCxqCXoKDHe
         L+26CsOmxhORRvvZ4RB3n5X/Jzmlo5SUK296tq/JBzpwH46T6XhFzI2/C0iMKsTSBkq2
         zv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZHxlrTXJ7AAihhldB7v8/BTxeSZA6cYlmAkaX0K7CQ=;
        b=CZxraNTE4+pSzNJHtkUeP/IvwBVv3dSFTLOCifaHqm+nMYo42QBhu2L/E1K3hIMQ2C
         gZXi9odE/rDE80IurOvkt3st/A0p08TuoIh3Pl3uP15al3qthKiM8R7RBMtjXOrFoDgr
         +av/82zXKsvzLuGTcEi7tSX73WVm9BSZbn3klBLqlkhIOyRETqmW83ugjO5X3ZqkHUjn
         QlaMo9ZRXUNdZyb+TGR8CJO6UuUw3Jq1s9Ldd09r9MthyFPP5pwWXz4NU9X6uiDtdFUs
         00qQ45sbrBwIIxC7UOfqMip5eNccaE+Ek5yacf3NNZ8dvUaeETIIipfJVzjv6ox53+SM
         EEGQ==
X-Gm-Message-State: AOAM532mdAZEl0BuQEdBhKhXtAPB4E+4czyHpKHN85DUFkkmJr1bMkh8
        GHZdeKSdmyx4+QzpkxbN0tk=
X-Google-Smtp-Source: ABdhPJzA22R5wMZ/yuio7cI43twxCiaEXM03QI/s4lQdfxfS5lljkjSAvgbABMwt2Yv36N3xiYeXAw==
X-Received: by 2002:a63:4303:: with SMTP id q3mr1087900pga.375.1631166339993;
        Wed, 08 Sep 2021 22:45:39 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-92-48-112.hsd1.ca.comcast.net. [73.92.48.112])
        by smtp.gmail.com with ESMTPSA id e19sm712321pfi.139.2021.09.08.22.45.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Sep 2021 22:45:39 -0700 (PDT)
Date:   Wed, 8 Sep 2021 22:45:32 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     neal_liu <neal_liu@aspeedtech.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2] usb: ehci: handshake CMD_RUN instead of STS_HALT
Message-ID: <20210909054531.GA10391@taoren-ubuntu-R90MNF91>
References: <20210901035041.10810-1-neal_liu@aspeedtech.com>
 <YS8YuX9laah5d/NY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS8YuX9laah5d/NY@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neal,

On Wed, Sep 01, 2021 at 08:07:53AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 01, 2021 at 11:50:41AM +0800, neal_liu wrote:
> > Retitle.
> > 
> > For Aspeed, HCHalted status depends on not only Run/Stop but also
> > ASS/PSS status.
> > Handshake CMD_RUN on startup instead.
> > 
> > Signed-off-by: neal_liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/host/ehci-hcd.c      | 11 ++++++++++-
> >  drivers/usb/host/ehci-platform.c |  6 ++++++
> >  drivers/usb/host/ehci.h          |  1 +
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > index 10b0365f3439..01c022e46aa2 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -634,7 +634,16 @@ static int ehci_run (struct usb_hcd *hcd)
> >  	/* Wait until HC become operational */
> >  	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes */
> >  	msleep(5);
> > -	rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT, 0, 100 * 1000);
> > +
> > +	/* For Aspeed, STS_HALT also depends on ASS/PSS status.
> > +	 * Skip this check on startup.
> > +	 */
> > +	if (ehci->is_aspeed)
> > +		rc = ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
> > +				    1, 100 * 1000);
> > +	else
> > +		rc = ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
> > +				    0, 100 * 1000);
> >  
> >  	up_write(&ehci_cf_port_reset_rwsem);
> >  
> > diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> > index c70f2d0b4aaf..c3dc906274d9 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -297,6 +297,12 @@ static int ehci_platform_probe(struct platform_device *dev)
> >  					  "has-transaction-translator"))
> >  			hcd->has_tt = 1;
> >  
> > +		if (of_device_is_compatible(dev->dev.of_node,
> > +					    "aspeed,ast2500-ehci") ||
> > +		    of_device_is_compatible(dev->dev.of_node,
> > +					    "aspeed,ast2600-ehci"))
> > +			ehci->is_aspeed = 1;
> > +
> >  		if (soc_device_match(quirk_poll_match))
> >  			priv->quirk_poll = true;
> >  
> > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> > index 80bb823aa9fe..fdd073cc053b 100644
> > --- a/drivers/usb/host/ehci.h
> > +++ b/drivers/usb/host/ehci.h
> > @@ -219,6 +219,7 @@ struct ehci_hcd {			/* one per controller */
> >  	unsigned		need_oc_pp_cycle:1; /* MPC834X port power */
> >  	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
> >  	unsigned		spurious_oc:1;
> > +	unsigned		is_aspeed:1;
> >  
> >  	/* required for usb32 quirk */
> >  	#define OHCI_CTRL_HCFS          (3 << 6)
> > -- 
> > 2.17.1
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - It looks like you did not use your "real" name for the patch on either
>   the Signed-off-by: line, or the From: line (both of which have to
>   match).  Please read the kernel file, Documentation/SubmittingPatches
>   for how to do this correctly.
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

Thank you Neal for the patch. I tried the fix on my CMM (AST2500) and
Fuji (AST2600) BMC and it works on both platforms.

Can you please address Greg's comments above and send out a new version?
BTW, please don't forget to include Alan's Acked-by in the new version.

Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Tao Ren <rentao.bupt@gmail.com>


Cheers,

Tao
