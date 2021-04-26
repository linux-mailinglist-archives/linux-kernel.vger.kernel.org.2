Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E236BAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhDZVGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbhDZVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:06:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73094C061574;
        Mon, 26 Apr 2021 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=o18bPOCg8Vev9yuxfiIQ9pnCFydFMd9gnR+8URq20pU=; b=aA7GIIBmhj69nk9f8lfNZc8zkr
        5zF4hx0WTkHLfrb5XFPHrapGUOHJSsiEpPHNZfjTpxnPrD60NLHlmgequhbVCXmHY/Hv97bsICynK
        UekEa0IzQecG1Da3h6+YMyfH86t8D0denvfuxJzv2sBS6YJC72Cpde6t/XWBdHJCs5k/sQ7T+CO1J
        KlNO5IS2gUB8CB4vQnBaEC5NU3OnDYKCHZ+rKkVMfdgIiZMOrbWVl9e53/eeUOeQbN+fHkzXjRlPi
        Q5RiAbJg405juMTyNTpUSzwaq5otGlGKorPsJHzMbzwiwe8qNUasCIah1u68OLkHFQ6kBtaxJT5oZ
        jrhCKFsA==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb8Pk-00665i-7r; Mon, 26 Apr 2021 21:05:09 +0000
Subject: Re: ingenic-adc.c:undefined reference to `clk_get_parent'
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <202103162301.oomY9NwI-lkp@intel.com>
 <ac51550d-c72e-4a85-ed0e-a4cddbf495be@infradead.org>
 <CAHp75VdZ6v7zV4_4YJ-rXAE2_ZLZw04AHib1yGPiwYS_JYYGOg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8a41b718-a6f6-6b7f-1699-18ab619884c3@infradead.org>
Date:   Mon, 26 Apr 2021 14:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdZ6v7zV4_4YJ-rXAE2_ZLZw04AHib1yGPiwYS_JYYGOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 1:22 AM, Andy Shevchenko wrote:
> On Mon, Apr 26, 2021 at 8:43 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> [add linux-clk + maintainers]
>>
>> On 3/16/21 8:54 AM, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   1a4431a5db2bf800c647ee0ed87f2727b8d6c29c
>>> commit: a07a4fe5ff460e99293c0d682421920d54e31d7f iio:adc:ingenic: drop of_match_ptr protection and include mod_devicetable.h
>>> date:   8 months ago
>>> config: mips-randconfig-p001-20210316 (attached as .config)
>>> compiler: mips-linux-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a07a4fe5ff460e99293c0d682421920d54e31d7f
>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>         git fetch --no-tags linus master
>>>         git checkout a07a4fe5ff460e99293c0d682421920d54e31d7f
>>>         # save the attached .config to linux build tree
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
>>>>> ingenic-adc.c:(.text+0x8c): undefined reference to `clk_get_parent'
>>>    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
>>>    ingenic-adc.c:(.text+0x164): undefined reference to `clk_get_parent'
>>
>> Hi,
>>
>> My guess (analysis) suggests that this problem is due to
>> a difference in when clk_get_parent() is available between
>> <linux/clk.h> where it depends on CONFIG_HAVE_CLK and
>> drivers/clk/clk.c, which is built iff CONFIG_COMMON_CLK.
>>
>> Any comments/suggestions?
> 
> I haven't looked into it, but IIRC MIPS has its own clock API
> implementation (or I mixed it with another arch?) and that's the root
> of many issues like this around the kernel.


Thanks. I do see that (MIPS) CONFIG_RA7 and CONFIG_RALINK
provide their own clk_get_parent(), but neither of those is
enabled in the kernel config file.

I'll post some kind of patch later today.

-- 
~Randy

