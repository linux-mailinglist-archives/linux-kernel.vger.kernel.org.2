Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A4388666
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhESFHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239033AbhESFHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:07:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B416135B;
        Wed, 19 May 2021 05:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621400775;
        bh=FeabjgYqNybppZqqnzHbLi82CaLWP46ifWGb6yUuS6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owPRJ8NF3nHj+plPrk07gzFM0TqfRSAX/C21sBfQaEsGWKPfAmgq01nAg0+YWc/rZ
         jTHUKzHktSI8QizOIRUM0SI/0g42/d0kjkZm82PbkIVaRJhTEJdR3rCWMKUpJd6egv
         Mfkx5JZhGZG+rlzToHPJsE/j+hv1FgEFb44vtdtE=
Date:   Wed, 19 May 2021 07:06:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v10 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <YKScw3zcnTV5AAA1@kroah.com>
References: <20210511225223.550762-1-mka@chromium.org>
 <20210511155152.v10.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YKPz7a68duMyXU5x@google.com>
 <20210518194511.GA1137841@rowland.harvard.edu>
 <YKQ0XxhIWaN37HMr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKQ0XxhIWaN37HMr@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 02:40:47PM -0700, Matthias Kaehlcke wrote:
> On Tue, May 18, 2021 at 03:45:11PM -0400, Alan Stern wrote:
> > On Tue, May 18, 2021 at 10:05:49AM -0700, Matthias Kaehlcke wrote:
> > > Hi Alan,
> > > 
> > > You seemed to have a generally favorable view of this driver,
> > > but I haven't heard from you in a while :)
> > > 
> > > On v4 expressed a series of suggestions and concerns, which
> > > should be addressed in this version:
> > > 
> > > https://lore.kernel.org/patchwork/patch/1313000/
> > > https://lore.kernel.org/patchwork/patch/1313001/
> > > 
> > > Rob acked the DT binding and the of_platform change. Please let me
> > > know if the USB part needs any further changes or if you think this
> > > series is ready to land.
> > 
> > Those were long and complicated threads, and a lot of the material has
> > gone out of my brain since last October.  :-(
> > 
> > Still, at the time when this was first posted I don't remember there
> > being any big outstanding issues regarding the USB part of the
> > implementation.  It seemed to be pretty much all in order.
> > 
> > You can add:
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > to this patch.  Greg KH may have some thoughts of his own...
> 
> Thanks!
> 
> Could you also have a look at "[4/5] usb: host: xhci-plat:
> Create platform device for onboard hubs in probe()"
> (https://lore.kernel.org/patchwork/patch/1425453/)? It's a
> relatively short patch that creates the platform device for
> the driver from xhci-plat as you suggested in the v4
> discussion.
> 
> Greg, are there any more concerns from your side?

Yes, I think there are, but like Alan said, it's been a long time since
I've looked at this.  I'll review it soon when I get a chance...

greg k-h
