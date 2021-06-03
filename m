Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9339A574
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFCQLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:11:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42652 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhFCQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:11:50 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AABEC1FD5F;
        Thu,  3 Jun 2021 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622736604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+MnzhJx6fIYTr/UbIrpDb8TXouK1cYBl9I4mhUEFxE=;
        b=V5pnjcF7GIxExaoG7yEWuUsP7xIFQhHM9xNUoDHvceYrWEw562g3knUt8YckhQZrJfctoa
        Nw/QWrzgXuBLFd8wnlCodgOjtk62SeI4Fy3jvZjITpIBsiEJXUITFN06vB56UFhO/9JGxu
        VvSbN3u9imI1iX+ciJOMs4aB0t3Rdus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622736604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+MnzhJx6fIYTr/UbIrpDb8TXouK1cYBl9I4mhUEFxE=;
        b=K36Pyj/2RiPj3Zh7YWZ96mrmJZdpPvDD4jXCO9ypy5we2RQElMJSF8DBjSJKZ5/1cirili
        PjhWsXZjHi0MNzCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 58B42A3B87;
        Thu,  3 Jun 2021 16:10:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2898F1F2C96; Thu,  3 Jun 2021 18:10:04 +0200 (CEST)
Date:   Thu, 3 Jun 2021 18:10:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
Message-ID: <20210603161004.GL23647@quack2.suse.cz>
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
 <20210520095119.GA18952@quack2.suse.cz>
 <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
 <20210521092730.GE18952@quack2.suse.cz>
 <YKfi6Pv+qwduKxuT@mit.edu>
 <20210525092205.GA4112@quack2.suse.cz>
 <20210531165746.GA2610@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531165746.GA2610@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-05-21 18:57:46, Jan Kara wrote:
> On Tue 25-05-21 11:22:05, Jan Kara wrote:
> > On Fri 21-05-21 12:42:16, Theodore Y. Ts'o wrote:
> > > On Fri, May 21, 2021 at 11:27:30AM +0200, Jan Kara wrote:
> > > > 
> > > > OK, thanks for testing. So the orphan code is indeed the likely cause of
> > > > this regression but I probably did not guess correctly what is the
> > > > contention point there. Then I guess I need to reproduce and do more
> > > > digging why the contention happens...
> > > 
> > > Hmm... what if we only recalculate the superblock checksum when we do
> > > a commit, via the callback function from the jbd2 layer to file
> > > system?
> > 
> > I actually have to check whether the regression is there because of the
> > additional locking of the buffer_head (because that's the only thing that
> > was added to that code in fact, adding some atomic instructions, bouncing
> > another cacheline) or because of the checksum computation that moved from
> > ext4_handle_dirty_super() closer to actual superblock update under those
> > locks.
> 
> So I did a few experiments on my test machine. I saw the biggest regression
> for creat_clo workload for 7 threads. The results look like:
> 
>                          orig                   patched                hack1                  hack2
> Hmean     creat_clo-7    36458.33 (   0.00%)    23836.55 * -34.62%*    32608.70 * -10.56%*    37300.18 (   2.31%)
> 
> where hack1 means I've removed the lock_buffer() calls from orphan handling
> code and hack2 means I've additionally moved checksum recalculation from
> under orphan lock. Take the numbers with a grain of salt as they are rather
> variable and this is just an average of 5 runs but the tendency is pretty
> clear. Both these changes contribute to the regression significantly,
> additional locking of the buffer head contributes somewhat more.
> 
> I will see how various variants of reducing the contention look like (e.g.
> if just using bh lock for everything helps at all). But honestly I don't
> want to jump through too big hoops just for this workload - the orphan list
> contention is pretty pathological here and if we seriously care about
> workload like this we should rather revive the patchset with hashed orphan
> list I wrote couple years back... That was able to give like 3x speedup to
> workloads like this.

So I did some more testing. I've found out that due to a configuration
mistake ramdisk created for previous round of test was tiny (8M instead of
8G) so I've now rerun all the tests and a few more:

                         Orig                   Patched                Hack1                  Hack2                  BH orphan lock
Hmean     creat_clo-1    12875.54 (   0.00%)    12765.96 (  -0.85%)    12765.96 (  -0.85%)    12820.51 (  -0.43%)    12875.54 (   0.00%)
Hmean     creat_clo-2    20761.25 (   0.00%)    19736.84 *  -4.93%*    20408.16 (  -1.70%)    19736.84 *  -4.93%*    20477.82 (  -1.37%)
Hmean     creat_clo-3    22727.27 (   0.00%)    22500.00 (  -1.00%)    24390.24 (   7.32%)    23255.81 (   2.33%)    21176.47 (  -6.82%)
Hmean     creat_clo-4    27149.32 (   0.00%)    24539.88 *  -9.61%*    27272.73 (   0.45%)    25806.45 (  -4.95%)    21660.65 * -20.22%*
Hmean     creat_clo-5    32397.41 (   0.00%)    27985.08 * -13.62%*    28957.53 ( -10.62%)    29821.07 *  -7.95%*    23771.79 * -26.62%*
Hmean     creat_clo-6    33898.30 (   0.00%)    30769.23 (  -9.23%)    30981.07 (  -8.61%)    31858.41 (  -6.02%)    26086.96 * -23.04%*
Hmean     creat_clo-7    29005.52 (   0.00%)    29661.02 (   2.26%)    30746.71 (   6.00%)    33175.35 (  14.38%)    24970.27 ( -13.91%)
Hmean     creat_clo-8    30573.25 (   0.00%)    32000.00 (   4.67%)    29702.97 (  -2.85%)    34139.40 (  11.66%)    23668.64 * -22.58%*

Similarly to previous test, 'Orig' is the original state before 05c2c00f37,
'Patched' is a state after commit 05c2c00f37, 'Hack1' is 05c2c00f37 but with
lock_buffer() calls removed from orphan handling, 'Hack2' is 05c2c00f37 with
lock_buffer() calls removed and checksumming moved from under orphan_lock,
'BH orphan lock' is 05c2c00f37 with orphan_lock replaced with sb buffer
lock.

As we can see with fixed filesystem size, the regression isn't actually
that big anymore but it about matches what 0-day reported. Replacing orphan
lock with superblock buffer_head lock makes things even much worse - not
really surprising given we are replacing optimized mutex implementation
with a bitlock. Just removing buffer lock (Hack1 test) doesn't seem to
improve the results noticeably so that is not a problem. Moving
checksumming out from under the orphan_lock would probably help noticeably
(Hack2 test) but there's the problem when to compute checksums for
nojournal mode and also we'd need to be very careful with all the other
places updating superblock so that they serialize against orphan operations
so that they cannot invalidate the checksum - IMO not very compelling.

So as we chatted on today's call probably the best option is to leave the
code as is for now and instead work on moving away from orphan list
altogether. I'll revive my patches to do that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
