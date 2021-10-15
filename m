Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20642F9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbhJORLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:11:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:25206 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237786AbhJORLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:11:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="226726371"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="226726371"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 10:08:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="492640732"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213]) ([10.212.23.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 10:08:51 -0700
Subject: Re: [RFC PATCH v3 05/13] ASoC: soc-pcm: align BE 'atomicity' with
 that of the FE
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, vkoul@kernel.org,
        broonie@kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
 <20211013143050.244444-6-pierre-louis.bossart@linux.intel.com>
 <2847a6d1-d97f-4161-c8b6-03672cf6645c@nvidia.com>
 <s5hmtnavisi.wl-tiwai@suse.de>
 <e2a79095-b8ce-9dd4-3e6d-00f8dda99f30@linux.intel.com>
 <s5h1r4muwlj.wl-tiwai@suse.de>
 <8aa4fa07-2b55-3927-f482-c2fd2b01a22e@linux.intel.com>
 <s5hmtnateeo.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c0803288-efb1-aaeb-218f-e1a6ba87abd7@linux.intel.com>
Date:   Fri, 15 Oct 2021 12:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hmtnateeo.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I have not been able to figure out when you need
>> a) the pcm_mutex only
>> b) the fe stream lock only
>> c) both pcm_mutex and fe stream lock
> 
> The pcm_mutex is needed for every sleepable function that treat DPCM
> FE link, but the mutex is taken only at the upper level, i.e. the
> top-most caller like PCM ops FE itself or the DAPM calls.
> 
> That said, pcm_mutex is the top-most protection of BE links in FE.
> But, there is a code path where a mutex can't be used, and that's the
> FE and BE trigger.  For protecting against this, the FE stream lock is
> taken only at the placing both adding and deleting a BE *in addition*.
> At those places, both pcm_mutex and FE stream lock are taken.
> 
> BE stream lock is taken in addition below the above mutex and FE
> locks.

Thanks Takashi, now I get the idea. Makes sense indeed. I'll make sure
to add this explanation to the commit message/cover so that it's not lost.

I added your three patches to my tests, so far so good, code is that
https://github.com/thesofproject/linux/pull/3215

Thanks and have a nice week-end.
-Pierre
