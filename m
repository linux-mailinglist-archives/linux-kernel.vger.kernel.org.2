Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDCA3E88C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhHKDT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhHKDTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:19:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC75DC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Tl+eS+6QMjkohlSBI4f3Acc4gkhJqzhh4NWop3vmxOA=; b=yScrgdsQyGOfeJVHq+sehDJorp
        DMq/Z89ddUb1PgK+R4/0FYVKtixh7ZXy1oKYzn5oXfHsuCbg3ORAEYlqWAGI+HCyoBrItjgiU9ZHZ
        SwNAqLnDvvid+Fnz1dwUPJmhGLXVtQAMaDZmmcvtmtCFC51i1fjtWMLmPx1EPtzUzuSX75IXxQ3+y
        8KefKKW4AZ1j0xAGwxfv+Cjj4jNnWvazdbCQyQhxkH6qEWxMdrsaL9GdAd/Ipdu1BS9lbxwE2J/hF
        g9tdlLspnx5K15zsxqdZeIkiBnx8o2lll7y5XjB7YehtWlyHhEK8sIa3sKsa1bJ9yelcBo5p1qMnb
        2da5zSQw==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDem8-005RvP-NM; Wed, 11 Aug 2021 03:19:28 +0000
Subject: Re: Error: kernelrelease not valid - run 'make prepare' to update it
To:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
References: <202108111155.RvN9J3Hs-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ec75ad9-a861-4402-9c16-ae7cb0aaeaba@infradead.org>
Date:   Tue, 10 Aug 2021 20:19:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108111155.RvN9J3Hs-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 8:16 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9e723c5380c6e14fb91a8b6950563d040674afdb
> commit: ba64beb17493a4bfec563100c86a462a15926f24 kbuild: check the minimum assembler version in Kconfig
> date:   4 months ago
> config: riscv-randconfig-r025-20210810 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d39ebdae674c8efc84ebe8dc32716ec353220530)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba64beb17493a4bfec563100c86a462a15926f24
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout ba64beb17493a4bfec563100c86a462a15926f24
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=riscv prepare
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: kernelrelease not valid - run 'make prepare' to update it
> --
>     clang --target=riscv64-linux-gnu -no-integrated-as --prefix=riscv64-linux-gnu- -Werror=unknown-warning-option: unknown assembler invoked
>     scripts/Kconfig.include:50: Sorry, this assembler is not supported.
>     make[3]: *** [scripts/kconfig/Makefile:63: syncconfig] Error 1
>     make[2]: *** [Makefile:617: syncconfig] Error 2
>     make[1]: *** [Makefile:726: include/config/auto.conf.cmd] Error 2
>     make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
>     make[1]: Failed to remake makefile 'include/config/auto.conf'.
>>> Error: kernelrelease not valid - run 'make prepare' to update it
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [Makefile:215: __sub-make] Error 2
>     make: Target 'prepare' not remade because of errors.

Yes, I have noticed this one and a few other ('static') make targets that
should not need a .config file. I have a note to myself to ask about these,
so thanks for bringing it up.

-- 
~Randy

