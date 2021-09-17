Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55C40FEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhIQRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhIQRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:33:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F1C061574;
        Fri, 17 Sep 2021 10:31:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w19so9769863pfn.12;
        Fri, 17 Sep 2021 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZgJTF+cE7D4yD4nVaDptPefXWZ8JJuPxDLtkAILEopg=;
        b=BnDkbCW6zcmBHofOamxH6kwYqcPaRJ1RMP5UsVAxcIsW6U6nv9tT7RPMu/g917ksNI
         EeWXauphhb6PentDHg0uXTJEGg2WG8n/ARGM6TYwLmODYySMui2TpuXppW2e2mtJaKgM
         eJDzh/LhxfNqG26vNKVOULB1EsGjoCZVP+1csC5bOIzR1jyCvIlvRy54Z9PzOhnSmUYE
         JdP6TGyvjieABL4lvUODPiqcKIB23UFANLkMgdxbWOv6gtW5MQYRjVJ7AiSzy3ischLn
         eNkx75jZgbT2zR+uZlbATfYk/XRU0h9BUGFhUokmyoYAlS5addRto9qzVtCfHoAqFfG2
         TAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZgJTF+cE7D4yD4nVaDptPefXWZ8JJuPxDLtkAILEopg=;
        b=lKaQMO0p2X29xz760oiozE0z/c1NE1GPyMw9b+FfKN2jzmG8dcvVrcI+THv8NQq2SA
         6L+NXCPhymcvhL7wEY62tbllQpQBAPFfUu2WmlR3HJuLVVq4QAG/ZMSkTbVxesKjspZH
         FDCKFpCcCmZIVUsnHKOKhgHdK8CuvbeM7GtpQ1QSHg9auBZtBLS+yOXkzwDEYllH/W/l
         EZIoOpLQifPuy7/XvxjH70KyOlkn5+LNOjzAlVCi2h7EQ9ZxPP2jeviSZKs6Ts28jQ6c
         oMkOmKEgNWlC5tJEsIFa2WNkXGET/Ot8g5a47T83xKgZucJsMqEK8o0HVH35azlbMJ7B
         AegQ==
X-Gm-Message-State: AOAM5339phYAoRKSpAH58W0vZGtYwlo7DlNBqqPuOOTndrkEsCTOs0pw
        W1e2x5lEv14UWhOJ8I/8G1itBpqnUcE=
X-Google-Smtp-Source: ABdhPJzEQInC3CjqI2kJ4cdpCpLh1AGMcnptDJ++UEwFXdZg6u6gTYHUygjavOsTK8pg01PW06N4Zg==
X-Received: by 2002:a62:8015:0:b0:43b:400c:7a73 with SMTP id j21-20020a628015000000b0043b400c7a73mr12202716pfd.34.1631899918447;
        Fri, 17 Sep 2021 10:31:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q11sm6341376pjf.14.2021.09.17.10.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 10:31:57 -0700 (PDT)
Subject: Re: [PATCH] Revert "of: property: fw_devlink: Add support for
 "phy-handle" property"
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210915081933.485112-1-saravanak@google.com>
 <45576ceb-562c-9ca7-3ef4-31add52b2168@gmail.com>
 <CAGETcx9nbxH6hETP2LUENG8EV3v771qi9NpkFd-mix3G-NdZUA@mail.gmail.com>
 <6cc44234-ed1f-5fb3-671a-cf673ee08fb7@gmail.com>
 <CAGETcx9YMsw1YnorpD7hYNiDxS_DKC4b30nk6vcUiBFKuJi-0w@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <498b5f71-ffb6-1f51-e27e-610496f70141@gmail.com>
Date:   Fri, 17 Sep 2021 10:31:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx9YMsw1YnorpD7hYNiDxS_DKC4b30nk6vcUiBFKuJi-0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 10:21 AM, Saravana Kannan wrote:
> On Fri, Sep 17, 2021 at 9:59 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 9/16/21 7:27 PM, Saravana Kannan wrote:
>>> On Thu, Sep 16, 2021 at 7:21 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/15/2021 1:19 AM, Saravana Kannan wrote:
>>>>> This reverts commit cf4b94c8530d14017fbddae26aad064ddc42edd4.
>>>>>
>>>>> Some PHYs pointed to by "phy-handle" will never bind to a driver until a
>>>>> consumer attaches to it. And when the consumer attaches to it, they get
>>>>> forcefully bound to a generic PHY driver. In such cases, parsing the
>>>>> phy-handle property and creating a device link will prevent the consumer
>>>>> from ever probing. We don't want that. So revert support for
>>>>> "phy-handle" property until we come up with a better mechanism for
>>>>> binding PHYs to generic drivers before a consumer tries to attach to it.
>>>>>
>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>
>>>> Thanks for getting this revert submitted, I just ran a bisection this
>>>> afternoon that pointed to this offending commit. It would cause the dead
>>>> lock
>>>
>>> Dead lock in the kernel? Or do you mean just a hang waiting forever for network?
>>
>> It locks up since we try to acquire __device_driver_lock() while we are
>> in the main driver's probe function.
> 
> Off the top of my head that sounds weird, but I'll look into the
> logs/code later. Bunch of other stuff and some LPC prep comes first :)
> 
>>
>>>
>>>> on boot with drivers/net/dsa/bcm_sf2.c pasted below.
>>>
>>> The log is too jumbled up to be readable (word wrap I suppose) and
>>> maybe even multiple thread printing at the same time.
>>
>> Re-attached (thunderbird is not really helping me).
> 
> Thanks!
> 
>>
>>>
>>>> Saravana, can
>>>> you CC on me on your fix or what you would want me to be testing?
>>>
>>> By fix, I assume you mean when I bring back phy-handle with a proper
>>> fix to handle the case in the commit text? Yeah, that's going to take
>>> a while. It's brewing in my head and there are some issues that's not
>>> fully resolved. But I haven't had time to code it up or dig into the
>>> net code to make sure it'll work. But yes, I'll CC you when I do so
>>> you can test it with this case.
>>
>> Well by fix, I meant something that does not lock up on my system,
> 
> Hold on. Now I'm confused. Are you still hitting hangs/issues after
> the phy-handle patch is reverted?

With the 'phy-handle' patch reverted no, I do not see the hang.

> 
>> it is
>> a different problem from supporting 'phy-handle', but it should not
>> regress an existing system, no matter how quirky that system behaves in
>> its probe function. For history and reference, the "offending" change
>> and background can be found here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=771089c2a485958e423f305e974303760167b45c
> 
> So that is the change that's interacting with the phy-handle patch to
> cause the deadlock?
> 
> I'm a bit confused on what needs debugging now.

Sorry was not very clear, what I meant to write is that your next
attempt at solving 'phy-handle' should not be regressing on my system,
and I will make sure you get appropriate testing of that patch.
-- 
Florian
