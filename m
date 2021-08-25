Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE43F6DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhHYDdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHYDdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:33:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E033EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:32:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m17so6456379plc.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMvozoUZ7Z0eDAIiUvnacEplSWNqczHFTpBObMxFc/Y=;
        b=Hl1VeBx1VSmDfIsz6h1ipCA7toiURujhTuLxid/8s4CpTOIXU0u89MQOnCXG+peA9X
         s/m0Xw5LQ5j6y7q8mWsmTLETlyFlAD4JYsTcm3PqqAGgKdxLOh/1UAOwcMFuJu+wELob
         vciGVjcZ+qJGT4w/6SItpycOwx3KDw3crLV+gqKAQDblMbpCsPQMvkKOa0TDdBjQOB5J
         XrTuC26gWGZ+CjxvejxkdEb4bpV2hfXbFr9mtFBEasAC2V8lxyBmRv6bB1eAzco4am2W
         hDp1n4WxOpaMwRp19hrN4nMYgZWK62pDbqFA4iKOMWp83teg0FTy1/4+n0A3Zmei/JSQ
         f/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMvozoUZ7Z0eDAIiUvnacEplSWNqczHFTpBObMxFc/Y=;
        b=pYcRiPzdkHgAa83/VClj27ld0QrqMG7pIj7ipT4g8unxUjZB3w9/Fap5qUaqLN05iw
         dsqXxp25nAAfs0xGKRk7UhtfpUErbwWI4gHhCNeCBqakjMGBUqvagTEghadO2yCoyQgB
         aD1hxLf3wEXNMCVS5X+WnHJFqIX7cZoN9szX5QjqCMNceblUGKH26NKqmSXFM+GVKbjC
         YYtA7mDrC6ccBmsahwyUS/++E39A0FH89MPUM9dVya5hTeCtlUEhdK2UFkQg8huV4h/j
         2ExlN8O8KotrmlZWbeqmFZwkiWYZ13Qf1hkryV+KG3A6OnkInwR8v7m5N1vm6eLbda4r
         VYvA==
X-Gm-Message-State: AOAM531x8ScSbQqVG9UB1Om7aADrvenFySsavEI+9thkrDyH0Cez0x+V
        paO299vMOLYqNBx3dCL566Uas0CCJAn5JA==
X-Google-Smtp-Source: ABdhPJzF9nwLx8MOn6Ef7vNx/Ok5Dm5sn5aPAthC1uYfXzYsN+GsB0U3SPPZXW8CI7KN6Gye6t9o+g==
X-Received: by 2002:a17:90a:1b07:: with SMTP id q7mr7982600pjq.100.1629862357506;
        Tue, 24 Aug 2021 20:32:37 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id b14sm20157966pfo.76.2021.08.24.20.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:32:37 -0700 (PDT)
Date:   Wed, 25 Aug 2021 09:02:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [vireshk-pm:cpufreq/arm/linux-next 15/17]
 drivers/base/arch_topology.c:156:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <20210825033233.sjnvlemmrocswxoc@vireshk-i7>
References: <202108242312.DH3jDsOZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108242312.DH3jDsOZ-lkp@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-21, 23:57, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
> head:   028068a13c533046fd4e37f06fb6efe50c759892
> commit: 942914c2f2438d137bcb9b9cb8343de62dc482df [15/17] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
> config: riscv-randconfig-s032-20210824 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-348-gf0e6938b-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=942914c2f2438d137bcb9b9cb8343de62dc482df
>         git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
>         git fetch --no-tags vireshk-pm cpufreq/arm/linux-next
>         git checkout 942914c2f2438d137bcb9b9cb8343de62dc482df
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/base/arch_topology.c:156:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
>    drivers/base/arch_topology.c:156:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    drivers/base/arch_topology.c:156:9: sparse:     got unsigned long *
> 
> vim +156 drivers/base/arch_topology.c
> 
> 2ef7a2953c81ee Juri Lelli 2017-05-31  153  
> 4ca4f26a9c6610 Juri Lelli 2017-05-31  154  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
> 2ef7a2953c81ee Juri Lelli 2017-05-31  155  {
> 2ef7a2953c81ee Juri Lelli 2017-05-31 @156  	per_cpu(cpu_scale, cpu) = capacity;
> 2ef7a2953c81ee Juri Lelli 2017-05-31  157  }

Fixed thanks.

-- 
viresh
