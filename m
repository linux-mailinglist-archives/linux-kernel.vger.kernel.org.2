Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41353E21A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 04:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbhHFCgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 22:36:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16053 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhHFCf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 22:35:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgqHr3shDzZy0t;
        Fri,  6 Aug 2021 10:32:08 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 10:35:43 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 6 Aug 2021 10:35:42 +0800
To:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        "xiaoqian9@huawei.com" <xiaoqian9@huawei.com>,
        "wangle6@huawei.com" <wangle6@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Subject: Question: Can I call down() in an atomic context?
Message-ID: <6b5e1da8-4360-e9da-ad42-a5365fb853fa@huawei.com>
Date:   Fri, 6 Aug 2021 10:35:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

might_sleep() is called in kernel/locking/rwsem.c (API: 
down_read/down_write/...)
but not in kernel/locking/semaphore.c (API: down/down_timeout/..).
Was it designed so purposely, or was it missed by mistake?

After I added might_sleep() to kernel/locking/semaphore.c,
an alarm log was occasionally detected in my test environment:

	BUG: sleeping function called from invalid context at 
kernel/locking/semaphore.c:163
	in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/8
	...
	Call trace:
	dump_backtrace+0x0/0x3c
	dump_backtrace+0x2c/0x3c
	show_stack+0x24/0x34
	dump_stack+0xb0/0xf0
	___might_sleep+0x130/0x144
	__might_sleep+0x78/0x88
	down_timeout+0x40/0xc8
	acpi_os_wait_semaphore+0x78/0xa0  drivers/acpi/osl.c#L1266
	acpi_ut_acquire_mutex+0x50/0xb4   drivers/acpi/acpica/utmutex.c#L241
	acpi_get_table+0x3c/0xc8          drivers/acpi/acpica/tbxface.c#L318
	acpi_find_last_cache_level+0x7c/0x140  drivers/acpi/pptt.c#L602
	_init_cache_level+0xd0/0xd8    arch/arm64/kernel/cacheinfo.c#L64
	flush_smp_call_function_queue+0x138/0x160   kernel/smp.c#L561
	generic_smp_call_function_single_interrupt+0x18/0x24
	handle_IPI+0x1d0/0x50c
	gic_handle_irq+0x13c/0x140
	el1_irq+0xcc/0x180
	arch_cpu_idle+0xc0/0x16c
	default_idle_call+0x34/0x38
	cpu_startup_entry+0x2b4/0x358
	secondary_start_kernel+0x1a8/0x1dc

Does this mean that it is necessary to add might_sleep in 
kernel/locking/semaphore.c?


Thanks
Xiaoming Ni
