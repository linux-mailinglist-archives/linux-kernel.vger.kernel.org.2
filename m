Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9A3677CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhDVDNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:13:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:5721 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhDVDNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:13:18 -0400
IronPort-SDR: CPlsuckRX9C0aiIXfgvq/ukZAal/X/RC65kHAgoT2/UaHN9UdbsTevMn2WD9da2pYitA2QsRmU
 hGPsGBgk0fow==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="182948302"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="182948302"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:12:43 -0700
IronPort-SDR: vm1ESiYH/j5vdRMTT8qF8B3diCpzVng9ejfrMdBqUzUEIFgFPZzAH0sdk4trzq23mIkGpC6dpj
 8azJBYAl3P/A==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="524496466"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:12:40 -0700
Date:   Thu, 22 Apr 2021 11:29:59 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>, Beibei Si <beibei.si@intel.com>
Subject: Re: [null_blk] de3510e52b: blktests.block.014.fail
Message-ID: <20210422032959.GA31382@xsang-OptiPlex-9020>
References: <20210407085942.GF22260@xsang-OptiPlex-9020>
 <BL0PR04MB651491ED14D710890187B3D1E7759@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651491ED14D710890187B3D1E7759@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Damien Le Moal,

On Wed, Apr 07, 2021 at 12:29:11PM +0000, Damien Le Moal wrote:
> On 2021/04/07 18:02, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: de3510e52b0a398261271455562458003b8eea62 ("null_blk: fix command timeout completion handling")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: blktests
> > version: blktests-x86_64-a210761-1_20210124
> > with following parameters:
> > 
> > 	disk: 1SSD
> > 	test: nvme-group-00
> > 	ucode: 0x11
> > 
> > 
> > 
> > on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > block/014 (run null-blk with blk-mq and timeout injection configured)
> > block/014 (run null-blk with blk-mq and timeout injection configured) [failed]
> >     runtime  ...  71.624s
> >     --- tests/block/014.out     2021-01-24 06:04:08.000000000 +0000
> >     +++ /mnt/nvme-group-00/nodev/block/014.out.bad      2021-04-06 09:21:25.133971868 +0000
> >     @@ -1,2 +1,377 @@
> >      Running block/014
> >     +dd: error reading '/dev/nullb0': Connection timed out
> >     +dd: error reading '/dev/nullb0': Connection timed out
> >     +dd: error reading '/dev/nullb0': Connection timed out
> >     +dd: error reading '/dev/nullb0': Connection timed out
> >     +dd: error reading '/dev/nullb0': Connection timed out
> >     +dd: error reading '/dev/nullb0': Connection timed out
> >     ...
> >     (Run 'diff -u tests/block/014.out /mnt/nvme-group-00/nodev/block/014.out.bad' to see the entire diff)
> 
> This is not a kernel bug. It is a problem with blktest. Before my patch, the
> timeout error was not propagated back to the user. It is now and causes dd to
> fail. blktest seeing dd failing reports the test as failed. On the kernel side,
> all is good, the reqs are completed as expected.
> 
> Note that the timeout error is reported back as is, using BLK_STS_TIMEOUT which
> becomes ETIMEDOUT, hence the "Connection timed out" error message. May be we
> should use the more traditional EIO ? Jens ?
> 
> In any case, I will send a patch to fix blktest block/014.

Thanks for information!
we checked the latest blktest repo (https://github.com/osandov/blktests)
but didn't find the fix. did we miss something?

when patch upstreamed, we could retest and confirm the fix. Thanks

> 
> 
> > 
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install                job.yaml  # job file is attached in this email
> >         bin/lkp split-job --compatible job.yaml
> >         bin/lkp run                    compatible-job.yaml
> > 
> > 
> > 
> > ---
> > 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> > 
> > Thanks,
> > Oliver Sang
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
