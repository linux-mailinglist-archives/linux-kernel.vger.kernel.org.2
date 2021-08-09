Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7463E3DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 04:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhHICan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 22:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhHICal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 22:30:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1968EC061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bZYo8E3NoPCdQsD1K8epoiMvW0tENbZpp7jmQByQbzE=; b=V0y7Uk5ZnkDlA5jxT4+U9agg+U
        DGUsIrFPHMeHHPWmK79y/v0kxo2o+K5746ApR1c3sSkKc6IDn6Sqi7eyRVlqt5v+NjBtktL3CusoK
        shzlfGov1ATLs928lfeatp+8m7Bpts2VospHMkT4M5tgINs+mB0I4+hwuM9g+zkWSmHlCosLIP19N
        Tpbw8pF6jP2WSIFK8s7jrWomvOyB9ji/cBg1e6NGFWQ1JFfDAGiXuQCj0jNF1VZdYH0aX8vpcLZZS
        S67gTmRVQ18WqjJMNBf+Nr6oUjkuvOEl6HOkv7PakgGYFtTYZ9DALejovf0kDcgZ9J31KFX6n4Kvj
        Pr/5N6Qg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCv1w-00AXWB-BY; Mon, 09 Aug 2021 02:28:55 +0000
Subject: Re: [PATCH] openrisc: Fix compiler warnings in setup
To:     Guenter Roeck <linux@roeck-us.net>,
        Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210805030035.2994973-1-shorne@gmail.com>
 <20210809013128.GA3698029@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a3de28d-17d5-ec22-0ffb-97f5ca11c127@infradead.org>
Date:   Sun, 8 Aug 2021 19:28:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809013128.GA3698029@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 6:31 PM, Guenter Roeck wrote:
> On Thu, Aug 05, 2021 at 12:00:33PM +0900, Stafford Horne wrote:
>> This was pointed out with the recent name change of or32_early_setup to
>> or1k_early_setup.  Investigating the file I found a few other warnings
>> so cleaning them up here.
>>
>>      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
>>        220 | void __init or1k_early_setup(void *fdt)
>> 	  |             ^~~~~~~~~~~~~~~~
>>
>> Fix this the missing or1k_early_setup prototype warning by adding an
>> asm/setup.h file to define the prototype.
>>
>>      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
>>        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
>> 	  |             ^~~~~~~~~~~~~~~~~~
>>
>> The function detect_unit_config is not used, just remove it.
>>
>>      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
>>
>> Add @fdt docs to the function comment to suppress this warning.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Puzzled. This patch gives me:

Stafford posted a v2 earlier today:
https://lore.kernel.org/lkml/20210808135437.3640549-1-shorne@gmail.com/


> Building openrisc:or1ksim_defconfig ... failed
> ------------
> Error log:
> In file included from ./arch/openrisc/include/asm/page.h:35,
>                   from ./include/linux/generic-radix-tree.h:39,
>                   from lib/generic-radix-tree.c:3:
> ./arch/openrisc/include/asm/setup.h:11:13: error:
> 		expected '=', ',', ';', 'asm' or '__attribute__' before 'or1k_early_setup'
>     11 | void __init or1k_early_setup(void *fdt);
>        |             ^~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:272: lib/generic-radix-tree.o] Error 1
> 
> Bisect log attached for completeness.

That needs #include <linux/init.h>

-- 
~Randy

