Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34A44653A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhKEOw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:52:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:19995 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhKEOwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:52:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="230634321"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="230634321"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 07:50:05 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="668261911"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 07:50:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mj0XM-003pNt-Uz;
        Fri, 05 Nov 2021 16:49:48 +0200
Date:   Fri, 5 Nov 2021 16:49:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v12] tty: Fix the keyboard led light display problem
Message-ID: <YYVEjMKfhnEMqQxD@smile.fi.intel.com>
References: <20211105134816.13982-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105134816.13982-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 09:48:16PM +0800, lianzhi chang wrote:
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

...

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Not me, it's Dmitry who suggested the solution. Sorry I wasn't crystal clear
about this part.

...

>  v11:
>  Supplement the signature of the collaborator.

You have v12 in the subject...

-- 
With Best Regards,
Andy Shevchenko


