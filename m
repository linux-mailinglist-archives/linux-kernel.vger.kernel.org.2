Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF863C3DBA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbhGKPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhGKPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:54:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB0C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IFHlYKqTo5g1KI9wdW9PxpmMJe002Z8/bWNtBvFoP5k=; b=wM7MtehhUJc8uDrV0Ww3UWwkVE
        Sjat6Kmo7Dr0+7M6EKcZSht4D54DEjjy+PDxeeDf9Beb8yQrjB+I48BklqJUomWcF2T+EvJT3fQSK
        p87Qua6s2/1RFubhqe516u6MBUfc7ZMUHf8vBPMcpmVFW4cdaV3JjYf8G08qnj8EtWBYR65DyWFgF
        CI7L8yHOkqLgqV+rZoVY6T2hLyi6yCvaLRE8S64ZNVBEKugNy2iw4qLcj4bcJsZd6G9qkVUItPmkB
        9FfpOiQT7F0ozw3KzkxR8tDQHV3IHkdYuekoCwQGUEJOAzu4PISsxl3wd6U/jVw6nXibEXog7cWry
        1duqEFCA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2bjm-005GCv-Kq; Sun, 11 Jul 2021 15:51:22 +0000
Subject: Re: stackdepot.c:undefined reference to `__irqentry_text_start'
To:     kernel test robot <lkp@intel.com>,
        Oliver Glitta <glittao@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <202107112307.R9jiyVzw-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f24ab355-1d38-2050-13ea-4fd4f7556304@infradead.org>
Date:   Sun, 11 Jul 2021 08:51:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107112307.R9jiyVzw-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 8:13 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   de5540965853e514a85d3b775e9049deb85a2ff3
> commit: 788691464c29455346dc613a3b43c2fb9e5757a4 mm/slub: use stackdepot to save stack trace in objects
> date:   3 days ago
> config: arc-randconfig-r004-20210711 (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=788691464c29455346dc613a3b43c2fb9e5757a4
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 788691464c29455346dc613a3b43c2fb9e5757a4
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>>> stackdepot.c:(.text+0x5a): undefined reference to `__irqentry_text_start'
>>> arc-elf-ld: stackdepot.c:(.text+0x5a): undefined reference to `__irqentry_text_start'
>    arc-elf-ld: stackdepot.c:(.text+0x62): undefined reference to `__irqentry_text_end'
>    arc-elf-ld: stackdepot.c:(.text+0x62): undefined reference to `__irqentry_text_end'
>    arc-elf-ld: stackdepot.c:(.text+0x6a): undefined reference to `__softirqentry_text_start'
>    arc-elf-ld: stackdepot.c:(.text+0x6a): undefined reference to `__softirqentry_text_start'
>    arc-elf-ld: stackdepot.c:(.text+0x72): undefined reference to `__softirqentry_text_end'
>    arc-elf-ld: stackdepot.c:(.text+0x72): undefined reference to `__softirqentry_text_end'


Please see https://lore.kernel.org/lkml/20210710145033.2804047-1-linux@roeck-us.net/


