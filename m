Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6685E4243EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhJFRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:23:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:45468 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232197AbhJFRW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:22:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223449201"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223449201"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:18:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439196894"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:18:57 -0700
Subject: Re: [PATCH v1 3/4] ASoC: Intel: bytcr_rt5651: use
 devm_clk_get_optional() for mclk
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
 <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
 <2d190513-7ac4-731c-7c9a-1f60a98f6345@linux.intel.com>
 <YV3NZnb6mg43nUC1@smile.fi.intel.com>
 <015e084e-70ed-7b5c-b103-8426ef0842d4@linux.intel.com>
 <999a1046-864e-2b47-6f44-6e8e42528b18@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fdbb840c-3a72-eae3-a650-bd6cc5abc53b@linux.intel.com>
Date:   Wed, 6 Oct 2021 12:18:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <999a1046-864e-2b47-6f44-6e8e42528b18@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> We'd need to Hans to comment on this since he's really the only one
>> maintaining this code.
> 
> So as Mark wrote in his later reply:
> 
> "AIUI with the clock API the idiomatic thing is that any optionality is
> handled at the point where the clock is acquired - if the clock is
> optional you end up with NULL which in the clock API is a dummy clock
> and ignored.  The rest of the code then doesn't need to worry about any
> of this stuff and the handling can only be in one place."
> 
> Combined with there pretty much always actually being an mclk I believe
> that this patch from Andy results in a nice cleanup so I'm in favor with
> this. And the other cleanups also look sensible to me

No sustained objection on my side.

Thanks Andy for starting this thread.
