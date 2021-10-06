Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7C424293
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbhJFQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:27:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:8683 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhJFQ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:27:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="225984223"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="225984223"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:25:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="484178307"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:25:04 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mY9j2-009Fq7-Q6;
        Wed, 06 Oct 2021 19:25:00 +0300
Date:   Wed, 6 Oct 2021 19:25:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: bytcht_es8316: Get platform data via
 dev_get_platdata()
Message-ID: <YV3N3KqGJN7Dztwa@smile.fi.intel.com>
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
 <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:52:54AM -0500, Pierre-Louis Bossart wrote:
> On 10/6/21 10:04 AM, Andy Shevchenko wrote:
> > Access to platform data via dev_get_platdata() getter to make code cleaner.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> For the series
> 
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>

Thanks!

> FWIW Marc likes a cover letter that's kept in the merge logs.

Noted!

-- 
With Best Regards,
Andy Shevchenko


