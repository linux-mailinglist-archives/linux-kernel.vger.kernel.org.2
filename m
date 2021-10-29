Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9E440184
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJ2R50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:57:26 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54807 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbhJ2R5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:57:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UuAhxjb_1635530094;
Received: from 192.168.31.215(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UuAhxjb_1635530094)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Oct 2021 01:54:54 +0800
Subject: Re: [BUG] About "io_uring: add more uring info to fdinfo for debug"
To:     Jens Axboe <axboe@kernel.dk>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
 <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk>
 <3b7dbb90-7fd5-d30f-cfe0-dd83f2cd4482@kernel.dk>
 <CANn89iJv6cRbK95Gwj=rrz2+X+Q4KQ7EtEcpz0Md0Vs1_iABPw@mail.gmail.com>
 <30b7018d-f60d-0c57-b3d6-92c1cf0762b9@kernel.dk>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <03e9b953-a9c2-c3bc-c265-b3fff76d7739@linux.alibaba.com>
Date:   Sat, 30 Oct 2021 01:54:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <30b7018d-f60d-0c57-b3d6-92c1cf0762b9@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric and Jens,
Sorry for reply late, I missed this eamil.
在 2021/10/29 下午8:40, Jens Axboe 写道:
> On 10/28/21 6:43 PM, Eric Dumazet wrote:
>> On Thu, Oct 28, 2021 at 5:13 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 10/28/21 3:40 PM, Jens Axboe wrote:
>>>> On 10/28/21 3:24 PM, Eric Dumazet wrote:
>>>>> Hi
>>>>>
>>>>> I was looking at commit 83f84356bc8f2d
>>>>> ("io_uring: add more uring info to fdinfo for debug") after receiving
>>>>> syzbot reports.
>>>>>
>>>>> I suspect that the following :
>>>>>
>>>>> +       for (i = cached_sq_head; i < sq_tail; i++) {
>>>>> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
>>>>> +
>>>>> +               if (likely(sq_idx <= sq_mask)) {
>>>>> +                       struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
>>>>> +
>>>>> +                       seq_printf(m, "%5u: opcode:%d, fd:%d, flags:%x, user_data:%llu\n",
>>>>> +                                  sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
>>>>> +               }
>>>>> +       }
>>>>>
>>>>>
>>>>> Can loop around ~2^32 times if sq_tail is close to ~0U
Hi Eric,
I do guess the syzbot manually set the sq_tail or sq_head to some
value rather than indirectly change them by push sqes into the ring like
a normal programs do. But Surely the wrong setting of sq_tail/sq_head
could happen if a user use raw io_uring api. So my Bad, thanks for
reporting!
)
>>>>>
>>>>> I see various READ_ONCE(), which are probably not good enough.
>>>>>
>>>>> At very minimum I would handling wrapping...
Sorry for my poor English, do you mean the alignment of the output?
>>>>
>>>> Thanks for reporting this. I think on top of wrapping, the loop should
>>>> just be capped at sq_entries as well. There's no point dumping more than
>>>> that, ever.
>>>>
>>>> I'll take a stab at this.
>>>
>>> I'd probably do something like this - make sure wrap is sane and that we
>>> always cap at the max number of entries we expect. This doesn't quite
>>> hold true for CQEs, but honestly for debugging purposes, we only really
>>> care about the sq ring side in terms of stalls. Or if we have unreaped
>>> CQEs, which we'll still show.
>>>
>>> This also removes the masking, as it's better to expose the ring indexes
>>> directly. And just dump the raw ring head/tail for sq/cq. We still
>>> include the cached info, but I think dumping the raw contents is saner
>>> and more useful.
Hi Jens,
I was thinking that print all the entries including the unused ones
would make the list very long(real product use hundreds or thousands
while there may be just several useful sqes). And that may be confused,
a example is: sq_array[0-999] = 0, we have only one sqe sqes[0] in use.
then we'll print sqe[0] 1000 times, though we can get to know the real
useful one by sq_head and tail info after calculation.
And if only print the useful ones, exposing the original counters will
make the loop condition a bit simpler than exposing the ring index(since
the original counters depend on natural overflow) though we cannot do
that now since realizing issues like what Eric reports.

