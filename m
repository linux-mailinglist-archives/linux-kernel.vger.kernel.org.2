Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B8396688
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhEaRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:09:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234418AbhEaQ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:59:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622480266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pt9jdDEFKfyrZWxbTsdPI87OthodO/U3mzphK8JrYmo=;
        b=uXA4TZe/Vz4O0tW/+795/cdcEaqQ1GKnX1hqkipeGPSom+lwqIeOcwaWSd4VaGq6XEznka
        mvg49oxJZASY9GDBtxrkDlclwaUgTsXGEgKjDe5xt3HWMAVJErOTLfN0+00gu2faNdn3aj
        lbYJRfIK+h/x+Lj5nl+h4HUnPKTfTi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622480266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pt9jdDEFKfyrZWxbTsdPI87OthodO/U3mzphK8JrYmo=;
        b=HvcmQnM5TIKGVQSJYFJAnbTpOu1PZoYouMJ02uG9MmZJly7nOA5eZC2Uo3bDuJA/4kb9w6
        1UGsYZpBrAM5IVDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AF6BB74F;
        Mon, 31 May 2021 16:57:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2584D1F2CAC; Mon, 31 May 2021 18:57:46 +0200 (CEST)
Date:   Mon, 31 May 2021 18:57:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
Message-ID: <20210531165746.GA2610@quack2.suse.cz>
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
 <20210520095119.GA18952@quack2.suse.cz>
 <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
 <20210521092730.GE18952@quack2.suse.cz>
 <YKfi6Pv+qwduKxuT@mit.edu>
 <20210525092205.GA4112@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525092205.GA4112@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-05-21 11:22:05, Jan Kara wrote:
> On Fri 21-05-21 12:42:16, Theodore Y. Ts'o wrote:
> > On Fri, May 21, 2021 at 11:27:30AM +0200, Jan Kara wrote:
> > > 
> > > OK, thanks for testing. So the orphan code is indeed the likely cause of
> > > this regression but I probably did not guess correctly what is the
> > > contention point there. Then I guess I need to reproduce and do more
> > > digging why the contention happens...
> > 
> > Hmm... what if we only recalculate the superblock checksum when we do
> > a commit, via the callback function from the jbd2 layer to file
> > system?
> 
> I actually have to check whether the regression is there because of the
> additional locking of the buffer_head (because that's the only thing that
> was added to that code in fact, adding some atomic instructions, bouncing
> another cacheline) or because of the checksum computation that moved from
> ext4_handle_dirty_super() closer to actual superblock update under those
> locks.

So I did a few experiments on my test machine. I saw the biggest regression
for creat_clo workload for 7 threads. The results look like:

                         orig                   patched                hack1                  hack2
Hmean     creat_clo-7    36458.33 (   0.00%)    23836.55 * -34.62%*    32608.70 * -10.56%*    37300.18 (   2.31%)

where hack1 means I've removed the lock_buffer() calls from orphan handling
code and hack2 means I've additionally moved checksum recalculation from
under orphan lock. Take the numbers with a grain of salt as they are rather
variable and this is just an average of 5 runs but the tendency is pretty
clear. Both these changes contribute to the regression significantly,
additional locking of the buffer head contributes somewhat more.

I will see how various variants of reducing the contention look like (e.g.
if just using bh lock for everything helps at all). But honestly I don't
want to jump through too big hoops just for this workload - the orphan list
contention is pretty pathological here and if we seriously care about
workload like this we should rather revive the patchset with hashed orphan
list I wrote couple years back... That was able to give like 3x speedup to
workloads like this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
