Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4344E45E6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357951AbhKZEBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357943AbhKZD7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 22:59:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F99C0698C3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:54:32 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id a11so13448318qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4gGVDXq87m+F4233ZN8Js9GucPgSxhvj+GQdGUcdMPA=;
        b=RGZKkhDlKEUB8VOo0+51jaHDk/qDO1sZBUecmghOi4ST8Aq9Q5GQ0joP5WmrcHPAN5
         fp9aJwoAn7Xp/cCMS4m+VNKXzZJgFlbnf2Owg1N/yvtBHZwHaMf6W20V7V3sZRxpZlIB
         dN1CTq34L4VXs6iIgmkt1lKa+7sAQfUfLF0ol2xrcpi8cdPR1dwvwMO/Ex+Ow1K9D5C+
         SnJE6rvixlG2yyWwiiSfoDaXoAr4isaewcV1tzAoRoHkoim7ZaM04HnAN+4QrS9WTA8M
         F37c/UywB9bNEx11nAMufR6g9aqy9/sLywgmW6aWGeW7TlBFjE+2YKZxYmBc2KbR7QMB
         kjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gGVDXq87m+F4233ZN8Js9GucPgSxhvj+GQdGUcdMPA=;
        b=cK61HHzNUAjw1wbDho6AT9FPxWCLW0IPdERQ0t+UllgfLc+OyayaizdXooWULmnEWB
         FEnYwLGV9c1ljRxgvgl63aUErvZDoR7Hxnjn44By/aumhNBuIpnRkCoyz8gNIVfql3XD
         94w5zirSs3hLjgSaL+3BLqNXpTwq1qdLZ9yqDstDjl+TksM06+1gOEiPiy6js59J/yTs
         ljP6Ly7jjNriDF1RViWvGnuDdbmHCaTC6ldUESOOP+m58arcBaIr4kPz1u6jye8FmqUc
         ZHDbzvSrmLvzJjTsFw1sOXcJaDlwJuVNFcGLVaBUZp6M3JKTvwrpn+PZxc+CVskpXfQ5
         8W+g==
X-Gm-Message-State: AOAM530JQUgX6lxrHQqOfmDziYPdud+5LT3oht4g+St4TvHDyaUxbNMt
        d5NakIpGi0OFycvN1C+5Sst1qv2k25g=
X-Google-Smtp-Source: ABdhPJyB/NeDrYAExhUfcg/nY9fACeoZ9lVQpUklAYHaUV6hGN4snw1OBDkb8+7A02RPwTP9+KpS6A==
X-Received: by 2002:ae9:edd3:: with SMTP id c202mr19690024qkg.274.1637895271106;
        Thu, 25 Nov 2021 18:54:31 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id h12sm2415352qkp.52.2021.11.25.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 18:54:30 -0800 (PST)
Date:   Thu, 25 Nov 2021 18:54:27 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [norov:bitmap-tmp 7/8] arch/powerpc/xmon/xmon.c:472:64: error:
 expected ')' before 'return'
Message-ID: <20211126025427.GA149004@lapt>
References: <202111260340.kCOW9xsR-lkp@intel.com>
 <81cbcf8c782cea2261af55965718a0d8ebb3b21f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81cbcf8c782cea2261af55965718a0d8ebb3b21f.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:43:48AM -0800, Joe Perches wrote:
> On Fri, 2021-11-26 at 03:17 +0800, kernel test robot wrote:
> > tree:   https://github.com/norov/linux bitmap-tmp
> > head:   75ee333c81c999b29a49810611fb160cec32217d
> > commit: 29f49f10b3fbef5a88db0a7e370984297616f0fa [7/8] lib/cpumask: replace cpumask_weight with cpumask_{empty,gt,le,eq}
> > config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111260340.kCOW9xsR-lkp@intel.com/config)
> > compiler: powerpc-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/norov/linux/commit/29f49f10b3fbef5a88db0a7e370984297616f0fa
> >         git remote add norov https://github.com/norov/linux
> >         git fetch --no-tags norov bitmap-tmp
> >         git checkout 29f49f10b3fbef5a88db0a7e370984297616f0fa
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/powerpc/xmon/xmon.c: In function 'wait_for_other_cpus':
> > > > arch/powerpc/xmon/xmon.c:472:64: error: expected ')' before 'return'
> >      472 |                 if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
> >          |                    ~                                           ^
> >          |                                                                )
> >      473 |                         return true;
> >          |                         ~~~~~~                                  
> > > > arch/powerpc/xmon/xmon.c:476:9: error: expected expression before '}' token
> >      476 |         }
> >          |         ^
> 
> It's always good to compile test patches before submitting them and:

As you can check, I didn't submit this patch. I pushed a series to my github,
and Intel 0-day bot tested it, and apparently found missed ')'.

I love this service, thank you Intel.
  
> > vim +472 arch/powerpc/xmon/xmon.c
> > 
> >    465	
> >    466	static bool wait_for_other_cpus(int ncpus)
> >    467	{
> >    468		unsigned long timeout;
> >    469	
> >    470		/* We wait for 2s, which is a metric "little while" */
> >    471		for (timeout = 20000; timeout != 0; --timeout) {
> >  > 472			if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
> >    473				return true;
> >    474			udelay(100);
> 
> unrelated trivia:
> 
> It seeems this loop could consume a lot of cpu/power.
> 
> Could this use usleep_range() or maybe something else that doesn't allow
> rescheduling on another cpu?
> 
> Maybe it should be something like
> 
> 	unsigned long timeout = jiffies + msecs_to_jiffies(2000);
> 
> 	while (time_before(jiffies, timeout)) {
> 		if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
> 				return true;
> 		usleep_range(100, 200);
> 	}
> 
