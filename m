Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A5365F27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhDTS0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhDTS0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:26:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F8B613CE;
        Tue, 20 Apr 2021 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618943170;
        bh=c6iMBvteXSLo2ps7WOwHOoMbvk0m6jpJVCFWhxgH69o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0sHndMS7ZK5/RPC2Bsktxa539LTcmVdpcD9jH8JUH73KqAIJrn4fbX8jX51JB01i
         Ifk/mz0G88iEEDs1yIiH9eOWaFGzG9uUVvCBbCZc1Mp48BwQNhrY8U1cyKMnkLNySw
         eFBq3G03xqCmL+owlApJThjHGukMu8DEFmOWtpkc6FxvhByt9BGP0+MbF1XHbc9Kdu
         RBHMJJ/SdZn0TfQDwS9ajrfSsE1fBL9fEw3TMp5yzH4aEMJUBhONo299lMdaM4l54q
         0T5InSGMitTrigg4A4bbWRdEcRMKfNmtQCFqtYrJnFyVcME1Q0zjdzRX49lS98QtJC
         Ly6g4KZxQe79Q==
Date:   Tue, 20 Apr 2021 11:26:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to cover allocate_segment() with lock
Message-ID: <YH8cwK+g2PpjBK0Y@google.com>
References: <20210414012134.128066-1-yuchao0@huawei.com>
 <YH22a55sexxwmGCe@google.com>
 <03dc1c69-9215-1b5f-b1cc-c38454f3b90a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03dc1c69-9215-1b5f-b1cc-c38454f3b90a@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Chao Yu wrote:
> On 2021/4/20 0:57, Jaegeuk Kim wrote:
> > On 04/14, Chao Yu wrote:
> > > As we did for other cases, in fix_curseg_write_pointer(), let's
> > > change as below:
> > > - use callback function s_ops->allocate_segment() instead of
> > > raw function allocate_segment_by_default();
> > > - cover allocate_segment() with curseg_lock and sentry_lock.
> > > 
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > >   fs/f2fs/segment.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index b2ee6b7791b0..daf9531ec58f 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -4848,7 +4848,12 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
> > >   	f2fs_notice(sbi, "Assign new section to curseg[%d]: "
> > >   		    "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff);
> > > -	allocate_segment_by_default(sbi, type, true);
> > > +
> > > +	down_read(&SM_I(sbi)->curseg_lock);
> > > +	down_write(&SIT_I(sbi)->sentry_lock);
> > > +	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
> > > +	up_write(&SIT_I(sbi)->sentry_lock);
> > > +	up_read(&SM_I(sbi)->curseg_lock);
> > 
> > Seems f2fs_allocate_new_section()?
> 
> f2fs_allocate_new_section() will allocate new section only when current
> section has been initialized and has valid block/ckpt_block.
> 
> It looks fix_curseg_write_pointer() wants to force migrating current segment
> to new section whenever write pointer and curseg->next_blkoff is inconsistent.
> 
> So how about adding a parameter to force f2fs_allocate_new_section() to
> allocate new section?

I think that can be doable. Hope to avoid native calls as much as possible.

> 
> Thanks,
> 
> > 
> > >   	/* check consistency of the zone curseg pointed to */
> > >   	if (check_zone_write_pointer(sbi, zbd, &zone))
> > > -- 
> > > 2.29.2
> > .
> > 
