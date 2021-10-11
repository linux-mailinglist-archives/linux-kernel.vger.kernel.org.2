Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A08429921
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhJKVuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:50:52 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53995 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJKVuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:50:51 -0400
Received: (Authenticated sender: didi.debian@cknow.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPA id AB6031C0002;
        Mon, 11 Oct 2021 21:48:48 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 11 Oct 2021 23:48:48 +0200
From:   didi.debian@cknow.org
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
In-Reply-To: <f7efde11-067d-8822-45fa-7cdbe2d17d93@perex.cz>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org> <4974503.Y8KB3sNASq@bagend>
 <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz> <5069869.zQgEQKRxDW@bagend>
 <f7efde11-067d-8822-45fa-7cdbe2d17d93@perex.cz>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <97a1c38c48765fb6634de34387e3ce3c@cknow.org>
X-Sender: didi.debian@cknow.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-11 19:16, Jaroslav Kysela wrote:
> On 10. 10. 21 12:40, Diederik de Haas wrote:
>> On Sunday, 10 October 2021 10:40:09 CEST Jaroslav Kysela wrote:
>>>> Unfortunately this change broke multichannel audio on my Rock64 
>>>> device
>>>> running Debian. My Rock64 is connected to my AVR (Pioneer SC-1224) 
>>>> via a
>>>> HDMI cable.
>>> This looks like an user space configuration problem.
>> 
>> I have placed ALSA card definitions (I think) from LibreELEC on my 
>> system from
>> https://github.com/LibreELEC/LibreELEC.tv/tree/master/projects/Rockchip/
>> filesystem/usr/share/alsa/cards
> 
> Apparently, the alsa-lib configuration is used in this case.
> 
> It seems that there are four sound cards (Analog/HDMI/I2S/SPDIF)
> created for your hardware. The alsa-lib configuration is a bit weird -
> an obfuscation for the simple-card driver use. The simple way to
> resolve this is to create a proper UCM configuration.
> 
> If you need further assistance, create an issue for alsa-lib or
> alsa-ucm-conf on github and with an output from the 'alsa-info.sh'
> script.

Will do.

FTR: It's now working again for me on a kernel with this patch included:
https://github.com/LibreELEC/LibreELEC.tv/issues/5734#issuecomment-940088156

I have no idea whether this is a proper solution or another 
'workaround', but
it's working for me again :)

Thanks for your help.

Diederik
