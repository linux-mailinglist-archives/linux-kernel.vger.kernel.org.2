Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9754463A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhKEMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:52:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:8164 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhKEMwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:52:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="231838477"
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; 
   d="scan'208";a="231838477"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 05:49:45 -0700
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; 
   d="scan'208";a="450561560"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 05:49:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1miyev-003nK4-0Z;
        Fri, 05 Nov 2021 14:49:29 +0200
Date:   Fri, 5 Nov 2021 14:49:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v10] tty: Fix the keyboard led light display problem
Message-ID: <YYUoWJWbPpK079/d@smile.fi.intel.com>
References: <20211105122443.23897-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105122443.23897-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 08:24:43PM +0800, lianzhi chang wrote:
> Switching from the desktop environment to the tty environment,
> the state of the keyboard led lights and the state of the keyboard
> lock are inconsistent. This is because the attribute kb->kbdmode
> of the tty bound in the desktop environment (Xorg) is set to
> VC_OFF, which causes the ledstate and kb->ledflagstate
> values of the bound tty to always be 0, which causes the switch
> from the desktop When to the tty environment, the LED light
> status is inconsistent with the keyboard lock status.
> In order to ensure that the keyboard LED lights are displayed
> normally during the VT switching process, when the VT is
> switched, the current VT LED configuration is forced to be issued.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> ---
>  v10:
>  The led state of the input device is no longer synchronized to
>  ledstate, and the related code is deleted. The current plan is
>  changed to: when the VT is switched, the LED state saved by the
>  current VT is forced to be issued.

Shouldn't you add a Suggested-by tag?

-- 
With Best Regards,
Andy Shevchenko


