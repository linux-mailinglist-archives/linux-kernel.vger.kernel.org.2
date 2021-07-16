Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A343CBB28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhGPRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:30:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:31673 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGPRah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:30:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="207740154"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="207740154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 10:27:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="431281124"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 10:27:40 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m4Rcc-00EK4B-1t; Fri, 16 Jul 2021 20:27:34 +0300
Date:   Fri, 16 Jul 2021 20:27:34 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [EXT] Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
Message-ID: <YPHBhpfk8RoEuQx2@smile.fi.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
 <784629f9-677e-ee53-aceb-89397ce0951a@oth-regensburg.de>
 <CAHp75VdoaE7hCOzsRvuf=7A4mmv0NWBmwqK_mM8vO-K3YZKTUQ@mail.gmail.com>
 <ac8ac10e-aa43-93a1-d36e-6304643375ae@oth-regensburg.de>
 <CAHp75VcLicxAz5BjP+Lp2yHxEGiKcT9OUZbPeRUgZVcYLdY0FA@mail.gmail.com>
 <599a37bd-3cb4-1e4b-d5f8-936c4daae71f@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599a37bd-3cb4-1e4b-d5f8-936c4daae71f@oth-regensburg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 05:27:36PM +0200, Ralf Ramsauer wrote:
> On 16/07/2021 17:01, Andy Shevchenko wrote:
> > On Fri, Jul 16, 2021 at 4:07 PM Ralf Ramsauer
> > <ralf.ramsauer@oth-regensburg.de> wrote:
> >> On 14/07/2021 15:35, Andy Shevchenko wrote:
> >>> On Wed, Jul 14, 2021 at 3:56 PM Ralf Ramsauer
> >>> <ralf.ramsauer@oth-regensburg.de> wrote:
> >>>> On 14/07/2021 08:54, Jiri Slaby wrote:
> >>>>> On 13. 07. 21, 12:40, Andy Shevchenko wrote:
> >>>
> >>>>> Hmm, have you checked the commit which introduced the whitelist?
> >>>>>
> >>>>>     Nevertheless, this needs to handled with care: while many 8250 devices
> >>>>>     actually claim to support MSI(-X) interrupts it should not be
> >>>>> enabled be
> >>>>>     default. I had at least one device in my hands with broken MSI
> >>>>>     implementation.
> >>>>>
> >>>>>     So better introduce a whitelist with devices that are known to support
> >>>>>     MSI(-X) interrupts. I tested all devices mentioned in the patch.
> >>>>>
> >>>>>
> >>>>> You should have at least CCed the author for an input.
> >>>>
> >>>> Yep, back then I was testing three different 8250 pci cards. All of them
> >>>> claimed to support MSI, while one really worked with MSI, the one that I
> >>>> whitelisted. So I thought it would be better to use legacy IRQs as long
> >>>> as no one tested a specific card to work with MSI.
> >>>
> >>> Can you shed a light eventually what those cards are?
> > 
> >> So I found a no-name el-cheapo card that has some issues with MSI:
> > 
> > Win Chip Head (WCH)
> > 
> >> 18:00.0 Serial controller: Device 1c00:3253 (rev 10) (prog-if 05 [16850])

Thank you!

One more thing, ist it possible to see entire PCI configuration space (w/ or
w/o MSI, I don't think it matters)? Something like

	`lspci -nk -vvv -xxx -s 18:0`

to run.

(I believe there are a lot of 0xff bytes)

-- 
With Best Regards,
Andy Shevchenko


