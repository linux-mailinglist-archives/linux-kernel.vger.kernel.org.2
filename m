Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976F630C6DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbhBBRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbhBBQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:57:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66C1C06174A;
        Tue,  2 Feb 2021 08:57:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q12so28950175lfo.12;
        Tue, 02 Feb 2021 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nwpPlS9MjT737XxxcrUZtECdOnIxemsu+NrondIvc+8=;
        b=lbpqq56s6LvejvAeOwCQmGbMeFB+iKVoCg4snZ1Ev8Jqxtb3K9240iD4L17QHxadTO
         XMIgeiSMoq+oGmO78p/lVO4YlEkfbu87ioa/GOgsE+K3ye98v3fPQgpffsAoDPlCw6kd
         BUHwJHWM6etsUBjZenEmUzMbl1wwTsbL7ZVHzLQtfod9chYgEi+wEkijo8bMAW5TC3Eh
         w9RCVQ4bdAfz3YeGlI2Yv39d1vtO2ZeipPdSURbWrloWKK/aNANcJYm57Q+dK33JaHoK
         F4tJerPMfNMwQtFBlY0A2Utuj6dHxabR8wTYAbWF/vciPB/skI+UE43D/cG8IiuKzI6C
         MDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nwpPlS9MjT737XxxcrUZtECdOnIxemsu+NrondIvc+8=;
        b=Bm6Yy4WL6WGBioJA578bL2X+JZlfus8pMtLqot9jbCJIi3PxODlUK+/9No/b2Cpp2j
         hbbBfhxw89rAVdE5qmWwA2+304ZXCsSCeyEfyJ3wBZdi/JUjE1q/OnTn1H0qwqpY4Fl/
         8bs/vjyfNLSFOwkRLkQLV6LppYKK2spcFosGfRlMVywLAIEkqw2aDzdQKGR+FBzkqOqz
         dwy9N6Qhb429yjwwp84IGGM66FUcSEdk1dci/rB0/pB0dvRK+okI1VBPlkUdZNd35aNW
         578sYty7irxn90X4NlmPoK32rwy06Z1BR42BCvQyU+0nhKIxO9745vcr9f2DOinHf9Vv
         KrFA==
X-Gm-Message-State: AOAM530ibPnXilql1vZUqSJCstBZoDDfbmsFqEjft+60wvAU5QTEdava
        hV4Sl08kOUB+WO6tS9mRuFLAEh+9xAc=
X-Google-Smtp-Source: ABdhPJylGmwbmiAU0xzI+fDP1qXJu7D4drYkzhizCth3IZP0qIWWEH8U+ZpYlF3q69KQJEaXekafWw==
X-Received: by 2002:a19:e43:: with SMTP id 64mr11085733lfo.642.1612285063231;
        Tue, 02 Feb 2021 08:57:43 -0800 (PST)
Received: from ?IPv6:2a00:1370:814d:ea25:a10:76ff:fe69:21b6? ([2a00:1370:814d:ea25:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id c6sm3366314lfc.11.2021.02.02.08.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 08:57:42 -0800 (PST)
Subject: Re: [PATCH v1 2/2] ASoC: tegra: Add RT5631 machine driver
To:     Jon Hunter <jonathanh@nvidia.com>, Ion Agorria <AG0RRIA@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ion Agorria <ion@agorria.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210131184101.651486-1-AG0RRIA@yahoo.com>
 <20210131184101.651486-3-AG0RRIA@yahoo.com>
 <7f4eb8f7-215e-ab3d-fcef-9243037cf246@nvidia.com>
 <8d0bc6f3-45ce-565d-d80f-b50fb75e7c55@gmail.com>
 <51571ec9-780b-ba71-c81d-dd01ebcefbb8@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fc0d7a20-f5ef-e8b4-6be8-ac9879399023@gmail.com>
Date:   Tue, 2 Feb 2021 19:57:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <51571ec9-780b-ba71-c81d-dd01ebcefbb8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.02.2021 19:24, Jon Hunter пишет:
> 
> On 02/02/2021 15:25, Dmitry Osipenko wrote:
>> 02.02.2021 16:22, Jon Hunter пишет:
>>> So this is very similar to tegra_rt5677, is it not possible to support
>>> both codecs with the same machine driver?
>>
>> These codecs require individual configurations and those
>> "../codecs/rt5631.h" and  "../codecs/rt5677.h" aren't compatible at a
>> quick glance.
> 
> Right but not all of that is needed. What is actually needed from the
> header files?

I recall that some downstream drivers were doing some special
programming of codecs. This is not relevant to the current upstream
drivers, but potentially it may become needed and then that single
driver could become unmanageable.

>> The tegra_rt5677 also uses outdated GPIO API and etc. Hence the new
>> driver should be a better base anyways.
> 
> Sounds like a good time to update it :-)
> 
>> Overall it shouldn't worth time and effort trying to squeeze these
>> drivers into a single one, IMO.
> 
> Not sure I agree when these drivers appear to be 90% the same.

Of course we could try, but I suggest that it should be done separately
from this series. Certainly it will take a lot of extra effort and this
series isn't about improving older drivers, it's about enabling h/w
support for the RT5631 codec.

It shouldn't be a problem to switch to the common machine driver later
on if this driver will turn out to be feasible.
