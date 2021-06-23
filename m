Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5753B11D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 04:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWClw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 22:41:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8296 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWClv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:41:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G8nQl3nYbz1BQlm;
        Wed, 23 Jun 2021 10:34:23 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 10:39:33 +0800
Received: from [10.174.177.134] (10.174.177.134) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 23 Jun 2021 10:39:32 +0800
From:   Chen Huang <chenhuang5@huawei.com>
Subject: [BUG] arm64: an infinite loop in generic_perform_write()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Message-ID: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
Date:   Wed, 23 Jun 2021 10:39:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we access a device memory in userspace, then perform an unaligned write to a file.
For example, we register a uio device and mmap the device, then perform an write to a
file, like that:

	device_addr = mmap(device_fd);
	write(file_fd, device_addr + unaligned_num, size);
	
We found that the infinite loop happened in generic_perform_write function:

again:
	copied = copy_page_from_iter_atomic(); //copied = 0
	status = ops->write_end(); //status = 0
	if (status == 0)
		goto again;

In copy_page_from_iter_atomic, the copyin() function finally call
__arch_copy_from_user which create an exception table entry for 'insn'.
Then when kernel handles the alignment_fault, it will not panic. As the
arm64 memory model spec said, when the address is not a multiple of the
element size, the access is unaligned. Unaligned accesses are allowed to
addresses marked as Normal, but not to Device regions. An unaligned access
to a Device region will trigger an exception (alignment fault).
	
do_alignment_fault
    do_bad_area
	__do_kernel_fault
           fixup_exception

But that fixup cann't handle the unaligned copy, so the
copy_page_from_iter_atomic returns 0 and traps in loop.

Reported-by: Chen Huang <chenhuang5@huawei.com>
