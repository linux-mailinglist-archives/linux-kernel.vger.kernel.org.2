Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A5407694
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhIKMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 08:25:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42153C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oe2/Kltpm9QvzVcCViYPsuS3iZQ1CLBgukRDQOqq9mo=; b=c3D7KRumRC6Ixcoump3FpxjikM
        XYiRb24ZWO9FvlWNhZFJBnH8ZtXGCGbsvX9QXSQjG+op/ve7Fwtr5iWxFHIIZXeRMrYH68q2c7BOv
        cG1DsdaXiPdorRmBLpAx+yS87nC3t2NM6p+y3du6lYofqR7LkWakatiFNWF0eIi3NBB2Tp210luGg
        lLi9YVPieOwF6j750CV9WmaQwVp5gxsOdH4NOuvU66BBw+NZzRKSsRkxZSiQkgamnTkbQwVYzMLvG
        tuGKDoozsRuiGa4TZ9rUTPz7GHPMiRHgRqJZPagwGBVOCNmRdXT9UrX8EWqGXnzOU7R6DAn4fLOhi
        xfOB/7Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mP23P-002N7z-Fo; Sat, 11 Sep 2021 12:24:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 163129862C9; Sat, 11 Sep 2021 14:24:19 +0200 (CEST)
Date:   Sat, 11 Sep 2021 14:24:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <Valentin.Schneider@arm.com>
Subject: Re: [kbuild-all] Re: [peterz-queue:sched/core 8/11]
 include/linux/sched.h:1722:57: warning: unused parameter 'dst'
Message-ID: <20210911122419.GY4323@worktop.programming.kicks-ass.net>
References: <202108210940.aD3d42zA-lkp@intel.com>
 <YSNkCAyMU0tJoedT@hirez.programming.kicks-ass.net>
 <428f3e9a-a8d3-51ca-5e2e-caa50b8da3eb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428f3e9a-a8d3-51ca-5e2e-caa50b8da3eb@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 05:16:05PM +0800, Chen, Rong A wrote:
> 
> 
> On 8/23/2021 5:02 PM, Peter Zijlstra wrote:
> > On Sat, Aug 21, 2021 at 09:20:50AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> > > head:   234b8ab6476c5edd5262e2ff563de9498d60044a
> > > commit: b90ca8badbd11488e5f762346b028666808164e7 [8/11] sched: Introduce task_struct::user_cpus_ptr to track requested affinity
> > > config: i386-randconfig-a016-20210820 (attached as .config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
> > > reproduce (this is a W=1 build):
> > 
> > Dear 0day folks; could you please blacklist me for all W=1 build output?
> > I'm 100% not interested in random compiler generated garbage.
> 
> Hi Peterz,
> 
> Got it, we'll do that for you asap.

Rong, I seem to still be getting W=1 build warnings spam. Could you
pleaes have a look?
