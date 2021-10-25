Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF843957D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhJYMFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:05:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:24240 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhJYMFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:05:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229903341"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="229903341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:03:28 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="446201127"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:03:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1meyh0-000c18-2u;
        Mon, 25 Oct 2021 15:03:06 +0300
Date:   Mon, 25 Oct 2021 15:03:05 +0300
From:   "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>
To:     "changlianzhi@uniontech.com" <changlianzhi@uniontech.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "dmitry.torokhov" <dmitry.torokhov@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        jirislaby <jirislaby@kernel.org>, 282827961 <282827961@qq.com>
Subject: Re: [PATCH v6] tty: Fix the keyboard led light display problem
Message-ID: <YXac+bpVemXEp9XR@smile.fi.intel.com>
References: <20211021020511.18016-1-changlianzhi@uniontech.com>
 <YXLVAOh6AcB34kW8@smile.fi.intel.com>
 <202110250129181502896@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110250129181502896@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 01:29:18AM +0800, changlianzhi@uniontech.com wrote:
> >>On Thu, Oct 21, 2021 at 10:05:11AM +0800, lianzhi chang wrote:
> >> Switching from the desktop environment to the tty environment,
> >> the state of the keyboard led lights and the state of the keyboard
> >> lock are inconsistent. This is because the attribute kb->kbdmode
> >> of the tty bound in the desktop environment (xorg) is set to
> >> VC_OFF, which causes the ledstate and kb->ledflagstate
> >> values of the bound tty to always be 0, which causes the switch
> >> from the desktop When to the tty environment, the LED light
> >> status is inconsistent with the keyboard lock status.
> 
> >...
> 
> >> +	unsigned long leds;
> >> +
> >> +	leds = (unsigned long)ledstate;
> 
> >Can be one line.
> 
> >But most important question you are ignoring to answer / address is why do you
> >use casting?

> >>But most important question you are ignoring to answer / address is why do you
> >>use casting?
> Casting is used here because:
> The second parameter of test_bit is "volatile unsigned long *addr" (see constant_test_bit() in /arch/x86/include/asm/bitops.h), but ledstate is an "unsigned int" type. If casting is not used,
> compile Will report an error.

Wait, you are casting pointer to an integer?!
This is completely wrong in this case!

-- 
With Best Regards,
Andy Shevchenko


