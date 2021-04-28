Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6731B36D935
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbhD1OE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:04:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34416 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230057AbhD1OEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:04:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13SE3HW3018990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 10:03:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DB1D515C3C3D; Wed, 28 Apr 2021 10:03:16 -0400 (EDT)
Date:   Wed, 28 Apr 2021 10:03:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, dm-devel@redhat.com
Subject: Re: [ext4]  21175ca434:
 mdadm-selftests.enchmarks/mdadm-selftests/tests/01r1fail.fail
Message-ID: <YIlrJCdhVaFPdPgb@mit.edu>
References: <20210427081539.GF32408@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427081539.GF32408@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hmm, why did you cc linux-km on this report?  I would have thought
dm-devel would have made more sense?)

On Tue, Apr 27, 2021 at 04:15:39PM +0800, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 21175ca434c5d49509b73cf473618b01b0b85437 ("ext4: make prefetch_block_bitmaps default")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 

> in testcase: mdadm-selftests
> version: mdadm-selftests-x86_64-5d518de-1_20201008
> with following parameters:
> 
> 	disk: 1HDD
> 	test_prefix: 01r1
> 	ucode: 0x21

So this failure makes no sense to me.  Looking at the kmesg failure
logs, it's failing in the md layer:

kern  :info  : [   99.775514] md/raid1:md0: not clean -- starting background reconstruction
kern  :info  : [   99.783372] md/raid1:md0: active with 3 out of 4 mirrors
kern  :info  : [   99.789735] md0: detected capacity change from 0 to 37888
kern  :info  : [   99.796216] md: resync of RAID array md0
kern  :crit  : [   99.900450] md/raid1:md0: Disk failure on loop2, disabling device.
                              md/raid1:md0: Operation continuing on 2 devices.
kern  :crit  : [   99.918281] md/raid1:md0: Disk failure on loop1, disabling device.
                              md/raid1:md0: Operation continuing on 1 devices.
kern  :info  : [  100.835833] md: md0: resync interrupted.
kern  :info  : [  101.852898] md: resync of RAID array md0
kern  :info  : [  101.858347] md: md0: resync done.
user  :notice: [  102.109684] /lkp/benchmarks/mdadm-selftests/tests/01r1fail... FAILED - see /var/tmp/01r1fail.log and /var/tmp/fail01r1fail.log for details

The referenced commit just turns block bitmap prefetching in ext4.
This should not cause md to failure; if so, that's an md bug, not an
ext4 bug.  There should not be anything that the file system is doing
that would cause the kernel to think there is a disk failure.

By the way, the reproduction instructions aren't working currently:

> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this email

This fails because lkp is trying to apply a patch which does not apply
with the current version of the md tools.

>         bin/lkp split-job --compatible job.yaml
>         bin/lkp run                    compatible-job.yaml

And the current versions lkp don't generate a compatible-job.yaml file
when you run "lkp split-job --compatable"; instead it generates a new
yaml file with a set of random characters to generate a unique name.
(What Multics parlance would be called a "shriek name"[1] :-)

Since I was having trouble running the reproduction; could you send
the /var/tmp/*fail.logs so we could have a bit more insight what is
going on?

Thanks!

					- Ted

