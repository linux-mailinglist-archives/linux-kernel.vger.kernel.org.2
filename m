Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6B4254C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbhJGNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:54:07 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43588
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241611AbhJGNyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:54:06 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9B8D73F328;
        Thu,  7 Oct 2021 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633614731;
        bh=yj4ipj7TovnF2emyJEKur8J+OhgS19wKBi0gQQl0MR4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rj1B9+pdqZ303MIif3t8nBbcellnPb18yxUU7ROgpGbxYqaB+YRE1ujelp4WP/lJY
         IvsX9eHUIW1h0m5EStO6T0RRNdEcbI54JOy6L8dX3JMloqFtXBo6xIzWtOrETFi6LT
         AMbL2MRupy69qPdfihAW9tZYEcu5kEPbhGH0iaWw/YQOWql23AxaFq1NpOrxgrmsxJ
         EMSkaMi4/6rAMMny0kOmBRnf1/FNt3BO+Uhmi8HFSbz7AVMMNwxz44vi3OzwFwklV9
         Z5GiQSp4fVAIZsVD8WoCR5bqZ4BhEoesGiG7EpVRmlMKoqksqxWkv4Hsb8VVsSRfy4
         meNV4XYUwFHtQ==
Message-ID: <e4f44c10-7600-5c50-7cd8-2044014b2e0d@canonical.com>
Date:   Thu, 7 Oct 2021 14:52:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: tracing: Create a sparse bitmask for pid filtering
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <221bc7ba-a475-1cb9-1bbe-730bb9c2d448@canonical.com>
 <20211007095115.5d26c558@gandalf.local.home>
From:   Colin Ian King <colin.king@canonical.com>
In-Reply-To: <20211007095115.5d26c558@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 14:51, Steven Rostedt wrote:
> On Thu, 7 Oct 2021 12:26:32 +0100
> Colin Ian King <colin.king@canonical.com> wrote:
> 
>> Hi,
>>
>> Static analysis on linux-next with Coverity has identified two issues
>> with reads of initialized pointers in the following commit:
>>
>> commit 8d6e90983ade25ec7925211ac31d9ccaf64b7edf
>> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Date:   Thu Sep 23 22:20:57 2021 -0400
>>
>>       tracing: Create a sparse bitmask for pid filtering
>>
>> The analysis is as follows:
>>
>> 332 static void pid_list_refill_irq(struct irq_work *iwork)
>> 333 {
>>
>>      1. Condition 0 /* !!(!__builtin_types_compatible_p() &&
>> !__builtin_types_compatible_p()) */, taking false branch.
> 
> What does the above mean?
> 
>>
>> 334        struct trace_pid_list *pid_list = container_of(iwork, struct
>> trace_pid_list,
>> 335                                                       refill_irqwork);
>>
>>      2. var_decl: Declaring variable upper without initializer.
> 
> Hmm, I think this is legit. I should have both upper and lower initialized
> as NULL.
> 
>>
>> 336        union upper_chunk *upper;
>> 337        union lower_chunk *lower;
>> 338        union upper_chunk **upper_next = &upper;
>> 339        union lower_chunk **lower_next = &lower;
>> 340        int upper_count;
>> 341        int lower_count;
>> 342        int ucnt = 0;
>> 343        int lcnt = 0;
>> 344
>> 345 again:
>> 346        raw_spin_lock(&pid_list->lock);
>> 347        upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
>> 348        lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
>> 349        raw_spin_unlock(&pid_list->lock);
>> 350
>>
>>      3. Condition upper_count <= 0, taking false branch.
> 
> What does the above mean?
> 
>>
>> 351        if (upper_count <= 0 && lower_count <= 0)
>> 352                return;
>> 353
>>
>>      4. Condition upper_count-- > 0, taking true branch.
>>
>> 354        while (upper_count-- > 0) {
>> 355                union upper_chunk *chunk;
>> 356
>> 357                chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
>>
>>      5. Condition !chunk, taking true branch.
>> 358                if (!chunk)
>>      6. Breaking from loop.
>>
>> 359                        break;
>> 360                *upper_next = chunk;
>> 361                upper_next = &chunk->next;
>> 362                ucnt++;
>> 363        }
>> 364
>>
>>      7. Condition lower_count-- > 0, taking true branch.
>>
>> 365        while (lower_count-- > 0) {
>> 366                union lower_chunk *chunk;
>> 367
>> 368                chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
>>
>>      8. Condition !chunk, taking true branch.
>>
>> 369                if (!chunk)
>>
>>      9. Breaking from loop.
>>
>> 370                        break;
>> 371                *lower_next = chunk;
>> 372                lower_next = &chunk->next;
>> 373                lcnt++;
>> 374        }
>> 375
>> 376        raw_spin_lock(&pid_list->lock);
>>
>>       Uninitialized pointer read (UNINIT)
>>       10. uninit_use: Using uninitialized value upper.
> 
> Agreed.
> 
>>
>> 377        if (upper) {
>> 378                *upper_next = pid_list->upper_list;
>> 379                pid_list->upper_list = upper;
>> 380                pid_list->free_upper_chunks += ucnt;
>> 381        }
>>
>>       Uninitialized pointer read (UNINIT)
>>       11. uninit_use: Using uninitialized value lower.
> 
> Agreed.
> 
>>
>> 382        if (lower) {
>> 383                *lower_next = pid_list->lower_list;
>> 384                pid_list->lower_list = lower;
>> 385                pid_list->free_lower_chunks += lcnt;
>> 386        }
>> 387        raw_spin_unlock(&pid_list->lock);
>> 388
>>
>> Colin
> 
> So is this just a fancy way of saying that upper and lower were
> uninitialized?

Basically, yes. But it shows how the static analyzer determined this :-)

> 
> -- Steve
> 

