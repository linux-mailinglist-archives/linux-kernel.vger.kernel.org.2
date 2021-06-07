Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1C39DF01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFGOo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:44:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:20750 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhFGOo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:44:57 -0400
IronPort-SDR: FwZyGfmcnoe3T8G35QN+UKwETiOeVv6tF4r4l5MCz+uDPon/OsyuNvxcUTugp4tXPuGC8ny5CW
 tv3vn5s/DmLg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204602881"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="204602881"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:43:06 -0700
IronPort-SDR: CeHH2bAx8sbXJSgflxrJfs1CIzAPWJ5w8atWCRvUHRcBtt4VcLlUvP21ft1ZLtBUi0afvQkJbG
 ScBsXQMEP20g==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="447503469"
Received: from dsanc15x-mobl3.amr.corp.intel.com (HELO [10.251.138.253]) ([10.251.138.253])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:43:04 -0700
Subject: Re: [PATCH 3/4] ASoC: intel: sof_cs42l42: add support for
 jsl_cs4242_mx98360a
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>, Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "M, Naveen" <naveen.m@intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
 <20210606004102.26190-4-brent.lu@intel.com>
 <505c7e46-316c-9fa1-feaa-115f4561ed19@linux.intel.com>
 <DM6PR11MB36421AD935E4A2B8EBD0FE6197389@DM6PR11MB3642.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cb76f83c-e9d1-9726-ff8d-8d48a4de8e26@linux.intel.com>
Date:   Mon, 7 Jun 2021 09:43:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB36421AD935E4A2B8EBD0FE6197389@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 9:29 AM, Lu, Brent wrote:
>> On 6/5/21 7:41 PM, Brent Lu wrote:
>>> This patch adds driver data for jsl_cs4242_mx98360a which supports two
>>> max98360a speaker amplifiers on SSP1 and cs42l42 headphone codec on
>>> SSP0 running on JSL platform. DAI format is leveraged from sof_rt5682
>>> machine driver to reuse the topology.
>>
>> This also looks like we have two topologies configuring the same DAIs
>> differently on different platforms.
>>
>> Why can't we pick one configuration that would work in all cases?
>>
> 
> The comment just say we are reusing rt5685's sof-jsl-rt5682-mx98360a.tplg.
> This patch does not care about the dai sequence. Maybe I should reword the
> commit log.

I was referring to the bclk frequency, one case uses 2.4 and the other 
3.072MHz.
