Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BFC390744
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhEYRRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:17:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47182 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232349AbhEYRQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:16:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14PHFASB001063
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 13:15:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7B1CB15C3C67; Tue, 25 May 2021 13:15:10 -0400 (EDT)
Date:   Tue, 25 May 2021 13:15:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
Message-ID: <YK0wnsZGP8iYKRje@mit.edu>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 11:22:05AM +0200, Jan Kara wrote:
> I actually have to check whether the regression is there because of the
> additional locking of the buffer_head (because that's the only thing that
> was added to that code in fact, adding some atomic instructions, bouncing
> another cacheline) or because of the checksum computation that moved from
> ext4_handle_dirty_super() closer to actual superblock update under those
> locks.

Hmm, yes.  So the other thing we could try doing might be to drop
s_orphan_lock mutex altogether and instead use the buffer_head lock to
protect the orphan list.  In actual practice the orphan list
modifications are the vast majority of the times when we need to
modify the superblock, so we could just take the buffer_head lock a
bit earlier (when we take the s_orphan_lock) and release it a bit
later and thus avoid the cacheline bounce.

What do you think?

> If the problem is indeed just the checksum computation under all those
> locks, we can move that to transaction commit time (using the t_frozen
> trigger - ocfs2 uses that for all metadata checksumming). But then we have
> to be very careful with unjournaled sb updates that can be running in
> parallel with the journaled ones because once you drop buffer lock, sb can
> get clobbered and checksum invalidated. Also there's the question what to
> do with nojournal mode - probably we would have to keep separate set of
> places recomputing checksums just for nojournal mode which is quite error
> prone but if it's just for sb, I guess it's manageable.

We lived without the orphan list in ext2 for a long time, and without
the journal, whether the orphan linked list in inode->d_time would be
anything approaching consistent is a major question in any case.  One
approach then might be to drop the orphan list in nojournal mode
altogether....

						- Ted
