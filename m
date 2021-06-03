Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB3399892
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhFCDb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:31:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3520 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:31:24 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwWXW2khMzZcG2;
        Thu,  3 Jun 2021 11:26:51 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 11:29:07 +0800
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 11:29:07 +0800
Subject: Re: drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:89:7: warning:
 variable 'val' set but not used
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Qi Liu <liuqi115@huawei.com>
References: <202106030815.nhs7gfMo-lkp@intel.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <3dde3f65-fd59-5ec4-5c1e-205d623f0cf3@hisilicon.com>
Date:   Thu, 3 Jun 2021 11:29:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202106030815.nhs7gfMo-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/6/3 8:28, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   324c92e5e0ee0e993bdb106fac407846ed677f6b
> commit: 932f6a99f9b0c6b7039a5e2ce961009a8dc8c07c drivers/perf: hisi: Add new functions for HHA PMU
> date:   10 weeks ago
> config: arm64-randconfig-r005-20210603 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d8e0ae9a76a62bdc6117630d59bf9967ac9bb4ea)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=932f6a99f9b0c6b7039a5e2ce961009a8dc8c07c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 932f6a99f9b0c6b7039a5e2ce961009a8dc8c07c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:11:
>    In file included from include/linux/acpi.h:35:
>    In file included from include/acpi/acpi_io.h:7:
>    In file included from arch/arm64/include/asm/acpi.h:12:
>    include/linux/efi.h:1093:34: warning: passing 1-byte aligned argument to 4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer access [-Walign-mismatch]
>            status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
>                                            ^
>    include/linux/efi.h:1101:24: warning: passing 1-byte aligned argument to 4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer access [-Walign-mismatch]
>            get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
>                                  ^
>>> drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:89:7: warning: variable 'val' set but not used [-Wunused-but-set-variable]
>                    u32 val;
> 

Oops, my bad, there is a bug that shall be fixed. I will post it later.

Thanks for the report,
Shaokun


                       ^
>    drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:103:7: warning: variable 'val' set but not used [-Wunused-but-set-variable]
>                    u32 val;
>                        ^
>    4 warnings generated.
> 
> 
> vim +/val +89 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> 
>     82	
>     83	static void hisi_hha_pmu_config_ds(struct perf_event *event)
>     84	{
>     85		struct hisi_pmu *hha_pmu = to_hisi_pmu(event->pmu);
>     86		u32 ds_skt = hisi_get_datasrc_skt(event);
>     87	
>     88		if (ds_skt) {
>   > 89			u32 val;
>     90	
>     91			val = readl(hha_pmu->base + HHA_DATSRC_CTRL);
>     92			val |= HHA_DATSRC_SKT_EN;
>     93			writel(ds_skt, hha_pmu->base + HHA_DATSRC_CTRL);
>     94		}
>     95	}
>     96	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
