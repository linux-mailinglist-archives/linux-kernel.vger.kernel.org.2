Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB238C30F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhEUJ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:29:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236502AbhEUJ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03E41AACA;
        Fri, 21 May 2021 09:27:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 90BF61F2C73; Fri, 21 May 2021 11:27:30 +0200 (CEST)
Date:   Fri, 21 May 2021 11:27:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
Message-ID: <20210521092730.GE18952@quack2.suse.cz>
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
 <20210520095119.GA18952@quack2.suse.cz>
 <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-05-21 09:16:42, Xing Zhengjun wrote:
> Hi Jan,
> 
> On 5/20/2021 5:51 PM, Jan Kara wrote:
> > Hello!
> > 
> > On Thu 20-05-21 15:13:20, Xing Zhengjun wrote:
> > > 
> > >       Do you have time to look at this? The regression still existed in the
> > > latest Linux mainline v5.13-rc2.
> > 
> > Thanks for verification and for the ping! I had a look into this and I
> > think the regression is caused by the changes in orphan handling. The load
> > runs multiple tasks all creating and deleting files. This generally
> > contends on the orphan locking with fast storage (which is your case
> > because you use ramdisk as a backing store AFAICT). And the changes I did
> > move superblock checksum computation under the orphan lock so the lock hold
> > times are now higher.
> > 
> > Sadly it is not easy to move checksum update from under the orphan lock and
> > maintain checksum consistency since the checksum has to be recomputed
> > consistently with the changes of superblock state. But I have one idea how
> > we could maybe improve the situation. Can you check whether attached patch
> > recovers the regression? Because that's about how good it could get when we
> > are more careful when writing out superblock.
> > 
> > 								Honza
> > 
> 
> I apply the patch based on v5.13-rc2 and test, it can not recover the
> regression and the regression became more serious(-45.7%).

OK, thanks for testing. So the orphan code is indeed the likely cause of
this regression but I probably did not guess correctly what is the
contention point there. Then I guess I need to reproduce and do more
digging why the contention happens...

								Honza

> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/disk/md/fs/test/load/cpufreq_governor/ucode:
> 
> lkp-csl-2sp9/aim7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4BRD_12G/RAID1/ext4/creat-clo/1000/performance/0x5003006
> 
> commit:
>   4392fbc4bab57db3760f0fb61258cb7089b37665
>   05c2c00f3769abb9e323fcaca70d2de0b48af7ba
>   v5.13-rc2
>   2a1eb1a2fc08daaaf76a5aa8ffa355b5a5013d86    (the test patch)
> 
> 4392fbc4bab57db3 05c2c00f3769abb9e323fcaca70                   v5.13-rc2
> 2a1eb1a2fc08daaaf76a5aa8ffa
> ---------------- --------------------------- ---------------------------
> ---------------------------
>          %stddev     %change         %stddev     %change %stddev     %change
> %stddev
>              \          |                \          |                \
> |                \
>      13342           -11.8%      11771 ±  2%     -14.2%      11450
> -45.7%       7240 ±  3%  aim7.jobs-per-min
> 
> 
> 
> -- 
> Zhengjun Xing
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
