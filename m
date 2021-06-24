Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304DF3B254D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFXDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:13:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:8317 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFXDNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:13:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G9Q5R5tljz70gq;
        Thu, 24 Jun 2021 11:06:35 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 11:10:43 +0800
Received: from [10.174.177.134] (10.174.177.134) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 24 Jun 2021 11:10:42 +0800
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
From:   Chen Huang <chenhuang5@huawei.com>
Message-ID: <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
Date:   Thu, 24 Jun 2021 11:10:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210623132223.GA96264@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/6/23 21:22, Mark Rutland Ð´µÀ:
> On Wed, Jun 23, 2021 at 10:39:31AM +0800, Chen Huang wrote:
>> When we access a device memory in userspace, then perform an unaligned write to a file.
>> For example, we register a uio device and mmap the device, then perform an write to a
>> file, like that:
>>
>> 	device_addr = mmap(device_fd);
>> 	write(file_fd, device_addr + unaligned_num, size);
> 
> What exactly is this device, and why do you want the kernel to do a
> direct memcpy from MMIO? Why can't you copy that in userspace (where you
> have knowledge of the device), then pass the copy to a syscall?
>
I'm sorry for not describing the problem well. It's an uio device:

static struct device_driver uio_dummy_driver = {
    .name = "uio_with_name",
    .bus = &platform_bus_type,
    .probe = drv_uio_with_name_probe,
    .remove = drv_uio_with_name_remove,
};

static int drv_uio_with_name_probe(struct device *dev)
{
    uio_with_name_info.mem[0].addr = 0xa0000000;
    uio_with_name_info.mem[0].memtype = UIO_MEM_PHYS;
    uio_with_name_info.mem[0].size = 0x1000;

    if (__uio_register_device(THIS_MODULE, dev, &uio_with_name_info)) {
        printk("__uio_register_device failed\n");
        return -ENODEV;
    }
    printk("UIO init end.\n");
    return 0;
}

In userspace, I perform such operation:

 	fd = open("/tmp/test", O_RDWR | O_SYNC);
        access_address = (char *)mmap(NULL, uio_size, PROT_READ, MAP_SHARED, uio_fd, 0);
        ret = write(fd, access_address + 2, sizeof(long));

> Ignoring the lockup below, this isn't going to work in general, since
> uaccess routines do not guarantee alignment, single-copy, access sizes,
> monotonically increasing addresses, etc. Any one of those can cause a
> device to raise an external abort which may or may not be synchronous.
> 
> It does not make sense to tell the kernel to access this, since the
> kernel cannot know how to access it safely, and we can;t do that without
> knowledge of the device that we do not have.
> 
> Thanks,
> Mark.
> 
>> 	
>> We found that the infinite loop happened in generic_perform_write function:
>>
>> again:
>> 	copied = copy_page_from_iter_atomic(); //copied = 0
>> 	status = ops->write_end(); //status = 0
>> 	if (status == 0)
>> 		goto again;
>>
>> In copy_page_from_iter_atomic, the copyin() function finally call
>> __arch_copy_from_user which create an exception table entry for 'insn'.
>> Then when kernel handles the alignment_fault, it will not panic. As the
>> arm64 memory model spec said, when the address is not a multiple of the
>> element size, the access is unaligned. Unaligned accesses are allowed to
>> addresses marked as Normal, but not to Device regions. An unaligned access
>> to a Device region will trigger an exception (alignment fault).
>> 	
>> do_alignment_fault
>>     do_bad_area
>> 	__do_kernel_fault
>>            fixup_exception
>>
>> But that fixup cann't handle the unaligned copy, so the
>> copy_page_from_iter_atomic returns 0 and traps in loop.
>>
>> Reported-by: Chen Huang <chenhuang5@huawei.com>
> .
> 
