Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1231C42EF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhJOLFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:05:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:10950 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238196AbhJOLFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:05:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="227787254"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="227787254"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 04:02:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="492447937"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213]) ([10.212.23.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 04:02:54 -0700
Subject: Re: [RFC PATCH v3 07/13] ASoC: soc-pcm: protect for_each_dpcm_be()
 loops
To:     Sameer Pujar <spujar@nvidia.com>, alsa-devel@alsa-project.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, vkoul@kernel.org,
        broonie@kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
 <20211013143050.244444-8-pierre-louis.bossart@linux.intel.com>
 <e101dee9-42cb-60f4-529b-2a9abb7740df@nvidia.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1492ba0c-73af-b43c-2d23-fc9e63bdc506@linux.intel.com>
Date:   Fri, 15 Oct 2021 06:02:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e101dee9-42cb-60f4-529b-2a9abb7740df@nvidia.com>
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
>> The D in DPCM stands for 'dynamic', which means that connections
>> between FE and BE can evolve.
>>
>> Commit a97648697790 ("ASoC: dpcm: prevent snd_soc_dpcm use after
>> free") started to protect some of the for_each_dpcm_be() loops, but
>> there are still many cases that were not modified.
>>
>> This patch adds protection for all the remaining loops, with the
>> notable exception of the dpcm_be_dai_trigger(), where the lock is
>> already taken at a higher level, e.g. in snd_pcm_period_elapsed().
>>
>> Signed-off-by: Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/soc-pcm.c | 86 ++++++++++++++++++++-------------------------
>>   1 file changed, 39 insertions(+), 47 deletions(-)
> 
> After this, once I load sound card there are warning prints and failure:
> 
> [   71.224324] WARNING: CPU: 3 PID: 574 at
> drivers/firmware/tegra/bpmp.c:362 tegra_bpmp_transfer+0x2d0/0x328
> [   71.238032] ---[ end trace 88d978f78a82134f ]---
> [   71.243033] WARNING: CPU: 3 PID: 574 at
> drivers/firmware/tegra/bpmp.c:362 tegra_bpmp_transfer+0x2d0/0x328
> [   71.257022] ---[ end trace 88d978f78a821350 ]---
> [   71.261965] tegra-audio-graph-card sound: Can't set plla rate for
> 270950400, err: -22
> ...
> 
> 
> This happens because, now the atomicity is propagated to BE callbacks
> where the clock settings are done in hw_param(). On Tegra, the clock
> APIs are served by BPMP and warning is seen because of below.

Sorry, I don't understand this part.

if the FEs used on Tegra have the nonatomic property set to zero,
nothing will be propagated really.

This patch was required on the Intel side, because ALL FEs are nonatomic
but some BEs are not, so I had issues when connecting a nonatomic FE to
an atomic BE. See e.g.
https://github.com/thesofproject/linux/pull/3209#issuecomment-941229502
