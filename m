Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BED38F4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhEXVGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 17:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232859AbhEXVGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621890302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdaLxiwYd0OKcfKpEiCU3jQhUReNdQ+hXTieDbqU8Ng=;
        b=MGtTnx/IXWlmxmjeMs93FMuffaF0BlfUkU1hCpuciS8xM+MZtopZ8DF3fH7y8yyoOizFFG
        APYuD1wa+6Q0UNLdRy2iSicPgPg22uOHRt4b7qdhOIt4XoYFrDSwaazUB0zKTS1YNJImmL
        hlWUUaCm84mzqFzertGsby1GIU/PHKY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-UiNsIF_rN1WXuJOc0JZv3w-1; Mon, 24 May 2021 17:05:00 -0400
X-MC-Unique: UiNsIF_rN1WXuJOc0JZv3w-1
Received: by mail-qt1-f197.google.com with SMTP id u3-20020a05622a0103b02902274c59d552so7002178qtw.23
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kdaLxiwYd0OKcfKpEiCU3jQhUReNdQ+hXTieDbqU8Ng=;
        b=ojIwrZtO3yhOoePv3G7hQV9LN8DjkNSLNB5xZfOH8b7QmFQW5aDGMw7ICRF1P3Pvn/
         ORR3bBBFFzSlupNH06uNYFcn7JLu4sXV3Axk/4IgBIFVNMuUVqfRWZBrfNZhvJCSE7fI
         7BX6rp1/UZMtQENvqSf4baV9rFjCbmLY/6nu0LMaAZlFcUc6rYKW3yB5P+Fu8bULprTi
         wImCoRjIrT8dJJddXSc5PtAN4+161ryl64uafO4zadBixvQAL96rkSCJ/8oUCszUwnHm
         ZFXqSOrXEu7oEwkhGPx7I8D+/kmcbhDlgO6rywPQ0M9ly82gUXSzpG0coWGAnLbgB18R
         rD3g==
X-Gm-Message-State: AOAM5324hyCcTjYulm27ot7cJuP9XKQqoe8NvkJHr+g5jI7Y3SGRcBvL
        q0B0uE5RZp7aObmuQ+ukAJuRRl0JkdR4VlAJgAXpEB/usH7VsC4ThZnj2DWKtgwbYp6l75/mdXy
        vcpvN3dJasA2lql0pFYvanUH+
X-Received: by 2002:a05:622a:28c:: with SMTP id z12mr12618849qtw.75.1621890298401;
        Mon, 24 May 2021 14:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+EhoRdfCwcVQAO0Ea9rcrxiK5bAAB0bTrOwSzaFCO7YgpRJScMN7Nk0kOvyvjwRf5l2wH/w==
X-Received: by 2002:a05:622a:28c:: with SMTP id z12mr12618830qtw.75.1621890298194;
        Mon, 24 May 2021 14:04:58 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f17sm5139085qto.68.2021.05.24.14.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 14:04:57 -0700 (PDT)
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
Message-ID: <8a4ee5be-ad5c-ca06-dd1a-aa13ccc94906@redhat.com>
Date:   Mon, 24 May 2021 17:04:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <bfb11ab2-d606-b96e-1979-3bcc3c3adc96@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 3:47 PM, Randy Dunlap wrote:
> On 5/17/21 7:02 AM, Waiman Long wrote:
>> On 5/17/21 3:11 AM, Ingo Molnar wrote:
>>> * Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>> Both arch/um/ and arch/xtensa/ cause a Kconfig warning for LOCKDEP.
>>>> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
>>>> of the arch-es that LOCKDEP depends on.
>>>>
>>>> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
>>>> intend to have LOCKDEP support, replace the awkward list of
>>>> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
>>>>
>>>> Fixes this kconfig warning: (for both um and xtensa)
>>>>
>>>> WARNING: unmet direct dependencies detected for LOCKDEP
>>>>     Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>>>>     Selected by [y]:
>>>>     - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>>>     - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>>>     - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Waiman Long <longman@redhat.com>
>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>> Cc: Chris Zankel <chris@zankel.net>
>>>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>>>> Cc: linux-xtensa@linux-xtensa.org
>>>> Cc: Johannes Berg <johannes@sipsolutions.net>
>>>> Cc: Jeff Dike <jdike@addtoit.com>
>>>> Cc: Richard Weinberger <richard@nod.at>
>>>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>> Cc: linux-um@lists.infradead.org
>>>> ---
>>>>    lib/Kconfig.debug |    2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> --- linux-next-20210514.orig/lib/Kconfig.debug
>>>> +++ linux-next-20210514/lib/Kconfig.debug
>>>> @@ -1383,7 +1383,7 @@ config LOCKDEP
>>>>        bool
>>>>        depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>>>        select STACKTRACE
>>>> -    depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
>>>> +    depends on FRAME_POINTER || LOCKDEP_SUPPORT
>>> Ok - the FRAME_POINTER bit is weird. Are there any architectures that have
>>> FRAME_POINTER defined but no LOCKDEP_SUPPORT?
>> LOCK_DEBUGGING_SUPPORT depends on LOCKDEP_SUPPORT. So this patch is equivalent to just delete the second depends-on line.
> Yes, if we disregard the FRAME_POINTER part.

My understanding is that the 2 depends-on statements have an implicit 
AND. So it is like

DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || 
LOCKDEP_SUPPORT). LOCK_DEBUGGING_SUPPORT is true means the 
(FRAME_POINTER || LOCKDEP_SUPPORT) will always be true. FRAME_POINTER is 
true doesn't mean the other dependencies are true. That is why I said it 
is equivalent to just "DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT". IOW, 
FRAME_POINTER will play no part here.

>
>> Beside LOCKDEP, LATENCYTOP also have exactly the same depends-on line.
> True, but I don't get any implication that the same patch applies there.
> Do you?
It is just an observation that I stumble on. It is not related to your 
patch.
>> So isn't FRAME_POINTER used mainly to support STACK_TRACE? However, LOCK_DEBUGGING_SUPPORT has already included STACK_TRACE_SUPPORT in its dependency. So why there is a FRAME_POINTER dependency?
> FRAME_POINTER is one way but it does not seem to be required
> for STACKTRACE_SUPPORT.
>
> Do you have any patch suggestions?

Is it possible to just get rid of the 2nd depends-on statement?

The 2nd depends-on line was introduced by commit 7d37cb2c912d ("lib: fix 
kconfig dependency on ARCH_WANT_FRAME_POINTER"):

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29d9981..417c3d3e521b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1363,7 +1363,7 @@ config LOCKDEP
         bool
         depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
         select STACKTRACE
-       select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && 
!MICROBLAZE &&
+       depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || 
ARM ||
         select KALLSYMS
         select KALLSYMS_ALL

Since STACKTRACE is selected by lockdep, maybe we can just remove the 
2nd depends-on line to see if anyone complain.

Cheers,
Longman

