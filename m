Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85B435795B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhDHBLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:11:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16069 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:11:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FG37T11DQz1BGP3;
        Thu,  8 Apr 2021 09:09:09 +0800 (CST)
Received: from [10.174.179.129] (10.174.179.129) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 09:11:12 +0800
Subject: Re: [PATCH] powerpc: Make some symbols static
To:     kernel test robot <lkp@intel.com>, <mpe@ellerman.id.au>
CC:     <kbuild-all@lists.01.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210407125942.4140430-1-yukuai3@huawei.com>
 <202104080005.BEYb9xKK-lkp@intel.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <4deb323a-ce00-b463-9b06-5cb5be0795fa@huawei.com>
Date:   Thu, 8 Apr 2021 09:11:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <202104080005.BEYb9xKK-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/08 0:57, kernel test robot wrote:
> Hi Yu,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v5.12-rc6 next-20210407]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Yu-Kuai/powerpc-Make-some-symbols-static/20210407-205258
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc64-defconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/7c0f3f68006b9b42ce944b02a2059128cc5826ec
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Yu-Kuai/powerpc-Make-some-symbols-static/20210407-205258
>          git checkout 7c0f3f68006b9b42ce944b02a2059128cc5826ec
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/powerpc/kernel/btext.c:49:12: error: 'force_printk_to_btext' defined but not used [-Werror=unused-variable]
>        49 | static int force_printk_to_btext;
>           |            ^~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
> 
> 
> vim +/force_printk_to_btext +49 arch/powerpc/kernel/btext.c
> 
>      47	
>      48	static int boot_text_mapped __force_data;
>    > 49	static int force_printk_to_btext;
>      50	

Will remove this variable in another patch.

Thanks
Yu Kuai
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
