Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A57E39C675
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFEHEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 03:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhFEHEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 03:04:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B24F611C2;
        Sat,  5 Jun 2021 07:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622876574;
        bh=IWAfrMlMqi9VAZziEACqpe8WptWvLIC5/6zCndodwc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vt5BpkzEGS8Psrr/Yo+GapEzuiJrLJ8y4Ta0gJRJtsWQ/WXifgMDvLPCuw79AC6A4
         ScEAnff4YszigHWx2BVQituq6Qberbss/7sdmFssVWRgwA1GcWkZeNaCAC/neyzz4s
         BoVeB3+FSZwngqJmUWxvf1XfixjD9MCwLDLW6OBY=
Date:   Sat, 5 Jun 2021 09:02:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0
 is disabled
Message-ID: <YLshmr+H4mES+kZX@kroah.com>
References: <20210601084830.260196-1-narmstrong@baylibre.com>
 <YLoHSJIOSRTyF0r1@kroah.com>
 <20210604150742.bssvnhm4gv72uw4h@nitro.local>
 <20210604164601.hrlgkrsghhqtho6m@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210604164601.hrlgkrsghhqtho6m@nitro.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 12:46:01PM -0400, Konstantin Ryabitsev wrote:
> On Fri, Jun 04, 2021 at 11:07:42AM -0400, Konstantin Ryabitsev wrote:
> > > Odd that DKIM didn't work for baylibre-com, but hey, I'll take a real
> > > signature over DKIM anyday!
> > 
> > That lookup happened to grab the thread from linux-amlogic, which is
> > mailman2-managed and is known to break DKIM. I'll try to fix our configuration
> > so that known-DKIM-friendly sources are given priority. This way, when a thread
> > exists on multiple lists, you'll get the one more likely to pass DKIM checks.
> 
> This is now in place -- lore will now prefer results from DKIM-friendly
> sources. E.g. grabbing the same message-id will now return the thread from
> linux-usb (via vger) instead of linux-amlogic (via infradead).
> 
>     $ b4 am -o/tmp 20210601084830.260196-1-narmstrong@baylibre.com
>     Looking up https://lore.kernel.org/r/20210601084830.260196-1-narmstrong%40baylibre.com
>     Grabbing thread from lore.kernel.org/linux-usb/20210601084830.260196-1-narmstrong%40baylibre.com/t.mbox.gz
>     Analyzing 4 messages in the thread
>     Checking attestation on all messages, may take a moment...
>     ---
>       ✓ [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
>         + Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> (✓ DKIM/googlemail.com)
>       ---
>       ✓ Signed: openpgp/narmstrong@baylibre.com
>       ✓ Signed: DKIM/baylibre-com.20150623.gappssmtp.com (From: narmstrong@baylibre.com)
>     ---
>     Total patches: 1
>     ---
>      Link: https://lore.kernel.org/r/20210601084830.260196-1-narmstrong@baylibre.com
>      Base: not found
>            git am /tmp/20210601_narmstrong_usb_dwc3_meson_g12a_fix_usb2_phy_glue_init_when_phy0_is_disabled.mbx

This is great, thanks for changing this on the lore backend, and for all
of this work in the firstplace.

greg k-h
