Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB93FD17E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbhIACvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:51:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:29330 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231588AbhIACvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:51:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218327662"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="218327662"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 19:50:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="531615897"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 19:50:01 -0700
Date:   Wed, 1 Sep 2021 11:07:39 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [PCI/MSI]  77e89afc25:  will-it-scale.per_process_ops -2.6%
 regression
Message-ID: <20210901030739.GE14661@xsang-OptiPlex-9020>
References: <20210818145122.GC1721@xsang-OptiPlex-9020>
 <87eeaf3khx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeaf3khx.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Aug 27, 2021 at 12:32:26AM +0200, Thomas Gleixner wrote:
> On Wed, Aug 18 2021 at 22:51, kernel report robot wrote:
> 
> > Greeting,
> >
> > FYI, we noticed a -2.6% regression of will-it-scale.per_process_ops due to commit:
> >
> >
> > commit: 77e89afc25f30abd56e76a809ee2884d7c1b63ce ("PCI/MSI: Protect msi_desc::masked for multi-MSI")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> >
> > in testcase: will-it-scale
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
> > with following parameters:
> >
> > 	nr_task: 100%
> > 	mode: process
> > 	test: lseek2
> > 	cpufreq_governor: performance
> > 	ucode: 0xd000280
> >
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> There is nothing to fix. The commit cures an incorrectness. Comparing
> buggy code to correct code is futile.

Got it! the change is a functionality fix. Thanks for information.

> 
> Thanks,
> 
>         tglx
