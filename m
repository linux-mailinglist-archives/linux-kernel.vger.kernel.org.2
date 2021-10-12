Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EF0429E50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhJLHLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:11:37 -0400
Received: from mail1.perex.cz ([77.48.224.245]:36330 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233456AbhJLHLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:11:36 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 93D58A003F;
        Tue, 12 Oct 2021 09:09:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 93D58A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1634022573; bh=MCKswC9dfx4z8lMqYYZ+iA/guE0ZI+EWy0JeZqlKWRg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KdgpgBni8FQ8qf00KE9jd6F/lFFE4gBL/deP4Gzk7btbCektMaADrYppYboQ0kWUH
         qpplY4C6k6A4bE615Q4s1ZOGDqE9skTxDMlPtBn8eVHwUDZ7PVJ6yeXG1cTCJF/Bn5
         j81zXmnFi1sB3RRSHiFqhuGUHdOs/np/CqimKvsc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 12 Oct 2021 09:09:29 +0200 (CEST)
Message-ID: <22cb5c18-9c92-7365-99a5-e0577e243fa2@perex.cz>
Date:   Tue, 12 Oct 2021 09:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Content-Language: en-US
To:     didi.debian@cknow.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org> <4974503.Y8KB3sNASq@bagend>
 <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz> <5069869.zQgEQKRxDW@bagend>
 <f7efde11-067d-8822-45fa-7cdbe2d17d93@perex.cz>
 <97a1c38c48765fb6634de34387e3ce3c@cknow.org>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <97a1c38c48765fb6634de34387e3ce3c@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 10. 21 23:48, didi.debian@cknow.org wrote:
> On 2021-10-11 19:16, Jaroslav Kysela wrote:
>> On 10. 10. 21 12:40, Diederik de Haas wrote:
>>> On Sunday, 10 October 2021 10:40:09 CEST Jaroslav Kysela wrote:
>>>>> Unfortunately this change broke multichannel audio on my Rock64
>>>>> device
>>>>> running Debian. My Rock64 is connected to my AVR (Pioneer SC-1224)
>>>>> via a
>>>>> HDMI cable.
>>>> This looks like an user space configuration problem.
>>>
>>> I have placed ALSA card definitions (I think) from LibreELEC on my
>>> system from
>>> https://github.com/LibreELEC/LibreELEC.tv/tree/master/projects/Rockchip/
>>> filesystem/usr/share/alsa/cards
>>
>> Apparently, the alsa-lib configuration is used in this case.
>>
>> It seems that there are four sound cards (Analog/HDMI/I2S/SPDIF)
>> created for your hardware. The alsa-lib configuration is a bit weird -
>> an obfuscation for the simple-card driver use. The simple way to
>> resolve this is to create a proper UCM configuration.
>>
>> If you need further assistance, create an issue for alsa-lib or
>> alsa-ucm-conf on github and with an output from the 'alsa-info.sh'
>> script.
> 
> Will do.
> 
> FTR: It's now working again for me on a kernel with this patch included:
> https://github.com/LibreELEC/LibreELEC.tv/issues/5734#issuecomment-940088156
> 
> I have no idea whether this is a proper solution or another
> 'workaround', but
> it's working for me again :)

The patch bellow resolved your issue - alsa-lib configuration fix. But it's 
not an universal solution and there may be clashes with other simple-card 
drivers in future.

https://github.com/LibreELEC/LibreELEC.tv/pull/5749/commits/f681a48a664bd0f0e8f0dc131bd58c5d7512adc3

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
