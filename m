Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF28135E14B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhDMOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:22:12 -0400
Received: from mail.efficios.com ([167.114.26.124]:60310 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhDMOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:22:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 12B37338B7C;
        Tue, 13 Apr 2021 10:21:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9EfswI6cimaZ; Tue, 13 Apr 2021 10:21:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 82A09338956;
        Tue, 13 Apr 2021 10:21:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 82A09338956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618323708;
        bh=odGHcDlkkyoeYhCvi7gyQ5vI6O/Jo65FG1EYVJ0hYbk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=I9pUNR5kim8HOLse4couqMfUL0G7sHZ8Ia2rdjRxXcayTT20CMYmmOuot/cPuGDzm
         KtLuEvFzJqwsHlpIqGvnm6iWHbBbluNfnzql4g05u4JyabY1RulkF6F7j4kin0GzX6
         S5Rg2X6QEGQalEpjpaEm8tLWAQ6IEgqTlrT04hMC8FIfHCS2To+NdAE7ytm3ZI1rq+
         nOYFPfc0jZ81MFZDgQ+L02YNkNlDNEwsxh6ASMDtLTMKUPi5bs0Y0m/vz5hDpFL6Io
         56sUcQI6w+mFWc2ldL2kWnlgvu3k+FbAqVPb2+l5gT8dGuNVbtbE+jXRob8lkrK/LS
         0zlQMM2jJN8tQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7Gr96GPnzDJy; Tue, 13 Apr 2021 10:21:48 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7158D338DA8;
        Tue, 13 Apr 2021 10:21:48 -0400 (EDT)
Date:   Tue, 13 Apr 2021 10:21:48 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Message-ID: <644332839.71291.1618323708305.JavaMail.zimbra@efficios.com>
In-Reply-To: <fbf1a4449b0148b5b9c3baa32088c32a@AcuMS.aculab.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com> <20210413073657.2308450-4-eric.dumazet@gmail.com> <YHVf+F3sKlWyZags@hirez.programming.kicks-ass.net> <fbf1a4449b0148b5b9c3baa32088c32a@AcuMS.aculab.com>
Subject: Re: [PATCH 3/3] rseq: optimise for 64bit arches
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: optimise for 64bit arches
Thread-Index: AQHXMETc4NN4/ddyHEK6qBKOxo8eAaqyQOlAaWt3qjQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 6:36 AM, David Laight David.Laight@ACULAB.COM wrote:

> From: Peter Zijlstra
>> Sent: 13 April 2021 10:10
>> 
>> On Tue, Apr 13, 2021 at 12:36:57AM -0700, Eric Dumazet wrote:
>> > From: Eric Dumazet <edumazet@google.com>
>> >
>> > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
>> > update includes") added regressions for our servers.
>> >
>> > Using copy_from_user() and clear_user() for 64bit values
>> > on 64bit arches is suboptimal.
>> >
>> > We might revisit this patch once all 32bit arches support
>> > get_user() and/or put_user() for 8 bytes values.
>> 
>> Argh, what a mess :/ afaict only nios32 lacks put_user_8, but get_user_8
>> is missing in a fair number of archs.
>> 
>> That said; 32bit archs never have to actually set the top bits in that
>> word, so they _could_ only set the low 32 bits. That works provided
>> userspace itself keeps the high bits clear.
> 
> Does that work for 32bit BE ?

Yes, because uapi/linux/rseq.h defines the ptr32 as:

#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined(__BIG_ENDIAN)
                        __u32 padding;          /* Initialized to zero. */
                        __u32 ptr32;
#else /* LITTLE */
                        __u32 ptr32;
                        __u32 padding;          /* Initialized to zero. */
#endif /* ENDIAN */

which takes care of BE vs LE.

> 
>	David
> 
>> So I suppose that if we're going to #ifdef this, we might as well do the
>> whole thing.
>> 
>> Mathieu; did I forget a reason why this cannot work?

The only difference it brings on 32-bit is that the truncation of high bits
will be done before the following validation:

        if (!ptr) {
                memset(rseq_cs, 0, sizeof(*rseq_cs));
                return 0;
        }
        if (ptr >= TASK_SIZE)
                return -EINVAL;

The question is whether we really want to issue a segmentation fault if 32-bit
user-space has set non-zero high bits, or if silently ignoring those high
bits is acceptable.

Nits below:

>> 
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index a4f86a9d6937..94006190b8eb 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -115,20 +115,25 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>>  static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
>>  {
>>  	struct rseq_cs __user *urseq_cs;
>> -	u64 ptr;
>> +	unsigned long ptr;

I am always reluctant to use long/unsigned long type as type for the get/put_user
(x) argument, because it hides the cast deep within architecture-specific macros.
I understand that in this specific case it happens that on 64-bit archs we end up
casting a u64 to unsigned long (same size), and on 32-bit archs we end up casting a
u32 to unsigned long (also same size), so there is no practical concern about type
promotion and sign-extension, but I think it would be better to have something
explicit, e.g.:

#ifdef CONFIG_64BIT
static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp, struct rseq_cs *rseq_cs)
{
    u64 ptr;

    if (get_user(ptr, &rseq_cs->ptr64))
        return -EFAULT;
    *ptrp = (struct rseq_cs __user *)ptr;
    return 0;
}
#else
static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp, struct rseq_cs *rseq_cs)
{
    u32 ptr;

    if (get_user(ptr, &rseq_cs->ptr.ptr32))
        return -EFAULT;
    *ptrp = (struct rseq_cs __user *)ptr;
    return 0;
}
#endif

And use those helpers to get the ptr value.

>>  	u32 __user *usig;
>>  	u32 sig;
>>  	int ret;
>> 
>> -	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
>> +#ifdef CONFIG_64BIT
>> +	if (get_user(ptr, &t->rseq->rseq_cs.ptr64))
>>  		return -EFAULT;
>> +#else
>> +	if (get_user(ptr, &t->rseq->rseq_cs.ptr32))

Note that this is also not right. It should be &t->rseq->rseq_cs.ptr.ptr32.

Thanks,

Mathieu

>> +		return -EFAULT;
>> +#endif
>>  	if (!ptr) {
>>  		memset(rseq_cs, 0, sizeof(*rseq_cs));
>>  		return 0;
>>  	}
>>  	if (ptr >= TASK_SIZE)
>>  		return -EINVAL;
>> -	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
>> +	urseq_cs = (struct rseq_cs __user *)ptr;
>>  	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
>>  		return -EFAULT;
>> 
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT,
> UK
> Registration No: 1397386 (Wales)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