Regards,
Hao

>>>
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 17cb0e1b88f0..babd9950ae9f 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -10065,12 +10065,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>>>          struct io_overflow_cqe *ocqe;
>>>          struct io_rings *r = ctx->rings;
>>>          unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
>>> -       unsigned int cached_sq_head = ctx->cached_sq_head;
>>> -       unsigned int cached_cq_tail = ctx->cached_cq_tail;
>>>          unsigned int sq_head = READ_ONCE(r->sq.head);
>>>          unsigned int sq_tail = READ_ONCE(r->sq.tail);
>>>          unsigned int cq_head = READ_ONCE(r->cq.head);
>>>          unsigned int cq_tail = READ_ONCE(r->cq.tail);
>>> +       unsigned int sq_entries, cq_entries;
>>>          bool has_lock;
>>>          unsigned int i;
>>>
>>> @@ -10080,15 +10079,19 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>>>           * and sq_tail and cq_head are changed by userspace. But it's ok since
>>>           * we usually use these info when it is stuck.
>>>           */
>>> -       seq_printf(m, "SqHead:\t%u\n", sq_head & sq_mask);
>>> -       seq_printf(m, "SqTail:\t%u\n", sq_tail & sq_mask);
>>> -       seq_printf(m, "CachedSqHead:\t%u\n", cached_sq_head & sq_mask);
>>> -       seq_printf(m, "CqHead:\t%u\n", cq_head & cq_mask);
>>> -       seq_printf(m, "CqTail:\t%u\n", cq_tail & cq_mask);
>>> -       seq_printf(m, "CachedCqTail:\t%u\n", cached_cq_tail & cq_mask);
>>> -       seq_printf(m, "SQEs:\t%u\n", sq_tail - cached_sq_head);
>>> -       for (i = cached_sq_head; i < sq_tail; i++) {
>>> -               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
>>> +       seq_printf(m, "SqMask:\t\t0x%x\n", sq_mask);
>>> +       seq_printf(m, "SqHead:\t%u\n", sq_head);
>>> +       seq_printf(m, "SqTail:\t%u\n", sq_tail);
>>> +       seq_printf(m, "CachedSqHead:\t%u\n", ctx->cached_sq_head);
>>> +       seq_printf(m, "CqMask:\t0x%x\n", cq_mask);
>>> +       seq_printf(m, "CqHead:\t%u\n", cq_head);
>>> +       seq_printf(m, "CqTail:\t%u\n", cq_tail);
>>> +       seq_printf(m, "CachedCqTail:\t%u\n", ctx->cached_cq_tail);
>>> +       seq_printf(m, "SQEs:\t%u\n", sq_tail - ctx->cached_sq_head);
>>> +       sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
>>> +       for (i = 0; i < sq_entries; i++) {
>>> +               unsigned int entry = i + sq_head;
>>> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[entry & sq_mask]);
>>>
>>>                  if (likely(sq_idx <= sq_mask)) {
>>>                          struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
>>> @@ -10097,9 +10100,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
>>>                                     sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
>>>                  }
>>>          }
>>> -       seq_printf(m, "CQEs:\t%u\n", cached_cq_tail - cq_head);
>>> -       for (i = cq_head; i < cached_cq_tail; i++) {
>>> -               struct io_uring_cqe *cqe = &r->cqes[i & cq_mask];
>>> +       seq_printf(m, "CQEs:\t%u\n", cq_tail - cq_head);
>>> +       cq_entries = min(cq_tail - cq_head, ctx->cq_entries);
>>> +       for (i = 0; i < cq_entries; i++) {
>>> +               unsigned int entry = i + cq_head;
>>> +               struct io_uring_cqe *cqe = &r->cqes[entry & cq_mask];
>>>
>>>                  seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x\n",
>>>                             i & cq_mask, cqe->user_data, cqe->res, cqe->flags);
>>
>> Note : you probably want to replace  (i & cq_mask) to (entry & cq_mask) here
>>
>> Otherwise, patch looks good to me.
> 
> Thanks, good catch. I've changed it.
> 

