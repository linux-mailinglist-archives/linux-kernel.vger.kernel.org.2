Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB5542A33B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhJLL3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbhJLL3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:29:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F786C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y+bzX7eo0mgNQAP2i+j+e4ro15ekvZebPoCJQosdbpE=; b=mk9TsScC58WpZdWtEDL8csju2g
        uHSASi0k0prGFpdpiKDWnonLi7tCMoGqjkGE/lw/ZiJHM5qyD0LC4sQkMNJcmV5Ng8gjrlTBqSqrv
        SHsVaSjl3GelGK4HoGdLgyHCLjvXxscDr2wQQOUnRRG5BJ4okFpHIF5WiVkYKXmaoFPkjldFhevsp
        Qslt92Rtfj3jQeiUJgoiG7GglsvLUNXwDyD2xLIVzfiDbEFFklIbQneaKv/yMUBCxjxW/Fa6FD6gV
        iQbSIpWbvho9dJX2losILJga+KpAQHCnAmm21KzuakGrDQYpTRVhBR6nUiBMsQeqjVWdWKeWX+Xjz
        C6Zw2bQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFvr-009P4T-Sd; Tue, 12 Oct 2021 11:26:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E83D8300079;
        Tue, 12 Oct 2021 13:26:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEC7820218D80; Tue, 12 Oct 2021 13:26:54 +0200 (CEST)
Date:   Tue, 12 Oct 2021 13:26:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip:sched/core 14/47] kernel/sched/fair.c:893:22: error:
 variable 'p' set but not used
Message-ID: <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
References: <202110121132.N2z9JrD0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110121132.N2z9JrD0-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:57:41AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   b2d5b9cec60fecc72a13191c2c6c05acf60975a5
> commit: 60f2415e19d3948641149ac6aca137a7be1d1952 [14/47] sched: Make schedstats helpers independent of fair sched class
> config: hexagon-buildonly-randconfig-r002-20211012 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dcf39554dbea780d6cb7e12239451ba47a2668)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=60f2415e19d3948641149ac6aca137a7be1d1952
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip sched/core
>         git checkout 60f2415e19d3948641149ac6aca137a7be1d1952
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/sched/fair.c:860:28: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>                    struct sched_statistics *stats;
>                                             ^
>    kernel/sched/fair.c:892:27: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>            struct sched_statistics *stats;
>                                     ^
> >> kernel/sched/fair.c:893:22: error: variable 'p' set but not used [-Werror,-Wunused-but-set-variable]
>            struct task_struct *p = NULL;
>                                ^
>    kernel/sched/fair.c:910:22: error: variable 'p' set but not used [-Werror,-Wunused-but-set-variable]
>            struct task_struct *p = NULL;
>                                ^
>    kernel/sched/fair.c:909:27: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>            struct sched_statistics *stats;
>                                     ^
> >> kernel/sched/fair.c:936:22: error: variable 'tsk' set but not used [-Werror,-Wunused-but-set-variable]
>            struct task_struct *tsk = NULL;
>                                ^
>    kernel/sched/fair.c:935:27: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>            struct sched_statistics *stats;
>                                     ^
>    kernel/sched/fair.c:4451:28: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>                    struct sched_statistics *stats;
>                                             ^
>    8 errors generated.

Again, I have absolutely no intention of fixing this. IMO this is the
compiler being a total pain in the arse.

Please stop reporting this.
