Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6334487A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhCVPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbhCVPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616425307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TeRLT206rXHXoXA6r2Hs7f1XgjJsdt/tFB50GF52SxQ=;
        b=L4L5TL3iJ3tSMOQ0ODjM5uCOMVHARw1oWGQS7KAtkUCruIBjvA0xaL2TD5Wnq7FzP1UGzm
        9Hh8YP6cXSlS8ZZjG/CXIUt8FsowiU1RmWBA/x+lw9w5gvFB91mFZZ7KEbpnjVb3qTsNto
        1y5sml6shGXmmzxDyLvWPbjNOPGNjBQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-8xEiY5WpPeK-cgFmkXp_bA-1; Mon, 22 Mar 2021 11:01:44 -0400
X-MC-Unique: 8xEiY5WpPeK-cgFmkXp_bA-1
Received: by mail-ed1-f72.google.com with SMTP id y10so15217786edr.20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TeRLT206rXHXoXA6r2Hs7f1XgjJsdt/tFB50GF52SxQ=;
        b=BskynzszkHhwd582M6fQ2N8H+gTZ6U1RrEEeShdQPnEIVwzlKG1CZZ4jXKkEMiQ3Y0
         XHvt0fpH7KRQItFxlx0EjG0o8E6gG9OzMvV2EPMADjtv1o9IfjFJKcg/h6n4YK4wjUYv
         c7pZ/MVVRTu+Nr8AmKnUq5/CYfAHXhi3mI07IHHz5SNH31IyptfG2oBKrE57Low9Nvti
         p/ebbF9CPA2AJD08PZNvEnphMzsv96PitE85nHXI7M6bB7nz14fFCTradrwrWavXVHuY
         KuZosIH49K7ffS4mm8aUVRUae+Iq1CQfWKjeNGEA899ChydhAubCV9OdvADmVEqvyBte
         yAgg==
X-Gm-Message-State: AOAM5334gwiG21qErrIE0n6MFbyl/hNcCJnohNtTCHeqIN4ly41aK+0T
        fVLB4MuqkNBIooSTQRt4tfAy5LMbb+bsLlgJEkYOjmFODRiPpAtIfsWqT2dzPpnTOKZ/itTN+kW
        7E4T2bHUbQzDQb0on2/TYJ5jI
X-Received: by 2002:a17:906:3395:: with SMTP id v21mr194804eja.322.1616425303019;
        Mon, 22 Mar 2021 08:01:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygJHx1ycHTtFDczgClQt4BcWFdt1OOvBVNQ2zk/+MtCfJ3F3mpKUaH3/gRSfpKT7IqYY77Ig==
X-Received: by 2002:a17:906:3395:: with SMTP id v21mr194782eja.322.1616425302868;
        Mon, 22 Mar 2021 08:01:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q16sm11812147edv.61.2021.03.22.08.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 08:01:42 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control supports
To:     Jaroslav Kysela <perex@perex.cz>,
        "Yuan, Perry" <Perry.Yuan@dell.com>,
        Mark Brown <broonie@kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     "pobrn@protonmail.com" <pobrn@protonmail.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20210301093834.19524-1-Perry_Yuan@Dell.com>
 <20210308172409.GF4656@sirena.org.uk>
 <SJ0PR19MB4528847687FEEE4A4DED8E3F84659@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <604693cc-08c7-2b5f-632a-58ed537c54a0@perex.cz>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5cad3045-7948-3282-c999-926095818d5f@redhat.com>
Date:   Mon, 22 Mar 2021 16:01:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <604693cc-08c7-2b5f-632a-58ed537c54a0@perex.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/21 3:37 PM, Jaroslav Kysela wrote:
> Dne 22. 03. 21 v 10:25 Yuan, Perry napsal(a):
>> Hi Mark:
>>
>>> -----Original Message-----
>>> From: Mark Brown <broonie@kernel.org>
>>> Sent: Tuesday, March 9, 2021 1:24 AM
>>> To: Yuan, Perry
>>> Cc: pobrn@protonmail.com; pierre-louis.bossart@linux.intel.com;
>>> oder_chiou@realtek.com; perex@perex.cz; tiwai@suse.com;
>>> hdegoede@redhat.com; mgross@linux.intel.com; Limonciello, Mario;
>>> lgirdwood@gmail.com; alsa-devel@alsa-project.org; linux-
>>> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
>>> Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control
>>> supports
>>>
>>> On Mon, Mar 01, 2021 at 05:38:34PM +0800, Perry Yuan wrote:
>>>
>>>> +	/* Micmute LED state changed by muted/unmute switch */
>>>> +	if (mc->invert) {
>>>> +		if (ucontrol->value.integer.value[0] || ucontrol-
>>>> value.integer.value[1]) {
>>>> +			micmute_led = LED_OFF;
>>>> +		} else {
>>>> +			micmute_led = LED_ON;
>>>> +		}
>>>> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
>>>> +	}
>>>
>>> These conditionals on inversion seem weird and counterintuitive.  If we're
>>> going with this approach it would probably be clearer to define a custom
>>> operation for the affected controls that wraps the standard one and adds the
>>> LED setting rather than keying off invert like this.
>>
>> Currently the sof soundwire driver has no generic led control yet.
>> This patch can handle the led control needs for MIC mute LED, definitely the patch is a short term solution.
>> There is a feature request discussion when we started to implement this solution.
>> https://github.com/thesofproject/linux/issues/2496#issuecomment-713892620
>>
>> The workable way for now is that we put the LED mute control to the codec driver.
>> When there is new and full sound LED solution implemented, this part will be also optimized.
>> The Hardware privacy feature needs this patch to handle the Mic mute led state change.
>> Before that full solution ready in kernel, could we take this as short term solution?
> 
> Perry, it's about the machine detection. Your code is too much generic even
> for the top-level LED trigger implementation. We need an extra check, if the
> proper LED's are really controlled on the specific hardware. Other hardware
> may use RT715 for a different purpose. Use DMI / ACPI checks to detect this
> hardware and don't misuse the inversion flag to enable this code.

I think this would be a goo candidate for the new generic LED handling:

https://lore.kernel.org/alsa-devel/20210317172945.842280-1-perex@perex.cz/

And then use a udev-rule + hwdb and/or UCM profiles to configure the LED trigger
for specific models from userspace ?

Regards,

Hans




