Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997B730BAD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhBBJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:22:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:43618 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232839AbhBBJVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:21:38 -0500
IronPort-SDR: FCrOJIrfSh2UG00JWmjJqHci6bC12qG+ntO6xGNR9a+oYSLB2LkMHejlTZzdKUhxeFhwFzd41U
 ZDuZxmTo5Qww==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167931623"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="167931623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 01:20:56 -0800
IronPort-SDR: 3IZJvT2+iksRI4caXQXYKA0zDQjX2ac/4W13D8lhgQPzWc0hyDU3c2UKU3VFR/OQr5dtp16QFw
 V2Y4+jlsr1tw==
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="391381398"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 01:20:54 -0800
Subject: Re: [kbuild-all] Re: s390-linux-ld: ll_temac_main.c:undefined
 reference to `devm_platform_ioremap_resource_byname'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Wang Hai <wanghai38@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202102010812.qthaghhK-lkp@intel.com>
 <ac0c1ba8-d7c7-1868-db25-ccf063effec8@infradead.org>
 <1606d1eb-2e10-185c-7f80-1a1538da03c8@intel.com>
 <8044e33e-018a-839b-4f71-38510d576f6e@infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <f297b20d-a2cc-88b0-2d8e-9f41c842ab83@intel.com>
Date:   Tue, 2 Feb 2021 17:20:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8044e33e-018a-839b-4f71-38510d576f6e@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 1:22 PM, Randy Dunlap wrote:
> On 2/1/21 9:09 PM, Rong Chen wrote:
>>
>> On 2/2/21 6:38 AM, Randy Dunlap wrote:
>>> On 1/31/21 4:06 PM, kernel test robot wrote:
>>>> Hi Wang,
>>>>
>>>> FYI, the error/warning still remains.
>>>>
>>>> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   1048ba83fb1c00cd24172e23e8263972f6b5d9ac
>>>> commit: bd69058f50d5ffa659423bcfa6fe6280ce9c760a net: ll_temac: Use devm_platform_ioremap_resource_byname()
>>>> date:   6 months ago
>>>> config: s390-randconfig-r034-20210201 (attached as .config)
>>> Hi robot,
>>>
>>> Instead of hit & miss with s390 randconfigs, you could do what I did:
>>> (all for arch/s390/):
>> Hi Randy,
>>
>> Thanks for the advice, do you mean we don't need to test randconfig for arch s390?
> You should still do randconfig testing for s390 (for other problems), but the robot has been
> sending out a lot of build errors similar to this one, using different randconfig files.
>
> I am just saying that you can find all of the ioremap/iounmap/devm_io* type build errors
> in one kernel config file as described above.

Hi Randy,

Thanks for the detailed explanation, will do it.

Best Regards,
Rong Chen

>
>> Best Regards,
>> Rong Chen
>>
>>> $ make allmodconfig
>>> $ scripts/config -d PCI  ## this also disables HAS_IOMEM
>>> $ make oldconfig
>>> $ make all
>>>
>>> The latter gives a full list of drivers etc. that use iomemp/ioremap etc. as well as dev_io* variants instead of just a few random ones.
>>>
>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>      s390-linux-ld: drivers/net/ethernet/xilinx/ll_temac_main.o: in function `temac_probe':
>>>>      ll_temac_main.c:(.text+0x39b6): undefined reference to `devm_platform_ioremap_resource_byname'
>>>>>> s390-linux-ld: ll_temac_main.c:(.text+0x3a4c): undefined reference to `devm_platform_ioremap_resource_byname'
>>>>      s390-linux-ld: ll_temac_main.c:(.text+0x3bce): undefined reference to `devm_ioremap'
>>>>      s390-linux-ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
>>>>      xilinx_axienet_main.c:(.text+0x844): undefined reference to `devm_ioremap_resource'
>>> _______________________________________________
>

