Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724FD38F949
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhEYEUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhEYEUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:20:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=0EGd2U/04FlaESkoL8bnAvy5F/5fb4NYWjnc+HfDQxA=; b=kQPCx4iFbYAwd+aFzAg8p/Lh2y
        p9sHL81BwagkAQWru7RiUv6HB0aYvzfPn0sTB45xxuewNlqxPA5YJidUeZqpiWJAO8zKR+qh8NhiK
        Md3Qd5FU0YYAZSRGsBkhH80P8MWaL11j0aTXWY6Ct+VUGD+2FZOIotNVnqAeQK6WiPb3OXE532lG/
        Jeq2nmds0gMWXMxi7UiFI2HnvUPP77Pzk77dfG8Y4jWpGj26ohx74IhQk70YmQtYXcFad5Fj37j9o
        vJR+055eCfaz6c+Ux3AFUThfZNk8nV9aiKlItB92EI0Oco9an2D9ZaGkKq04/KKcdSijrpWxwgBm6
        gIbQqy5Q==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llOWT-003IKs-Qh; Tue, 25 May 2021 04:18:29 +0000
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
 <bfb11ab2-d606-b96e-1979-3bcc3c3adc96@infradead.org>
 <8a4ee5be-ad5c-ca06-dd1a-aa13ccc94906@redhat.com>
 <c8698ce3-4995-efd6-9d1d-095dcac70dc2@infradead.org>
 <09243238-94ba-caca-441e-3fdac0154822@infradead.org>
 <3a0fb04c-c640-25db-7e7a-fbdd3b4defb5@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0213cd4e-e832-f768-106a-345e77ce2665@infradead.org>
Date:   Mon, 24 May 2021 21:18:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <3a0fb04c-c640-25db-7e7a-fbdd3b4defb5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 5:05 PM, Waiman Long wrote:
> On 5/24/21 5:41 PM, Randy Dunlap wrote:
>> On 5/24/21 2:31 PM, Randy Dunlap wrote:
>>> On 5/24/21 2:04 PM, Waiman Long wrote:
>>>
>>>> Is it possible to just get rid of the 2nd depends-on statement?
>>>>
>>>> The 2nd depends-on line was introduced by commit 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTER"):
>>> and I should have looked at that history too. Thanks.
>>>
>>> Yes, I agree, we can just delete that line...
>>>
>>> I'll send a v2 and copy the author of commit 7d37cb2c912d as well.
>> Hm, as I review that commit, I have to wonder if the previous 'select'
>> was correct (if we disregard the Kconfig warning).  If so, then
>> FRAME_POINTER is still wanted/needed for some arch-es.
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 2779c29d9981..417c3d3e521b 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1363,7 +1363,7 @@ config LOCKDEP
>>          bool
>>          depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>          select STACKTRACE
>> -       select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86 <<<<<<<<<<<
>>
> AFAICS, enabling FRAME_POINTER is a debugging aid as it enable more precise stacktrace. However, not all archs want to enable FRAME_POINTER because of LOCKDEP. Now you are just letting users decide if they want FRAME_POINTER or not. Maybe you can modify the help text to mention that.

LOCKDEP doesn't have any user help text.

For FRAME_POINTER, when ARCH_WANT_FRAME_POINTERS + a few other conditions
is met, it seems that the FRAME_POINTER help text is good enough IMO.

	help
	  If you say Y here the resulting kernel image will be slightly
	  larger and slower, but it gives very useful debugging information
	  in case of kernel bugs. (precise oopses/stacktraces/warnings)

-- 
~Randy

