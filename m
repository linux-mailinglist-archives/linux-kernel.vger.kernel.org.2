Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E838237A702
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEKMrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:47:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhEKMrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:47:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5014AF3E;
        Tue, 11 May 2021 12:46:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 59D211F2B6D; Tue, 11 May 2021 14:46:32 +0200 (CEST)
Date:   Tue, 11 May 2021 14:46:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [fanotify] 7cea2a3c50: stress-ng.fanotify.ops_per_sec -23.4%
 regression
Message-ID: <20210511124632.GL24154@quack2.suse.cz>
References: <20210511070805.GE8539@xsang-OptiPlex-9020>
 <CAOQ4uxhoR8h0Mw=LJGSxMYWC1krjbwgzxbYNDjMmeo3sBAey1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhoR8h0Mw=LJGSxMYWC1krjbwgzxbYNDjMmeo3sBAey1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-05-21 14:13:38, Amir Goldstein wrote:
> On Tue, May 11, 2021 at 9:51 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Greeting,
> >
> > FYI, we noticed a -23.4% regression of stress-ng.fanotify.ops_per_sec due to commit:
> >
> >
> > commit: 7cea2a3c505e87a9d6afc78be4a7f7be636a73a7 ("fanotify: support limited functionality for unprivileged users")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> 
> I am not sure how this is possible.
> This commit only changes permissions to perform the operation.
> Is the test not being run as root?

Yeah, I've stared at it for some time and didn't come up with a sensible
explanation either. I guess we need to try to reproduce and see...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
