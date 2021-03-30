Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB334ECE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhC3PuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:50:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:64711 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhC3PuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:50:07 -0400
IronPort-SDR: YfAp4jE1+IsYs29iGbHnZKqjMCwK9qyVlPUHLFaHWT4CHRjB1vEf/Az31EJrbPry/WxG43J6bg
 1M+SGtHQtW/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="189553510"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="189553510"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 08:50:06 -0700
IronPort-SDR: 41/9bI8WUCMUw1VAww60kVAXSnK+BEjNveSFmjwH6T3dAKa+HUb7txo1YTLEHj3EZNztQFi7U0
 /0jbNrBIBmEA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="445200586"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 08:50:00 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 30 Mar 2021 18:49:57 +0300
Date:   Tue, 30 Mar 2021 18:49:57 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Angela Czubak <acz@semihalf.com>, akpm@linux-foundation.org,
        john.garry@huawei.com, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, dtor@chromium.org,
        linux-acpi <linux-acpi@intel.com>, rafael@kernel.org
Subject: Re: [PATCH] resource: Prevent irqresource_disabled() from erasing
 flags
Message-ID: <20210330154957.GU2542@lahna.fi.intel.com>
References: <20210329195238.9455-1-acz@semihalf.com>
 <1c086b9e-d5c2-6e8d-1d81-748935b0dd64@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c086b9e-d5c2-6e8d-1d81-748935b0dd64@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 30, 2021 at 05:09:42PM +0200, Rafael J. Wysocki wrote:
> On 3/29/2021 9:52 PM, Angela Czubak wrote:
> > Do not overwrite flags as it leads to erasing triggering and polarity
> > information which might be useful in case of hard-coded interrupts.
> > This way the information can be read later on even though mapping to
> > APIC domain failed.
> > 
> > Signed-off-by: Angela Czubak <acz@semihalf.com>
> > ---
> > Some Chromebooks use hard-coded interrupts in their ACPI tables.
> > This is an excerpt as dumped on Relm:
> > 
> > ...
> >              Name (_HID, "ELAN0001")  // _HID: Hardware ID
> >              Name (_DDN, "Elan Touchscreen ")  // _DDN: DOS Device Name
> >              Name (_UID, 0x05)  // _UID: Unique ID
> >              Name (ISTP, Zero)
> >              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >              {
> >                  Name (BUF0, ResourceTemplate ()
> >                  {
> >                      I2cSerialBusV2 (0x0010, ControllerInitiated, 0x00061A80,
> >                          AddressingMode7Bit, "\\_SB.I2C1",
> >                          0x00, ResourceConsumer, , Exclusive,
> >                          )
> >                      Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, )
> >                      {
> >                          0x000000B8,
> >                      }
> >                  })
> >                  Return (BUF0) /* \_SB_.I2C1.ETSA._CRS.BUF0 */
> >              }
> > ...
> > 
> > This interrupt is hard-coded to 0xB8 = 184 which is too high to be mapped
> > to IO-APIC, so no triggering information is propagated as acpi_register_gsi()
> > fails and irqresource_disabled() is issued, which leads to erasing triggering
> > and polarity information.
> > If that function added its flags instead of overwriting them the correct IRQ
> > type would be set even for the hard-coded interrupts, which allows device driver
> > to retrieve it.
> > Please, let me know if this kind of modification is acceptable.
> 
> From the quick look it should not be problematic, but it needs to be checked
> more carefully.
> 
> Mika, what do you think?

I think it makes sense. We still set IORESOURCE_DISABLED unconditionally
so this should not cause issues. In theory at least :)

> >   include/linux/ioport.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 55de385c839cf..647744d8514e0 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -331,7 +331,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
> >   {
> >   	res->start = irq;
> >   	res->end = irq;
> > -	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> > +	res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> >   }
> >   extern struct address_space *iomem_get_mapping(void);
> 
