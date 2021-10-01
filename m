Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB941F465
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355566AbhJASN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:13:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:56908 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232126AbhJASNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:13:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205009140"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="205009140"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 11:11:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="565189925"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 11:11:49 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mWN0b-007Vez-Pz;
        Fri, 01 Oct 2021 21:11:45 +0300
Date:   Fri, 1 Oct 2021 21:11:45 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszor@gmail.com>
Cc:     zboszor@pr.hu, Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl-intel: Fix NULL pointer dereference
Message-ID: <YVdPYQ3RsyrWXU2H@smile.fi.intel.com>
References: <20210920124416.7063-1-zboszor@pr.hu>
 <CAHp75VdTJ825JP51p24XJmpQORUhoTJ2=7_HOpqw-EGT1fFEOA@mail.gmail.com>
 <7f8ad14e-b2d8-676c-cd86-6ddd2dc386bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f8ad14e-b2d8-676c-cd86-6ddd2dc386bb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 07:07:17AM +0200, Böszörményi Zoltán wrote:
> On 2021. 09. 20. 18:00, Andy Shevchenko wrote:
> > On Mon, Sep 20, 2021 at 4:00 PM <zboszor@pr.hu> wrote:
> > > On an Elkhart Lake based POS hardware prototype, I got this Oops:

...

> > > It's probably a firmware bug, so be overly protective:
> > Patch is simply wrong. While Oops will be gone, the driver won't work correctly.
> 
> Of course. But a driver that gives up is better than a
> crashing kernel which results in udevd and "udevadm settle"
> stalling forever on it. systemd waits about 6 minutes before
> continuing the boot process that involves these two services
> timing out and this also prevents powering the computer down.

Hiding real bugs is not a good strategy. What you may do is blacklisting it.

> > Yes, it's either a firmware bug or the driver is outdated (depends
> > from which side you look at this issue).
> > 
> > I have heard that new firmware is on its way to the customers, but I
> > have no more information right now.
> 
> Thanks, good to know.
> 
> I also reported it to the manufacturer, I hope to receive
> a response from them soon.
> 
> The kernel reports other firmware bugs for this
> Celeron J6412 based machine.

Yeah...

-- 
With Best Regards,
Andy Shevchenko


