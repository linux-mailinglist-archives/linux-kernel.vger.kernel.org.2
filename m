Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59A3385E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCLGaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:30:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:45510 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231544AbhCLGai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:30:38 -0500
IronPort-SDR: ZMpMqxuXhYPozrrWPTuLRmpSG2sSNpUrEHSanUIPw3t4Sk0eGjx8O8Q/c7YjAgXHy39pu/2Jdw
 6/sC21qterLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="176381654"
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="176381654"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 22:30:37 -0800
IronPort-SDR: Co3t1pgsRLHMkBiBltp/iyMwsnvZq+XrKmqVVH6NmbGcSkmcNfcKn1KISXa8+2D8dUMfYMWCRp
 yfFFdTIv10Jw==
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="410904374"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 22:30:34 -0800
Date:   Fri, 12 Mar 2021 14:27:55 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [mm/highmem] 61b205f579:
 WARNING:at_mm/highmem.c:#__kmap_local_sched_out
Message-ID: <20210312062755.GA5022@xsang-OptiPlex-9020>
References: <20210304083825.GB17830@xsang-OptiPlex-9020>
 <BYAPR04MB496507720FEEF2B77FB639E186929@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210311160220.GS3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311160220.GS3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On Thu, Mar 11, 2021 at 08:02:20AM -0800, Ira Weiny wrote:
> On Tue, Mar 09, 2021 at 08:53:04PM +0000, Chaitanya Kulkarni wrote:
> > Ira,
> > 
> > On 3/4/21 00:23, kernel test robot wrote:
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: 61b205f579911a11f0b576f73275eca2aed0d108 ("mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > >
> > > in testcase: trinity
> > > version: trinity-static-i386-x86_64-f93256fb_2019-08-28
> > > with following parameters:
> > >
> > > 	runtime: 300s
> > >
> > > test-description: Trinity is a linux system call fuzz tester.
> > > test-url: http://codemonkey.org.uk/projects/trinity/
> > >
> > >
> > > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > Is the fix for this been posted yet ?
> 
> No.  I've been unable to reproduce it yet.

just FYI
the issue does not always happen but the rate on 61b205f579 is not low,
while we didn't observe it happen on parent commit.

bb90d4bc7b6a536b 61b205f579911a11f0b576f7327
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :38          16%           6:38    dmesg.EIP:__kmap_local_sched_in
           :38          16%           6:38    dmesg.EIP:__kmap_local_sched_out
           :38          16%           6:38    dmesg.WARNING:at_mm/highmem.c:#__kmap_local_sched_in
           :38          16%           6:38    dmesg.WARNING:at_mm/highmem.c:#__kmap_local_sched_out

also please permit me to quote our internal analysis by Zhengjun (cced)
(Thanks a lot, Zhengjun)

"the commit has the potential to cause the issue.
It replaces " kmap_atomic" to " kmap_local_page".

Most of the two API is the same, except for " kmap_atomic" disable preemption and cannot sleep.
I check the issue happened when there is a preemption,  in FBC " kmap_local_page",
the  preemption is enabled,  the issue may happen."
"

> 
> Ira
> 
> > 
> > (asking since I didn't see the fix and my mailer is dropping emails from
> >  lkml).
