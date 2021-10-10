Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54D42801A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhJJIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:50:43 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41304 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbhJJIum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:50:42 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Oct 2021 04:50:41 EDT
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6BE4AA003F;
        Sun, 10 Oct 2021 10:40:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6BE4AA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1633855221; bh=jEddCVVyEM6hfDJAIIp/JF0rfCtaB9zR3MuC9Qro148=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=wKG6TDVhlblRcRd0f6VGjJyJlnjhQAmYlYNXqC/D15yntOn9n+tTwxJ2bioo55qGe
         jzz2CGbAPmQokinVBhrSwy3VjSGDJKkwrDIbIeH+PmRov5Rk2QO31XxKIp9uqp7MRV
         vLs+n2Oj0tfHRT/CZDNNgBNwd8huSrXKxg3dQJRc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Sun, 10 Oct 2021 10:40:10 +0200 (CEST)
Message-ID: <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz>
Date:   Sun, 10 Oct 2021 10:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Content-Language: en-US
To:     Diederik de Haas <didi.debian@cknow.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org> <4974503.Y8KB3sNASq@bagend>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <4974503.Y8KB3sNASq@bagend>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 10. 21 9:47, Diederik de Haas wrote:
> On Tuesday, 22 June 2021 10:27:09 CEST Guido Günther wrote:
>> alsa-ucm groups by driver name so fill that in as well. Otherwise the
>> presented information is redundant and doesn't reflect the used
>> driver. We can't just use 'asoc-simple-card' since the driver name is
>> restricted to 15 characters.
>>
>> Before:
>>
>>   # cat /proc/asound/cards
>>   0 [Devkit         ]: Librem_5_Devkit - Librem 5 Devkit
>>                        Librem 5 Devkit
>> After:
>>
>>   0 [Devkit         ]: simple-card - Librem 5 Devkit
>>                        Librem 5 Devkit
>>
>> Signed-off-by: Guido GÃ¼nther <agx@sigxcpu.org>
>> ---
>> This came out of a discussion about adding alsa-ucm profiles for the
>> Librem 5 Devkit at https://github.com/alsa-project/alsa-ucm-conf/pull/102
>>
>>   sound/soc/generic/simple-card.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/generic/simple-card.c
>> b/sound/soc/generic/simple-card.c index 0015f534d42d..a3a7990b5cb6 100644
>> --- a/sound/soc/generic/simple-card.c
>> +++ b/sound/soc/generic/simple-card.c
>> @@ -621,6 +621,7 @@ static int asoc_simple_probe(struct platform_device
>> *pdev) card->owner		= THIS_MODULE;
>>   	card->dev		= dev;
>>   	card->probe		= simple_soc_probe;
>> +	card->driver_name       = "simple-card";
>>
>>   	li = devm_kzalloc(dev, sizeof(*li), GFP_KERNEL);
>>   	if (!li)
> 
> Unfortunately this change broke multichannel audio on my Rock64 device running
> Debian. My Rock64 is connected to my AVR (Pioneer SC-1224) via a HDMI cable.

This looks like an user space configuration problem. You should check, if a PA 
profile or an UCM configuration is used (in the PA debug log).

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
