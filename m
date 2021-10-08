Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74161427181
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbhJHTpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 15:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhJHTpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 15:45:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F3C061570;
        Fri,  8 Oct 2021 12:43:39 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r17so5298404qtx.10;
        Fri, 08 Oct 2021 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=txtnvg7blPU7HQRh6QW4CdbKgSFFsV7Icy1mQ2ZPblw=;
        b=KZoMDjctnN+693gxmSWUzBBC1g3g41UHZuWf7wrLuslXZt5a4DWN4yOXKuYwHJ1J7x
         X9HFxVuBs1moHaihl0fByuwtKEaVwKq+s3qa648SNhURZj2aUTOxbBQq1YMu8bWjXLG5
         Bzvcmxjl8JBiwWqedO/M1Gt5hRC8gcHpiuSBAU5j882P1MHIRcur2ZbXPVi7R9n/9+PK
         gwyMp8q8sQpnDg+/X/IUrg0X4kzxb2Ic/S+QZv+0nqqlciuNXY5sAxH5/ztxjMi+ywxN
         WZa/XZogOqEGQP+Lgev5E5CbBKNFCp4VCRwah19rIiGQn5DqOVirLxfLOFnd9HyRdafS
         z3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=txtnvg7blPU7HQRh6QW4CdbKgSFFsV7Icy1mQ2ZPblw=;
        b=a+hL0pUxFqQ9APSAXm6fAR0zfZh9swibHGNTYypCwTqT6Gz/JO4oxxfcg4lZSH/pqb
         CpbpHayAOER9ANtM8SvIwTSA0gRZjGpwzDZiAWozi3F5dsjglRQIleBGFRQT66rKtW7x
         vygGegnDHub7mvO87uy4sRisqqd+DjSH7qzR2ckrDAVx/CfqsFD1IuJ/+QwpSk4u2knl
         /cG+rWLydQLcPDv7M54siE1EwTNsOk7o8Zh8WAGknCDodoRhvE4meKzoLWt2Cc/ZnbJn
         kwPAP8R87mKG0oyM3LZHw2cWu6HZp8gxjr094gka7iHDc6qa9fKTG6TIgy3JH95E3zWL
         heqg==
X-Gm-Message-State: AOAM532xUJ6qww1VRVx8NsHOlaVjobvMOD1OcnuVxt278uNtqCqGIztk
        fbDrSrS1P5HqLDplMgY7bKQ=
X-Google-Smtp-Source: ABdhPJxW8C59Jq0Pei+jZgoEB1O83v6o+W3HERrHg0pzeXv7bQKu2fYbCfGPFy/xFLqdAnsi84VdUw==
X-Received: by 2002:ac8:5a:: with SMTP id i26mr244744qtg.269.1633722219005;
        Fri, 08 Oct 2021 12:43:39 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id a17sm164016qtn.86.2021.10.08.12.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 12:43:38 -0700 (PDT)
Subject: Re: [PATCH 0/9] Dynamic DT device nodes
To:     Rob Herring <robh+dt@kernel.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Axtens <dja@axtens.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
 <YV64ZbcsHvBObH2j@hatter.bewilderbeest.net> <YV7Miz9RMMx/17A0@kroah.com>
 <YV8VGeMreR6NJad4@hatter.bewilderbeest.net>
 <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <662f6ff3-61b9-e1e6-5059-699edbb2ab1c@gmail.com>
Date:   Fri, 8 Oct 2021 14:43:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/21 3:03 PM, Rob Herring wrote:
> On Thu, Oct 7, 2021 at 10:41 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> On Thu, Oct 07, 2021 at 03:31:39AM PDT, Greg Kroah-Hartman wrote:
>>> On Thu, Oct 07, 2021 at 02:05:41AM -0700, Zev Weiss wrote:
>>>> On Thu, Oct 07, 2021 at 12:04:41AM PDT, Andy Shevchenko wrote:
>>>>> On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>>>>>> This patch series is in some ways kind of a v2 for the "Dynamic
>>>>>> aspeed-smc flash chips via 'reserved' DT status" series I posted
>>>>>> previously [0], but takes a fairly different approach suggested by Rob
>>>>>> Herring [1] and doesn't actually touch the aspeed-smc driver or
>>>>>> anything in the MTD subsystem, so I haven't marked it as such.
>>>>>>
>>>>>> To recap a bit of the context from that series, in OpenBMC there's a
>>>>>> need for certain devices (described by device-tree nodes) to be able
>>>>>> to be attached and detached at runtime (for example the SPI flash for
>>>>>> the host's firmware, which is shared between the BMC and the host but
>>>>>> can only be accessed by one or the other at a time).
>>>>>
>>>>> This seems quite dangerous. Why do you need that?
>>>>
>>>> Sometimes the host needs access to the flash (it's the host's firmware,
>>>> after all), sometimes the BMC needs access to it (e.g. to perform an
>>>> out-of-band update to the host's firmware).  To achieve the latter, the
>>>> flash needs to be attached to the BMC, but that requires some careful
>>>> coordination with the host to arbitrate which one actually has access to it
>>>> (that coordination is handled by userspace, which then tells the kernel
>>>> explicitly when the flash should be attached and detached).
>>>>
>>>> What seems dangerous?
>>>>
>>>>> Why can't device tree overlays be used?
>>>>
>>>> I'm hoping to stay closer to mainline.  The OpenBMC kernel has a documented
>>>> policy strongly encouraging upstream-first development:
>>>> https://github.com/openbmc/docs/blob/master/kernel-development.md
>>>>
>>>> I doubt Joel (the OpenBMC kernel maintainer) would be eager to start
>>>> carrying the DT overlay patches; I'd likewise strongly prefer to avoid
>>>> carrying them myself as additional downstream patches.  Hence the attempt at
>>>> getting a solution to the problem upstream.
>>>
>>> Then why not work to get device tree overlays to be merged properly?
> 
> TBC, it's 'just' the general purpose userspace interface to apply
> overlays that's missing.

A fuller view of what is missing is at:

https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts#issues_and_what_needs_to_be_completed_--_Not_an_exhaustive_list


> 
> I did suggest what's done here as overlays are kind of an overkill for
> this usecase. Much easier to write to a sysfs file than write an
> overlay, compile it with dtc, and provide it to the kernel all just to
> enable a device.
> 
> Perhaps this could also be supported in the driver model directly.
> Given the "what about ACPI question", that is probably what should be
> done unless the answer is we don't care. I think we'd just need a flag
> to create devices, but not bind automatically. Or maybe abusing
> driver_override can accomplish that.
> 
>>> Don't work on a half-of-a-solution when the real solution is already
>>> here.
>>>
>>
>> I had been under the impression that the overlay patches had very dim
>> prospects of ever being accepted and that this might be a more tractable
>> alternative, but apparently was mistaken -- I'll look into what the
>> outstanding issues were with that and perhaps take a stab at addressing
>> them.
> 

> What's dim is the patches allowing any modification to any part of the
> DT. Any changes to a DT need to work (i.e. have some effect). For
> example, randomly changing/adding/removing properties wouldn't have
> any effect because they've probably already be read and used.

Yes, that is a good description.

> 
> What I've suggested before is some sort of registration of nodes
> allowed to apply child nodes and properties to. That would serve the
> add-on board usecases which have been the main driver of this to date.
> That also got hung up on defining interface nodes to add-on boards.
> Your scope is more limited and can be limited to that scope while
> using the same configfs interface.
> 
> Rob
> 

