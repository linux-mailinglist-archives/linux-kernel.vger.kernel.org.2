Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B03F2E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbhHTOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbhHTOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:44:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DBC061756
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 07:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=xGFbl2uZTEy0EpezAMk2wpGgS4j0k7wV10mN9c0Qz7E=; b=Af5XQnWsLPo71t9MoOv9U85xTo
        P26GNoILOiVBipg5SNn9ZFzrqwqryhSBDQLWzKD6FbmkRotvLy/A0VEItnwIoso9UhUL8zILD8QvN
        pBHM/12o8rcFBjYUzrOlwD999Q9QeVHt+YLiBBP9kl3wLvf3hzsJiedXsXAG6Zg8unJBYMsC25PhM
        8mxjSK1Dqqbzyo106YK2uza17k3bmR7KEF/fEDPoGY/MhgSatak7DhqYA1KM3vQoXzFuA/fzyPgP5
        dTRCfbaPtGKcscV9p8ZX9NmEEjo/pVr5cf1iEFwmzqyVOH/gpWzk7ty55o0opXqzsU+0o1ToOy7qw
        Y23kdmDA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH5jy-00BPRq-UA; Fri, 20 Aug 2021 14:43:27 +0000
Subject: Re: HDA codec problem
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
References: <12bbf54b-3ef6-8fa8-37fc-5f1e8d134bba@infradead.org>
 <s5hfsv48vk8.wl-tiwai@suse.de>
 <12443ca6-99dd-aea3-c35b-4c68ad0e0b31@infradead.org>
 <s5hczq86wac.wl-tiwai@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <775793c5-979a-169b-3634-e08e62284b36@infradead.org>
Date:   Fri, 20 Aug 2021 07:43:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <s5hczq86wac.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 7:11 AM, Takashi Iwai wrote:
> On Fri, 20 Aug 2021 15:54:51 +0200,
> Randy Dunlap wrote:
>>
>> On 8/19/21 11:44 PM, Takashi Iwai wrote:
>>> On Fri, 20 Aug 2021 07:08:34 +0200,
>>> Randy Dunlap wrote:
>>>>
>>>> Hi,
>>>>
>>>> I am having problems getting audio working on my computer:
>>>>
>>>> 00:1f.3 Audio device: Intel Corporation Device f1c8
>>>>
>>>> I did an internet search that said that I would need 5.13 or later to
>>>> have support for this device.
>>>
>>> The above is Cometlake-H, and it pretty much depends on the machine
>>> configuration.
>>>
>>>> openSUSE 15.3 kernel 5.3.18-59.19-default says:
>>>>
>>>> snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC233: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
>>>> snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>>>> snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
>>>> snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
>>>> snd_hda_codec_realtek hdaudioC0D0:    inputs:
>>>> snd_hda_codec_realtek hdaudioC0D0:      Mic=0x1a
>>>> snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
>>>>
>>>> but produces no sound output.
>>>
>>> FWIW, openSUSE Leap 15.3 kernel is based on 5.3 but got tons of
>>> backports, hence its HD-audio part is almost equivalent with 5.13 or
>>> later kernel (except for the recently changed mute-LED handling --
>>> which must be irrelevant with your problem).
>>>
>>> The above indicates that the codec is detected and set up.  The rest
>>> part is often some vendor-specific quirks.  For that, details are
>>> missing completely.  At best please give alsa-info.sh output (run the
>>> script with --no-upload and attach the output).
>>>
>>
>> Oh, of course. Now attached.
> 
> I see that the Headphone mixer switch is off by some reason.
> But it should have been toggled by PulseAudio.
> 
> You can test like:
>    amixer -c0 set "Headphone" unmute

Simple mixer control 'Headphone',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 87
   Mono:
   Front Left: Playback 87 [100%] [0.00dB] [on]
   Front Right: Playback 87 [100%] [0.00dB] [on]


> Also, just to be sure: did you install both pulseaudio and pipewire?
> They may conflict.

Yes. pipewire is now gone.

Still no sound but I might need to restart...

Thanks!

-- 
~Randy

