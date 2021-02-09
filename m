Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41011315219
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhBIOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbhBIOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612882338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZurZ2p+Oz9T6fAZtfH5OfgZcCPb/XCukhWZRZD790Y=;
        b=JmrNig7mCItZLUaqnIJahB9E13I8SlcM7r6xQ72iD1w0Ok8Qr2uhjEm0inK8GaCm0sNpB/
        j1TseR38qZCJld9KC0+faypOBC8bKUKGqy43vLTW4snVwXRKx7K3RNWw87/W4bQNMpfiwr
        qtu5Yvf7nwXpiW0py7IIcOYXPmh6haw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-px8sYOy3Peas_J-ZmljrTQ-1; Tue, 09 Feb 2021 09:52:16 -0500
X-MC-Unique: px8sYOy3Peas_J-ZmljrTQ-1
Received: by mail-ej1-f72.google.com with SMTP id q11so15957751ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZZurZ2p+Oz9T6fAZtfH5OfgZcCPb/XCukhWZRZD790Y=;
        b=i7fWG2szdduatbFogUs490aAkQ7hjRpS1eNxggApASTlyF6yZD28DlUEBrCbKY/ZFM
         S+xAT2/sP4CLVLy71vCEyjJ/cvkhNMFECWaDB0MvzgjZsRhJthxsygxtO7NNnVNszAN9
         EE4hZ0bYVrn72cnTqeyWqu1bbsCklbQF0YQCFyzgUaPiWwo0cqyocGfW/cxJhsPspNAF
         OUVkI109mpe6190+yTvgoDi3R1MlAlpDHEe7lQ6npyS3CHVZ0os4NhGBz0M1ikUehPCo
         WMxppqQC0knhnqsAvFk1tnMDzU+5ks6J/aDzlMum7eJ1KUiam4L9ICueDdscVvnWrIs0
         qAmQ==
X-Gm-Message-State: AOAM532y34VqD5sCfLWA2nSOrFw0nRhl/2421CqKt0misdlSb9GG6/Cf
        afImfhjeeRiZqf3b0glla8UcNNtRaAs3fAL+6Hwrfu+GkFshIwqLbPYJvo70y3UnCC2am+UZBaU
        XqP775DeRlJK/GLOOJ3hJyd1m
X-Received: by 2002:a17:906:5857:: with SMTP id h23mr22033007ejs.465.1612882335651;
        Tue, 09 Feb 2021 06:52:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnZEri6RLCqyJIJnLPm/wgV4KEeFSCkri4avV84ph/v41CgyK2i5cF+/z4p5qQPyfEYe+QTA==
X-Received: by 2002:a17:906:5857:: with SMTP id h23mr22032955ejs.465.1612882335165;
        Tue, 09 Feb 2021 06:52:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bm2sm10658168ejb.87.2021.02.09.06.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:52:14 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c0b4c612-7f60-5126-4c4d-b7085bd356d0@redhat.com>
Date:   Tue, 9 Feb 2021 15:52:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209141420.GE4766@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/9/21 3:14 PM, Lee Jones wrote:
> On Mon, 08 Feb 2021, Hans de Goede wrote:
> 
>> Hi Mark, Lee,
>>
>> On 2/4/21 12:24 PM, Hans de Goede wrote:
>>> Hi all,
>>>
>>> Here is v4 of my series to rework the arizona codec jack-detect support
>>> to use the snd_soc_jack helpers instead of direct extcon reporting.
>>>
>>> This is a resend with some extra *-by tags collected and with the extcon
>>> folks added to the "To:" list, which I somehow missed with the original
>>> v4 posting, sorry.
>>>
>>> This is done by reworking the extcon driver into an arizona-jackdet
>>> library and then modifying the codec drivers to use that directly,
>>> replacing the old separate extcon child-devices and extcon-driver.
>>>
>>> This brings the arizona-codec jack-detect handling inline with how
>>> all other ASoC codec driver do this. This was developed and tested on
>>> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
>>>
>>> This was also tested by Charles Keepax, one of the Cirrus Codec folks.
>>>
>>> This depends on the previously posted "[PATCH v4 0/5] MFD/ASoC: Add
>>> support for Intel Bay Trail boards with WM5102 codec" series and there
>>> are various interdependencies between the patches in this series.
>>>
>>> Lee Jones, the MFD maintainer has agreed to take this series upstream
>>> through the MFD tree and to provide an immutable branch for the ASoC
>>> and extcon subsystems to merge.
>>>
>>> Mark and extcon-maintainers may we have your ack for merging these
>>> through the MFD tree ?
>>
>> Now that the pre-cursor (1) series to this has been merged, I guess it
>> is time to decide how to merge this series. 
>>
>> Chanwoo Choi has given his ack to merge the extcon bits through the MFD
>> tree and since Mark has expressed a preference for merging ASOC patches
>> directly I guess that it would be best to merge 1-6 through the MFD
>> tree and then Lee can send Mark a pull-req and Mark can apply the others? :
>>
>> 1/13  mfd: arizona: Drop arizona-extcon cells
>> 2/13  extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
>> 3/13  extcon: arizona: Fix various races on driver unbind
>> 4/13  extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
>> 5/13  extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
>> 6/14  ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c
>>
>> 1 is:    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>> 2-6 are: Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Note patch 6 renames drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c
>> but it does not touch any other files under sound/soc (including NOT touching
>> sound/soc/codecs/Makefile that is done in a later patch). So it cannot cause any
>> conflicts.
>>
>> Mark, would merging 1-6 through the MFD tree, and you applying the rest
>> (which are all ASoC patches) work for you ?
> 
> What a faff.
> 
> I still don't see why they can't all go in and a PR provided.

Well patch 13/13 of this set relies on 5/5 from the previous set which is
only in Mark's ASoC tree and not in the MFD tree, so splitting things over MFD + ASoC
again makes the most sense here too.

The alternative is Mark doing a PR from ASoC to MFD to get 5/5 from the previous set
in MFD first, which seems less then ideal.

Regards,

Hans

