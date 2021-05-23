Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8114C38D86A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhEWDN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEWDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 23:13:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6885C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cmMv8bNvORE9fR6CtHBRwWReFvqg6bgdLW2ZioYqDUc=; b=ba/N+aTCzPKolZlqpdZwyRlVtp
        WkuCPKDnLEkl+CQOV8VSmAX6G8s2Woo6hVtAli51IoQ7p2QFHGCCPf4l/FzXcFs+5vaFrzM0s0vzD
        EuZccUBnNNvoTWBwjEXKvi3XFuDUnBG9vpRhamNTwGtAjIUoutnslnA2rDof5q77M0zFvvzrthlVP
        SJBgbVSuDGWeP8Cr9T/6S5yCW9dcr4hpcoBcj/0dN/gOixFKA220GCfh3SIlpOoMrk7jlBb+qZmdS
        kB2sBObJ/5fD01AyfIsdnSHUfsRss64v7lAT6MV5gbXDWhWYAuRGo6RBWJu/0RTE8dAS5s1GTUqRv
        Dj5CWNwg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkeXM-000I8U-3x; Sun, 23 May 2021 03:12:20 +0000
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
To:     Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@kernel.org>
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f073a95b-5cf5-d379-4cf4-213bdf8a28e7@infradead.org>
Date:   Sat, 22 May 2021 20:12:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1284b997-b9da-769f-2d36-4d4232c7df88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 7:02 AM, Waiman Long wrote:
> On 5/17/21 3:11 AM, Ingo Molnar wrote:
>> * Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>> Both arch/um/ and arch/xtensa/ cause a Kconfig warning for LOCKDEP.
>>> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
>>> of the arch-es that LOCKDEP depends on.
>>>
>>> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
>>> intend to have LOCKDEP support, replace the awkward list of
>>> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
>>>
>>> Fixes this kconfig warning: (for both um and xtensa)
>>>
>>> WARNING: unmet direct dependencies detected for LOCKDEP
>>>    Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>>>    Selected by [y]:
>>>    - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>>    - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>>    - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Chris Zankel <chris@zankel.net>
>>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>>> Cc: linux-xtensa@linux-xtensa.org
>>> Cc: Johannes Berg <johannes@sipsolutions.net>
>>> Cc: Jeff Dike <jdike@addtoit.com>
>>> Cc: Richard Weinberger <richard@nod.at>
>>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>> Cc: linux-um@lists.infradead.org
>>> ---
>>>   lib/Kconfig.debug |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- linux-next-20210514.orig/lib/Kconfig.debug
>>> +++ linux-next-20210514/lib/Kconfig.debug
>>> @@ -1383,7 +1383,7 @@ config LOCKDEP
>>>       bool
>>>       depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>>       select STACKTRACE
>>> -    depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
>>> +    depends on FRAME_POINTER || LOCKDEP_SUPPORT
>> Ok - the FRAME_POINTER bit is weird. Are there any architectures that have
>> FRAME_POINTER defined but no LOCKDEP_SUPPORT?
> 
> LOCK_DEBUGGING_SUPPORT depends on LOCKDEP_SUPPORT. So this patch is equivalent to just delete the second depends-on line. Beside LOCKDEP, LATENCYTOP also have exactly the same depends-on line.

I will attempt to consolidate those.

> So isn't FRAME_POINTER used mainly to support STACK_TRACE? However, LOCK_DEBUGGING_SUPPORT has already included STACK_TRACE_SUPPORT in its dependency. So why there is a FRAME_POINTER dependency?

I dunno why FRAME_POINTER is there. It was there before this patch.

thanks.
-- 
~Randy

