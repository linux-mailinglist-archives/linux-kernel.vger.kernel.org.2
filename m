Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60B53B1224
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFWD1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 23:27:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11083 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWD1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:27:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8pTj2nBkzZhvD;
        Wed, 23 Jun 2021 11:22:01 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 11:25:02 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 23 Jun 2021 11:25:01 +0800
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Chen Huang <chenhuang5@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <YNKhjkuzXEJrBUA8@zeniv-ca.linux.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <92fa298d-9d88-0ca4-40d9-13690dcd42f9@huawei.com>
Date:   Wed, 23 Jun 2021 11:24:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <YNKhjkuzXEJrBUA8@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/23 10:50, Al Viro wrote:
> On Wed, Jun 23, 2021 at 10:39:31AM +0800, Chen Huang wrote:
> 
>> Then when kernel handles the alignment_fault, it will not panic. As the
>> arm64 memory model spec said, when the address is not a multiple of the
>> element size, the access is unaligned. Unaligned accesses are allowed to
>> addresses marked as Normal, but not to Device regions. An unaligned access
>> to a Device region will trigger an exception (alignment fault).
>> 	
>> do_alignment_fault
>>      do_bad_area
>> 	__do_kernel_fault
>>             fixup_exception
>>
>> But that fixup cann't handle the unaligned copy, so the
>> copy_page_from_iter_atomic returns 0 and traps in loop.
> 
> Looks like you need to fix your raw_copy_from_user(), then...
> .
> 

Exit loop when iov_iter_copy_from_user_atomic() returns 0.
This should solve the problem, too, and it's easier.

Thanks.
Xiaoming Ni





	
