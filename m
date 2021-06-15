Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A361C3A7DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFOMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:08:38 -0400
Received: from phobos.denx.de ([85.214.62.61]:53924 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFOMIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:08:37 -0400
Received: from [10.88.0.186] (dslb-084-062-104-230.084.062.pools.vodafone-ip.de [84.62.104.230])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ch@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 21FAD81249;
        Tue, 15 Jun 2021 14:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623758791;
        bh=dWaYxNZ7Ro9xr/pNtB1Q08hiDs2nyh+0Dls0ENGlbRs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wePmA+OF/i3IITNVBaahj2vBUdygQswycdQHdo6wNsv8QQZOdoVDbVNIIXS1IaTSp
         unfn5UOCllYXnrLUjilB5CUonIU5saosGc1hLsvxCnvUrbhG8R0sqd3qeV9a1XX2Xr
         kBvCYBvb8dESS22C4IRoBLQO/whP9JkvmnYvngCutMkgmECxP2qRqDTXa3VWiq/Y3x
         irnq3zwamU9psotPDU91/0s5/d5hjW42HQV51N9UpMGDwocKDP2xU7bS8RLAtXdHjl
         1tbiGHIvB2Xnvww7SPiP8DknBA1JvkO6ma04M1h7oaTpkfDSIwab41Dwkq/jvQ6YoB
         g3r1+yRIZZUng==
Subject: Re: [PATCH 1/3] ASoC: tlv320aic32x4: prepare driver for different
 device variants
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Marek Vasut <marex@denx.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210615094933.3076392-1-ch@denx.de>
 <20210615094933.3076392-2-ch@denx.de> <20210615115438.GD5149@sirena.org.uk>
From:   Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <32b82dae-45ea-c6d4-77b7-c8a234cbf803@denx.de>
Date:   Tue, 15 Jun 2021 14:06:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210615115438.GD5149@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2021-06-15 13:54, Mark Brown wrote:
> On Tue, Jun 15, 2021 at 11:49:30AM +0200, Claudius Heine wrote:
> 
>> With this change it will be possible to add different code paths for
>> similar devices.
> 
>>   static const struct i2c_device_id aic32x4_i2c_id[] = {
>> -	{ "tlv320aic32x4", 0 },
>> -	{ "tlv320aic32x6", 1 },
>> +	{ "tlv320aic32x4", (kernel_ulong_t)AIC32X4_TYPE_AIC32X4 },
>> +	{ "tlv320aic32x6", (kernel_ulong_t)AIC32X4_TYPE_AIC32X6 },
>>   	{ /* sentinel */ }
> 
> It appears that the device already supports multiple variants?

Those values aren't used anywhere as far as I can see.

regards,
Claudius
