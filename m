Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141F731540F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhBIQh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232810AbhBIQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612888494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WE5mpi7ygmfeed8LxkrTimbUCAkDMTPfX6TbCxa66yE=;
        b=bPHim6+C5yoPrMKtu4Cjo7257R0AFgN33kHw6+7TfbcjOcS836Li6oi+ONbS3JpUS0JbnE
        iiUrklzYc0ZRjVz2QPUy31NyxtfCFEQVHgaeGZa0yykaRruEoYBhmBwl68vNN0brJbNbj4
        dNsOKHipjCgOwEWd7HKsew/JnHxCK6M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-gtxOZBVANAar3QkcD8FWhQ-1; Tue, 09 Feb 2021 11:34:51 -0500
X-MC-Unique: gtxOZBVANAar3QkcD8FWhQ-1
Received: by mail-ed1-f72.google.com with SMTP id l23so16108373edt.23
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WE5mpi7ygmfeed8LxkrTimbUCAkDMTPfX6TbCxa66yE=;
        b=e8kEg3e6744tZYEN9h12aoe2j+M35D2tw1ZSavV5Ph7qUYauaQxdsU1+5EVlXcucPJ
         kjflShvevlkoXAK3GVQJHou4rMjxAC5BhI8wdKBxNo7nkamLv8dVeW9hdEvVqdQ6ILKo
         1oFk782ZSExC4bpj/nJvWawy3/drsHm01I33W9imTJIP/Xd8HPRda8024YPDlwICYSTm
         QXNCMIsN1L5VJSccRK8jFop+p8KPN1qFkgM8WM+zTkgqmzEZubxHvYnh6cKiwLSF0dPD
         tAkBVQLW12gJawMGYVyjiV/fMAY3NORHbBVNcbi+YcsccehHj17IlwOnrU2dCCCNi+Xt
         fRxw==
X-Gm-Message-State: AOAM532927FmLuk2rO0i4wNMG5Pu4u6njj58M9Y0Gs37LonbNTsYyryd
        fkNfqhIz4lDXmpPOhFInvohYrmYjo5LM1KHMRiuGmjBMMeFkCAtKxXroG0LcMz9iHpzKP38Ofx0
        +j0x53AcyGRfkDE9TocA7nWx6
X-Received: by 2002:a17:906:2495:: with SMTP id e21mr23111088ejb.280.1612888489380;
        Tue, 09 Feb 2021 08:34:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXQ2QXB9+9Mhzc58vdMVhJmHOiv2EQfnoI6xpqFh6KzkipbxXAk7ZgiV4CUMW+PsiRlSPbXg==
X-Received: by 2002:a17:906:2495:: with SMTP id e21mr23110989ejb.280.1612888488386;
        Tue, 09 Feb 2021 08:34:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d3sm4215537edk.82.2021.02.09.08.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 08:34:47 -0800 (PST)
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210204112502.88362-1-hdegoede@redhat.com>
 <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
 <20210209141420.GE4766@dell>
 <c0b4c612-7f60-5126-4c4d-b7085bd356d0@redhat.com>
 <20210209154511.GC220368@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <80068116-eb04-fd75-f656-804ab9f5d414@redhat.com>
Date:   Tue, 9 Feb 2021 17:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209154511.GC220368@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/9/21 4:45 PM, Lee Jones wrote:
> On Tue, 09 Feb 2021, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 2/9/21 3:14 PM, Lee Jones wrote:
>>> On Mon, 08 Feb 2021, Hans de Goede wrote:
>>>
>>>> Hi Mark, Lee,
>>>>
>>>> On 2/4/21 12:24 PM, Hans de Goede wrote:
>>>>> Hi all,
>>>>>
>>>>> Here is v4 of my series to rework the arizona codec jack-detect support
>>>>> to use the snd_soc_jack helpers instead of direct extcon reporting.
>>>>>
>>>>> This is a resend with some extra *-by tags collected and with the extcon
>>>>> folks added to the "To:" list, which I somehow missed with the original
>>>>> v4 posting, sorry.
>>>>>
>>>>> This is done by reworking the extcon driver into an arizona-jackdet
>>>>> library and then modifying the codec drivers to use that directly,
>>>>> replacing the old separate extcon child-devices and extcon-driver.
>>>>>
>>>>> This brings the arizona-codec jack-detect handling inline with how
>>>>> all other ASoC codec driver do this. This was developed and tested on
>>>>> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
>>>>>
>>>>> This was also tested by Charles Keepax, one of the Cirrus Codec folks.
>>>>>
>>>>> This depends on the previously posted "[PATCH v4 0/5] MFD/ASoC: Add
>>>>> support for Intel Bay Trail boards with WM5102 codec" series and there
>>>>> are various interdependencies between the patches in this series.
>>>>>
>>>>> Lee Jones, the MFD maintainer has agreed to take this series upstream
>>>>> through the MFD tree and to provide an immutable branch for the ASoC
>>>>> and extcon subsystems to merge.
>>>>>
>>>>> Mark and extcon-maintainers may we have your ack for merging these
>>>>> through the MFD tree ?
>>>>
>>>> Now that the pre-cursor (1) series to this has been merged, I guess it
>>>> is time to decide how to merge this series. 
>>>>
>>>> Chanwoo Choi has given his ack to merge the extcon bits through the MFD
>>>> tree and since Mark has expressed a preference for merging ASOC patches
>>>> directly I guess that it would be best to merge 1-6 through the MFD
>>>> tree and then Lee can send Mark a pull-req and Mark can apply the others? :
>>>>
>>>> 1/13  mfd: arizona: Drop arizona-extcon cells
>>>> 2/13  extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
>>>> 3/13  extcon: arizona: Fix various races on driver unbind
>>>> 4/13  extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
>>>> 5/13  extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
>>>> 6/14  ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c
>>>>
>>>> 1 is:    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>> 2-6 are: Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>> Note patch 6 renames drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c
>>>> but it does not touch any other files under sound/soc (including NOT touching
>>>> sound/soc/codecs/Makefile that is done in a later patch). So it cannot cause any
>>>> conflicts.
>>>>
>>>> Mark, would merging 1-6 through the MFD tree, and you applying the rest
>>>> (which are all ASoC patches) work for you ?
>>>
>>> What a faff.
>>>
>>> I still don't see why they can't all go in and a PR provided.
>>
>> Well patch 13/13 of this set relies on 5/5 from the previous set which is
>> only in Mark's ASoC tree and not in the MFD tree, so splitting things over MFD + ASoC
>> again makes the most sense here too.
> 
> Right, this is what can happen when patch-sets are split up.
> 
>> The alternative is Mark doing a PR from ASoC to MFD to get 5/5 from the previous set
>> in MFD first, which seems less then ideal.
> 
> Well this set isn't likely to go in this cycle anyway, so actually the
> problem should just go away.

That is true.

> Best to let the first set get sucked
> into v5.12, then send this one up subsequently for v5.13.

Ack. So should I resend this once 5.12-rc1 is out ?

Regards,

Hans

