Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397C6331A31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCHWab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCHW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:29:57 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE72C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 14:29:57 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a4so7378543pgc.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 14:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sh5lfCQe/1CSXBegypH5sfoEf89f8bD5kkTOkHnpdnw=;
        b=D7Lg6Gqfum3Yoo0KBIU2pzN4yxEjJCWB8cwDzoLeeJEVI3cHiC9kREuZMHGlpzQU0N
         uoptM6any9yo7t6XfGdG0uS0HGWUMzdKVQSGxmFimzrj9hjmWmrKk2kDSCJkl+ZqpvZ8
         3lrpZRtpS9+n5PPqUrxopGKXYMKIie6biESEZKwjA8MpVLqNsw+2V1iL5V/KmAmXNhyo
         IXjfL9Mo/gUENLkKEvGoAoYmyBhLS5W7ExEjJgLJSMPVe7fGYtMlech3yWgnLCRo+Nk0
         Nvrsn+6W7E26DqIAY8KJz3fsSJXKNVfymoawolfBBpDBixmLzTh37TB+sjsiwrDmPOmM
         KhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Sh5lfCQe/1CSXBegypH5sfoEf89f8bD5kkTOkHnpdnw=;
        b=QTWxJzB+H/EDFh99PY5EeDB8D77H1Dq82nNQbrMevmjeElFUVWCiJ5ebyBl1C36JTc
         /9kh+/h8PPYcMtIY5DQnnBsX2t5viyRz0qgrndWPrzh/GGZb0SFK4tV5aBfsISnFtiqH
         N6RN/xNeSyQgLZf3uRGxIiqHVS0VyQn4phT0zDdsjO0Twf9rsO4xmVk4rVBe+UQ86ODN
         SnKq3br3+sSkMYvJmejDNnVZmhRyFVY925kNHjpfuhSWHFcchliw/8/E1Ej2nI/xj04Q
         nPHxKzmIcKBaGH5hhMzQSiuLUUMVYzK6lcAmhnlQwe+UVMsZZFAvxiqrpGVzKCcJwV+R
         9poQ==
X-Gm-Message-State: AOAM5305VVo27cnliWJYXCiq/aqkq23qtWQ5ivN1wBLPqUkUvDo1yoOI
        2U8IccZ4tpJ7JOS8BvW/pFY=
X-Google-Smtp-Source: ABdhPJxeocRilqyTmKL1i8h7ADYciQ2bbVMZ/l4r1ThOWuSVgqveoHZh7JKVSQcDo3eXjC1OEtqP7A==
X-Received: by 2002:a62:62c2:0:b029:1ee:1e3f:1b68 with SMTP id w185-20020a6262c20000b02901ee1e3f1b68mr22388338pfb.25.1615242597146;
        Mon, 08 Mar 2021 14:29:57 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id h23sm11074745pfn.118.2021.03.08.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:29:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 14:29:53 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kbuild-all@01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEalYUiTH45XO2EV@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <202103090555.LtLPf1Ho-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103090555.LtLPf1Ho-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 05:29:30AM +0800, kernel test robot wrote:
> Hi Minchan,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on hnaz-linux-mm/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/mm-page_alloc-dump-migrate-failed-pages/20210309-042205
> base:   https://github.com/hnaz/linux-mm master
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/3c635af37b862e9c601ee8d5818f7da9cd3e2e57
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Minchan-Kim/mm-page_alloc-dump-migrate-failed-pages/20210309-042205
>         git checkout 3c635af37b862e9c601ee8d5818f7da9cd3e2e57
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
>      169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
>          |                                                 ^~
>    include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>       78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>          |                                          ^
>    include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
>      143 |  BUG_ON(!virt_addr_valid(buf));
>          |  ^~~~~~
>    include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
>      143 |  BUG_ON(!virt_addr_valid(buf));
>          |          ^~~~~~~~~~~~~~~
>    In file included from arch/m68k/include/asm/page.h:60,
>                     from arch/m68k/include/asm/thread_info.h:6,
>                     from include/linux/thread_info.h:38,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/m68k/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:10,
>                     from mm/page_alloc.c:19:

I am not sure this is triggered by the patch since I could see the
warn with reverting the patch.
