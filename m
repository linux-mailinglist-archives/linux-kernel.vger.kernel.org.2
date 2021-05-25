Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9E38FDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhEYJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:49444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232540AbhEYJXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:23:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621934525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Km8x1iNswod8J6jOTrElieNcifEjpJYKCuh1lkUjw+o=;
        b=ZLXa504a9dSoewPkKfWKSHxAqmjJteVrgKhTg1ndw0+uVFvcBZnHbBjw1bIbMU1wI0u6g2
        EMm1UDPOqJ3oaMtzIhBe+CjS2Cc4z99ERx0R9uRjLj2YxLyOapEdtU1i92aelYjm5ZGqtS
        OnipQBA0QSc1TyZWg3W+eNgdgGYI6s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621934525;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Km8x1iNswod8J6jOTrElieNcifEjpJYKCuh1lkUjw+o=;
        b=uwA/U6nKtl7G+RUfLAiGm0vFcYM3yFhmHr61p//rliSrss6FEcMUmotkxS2O6/SlY2GGXB
        haHasfSO6UAB3TBQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A255AEAB;
        Tue, 25 May 2021 09:22:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 144021F2C98; Tue, 25 May 2021 11:22:05 +0200 (CEST)
Date:   Tue, 25 May 2021 11:22:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
Message-ID: <20210525092205.GA4112@quack2.suse.cz>
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
 <20210520095119.GA18952@quack2.suse.cz>
 <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
 <20210521092730.GE18952@quack2.suse.cz>
 <YKfi6Pv+qwduKxuT@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKfi6Pv+qwduKxuT@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-05-21 12:42:16, Theodore Y. Ts'o wrote:
> On Fri, May 21, 2021 at 11:27:30AM +0200, Jan Kara wrote:
> > 
> > OK, thanks for testing. So the orphan code is indeed the likely cause of
> > this regression but I probably did not guess correctly what is the
> > contention point there. Then I guess I need to reproduce and do more
> > digging why the contention happens...
> 
> Hmm... what if we only recalculate the superblock checksum when we do
> a commit, via the callback function from the jbd2 layer to file
> system?

I actually have to check whether the regression is there because of the
additional locking of the buffer_head (because that's the only thing that
was added to that code in fact, adding some atomic instructions, bouncing
another cacheline) or because of the checksum computation that moved from
ext4_handle_dirty_super() closer to actual superblock update under those
locks.

If the problem is indeed just the checksum computation under all those
locks, we can move that to transaction commit time (using the t_frozen
trigger - ocfs2 uses that for all metadata checksumming). But then we have
to be very careful with unjournaled sb updates that can be running in
parallel with the journaled ones because once you drop buffer lock, sb can
get clobbered and checksum invalidated. Also there's the question what to
do with nojournal mode - probably we would have to keep separate set of
places recomputing checksums just for nojournal mode which is quite error
prone but if it's just for sb, I guess it's manageable.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
