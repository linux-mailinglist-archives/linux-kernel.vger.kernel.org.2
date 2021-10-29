Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88343F3BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhJ2AQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhJ2AQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:16:01 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB9C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:13:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f9so10313874ioo.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZIjyoYi9cxxIXUlxKpHqWUNrKUtbl0bRvv41mPOejoY=;
        b=jhLHedCCiT+x709J093QtCnJHfcsqJtwq4fJ9cF0euvX5fhD0ucHzWogtuB2yt8dOn
         EG9d2KP4fvdi9eTFfgAbnk7DmBBnCj13HvN5zLr3cNwXm8ficgvCvL5CNkOHcLG8Lq1r
         SOokrprsoFrunBoD4DqpvUbLVEgSoOa0EtjxvOBaBpkDrETuDMBwuk9cPHBTaeW0hTHr
         kzMgN4C4ksody1Qbr8Kalu4ZafxTXyT7ShjbD/YQqepOoN+qkj11cftjM3oYuVaPj8+e
         YXkLqiff3wVy8DudJbT9skEET55MRhVvc7vncMmXZTOFG9L7txnjYGjmu2HZ8UBBTqck
         N2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIjyoYi9cxxIXUlxKpHqWUNrKUtbl0bRvv41mPOejoY=;
        b=AjHYTUw/0aHM1pAAuq5DwJ0AklrbrVMUyjR08a988pwVIRpTsRIMSzr4HHDqWwCnX/
         VqemYfxe9FBPOVI5Bc8/gvqnHW6jYtPjzmI/WfHQQNbs87ZII/BuQBvb6heqK/yDzX4g
         StOezEGxhpOjVjeIb4MyYbnqerTBV6jgM70Iu83jY5sFeImFxOAYJCvjQ/bTlwsvQYRY
         gKIrrf72qKxJAwZZs39Bg8UcPW9cvgB8lJXcXcUkY9m+D/WFbFCQVTw8vlKiFNs94Vtr
         CC9azK4XGxkuAOXdyWavLf28+VSBCE/rtrCDE3Ztp1I2xjJz6A2rkPzbjtc1PYC8T7ZJ
         OhkQ==
X-Gm-Message-State: AOAM530turV0XvDh9dQcrZjn/hq0N/XTNyn3wSPzJuGf4NJOZlP6waWI
        xg4mPMRK6tvVthRdwH1MwkxPeg==
X-Google-Smtp-Source: ABdhPJyOoctg/YforzHBZ0T3he7zu1Zevj2JNPXBiIJOLBfVaVbc/K1DD/QxmNTyoX8QA8drDBsMmg==
X-Received: by 2002:a05:6638:d84:: with SMTP id l4mr5647164jaj.30.1635466413367;
        Thu, 28 Oct 2021 17:13:33 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x13sm2230167ile.9.2021.10.28.17.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 17:13:32 -0700 (PDT)
Subject: Re: [BUG] About "io_uring: add more uring info to fdinfo for debug"
From:   Jens Axboe <axboe@kernel.dk>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Hao Xu <haoxu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
References: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
 <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk>
