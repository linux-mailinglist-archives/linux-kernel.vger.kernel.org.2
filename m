Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4315B415F04
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbhIWM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:59:21 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48422
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241170AbhIWM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:59:16 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95A483F22C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632401862;
        bh=mASWuX3flYB8leB5oLjas+ClwDRJkiZNw0C7JrzS2pY=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=lrrgLpLqKSjzdfc9JtuTrV7t6eVk81mwTE4dZTf8gAEcCnjmK4unRzE807NEdAVxn
         Hw3AdcnRIXVeeWx6sa8Km34lZPyDq/RJvOl/pgqld4yy2QOnAlSAi8cTZarzfgVes9
         hf+u1DZpiQhaMmLDnEPyV6cNeSzPZKbeTurUNfyA+LOj/MCAgAdulsPAySoWdEW/eX
         SiYV3ZjMpNc32imY3UsU120MQLqB3EhoC03d9reGy9zXcGjIyrcH+wX6xEsDYPpE+z
         LogYbV1X+0d9NfjBokNu9/y8p/hwo1QmUz/WPG0WLBH6VXbodgI84P1IqyauWXQyIU
         pmSAjRgdTdBhQ==
Received: by mail-wr1-f70.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so5085171wrf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mASWuX3flYB8leB5oLjas+ClwDRJkiZNw0C7JrzS2pY=;
        b=ScvUYtGidJK/h03XvTZ4zKW87tNiA3k/mi6oqsT+sZQWMBbtfLRK9P5Zhc6BhciBRE
         KjlYhEh7JpeFx1n9sgf+ZTiYbW4Tmn4yT4eAlaau9bfVDIet/13m1PEbWb/FadJ7EqLS
         AmtvQW/Au9IQK7QrK4hWUHK2jNYkvVd4poxtzG0zjbMHnqydAP8uOtH3FTH98GJS3CCg
         XICn78t8QtFbSy5tZJ+1P6hgkuPXkDhIqRSR12xg2rOtFchmadERaZFjeiEBb7RDahzj
         jsVqKHvYku1oZBwTpXZMzWswGJdtDvXXnDZZm/eaMWdUiocNhI7n4mqDcLDvFrYA/PgJ
         Tirw==
X-Gm-Message-State: AOAM533NCC88spM6PAPm8Z0XeNOcYDvx5vaQKVZUwmU/X4JX+9XeyA/O
        ao0MSZGn5WejVaYpr2CqJzRrQgB8zJgqOc+5IACcNMxeppn2Plrnxe3YyCs82NIj7KlRS9mV+da
        sDQIfqkucQjb7W4+GdtP1iN1CAoaF+vvuNJZeGnip+A==
X-Received: by 2002:a05:600c:b56:: with SMTP id k22mr4384210wmr.92.1632401861950;
        Thu, 23 Sep 2021 05:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWyLm0wEC/mrzeiTfnYq5V0pyyRci238Q1zBgq6kAG9VVtql0gZoCHgHn/dkxF2gAg9ewJ6Q==
X-Received: by 2002:a05:600c:b56:: with SMTP id k22mr4384191wmr.92.1632401861710;
        Thu, 23 Sep 2021 05:57:41 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l26sm9112190wmi.25.2021.09.23.05.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 05:57:41 -0700 (PDT)
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
References: <20210920190350.3860821-1-willmcvicker@google.com>
 <20210920190350.3860821-3-willmcvicker@google.com>
 <2b48a41a-9130-b4cc-40d3-0bc7930ac76a@canonical.com>
 <YUmVj80m/rEC2mT7@google.com>
 <CABYd82a4OwxHNUUmUtBmTpSvWLu-f4sepHMF49kPQtWLU3MkDA@mail.gmail.com>
 <ad2de848-8fce-f275-25de-83a886243645@canonical.com>
 <YUx1c/xZ+nP5aI+X@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v1 2/4] soc: samsung: change SOC_SAMSUNG default config
 logic
Message-ID: <db808138-e839-48d8-26e7-659cc9950163@canonical.com>
Date:   Thu, 23 Sep 2021 14:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUx1c/xZ+nP5aI+X@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 14:39, Lee Jones wrote:
> On Tue, 21 Sep 2021, Krzysztof Kozlowski wrote:
> 
>> On 21/09/2021 19:45, Will McVicker wrote:
>>> On Tue, Sep 21, 2021 at 1:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>>>>
>>>> On Tue, 21 Sep 2021, Krzysztof Kozlowski wrote:
>>>>
>>>>> On 20/09/2021 21:03, Will McVicker wrote:
>>>>>> Switch the default logic to enable SOC_SAMSUNG and it's sub-configs to
>>>>>> be enabled by default via "default y if ARCH_EXYNOS" versus being
>>>>>> selected by the ARCH_EXYNOS config directly. This allows vendors to
>>>>>> disable these configs if they wish and provides additional flexibility
>>>>>> to modularize them in the presence of a generic kernel.
>>>>>
>>>>> This is not true. Vendors cannot disable these options as they are not
>>>>> visible.
>>>>
>>>> Good point, well made.
>>>>
>>>>> Although I understand that Arnd prefers this way and I do not
>>>>> object it, but your explanation is incorrect.
>>>
>>> Thanks Krzysztof for the reviews! I'm sorry I missed the whole "hidden
>>> configs" part. I'll upload the series to include the fix that refactos
>>> the Samsung SoC drivers menuconfig which will address that and allow
>>> one to enable/disable those configs. I'm going to hold off though
>>> until we hash out the rest of the discussion in the cover letter
>>> email.
>>
>> No, please first read our discussions, including Lee's and Geert's
>> comments. The drivers should not be converted to modules or made visible
>> if such configuration does not work. If it works, please describe your
>> testing setup.
> 
> Modules *should* work.  William is going to try it out.
> 
> Might need to lean-on for some testing on different H/W though.

