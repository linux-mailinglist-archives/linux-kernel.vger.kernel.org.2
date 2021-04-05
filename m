Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21483546F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhDETIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 15:08:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:52638 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhDETI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 15:08:27 -0400
IronPort-SDR: YGu8dfFuXkDypDAWteYxiivbyf8XDTaJITanwkLqZFfp8LfQK1gdnlpMMJL//7iktQUuFeSKbf
 rTmPaWhYO54g==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="254243640"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="254243640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 12:08:08 -0700
IronPort-SDR: VWi1JLsaZAVvlqpxRGMKsBvp7vRhCLW0BNV7GqwgsSiEF1Q1owbQdpqfXMGs2hcLW2cFMQOtE1
 D0ApP9YDiFnw==
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="420847777"
Received: from esiow1-mobl1.amr.corp.intel.com (HELO [10.212.57.118]) ([10.212.57.118])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 12:08:05 -0700
Subject: Re: [PATCH] ASoC: amd: Add support for ALC1015P codec in acp3x
 machine driver
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     jack.yu@realtek.com, alsa-devel@alsa-project.org,
        Sunil-kumar.Dommati@amd.com, kent_chen@realtek.com,
        Arnd Bergmann <arnd@arndb.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alexander.Deucher@amd.com, shumingf@realtek.com,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, flove@realtek.com,
        Akshu Agrawal <akshu.agrawal@amd.com>
References: <1617095628-8324-1-git-send-email-Vijendar.Mukunda@amd.com>
 <82817878-a30d-2b0c-07f8-48bcca3ebc80@linux.intel.com>
 <a55c7a75-22ab-31fc-81b3-ed8fa24027f4@amd.com>
 <20210330153534.GF4976@sirena.org.uk>
 <cd0d87e0-caa5-b671-9c91-1c5f35c2f017@linux.intel.com>
 <972d38d8-39c8-66d7-292d-37c1f0e027bd@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b330ca5e-1162-29c9-d846-fbfbd9db638f@linux.intel.com>
Date:   Mon, 5 Apr 2021 11:24:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <972d38d8-39c8-66d7-292d-37c1f0e027bd@amd.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>>>    static const struct acpi_device_id acp3x_audio_acpi_match[] = {
>>>>>>        { "AMDI5682", (unsigned long)&acp3x_5682},
>>>>>>        { "AMDI1015", (unsigned long)&acp3x_1015},
>>>>>> +    { "AMDP1015", (unsigned long)&acp3x_1015p},
>>>
>>>>> This isn't a valid ACPI ID. AMDP does not exist in
>>>
>>> ...
>>>
>>>>> There was a similar issue with Intel platforms using this part, we had
>>>>> to use a different HID.
>>>
>>>> Is it okay if i use "AMDI1016" for ALC1015P?
>>>
>>> That's valid, though obviously you might regret that later on if someone
>>> releases a CODEC with a 1016 name (equally well ACPI being what it is
>>> there's no good options for naming).
>>
>> wish granted, the 1016 already exists :-)
>> you may want to align with what we did for Intel and use the same HID: 
>> RTL1015
> 
> As per RTK team inputs, "RTL1015" ACPI HID is in use for RT1015p codec 
> driver.
> RTK team suggested us to use "RTL1015A" as ACPI HID.
> Let us know, if we can use "RTL1015A" as an ACPI HID?

Not if you want to be compliant. The part ID remains pegged to 4 hex 
digits, no matter what the vendor ID representation is.

The only solution I can suggest is using the PCI ID 0x1002, ie.

AMDI1015 -> AMD platform with RT1015
10021015 -> AMD platform with RT1015p

Note that it's not only ACPI's fault, other standards also only allow 
for 16 bits for part IDs, we'd have the same issue with SoundWire.
