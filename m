Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B954D452F43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhKPKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:41:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:12433 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234039AbhKPKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:41:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257422426"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="257422426"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 02:38:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="592571817"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 02:38:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mmvrI-007O8b-IQ;
        Tue, 16 Nov 2021 12:38:36 +0200
Date:   Tue, 16 Nov 2021 12:38:36 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 0/2] Update ASUS WMI supported boards
Message-ID: <YZOKLDg582dQPzVN@smile.fi.intel.com>
References: <20211115210842.11972-1-pauk.denis@gmail.com>
 <CAHp75VcPHi1XyZr=CFbUhiUXK0q-10iBx5U3d==aG8pMG27k1Q@mail.gmail.com>
 <c016d0ca-b8b1-fb06-50f3-06a7b1c4aaea@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c016d0ca-b8b1-fb06-50f3-06a7b1c4aaea@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 03:15:39PM -0800, Guenter Roeck wrote:
> On 11/15/21 2:01 PM, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 11:09 PM Denis Pauk <pauk.denis@gmail.com> wrote:
> > > 
> > > Add support by WMI interface provided by Asus for B550/X570 boards:
> > > * PRIME X570-PRO,
> > > * ROG CROSSHAIR VIII HERO
> > > * ROG CROSSHAIR VIII DARK HERO
> > > * ROG CROSSHAIR VIII FORMULA
> > > * ROG STRIX X570-E GAMING
> > > * ROG STRIX B550-I GAMING
> > > * ROG STRIX B550-E GAMING
> > > 
> > > Add support by WMI interface provided by Asus for X370/X470/
> > > B450/X399 boards:
> > > * ROG CROSSHAIR VI HERO,
> > > * PRIME X399-A,
> > > * PRIME X470-PRO,
> > > * ROG CROSSHAIR VI EXTREME,
> > > * ROG CROSSHAIR VI HERO (WI-FI AC),
> > > * ROG CROSSHAIR VII HERO,
> > > * ROG CROSSHAIR VII HERO (WI-FI),
> > > * ROG STRIX Z390-F GAMING
> > > * ROG STRIX B450-E GAMING,
> > > * ROG STRIX B450-F GAMING,
> > > * ROG STRIX B450-I GAMING,
> > > * ROG STRIX X399-E GAMING,
> > > * ROG STRIX X470-F GAMING,
> > > * ROG STRIX X470-I GAMING,
> > > * ROG ZENITH EXTREME,
> > > * ROG ZENITH EXTREME ALPHA.
> > > 
> > > I have added "ROG STRIX Z390-F GAMING" to list of supported boards in
> > > asus_wmi_sensors.
> > 
> > Guenter, what is your plan about this patch series? It seems it
> > missed, by unknown (?) reason, the v5.16-rc1 (I remember seeing it in
> > some of your tree branches at some point).
> > 
> 
> I don't see it in my record. Earlier I was simply waiting for some
> Reviewed-by: tags, which I have never seen.

Ah, understood. Thank you for clarifications.

> Looking into the commit log,
> I do see:
> 
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Did you and Eugene indeed sign this off, ie did you write it, and
> Eugene and Denis signed it off ? If so, the tags are in the wrong order.

I'm not sure I follow. I have helped Denis with the code and according to
Submitting Patches documentation the order should be chronological with the
main author to be first in the list. Here the committer (submitter) is the
same as the original author IIUC. (I can't speak for Eugene, though)

> On the other side, if the code is ultimately from Denis, with your input,
> the tags should be either Acked-by: or Reviewed-by: for both Eugene
> and yourself.

I'm fine with either Co-developed-by+SoB or Reviewed-by.

> Note that v11 of this patch series is missing from
> https://patchwork.kernel.org/project/linux-hwmon/list/
> for some reason.

Hmm... Denis, please check locally how you prepare your patches.


-- 
With Best Regards,
Andy Shevchenko


