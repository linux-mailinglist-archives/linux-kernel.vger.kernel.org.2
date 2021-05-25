Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7713903AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhEYORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233756AbhEYORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621952154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlqULTQKgpp23k3zz821ZdlDSBodLG51nX7mC5euY1A=;
        b=bgTOBlUq8wjAAoWXAxN/yPI4xSeBSrqtRkXFeMR0Ws9hyrIH4lm5dsFRuLahOg8z6+o4IF
        dMFmAVUVivgI16Fej+hxUMgNNj2/0QWIaffuIMptSUP1IVF6oO3/0O4sTrQfOx+jAaJwxT
        kkedZNRRS/4HLfhvJ29QrBiLT6hBFXE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-0-TFQmi6Ojml9VDPpZDUbQ-1; Tue, 25 May 2021 10:15:51 -0400
X-MC-Unique: 0-TFQmi6Ojml9VDPpZDUbQ-1
Received: by mail-qt1-f198.google.com with SMTP id h7-20020ac846c70000b0290231af0e7829so32348qto.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nlqULTQKgpp23k3zz821ZdlDSBodLG51nX7mC5euY1A=;
        b=JaeKPkpAHwXFCqR6ZRMZ18n04l9lNKfgdFPv4Ty6pTmZ9E/CeeXsnIrnjAEQVyBaVh
         ZhUTdvTCRg42gepLPCuKRTSajUwwEHOC9wJZvLIer3jwgUSCibuD9xyTi2gd4nyhcDq+
         bGRWzGp444DdVr6o0XelJIcn3tvYPh2/Tk7Nh0iKxZWNS6H3Kjk1ySBKRp2iD0mEpIia
         t/hXy5U48pJbB3w2EVTJ76gk8vP6RWbDabg3BKR5dzoIBpYLv4mYeoW5lJzBV71XCUdr
         mjazQLuYyid7G9AaiHqKUR1q4lubgwYznPowWZVFBrKyBEnxExvKPa3OqubM01xXd4w9
         LeuA==
X-Gm-Message-State: AOAM533QFMwUMaDVbq/z+oCk4ELzunEuZcixXOZgLVpqK9b/3pK/urix
        iC1CDEwbn3H5TMRFsrrhp/zF15S6lNdHlG0W7wGP5yS3oldONtwAvcuVdVmYwWUlNXlVWCTAu+d
        GzTpJ18fw7TMY3OQjfjs3ErCA
X-Received: by 2002:ac8:7757:: with SMTP id g23mr31954677qtu.46.1621952149697;
        Tue, 25 May 2021 07:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuhv77RHaTLDz2vpI9KwRMUqN7iMGKAvxMiOkVCrF6SaL1qezOHGzvuvnqSYnRkR3GljYCiA==
X-Received: by 2002:ac8:7757:: with SMTP id g23mr31954652qtu.46.1621952149414;
        Tue, 25 May 2021 07:15:49 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id i10sm13315446qko.68.2021.05.25.07.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 07:15:48 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
To:     Randy Dunlap <rdunlap@infradead.org>,
        Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
References: <20210517034430.9569-1-rdunlap@infradead.org>
 <YKIXBpxyvhzdb1uv@gmail.com>
 <1284b997-b9da-769f-2d36-4d4232c7df88@redhat.com>
 <bfb11ab2-d606-b96e-1979-3bcc3c3adc96@infradead.org>
 <8a4ee5be-ad5c-ca06-dd1a-aa13ccc94906@redhat.com>
 <c8698ce3-4995-efd6-9d1d-095dcac70dc2@infradead.org>
 <09243238-94ba-caca-441e-3fdac0154822@infradead.org>
 <3a0fb04c-c640-25db-7e7a-fbdd3b4defb5@redhat.com>
 <0213cd4e-e832-f768-106a-345e77ce2665@infradead.org>
Message-ID: <38797295-8c65-814a-c550-298da324b988@redhat.com>
Date:   Tue, 25 May 2021 10:15:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <0213cd4e-e832-f768-106a-345e77ce2665@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 12:18 AM, Randy Dunlap wrote:
> On 5/24/21 5:05 PM, Waiman Long wrote:
>> On 5/24/21 5:41 PM, Randy Dunlap wrote:
>>> On 5/24/21 2:31 PM, Randy Dunlap wrote:
>>>> On 5/24/21 2:04 PM, Waiman Long wrote:
>>>>
>>>>> Is it possible to just get rid of the 2nd depends-on statement?
>>>>>
>>>>> The 2nd depends-on line was introduced by commit 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTER"):
>>>> and I should have looked at that history too. Thanks.
>>>>
>>>> Yes, I agree, we can just delete that line...
>>>>
>>>> I'll send a v2 and copy the author of commit 7d37cb2c912d as well.
>>> Hm, as I review that commit, I have to wonder if the previous 'select'
>>> was correct (if we disregard the Kconfig warning).  If so, then
>>> FRAME_POINTER is still wanted/needed for some arch-es.
>>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index 2779c29d9981..417c3d3e521b 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -1363,7 +1363,7 @@ config LOCKDEP
>>>           bool
>>>           depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>>           select STACKTRACE
>>> -       select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86 <<<<<<<<<<<
>>>
>> AFAICS, enabling FRAME_POINTER is a debugging aid as it enable more precise stacktrace. However, not all archs want to enable FRAME_POINTER because of LOCKDEP. Now you are just letting users decide if they want FRAME_POINTER or not. Maybe you can modify the help text to mention that.
> LOCKDEP doesn't have any user help text.
>
> For FRAME_POINTER, when ARCH_WANT_FRAME_POINTERS + a few other conditions
> is met, it seems that the FRAME_POINTER help text is good enough IMO.
>
> 	help
> 	  If you say Y here the resulting kernel image will be slightly
> 	  larger and slower, but it gives very useful debugging information
> 	  in case of kernel bugs. (precise oopses/stacktraces/warnings)
>
Right. I am fine with that.

Thanks,
Longman

