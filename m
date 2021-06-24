Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42C3B2FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhFXNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:24:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXNYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:24:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D710ED1;
        Thu, 24 Jun 2021 06:22:34 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BD2F3F718;
        Thu, 24 Jun 2021 06:22:32 -0700 (PDT)
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org> <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
Date:   Thu, 24 Jun 2021 14:22:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNRpYli/5/GWvaTT@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-24 12:15, Matthew Wilcox wrote:
> On Thu, Jun 24, 2021 at 08:04:07AM +0100, Christoph Hellwig wrote:
>> On Thu, Jun 24, 2021 at 04:24:46AM +0100, Matthew Wilcox wrote:
>>> On Thu, Jun 24, 2021 at 11:10:41AM +0800, Chen Huang wrote:
>>>> In userspace, I perform such operation:
>>>>
>>>>   	fd = open("/tmp/test", O_RDWR | O_SYNC);
>>>>          access_address = (char *)mmap(NULL, uio_size, PROT_READ, MAP_SHARED, uio_fd, 0);
>>>>          ret = write(fd, access_address + 2, sizeof(long));
>>>
>>> ... you know that accessing this at unaligned offsets isn't going to
>>> work.  It's completely meaningless.  Why are you trying to do it?
>>
>> We still should not cause an infinite loop in kernel space due to a
>> a userspace programmer error.
> 
> They're running as root and they've mapped some device memory.  We can't
> save them from themself.  Imagine if they'd done this to the NVMe BAR.

FWIW I think the only way to make the kernel behaviour any more robust 
here would be to make the whole uaccess API more expressive, such that 
rather than simply saying "I only got this far" it could actually 
differentiate between stopping due to a fault which may be recoverable 
and worth retrying, and one which definitely isn't.

Unless maybe there's the possibility to abandon a syscall and SIGBUS the 
process directly from the uaccess fixup path, but even to my limited 
knowledge that seems unlikely.

(I'm not counting "cap the number of retries to a very large value to 
guarantee *eventual* failure" as robust, but I suppose it's a potential 
option too)

Robin.
