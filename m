Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A830CC3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhBBTsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:48:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:30334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240046AbhBBTqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:46:39 -0500
IronPort-SDR: DR5pnz9VWmbT/25ya/8gNYcWiSCA9Q3p2UPiw3Nlt0ZL2R23iCmO2SKNgK7TTprWAavVftCfk7
 nzkyHB/ldqBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="168026647"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="168026647"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 11:45:53 -0800
IronPort-SDR: h64eDiPIfkkv7OpD8OQKQZpYmVajOC/dG56z7nCYbFdh1SCCd1nA7Es8LgOGHqeKXpFzHjSqUW
 y3hAHWLu3JVQ==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="372087794"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.24.26]) ([10.213.24.26])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 11:45:50 -0800
Subject: Re: [PATCH] ASoC: Intel: catpt: remove unneeded semicolon
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, perex@perex.cz
Cc:     tiwai@suse.com, broonie@kernel.org, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
 <fb3dd21b-dde6-d9f7-e497-a443f60e7493@intel.com>
Message-ID: <adc3a883-a268-c3a9-b53b-c2ac96ca03db@intel.com>
Date:   Tue, 2 Feb 2021 20:45:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <fb3dd21b-dde6-d9f7-e497-a443f60e7493@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-01 10:03 PM, Cezary Rojewski wrote:
> On 2021-02-01 9:01 AM, Yang Li wrote:
>> Eliminate the following coccicheck warning:
>> ./sound/soc/intel/catpt/pcm.c:355:2-3: Unneeded semicolon
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>   sound/soc/intel/catpt/pcm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
>> index e5d54bb..88a0879 100644
>> --- a/sound/soc/intel/catpt/pcm.c
>> +++ b/sound/soc/intel/catpt/pcm.c
>> @@ -352,7 +352,7 @@ static int catpt_dai_apply_usettings(struct 
>> snd_soc_dai *dai,
>>           break;
>>       default:
>>           return 0;
>> -    };
>> +    }
>>       list_for_each_entry(pos, &component->card->snd_card->controls, 
>> list) {
>>           if (pos->private_data == component &&
>>
> 
> Hello Yang,
> 
> Your patch is much appreciated.
> 
> I noticed that more mistakes such as this have been made in the code. 
> Could you please also update switch-statements in other parts of catpt 
> (from what I've found, pcm.c has 2 occurrences while loader.c has 1)?
> 

I see now. Patch [1] provided the fixes already but optimization of mine 
[2] done later, overridden part of it. In that case, there's nothing 
else to be done.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Regards,
Czarek


[1]: https://lore.kernel.org/r/20201101171943.2305030-1-trix@redhat.com
[2]: 
https://lore.kernel.org/r/20201116133332.8530-4-cezary.rojewski@intel.com
