Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E49342DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhCTP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:28:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41481 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229769AbhCTP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:28:08 -0400
Received: (qmail 608526 invoked by uid 1000); 20 Mar 2021 11:28:07 -0400
Date:   Sat, 20 Mar 2021 11:28:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] usb: host: ehci-tegra: Select USB_GADGET Kconfig
 option
Message-ID: <20210320152807.GA606911@rowland.harvard.edu>
References: <20210320151915.7566-1-digetx@gmail.com>
 <20210320151915.7566-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320151915.7566-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 06:19:15PM +0300, Dmitry Osipenko wrote:
> Select USB_GADGET Kconfig option in order to fix build failure which
> happens because ChipIdea driver has a build dependency on both USB_GADGET
> and USB_EHCI_HCD, while USB_EHCI_TEGRA force-selects the ChipIdea driver
> without taking into account the tristate USB_GADGET dependency. It's not
> possible to do anything about the cyclic dependency of the Kconfig
> options, but USB_EHCI_TEGRA is now a deprecated option that isn't used
> by defconfigs and USB_GADGET is wanted on Tegra by default, hence it's
> okay to have a bit clunky workaround for it.
> 
> Fixes: c3590c7656fb ("usb: host: ehci-tegra: Remove the driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index b94f2a070c05..df9428f1dc5e 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -272,6 +272,7 @@ config USB_EHCI_TEGRA
>  	select USB_CHIPIDEA
>  	select USB_CHIPIDEA_HOST
>  	select USB_CHIPIDEA_TEGRA
> +	select USB_GADGET
>  	help
>  	  This option is deprecated now and the driver was removed, use
>  	  USB_CHIPIDEA_TEGRA instead.
> -- 
> 2.30.2
> 
