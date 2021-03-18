Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D376340585
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCRM3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:29:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:37369 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhCRM2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:28:51 -0400
IronPort-SDR: qmWL85Qja+hoUUsw3lt7jMZMQc6Ow0RQm8w6o2VCpTRLx6wLF3pfhqQqk2CwAwaQugeHxIFjPS
 7dcYR4Yjem8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="209665048"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="209665048"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 05:28:50 -0700
IronPort-SDR: JsvFnuHaxxVG8o7XfFxBcOLaZTyrONyCDU0I8r9X39KY7L0RnNTyUvGGlGa7Q0dKGlT3IjY06V
 o5Tyzp6M3XZA==
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="406343619"
Received: from hapte-mobl.amr.corp.intel.com (HELO [10.212.219.204]) ([10.212.219.204])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 05:28:47 -0700
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp
 support
To:     Jack Yu <jack.yu@realtek.com>, Brent Lu <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        =?UTF-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?= 
        <kent_chen@realtek.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210317110824.20814-1-brent.lu@intel.com>
 <af990f6f-3a8b-3a1e-a02a-3bfe96e4d80a@linux.intel.com>
 <7f91482a93aa4d429ee574d730eeca6a@realtek.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <73f439e8-8553-30bd-f72c-e7d86fe59447@linux.intel.com>
Date:   Thu, 18 Mar 2021 05:57:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7f91482a93aa4d429ee574d730eeca6a@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/21 8:21 PM, Jack Yu wrote:
>>> This patch adds jsl_rt5682_rt1015p which supports the RT5682 headset
>>> codec and ALC1015Q-VB speaker amplifier combination on JasperLake
>>> platform.
>>>
>>> This driver also supports ALC1015Q-CG if running in auto-mode.
>>> Following table shows the audio interface support of the two
>>> amplifiers.
>>>
>>>             | ALC1015Q-CG | ALC1015Q-VB
>>> =====================================
>>> I2C       | Yes         | No
>>> Auto-mode | 48K, 64fs   | 16k, 32fs
>>>                           | 48k, 32fs
>>>                           | 48k, 64fs
>>>
>>> Signed-off-by: Brent Lu <brent.lu@intel.com>
>>
>> The code is looks fine, but Jack Yu added a separate patch that makes
>> RTL1019 equivalent to RTL1015, so should this patch also handle the
>> RTL1019 case?
>>
> For rt1019 non-i2c mode (auto mode), it uses the sdb pin to enable amp, the same as rt1015 non-i2c mode,
> therefore we propose rt1019(auto mode) to use rt1015p instead of adding a new driver for it.

ok, that's fine.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
