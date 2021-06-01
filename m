Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2945738F218
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhEXRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:15:34 -0400
Received: from mail.itouring.de ([85.10.202.141]:58410 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232543AbhEXRPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:15:32 -0400
Received: from tux.applied-asynchrony.com (p5ddd760d.dip0.t-ipconnect.de [93.221.118.13])
        by mail.itouring.de (Postfix) with ESMTPSA id D1C9EE0;
        Mon, 24 May 2021 19:13:59 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 7D39DF01600;
        Mon, 24 May 2021 19:13:59 +0200 (CEST)
Subject: Re: [PATCH BUGFIX] block, bfq: fix delayed stable merge check
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Luca Mariotti <mariottiluca1@hotmail.it>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>
References: <DB8PR01MB59647C41BF6C964467EAFE0D882C9@DB8PR01MB5964.eurprd01.prod.exchangelabs.com>
 <f23f8090-4a55-3c16-1bdd-f86634cd6f3b@applied-asynchrony.com>
 <E9D95C99-D07B-4A63-8C0E-67356887DE23@linaro.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <c6a3d259-a118-0c7a-0faf-1ab48f9cd2ff@applied-asynchrony.com>
Date:   Mon, 24 May 2021 19:13:59 +0200
MIME-Version: 1.0
In-Reply-To: <E9D95C99-D07B-4A63-8C0E-67356887DE23@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-24 18:57, Paolo Valente wrote:
> 
> 
>> Il giorno 20 mag 2021, alle ore 09:15, Holger Hoffstätte <holger@applied-asynchrony.com> ha scritto:
>>
>> On 2021-05-18 12:43, Luca Mariotti wrote:
>>> When attempting to schedule a merge of a given bfq_queue with the currently
>>> in-service bfq_queue or with a cooperating bfq_queue among the scheduled
>>> bfq_queues, delayed stable merge is checked for rotational or non-queueing
>>> devs. For this stable merge to be performed, some conditions must be met.
>>> If the current bfq_queue underwent some split from some merged bfq_queue,
>>> one of these conditions is that two hundred milliseconds must elapse from
>>> split, otherwise this condition is always met.
>>> Unfortunately, by mistake, time_is_after_jiffies() was written instead of
>>> time_is_before_jiffies() for this check, verifying that less than two
>>> hundred milliseconds have elapsed instead of verifying that at least two
>>> hundred milliseconds have elapsed.
>>> Fix this issue by replacing time_is_after_jiffies() with
>>> time_is_before_jiffies().
>>> Signed-off-by: Luca Mariotti <mariottiluca1@hotmail.it>
>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>> Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
>>> ---
>>>   block/bfq-iosched.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index acd1f881273e..2adb1e69c9d2 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -2697,7 +2697,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>>   	if (unlikely(!bfqd->nonrot_with_queueing)) {
>>>   		if (bic->stable_merge_bfqq &&
>>>   		    !bfq_bfqq_just_created(bfqq) &&
>>> -		    time_is_after_jiffies(bfqq->split_time +
>>> +		    time_is_before_jiffies(bfqq->split_time +
>>>   					  msecs_to_jiffies(200))) {
>>>   			struct bfq_queue *stable_merge_bfqq =
>>>   				bic->stable_merge_bfqq;
>>
>> Not sure why but with this patch I quickly got a division-by-zero in BFQ and
>> complete system halt. Unfortunately I couldn't capture the exact stack trace,
>> but it read something like bfq_calc_weight() or something ike that.
>> I looked through the code and found bfq_delta(), so maybe weight got
>> reduced to 0?
>>
> 
> Hi Holger,
> is this (easily) reproducible for you?  If so, I'd like to propose you
> a candidate fix.

Yes, it's easily reproducible (should be reproducible on 5.13-rc as well).
Simple read/write I/O on a cold FS (rotational disk obviously) will crash
pretty much immediately; without it everything works fine, likely because the
bug (in the recent queue merging patches?) is never triggered due to the
accidentally-wrong time calculation.
Will gladly test your patch! :)

cheers
Holger
