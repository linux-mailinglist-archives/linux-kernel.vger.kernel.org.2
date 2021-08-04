Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0056F3DF9C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhHDClp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhHDCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70FC061575
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ujaps8s3fJlAlAP4Dhd8BqjvyYaCWRLuuClahQZg6cs=; b=wG7cSv1+kc/iI3FPpRHP6TDPqw
        LHzTHvwns4HBKBb480yZrTvIigBcYVVEwG2gO9zb6bsfRlJQj9N2qMD3w1VglUWXjicRUUTyEBBTf
        kPpbr1IVroXnNasUgKiXz0FnRsP4t52FrjHMpaHJjZn4mOiiLiOQBUOiP6vM32Qoun1xIoaFN1ZgG
        LQ3ieQ6RuMGU/DYLbuXKyQoXUMShB0AAOCSzN7JU5LBb3DdkTQzHHyAC4tCifhK/70rFqpKqxWIu7
        NxfZEsH9/syMrAe+1IrcVz7zwG6BR/WcILnjgimbPDaWTxemMJISTP3FHHzkqDWBZJhplXgygvogS
        eVcjaNsA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB6pI-005KWU-Cd; Wed, 04 Aug 2021 02:40:24 +0000
Subject: Re: undefined reference to `.radix__create_section_mapping'
To:     kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202108010251.C4jhEEBW-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <082eea82-c788-72e0-f6a4-eadfb54d1231@infradead.org>
Date:   Tue, 3 Aug 2021 19:40:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108010251.C4jhEEBW-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/21 11:22 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c7d102232649226a69dddd58a4942cf13cff4f7c
> commit: fe3dc333d2ed50c9764d281869d87bae0d795ce5 powerpc/mmu: Don't duplicate radix_enabled()
> date:   3 months ago
> config: powerpc64-randconfig-r013-20210731 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe3dc333d2ed50c9764d281869d87bae0d795ce5
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout fe3dc333d2ed50c9764d281869d87bae0d795ce5
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     powerpc-linux-ld: arch/powerpc/mm/book3s64/pgtable.o: in function `.create_section_mapping':
>>> (.meminit.text+0x3c): undefined reference to `.radix__create_section_mapping'
>     powerpc-linux-ld: arch/powerpc/mm/book3s64/pgtable.o: in function `.remove_section_mapping':
>>> (.meminit.text+0x90): undefined reference to `.radix__remove_section_mapping'

In the randconfig file:
# CONFIG_PPC_RADIX_MMU is not set

It is default y, but maybe that is not strong enough?
I.e., should it be selected by PPC_BOOK3S_64?

Changing the config to PPC_RADIX_MMU=y fixes the build errors.

Or should arch/powerpc/mm/book3s64/pgtable.c be modified to handle
the case of PPC_RADIX_MMU is not set?


thanks.
-- 
~Randy

