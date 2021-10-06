Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA944242C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhJFQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:36:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:46337 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhJFQgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:36:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="213161376"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="213161376"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:34:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439957347"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:34:18 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mY9ry-009FyW-JQ;
        Wed, 06 Oct 2021 19:34:14 +0300
Date:   Wed, 6 Oct 2021 19:34:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 2/4] ASoC: Intel: bytcr_rt5640: Use temporary variable
 for struct device
Message-ID: <YV3QBsj2gLzmePWE@smile.fi.intel.com>
References: <20211006150442.16503-1-andriy.shevchenko@linux.intel.com>
 <20211006150442.16503-2-andriy.shevchenko@linux.intel.com>
 <4b81a10dca78e286a9f806464b97111b5a15a91e.camel@perches.com>
 <YV3ER4uIL4aRWBjz@smile.fi.intel.com>
 <YV3FaZ+afuZZSIth@sirena.org.uk>
 <YV3JWzNgGInZ1Bt5@smile.fi.intel.com>
 <YV3MtOrpziyKqkxA@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV3MtOrpziyKqkxA@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:20:04PM +0100, Mark Brown wrote:
> On Wed, Oct 06, 2021 at 07:05:47PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 06, 2021 at 04:48:57PM +0100, Mark Brown wrote:
> > > On Wed, Oct 06, 2021 at 06:44:07PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Oct 06, 2021 at 08:21:01AM -0700, Joe Perches wrote:
> 
> > > > > Some will complain about a lack of commit message.
> 
> > > > Yeah, sorry for that, it wasn't deliberate. I forgot to run `git msg-filter`
> > > > on these three patches to add it.
> 
> > > > Mark, do you want me resend entire bunch(es) or just starting from these
> > > > patches? Or...?
> 
> > > If you're adding a commit message with automation it's probably not
> > > adding any value.
> 
> > What do you mean? I add it exceptionally for the same (by nature) patches.
> > What do you expect to be altered in these three, if the idea behind the change
> > is very well the same?
> 
> I really don't care if there's a separate changelog for trivial patches
> like this, it adds nothing of value.

I see. In any case I'll add something meaningful here.

-- 
With Best Regards,
Andy Shevchenko


