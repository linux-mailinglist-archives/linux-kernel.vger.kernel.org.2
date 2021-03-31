Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64534FA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhCaHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhCaHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:33:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D67C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FCOeNsdqWlXJJzwZbuVskDWYiqHeP5gXynaJwTTANcc=; b=plAm4hZUpsSpsxqx+jW/gn4Fut
        VfWup/icq2Hq38lolETXuZxVQqx6wim2ihPB+y4mYuZC394djW8lXkEvCp9sN/94GbCoVuzGa2kc+
        uvaOqJqZTg44JOKztdY1IeGR2qMtFhSckYtLziUedc372yc99BZ5gHppUN4f0O6ptDTqpbOsEgTyN
        W6or09iuSorZD+2WzXi5zih0SqAd2bbhPP4IWbLefT7GL57b803QfG6UFoGLx0+vaqUpsD0DeDmRp
        Ex5KR+A0XuRyuRIG+xEe3/BV/BtpQLmOI5fKQdn7vVUcQT+SSto1r9V9pEdrc8Mi1doIJc17nz1oX
        0VWPVhgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRVKw-004C3H-2M; Wed, 31 Mar 2021 07:32:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38459304B90;
        Wed, 31 Mar 2021 09:32:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DEB82B878558; Wed, 31 Mar 2021 09:32:21 +0200 (CEST)
Date:   Wed, 31 Mar 2021 09:32:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: kernel/sched/core.c:5370:37: warning: cast between incompatible
 function types from 'long int (*)(void)' to 'int (*)(void)'
Message-ID: <YGQlhQ9rfkKBwUKB@hirez.programming.kicks-ass.net>
References: <202103311434.dpBaRaX7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103311434.dpBaRaX7-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:15:41PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5e46d1b78a03d52306f21f77a4e4a144b6d31486
> commit: 826bfeb37bb4302ee6042f330c4c0c757152bdb8 preempt/dynamic: Support dynamic preempt with preempt= boot option
> date:   6 weeks ago
> config: x86_64-randconfig-r011-20210331 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=826bfeb37bb4302ee6042f330c4c0c757152bdb8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 826bfeb37bb4302ee6042f330c4c0c757152bdb8
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/sched/core.c: In function 'schedule_tail':
>    kernel/sched/core.c:4252:13: warning: variable 'rq' set but not used [-Wunused-but-set-variable]
>     4252 |  struct rq *rq;
>          |             ^~
>    In file included from include/linux/err.h:5,
>                     from include/linux/kthread.h:5,
>                     from include/trace/events/sched.h:8,
>                     from kernel/sched/core.c:10:
>    kernel/sched/core.c: In function 'setup_preempt_mode':
> >> kernel/sched/core.c:5370:37: warning: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Wcast-function-type]

That warning is broken IMO.

Still, I have a patch for this somewhere.. I'll try and push it out
sometime soon.
