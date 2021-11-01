Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E64441BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhKANjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231808AbhKANjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635773832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgWA21RbnVHNJqYVTGhY7Yn3OnV0VV8UOaMkbZYsosU=;
        b=PStJf1wHucughjPoMMEx/rKqOgAa9s4PCtD/oajAf1nff8XnmhZGe7WFXRBSERlKeSrYnl
        NtXoigZyIKZncbPcKTfhZlGHx65IrqEHWmyYNU281dD9DPuzDk9+ww+y8Iy4t6rmWYXYqV
        eU0b3SGqdJE18mR+pcnj35pOj9SCFb0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-luv3hVoNNrehvpOsZvpeBg-1; Mon, 01 Nov 2021 09:37:11 -0400
X-MC-Unique: luv3hVoNNrehvpOsZvpeBg-1
Received: by mail-ed1-f71.google.com with SMTP id i22-20020a05640242d600b003e28aecc0afso3021885edc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 06:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wgWA21RbnVHNJqYVTGhY7Yn3OnV0VV8UOaMkbZYsosU=;
        b=rZUXmpzB7ODyQzqqM2x7igNH/qld9ltsVNflCsj7/88isXTxrmqPvSOlXC0FbOcO94
         PD62NxwyzPqj74tsba9DK9p9TyH6uyW9jPOTTzW0gLk0nebA04Dse3Ucn85zlIWZDU10
         A3OaLDVukFx1OjNJYiuiB+95pmF3TeNurJiCJ8y5P/YUaOcoM78JH6/LT8lk/NPaBNZV
         6ilTmdrrfoeKxB8HnPtKRaBKTSaxP00XJ16z3OeDQNkIKLsQltnbsEUMJhAG1MtXnELb
         WRE6J+hyLNKU5Ky3vLNtUEIZ436egXDuils1nvOvc6Tm2LRmQy1nRG+wS8sYQ2TqwsuX
         bRFg==
X-Gm-Message-State: AOAM532Z9Nwj2Klv2Rkr6tyFLQ94E0BZPWl3FYABg8z3tkU7R7FerUCg
        BFGq2jW6I7pYzLoV/unc8Q9mJYchsWSDj7EOQElgHY+6tmnMx+mkYjpdsYWqowQSm2coFtntawb
        EQZlv2r2k8pamnxievmjI7OqB
X-Received: by 2002:a17:906:7d48:: with SMTP id l8mr27921157ejp.106.1635773830180;
        Mon, 01 Nov 2021 06:37:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWZv3U+QmniDANZEr4DQ+HnTJLnVf970DRUk1goa2HV9d2mYiMDrbyzv10yCoN4cuvXH5n9w==
X-Received: by 2002:a17:906:7d48:: with SMTP id l8mr27921137ejp.106.1635773830030;
        Mon, 01 Nov 2021 06:37:10 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b2sm8919031edv.73.2021.11.01.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 06:37:09 -0700 (PDT)
Date:   Mon, 1 Nov 2021 14:37:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: [rostedt-trace:for-next 58/100]
 samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous prototype for
 function 'my_direct_func'
Message-ID: <YX/thIXtDzfhljX7@krava>
References: <202111010507.F9ud1mUL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111010507.F9ud1mUL-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 05:46:26AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
> head:   93d76e4a0e0112b320c4f0e2a3930ad634628c58
> commit: 5fae941b9a6f95773df644e7cf304bf199707876 [58/100] ftrace/samples: Add multi direct interface test module
> config: x86_64-randconfig-r024-20211031 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82ed106567063ea269c6d5669278b733e173a42f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?id=5fae941b9a6f95773df644e7cf304bf199707876
>         git remote add rostedt-trace https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>         git fetch --no-tags rostedt-trace for-next
>         git checkout 5fae941b9a6f95773df644e7cf304bf199707876
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous prototype for function 'my_direct_func' [-Wmissing-prototypes]
>    void my_direct_func(unsigned long ip)
>         ^
>    samples/ftrace/ftrace-direct-multi.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void my_direct_func(unsigned long ip)

hum, that can actually be static.. I'll check

thanks,
jirka

>    ^
>    static 
>    1 warning generated.
> 
> 
> vim +/my_direct_func +8 samples/ftrace/ftrace-direct-multi.c
> 
>      7	
>    > 8	void my_direct_func(unsigned long ip)
>      9	{
>     10		trace_printk("ip %lx\n", ip);
>     11	}
>     12	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


