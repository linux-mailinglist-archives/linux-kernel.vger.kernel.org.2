Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16F23E33AD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhHGFvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 01:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhHGFvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 01:51:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE439C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 22:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Ykyesqpa4JO1NvFqTxgiNWjE2F02tCDu86tfvqTqp5I=; b=dcxAIEdxlcHNVRsfon7rL611he
        iOOcHOMwcoxeTT2kjeFWEng08Ari8+liWepmhnzvI10RCwYhWOvQlhIZyL5bNR9ZoEHs+VMh6zton
        tsgVAhzvsm0uzInPpGdTQEGQXhOC0RJyaqh+L6BocP+Giznb/wVUH940E9umBfutZrkB8guaK1qop
        7vhd9jzxUuyyPngM01qo942bLozfP/kmkW9nMGj2cuEN+Q4h9cLSQsWyDvMUkt/gaCEp6VXnXwNSA
        3UxXlS7lk/VRqjR9tvs3sZJyX0zuChKidVo6iIWtNdccdiLrqhW7ACycfTGJf3TbTQoBg9XH1k7IP
        fhK94X/Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCFEo-008sfu-Cl; Sat, 07 Aug 2021 05:51:17 +0000
Subject: Re: [openrisc:for-next 3/3] arch/openrisc/include/asm/setup.h:11:13:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 'or1k_early_setup'
From:   Randy Dunlap <rdunlap@infradead.org>
To:     kernel test robot <lkp@intel.com>,
        Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202108052040.jEu76XzR-lkp@intel.com>
 <50c8f758-91de-8f0a-57e1-07e71afcdbde@infradead.org>
Message-ID: <251bc79f-7703-4a1c-bb8e-0c61bbcefc4c@infradead.org>
Date:   Fri, 6 Aug 2021 22:51:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <50c8f758-91de-8f0a-57e1-07e71afcdbde@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 10:46 PM, Randy Dunlap wrote:
> On 8/5/21 5:04 AM, kernel test robot wrote:
>> tree:   https://github.com/openrisc/linux.git for-next
>> head:   19e14f3a81d227f1c8b8d5371de28b3ab3deb556
>> commit: 19e14f3a81d227f1c8b8d5371de28b3ab3deb556 [3/3] openrisc: Fix compiler warnings in setup
>> config: openrisc-randconfig-r005-20210804 (attached as .config)
>> compiler: or1k-linux-gcc (GCC) 10.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/openrisc/linux/commit/19e14f3a81d227f1c8b8d5371de28b3ab3deb556
>>          git remote add openrisc https://github.com/openrisc/linux.git
>>          git fetch --no-tags openrisc for-next
>>          git checkout 19e14f3a81d227f1c8b8d5371de28b3ab3deb556
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from arch/openrisc/include/asm/page.h:35,
>>                      from drivers/usb/atm/speedtch.c:12:
>>>> arch/openrisc/include/asm/setup.h:11:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'or1k_early_setup'
>>        11 | void __init or1k_early_setup(void *fdt);
>>           |             ^~~~~~~~~~~~~~~~
>>
>>
>> vim +11 arch/openrisc/include/asm/setup.h
> 
> Hi Stafford-
> 
> #include <linux/init.h>
> 
> and where is this file?
> 
> #include <asm-generic/setup.h>

Found it.

> 
>>       9
>>      10    #ifndef __ASSEMBLY__
>>    > 11    void __init or1k_early_setup(void *fdt);
>>      12    #endif
>>      13
>>
>> ---
> 


-- 
~Randy

