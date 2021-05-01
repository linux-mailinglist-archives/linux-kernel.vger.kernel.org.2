Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94903706B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 11:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhEAJri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 05:47:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:16737 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhEAJrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 05:47:37 -0400
IronPort-SDR: h2qp78pQcb9G8v+YuMa0EjK6kT+Fz+FIZbFNIr6qfXR//2wyG8X4i4HLYD4yHv+Od0/LX+2WD9
 jraeCA1fSyDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="195353275"
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="195353275"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2021 02:46:47 -0700
IronPort-SDR: TQ7BA8x/6XBEb8JIXO5y20t9Q5f6ZjLYfqOqAg7PFH9TM2folv1srR/LRsL8zZbkk3oJnd8sg9
 aQHsMRymtpQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="459951498"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 01 May 2021 02:46:44 -0700
Date:   Sat, 1 May 2021 17:46:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [signal]  4bad58ebc8:  will-it-scale.per_thread_ops -3.3%
 regression
Message-ID: <20210501094643.GC79529@shbuild999.sh.intel.com>
References: <20210420030837.GB31773@xsang-OptiPlex-9020>
 <20210430081359.GB79529@shbuild999.sh.intel.com>
 <874kfof8un.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kfof8un.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Apr 30, 2021 at 10:57:20AM +0200, Thomas Gleixner wrote:
> Feng,
> 
> On Fri, Apr 30 2021 at 16:13, Feng Tang wrote:
> > On Tue, Apr 20, 2021 at 11:08:37AM +0800, kernel test robot wrote:
> >> commit: 
> >>   69995ebbb9 ("signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()")
> >>   4bad58ebc8 ("signal: Allow tasks to cache one sigqueue struct")
> >> 
> >> 69995ebbb9d37173 4bad58ebc8bc4f20d89cff95417 
> >> ---------------- --------------------------- 
> >>          %stddev     %change         %stddev
> >>              \          |                \  
> >>  1.273e+09            -3.3%  1.231e+09        will-it-scale.192.threads
> >>    6630224            -3.3%    6409738        will-it-scale.per_thread_ops
> >>  1.273e+09            -3.3%  1.231e+09        will-it-scale.workload
> >
> > We've double checked this, and it seems to be another case of
> > the code alignment change caused regression change, just like
> > the other case we debugged " [genirq]  cbe16f35be:
> > will-it-scale.per_thread_ops -5.2% regression" 
> >
> > https://lore.kernel.org/lkml/20210428050758.GB52098@shbuild999.sh.intel.com/
> >
> > With the same debug patch of forcing function address 64 bytes
> > aligned, then commit 4bad58ebc8 will bring no change on this case. 
> >
> > commit 09c60546f04f "./Makefile: add debug option to enable function
> > aligned on 32 bytes" only forced 32 bytes align, with thinking 64B
> > align will occupy more code space, and affect iTLB more. Maybe we
> > should just extend it to 64B align, as it is for debug only anyway. 
> 
> thanks for the heads up!
> 
> But why is this restricted to debug mode?
> 
> The fact that adding a few bytes of text causes regressions in unrelated
> code is not restricted to debug or am I missing something here?
 
With the default kernel config of 0day, 64B_force_aligned kernel is 11%
bigger than the 32B_force_aligned kernel (both the vmlinux and its text
size), and benchmark also shows there are performance drops with the
64B_forced_aligned kernel (should be related with more i-cache and i-TLB
footprint).

Also we are still looking for other ways with same effect, while not
increasing kernel text so much. So we are still put it under debug
options.

Thanks,
Feng

> Thanks,
> 
>         tglx
