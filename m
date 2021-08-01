Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2703DCDB9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhHAUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhHAUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:30:02 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B9C06175F;
        Sun,  1 Aug 2021 13:29:54 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so3924854ooa.11;
        Sun, 01 Aug 2021 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yRa+8nfsAlC+BDrCiBgWd6QSuRUaWhatjBxWVMsk2Ws=;
        b=KkY1OGN8uI/P+a7a+GD3fcV6/GZqPNwZveus7pEhhp4qjTAyh7xwVNt1Bp8/KY9K27
         lkABJJAD5vKgCcDJHj9QBIeVAXyY8urdhjWc1fPQts0Sn4vadbs0xGzStXGHLiQGBmjh
         HkgPdRMxLkKb338/DU29rorBdIFStxsBbyFdKwG0KilfDB7zFJk4UZW4beOXxPI/SOsR
         C+hJyp8BAavl6Nl/6j3890xzX2goaWkhN8RZ8eZZLJf2HmwMM0P7kfbQdcD7XOT9xwWY
         At5Wd06c4kc34iqDvadUHhpmBDPigOeN7pfMXXIC1L1I8hQTSK7phbHTHYVlYecD9QPP
         1xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yRa+8nfsAlC+BDrCiBgWd6QSuRUaWhatjBxWVMsk2Ws=;
        b=VcTYCppBTuJ2crcdvTActKpBXip5eXgtiXeRcWkoPn5qPOneZPUqqRReOpwBFh+rsh
         HoZ0zheIf5asjzEfCMulkiZ3rEihISFQ5U0dhdv0rKtuWNvZsWpDSumC4h+qsYr0g401
         Fjeo1dXecZGtOtXyGnbcET/uZAekbRiw8wpBUArQtLq0kcTJFPpPPuIA7csQKZeWCmHh
         wsL+mJs47TimxQC6NcrVufk2yG7fUycs8xQepSOVZjpw88u25PPKGUH8lMK98FFNhsor
         6ZG0fN1kuWEezx10TZlFTKE3A23TOpsvpR/WzZXL3rLO6MxOcTrCpOT1+XGDvrJhCGAo
         m+Iw==
X-Gm-Message-State: AOAM532tidLb3w4SIgd5ZIa8kHBSoAUzTYS7DlZno377Hcv60QWuZoFo
        81pH9VVOsNq9bENNkeR6f0T0/m9wljk=
X-Google-Smtp-Source: ABdhPJwrQoKb31KnmW9JbnFu5E1LVxfynz7kqyd4XHz4RvxsUJlby484ubfYOpX1v83Y1tyritlmRg==
X-Received: by 2002:a4a:e8cd:: with SMTP id h13mr8634903ooe.26.1627849793356;
        Sun, 01 Aug 2021 13:29:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 89sm1561391ott.19.2021.08.01.13.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 13:29:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 0/2] hwmon: Add StarFive JH7100 temperature sensor
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210726171802.1052716-1-kernel@esmil.dk>
 <bcc9de67-f006-0a81-8c3f-2ae5188dca48@roeck-us.net>
 <CANBLGcxpaFt-bokq8=Tie-bJnWk5AqLyr-1Ns-+Xtobxs5bYQQ@mail.gmail.com>
 <CANBLGcyhKYwsLOwaO=BOhaCzP0T2CqKruJZexypRAY3HmEJUMA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f09e323b-90f3-8fd6-e5ba-e3c5ac823dc6@roeck-us.net>
Date:   Sun, 1 Aug 2021 13:29:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANBLGcyhKYwsLOwaO=BOhaCzP0T2CqKruJZexypRAY3HmEJUMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/21 1:19 PM, Emil Renner Berthing wrote:
> On Wed, 28 Jul 2021 at 19:05, Emil Renner Berthing <kernel@esmil.dk> wrote:
>> On Wed, 28 Jul 2021 at 18:54, Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 7/26/21 10:18 AM, Emil Renner Berthing wrote:
>>>> This adds a driver for the temperature sensor on the JH7100, a RISC-V
>>>> SoC by StarFive Technology Co. Ltd., and most likely also the upcoming
>>>> JH7110 version.
>>>>
>>>> The SoC is used on the BeagleV Starlight board:
>>>> https://github.com/beagleboard/beaglev-starlight
>>>>
>>>> Support for this SoC is not yet upstreamed, but is actively worked on,
>>>> so it should only be a matter of time before that happens.
>>>>
>>>
>>> Hmm, makes me wonder if I should apply the series now or later,
>>> when the chip is actually supported by the kernel. Comments/thoughts ?
>>>
>>> Guenter
>>
>> I'd of course love if it was applied now. That would at least mean
>> fewer patches to rebase when keeping the beaglev patches [1] up to
>> date, and I'd be very surprised if SoC support doesn't make it
>> upstream eventually. But I'd also fully understand the position that
>> this only makes sense to add when support for the SoC is upstream too.
>> I'm adding Drew, as he might have something to say about this.
> 
> Hi Guenter,
> 
> Things have changed. The BeagleBoard.org foundation is no longer
> planning to make any further boards using the JH7100 or upcoming
> JH7110 SoCs from StarFive. I still think support for the JH7100 will
> make it upstream eventually, but I'm no longer confident enough to
> recommend merging this before there are more concrete plans for the
> SoC. So thanks for the reviews. I'll repost it when I think it's time
> to consider it for upstream again.
> 

Thanks for the update.

Guenter

