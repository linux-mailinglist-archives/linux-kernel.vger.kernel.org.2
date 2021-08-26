Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535503F86B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbhHZLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242100AbhHZLvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:51:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E23D761058;
        Thu, 26 Aug 2021 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629978616;
        bh=Vvb0F8EMBgDIIWZGx3dcWoVsp4/javT4z7Vxmap1bbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOe3ekE14vM0BHNJDYuRgf8UAhCtVtAcu3rp+XqRt2+6VNUmLdH3T9WwmUulsdg4t
         i1JjIFZwdRbDCTswK113vwCxvzIu5IqASAOAMlv3VwuH67G7FULZ0VTjQC0LhugMMc
         OeaTO4Gqi/yjoAfO9AtivvouFfOjGZJ4dicAOQO4=
Date:   Thu, 26 Aug 2021 13:50:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: renesas-xhci: Prefer firmware loading on unknown
 ROM state
Message-ID: <YSd/9clcNN547vre@kroah.com>
References: <20210819113427.1166-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819113427.1166-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 01:34:27PM +0200, Takashi Iwai wrote:
> The recent attempt to handle an unknown ROM state in the commit
> d143825baf15 ("usb: renesas-xhci: Fix handling of unknown ROM state")
> resulted in a regression and reverted later by the commit 44cf53602f5a
> ("Revert "usb: renesas-xhci: Fix handling of unknown ROM state"").
> The problem of the former fix was that it treated the failure of
> firmware loading as a fatal error.  Since the firmware files aren't
> included in the standard linux-firmware tree, most users don't have
> them, hence they got the non-working system after that.  The revert
> fixed the regression, but also it didn't make the firmware loading
> triggered even on the devices that do need it.  So we need still a fix
> for them.
> 
> This is another attempt to handle the unknown ROM state.  Like the
> previous fix, this also tries to load the firmware when ROM shows
> unknown state.  In this patch, however, the failure of a firmware
> loading (such as a missing firmware file) isn't handled as a fatal
> error any longer when ROM has been already detected, but it falls back
> to the ROM mode like before.  The error is returned only when no ROM
> is detected and the firmware loading failed.
> 
> Along with it, for simplifying the code flow, the detection and the
> check of ROM is factored out from renesas_fw_check_running() and done
> in the caller side, renesas_xhci_check_request_fw().  It avoids the
> redundant ROM checks.
> 
> The patch was tested on Lenovo Thinkpad T14 gen (BIOS 1.34).  Also it
> was confirmed that no regression is seen on another Thinkpad T14
> machine that has worked without the patch, too.
> 
> Fixes: 44cf53602f5a ("Revert "usb: renesas-xhci: Fix handling of unknown ROM state"")
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189207
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/usb/host/xhci-pci-renesas.c | 35 +++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 12 deletions(-)

This does not apply to my usb-linus branch, are you sure it is still
needed in Linus's tree right now?

thanks,

greg k-h
