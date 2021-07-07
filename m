Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19183BE6DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhGGLHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:07:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhGGLHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:07:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4FCB1042;
        Wed,  7 Jul 2021 04:04:31 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85FD3F5A1;
        Wed,  7 Jul 2021 04:04:29 -0700 (PDT)
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
To:     David Laight <David.Laight@ACULAB.COM>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org> <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk> <20210624185554.GC25097@arm.com>
 <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
 <20210625103905.GA20835@arm.com>
 <7f14271a-9b2f-1afc-3caf-c4e5b36efa73@arm.com>
 <20210706175052.GD15218@arm.com>
 <dd30df30-5271-2724-48eb-9f47c5f3e1aa@arm.com>
 <4a1473fc5af9496e9c8ed02c7f631d72@AcuMS.aculab.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9bda45b9-5384-fc14-1bc5-be00d07d4350@arm.com>
Date:   Wed, 7 Jul 2021 12:04:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4a1473fc5af9496e9c8ed02c7f631d72@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-07 10:55, David Laight wrote:
>>> I think it's worth doing the copy_to_user() fallback in a loop until it
>>> faults or hits the end of the buffer. This would solve the problem we
>>> currently have with writing more bytes than actually reported. The
>>> copy_from_user() is not necessary, a byte would suffice.
>>
>> The thing is, we don't really have that problem since the set_fs cleanup
>> removed IMP-DEF STP behaviour from the picture - even with the current
>> mess we could perfectly well know which of the two STTRs faulted if we
> ...
> 
> There is a much more interesting case though.
> It is possible for userspace to have supplied a misaligned
> buffer that is mmapped to an IO address that doesn't support
> misaligned accesses even though normal memory does support them.

Er, yes, that's where this whole thing started - don't worry, I haven't 
forgotten.

> So the 'byte retry' loop would work for the entire buffer.

Indeed it might in certain cases, but is that (unlikely) possibility 
worth our while? What it boils down to is maintaining complexity in the 
kernel purely to humour broken userspace doing a nonsensical thing, when 
it's equally valid to just return a short read/write and let said broken 
userspace take responsibility for retrying the remainder of said 
nonsensical thing by itself. If userspace has managed to get its hands 
on an mmap of something without Normal memory semantics, I would expect 
it to know what it's doing...

Thanks,
Robin.
