Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE25434BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:25:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:60606 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTNZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:25:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="209571797"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="209571797"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 06:22:45 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="527061761"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 06:22:43 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mdBY0-000DOj-0j;
        Wed, 20 Oct 2021 16:22:24 +0300
Date:   Wed, 20 Oct 2021 16:22:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v5] tty: Fix the keyboard led light display problem
Message-ID: <YXAYENOfaRr7bfJ8@smile.fi.intel.com>
References: <20211020125050.16446-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020125050.16446-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:50:50PM +0800, lianzhi chang wrote:
> Switching from the desktop environment to the tty environment,
> the state of the keyboard led lights and the state of the keyboard
> lock are inconsistent. This is because the attribute kb->kbdmode
> of the tty bound in the desktop environment (xorg) is set to
> VC_OFF, which causes the ledstate and kb->ledflagstate
> values of the bound tty to always be 0, which causes the switch
> from the desktop When to the tty environment, the LED light
> status is inconsistent with the keyboard lock status.

Thank you for an update! My comments below.

...

> +static void kbd_update_ledstate(struct input_dev *dev)
> +{
> +	unsigned long leds;
> +
> +	if (ledstate == -1U)
> +		ledstate = 0;

> +	leds = (unsigned long)ledstate;

It's still unclear why do you need casting here.

> +	if (!!test_bit(LED_NUML, dev->led) != !!test_bit(VC_NUMLOCK, &leds))
> +		ledstate ^= BIT(VC_NUMLOCK);
> +	if (!!test_bit(LED_CAPSL, dev->led) != !!test_bit(VC_CAPSLOCK, &leds))
> +		ledstate ^= BIT(VC_CAPSLOCK);
> +	if (!!test_bit(LED_SCROLLL, dev->led) != !!test_bit(VC_SCROLLOCK, &leds))
> +		ledstate ^= BIT(VC_SCROLLOCK);
> +}

...

>  	unsigned int leds;
>  	unsigned long flags;
> +	struct kbd_struct *kb;

Can we use reversed xmas tree ordering as I showed previously, please?


-- 
With Best Regards,
Andy Shevchenko


