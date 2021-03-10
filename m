Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41B334348
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhCJQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:41:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:46597 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231790AbhCJQl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:41:26 -0500
IronPort-SDR: VThSInN9ZKeyZjjzpHUgKsQlo4QDu9NRljxJTdE9Af67rR9dW1LZRof+7DeN9vmDx3IBwkBjdP
 44NBn4gJ8NQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175612703"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="175612703"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:41:23 -0800
IronPort-SDR: YYDjhh1OA5FA/uN50/iTRjQ0hrwf4lSd5EzYDJrUKp2IotZ73mJSacsS+5eHu3txj+eR013M9t
 BFj6NdzrLPcg==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403742860"
Received: from huiyingw-mobl.amr.corp.intel.com (HELO [10.212.214.84]) ([10.212.214.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:41:21 -0800
Subject: Re: [PATCH V2] ASoC: soc-core: Prevent warning if no DMI table is
 present
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>
References: <20210303115526.419458-1-jonathanh@nvidia.com>
 <91480f92-a3f5-e71f-acdc-ea74488ab0a1@linux.intel.com>
 <20210310133534.GD4746@sirena.org.uk>
 <6a2352e6-f2b7-def1-de58-52fbeb7846e5@linux.intel.com>
 <20210310161814.GA28564@sirena.org.uk> <s5hzgzbvube.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9b073d01-f2fe-a99b-e53c-4a0b3f95ca05@linux.intel.com>
Date:   Wed, 10 Mar 2021 10:41:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hzgzbvube.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/21 10:37 AM, Takashi Iwai wrote:
> On Wed, 10 Mar 2021 17:18:14 +0100,
> Mark Brown wrote:
>>
>> On Wed, Mar 10, 2021 at 09:44:07AM -0600, Pierre-Louis Bossart wrote:
>>> On 3/10/21 7:35 AM, Mark Brown wrote:
>>
>>>> Just change it to a system level check for ACPI, checking for OF would
>>>> leave problems for board files or any other alternative firmware
>>>> interfaces.
>>
>>> did you mean if (!IS_ENABLED(CONFIG_ACPI)) ?
>>
>> Is there a runtime check?
> 
> Well, basically both DMI and ACPI are completely different things, so
> I don't think it's right to check the availability of ACPI as a signal
> of the availability of DMI.

would this work?

if (!IS_ENABLED(CONFIG_DMI))
     return 0;
