Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD53A5D76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhFNHMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:12:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36342 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhFNHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:12:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDC1621975;
        Mon, 14 Jun 2021 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623654612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=imIsqFRpuOqsurBwOcFSF/CSyRUJvFV1150r+mLEIm8=;
        b=M8dqK02tZL4zmjx3seBXwzbI/Oz7WbwJnxleltAvLimSE9OWRyVZCS/B8cUYDyn0iHHzi5
        T/J4A7dFP4oTb5d40kHIfjtUnUluQLOsNDZQHzT96LZiC9yCI4Iv8Pmter5zFBh17NaaCg
        jyoFuAmsj+obATrMBPFKCjeJCi93h8U=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD2A7A3B87;
        Mon, 14 Jun 2021 07:10:12 +0000 (UTC)
Date:   Mon, 14 Jun 2021 09:10:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Martin Liu <liumartin@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com,
        davidchao@google.com, jenhaochen@google.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kthread: Prevent deadlock when
 kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()
Message-ID: <YMcA1BL5RVRm25bu@alley>
References: <20210610133051.15337-1-pmladek@suse.com>
 <20210610133051.15337-3-pmladek@suse.com>
 <20210610143030.f599946ec11e1eccde6af4f0@linux-foundation.org>
 <YMMN5IoXyXqoRsBX@alley>
 <20210611134125.bdb08ba0d2b6b87dc60d446d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611134125.bdb08ba0d2b6b87dc60d446d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-06-11 13:41:25, Andrew Morton wrote:
> On Fri, 11 Jun 2021 09:16:52 +0200 Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Thu 2021-06-10 14:30:30, Andrew Morton wrote:
> > > On Thu, 10 Jun 2021 15:30:50 +0200 Petr Mladek <pmladek@suse.com> wrote:
> > > 
> > > > The system might hang with the following backtrace:
> > > 
> > > Well that's not good.
> > 
> > Fortunately, the API users normally synchronize these operations
> > another way. The race should never happen when the API is used
> > a reasonable way,
> > see https://lore.kernel.org/lkml/YKZLnTNOlUQ85F2s@alley/
> > 
> > > > Fixes: 9a6b06c8d9a220860468a ("kthread: allow to modify delayed kthread work")
> > > > Reported-by: Martin Liu <liumartin@google.com>
> > > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > Was a -stable backport considered?
> > 
> > Good point! It would make sense to backport it. System hang is never
> > good.
> > 
> > Could you please add Cc: stable@vger.kernel.org or should I resend the
> > patchset?
> 
> I made that change to patches 1&2.  I don't think patch 3 need be
> backported?

Sounds good to me. Thanks a lot for the update.

Best Regards,
Petr
