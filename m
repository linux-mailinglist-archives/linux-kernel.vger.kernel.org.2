Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0227B40F74F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbhIQMO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:14:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38364 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhIQMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:14:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 478771FE6E;
        Fri, 17 Sep 2021 12:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631880814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ce0dhYuZF8iH1ahdO1gFqxDTSsqLzOXS7SfUCTPjcGY=;
        b=qHcpYaRngDtEfV86461CjMLdbL/d3/7kVV+kBB0UNIdc876p2ED36DDn58h87Qsy8j7MlK
        tWbpGE2OgJsF9MipVfiQ66E/X4yEfO6DUJ2tcj+eHs9LXtlW0ZcAfaWZqNhwBMCGmEWWUE
        LfHkxUxUbEuGbBaqaEKuU2nTRyuw/rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631880814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ce0dhYuZF8iH1ahdO1gFqxDTSsqLzOXS7SfUCTPjcGY=;
        b=V9Ml5E1H1a688V4ItoqJiJdy23i/X2Gyg2SqcMsBsPfM9sI13Lx87nXMKhrGA+A41m0ae8
        o63lQsV0sCfEwMAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 2BF9AA3B9C;
        Fri, 17 Sep 2021 12:13:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C68F41E0CA7; Fri, 17 Sep 2021 14:13:31 +0200 (CEST)
Date:   Fri, 17 Sep 2021 14:13:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chi Wu <wuchi.zero@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>,
        lkp@intel.com, lkp@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ltp@lists.linux.it
Subject: Re: [LTP] [mm/page]  ab19939a6a: ltp.msync04.fail
Message-ID: <20210917121331.GA14905@quack2.suse.cz>
References: <20210912123429.GA25450@xsang-OptiPlex-9020>
 <YT8HqsXsHFeMdDxS@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT8HqsXsHFeMdDxS@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-09-21 10:11:22, Cyril Hrubis wrote:
> Hi!
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20210907
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: xfs
> > 	test: syscalls-03
> > 	ucode: 0xe2
> > 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> 
> The msync04 test formats a device with a diffrent filesystems, for each
> filesystem it maps a file, writes to the mapped page and the checks a
> dirty bit in /proc/kpageflags before and after msync() on that page.
> 
> This seems to be broken after this patch for ntfs over FUSE and it looks
> like the page does not have a dirty bit set right after it has been
> written to.
> 
> Also I guess that we should increase the number of the pages we dirty or
> attempt to retry since a single page may be flushed to the storage if we
> are unlucky and the process is preempted between the write and the
> initial check for the dirty bit.

Yes, I agree. The most likely explanation I see for this is that the
identified commit results in waking flush worker earlier so it may now
succeed in cleaning the page before get_dirty_bit() in the LTP testcase
manages to see it. This is a principial race in this testcase, you can
perhaps make it less likely but not completely fix it AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
