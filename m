Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20A3B1AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhFWNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:24:52 -0400
Received: from foss.arm.com ([217.140.110.172]:35274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhFWNYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:24:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B9F5ED1;
        Wed, 23 Jun 2021 06:22:34 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.11.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FD013F718;
        Wed, 23 Jun 2021 06:22:31 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:22:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chen Huang <chenhuang5@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <20210623132223.GA96264@C02TD0UTHF1T.local>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:39:31AM +0800, Chen Huang wrote:
> When we access a device memory in userspace, then perform an unaligned write to a file.
> For example, we register a uio device and mmap the device, then perform an write to a
> file, like that:
> 
> 	device_addr = mmap(device_fd);
> 	write(file_fd, device_addr + unaligned_num, size);

What exactly is this device, and why do you want the kernel to do a
direct memcpy from MMIO? Why can't you copy that in userspace (where you
have knowledge of the device), then pass the copy to a syscall?

Ignoring the lockup below, this isn't going to work in general, since
uaccess routines do not guarantee alignment, single-copy, access sizes,
monotonically increasing addresses, etc. Any one of those can cause a
device to raise an external abort which may or may not be synchronous.

It does not make sense to tell the kernel to access this, since the
kernel cannot know how to access it safely, and we can;t do that without
knowledge of the device that we do not have.

Thanks,
Mark.

> 	
> We found that the infinite loop happened in generic_perform_write function:
> 
> again:
> 	copied = copy_page_from_iter_atomic(); //copied = 0
> 	status = ops->write_end(); //status = 0
> 	if (status == 0)
> 		goto again;
> 
> In copy_page_from_iter_atomic, the copyin() function finally call
> __arch_copy_from_user which create an exception table entry for 'insn'.
> Then when kernel handles the alignment_fault, it will not panic. As the
> arm64 memory model spec said, when the address is not a multiple of the
> element size, the access is unaligned. Unaligned accesses are allowed to
> addresses marked as Normal, but not to Device regions. An unaligned access
> to a Device region will trigger an exception (alignment fault).
> 	
> do_alignment_fault
>     do_bad_area
> 	__do_kernel_fault
>            fixup_exception
> 
> But that fixup cann't handle the unaligned copy, so the
> copy_page_from_iter_atomic returns 0 and traps in loop.
> 
> Reported-by: Chen Huang <chenhuang5@huawei.com>
