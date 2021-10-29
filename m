Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7C43FC70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhJ2MnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhJ2MnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:43:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E0C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:40:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l7so10467526iln.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YscSIkBLF4wuDWQrJPG8y8OnN+Mj/mesrntFP3HWYQY=;
        b=XJxcHMNZTn6L9Ghk6y2RwTtj7oo/T1zQoZ1Gcy27JrB458KqhxdTTAD6vHkX7h2iBh
         yyZ97quXEmook5gmISSxMqtjLAnCPvEdTFR7TrGFmfbThb482VGNHkcTCsNi2lFwAGcz
         hztXtkGQfyM46WRx2wob8CzQ08yCeJbF/tfRMiy02/83aX+PnDjQDBigP4vJDW2U0kU9
         41d37PV5WIXyLzb+IqPgsyWtf2ttbo/RwajDfBg0TXL2QXQ9LuabNEAADSxT3aMeqGQx
         HaRxkekccwY/fatre5HPz83Wfxn6yhF/2TXXMJvzZPUgqBEZkdkRtqZ/v+BsbBCtFOiQ
         MCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YscSIkBLF4wuDWQrJPG8y8OnN+Mj/mesrntFP3HWYQY=;
        b=Tpen7//YVrXf/V22XfjtCcgTky9aNChgwoLCb/Jg/PBygsPUtat/UPhpVVxNM+jTVX
         K+9TId5ZJdZDHdZXRhxj7K2GqTeJwDT5aEUiyvX0fciqMj+T+36xMxmoI2BTNtnRKs3D
         KKL93JnhYqoATliEJf/u9/+gU3ZuH5hrU3p22qpna9O5xiVzCkSMWQjLcQovEWtcj+Rc
         dKzQYkGqk+/1ZpmxA+3P9Rm4Ft4yq7j9fhQ/5WE9BmlrgiLdMtuIphnhDqGASv3KeV/k
         aDStUmd+f2Rd99xbUPCiaNSo78l34ZChlZ5TYYdAQYcVXlMRk2hESUh5okSEKoGI4t7p
         gaTg==
X-Gm-Message-State: AOAM532fFj5CDTFfkpwIVVhA5qkrRD0zMrj4SWqosvWgF8iwtIYTMknn
        +43+XAoQiXanAymz26b8GPmReN/vBc0XMA==
X-Google-Smtp-Source: ABdhPJyjP55MLSD+Uq6YI2k2YVpjCl6Y3Ek500BLrmkpz54Al0Gvyiq7xl0yLnlk0rcjrxk33g9N1Q==
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr7232988ils.289.1635511235653;
        Fri, 29 Oct 2021 05:40:35 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v4sm2992092ilq.57.2021.10.29.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 05:40:35 -0700 (PDT)
Subject: Re: [BUG] About "io_uring: add more uring info to fdinfo for debug"
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Hao Xu <haoxu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
 <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk>
 <3b7dbb90-7fd5-d30f-cfe0-dd83f2cd4482@kernel.dk>
 <CANn89iJv6cRbK95Gwj=rrz2+X+Q4KQ7EtEcpz0Md0Vs1_iABPw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30b7018d-f60d-0c57-b3d6-92c1cf0762b9@kernel.dk>
