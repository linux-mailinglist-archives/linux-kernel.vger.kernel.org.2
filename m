Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCD844D3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhKKJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:10:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:49709 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhKKJKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:10:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="296318272"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="296318272"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 01:07:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="492471457"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.108]) ([10.255.28.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 01:07:10 -0800
Subject: Re: [kbuild-all] Re: [mcgrof-next:20210916-firmware-builtin-v2 14/14]
 drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5:13:
 error: Could not find incbin file
 'drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin'
To:     Luis Chamberlain <mcgrof@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
References: <202111080124.Dyl8aeOd-lkp@intel.com>
 <YYlVhm0ybuirMI//@bombadil.infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a822ee1e-a9a2-7208-3d7d-61239c0da695@intel.com>
Date:   Thu, 11 Nov 2021 17:07:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YYlVhm0ybuirMI//@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2021 12:51 AM, Luis Chamberlain wrote:
> On Mon, Nov 08, 2021 at 01:37:31AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210916-firmware-builtin-v2
>> head:   f69194f4bcf5b301f2d169b2f036c0da4b642e53
>> commit: f69194f4bcf5b301f2d169b2f036c0da4b642e53 [14/14] test_firmware: add support for testing built-in firmware
>> config: arm-randconfig-r004-20210929 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm cross compiling tool for clang build
>>          # apt-get install binutils-arm-linux-gnueabi
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=f69194f4bcf5b301f2d169b2f036c0da4b642e53
>>          git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
>>          git fetch --no-tags mcgrof-next 20210916-firmware-builtin-v2
>>          git checkout f69194f4bcf5b301f2d169b2f036c0da4b642e53
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5:13: error: Could not find incbin file 'drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin'
>>         .incbin "drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin"
>>                 ^
> 
> I used the latest test branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20211020-firmware-builtin
> 
> And I can't reproduce there, that build fails for another reason though:

Hi Luis,

Sorry for the inconvenience, the reproduce step is not accurate,
we can be reproduced the error with "O=dir" option specified.

Best Regards,
Rong Chen

> 
> ld.lld: error: undefined symbol: _printk
>>>> referenced by io-acorn.o:(.text+0x38) in archive
>>>> arch/arm/mach-rpc/built-in.a
> make: *** [Makefile:1183: vmlinux] Error 1
> make: Target '__all' not remade because of errors.
> 
>    Luis
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
