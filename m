Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952FE453E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 03:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhKQCSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 21:18:32 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31877 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhKQCSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:18:31 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hv5xT2vXLzcbPb;
        Wed, 17 Nov 2021 10:10:37 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 17 Nov 2021 10:15:30 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Wed, 17 Nov 2021 10:15:30 +0800
Message-ID: <7ae0d25e-4baa-76e2-4937-9b413af25591@huawei.com>
Date:   Wed, 17 Nov 2021 10:15:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: arch/arm/mm/fault.c:210:24: sparse: sparse: incorrect type in
 return expression (different base types)
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
References: <202111170449.8KzXziyR-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202111170449.8KzXziyR-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/linux-arm-kernel/20211115075834.156838-1-wangkefeng.wang@huawei.com/

On 2021/11/17 4:14, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8ab774587903771821b59471cc723bba6d893942
> commit: caed89dab0ca0e73d7e016c04e1f5957650f4ec3 ARM: 9128/1: mm: Refactor the __do_page_fault()
> date:   4 weeks ago
> config: arm-randconfig-s031-20211116 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=caed89dab0ca0e73d7e016c04e1f5957650f4ec3
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout caed89dab0ca0e73d7e016c04e1f5957650f4ec3
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>>> arch/arm/mm/fault.c:210:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int @@
>     arch/arm/mm/fault.c:210:24: sparse:     expected restricted vm_fault_t
>     arch/arm/mm/fault.c:210:24: sparse:     got int
>     arch/arm/mm/fault.c:214:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int @@
>     arch/arm/mm/fault.c:214:32: sparse:     expected restricted vm_fault_t
>     arch/arm/mm/fault.c:214:32: sparse:     got int
>     arch/arm/mm/fault.c:216:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int @@
>     arch/arm/mm/fault.c:216:32: sparse:     expected restricted vm_fault_t
>     arch/arm/mm/fault.c:216:32: sparse:     got int
>     arch/arm/mm/fault.c:218:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int @@
>     arch/arm/mm/fault.c:218:32: sparse:     expected restricted vm_fault_t
>     arch/arm/mm/fault.c:218:32: sparse:     got int
>     arch/arm/mm/fault.c:226:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int @@
>     arch/arm/mm/fault.c:226:24: sparse:     expected restricted vm_fault_t
>     arch/arm/mm/fault.c:226:24: sparse:     got int
>     arch/arm/mm/fault.c:312:13: sparse: sparse: restricted vm_fault_t degrades to integer
>     arch/arm/mm/fault.c:312:13: sparse: sparse: restricted vm_fault_t degrades to integer
>     arch/arm/mm/fault.c:345:24: sparse: sparse: restricted vm_fault_t degrades to integer
> 
