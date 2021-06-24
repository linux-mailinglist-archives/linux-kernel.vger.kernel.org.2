Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58103B26EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFXFny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhFXFnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 615A2613E7;
        Thu, 24 Jun 2021 05:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624513294;
        bh=zwAa1oXvtNsRyT1TQaWBA4D9GsM7gx8Hoa3hx2a/zOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKEuNgpfLnosXquFxao5Ko9V7ZiB578/IVUed7uSE/JUglaFf9fuTiT8wB3hxtBdG
         3+k09I8x13S2WP9KQp8lqf0/icasPjUz/oKlSoWG0Rl4kimvneQDV4E9Df9u0mZcTU
         /Jl+F56OXGBRLsJXLVLerNGISJwVzdpGVdT2YaDo=
Date:   Thu, 24 Jun 2021 07:41:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, rafael.j.wysocki@intel.com
Subject: Re: [PATCH 1/7] driver core: Add a way to get to bus devices kset
Message-ID: <YNQbCtP7/2rF9Pnl@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624497729-158864-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 06:22:03PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add an accessor function to get to the bus devices kset associated with
> a struct bus_type.
> 
> The user of this is the following perf changes, which will need to get
> to the kobj of the 'devices' directory of a certain bus.

What "following perf changes"?

Nothing should be messing with the kobject of a bus, where are those
patches?

> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: gregkh@linuxfoundation.org
> Cc: rafael.j.wysocki@intel.com
> ---
>  drivers/base/bus.c         | 6 ++++++
>  include/linux/device/bus.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 36d0c65..3d621a8 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -899,6 +899,12 @@ struct kset *bus_get_kset(struct bus_type *bus)
>  }
>  EXPORT_SYMBOL_GPL(bus_get_kset);
>  
> +struct kset *bus_get_devices_kset(struct bus_type *bus)
> +{
> +	return bus->p->devices_kset;
> +}
> +EXPORT_SYMBOL_GPL(bus_get_devices_kset);

No, sorry, this feels really wrong, why does anyone care about the bus
kset?

thanks,

greg k-h
