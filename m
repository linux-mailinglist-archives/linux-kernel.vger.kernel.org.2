Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E845EADB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376588AbhKZKAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:00:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:24727 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237197AbhKZJ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:58:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="233133716"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="233133716"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 01:55:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="675508802"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 01:55:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqXx7-00Ak2s-Qh;
        Fri, 26 Nov 2021 11:55:33 +0200
Date:   Fri, 26 Nov 2021 11:55:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v15] tty: Fix the keyboard led light display problem
Message-ID: <YaCvFYyBljlQRKth@smile.fi.intel.com>
References: <20211126024423.17218-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126024423.17218-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:44:23AM +0800, lianzhi chang wrote:
> When the desktop and tty switch mutually, the led state of the
> keyboard may be inconsistent with the state of the keyboard lock.
> This is because the desktop environment (Xorg, etc.) is bound to
> a tty, and the kb->kbdmode attribute of this tty is set to VC_OFF.
> This leads to the fact that in the desktop environment, the bound
> tty will not set the keyboard light state, so in the current tty
> scene, the values of ledstate and kb->ledflagstate are always 0.
> This leads to two situations: (1) When switching from the desktop
> to another tty, the code inside VT still compares ledstate with
> the kb->ledflagstate of the next tty. If they are equal, then
> after the switch is completed, The keyboard light will maintain
> the state of the previous desktop settings, and the state of the
> keyboard lock may be inconsistent; (2) When switching from another
> tty to the desktop, according to the code logic, it may still
> trigger the desktop bound tty to set the keyboard light state.
> After the switch is completed, the keyboard light is forcibly
> turned off. I think in this case, the tty should not set the
> keyboard light, and give control to Xorg etc. to handle it.
> The current modification judges the value of kb->kbdmode.
> In some modes, when switching VT, the current tty keyboard
> light status is forcibly issued. And when switching to the
> desktop, the tty no longer sets the keyboard light.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>

> Suggested-by: dmitry.torokhov <dmitry.torokhov@gmail.com>

I guess I have told you at least a couple of times that the format of these
lines should follow the pattern, where it's "Real Name <real@email.com>".
I truly believe there is no guy with _real_ name "dmitry.torochov".

...

>  /*
>   * Notifier list for console keyboard events

(1)

> @@ -412,9 +413,20 @@ static void do_compute_shiftstate(void)
>  /* We still have to export this method to vt.c */
>  void vt_set_leds_compute_shiftstate(void)
>  {

> +	/* When switching VT, according to the value of kb->kbdmode,
> +	 * judge whether it is necessary to force the keyboard light
> +	 * state to be issued.
> +	 */

Is it too hard to be consistent? See (1).

-- 
With Best Regards,
Andy Shevchenko


