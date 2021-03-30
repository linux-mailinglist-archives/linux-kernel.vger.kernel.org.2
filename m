Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8BA34EDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhC3Q1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:27:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:21512 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhC3Q1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:27:36 -0400
IronPort-SDR: oeUD/7vDc0Fji0gvMLnRLd6nPR8LREAu5oIR2YyGOkl3LlgsCN5Qqg2N7Q5V7ZEGJIn1w6WBYm
 PlLIRZYQakcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191278483"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191278483"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 09:27:36 -0700
IronPort-SDR: rALFS58bsnZc5hncT56uEWexYkHiT78FgWZUhcfa6HK7mP//UDKSJXPUBuGq7qT1R5wnbu5fVl
 178aX246NBfg==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="455091940"
Received: from leekevi1-mobl.amr.corp.intel.com (HELO [10.209.2.33]) ([10.209.2.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 09:27:34 -0700
Subject: Re: [PATCH] ASoC: amd: Add support for ALC1015P codec in acp3x
 machine driver
To:     Mark Brown <broonie@kernel.org>,
        "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, shumingf@realtek.com,
        flove@realtek.com, kent_chen@realtek.com, jack.yu@realtek.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1617095628-8324-1-git-send-email-Vijendar.Mukunda@amd.com>
 <82817878-a30d-2b0c-07f8-48bcca3ebc80@linux.intel.com>
 <a55c7a75-22ab-31fc-81b3-ed8fa24027f4@amd.com>
 <20210330153534.GF4976@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cd0d87e0-caa5-b671-9c91-1c5f35c2f017@linux.intel.com>
Date:   Tue, 30 Mar 2021 11:27:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330153534.GF4976@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/21 10:35 AM, Mark Brown wrote:
> On Tue, Mar 30, 2021 at 09:12:11PM +0530, Mukunda,Vijendar wrote:
>> On 3/30/21 7:52 PM, Pierre-Louis Bossart wrote:
> 
>>>>    static const struct acpi_device_id acp3x_audio_acpi_match[] = {
>>>>        { "AMDI5682", (unsigned long)&acp3x_5682},
>>>>        { "AMDI1015", (unsigned long)&acp3x_1015},
>>>> +    { "AMDP1015", (unsigned long)&acp3x_1015p},
> 
>>> This isn't a valid ACPI ID. AMDP does not exist in
> 
> ...
> 
>>> There was a similar issue with Intel platforms using this part, we had
>>> to use a different HID.
> 
>> Is it okay if i use "AMDI1016" for ALC1015P?
> 
> That's valid, though obviously you might regret that later on if someone
> releases a CODEC with a 1016 name (equally well ACPI being what it is
> there's no good options for naming).

wish granted, the 1016 already exists :-)
you may want to align with what we did for Intel and use the same HID: 
RTL1015
