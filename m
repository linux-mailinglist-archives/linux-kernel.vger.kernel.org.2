Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2623D9497
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhG1Rwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:52:39 -0400
Received: from liame.vimja.email ([185.85.124.156]:51013 "EHLO
        liame.vimja.email" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1Rwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:52:38 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 13:52:37 EDT
Received: from authenticated-user (liame.vimja.email [185.85.124.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by liame.vimja.email (Postfix) with ESMTPSA id 48CB33F307
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 19:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vimja.email; s=mail;
        t=1627494392; bh=q7ZSWMIaeHfrouOjyXxOm8kGC9Ef7xw//sHDmbzy3Zw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=LU/tEGnb/1rDnYxLQ+m/Nrn9YWb0Yh/Pin8TddUfh+8ss2C3pYmBqf6ab9jeyippj
         kGCiUSxouEE8ndAoJZmm5pu99JK7x8KiQiZQg2sGenE32YXHtimlvMA5x4wdIcqlis
         2Z4RmXMTE6RtEdxSMz6+Z+8MI8EMlF36kbDRBMAMTuirkGapZepHm5qhjzfkc6Jd0Z
         TobTG3FKo9VOVnwpSxAutNVsBPELLsuIzK3P3DLcIyifWwmvC3xRxdN9SYi1ivv5i/
         FqaP47PofOlmf9Icn7LebIW6oRzciIj5RXFujIZfFYtbMnhu0LgFlY0fKD5cqBX3jh
         y5WzYIFrs12EA==
Date:   Wed, 28 Jul 2021 19:46:32 +0200
From:   Niklaus vimja Hofer <lkml@vimja.email>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.13 024/800] usb: renesas-xhci: Fix handling of unknown
 ROM state
Message-ID: <YQGX+HdjGCfpUper@pcsm1501.honet.lan>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <20210712060912.995381202@linuxfoundation.org>
 <20210712060916.499546891@linuxfoundation.org>
 <CAFxkdApAJ2i_Bg6Ghd38Tw9Lz5s6FTKP=3-+pSWM-cDT427i2g@mail.gmail.com>
 <YPMUu+kNu0GZeQQ1@kroah.com>
 <YPM0IE8U7oDSVbvd@epycbox.lan>
 <CAFxkdAr7KHgx3etpia8_OdFySP-1HQVW=2LL6Vu=UO4Jh1dW5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFxkdAr7KHgx3etpia8_OdFySP-1HQVW=2LL6Vu=UO4Jh1dW5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2021-07-19 10:28, Justin Forbes wrote:
> On Sat, Jul 17, 2021 at 2:48 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > On Sat, Jul 17, 2021 at 07:34:51PM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Jul 17, 2021 at 08:39:19AM -0500, Justin Forbes wrote:
> > > > On Mon, Jul 12, 2021 at 2:31 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > From: Moritz Fischer <mdf@kernel.org>
> > > > >
> > > > > commit d143825baf15f204dac60acdf95e428182aa3374 upstream.
> > > > >
> > > > > The ROM load sometimes seems to return an unknown status
> > > > > (RENESAS_ROM_STATUS_NO_RESULT) instead of success / fail.
> > > > >
> > > > > If the ROM load indeed failed this leads to failures when trying to
> > > > > communicate with the controller later on.
> > > > >
> > > > > Attempt to load firmware using RAM load in those cases.
> > > > >
> > > > > Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: Mathias Nyman <mathias.nyman@intel.com>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > > Tested-by: Vinod Koul <vkoul@kernel.org>
> > > > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > > Link: https://lore.kernel.org/r/20210615153758.253572-1-mdf@kernel.org
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >
> > > >
> > > > After sending out 5.12.17 for testing, we had a user complain that all
> > > > of their USB devices disappeared with the error:
> > > >
> > > > Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: Direct firmware load
> > > > for renesas_usb_fw.mem failed with error -2
> > > > Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: request_firmware failed: -2
> > > > Jul 15 23:18:53 kernel: xhci_hcd: probe of 0000:04:00.0 failed with error -2
> > > >
> > > > After first assuming that something was missing in the backport to
> > > > 5.12, I had the user try 5.13.2, and then 5.14-rc1. Both of those
> > > > failed in the same way, so it is not working in the current Linus tree
> > > > either.  Reverting this patch fixed the issue.
> > >
> > > Can you send a revert for this so I can get that into Linus's tree and
> > > then all stable releases as well?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Me or Justin? I can do it. This is annoying my system doesn't work
> > without this :-(
> >
> > Back to the drawing board I guess ...
> >
> > Justin, any idea if your customer had the eeprom populated and
> > programmed or not, just as additional datapoint.
> 
> I am not sure, but I did have another user chime in on the bug saying
> the test kernel with the revert fixed their system as well. It was a
> T14s AMD
> Generation_1. The original reporter had a ASUS System Product
> Name/PRIME H370M-PLUS, BIOS 2801 04/13/2021.

This solved the same issue on my T14 AMD Gen 1 (non-s variant). I was
using 5.13.5 where it was not working and I was able to observe the same
error message in `dmesg`. Reverted the patch, recompiled, rebooted and
now it's working just fine.

Sincerely
-- 
Niklaus 'vimja' Hofer
ig@vimja.email
xmpp: vimja@xmpp.honet.ch
