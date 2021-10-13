Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F49242B4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 07:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhJMF0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 01:26:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:38126 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhJMF0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:26:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227247725"
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="227247725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 22:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="480649979"
Received: from hli101-mobl1.ccr.corp.intel.com (HELO [10.255.28.104]) ([10.255.28.104])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 22:24:36 -0700
Subject: Re: [kbuild-all] Re: [axboe-block:nvme-passthru-wip 10/19]
 drivers/nvme/host/ioctl.c:47:19: error: cast to pointer from integer of
 different size
To:     Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anuj Gupta <anuj20.g@samsung.com>
References: <202110080434.YH6r4WZv-lkp@intel.com>
 <CAMuHMdUoh0PbLDU1_Drce=cQorv6M47i4pLDE9DtSOmsYOD9AQ@mail.gmail.com>
 <c2115b49-f0ae-3c38-464b-5f99a572e681@kernel.dk>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <c7d7164b-cac8-a752-3cdc-f48cd4197f99@intel.com>
Date:   Wed, 13 Oct 2021 13:24:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c2115b49-f0ae-3c38-464b-5f99a572e681@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/2021 8:35 PM, Jens Axboe wrote:
> On 10/8/21 2:19 AM, Geert Uytterhoeven wrote:
>> On Fri, Oct 8, 2021 at 12:12 AM kernel test robot <lkp@intel.com> wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git nvme-passthru-wip
>>> head:   9c18980ac90053bcdb21594eae48935d89bf389c
>>> commit: 5cc445dd8df6e06f3482711aa590170450364393 [10/19] nvme: wire-up support for async-passthru on char-device.
>>> config: m68k-allmodconfig (attached as .config)
>>> compiler: m68k-linux-gcc (GCC) 11.2.0
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=5cc445dd8df6e06f3482711aa590170450364393
>>>          git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>          git fetch --no-tags axboe-block nvme-passthru-wip
>>>          git checkout 5cc445dd8df6e06f3482711aa590170450364393
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     drivers/nvme/host/ioctl.c: In function 'nvme_pt_task_cb':
>>>>> drivers/nvme/host/ioctl.c:47:19: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>>        47 |         ptcmd64 = (void __user *) bcmd->unused2[0];
>>>           |                   ^
>>>     drivers/nvme/host/ioctl.c:62:58: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>>        62 |                 struct nvme_passthru_cmd __user *ptcmd = (void *)bcmd->unused2[0];
>>>           |                                                          ^
>>>     drivers/nvme/host/ioctl.c: In function 'nvme_ns_async_ioctl':
>>>     drivers/nvme/host/ioctl.c:472:29: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>>       472 |         void __user *argp = (void __user *) bcmd->unused2[0];
>>>           |                             ^
>>>     cc1: all warnings being treated as errors
>>>
>>>
>>> vim +47 drivers/nvme/host/ioctl.c
>>>
>>>      39
>>>      40  static void nvme_pt_task_cb(struct io_uring_cmd *ioucmd)
>>>      41  {
>>>      42          struct uring_cmd_data *ucd;
>>>      43          struct nvme_passthru_cmd64 __user *ptcmd64 = NULL;
>>>      44          struct block_uring_cmd *bcmd;
>>>      45
>>>      46          bcmd = (struct block_uring_cmd *) &ioucmd->pdu;
>>>    > 47          ptcmd64 = (void __user *) bcmd->unused2[0];
>>
>> Casts from u64 to a pointer on 32-bit need an intermediate cast to uintptr_t:
>>
>>      ptcmd64 = (void __user *)(uintptr_t)bcmd->unused2[0];
>>
>> Note that you can improve on the naming, as people may be surprised
>> discovering "unused2" is actually used ;-)
> 
> There's a reason the branch is called -wip, it's just a hodge podge of
> stuff. Not sure why the kernel test robot bothers reporting failures
> publicly for that...
> 

Hi Jens,

We have changed the rule to not report the wip branches to public:

https://github.com/intel/lkp-tests/commit/f5f8d52830e342d51a200d5688b931faa0b786ea

Best Regards,
Rong Chen
