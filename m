Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FCD34820A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhCXThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:37:36 -0400
Received: from foss.arm.com ([217.140.110.172]:38528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237907AbhCXThE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:37:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21AA01529;
        Wed, 24 Mar 2021 12:37:04 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7100D3F718;
        Wed, 24 Mar 2021 12:37:02 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: lib: improve copy performance when size is ge
 128 bytes
To:     David Laight <David.Laight@ACULAB.COM>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
 <20210323073432.3422227-3-yangyingliang@huawei.com>
 <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
 <62602598e7b742d09c581f3fc988e487@AcuMS.aculab.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7c38b9e3-f7ba-4d51-1c84-9c47dad07189@arm.com>
Date:   Wed, 24 Mar 2021 19:36:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <62602598e7b742d09c581f3fc988e487@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-24 16:38, David Laight wrote:
> From: Robin Murphy
>> Sent: 23 March 2021 12:09
>>
>> On 2021-03-23 07:34, Yang Yingliang wrote:
>>> When copy over 128 bytes, src/dst is added after
>>> each ldp/stp instruction, it will cost more time.
>>> To improve this, we only add src/dst after load
>>> or store 64 bytes.
>>
>> This breaks the required behaviour for copy_*_user(), since the fault
>> handler expects the base address to be up-to-date at all times. Say
>> you're copying 128 bytes and fault on the 4th store, it should return 80
>> bytes not copied; the code below would return 128 bytes not copied, even
>> though 48 bytes have actually been written to the destination.
> 
> Are there any non-superscaler amd64 cpu (that anyone cares about)?
> 
> If the cpu can execute multiple instructions in one clock
> then it is usually possible to get the loop control (almost) free.
> 
> You might need to unroll once to interleave read/write
> but any more may be pointless.

Nah, the whole point is that using post-increment addressing is crap in 
the first place because it introduces register dependencies between each 
access that could be avoided entirely if we could use offset addressing 
(and especially crap when we don't even *have* a post-index addressing 
mode for the unprivileged load/store instructions used in copy_*_user() 
and have to simulate it with extra instructions that throw off the code 
alignment).

We already have code that's tuned to work well across our 
microarchitectures[1], the issue is that butchering it to satisfy the 
additional requirements of copy_*_user() with a common template has 
hobbled regular memcpy() performance. I intend to have a crack at fixing 
that properly tomorrow ;)

Robin.

[1] https://github.com/ARM-software/optimized-routines

> So something like:
> 	a = *src++
> 	do {
> 		b = *src++;
> 		*dst++ = a;
> 		a = *src++;
> 		*dst++ = b;
> 	} while (src != lim);
> 	*dst++ = b;
> 
>      David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
