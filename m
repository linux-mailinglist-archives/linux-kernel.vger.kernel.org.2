Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D83346177
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhCWO3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:29:07 -0400
Received: from foss.arm.com ([217.140.110.172]:47334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhCWO2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:28:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6587D6E;
        Tue, 23 Mar 2021 07:28:44 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 982083F719;
        Tue, 23 Mar 2021 07:28:43 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: lib: improve copy performance when size is ge
 128 bytes
To:     Will Deacon <will@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, guohanjun@huawei.com
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
 <20210323073432.3422227-3-yangyingliang@huawei.com>
 <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
 <20210323133217.GA11802@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aadf2619-4282-f9f3-359c-bb166830f488@arm.com>
Date:   Tue, 23 Mar 2021 14:28:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323133217.GA11802@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-23 13:32, Will Deacon wrote:
> On Tue, Mar 23, 2021 at 12:08:56PM +0000, Robin Murphy wrote:
>> On 2021-03-23 07:34, Yang Yingliang wrote:
>>> When copy over 128 bytes, src/dst is added after
>>> each ldp/stp instruction, it will cost more time.
>>> To improve this, we only add src/dst after load
>>> or store 64 bytes.
>>
>> This breaks the required behaviour for copy_*_user(), since the fault
>> handler expects the base address to be up-to-date at all times. Say you're
>> copying 128 bytes and fault on the 4th store, it should return 80 bytes not
>> copied; the code below would return 128 bytes not copied, even though 48
>> bytes have actually been written to the destination.
>>
>> We've had a couple of tries at updating this code (because the whole
>> template is frankly a bit terrible, and a long way from the well-optimised
>> code it was derived from), but getting the fault-handling behaviour right
>> without making the handler itself ludicrously complex has proven tricky. And
>> then it got bumped down the priority list while the uaccess behaviour in
>> general was in flux - now that the dust has largely settled on that I should
>> probably try to find time to pick this up again...
> 
> I think the v5 from Oli was pretty close, but it didn't get any review:
> 
> https://lore.kernel.org/r/20200914151800.2270-1-oli.swede@arm.com
> 
> he also included tests:
> 
> https://lore.kernel.org/r/20200916104636.19172-1-oli.swede@arm.com
> 
> It would be great if you or somebody else has time to revive those!

Yeah, we still have a ticket open for it. Since the uaccess overhaul has 
pretty much killed off any remaining value in the template idea, I might 
have a quick go at spinning a series to just update memcpy() and the 
other library routines to their shiny new versions, then come back and 
work on some dedicated usercopy routines built around LDTR/STTR (and the 
desired fault behaviour) as a follow-up.

(I was also holding out hope for copy_in_user() to disappear if we wait 
long enough, but apparently not yet...)

Robin.
