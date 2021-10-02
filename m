Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8974541F997
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 06:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhJBEQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 00:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhJBEQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 00:16:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0842C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 21:15:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bd28so41635903edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 21:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IiLda6O/l1Co3m8X+IjQnVuOwn2qsKC/9LWD6X1H/To=;
        b=LphyHujyj48edrYDaVDUhHRpFqlFAaWfgFZW4LLlp+ohBSfPjtfIJDVhN58cCIuoKc
         lpjBkh7qLF8Vck/3BPmvBKZKSgy9nBw0LtJbCbSuwXhYCPzKhmgW//X9ZPgH1pAKPqOE
         j9jEolzxu5CQnifXJJX6LHk0zZ7VVacUwKodfkme4tMFbJtxuaJzJtYcjy6ntrzUGGIo
         SMWe1lIit4eSfAx4uwDzBMDn/WvJPRnw0gcerpSUFvM21OymVUFKiRzUuy3HB6DEDAb1
         6UOROCTyWNAFhMh0NnPbyIFxvNI8h0gvbotgaRKqIeLAd+u1DTypdGFYlRMTcZuaLsU+
         5J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IiLda6O/l1Co3m8X+IjQnVuOwn2qsKC/9LWD6X1H/To=;
        b=UwNI8kf1ON/pEpJh2tqZIjh+KUIg53D9rwo2mY0qj/mrsmdjN6iCOqEhSRR0rXK6gV
         98GXj6e8cGjg1fFG0g7B69Rtg28jqtT4HJfYGXgxPsJY+i2YLqw3/W+xKIFGNSOAb2kP
         ddn1UCGdzQfjiHY/ye3IUtEv3cGQhgD0gSdTGSIYL4ijXX4Qschg+H2FZycS8SmjKxAc
         c0Nt5AYrRR16BtyVUrue/nlQzfw0mS8rEW9E5MlVWwcTwkeKeo+3uwIaom7sZFpNkN6t
         J7eoUcijUCezi1KnaBbX1DSDI7/WHwmeaCP14f66UNToytCnGjvYU4xpSGEoShRV2X4t
         kX7Q==
X-Gm-Message-State: AOAM532oLPRDt1AaBAFSNs61E5zuf5aEdEK7oR9HGXcEZaQDgS2c7Ubw
        s9bG/nh5wRgzGqX0O+x8S8fyQL2K6ruwww==
X-Google-Smtp-Source: ABdhPJwsfc9JLogRpWHCSxsNlmI3VG8f1/4dVSZriAF9+PcTtMi0c+fql69bubGgxLyrqfpMTNfUfw==
X-Received: by 2002:a17:906:1f49:: with SMTP id d9mr2160292ejk.150.1633148099278;
        Fri, 01 Oct 2021 21:14:59 -0700 (PDT)
Received: from [192.168.1.2] (host-87-242-33-29.prtelecom.hu. [87.242.33.29])
        by smtp.gmail.com with ESMTPSA id q6sm3570531ejm.106.2021.10.01.21.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 21:14:58 -0700 (PDT)
Message-ID: <d3edffff-c143-63c8-17de-16d4ba24f8c3@gmail.com>
Date:   Sat, 2 Oct 2021 06:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] pinctrl-intel: Fix NULL pointer dereference
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     zboszor@pr.hu, Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210920124416.7063-1-zboszor@pr.hu>
 <CAHp75VdTJ825JP51p24XJmpQORUhoTJ2=7_HOpqw-EGT1fFEOA@mail.gmail.com>
 <7f8ad14e-b2d8-676c-cd86-6ddd2dc386bb@gmail.com>
 <YVdPYQ3RsyrWXU2H@smile.fi.intel.com>
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <YVdPYQ3RsyrWXU2H@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021. 10. 01. 20:11, Andy Shevchenko wrote:
> On Tue, Sep 21, 2021 at 07:07:17AM +0200, Böszörményi Zoltán wrote:
>> On 2021. 09. 20. 18:00, Andy Shevchenko wrote:
>>> On Mon, Sep 20, 2021 at 4:00 PM <zboszor@pr.hu> wrote:
>>>> On an Elkhart Lake based POS hardware prototype, I got this Oops:
> ...
>
>>>> It's probably a firmware bug, so be overly protective:
>>> Patch is simply wrong. While Oops will be gone, the driver won't work correctly.
>> Of course. But a driver that gives up is better than a
>> crashing kernel which results in udevd and "udevadm settle"
>> stalling forever on it. systemd waits about 6 minutes before
>> continuing the boot process that involves these two services
>> timing out and this also prevents powering the computer down.
> Hiding real bugs is not a good strategy. What you may do is blacklisting it.

I got a better solution.

>>> Yes, it's either a firmware bug or the driver is outdated (depends
>>> from which side you look at this issue).
>>>
>>> I have heard that new firmware is on its way to the customers, but I
>>> have no more information right now.
>> Thanks, good to know.
>>
>> I also reported it to the manufacturer, I hope to receive
>> a response from them soon.

They responded with a kernel patch, switching the elkhartlake
pinctrl driver to probe the hardware via HID and this allowed
the driver to initialize.

>>
>> The kernel reports other firmware bugs for this
>> Celeron J6412 based machine.
> Yeah...
>

