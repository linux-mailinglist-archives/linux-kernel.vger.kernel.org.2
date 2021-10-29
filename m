Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99844019A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhJ2SB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:01:27 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49707 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhJ2SBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:01:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UuB47em_1635530333;
Received: from 192.168.31.215(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UuB47em_1635530333)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Oct 2021 01:58:54 +0800
Subject: Re: [BUG] About "io_uring: add more uring info to fdinfo for debug"
To:     Jens Axboe <axboe@kernel.dk>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
 <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk>
 <3b7dbb90-7fd5-d30f-cfe0-dd83f2cd4482@kernel.dk>
 <CANn89iJv6cRbK95Gwj=rrz2+X+Q4KQ7EtEcpz0Md0Vs1_iABPw@mail.gmail.com>
 <30b7018d-f60d-0c57-b3d6-92c1cf0762b9@kernel.dk>
 <03e9b953-a9c2-c3bc-c265-b3fff76d7739@linux.alibaba.com>
 <7c6ec470-0985-2ee8-4cbd-1f9649c7b69c@kernel.dk>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <b169a5b5-aa71-690a-f658-47dfe7a21785@linux.alibaba.com>
Date:   Sat, 30 Oct 2021 01:58:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7c6ec470-0985-2ee8-4cbd-1f9649c7b69c@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/10/30 上午1:56, Jens Axboe 写道:
> On 10/29/21 11:54 AM, Hao Xu wrote:
>> Hi Jens,
>> I was thinking that print all the entries including the unused ones
>> would make the list very long(real product use hundreds or thousands
>> while there may be just several useful sqes). And that may be confused,
>> a example is: sq_array[0-999] = 0, we have only one sqe sqes[0] in use.
>> then we'll print sqe[0] 1000 times, though we can get to know the real
>> useful one by sq_head and tail info after calculation.
>> And if only print the useful ones, exposing the original counters will
>> make the loop condition a bit simpler than exposing the ring index(since
>> the original counters depend on natural overflow) though we cannot do
>> that now since realizing issues like what Eric reports.
> 
> We can revisit in the merge window, I wrote up the pull requests for
> this branch (among others) already. The most important part was fixing
> the looping to appropriately cap it.
> 
Gotcha

