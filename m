Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0563169CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBJPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhBJPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:11:21 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA68C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:10:41 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id m7so2310183oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aTpWWeojNQbSjmcHZ/jQUu8KsLOoh6lP/nZMxZFQMfc=;
        b=TiUmWUjJhZCu8JeSbqv9DkKK2CI7IeEIP73ydqKAGR56vBUceuVhEAimUQFXSRafaq
         F6A3VSHgUmYNyRSxKYfSrrDZToicN4VfgCrVj7Infu8utTA/O61rDHZSCivojR9PIgVW
         NTVL2X+BknkjRX/8R15/sjntJS3z6ppajTzGciaWgUBDfPxorMVbV823DSv6jDyZocUh
         LfgiOkAQxSCx4YwXkZiA/eg6045HPSB35qyH9rsOWpv4EctXdEb4cFVqD54T0/poD5S8
         Q+itp9ZSvLrLBQy36Wcb0FmUonjkhccPgMttqljYQpQjeEZX6uXZ504LeBKj9BOGStiP
         Xm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aTpWWeojNQbSjmcHZ/jQUu8KsLOoh6lP/nZMxZFQMfc=;
        b=H4RHerXHTdhpFuGQZ3gzBBrgf23/pg9dcrPbKGy5wUtqFRMP6DAxL5wm691KdRHXVh
         pP/2iVVVTVczLYKCWsJ6Ho/tyiSWklT/vBitQ5vomODL3I9VVzkNOwZkfsGQNqnEWmln
         zlv3B1Qx17C5cyC+IdOjdhy0MEs07muYpA7lthCIcwx8wmQZUaGB20enkAXExIPmJPaq
         F/eynafuJtSqM21ONjkkhQG/wV50duzdtBOI8pckX3o4y4go8BwFcBGRTe9hqV4OaFR+
         Ts92XhvPgERWtrtUg0MTStCGn6zvciH/o6m9S/Uh9hcRnbdwgqsnb7j1iMbM8WUQRbPl
         Zx2A==
X-Gm-Message-State: AOAM532NZ2BR+rzFZSPsR/3NYXTdx+DF27RnufD+9E9OxvM3Dn+uJDx4
        flcG8p03YCAVJ1QkwwVJFxg=
X-Google-Smtp-Source: ABdhPJynHkbovOuEU0MZa5N2dR5M+LmNRyuaW83d5lhthyjushCGsTLK0z6+stK9cN6bA1goyQw9Og==
X-Received: by 2002:aca:de06:: with SMTP id v6mr2420536oig.60.1612969840530;
        Wed, 10 Feb 2021 07:10:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 62sm493210oii.23.2021.02.10.07.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:10:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com>
 <20210210055430.GA73123@roeck-us.net>
 <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <33f643b9-9f6d-e59a-64e7-2d2b7d3e71a4@roeck-us.net>
Date:   Wed, 10 Feb 2021 07:10:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 12:20 AM, Saravana Kannan wrote:
> On Tue, Feb 9, 2021 at 9:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
>>> Cyclic dependencies in some firmware was one of the last remaining
>>> reasons fw_devlink=on couldn't be set by default. Now that cyclic
>>> dependencies don't block probing, set fw_devlink=on by default.
>>>
>>> Setting fw_devlink=on by default brings a bunch of benefits (currently,
>>> only for systems with device tree firmware):
>>> * Significantly cuts down deferred probes.
>>> * Device probe is effectively attempted in graph order.
>>> * Makes it much easier to load drivers as modules without having to
>>>   worry about functional dependencies between modules (depmod is still
>>>   needed for symbol dependencies).
>>>
>>> If this patch prevents some devices from probing, it's very likely due
>>> to the system having one or more device drivers that "probe"/set up a
>>> device (DT node with compatible property) without creating a struct
>>> device for it.  If we hit such cases, the device drivers need to be
>>> fixed so that they populate struct devices and probe them like normal
>>> device drivers so that the driver core is aware of the devices and their
>>> status. See [1] for an example of such a case.
>>>
>>> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>
>> This patch breaks nios2 boot tests in qemu. The system gets stuck when
>> trying to reboot. Reverting this patch fixes the problem. Bisect log
>> is attached.
> 
> Thanks for the report Guenter. Can you please try this series?
> https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
> 

Not this week. I have lots of reviews to complete before the end of the week,
with the 5.12 commit window coming up.

Given the number of problems observed, I personally think that it is way
too early for this patch. We'll have no end of problems if it is applied
to the upstream kernel in the next commit window. Of course, that is just
my personal opinion.

Thanks,
Guenter
