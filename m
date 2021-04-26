Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8836ABDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhDZFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDZFog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:44:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF6EC061574;
        Sun, 25 Apr 2021 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=j7DLfZ0gGkW1/uJMvg7bWmnCtMj5oRBCq6k+gK0AjJs=; b=SVoTz5bh6ctXoJTXkFNB5Da1Rt
        v3q4RxFNi3raWf7kF+SU8dSp0059/RTV1R//EYW44gB0kHpvIfP3HR4RPVKrMX4WkAX0yTn6kgvWE
        JH0WaVtojIjXGk62LUljJ8AJVIGfvHeKPeXEWFSXNZnuLeuO1SvEkZIa5GioshpTLM2sgBq/D5kDe
        W7w4wxbRXdMKnQpBcLk3qCLFzLKhAzu8N3LMve1WVn2AhufVxxrO7FvV5A+JR6EM3wBtRYrpsdI7I
        16m2i1e3lqEfV8/Px6lSqS2HKmCmvh/FzkAEugF0GX1vgiciP6e0wR2N+QlDfIGRTgObCldtAu5AO
        LMego0dA==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lau26-006yyW-KG; Mon, 26 Apr 2021 05:43:48 +0000
Subject: Re: ingenic-adc.c:undefined reference to `clk_get_parent'
To:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <202103162301.oomY9NwI-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ac51550d-c72e-4a85-ed0e-a4cddbf495be@infradead.org>
Date:   Sun, 25 Apr 2021 22:43:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202103162301.oomY9NwI-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-clk + maintainers]

On 3/16/21 8:54 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1a4431a5db2bf800c647ee0ed87f2727b8d6c29c
> commit: a07a4fe5ff460e99293c0d682421920d54e31d7f iio:adc:ingenic: drop of_match_ptr protection and include mod_devicetable.h
> date:   8 months ago
> config: mips-randconfig-p001-20210316 (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a07a4fe5ff460e99293c0d682421920d54e31d7f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a07a4fe5ff460e99293c0d682421920d54e31d7f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
>>> ingenic-adc.c:(.text+0x8c): undefined reference to `clk_get_parent'
>    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
>    ingenic-adc.c:(.text+0x164): undefined reference to `clk_get_parent'

Hi,

My guess (analysis) suggests that this problem is due to
a difference in when clk_get_parent() is available between
<linux/clk.h> where it depends on CONFIG_HAVE_CLK and
drivers/clk/clk.c, which is built iff CONFIG_COMMON_CLK.

Any comments/suggestions?

thanks.
-- 
~Randy

