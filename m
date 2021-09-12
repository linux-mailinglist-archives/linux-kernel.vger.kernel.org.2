Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0806407DDE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhILPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 11:15:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:17570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhILPPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 11:15:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="221136470"
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="scan'208";a="221136470"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 08:14:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="scan'208";a="480974769"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 08:14:26 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mPRBX-002xN0-KE;
        Sun, 12 Sep 2021 18:14:23 +0300
Date:   Sun, 12 Sep 2021 18:14:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?iso-8859-1?B?UORy?= Ekholm <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] hwmon: (nct6775) Support access via Asus WMI
Message-ID: <YT4ZT18e1NtM4T5C@smile.fi.intel.com>
References: <20210912110557.41346-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210912110557.41346-1-pauk.denis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 02:05:55PM +0300, Denis Pauk wrote:
> Support accessing the NCT677x via Asus WMI functions.
> 
> On mainboards that support this way of accessing the chip,
> the driver will usually not work without this option since
> in these mainboards, ACPI will mark the I/O port as used.
> 
> @Andy Shevchenko, I have left type of sioreg, in other places
> sioreg has same integer type, should I change all occurrences
> of usage?
> @Guenter Roeck, I have left nct6775_*_set_back() call without
> changes as its always called from platform specific callbacks.
> 
> Could you please review?
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
> Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> Tested-by: Pär Ekholm <pehlm@pekholm.org>
> Tested-by: <to.eivind@gmail.com>
> Tested-by: Artem S. Tashkinov <aros@gmx.com>
> Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
> Tested-by: Sahan Fernando <sahan.h.fernando@gmail.com>

This should go to the actual patch that makes it work (preparatory patches may
or may not have all above be listed).

As kbuild bot rightfully noted, the series has to be bisectable.

Compile time bisectability means: each patch should compile incrementally.
And run-time bisectability means: the device should work with each patch
applied incrementally.

I.o.w. you have to compile and boot kernel as many times as patches in your
series + 1 (the clean build of the base).

-- 
With Best Regards,
Andy Shevchenko


