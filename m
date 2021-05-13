Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDC37F9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhEMOce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:32:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:32229 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhEMOc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:32:26 -0400
IronPort-SDR: TJ0CSKJVqadBjj0D4Yun2LLohDkVBypFp3aQXmMtPEfPVfR2Fw8YU9FCs8EshYeSZTc1Aopjw7
 W166SMK7l+Nw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="180224303"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="180224303"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 07:31:12 -0700
IronPort-SDR: 1w+Fr7BDs7KibBuHH2nvv7S7MWcDG+82O653mKtrOk34KnFyowG0bNYtCGTAELPU3W+m0/0ni1
 sGt8t7L1XcUQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="626232328"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 07:31:10 -0700
Date:   Thu, 13 May 2021 22:48:09 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, dm-devel@redhat.com
Subject: Re: [ext4]  21175ca434:
 mdadm-selftests.enchmarks/mdadm-selftests/tests/01r1fail.fail
Message-ID: <20210513144809.GF20142@xsang-OptiPlex-9020>
References: <20210427081539.GF32408@xsang-OptiPlex-9020>
 <YIlrJCdhVaFPdPgb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIlrJCdhVaFPdPgb@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Theodore,

On Wed, Apr 28, 2021 at 10:03:16AM -0400, Theodore Ts'o wrote:
> (Hmm, why did you cc linux-km on this report?  I would have thought
> dm-devel would have made more sense?)
> 
> On Tue, Apr 27, 2021 at 04:15:39PM +0800, kernel test robot wrote:
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 21175ca434c5d49509b73cf473618b01b0b85437 ("ext4: make prefetch_block_bitmaps default")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> 
> > in testcase: mdadm-selftests
> > version: mdadm-selftests-x86_64-5d518de-1_20201008
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	test_prefix: 01r1
> > 	ucode: 0x21
> 
> So this failure makes no sense to me.  Looking at the kmesg failure
> logs, it's failing in the md layer:

just FYI. we rerun the tests for both parent and this commit, up to 56
times. the failure seems persistent on the commit, though not always.
but the test never failed on parent.

f68f4063855903fd 21175ca434c5d49509b73cf4736
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :56          61%          34:56    mdadm-selftests.enchmarks/mdadm-selftests/tests/01r1fail.fail


> 
> kern  :info  : [   99.775514] md/raid1:md0: not clean -- starting background reconstruction
> kern  :info  : [   99.783372] md/raid1:md0: active with 3 out of 4 mirrors
> kern  :info  : [   99.789735] md0: detected capacity change from 0 to 37888
> kern  :info  : [   99.796216] md: resync of RAID array md0
> kern  :crit  : [   99.900450] md/raid1:md0: Disk failure on loop2, disabling device.
>                               md/raid1:md0: Operation continuing on 2 devices.
> kern  :crit  : [   99.918281] md/raid1:md0: Disk failure on loop1, disabling device.
>                               md/raid1:md0: Operation continuing on 1 devices.
> kern  :info  : [  100.835833] md: md0: resync interrupted.
> kern  :info  : [  101.852898] md: resync of RAID array md0
> kern  :info  : [  101.858347] md: md0: resync done.
> user  :notice: [  102.109684] /lkp/benchmarks/mdadm-selftests/tests/01r1fail... FAILED - see /var/tmp/01r1fail.log and /var/tmp/fail01r1fail.log for details
> 
> The referenced commit just turns block bitmap prefetching in ext4.
> This should not cause md to failure; if so, that's an md bug, not an
> ext4 bug.  There should not be anything that the file system is doing
> that would cause the kernel to think there is a disk failure.
> 
> By the way, the reproduction instructions aren't working currently:
> 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install                job.yaml  # job file is attached in this email
> 
> This fails because lkp is trying to apply a patch which does not apply
> with the current version of the md tools.
> 
> >         bin/lkp split-job --compatible job.yaml
> >         bin/lkp run                    compatible-job.yaml
> 
> And the current versions lkp don't generate a compatible-job.yaml file
> when you run "lkp split-job --compatable"; instead it generates a new
> yaml file with a set of random characters to generate a unique name.
> (What Multics parlance would be called a "shriek name"[1] :-)
> 
> Since I was having trouble running the reproduction; could you send
> the /var/tmp/*fail.logs so we could have a bit more insight what is
> going on?
> 
> Thanks!
> 
> 					- Ted
> 