Date:   Fri, 29 Oct 2021 06:40:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANn89iJv6cRbK95Gwj=rrz2+X+Q4KQ7EtEcpz0Md0Vs1_iABPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 6:43 PM, Eric Dumazet wrote:
> On Thu, Oct 28, 2021 at 5:13 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/28/21 3:40 PM, Jens Axboe wrote:
>>> On 10/28/21 3:24 PM, Eric Dumazet wrote:
>>>> Hi
>>>>
>>>> I was looking at commit 83f84356bc8f2d
>>>> ("io_uring: add more uring info to fdinfo for debug") after receiving
>>>> syzbot reports.
>>>>
>>>> I suspect that the following :
>>>>
>>>> +       for (i = cached_sq_head; i < sq_tail; i++) {
>>>> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
>>>> +
>>>> +               if (likely(sq_idx <= sq_mask)) {
>>>> +                       struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
>>>> +
>>>> +                       seq_printf(m, "%5u: opcode:%d, fd:%d, flags:%x, user_data:%llu\n",
>>>> +                                  sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
>>>> +               }
>>>> +       }
>>>>
>>>>
>>>> Can loop around ~2^32 times if sq_tail is close to ~0U
>>>>
>>>> I see various READ_ONCE(), which are probably not good enough.
>>>>
>>>> At very minimum I would handling wrapping...
>>>
>>> Thanks for reporting this. I think on top of wrapping, the loop should
>>> just be capped at sq_entries as well. There's no point dumping more than
>>> that, ever.
>>>
>>> I'll take a stab at this.
>>
>> I'd probably do something like this - make sure wrap is sane and that we
>> always cap at the max number of entries we expect. This doesn't quite
>> hold true for CQEs, but honestly for debugging purposes, we only really
>> care about the sq ring side in terms of stalls. Or if we have unreaped
>> CQEs, which we'll still show.
>>
>> This also removes the masking, as it's better to expose the ring indexes
>> directly. And just dump the raw ring head/tail for sq/cq. We still
>> include the cached info, but I think dumping the raw contents is saner
>> and more useful.
>>
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 17cb0e1b88f0..babd9950ae9f 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -10065,12 +10065,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>>         struct io_overflow_cqe *ocqe;
>>         struct io_rings *r = ctx->rings;
>>         unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
>> -       unsigned int cached_sq_head = ctx->cached_sq_head;
>> -       unsigned int cached_cq_tail = ctx->cached_cq_tail;
>>         unsigned int sq_head = READ_ONCE(r->sq.head);
>>         unsigned int sq_tail = READ_ONCE(r->sq.tail);
>>         unsigned int cq_head = READ_ONCE(r->cq.head);
>>         unsigned int cq_tail = READ_ONCE(r->cq.tail);
>> +       unsigned int sq_entries, cq_entries;
>>         bool has_lock;
>>         unsigned int i;
>>
>> @@ -10080,15 +10079,19 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>>          * and sq_tail and cq_head are changed by userspace. But it's ok since
>>          * we usually use these info when it is stuck.
>>          */
>> -       seq_printf(m, "SqHead:\t%u\n", sq_head & sq_mask);
>> -       seq_printf(m, "SqTail:\t%u\n", sq_tail & sq_mask);
>> -       seq_printf(m, "CachedSqHead:\t%u\n", cached_sq_head & sq_mask);
>> -       seq_printf(m, "CqHead:\t%u\n", cq_head & cq_mask);
>> -       seq_printf(m, "CqTail:\t%u\n", cq_tail & cq_mask);
>> -       seq_printf(m, "CachedCqTail:\t%u\n", cached_cq_tail & cq_mask);
>> -       seq_printf(m, "SQEs:\t%u\n", sq_tail - cached_sq_head);
>> -       for (i = cached_sq_head; i < sq_tail; i++) {
>> -               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
>> +       seq_printf(m, "SqMask:\t\t0x%x\n", sq_mask);
>> +       seq_printf(m, "SqHead:\t%u\n", sq_head);
>> +       seq_printf(m, "SqTail:\t%u\n", sq_tail);
>> +       seq_printf(m, "CachedSqHead:\t%u\n", ctx->cached_sq_head);
>> +       seq_printf(m, "CqMask:\t0x%x\n", cq_mask);
>> +       seq_printf(m, "CqHead:\t%u\n", cq_head);
>> +       seq_printf(m, "CqTail:\t%u\n", cq_tail);
>> +       seq_printf(m, "CachedCqTail:\t%u\n", ctx->cached_cq_tail);
>> +       seq_printf(m, "SQEs:\t%u\n", sq_tail - ctx->cached_sq_head);
>> +       sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
>> +       for (i = 0; i < sq_entries; i++) {
>> +               unsigned int entry = i + sq_head;
>> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[entry & sq_mask]);
>>
>>                 if (likely(sq_idx <= sq_mask)) {
>>                         struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
>> @@ -10097,9 +10100,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>>                                    sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
>>                 }
>>         }
>> -       seq_printf(m, "CQEs:\t%u\n", cached_cq_tail - cq_head);
>> -       for (i = cq_head; i < cached_cq_tail; i++) {
>> -               struct io_uring_cqe *cqe = &r->cqes[i & cq_mask];
>> +       seq_printf(m, "CQEs:\t%u\n", cq_tail - cq_head);
>> +       cq_entries = min(cq_tail - cq_head, ctx->cq_entries);
>> +       for (i = 0; i < cq_entries; i++) {
>> +               unsigned int entry = i + cq_head;
>> +               struct io_uring_cqe *cqe = &r->cqes[entry & cq_mask];
>>
>>                 seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x\n",
>>                            i & cq_mask, cqe->user_data, cqe->res, cqe->flags);
> 
> Note : you probably want to replace  (i & cq_mask) to (entry & cq_mask) here
> 
> Otherwise, patch looks good to me.

Thanks, good catch. I've changed it.

-- 
Jens Axboe

