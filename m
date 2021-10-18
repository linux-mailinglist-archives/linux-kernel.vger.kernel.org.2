Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3465D432291
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhJRPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:20:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:57527 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232367AbhJRPUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:20:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="208372767"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="208372767"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 08:15:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="566102971"
Received: from dsardana-mobl.amr.corp.intel.com (HELO [10.209.189.174]) ([10.209.189.174])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 08:15:11 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: Initialize the sof_sdw_quirk with
 RT711_JD_NULL
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, yang.jie@linux.intel.com,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org
References: <20211015133424.494463-1-chris.chiu@canonical.com>
 <c40282f6-cb8f-22ca-4a57-26fcbc39f423@linux.intel.com>
 <CABTNMG0oef2AQywfzQ3iMfHWXxi6RDUL9VaQ_cYfbFp1JZqAWg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <16370bb9-51d4-69ab-8de9-b0dc09377f1c@linux.intel.com>
Date:   Mon, 18 Oct 2021 10:15:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABTNMG0oef2AQywfzQ3iMfHWXxi6RDUL9VaQ_cYfbFp1JZqAWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> On 10/15/21 8:34 AM, Chris Chiu wrote:
>>> The jd_src of RT711 which is initialized in rt711/rt711_sdca_init
>>> will be overridden by rt711/rt711_sdca_add_codec_device_props when
>>> the sof_sdw_quirk is not RT711_JD_NULL. It will force the JD mode
>>> to RT711_JD1 and cause confusion while debugging the JD mode of
>>> the boards without quirk. Initialize sof_sdw_quirk with RT711_JD_NULL
>>> to honor the jd_src value in rt711/rt711_sdca init.
>>
>> Not able to follow what the "confusion while debugging the JD mode of
>> the boards without quirk" is. You need a DMI quirk or need to override
>> the default quirk with the kernel module parameter.
>>
> The JD mode will be set by rt711/rt711_sdca_init first (which is JD2
> as https://github.com/torvalds/linux/blob/master/sound/soc/codecs/rt711.c#L1209.
> Then it will be overridden by rt711_add_codec_device_props() while doing
> rt711_parse_dt(), which is now always JD1 since the current
> sof_sdw_quirk init value.
> I'm afraid that JD2 is a more preferable mode rather than JD1. Then we
> will have to
> maintain a bigger DMI quirk table for more and more coming alderlake machines.
> 
> Given the rt711 codec has initialized the jd_src to JD2, The
> sof_sdw_quirk should only
> override it unless necessary? But now it's forced to override. Or can
> we have a more
> generic solution for it?

I don't mind changing the default if the majority of devices uses JD2.
But your patch doesn't do this cleanly, it breaks all usages of JD1 that
relied on the previous default.

Changing the default for jack detection also doesn't really decrease the
need for quirks in itself, for this we would need to handle the RT715
quirk and also fix the amplifier link id, and also set the HDMI quirk
depending on the platform setting. Bard's working on this, see
https://github.com/thesofproject/linux/pull/3203