I can help, few other folks from Samsung can help as well.

> 
>> All these drivers are *necessary* for a multiplatform kernel supporting
>> Exynos platforms, therefore disabling them does not make any sense (if
>> you support Exynos platform). If your kernel does not support Exynos
>> platform, just do not select ARCH_EXYNOS and problem disappears because
>> none of these drivers will be visible and selected.
>>
>> Unless you describe here some out-of-tree kernel which wants
>> ARCH_EXYNOS, because vendor did not upstream it's code, but you do not
>> want existing Exynos upstream drivers. We do not support such
>> configuration. Please push your lovely vendor to work with upstream.
>> That's the only solution.
>>
>> It's the third time this abuse re-usage of ARCH_EXYNOS appears and the
>> same as before - the vendor does not like to upstream stuff. There are
>> few guys trying to upstream recent Samsung SoC support by themself (ping
>> me for contacts if you would like to participate) but the one party
>> which should be doing it - the lovely vendor - does not actually
>> participate and instead sends ridiculous patches like this one here...
>> or like this [1] [2].
>>
>> Nope, please work with upstreaming SoC support, instead of abusing
>> ARCH_EXYNOS for out of tree code from the vendor.
> 
> One of the on-going issues that GKI aims to solve pertains to the
> disparity between what upstream engineers would like to be upstreamed
> (i.e. everything) and what vendors can upstream (i.e. most things).
> 
> The old Open Source vs Business (i.e. products/real-life) struggle!
> 
> Vendors are not able to upstream all functionality right away, as it
> would give away their perceived edge on the competition (i.e. other
> vendors).  This is something we just have to accept as it will *never*
> change.

Sure, I understand. Balance, compromise, not perfectness.

However now it is heavily in-balanced since vendor did upstream only one
change - UFS drivers for new SoC - since 2017. One change. Nothing else,
nothing for older SoC, nothing for newer.

All other work is done by the community, not by the vendor.

Not sure how to qualify Sam's Exynos850 work, but even if counting it,
there will be just two changes from vendor.

This is not acceptable, this is not a balanced approach.

> 
> GKI attempts to solve this issue by providing a generic core
> containing all of the elements required to get every supported
> platform bootstrapped to a point where modules can be loaded and
> additional functionality can be brought in.  GKI provides all of the
> modules available from the upstream kernel BUT allows them to be
> overwritten/swapped-out by modules containing code (new/shiny
> unreleased value-add) that the vendors do not wish to share (yet).
> 
> Clever, eh!
> 
> As I've explained before, the trigger for all of this was
> SERIAL_SAMSUNG which is required for early console on supported
> Samsung platforms i.e. this symbol *has* to be built-in.  

Actually SERIAL_SAMSUNG does not have to be built-in. It is necessary
for built-in only for debugging or development, not for real products.

Unlike other drivers which have to be built-in, e.g. clocks or pinctrl,
or heavily tested whether setup from initrd works. Plus not breaking
distros who like to have everything as module (solution from Geert?)...

> In order for
> this to built-in ARCH_EXYNOS has to be enabled due to the listed
> dependencies in Kconfig.  And since ARCH_EXYNOS 'selects' all of these
> different extra symbols, it means they too will be built-in, meaning
> that a) the core binary will be unnecessarily bloated and b) vendors
> who wish to overwrite/replace this functionality with their
> non-shareable value-add, are not able to do so.

I am sorry, but this is not reflecting status we want to have in
usptream. Everything selected by ARCH_EXYNOS *has to be selected* for
supported platforms. Since vendor does not contribute anything new
(except mentioned one work for UFS), we are not going to sacrifice
supported mainline platforms for a non-cooperative out-of-tree unknown
platforms.

> Going forward, it sounds like the best approach that will make
> everyone happy, providing it's technically feasible, is to enable
> these added (sometimes required, other times superfluous) symbols as
> loadable modules.

Not entirely. What actually would make everyone happy and it is still
technically feasible is for a multi-billion company with thousands of
engineers to contribute something. Let's start with a little bit. From
billions of dollars and thousands of engineers we won't expect too much,
right?


Best regards,
Krzysztof
