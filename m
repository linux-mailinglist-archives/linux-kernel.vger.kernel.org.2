Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01C3381433
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 01:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhENXXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 19:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhENXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 19:23:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24872C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=+TdUnFUEl/7atT/yjSySZz/MPOKeDtq/8iBLDO4cruE=; b=rPsuzp17QDSKT7GGOUJWUvVdrb
        1UBOlDg6AeVFPUVjIkgWuZS46PJKqBfrGNtwlmQY/G3ypKlV7WX71Ns5EtYsIOBaawP7gyexpKCz6
        +D+uuX9GWOXxgd1t8VO8N9/rX2QBjB4RBm1EQ4qQaY0aYxgJgh/UuQiaX2vvAbGdaWCIlvqfLLJ1D
        IzW/+Ngsg8BFA9vXhWK5FoF401WpkwRuFdo9VQpr16Ipo0oISGFs04QJHWXp6sxIUOyJhvQ7y2C2y
        ZDsNPK3949zVBz1InXtHiDZuI7eos0IBXtGJkn6VddUe8QvXoUfmQqxn04hQrE5C/teEhT68XmaT3
        052dAuiQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhh86-00CJgq-Hc; Fri, 14 May 2021 23:22:02 +0000
Subject: Re: arch/csky/mm/tcm.c:14:2: error: #error "You should define
 DTCM_RAM_BASE"
To:     kernel test robot <lkp@intel.com>,
        Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202105150718.cdDLUzFD-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a386406d-40fd-d382-b272-e524f046ca71@infradead.org>
Date:   Fri, 14 May 2021 16:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202105150718.cdDLUzFD-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 4:08 PM, kernel test robot wrote:
> Hi Guo,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   25a1298726e97b9d25379986f5d54d9e62ad6e93
> commit: 18c07d23da5a48525b2955aa269b8bb108c19300 csky: Fixup calltrace panic
> date:   1 year ago
> config: csky-randconfig-r036-20210515 (attached as .config)
> compiler: csky-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18c07d23da5a48525b2955aa269b8bb108c19300
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 18c07d23da5a48525b2955aa269b8bb108c19300
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=csky 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/csky/mm/tcm.c:14:2: error: #error "You should define DTCM_RAM_BASE"
>       14 | #error "You should define DTCM_RAM_BASE"
>          |  ^~~~~
>    arch/csky/mm/tcm.c:109:7: warning: no previous prototype for 'tcm_alloc' [-Wmissing-prototypes]
>      109 | void *tcm_alloc(size_t len)
>          |       ^~~~~~~~~
>    arch/csky/mm/tcm.c:124:6: warning: no previous prototype for 'tcm_free' [-Wmissing-prototypes]
>      124 | void tcm_free(void *addr, size_t len)
>          |      ^~~~~~~~
> 
> 
> vim +14 arch/csky/mm/tcm.c
> 
> f525bb2c9e7cf1 Guo Ren 2019-11-27  11  
> f525bb2c9e7cf1 Guo Ren 2019-11-27  12  #ifdef CONFIG_HAVE_DTCM
> f525bb2c9e7cf1 Guo Ren 2019-11-27  13  #if (CONFIG_DTCM_RAM_BASE == 0xffffffff)
> f525bb2c9e7cf1 Guo Ren 2019-11-27 @14  #error "You should define DTCM_RAM_BASE"
> f525bb2c9e7cf1 Guo Ren 2019-11-27  15  #endif
> f525bb2c9e7cf1 Guo Ren 2019-11-27  16  


I.e., the person or bot that is running the kernel configurator should
set/define the Kconfig symbol CONFIG_DTCM_RAM_BASE.

Please do so in your scripts.
Thanks.

> :::::: The code at line 14 was first introduced by commit
> :::::: f525bb2c9e7cf1e3c43ab57704c9e1c836d30b34 csky: Tightly-Coupled Memory or Sram support
> 
> :::::: TO: Guo Ren <guoren@linux.alibaba.com>
> :::::: CC: Guo Ren <guoren@linux.alibaba.com>



-- 
~Randy

