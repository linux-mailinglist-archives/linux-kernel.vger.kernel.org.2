Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE4429567
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhJKRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:18:53 -0400
Received: from mail1.perex.cz ([77.48.224.245]:57352 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232866AbhJKRSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:18:52 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C4DE4A003F;
        Mon, 11 Oct 2021 19:16:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C4DE4A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1633972608; bh=QRB5Ou1NGnbNid6JFfjU38Lss1F7V2ixqJfm4FYhiPw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=fug/BqNlw3eZvAAw/uX5lfGAXUi44nPGHYrG4qmeeATh2kPPfZbkaQnzADYiZJdzm
         dN0/vLBA2laqK9wQ91k+H418whIm8nHiZDfqZZ5suqFTofU4xR5ENi9EWqQVFBfqSs
         iTc6bj2Od87GNb6vlkXD6CCmpY1XUGXWJZwEk8vA=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 11 Oct 2021 19:16:37 +0200 (CEST)
Message-ID: <f7efde11-067d-8822-45fa-7cdbe2d17d93@perex.cz>
Date:   Mon, 11 Oct 2021 19:16:37 +0200
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
 <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz> <5069869.zQgEQKRxDW@bagend>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <5069869.zQgEQKRxDW@bagend>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 10. 21 12:40, Diederik de Haas wrote:
> On Sunday, 10 October 2021 10:40:09 CEST Jaroslav Kysela wrote:
>>> Unfortunately this change broke multichannel audio on my Rock64 device
>>> running Debian. My Rock64 is connected to my AVR (Pioneer SC-1224) via a
>>> HDMI cable.
>> This looks like an user space configuration problem.
> 
> I have placed ALSA card definitions (I think) from LibreELEC on my system from
> https://github.com/LibreELEC/LibreELEC.tv/tree/master/projects/Rockchip/
> filesystem/usr/share/alsa/cards

Apparently, the alsa-lib configuration is used in this case.

It seems that there are four sound cards (Analog/HDMI/I2S/SPDIF) created for 
your hardware. The alsa-lib configuration is a bit weird - an obfuscation for 
the simple-card driver use. The simple way to resolve this is to create a 
proper UCM configuration.

If you need further assistance, create an issue for alsa-lib or alsa-ucm-conf 
on github and with an output from the 'alsa-info.sh' script.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
