Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF16F449AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbhKHRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:41:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:53674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240830AbhKHRl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:41:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293113449"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="293113449"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 09:18:23 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="533392402"
Received: from anushave-mobl1.amr.corp.intel.com (HELO [10.255.85.158]) ([10.255.85.158])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 09:18:21 -0800
Subject: Re: [Sound-open-firmware] [PATCH] ASoC: SOF: build compression
 interface into snd_sof.ko
To:     Arnd Bergmann <arnd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bud Liviu-Alexandru <budliviu@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
References: <20211108111132.3800548-1-arnd@kernel.org>
 <63c5b1fb-575e-f026-5a76-f08a366f7f38@linux.intel.com>
 <bae1a17c-af6e-d77a-19e7-f3f6408951fa@nxp.com>
 <CAK8P3a2-=-JM+p2b4v4F8O9O2ZhB-3Uhd_F+gcGAinAztSDH9A@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <948c8add-2a31-a7aa-f16c-8629dab690cc@linux.intel.com>
Date:   Mon, 8 Nov 2021 11:18:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2-=-JM+p2b4v4F8O9O2ZhB-3Uhd_F+gcGAinAztSDH9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/21 10:15 AM, Arnd Bergmann wrote:
> On Mon, Nov 8, 2021 at 3:13 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>> On 11/8/21 3:39 PM, Pierre-Louis Bossart wrote:
>>> On 11/8/21 5:11 AM, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> Fixes: 858f7a5c45ca ("ASoC: SOF: Introduce fragment elapsed notification API")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> It's Monday morning and my memory is still foggy but I think we fixed
>>> this problem with https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fthesofproject%2Flinux%2Fpull%2F3180&amp;data=04%7C01%7Cdaniel.baluta%40nxp.com%7C25ac869cfd1040f1be1708d9a2bd3460%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637719755777370422%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=E4K2DPkpLX2SgVJ1K99Qs3uz7l7mS96gIzYlJw9akbg%3D&amp;reserved=0,
>>> where we changed the Kconfigs for i.MX. We haven't sent this update
>>> upstream for some reason.
>>>
>>> Arnd, can you share the configuration that breaks with the existing
>>> upstream code, I can check if the problem still exists.
> 
> https://pastebin.com/6JqM6Gkr

Ack, the problem still exists and is fixed by this patch

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


On a related note, with this randconfig we have a separate problem on an
AMD patch on the SOF tree

ERROR: modpost: "snd_amd_acp_find_config"
[sound/soc/amd/snd-acp-config] is a static EXPORT_SYMBOL

That wasn't detected earlier, any idea what Kconfig option I need to
enable to filter this out?
