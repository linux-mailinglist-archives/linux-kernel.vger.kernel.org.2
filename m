Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419F230AF88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhBAShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:37:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2471 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhBAShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:37:09 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DTxQM3Vlnz67js6;
        Tue,  2 Feb 2021 02:32:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 19:36:27 +0100
Received: from [10.47.11.37] (10.47.11.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 1 Feb 2021
 18:36:26 +0000
CC:     Zhou Wang <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: PCI MSI issue with reinserting a driver
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
Date:   Mon, 1 Feb 2021 18:34:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.37]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a heads-up, by chance I noticed that I can't re-insert a specific 
driver on v5.11-rc6:

[   64.356023] hisi_dma 0000:7b:00.0: Adding to iommu group 31
[   64.368627] hisi_dma 0000:7b:00.0: enabling device (0000 -> 0002)
[   64.384156] hisi_dma 0000:7b:00.0: Failed to allocate MSI vectors!
[   64.397180] hisi_dma: probe of 0000:7b:00.0 failed with error -28

That's with CONFIG_DEBUG_TEST_DRIVER_REMOVE=y

Bisect tells me that this is the first bad commit:
4615fbc3788d genirq/irqdomain: Don't try to free an interrupt that has 
no mapping

The relevant driver code is 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/hisi_dma.c#n547

That driver only allocates 30 MSI, so maybe there's a problem with not 
allocating (and freeing) all 32 MSI.

I'll have a bit more of a look tomorrow.

Cheers,
john

Bisect log:

git bisect start
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
# bad: [1048ba83fb1c00cd24172e23e8263972f6b5d9ac] Linux 5.11-rc6
git bisect bad 1048ba83fb1c00cd24172e23e8263972f6b5d9ac
# bad: [ee249d30fadec7677364063648f5547e243bf93f] Merge branch 
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect bad ee249d30fadec7677364063648f5547e243bf93f
# good: [15b447361794271f4d03c04d82276a841fe06328] mm/lru: revise the 
comments of lru_lock
git bisect good 15b447361794271f4d03c04d82276a841fe06328
# good: [15b447361794271f4d03c04d82276a841fe06328] mm/lru: revise the 
comments of lru_lock
git bisect good 15b447361794271f4d03c04d82276a841fe06328
# good: [2aa899ebd5c3aef707460f58951cc8a1d1f466c1] MAINTAINERS: add 
mvpp2 driver entry
git bisect good 2aa899ebd5c3aef707460f58951cc8a1d1f466c1
# good: [2911ed9f47b47cb5ab87d03314b3b9fe008e607f] Merge tag 
'char-misc-5.11-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc 

git bisect good 2911ed9f47b47cb5ab87d03314b3b9fe008e607f
# bad: [a45f1d43311d3a4f6534e48a3655ba3247a59d48] Merge tag 
'regmap-v5.11' of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect bad a45f1d43311d3a4f6534e48a3655ba3247a59d48
# good: [749c1e1481e1d242ded9dd1bf210ddb7c0d22a4f] Merge tag 
'iio-for-5.11a' of 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into 
staging-next
git bisect good 749c1e1481e1d242ded9dd1bf210ddb7c0d22a4f
# good: [98b32c71a455ff289442779fee02ad60a6217006] staging: rtl8723bs: 
replace HT_CAP_AMPDU_FACTOR
git bisect good 98b32c71a455ff289442779fee02ad60a6217006
# bad: [3c41e57a1e168d879e923c5583adeae47eec9f64] Merge tag 
'irqchip-5.11' of 
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into 
irq/core
git bisect bad 3c41e57a1e168d879e923c5583adeae47eec9f64
# good: [e15f2fa959f2cce8a05e8e3a596e75d068cd42c5] driver core: 
platform: Add devm_platform_get_irqs_affinity()
git bisect good e15f2fa959f2cce8a05e8e3a596e75d068cd42c5
# good: [2cb0837e56e1b04b773ed05df72297de4e010063] arm64: irqstat: Get 
rid of duplicated declaration
git bisect good 2cb0837e56e1b04b773ed05df72297de4e010063
# bad: [4615fbc3788ddc8e7c6d697714ad35a53729aa2c] genirq/irqdomain: 
Don't try to free an interrupt that has no mapping
git bisect bad 4615fbc3788ddc8e7c6d697714ad35a53729aa2c
# good: [e091bc90cd2d65f48e4688faead2911558d177d7] irqstat: Move 
declaration into asm-generic/hardirq.h
git bisect good e091bc90cd2d65f48e4688faead2911558d177d7
# good: [ae9ef58996a4447dd44aa638759f913c883ba816] softirq: Move related 
code into one section
git bisect good ae9ef58996a4447dd44aa638759f913c883ba816
# good: [15b8d9372f27c47e17c91f6f16d359314cf11404] sh/irq: Add missing 
closing parentheses in arch_show_interrupts()
git bisect good 15b8d9372f27c47e17c91f6f16d359314cf11404
# first bad commit: [4615fbc3788ddc8e7c6d697714ad35a53729aa2c] 
genirq/irqdomain: Don't try to free an interrupt that has no mapping
