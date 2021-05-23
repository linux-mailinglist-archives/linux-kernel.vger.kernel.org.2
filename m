Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6E38D869
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 05:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEWDLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 23:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhEWDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 23:11:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=c/3S4mjblqRvWz49Q5GSxxKMFgTWlF36O3esIve3S3c=; b=fx1HuzO5D5v44oIml1QNR3pzpu
        T1GVxnnz55GMV1yqkmRLIMIYxz7lg7mhiJoe/QAOFHqXjIFgwM63K/FXy2gqqS+Zs57ndoqOSE1Lq
        SSfyet17w/3KKHrIY0a2NXzQNgMV6fvM6XUEg+1atPpqZPCCoW1Fvf5lquV+xQFqwZ5h6ZDS3eI7d
        NgPhu3bK7qU5Z7mc/HOiya+/FPm05yx3XZ0KEZkTWlo5WksYeoWQQ6M3OFsBKax78RVKghY029Or1
        Ni17KDB+QqxPkzpaBeyCCN89bzd/w/9KfWBNRyNmMd9z2M4KCvVfLKHR+2dIfWlxY/ulqPmqC1JlR
        XIJ5AR+w==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkeV1-000I5t-FV; Sun, 23 May 2021 03:09:55 +0000
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <71d07ade-af7a-8f7e-90d8-f4431943c7f1@infradead.org>
Date:   Sat, 22 May 2021 20:09:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKIXBpxyvhzdb1uv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 12:11 AM, Ingo Molnar wrote:
> 
> * Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Both arch/um/ and arch/xtensa/ cause a Kconfig warning for LOCKDEP.
>> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
>> of the arch-es that LOCKDEP depends on.
>>
>> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
>> intend to have LOCKDEP support, replace the awkward list of
>> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
>>
>> Fixes this kconfig warning: (for both um and xtensa)
>>
>> WARNING: unmet direct dependencies detected for LOCKDEP
>>   Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>>   Selected by [y]:
>>   - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>   - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>   - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>> Cc: linux-xtensa@linux-xtensa.org
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: linux-um@lists.infradead.org
>> ---
>>  lib/Kconfig.debug |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20210514.orig/lib/Kconfig.debug
>> +++ linux-next-20210514/lib/Kconfig.debug
>> @@ -1383,7 +1383,7 @@ config LOCKDEP
>>  	bool
>>  	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>  	select STACKTRACE
>> -	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
>> +	depends on FRAME_POINTER || LOCKDEP_SUPPORT
> 
> Ok - the FRAME_POINTER bit is weird. Are there any architectures that have 
> FRAME_POINTER defined but no LOCKDEP_SUPPORT?

arch/h8300/ does AFAICT.
and arch/parisc/ has user-choosable FRAME_POINTER and no LOCKDEP support.

-- 
~Randy

