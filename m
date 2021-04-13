Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CFC35E498
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347058AbhDMRGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:06:40 -0400
Received: from mail.efficios.com ([167.114.26.124]:33290 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347043AbhDMRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:06:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E356F33A20A;
        Tue, 13 Apr 2021 13:06:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nV-TYNVwFc6v; Tue, 13 Apr 2021 13:06:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1FD54339D6F;
        Tue, 13 Apr 2021 13:06:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1FD54339D6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618333577;
        bh=vHmhjXFwQhXH+npqzv3ukS8I0APCahtWGKpyH/xPokw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AHZ9tU+z6OLfkZR1nBI192q2jZhbIBWSFoRla92Vlxnd8ceKpm9pPCnOAIfhyFd78
         uw0Z8PI3W1ThR9ueITaoQE3uQ+V2v1W/UJSJNvfwhJkJr1GtMZ78Zf+CVpT3tNi+Tw
         /ONkYhaCvxoukDx9FGohannXENqEnZJTbLfMYGR/pqi3SNiLzbq3rlOjIFu4cU0TG5
         Ymu/LwCkLbdI1xKLe4N41IspxjUUu3nXbT5vyWZiBHKsigzo7w/AYEqgDU2hHcDJI+
         IUTrC80yR8bc1iLiCf8M+HMVpQjnR2ql+TvzQ99dDaohowlzxr+wH3h4n2VbTuHJA4
         GOEbXSz42OXyw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j4aJFYh4MM7R; Tue, 13 Apr 2021 13:06:17 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 11DD3339D6C;
        Tue, 13 Apr 2021 13:06:17 -0400 (EDT)
Date:   Tue, 13 Apr 2021 13:06:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <373117462.72486.1618333576943.JavaMail.zimbra@efficios.com>
In-Reply-To: <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com> <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com> <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
Thread-Index: gDWgyfjD48QmXBvYCDwQptq2oJSmLg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 12:57 PM, Eric Dumazet edumazet@google.com wrote:

> On Tue, Apr 13, 2021 at 6:54 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Apr 13, 2021, at 12:22 PM, Eric Dumazet eric.dumazet@gmail.com wrote:
>>
>> > From: Eric Dumazet <edumazet@google.com>
>> >
>> > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
>> > update includes") added regressions for our servers.
>> >
>> > Using copy_from_user() and clear_user() for 64bit values
>> > is suboptimal.
>> >
>> > We can use faster put_user() and get_user().
>> >
>> > 32bit arches can be changed to use the ptr32 field,
>> > since the padding field must always be zero.
>> >
>> > v2: added ideas from Peter and Mathieu about making this
>> >    generic, since my initial patch was only dealing with
>> >    64bit arches.
>>
>> Ah, now I remember the reason why reading and clearing the entire 64-bit
>> is important: it's because we don't want to allow user-space processes to
>> use this change in behavior to figure out whether they are running on a
>> 32-bit or in a 32-bit compat mode on a 64-bit kernel.
>>
>> So although I'm fine with making 64-bit kernels faster, we'll want to keep
>> updating the entire 64-bit ptr field on 32-bit kernels as well.
>>
>> Thanks,
>>
> 
> So... back to V1 then ?

In terms of behavior, yes. And it's probably the "easy" fix, but I hate that
it adds lots of preprocessor ifdefs into the rseq code.

But this would require auditing get_user()/put_user() for each architecture
supported by rseq to ensure they support 8-byte load/store. And it would become
an added burden on architecture maintainers wishing to add rseq support for their
architecture.

One alternative would be to implement rseq_get_user_u64 and rseq_put_user_u64
wrappers as static functions within rseq.c to hide the preprocessor ifdeffery
from the higher-level code. I try very hard to avoid mixing preprocessor ifdefs
with C code logic whenever I can.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
