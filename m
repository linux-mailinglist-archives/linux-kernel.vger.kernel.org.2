Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B199E45D97E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhKYLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:48:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:23942 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236233AbhKYLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:46:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="215525353"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="215525353"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:40:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="741736989"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:40:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqD6z-00AQ4B-Gn;
        Thu, 25 Nov 2021 13:40:21 +0200
Date:   Thu, 25 Nov 2021 13:40:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     "dmitry.torokhov" <dmitry.torokhov@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        jirislaby <jirislaby@kernel.org>, 282827961 <282827961@qq.com>
Subject: Re: [PATCH v14] tty: Fix the keyboard led light display problem
Message-ID: <YZ92JaKnUbXb0shZ@smile.fi.intel.com>
References: <20211108055139.7202-1-changlianzhi@uniontech.com>
 <YYtpr/bP0HqBsmbW@google.com>
 <tencent_032E4FE80FDB8EA164AE0644@qq.com>
 <tencent_5573CD56296D5E2F4C59A664@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5573CD56296D5E2F4C59A664@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:33:23AM +0800, lianzhi chang wrote:
> > > On Mon, Nov 08, 2021 at 01:51:39PM +0800, lianzhi chang wrote:
> > > > Switching from the desktop environment to the tty environment,
> > > > the state of the keyboard led lights and the state of the keyboard
> > > > lock are inconsistent. This is because the attribute kb->kbdmode
> > > > of the tty bound in the desktop environment (Xorg) is set to
> > > > VC_OFF, which causes the ledstate and kb->ledflagstate
> 
> > > We know that Xorg sets kbdmode mode to VC_OFF, but it does not mean that
> > > you can say for sure that it is Xorg instance that controls a VT simply
> > > by observing kb->kbdmode. There may be something else entirely. That is
> > > why you want drivers/tty/vt/keyboard.c to reset LEDs and leave it to
> > > whoever is controlling VT to set them to something else if it is
> > > desired.
> 
> > Does this mean let me change the description information? Or is the
> > judgment of VC_OFF in patch incorrect?
> > The setup method of Xorg mentioned here is just to describe a process
> > in which I found the problem;
> > My understanding is that when the mode of kbdmode is set to VC_OFF,
> > VT shouldn't interfere with the state of the keyboard light, right? This is
> > how functions such as kbd_keycode() are implemented.
> > When VT is switched, if the VT mode is VC_OFF, there is also no need
> > to set the state of the keyboard light. I think this is reasonable.
> 
> > > > > values of the bound tty to always be 0, which causes the switch
> > > > > from the desktop When to the tty environment, the LED light
> > > > > status is inconsistent with the keyboard lock status.
> > > > > In order to ensure that the keyboard LED lights are displayed
> > > > > normally during the VT switching process, when the VT is
> > > > > switched, the current VT LED configuration is forced to be issued.

> Hi friends, how is this patch progressing now, do I need to modify it further?

At least I have told you already twice that I'm not the guy who suggested this
solution. Others seem gave you other comments.

-- 
With Best Regards,
Andy Shevchenko


