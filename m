Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D113C9AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhGOI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:59:14 -0400
Received: from audible.transient.net ([24.143.126.66]:45354 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S238012AbhGOI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:59:13 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2021 04:59:12 EDT
Received: (qmail 3866 invoked from network); 15 Jul 2021 08:49:39 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 15 Jul 2021 08:49:39 -0000
Received: (nullmailer pid 2833 invoked by uid 1000);
        Thu, 15 Jul 2021 08:49:38 -0000
Date:   Thu, 15 Jul 2021 08:49:38 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH 5.10 187/593] ACPI: resources: Add checks for ACPI IRQ
 override
Message-ID: <YO/2oiphnFdacyIN@audible.transient.net>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>
References: <20210712060903.591188609@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712060903.591188609@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> From: Hui Wang <hui.wang@canonical.com>
> 
> [ Upstream commit 0ec4e55e9f571f08970ed115ec0addc691eda613 ]
> 
> The laptop keyboard doesn't work on many MEDION notebooks, but the
> keyboard works well under Windows and Unix.

This patch makes my EPIA VIA Esther system stop booting correctly.
Reverting it returns things to normal operation.  The symptoms are
pretty strange.  When the kernel hands off to init I get none of the
usual output from userspace, but I still get the occasional message
from the kernel as modules load.  Despite some processes continuing on
in the background, I'm never able to ssh into the host, and it never
displays a getty on serial console like it should.  Sending a break
and a command key over serial doesn't work like it should either.
I've found I was able to somewhat get a little bit of IO if I plugged
in a keyboard or unplugged it, like just jiggling the handle of the
usb hot plug routines was enough to get my system to reboot so I only
had to resort to hard resets a few times.  At any rate, maybe this
patch wasn't really ready for stable.

> Through debugging, we found this log in the dmesg:
> 
>  ACPI: IRQ 1 override to edge, high
>  pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
> 
>  And we checked the IRQ definition in the DSDT, it is:
> 
>     IRQ (Level, ActiveLow, Exclusive, )
>         {1}
> 
> So the BIOS defines the keyboard IRQ to Level_Low, but the Linux
> kernel override it to Edge_High. If the Linux kernel is modified
> to skip the IRQ override, the keyboard will work normally.
> 
> From the existing comment in acpi_dev_get_irqresource(), the override
> function only needs to be called when IRQ() or IRQNoFlags() is used
> to populate the resource descriptor, and according to Section 6.4.2.1
> of ACPI 6.4 [1], if IRQ() is empty or IRQNoFlags() is used, the IRQ
> is High true, edge sensitive and non-shareable. ACPICA also assumes
> that to be the case (see acpi_rs_set_irq[] in rsirq.c).
> 
> In accordance with the above, check 3 additional conditions
> (EdgeSensitive, ActiveHigh and Exclusive) when deciding whether or
> not to treat an ACPI_RESOURCE_TYPE_IRQ resource as "legacy", in which
> case the IRQ override is applicable to it.
> 
> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#irq-descriptor # [1]
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> BugLink: http://bugs.launchpad.net/bugs/1909814
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> [ rjw: Subject rewrite, changelog edits ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/acpi/resource.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index f2f5f1dc7c61..9d82440a1d75 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -430,6 +430,13 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>  	}
>  }
>  
> +static bool irq_is_legacy(struct acpi_resource_irq *irq)
> +{
> +	return irq->triggering == ACPI_EDGE_SENSITIVE &&
> +		irq->polarity == ACPI_ACTIVE_HIGH &&
> +		irq->shareable == ACPI_EXCLUSIVE;
> +}
> +
>  /**
>   * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
>   * @ares: Input ACPI resource object.
> @@ -468,7 +475,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  		}
>  		acpi_dev_get_irqresource(res, irq->interrupts[index],
>  					 irq->triggering, irq->polarity,
> -					 irq->shareable, true);
> +					 irq->shareable, irq_is_legacy(irq));
>  		break;
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>  		ext_irq = &ares->data.extended_irq;
> -- 
> 2.30.2
> 

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
