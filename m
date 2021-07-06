Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803BC3BC529
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 06:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGFEOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 00:14:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6416 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhGFEOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 00:14:50 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GJpvc0Kmtz78ST;
        Tue,  6 Jul 2021 12:08:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 12:12:10 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 12:12:09 +0800
Subject: Re: [PATCH -next 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
To:     kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>
CC:     <kbuild-all@lists.01.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>
References: <20210705111453.164230-4-wangkefeng.wang@huawei.com>
 <202107052207.RUhTJd4N-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <3463cf5e-2562-7a23-6c57-421d5c3e2b4f@huawei.com>
Date:   Tue, 6 Jul 2021 12:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202107052207.RUhTJd4N-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/5 22:10, kernel test robot wrote:
> Hi Kefeng,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on next-20210701]
>
> url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/arm64-support-page-mapping-percpu-first-chunk-allocator/20210705-190907
> base:    fb0ca446157a86b75502c1636b0d81e642fe6bf1
> config: i386-randconfig-a015-20210705 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/0day-ci/linux/commit/5f6b5a402ed3e390563ddbddf12973470fd4886d
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Kefeng-Wang/arm64-support-page-mapping-percpu-first-chunk-allocator/20210705-190907
>          git checkout 5f6b5a402ed3e390563ddbddf12973470fd4886d
>          # save the attached .config to linux build tree
>          make W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     mm/vmalloc.c: In function 'vm_area_register_early':
>>> mm/vmalloc.c:2252:2: error: implicit declaration of function 'kasan_populate_early_vm_area_shadow' [-Werror=implicit-function-declaration]
should add  a stub function when KASAN is not enabled, thanks.
>      2252 |  kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
>           |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>
>
> vim +/kasan_populate_early_vm_area_shadow +2252 mm/vmalloc.c
>
