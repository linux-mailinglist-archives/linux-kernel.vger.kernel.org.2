Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A959042F0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhJOM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:27:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:28965 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhJOM1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:27:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="228185588"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="228185588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 05:24:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="492523934"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213]) ([10.212.23.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 05:24:55 -0700
Subject: Re: [RFC PATCH v3 04/13] ASoC: soc-pcm: introduce
 snd_soc_dpcm_fe_lock_irq/unlock_irq()
To:     Sameer Pujar <spujar@nvidia.com>, alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
 <20211013143050.244444-5-pierre-louis.bossart@linux.intel.com>
 <a98ea2c6-e617-0fb7-8b24-99b8edc8868a@nvidia.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6d7c8d71-d131-fd92-c1c6-e4f4380a4f77@linux.intel.com>
Date:   Fri, 15 Oct 2021 07:24:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a98ea2c6-e617-0fb7-8b24-99b8edc8868a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/21 1:24 AM, Sameer Pujar wrote:
> 
> 
> On 10/13/2021 8:00 PM, Pierre-Louis Bossart wrote:
>> In preparation for more changes, add two new helpers to gradually
>> modify the DPCM locks.
>>
>> Since DPCM functions are not used from interrupt handlers, we can only
>> use the lock_irq case.
>>
>> While most of the uses of DPCM are internal to soc-pcm.c, some drivers
>> in soc/fsl and soc/sh do make use of DPCM-related loops that will
>> require protection, adding EXPORT_SYMBOL_GPL() is needed for those
>> drivers.
>>
>> The stream argument is unused in this patch but will be enabled in
>> follow-up patches.
>>
>> Signed-off-by: Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/sound/soc-dpcm.h |  3 +++
>>   sound/soc/soc-pcm.c      | 42 +++++++++++++++++++++++-----------------
>>   2 files changed, 27 insertions(+), 18 deletions(-)
> 
> 1. Till this patch and with DEBUG_LOCKDEP config enabled, I see

Did you mean "with this patch included", yes?

> following warning:
>    "WARNING: CPU: 0 PID: 0 at kernel/locking/irqflag-debug.c:10
> warn_bogus_irq_restore+0x30/0x40"
> 
>    However test passed though. Interestingly it was seen only for the
> first time I ran a 2x1 mixer test.
> 
> 2. Also after I load sound modules and card gets registered, I see some
> hw_param() calls for FE and BE. This seems harmless at this point, but
> is getting problematic with subsequent patches. This was not happening
> earier.

This patch doesn't change any of the flow, it just adds a wrapper in
preparation for the transition to the FE pcm lock.

The only change is that we use spin_lock_irq instead of the
irqsave/restore version, but that was also Takashi's recommendation.

the test results would suggest that on Tegra DPCM functions are used
from an interrupt context?
