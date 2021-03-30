Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58434EB96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhC3PKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:10:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:32623 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231874AbhC3PJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:09:48 -0400
IronPort-SDR: rNJhceoetM/G+IuRfXSYgeVtGpKHpjneiwOI/JX+kKdAPHQOWiVFO7HORJmMfXN+2XXqQZXPML
 b2ibcOJzZNhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191816894"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191816894"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 08:09:48 -0700
IronPort-SDR: LZBLF35OpbKsekZsYWYC8Kwt+pNmJHfS5HV++apvkmZsiAr5LchciB8UlW0OdA5iMRiVW1UvHP
 p3uWO5EkANUA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="418210317"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.131.38]) ([10.249.131.38])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 08:09:45 -0700
Subject: Re: [PATCH] resource: Prevent irqresource_disabled() from erasing
 flags
To:     Angela Czubak <acz@semihalf.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     akpm@linux-foundation.org, john.garry@huawei.com,
        linux-kernel@vger.kernel.org, upstream@semihalf.com,
        dtor@chromium.org, linux-acpi <linux-acpi@intel.com>,
        rafael@kernel.org
References: <20210329195238.9455-1-acz@semihalf.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <1c086b9e-d5c2-6e8d-1d81-748935b0dd64@intel.com>
Date:   Tue, 30 Mar 2021 17:09:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210329195238.9455-1-acz@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2021 9:52 PM, Angela Czubak wrote:
> Do not overwrite flags as it leads to erasing triggering and polarity
> information which might be useful in case of hard-coded interrupts.
> This way the information can be read later on even though mapping to
> APIC domain failed.
>
> Signed-off-by: Angela Czubak <acz@semihalf.com>
> ---
> Some Chromebooks use hard-coded interrupts in their ACPI tables.
> This is an excerpt as dumped on Relm:
>
> ...
>              Name (_HID, "ELAN0001")  // _HID: Hardware ID
>              Name (_DDN, "Elan Touchscreen ")  // _DDN: DOS Device Name
>              Name (_UID, 0x05)  // _UID: Unique ID
>              Name (ISTP, Zero)
>              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>              {
>                  Name (BUF0, ResourceTemplate ()
>                  {
>                      I2cSerialBusV2 (0x0010, ControllerInitiated, 0x00061A80,
>                          AddressingMode7Bit, "\\_SB.I2C1",
>                          0x00, ResourceConsumer, , Exclusive,
>                          )
>                      Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, )
>                      {
>                          0x000000B8,
>                      }
>                  })
>                  Return (BUF0) /* \_SB_.I2C1.ETSA._CRS.BUF0 */
>              }
> ...
>
> This interrupt is hard-coded to 0xB8 = 184 which is too high to be mapped
> to IO-APIC, so no triggering information is propagated as acpi_register_gsi()
> fails and irqresource_disabled() is issued, which leads to erasing triggering
> and polarity information.
> If that function added its flags instead of overwriting them the correct IRQ
> type would be set even for the hard-coded interrupts, which allows device driver
> to retrieve it.
> Please, let me know if this kind of modification is acceptable.

 From the quick look it should not be problematic, but it needs to be 
checked more carefully.

Mika, what do you think?


>   include/linux/ioport.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 55de385c839cf..647744d8514e0 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -331,7 +331,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
>   {
>   	res->start = irq;
>   	res->end = irq;
> -	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> +	res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
>   }
>   
>   extern struct address_space *iomem_get_mapping(void);


