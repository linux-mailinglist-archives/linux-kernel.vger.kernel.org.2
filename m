Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9353AF618
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 21:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhFUT2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 15:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230059AbhFUT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 15:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624303553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Il1Ony6YcK5r8ns4t32hJT8Wa7X//GQ16ngzusYt4pM=;
        b=Zt1BKfrEZ33h9KERzdda1sVNHUhq89cEg6JOUAPN2XqtWOfl8iJsOW4Id2kc9XgEkk2RHl
        tlj51xqvWmZafvbULjkVSbzusl3g4MdNH60T/8hg39/9akLnMaqyBCMuqQVpPssTnOzKt2
        Ph/TUiamCnjo0uvXLPOgqmDFmDa4mKU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-twJOSRVZMza4VGgdM13M8Q-1; Mon, 21 Jun 2021 15:25:51 -0400
X-MC-Unique: twJOSRVZMza4VGgdM13M8Q-1
Received: by mail-ed1-f70.google.com with SMTP id t11-20020a056402524bb029038ffacf1cafso8283000edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 12:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Il1Ony6YcK5r8ns4t32hJT8Wa7X//GQ16ngzusYt4pM=;
        b=PohIdDWPpfyepKBemSYQJPu7FW5sfySW/31/V959lUAG0SejxiuTdfKvvKtkOlrAVP
         +rD7wiYYb/lnVjFSCUJ3ooS9qovkA+q1O8N35SBgFP9pK0HzYwcnqz9U3tZM7ReTyD8W
         EPyBtM1AYHzLryv1m7mOHCzR5bAAj1XACFXZNiYHhU/DOdBCcA7w18B6/wge2DQLsPaz
         xFtvwN2AM9rqunoOBfLKdEF/L/Sd5sB7nHPfq7ljXPZ5KgV8TQINlCvv5Qr6572Z8Z1v
         u5S1LnzDf6iFLUSPRloZ1FchbJp5FVpsDiOaZCGmZ9huuRTub3QC5EBIv2yH8CIAsjR+
         iz5Q==
X-Gm-Message-State: AOAM530zmbBWiFaFcdgD3aSncvNLsFIWlsN+ELYrZG1lE60GlNJ95yuu
        MHPH62HwItleDHNov2BKj1wh63dC26/uksQSuCiGxdNOmgISdRW4xrWcza+LVMoFU1ojrvZp/lB
        48Bz/IcYKtHWenBZJT61TSmTfGQZ1iiC67/tUSn2+isCfZY5nqGhtiRcS8mcAVGOr82tIHgsC0o
        o=
X-Received: by 2002:a05:6402:17d3:: with SMTP id s19mr22794035edy.222.1624303550548;
        Mon, 21 Jun 2021 12:25:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVu++vTrNLMe2h9u6CEYuNryLjzqNOilHwBbdwm3l8FyKuszRM/A62FCLdMMfRIH28cKVHYg==
X-Received: by 2002:a05:6402:17d3:: with SMTP id s19mr22794017edy.222.1624303550320;
        Mon, 21 Jun 2021 12:25:50 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id u4sm5494718edy.60.2021.06.21.12.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 12:25:49 -0700 (PDT)
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210517164411.GH4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNPbXmm9jQcquyrNGv4M4+KW_DgcrXHsgDtH=tYQ6=RU4Q@mail.gmail.com>
 <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com>
 <YMyC/Dy7XoxTeIWb@elver.google.com>
 <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com>
 <YNBqTVFpvpXUbG4z@elver.google.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <01a0161a-44d2-5a32-7b7a-fdb13debfe57@redhat.com>
Date:   Mon, 21 Jun 2021 21:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNBqTVFpvpXUbG4z@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 12:30 PM, Marco Elver wrote:
> On Mon, Jun 21, 2021 at 10:23AM +0200, Daniel Bristot de Oliveira wrote:
> [...]
>>> Yes, unlike code/structural coverage (which is what we have today via
>>> KCOV) functional coverage checks if some interesting states were reached
>>> (e.g. was buffer full/empty, did we observe transition a->b etc.).
>>
>> So you want to observe a given a->b transition, not that B was visited?
> 
> An a->b transition would imply that a and b were visited.

HA! let's try again with a less abstract example...


  |   +------------ on --+----------------+
  v   ^                  +--------v       v
+========+               |        +===========+>--- suspend ---->+===========+
|  OFF   |               +- on --<|     ON    |                  | SUSPENDED |
+========+ <------ shutdown -----<+===========+<----- on -------<+===========+
    ^                                    v                             v
    +--------------- off ----------------+-----------------------------+

Do you care about:

1) states [OFF|ON|SUSPENDED] being visited a # of times; or
2) the occurrence of the [on|suspend|off] events a # of times; or
3) the language generated by the "state machine"; like:

   the occurrence of *"on -> suspend -> on -> off"*

         which is != of

   the occurrence of *"on -> on -> suspend -> off"*

         although the same events and states occurred the same # of times
?

RV can give you all... but the way to inform this might be different.

>> I still need to understand what you are aiming to verify, and what is the
>> approach that you would like to use to express the specifications of the systems...
>>
>> Can you give me a simple example?
> 
> The older discussion started around a discussion how to get the fuzzer
> into more interesting states in complex concurrent algorithms. But
> otherwise I have no idea ... we were just brainstorming and got to the
> point where it looked like "functional coverage" would improve automated
> test generation in general. And then I found RV which pretty much can
> specify "functional coverage" and almost gets that information to KCOV
> "for free".

I think we will end up having an almost for free solution, but worth the price.

>> so, you want to have a different function for every transition so KCOV can
>> observe that?
> 
> Not a different function, just distinct "basic blocks". KCOV uses
> compiler instrumentation, and a sequence of non-branching instructions
> denote one point of coverage; at the next branch (conditional or otherwise)
> it then records which branch was taken and therefore we know which code
> paths were covered.

ah, got it. But can't KCOV be extended with another source of information?

>>>
>>> From what I can tell this doesn't quite happen today, because
>>> automaton::function is a lookup table as an array.
>>
>> It is a the transition function of the formal automaton definition. Check this:
>>
>> https://bristot.me/wp-content/uploads/2020/01/JSA_preprint.pdf
>>
>> page 9.
>>
>> Could this just
>>> become a generated function with a switch statement? Because then I
>>> think we'd pretty much have all the ingredients we need.
>>
>> a switch statement that would.... call a different function for each transition?
> 
> No, just a switch statement that returns the same thing as it does
> today. But KCOV wouldn't see different different coverage with the
> current version because it's all in one basic block because it looks up
> the next state given the current state out of the array. If it was a
> switch statement doing the same thing, the compiler will turn the thing
> into conditional branches and KCOV then knows which code path
> (effectively the transition) was covered.

[ the answer for this points will depend on your answer from my first question
on this email so... I will reply it later ].

-- Daniel

>>> Then:
>>>
>>> 1. Create RV models for states of interests not covered by normal code
>>>    coverage of code under test.
>>>
>>> 2. Enable KCOV for everything.
>>>
>>> 3. KCOV's coverage of the RV model will tell us if we reached the
>>>    desired "functional coverage" (and can be used by e.g. syzbot to
>>>    generate better tests without any additional changes because it
>>>    already talks to KCOV).
>>>
>>> Thoughts?
>>>
>>> Thanks,
>>> -- Marco
> 

