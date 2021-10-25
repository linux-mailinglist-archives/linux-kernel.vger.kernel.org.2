Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE2439A81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhJYPbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233933AbhJYPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635175760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1cYYIVh+xGjWZ5+lH9xxF7m8Jg6vgobu0WCRcUUQ6o=;
        b=Jfc3ohafT0if8FO2xeF85mHEJWlNBNm5tMK7PsQi4/9LavwDJWCdmI5sesOc2NuWbMp7qU
        g/Latb9279tnr7gKJpP2rXaX7YgCmBgqXaLpeu465R7MlfFM9QVLYqSOZn6TO+wNY7yClO
        IrEUgZ8z7YH9jMoAca76kAN1VxXew1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-x4xQsDwWOV62UjcxFemc8Q-1; Mon, 25 Oct 2021 11:28:47 -0400
X-MC-Unique: x4xQsDwWOV62UjcxFemc8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDC93362FD;
        Mon, 25 Oct 2021 15:28:43 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.18.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E34335D6D5;
        Mon, 25 Oct 2021 15:28:37 +0000 (UTC)
Subject: Re: [PATCH] locking: remove spin_lock_flags() etc
To:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20211022120058.1031690-1-arnd@kernel.org>
 <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
 <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
 <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net>
 <CAK8P3a2Luz7sd5cM1OdZhYCs_UPzo+2qVQYSZPfR2QN+0DkyRg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Message-ID: <2413f412-a390-bbc0-e848-e2a77d1f0ab3@redhat.com>
Date:   Mon, 25 Oct 2021 11:28:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Luz7sd5cM1OdZhYCs_UPzo+2qVQYSZPfR2QN+0DkyRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/25/21 9:06 AM, Arnd Bergmann wrote:
> On Mon, Oct 25, 2021 at 11:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Sat, Oct 23, 2021 at 06:04:57PM +0200, Arnd Bergmann wrote:
>>> On Sat, Oct 23, 2021 at 3:37 AM Waiman Long <longman@redhat.com> wrote:
>>>>> On 10/22/21 7:59 AM, Arnd Bergmann wrote:
>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>>
>>>>> As this is all dead code, just remove it and the helper functions built
>>>>> around it. For arch/ia64, the inline asm could be cleaned up, but
>>>>> it seems safer to leave it untouched.
>>>>>
>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Does that mean we can also remove the GENERIC_LOCKBREAK config option
>>>> from the Kconfig files as well?
>>>   I couldn't figure this out.
>>>
>>> What I see is that the only architectures setting GENERIC_LOCKBREAK are
>>> nds32, parisc, powerpc, s390, sh and sparc64, while the only architectures
>>> implementing arch_spin_is_contended() are arm32, csky and ia64.
>>>
>>> The part I don't understand is whether the option actually does anything
>>> useful any more after commit d89c70356acf ("locking/core: Remove break_lock
>>> field when CONFIG_GENERIC_LOCKBREAK=y").
>> Urgh, what a mess.. AFAICT there's still code in
>> kernel/locking/spinlock.c that relies on it. Specifically when
>> GENERIC_LOCKBREAK=y we seem to create _lock*() variants that are
>> basically TaS locks which drop preempt/irq disable while spinning.
>>
>> Anybody having this on and not having native TaS locks is in for a rude
>> surprise I suppose... sparc64 being the obvious candidate there :/
> Is this a problem on s390 and powerpc, those two being the ones
> that matter in practice?
>
> On s390, we pick between the cmpxchg() based directed-yield when
> running on virtualized CPUs, and a normal qspinlock when running on a
> dedicated CPU.

I am not aware that s390 is using qspinlocks at all as I don't see 
ARCH_USE_QUEUED_SPINLOCKS being set anywhere under arch/s390. I only see 
that it uses a cmpxchg based spinlock.

Cheers,
Longman



