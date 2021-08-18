Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2F3F0215
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhHRK6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235120AbhHRK6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:58:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1631761029;
        Wed, 18 Aug 2021 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629284250;
        bh=IP9QZ9R4vDScwCucpKYL7KBQIzj0wzHNmIYig9vv5+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ly3thsFBZKmxkkxQ1Zq6Zom/3c1Ek9+Mh6NMdv1sbehEQl6YCv2n8ipVFHuQwWXkt
         oLrrWjt5QIBqfMNdbzMzL35Sn6cIomKi4lTnm7ygctQSRoUiRDntlwGueT5k/Kk16t
         wBuZQrKfOANAR/lZxIha8pEiztnroRetNzjWEfdc=
Date:   Wed, 18 Aug 2021 12:57:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] ARM: tegra: paz00: Handle device properties
 with software node API
Message-ID: <YRznmKAnIoM5/Is/@kroah.com>
References: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
 <20210817102449.39994-2-heikki.krogerus@linux.intel.com>
 <YRvIFJKmFlB6ntI5@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRvIFJKmFlB6ntI5@orome.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 04:30:44PM +0200, Thierry Reding wrote:
> On Tue, Aug 17, 2021 at 01:24:48PM +0300, Heikki Krogerus wrote:
> > The old device property API is going to be removed.
> > Replacing the device_add_properties() call with the software
> > node API equivalent, device_create_managed_software_node().
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  arch/arm/mach-tegra/board-paz00.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> > index b5c990a7a5af5..18d37f90cdfe3 100644
> > --- a/arch/arm/mach-tegra/board-paz00.c
> > +++ b/arch/arm/mach-tegra/board-paz00.c
> > @@ -36,7 +36,7 @@ static struct gpiod_lookup_table wifi_gpio_lookup = {
> >  
> >  void __init tegra_paz00_wifikill_init(void)
> >  {
> > -	platform_device_add_properties(&wifi_rfkill_device, wifi_rfkill_prop);
> > +	device_create_managed_software_node(&wifi_rfkill_device.dev, wifi_rfkill_prop, NULL);
> >  	gpiod_add_lookup_table(&wifi_gpio_lookup);
> >  	platform_device_register(&wifi_rfkill_device);
> >  }
> 
> Seems alright. Looks to be doing mostly the same thing as the original
> platform_device_add_properties() was doing, except for the node now
> being managed, which is irrelevant in this context.
> 
> I'm fine with Greg picking this up. I'm not aware of any other changes
> to this file that might cause a conflict for v5.15.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

I'll pick it up, thanks!

greg k-h
