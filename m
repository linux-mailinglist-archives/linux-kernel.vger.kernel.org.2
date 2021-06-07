Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFA39E6B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFGSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:34:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:16994 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhFGSek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:34:40 -0400
IronPort-SDR: WqmQKrKM9Ymsgp+O5W66LhrlQPkXDiSdduksF2hqg/ePcjTGV4jiCzJ4yf/5uQzH866aIQV9FB
 Tlv8jfgXNoUA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202820972"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="202820972"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 11:32:48 -0700
IronPort-SDR: hEZZQyqiJNNcgEl8G32to+qOaYgO6xuSYnKHeqp+pMk/0Q4uq1MkZuWkewh+e6OKbXz4HSPqu8
 i9roS/djGXHg==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="447585633"
Received: from dsanc15x-mobl3.amr.corp.intel.com (HELO [10.251.138.253]) ([10.251.138.253])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 11:32:46 -0700
Subject: Re: [PATCH 3/4] ASoC: intel: sof_cs42l42: add support for
 jsl_cs4242_mx98360a
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "M, Naveen" <naveen.m@intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
 <20210606004102.26190-4-brent.lu@intel.com>
 <505c7e46-316c-9fa1-feaa-115f4561ed19@linux.intel.com>
 <DM6PR11MB36421AD935E4A2B8EBD0FE6197389@DM6PR11MB3642.namprd11.prod.outlook.com>
 <cb76f83c-e9d1-9726-ff8d-8d48a4de8e26@linux.intel.com>
 <DM6PR11MB364231AEC2208EAF5F898B7A97389@DM6PR11MB3642.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f8fa92bf-29eb-5ea4-55cc-4bb99db3b0d7@linux.intel.com>
Date:   Mon, 7 Jun 2021 13:32:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB364231AEC2208EAF5F898B7A97389@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 11:28 AM, Lu, Brent wrote:
>>>>
>>>> This also looks like we have two topologies configuring the same DAIs
>>>> differently on different platforms.
>>>>
>>>> Why can't we pick one configuration that would work in all cases?
>>>>
>>>
>>> The comment just say we are reusing rt5685's sof-jsl-rt5682-mx98360a.tplg.
>>> This patch does not care about the dai sequence. Maybe I should reword
>>> the commit log.
>>
>> I was referring to the bclk frequency, one case uses 2.4 and the other
>> 3.072MHz.
> 
> The 2.4MHz setting isn't ready when we enabled this codec so we selected
> 3.072MHz. Since we are updating topology for PLL issue soon, we can change
> bclk frequency to 2.4MHz as well. How do you think?

The 3.072MHz clock will require the 24.576MHz PLL to be on on the 
SOC/PCH. If you can use 2.4 MHz without any loss of quality and the 
codec can deal with 25 bit slots with 24-bit data it's better power-wise.

We try to use 64.fs only when it's absolutely mandatory, e.g. if the 
codec or amplifier doesn't support the 25/24 configuration. IIRC this 
was the case with TI PCM512x and Maxim amps.

We've also used the 3.072 MHz bit clock when there are constraints on 
the clock sources and selectors. This isn't the case on GLK but the SOF 
commit 0a97c1a92f2d93bd4d45bc99d61e362cd214748c clarified the clock 
selection for newer platforms, including JSL. In the end we may be 
forced to use the 3.072 MHz PLL, you'd need to look at the various 
topologies used with this machine driver.

