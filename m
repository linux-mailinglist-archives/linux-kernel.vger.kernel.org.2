Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1886447843
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 02:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhKHBby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 20:31:54 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27118 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKHBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 20:31:53 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HnYPC527Hz1DJC4;
        Mon,  8 Nov 2021 09:26:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 09:29:06 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 09:29:05 +0800
Message-ID: <2cf3f6a2-769a-7d68-b42f-3b74b58925fb@huawei.com>
Date:   Mon, 8 Nov 2021 09:29:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] amba: Move of_amba_device_decode_irq() into
 amba_probe()
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Russell King <linux@armlinux.org.uk>, <saravanak@google.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>
References: <20211104095643.180429-3-wangkefeng.wang@huawei.com>
 <202111060042.JQjb9nZb-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202111060042.JQjb9nZb-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, will fix and resend after 5.16-rc1.

On 2021/11/6 0:41, kernel test robot wrote:
> Hi Kefeng,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on next-20211105]
> [cannot apply to v5.15]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/amba-some-cleanup/20211104-174611
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7ddb58cb0ecae8e8b6181d736a87667cc9ab8389
> config: arm-randconfig-r034-20211104 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 847a6807332b13f43704327c2d30103ec0347c77)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm cross compiling tool for clang build
>          # apt-get install binutils-arm-linux-gnueabi
>          # https://github.com/0day-ci/linux/commit/e7bfc31724b5810d3dade0f2b83635fec6aef601
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Kefeng-Wang/amba-some-cleanup/20211104-174611
>          git checkout e7bfc31724b5810d3dade0f2b83635fec6aef601
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/amba/bus.c:186:9: error: implicit declaration of function 'of_amba_device_decode_irq' [-Werror,-Wimplicit-function-declaration]
>                     ret = of_amba_device_decode_irq(dev);
>                           ^
>     drivers/amba/bus.c:375:12: error: static declaration of 'of_amba_device_decode_irq' follows non-static declaration
>     static int of_amba_device_decode_irq(struct amba_device *dev)
>                ^
>     drivers/amba/bus.c:186:9: note: previous implicit declaration is here
>                     ret = of_amba_device_decode_irq(dev);
>                           ^
>     2 errors generated.
> 
