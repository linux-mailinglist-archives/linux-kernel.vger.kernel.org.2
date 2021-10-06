Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CD42418F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhJFPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:46:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:34806 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhJFPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:46:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="286904803"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="286904803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:44:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="458466106"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:44:11 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mY95T-009F82-LL;
        Wed, 06 Oct 2021 18:44:07 +0300
Date:   Wed, 6 Oct 2021 18:44:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 2/4] ASoC: Intel: bytcr_rt5640: Use temporary variable
 for struct device
Message-ID: <YV3ER4uIL4aRWBjz@smile.fi.intel.com>
References: <20211006150442.16503-1-andriy.shevchenko@linux.intel.com>
 <20211006150442.16503-2-andriy.shevchenko@linux.intel.com>
 <4b81a10dca78e286a9f806464b97111b5a15a91e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b81a10dca78e286a9f806464b97111b5a15a91e.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:21:01AM -0700, Joe Perches wrote:
> On Wed, 2021-10-06 at 18:04 +0300, Andy Shevchenko wrote:
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> trivia:
> 
> Some will complain about a lack of commit message.

Yeah, sorry for that, it wasn't deliberate. I forgot to run `git msg-filter`
on these three patches to add it.

Mark, do you want me resend entire bunch(es) or just starting from these
patches? Or...?

-- 
With Best Regards,
Andy Shevchenko


