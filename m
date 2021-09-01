Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAC3FD17A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbhIACrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:47:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:43484 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231613AbhIACrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:47:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="282323654"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="282323654"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 19:46:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="541298153"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 19:46:19 -0700
Date:   Wed, 1 Sep 2021 11:03:57 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ltp@lists.linux.it
Subject: Re: [fs]  f7e33bdbd6: ltp.ftruncate04_64.fail
Message-ID: <20210901030357.GD14661@xsang-OptiPlex-9020>
References: <20210825051710.GA5358@xsang-OptiPlex-9020>
 <cf358b73cbda90fd6c023f3a59a8df94698cf0bc.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf358b73cbda90fd6c023f3a59a8df94698cf0bc.camel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Wed, Aug 25, 2021 at 06:32:38AM -0400, Jeff Layton wrote:
> On Wed, 2021-08-25 at 13:17 +0800, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3 ("fs: remove mandatory file locking support")
> > https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git locks-next
> > 
> > 
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20210821
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: ext4
> > 	test: syscalls-07
> > 	ucode: 0xe2
> > 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> > 
> > 
> > on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> 
> [...]
> 
> > <<<test_start>>>
> > tag=ftruncate04_64 stime=1629792639
> > cmdline="ftruncate04_64"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> > tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > mke2fs 1.44.5 (15-Dec-2018)
> > tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
> > ftruncate04.c:116: TINFO: Child locks file
> > ftruncate04.c:49: TFAIL: ftruncate() offset before lock succeeded unexpectedly
> > ftruncate04.c:49: TFAIL: ftruncate() offset in lock succeeded unexpectedly
> > ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
> > ftruncate04.c:127: TINFO: Child unlocks file
> > ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
> > ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
> > ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
> > 
> > Summary:
> > passed   4
> > failed   2
> > broken   0
> > skipped  0
> > warnings 0
> 
> I think this failed because of the above, which is expected now that we
> ignore the "mand" mount option (and mandatory locking support is gone).
> 
> Oliver, you may need to update the expected test output for this test.

Thanks for the information! we will do the corresponding change ASAP

> 
> Thanks,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
