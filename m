Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A74396DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhJYM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:59:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:54793 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhJYM74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:59:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="315846780"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="315846780"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:57:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="485664166"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:57:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mezXG-000ceU-FU;
        Mon, 25 Oct 2021 15:57:06 +0300
Date:   Mon, 25 Oct 2021 15:57:06 +0300
From:   "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>
To:     "changlianzhi@uniontech.com" <changlianzhi@uniontech.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "dmitry.torokhov" <dmitry.torokhov@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        jirislaby <jirislaby@kernel.org>, 282827961 <282827961@qq.com>
Subject: Re: [PATCH v6] tty: Fix the keyboard led light display problem
Message-ID: <YXaposOYGalsRtZt@smile.fi.intel.com>
References: <20211021020511.18016-1-changlianzhi@uniontech.com>
 <YXLVAOh6AcB34kW8@smile.fi.intel.com>
 <202110250129181502896@uniontech.com>
 <YXac+bpVemXEp9XR@smile.fi.intel.com>
 <202110251224440412487@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110251224440412487@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:24:45PM +0800, changlianzhi@uniontech.com wrote:
> On Mon, Oct 25, 2021 at 01:29:18AM +0800, changlianzhi@uniontech.com wrote:
> > > >>On Thu, Oct 21, 2021 at 10:05:11AM +0800, lianzhi chang wrote:

...

> > > >> +	unsigned long leds;
> > > >> +
> > > >> +	leds = (unsigned long)ledstate;
> > >
> > > >Can be one line.
> > >
> > > >But most important question you are ignoring to answer / address is why do you
> > > >use casting?
> 
> > > >>But most important question you are ignoring to answer / address is why do you
> > > >>use casting?
> > > Casting is used here because:
> > > The second parameter of test_bit is "volatile unsigned long *addr" (see constant_test_bit() in /arch/x86/include/asm/bitops.h), but ledstate is an "unsigned int" type. If casting is not used,
> > > compile Will report an error.
> 
> > Wait, you are casting pointer to an integer?!
> > This is completely wrong in this case!
> 
> Hello, I did not do that. For the complete code, please check the
> "patch v6" email I sent earlier. My code is like this:

> +static void kbd_update_ledstate(struct input_dev *dev)
> +{
> +	unsigned long leds;
> +
> +	leds = (unsigned long)ledstate;
> +
> +	if (!!test_bit(LED_NUML, dev->led) != !!test_bit(VC_NUMLOCK, &leds))
> +	ledstate ^= BIT(VC_NUMLOCK);
> +	if (!!test_bit(LED_CAPSL, dev->led) != !!test_bit(VC_CAPSLOCK, &leds))
> +	ledstate ^= BIT(VC_CAPSLOCK);
> +	if (!!test_bit(LED_SCROLLL, dev->led) != !!test_bit(VC_SCROLLOCK, &leds))
> +	ledstate ^= BIT(VC_SCROLLOCK);
> +}

> I mean, the second parameter of test_bit is "volatile unsigned long *addr",
> which is a pointer. And ledstate is an unsigned int type, so I defined an
> unsigned long type leds, assign the ledstate to the leds after forced
> conversion, and then when calling the test_bit function, get the address
> of the leds as a parameter.

This all is fine, but why casting is needed? I didn't still get.

-- 
With Best Regards,
Andy Shevchenko


