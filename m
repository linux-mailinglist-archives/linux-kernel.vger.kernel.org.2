Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADC3A1D63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFITBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFITBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:01:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFFFF61364;
        Wed,  9 Jun 2021 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623265160;
        bh=nXoyJTJxIU3jLPEO7r7vkSzXDt/P6SnO6auwIHMlV/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5vtyGuXmMyksM3Z7Ybx3hLNe6SGBJvUCtgsPr7YTMlCz1h51l2fjMxlmix04G5Jz
         4Z2liKHYdyYSlJehNHJA/hBC3qac9U9znTMz6xobrAoKKGGzi1Kgb2jeL3CIv5wY4G
         dqmwEDO5mrmCfGJ+EJEznfWjXFcR9Auxqk3vIQII=
Date:   Wed, 9 Jun 2021 20:59:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Peter Chen <peter.chen@kernel.org>
Subject: Re: [PATCH] USB: dwc3: remove debugfs root dentry storage
Message-ID: <YMEPhay2knIEc3sZ@kroah.com>
References: <20210609093924.3293230-1-gregkh@linuxfoundation.org>
 <20210609184715.GA28957@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609184715.GA28957@jackp-linux.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:47:15AM -0700, Jack Pham wrote:
> On Wed, Jun 09, 2021 at 11:39:24AM +0200, Greg Kroah-Hartman wrote:
> > There is no need to keep around the debugfs "root" directory for the
> > dwc3 device.  Instead, look it up anytime we need to find it.  This will
> > help when callers get out-of-order and we had the potential to have a
> > "stale" pointer around for the root dentry, as has happened in the past.
> > 
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Jack Pham <jackp@codeaurora.org>
> > Cc: Peter Chen <peter.chen@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/dwc3/core.h    | 2 --
> >  drivers/usb/dwc3/debugfs.c | 8 ++++----
> >  drivers/usb/dwc3/gadget.c  | 4 +++-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index c5d5760cdf53..dccdf13b5f9e 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -1013,7 +1013,6 @@ struct dwc3_scratchpad_array {
> >   * @link_state: link state
> >   * @speed: device speed (super, high, full, low)
> >   * @hwparams: copy of hwparams registers
> > - * @root: debugfs root folder pointer
> >   * @regset: debugfs pointer to regdump file
> >   * @dbg_lsp_select: current debug lsp mux register selection
> >   * @test_mode: true when we're entering a USB test mode
> > @@ -1222,7 +1221,6 @@ struct dwc3 {
> >  	u8			num_eps;
> >  
> >  	struct dwc3_hwparams	hwparams;
> > -	struct dentry		*root;
> >  	struct debugfs_regset32	*regset;
> >  
> >  	u32			dbg_lsp_select;
> > diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
> > index 5dbbe53269d3..f2b7675c7f62 100644
> > --- a/drivers/usb/dwc3/debugfs.c
> > +++ b/drivers/usb/dwc3/debugfs.c
> > @@ -889,8 +889,10 @@ static void dwc3_debugfs_create_endpoint_files(struct dwc3_ep *dep,
> >  void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
> >  {
> >  	struct dentry		*dir;
> > +	struct dentry		*root;
> >  
> > -	dir = debugfs_create_dir(dep->name, dep->dwc->root);
> > +	root = debugfs_lookup(dev_name(dep->dwc->dev), usb_debug_root);
> > +	dir = debugfs_create_dir(dep->name, root);
> >  	dwc3_debugfs_create_endpoint_files(dep, dir);
> >  }
> >  
> > @@ -909,8 +911,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
> >  	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
> >  
> >  	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
> > -	dwc->root = root;
> > -
> >  	debugfs_create_regset32("regdump", 0444, root, dwc->regset);
> >  	debugfs_create_file("lsp_dump", 0644, root, dwc, &dwc3_lsp_fops);
> >  
> > @@ -929,6 +929,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
> >  
> >  void dwc3_debugfs_exit(struct dwc3 *dwc)
> >  {
> > -	debugfs_remove_recursive(dwc->root);
> > +	debugfs_remove(debugfs_lookup(dev_name(dwc->dev), usb_debug_root));
> >  	kfree(dwc->regset);
> >  }
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 7cc99b6d0bfe..026a2ad0fc80 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2799,7 +2799,9 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
> >  			list_del(&dep->endpoint.ep_list);
> >  		}
> >  
> > -		debugfs_remove_recursive(debugfs_lookup(dep->name, dwc->root));
> > +		debugfs_remove_recursive(debugfs_lookup(dep->name,
> > +				debugfs_lookup(dev_name(dep->dwc->dev),
> > +					       usb_debug_root)));
> 
> Nested calls to debugfs_lookup() :). But it does work, and similarly
> avoids the out-of-order debugfs removal issue as well even without
> Peter's fix.

Yeah, it's funny, but it's safer than trying to store a pointer around :)

> Tested-by: Jack Pham <jackp@codeaurora.org>

Many thanks for testing.

greg k-h
