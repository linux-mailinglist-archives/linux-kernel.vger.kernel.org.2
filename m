Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D951E45E450
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357481AbhKZCWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245310AbhKZCUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:20:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=6vEAJlNPl1ic28avxji2uZsjO8Onw8hpf5i06ixac48=; b=B8uYRYH904JPj26E0SQ1DJNmcV
        qNf1k1wWNZKP/3vjGinAIDCYScdPA1xPmyL3VATCXpvmUb3IkUQy3ZTffaeFPUmMEuagYTuVRA6ka
        gUxGzLTLLHHnEMtfG7JAnsEmg91OaOvg45C2Gn+6eSV5Tn4H2E/RLNexEoy63KwhnkNnnJh34WD5X
        NPWxSJS212BypruUxTbWq951Nd1kOSDDRAkjv/oWvUn3NQ9lXABCoMbliAxF3ylErmVnsgwi4L4ao
        zkkkUPrdy/eXE+NJ6JsI+AxrJhbUjVy2hHuHoyaMcJ9tgD+N7reLgSv4VcwLxLu7a8wLKxn2j9+Il
        31sJHtiA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqQmc-0090Ps-IL; Fri, 26 Nov 2021 02:16:14 +0000
Subject: Re: ERROR: start_text address is c000000000000500, should be
 c000000000000100
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202111242215.KCExqByj-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <999e4424-c7c7-7b18-ca26-0ee44db5754b@infradead.org>
Date:   Thu, 25 Nov 2021 18:16:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202111242215.KCExqByj-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 6:31 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
> commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
> date:   3 months ago
> config: powerpc64-randconfig-r033-20211123 (https://download.01.org/0day-ci/archive/20211124/202111242215.KCExqByj-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47c258d71ebfc832a760a1dc6540cf3c33968023
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 47c258d71ebfc832a760a1dc6540cf3c33968023
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: start_text address is c000000000000500, should be c000000000000100
>>> ERROR: try to enable LD_HEAD_STUB_CATCH config option
>>> ERROR: see comments in arch/powerpc/tools/head_check.sh
> 
> ---


Hm, interesting. After following the directions above and setting
CONFIG_LD_HEAD_STUB_CATCH=y and then rebuilding, the "should be" address
has changed:

ERROR: start_text address is c000000000000500, should be c000000000000200
ERROR: try to enable LD_HEAD_STUB_CATCH config option
ERROR: see comments in arch/powerpc/tools/head_check.sh


Michael, any ideas?

-- 
~Randy
