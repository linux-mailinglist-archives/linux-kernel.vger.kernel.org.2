Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C93F8748
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbhHZMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234578AbhHZMWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:22:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46AAF61052;
        Thu, 26 Aug 2021 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629980510;
        bh=qIn9xBJAeipC6fMIJLCU3qbBWel3Q7ad0qQiDHzzZz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfZv0LsYxSlFKz+UtbBGjDJ8wr+AZy0TVhynGyBABw/43BpLvz8t62QI7fP0s7i4s
         9xz02aoVjAWKHRQBcjm0WrWUR6LCd+HGl2J77DeejSmipbaX2Mra5ZE5GSR2wiWKqd
         62YHOj4d4QNGhrE0T11UnmJGgkp1D5ocGz/60Eow=
Date:   Thu, 26 Aug 2021 14:21:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: renesas-xhci: Prefer firmware loading on unknown
 ROM state
Message-ID: <YSeHWusVwn9XMHMg@kroah.com>
References: <20210819113427.1166-1-tiwai@suse.de>
 <YSd/9clcNN547vre@kroah.com>
 <s5h8s0owhbp.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8s0owhbp.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 01:55:54PM +0200, Takashi Iwai wrote:
> On Thu, 26 Aug 2021 13:50:13 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Thu, Aug 19, 2021 at 01:34:27PM +0200, Takashi Iwai wrote:
> > > The recent attempt to handle an unknown ROM state in the commit
> > > d143825baf15 ("usb: renesas-xhci: Fix handling of unknown ROM state")
> > > resulted in a regression and reverted later by the commit 44cf53602f5a
> > > ("Revert "usb: renesas-xhci: Fix handling of unknown ROM state"").
> > > The problem of the former fix was that it treated the failure of
> > > firmware loading as a fatal error.  Since the firmware files aren't
> > > included in the standard linux-firmware tree, most users don't have
> > > them, hence they got the non-working system after that.  The revert
> > > fixed the regression, but also it didn't make the firmware loading
> > > triggered even on the devices that do need it.  So we need still a fix
> > > for them.
> > > 
> > > This is another attempt to handle the unknown ROM state.  Like the
> > > previous fix, this also tries to load the firmware when ROM shows
> > > unknown state.  In this patch, however, the failure of a firmware
> > > loading (such as a missing firmware file) isn't handled as a fatal
> > > error any longer when ROM has been already detected, but it falls back
> > > to the ROM mode like before.  The error is returned only when no ROM
> > > is detected and the firmware loading failed.
> > > 
> > > Along with it, for simplifying the code flow, the detection and the
> > > check of ROM is factored out from renesas_fw_check_running() and done
> > > in the caller side, renesas_xhci_check_request_fw().  It avoids the
> > > redundant ROM checks.
> > > 
> > > The patch was tested on Lenovo Thinkpad T14 gen (BIOS 1.34).  Also it
> > > was confirmed that no regression is seen on another Thinkpad T14
> > > machine that has worked without the patch, too.
> > > 
> > > Fixes: 44cf53602f5a ("Revert "usb: renesas-xhci: Fix handling of unknown ROM state"")
> > > BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189207
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/usb/host/xhci-pci-renesas.c | 35 +++++++++++++++++++----------
> > >  1 file changed, 23 insertions(+), 12 deletions(-)
> > 
> > This does not apply to my usb-linus branch, are you sure it is still
> > needed in Linus's tree right now?
> 
> I guess we can postpone for 5.15.  The patch was written for the code
> on linux-next, and I see there have been a few code clean up there.
> 
> But the patch itself could be applied to Linus tree with a slight
> fuzz, so the stable backport should be fine.
> 
> If it's still not cleanly applicable, let me know.  I'll refresh the
> patch for whatever preferred branch.

It was not cleanly applicable, 'git am' did not like it against my
usb-linus branch (which is 5.14-rc7 + a few other USB patches not in
this driver).

So if you want to rebase it against that, I will be glad to take it for
5.14-final to resolve this issue.

thanks,

greg k-h