Message-ID: <3b7dbb90-7fd5-d30f-cfe0-dd83f2cd4482@kernel.dk>
Date:   Thu, 28 Oct 2021 18:13:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 3:40 PM, Jens Axboe wrote:
> On 10/28/21 3:24 PM, Eric Dumazet wrote:
>> Hi
>>
>> I was looking at commit 83f84356bc8f2d
>> ("io_uring: add more uring info to fdinfo for debug") after receiving
>> syzbot reports.
>>
>> I suspect that the following :
>>
>> +       for (i = cached_sq_head; i < sq_tail; i++) {
>> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
>> +
>> +               if (likely(sq_idx <= sq_mask)) {
>> +                       struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
>> +
>> +                       seq_printf(m, "%5u: opcode:%d, fd:%d, flags:%x, user_data:%llu\n",
>> +                                  sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
>> +               }
>> +       }
>>
>>
>> Can loop around ~2^32 times if sq_tail is close to ~0U
>>
>> I see various READ_ONCE(), which are probably not good enough.
>>
>> At very minimum I would handling wrapping...
> 
> Thanks for reporting this. I think on top of wrapping, the loop should
> just be capped at sq_entries as well. There's no point dumping more than
> that, ever.
> 
> I'll take a stab at this.

I'd probably do something like this - make sure wrap is sane and that we
always cap at the max number of entries we expect. This doesn't quite
hold true for CQEs, but honestly for debugging purposes, we only really
care about the sq ring side in terms of stalls. Or if we have unreaped
CQEs, which we'll still show.

This also removes the masking, as it's better to expose the ring indexes
directly. And just dump the raw ring head/tail for sq/cq. We still
include the cached info, but I think dumping the raw contents is saner
and more useful.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 17cb0e1b88f0..babd9950ae9f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -10065,12 +10065,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 	struct io_overflow_cqe *ocqe;
 	struct io_rings *r = ctx->rings;
 	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
-	unsigned int cached_sq_head = ctx->cached_sq_head;
-	unsigned int cached_cq_tail = ctx->cached_cq_tail;
 	unsigned int sq_head = READ_ONCE(r->sq.head);
 	unsigned int sq_tail = READ_ONCE(r->sq.tail);
 	unsigned int cq_head = READ_ONCE(r->cq.head);
 	unsigned int cq_tail = READ_ONCE(r->cq.tail);
+	unsigned int sq_entries, cq_entries;
 	bool has_lock;
 	unsigned int i;
 
@@ -10080,15 +10079,19 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 	 * and sq_tail and cq_head are changed by userspace. But it's ok since
 	 * we usually use these info when it is stuck.
 	 */
-	seq_printf(m, "SqHead:\t%u\n", sq_head & sq_mask);
-	seq_printf(m, "SqTail:\t%u\n", sq_tail & sq_mask);
-	seq_printf(m, "CachedSqHead:\t%u\n", cached_sq_head & sq_mask);
-	seq_printf(m, "CqHead:\t%u\n", cq_head & cq_mask);
-	seq_printf(m, "CqTail:\t%u\n", cq_tail & cq_mask);
-	seq_printf(m, "CachedCqTail:\t%u\n", cached_cq_tail & cq_mask);
-	seq_printf(m, "SQEs:\t%u\n", sq_tail - cached_sq_head);
-	for (i = cached_sq_head; i < sq_tail; i++) {
-		unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
+	seq_printf(m, "SqMask:\t\t0x%x\n", sq_mask);
+	seq_printf(m, "SqHead:\t%u\n", sq_head);
+	seq_printf(m, "SqTail:\t%u\n", sq_tail);
+	seq_printf(m, "CachedSqHead:\t%u\n", ctx->cached_sq_head);
+	seq_printf(m, "CqMask:\t0x%x\n", cq_mask);
+	seq_printf(m, "CqHead:\t%u\n", cq_head);
+	seq_printf(m, "CqTail:\t%u\n", cq_tail);
+	seq_printf(m, "CachedCqTail:\t%u\n", ctx->cached_cq_tail);
+	seq_printf(m, "SQEs:\t%u\n", sq_tail - ctx->cached_sq_head);
+	sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
+	for (i = 0; i < sq_entries; i++) {
+		unsigned int entry = i + sq_head;
+		unsigned int sq_idx = READ_ONCE(ctx->sq_array[entry & sq_mask]);
 
 		if (likely(sq_idx <= sq_mask)) {
 			struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
@@ -10097,9 +10100,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 				   sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
 		}
 	}
-	seq_printf(m, "CQEs:\t%u\n", cached_cq_tail - cq_head);
-	for (i = cq_head; i < cached_cq_tail; i++) {
-		struct io_uring_cqe *cqe = &r->cqes[i & cq_mask];
+	seq_printf(m, "CQEs:\t%u\n", cq_tail - cq_head);
+	cq_entries = min(cq_tail - cq_head, ctx->cq_entries);
+	for (i = 0; i < cq_entries; i++) {
+		unsigned int entry = i + cq_head;
+		struct io_uring_cqe *cqe = &r->cqes[entry & cq_mask];
 
 		seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x\n",
 			   i & cq_mask, cqe->user_data, cqe->res, cqe->flags);

-- 
Jens Axboe

