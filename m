Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421C431C0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhBORda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232100AbhBOQiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613406992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFzj2rODJUK5q41Mv/Io7SL5b3FYccUSH7ggm3/NT4E=;
        b=X30O2J6iEZVAk3aSzyyBqj867oHhOCjYRcwTf8zOOES0G5DrfamN9Lymv1JVp/nmseHv5p
        BxsN3HjCz2dREM6sFLhRw/KYqZZZFSdNJJR37onEjzHZZEbkTu9gp2I6x/2Yd6+slpycog
        yfbz/0eDtCjq8hgI+mtn/Io/QgkW6ck=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-lb4YfMo_NKOUkw2qd-0avg-1; Mon, 15 Feb 2021 11:36:31 -0500
X-MC-Unique: lb4YfMo_NKOUkw2qd-0avg-1
Received: by mail-ed1-f71.google.com with SMTP id g6so5484509edy.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFzj2rODJUK5q41Mv/Io7SL5b3FYccUSH7ggm3/NT4E=;
        b=bjUbVpM/GoGp+tBkNFvLmH9LAdPVor1YUUUF88QS/PtfjDbPIAaR5xVNT5cG2CNbue
         PGj45OvJZExAE4p0rsMVP1F8Rwu1HpUAlvxWeb4zTe6GgxHI1j4h3PRn90Ck/i44Eyds
         yVU5Y4gEpxZuFMnAH2oFuotVDK4LTjX5QDNNiQaCEpcoJJ8lkvceJ0tQPBEQOHoC/byc
         prVzX63pHDxzFphfy8qeYjr+1ubw7peTGxb5WDhq/joRkB1no0gCr7EDvvKJRuIUGurx
         3yS7+3YIwctJvHVqrR3SxLX8QBnmgr7/1bmOmYYJUkvStSTrLUbGqsHjC3T9sfG7cLxT
         qpQA==
X-Gm-Message-State: AOAM531blwmAW6UAdTC41Z4JI9Sm1mFe/PElNeDRj8YpShDPoL+GOe/H
        0NJ23HNOHg9srHcrVeZNf3Jev7aDxZ4SdCyrgi+njB7e79jKM6QomYgLdhYCoJN96op6aXiHBk2
        cEYZBTo6pnfMM5owDeHJLujuALFt9HWyDL8jSCXEBKhFRci90yCk+oYRQIOHyKcz9ureFJuUgSx
        40
X-Received: by 2002:aa7:c991:: with SMTP id c17mr5863068edt.165.1613406989877;
        Mon, 15 Feb 2021 08:36:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIS+DGtIJOghH2LW7e+kP9zUs2GEvAi9MOuAwjCAR/nA1TCdrU9hpTofc967En7cCrT+RyWQ==
X-Received: by 2002:aa7:c991:: with SMTP id c17mr5863039edt.165.1613406989699;
        Mon, 15 Feb 2021 08:36:29 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p16sm10478569edw.44.2021.02.15.08.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 08:36:29 -0800 (PST)
Subject: Re: [PATCH v2 0/4] platform/surface: Add platform profile driver for
 Surface devices
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <mgross@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
 <898aa498-8256-d59f-9e72-0e1199b3a62a@redhat.com>
 <CAJZ5v0jGUgHsNaqLarf=YLwjtOe-mQB48LkOQLi7FcZyW1Qchg@mail.gmail.com>
 <510803ab-b5b8-ce2c-e956-5539874d00bf@redhat.com>
 <CAJZ5v0hBN2zTHj+KsAmdNWTL0e983CFE+LYBssJzUDOmdF7PPQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8435cc87-d92f-e1c3-97c7-e2113e0ff3a9@redhat.com>
Date:   Mon, 15 Feb 2021 17:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hBN2zTHj+KsAmdNWTL0e983CFE+LYBssJzUDOmdF7PPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/15/21 4:29 PM, Rafael J. Wysocki wrote:
> On Mon, Feb 15, 2021 at 4:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 2/15/21 3:54 PM, Rafael J. Wysocki wrote:
>>> On Mon, Feb 15, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 2/11/21 9:16 PM, Maximilian Luz wrote:
>>>>> This series adds a driver to provide platform profile support on 5th-
>>>>> and later generation Microsoft Surface devices with a Surface System
>>>>> Aggregator Module. On those devices, the platform profile can be used to
>>>>> influence cooling behavior and power consumption.
>>>>>
>>>>> To achieve this, a new platform profile is introduced: the
>>>>> 'balanced-performance' profile.
>>>>>
>>>>> In addition, a couple of fix-ups are performed:
>>>>> - Hide CONFIG_ACPI_PLATFORM_PROFILE and change drivers so that it is
>>>>>   selected instead of depended on.
>>>>> - Fix some references to documentation in a comment.
>>>>>
>>>>> Note: This series (or more specifically "platform/surface: Add platform
>>>>> profile driver") depends on the "platform/surface: Add Surface
>>>>> Aggregator device registry" series.
>>>>>
>>>>> Changes in v2:
>>>>>  - Introduce new 'balanced-performance' platform profile and change
>>>>>    profile mapping in driver.
>>>>>  - Perform some fix-ups for the ACPI platform profile implementation:
>>>>>    - Fix some references to documentation in a comment.
>>>>>    - Hide CONFIG_ACPI_PLATFORM_PROFILE
>>>>
>>>> Thanks, the entire series looks good to me, so for the series:
>>>>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> Rafael, can you (once 5.12-rc1 is out) pick 1-3/4 and then provide a
>>>> stable branch for me to merge?
>>>
>>> Since [1-3/4] appear to be uncontroversial, so IMO it would be better
>>> to merge them during the merge window, so they are present in
>>> 5.12-rc1.
>>
>> So I just realized one problem with this plan, patch 1/4 depends
>> on (modifies) Kconfig bits which are only in my tree / my 5.12 pull-req
>> (which I send out earlier today).
> 
> That should be fine.
> 
> I will be sending the first batch of pull requests tomorrow.  Then I
> will wait for them to be merged and I will merge the mainline back at
> that point.  The new patches will be applied on top of that merge, so
> if your 5.12 material is included in it, they should build without
> problems.

Ok, that sounds good to me.

Regards,

Hans

