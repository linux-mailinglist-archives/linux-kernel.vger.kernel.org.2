Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0130B6CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhBBFKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:10:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:33951 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBBFKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:10:48 -0500
IronPort-SDR: V3lkZTk47izms0suhaJaAwAiHP6CqgnMTTVvS8LcVNlFL3XR18INXNTqRXya/fXlctDxlEyrSA
 eP6yJfxS6+Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199710392"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="199710392"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:10:04 -0800
IronPort-SDR: 9SPF0Nj+gVKIa+RGZv89Lkro9USExmVgo3NE9aeTQY5G+1aTP5QqJKLIGd7w6E3LgPkXKVSmdo
 CySbwQJBj5LQ==
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="391289402"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:10:01 -0800
Subject: Re: [kbuild-all] Re: s390-linux-ld: ll_temac_main.c:undefined
 reference to `devm_platform_ioremap_resource_byname'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Wang Hai <wanghai38@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202102010812.qthaghhK-lkp@intel.com>
 <ac0c1ba8-d7c7-1868-db25-ccf063effec8@infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <1606d1eb-2e10-185c-7f80-1a1538da03c8@intel.com>
Date:   Tue, 2 Feb 2021 13:09:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ac0c1ba8-d7c7-1868-db25-ccf063effec8@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 6:38 AM, Randy Dunlap wrote:
> On 1/31/21 4:06 PM, kernel test robot wrote:
>> Hi Wang,
>>
>> FYI, the error/warning still remains.
>>
>> tree: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>> master
>> head:   1048ba83fb1c00cd24172e23e8263972f6b5d9ac
>> commit: bd69058f50d5ffa659423bcfa6fe6280ce9c760a net: ll_temac: Use 
>> devm_platform_ioremap_resource_byname()
>> date:   6 months ago
>> config: s390-randconfig-r034-20210201 (attached as .config)
>
> Hi robot,
>
> Instead of hit & miss with s390 randconfigs, you could do what I did:
> (all for arch/s390/):

Hi Randy,

Thanks for the advice, do you mean we don't need to test randconfig for 
arch s390?

Best Regards,
Rong Chen

>
> $ make allmodconfig
> $ scripts/config -d PCI  ## this also disables HAS_IOMEM
> $ make oldconfig
> $ make all
>
> The latter gives a full list of drivers etc. that use iomemp/ioremap 
> etc. as well as dev_io* variants instead of just a few random ones.
>
>
>> All errors (new ones prefixed by >>):
>>
>>     s390-linux-ld: drivers/net/ethernet/xilinx/ll_temac_main.o: in 
>> function `temac_probe':
>>     ll_temac_main.c:(.text+0x39b6): undefined reference to 
>> `devm_platform_ioremap_resource_byname'
>>>> s390-linux-ld: ll_temac_main.c:(.text+0x3a4c): undefined reference 
>>>> to `devm_platform_ioremap_resource_byname'
>>     s390-linux-ld: ll_temac_main.c:(.text+0x3bce): undefined 
>> reference to `devm_ioremap'
>>     s390-linux-ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: 
>> in function `axienet_probe':
>>     xilinx_axienet_main.c:(.text+0x844): undefined reference to 
>> `devm_ioremap_resource'
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

