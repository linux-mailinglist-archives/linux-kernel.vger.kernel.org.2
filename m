Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540703DE41D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhHCBpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhHCBo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:44:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F68B60EEA;
        Tue,  3 Aug 2021 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627955089;
        bh=D2nHBzZZYP6XEc94dr6N/hp28tcnuDh4gjg52b8eIiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYg6g+g7ZqhVSya0wNXq6u/7ckmeQ6aqpf4BSqzanF4wfyoiS4Gv8bOKcDwfScCTN
         xY7YjWGZcKmb6HvzVMx466MOi6d0Mx8d4XdDs/FK7K6J69q+0YmWHV39jTqCcSBU6e
         uiAFtq34bOwnROSqpyrRY80IhdPzGycipW2a5QOpmG7o1YYyUMrsfZk39j/Y+hT/g4
         m678pweh4NrHnGTFOcXl/nFDoXo2kR0NNl3hcAuKNkL9I/C+a0Nek4i9LQG8qa5u1F
         1tm43bRtVA7juM386xbmVe5gew3i1X2qeOPLSM3k1+c33+TklhzQ86H+s8ZFmJExOU
         Z6g6z5zMAm4Hw==
Date:   Mon, 2 Aug 2021 18:44:48 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: reset free segment to prefree status
 when do_checkpoint() fail
Message-ID: <YQifkGIYCHfaQ/AJ@google.com>
References: <20210427082106.2755-1-frank.li@vivo.com>
 <12ae52df-bc5e-82c3-4f78-1eafe7723f93@huawei.com>
 <5f37995c-2390-e8ca-d002-3639ad39e0d3@kernel.org>
 <YPXDtEyBg5W2ToD/@google.com>
 <8d2e3a63-72f9-bcb2-24e5-dddd84136001@kernel.org>
 <YQR60QUh0Pim8vSf@google.com>
 <355ac2ff-f1f1-b9ea-bd8c-139cb24a03fb@kernel.org>
 <YQgydetYHOkgY9+B@google.com>
 <3d3ef5c9-fbb6-df85-26f7-e493da594b22@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3ef5c9-fbb6-df85-26f7-e493da594b22@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03, Chao Yu wrote:
> On 2021/8/3 1:59, Jaegeuk Kim wrote:
> > On 08/01, Chao Yu wrote:
> > > On 2021/7/31 6:18, Jaegeuk Kim wrote:
> > > > On 07/20, Chao Yu wrote:
> > > > > On 2021/7/20 2:25, Jaegeuk Kim wrote:
> > > > > > On 07/19, Chao Yu wrote:
> > > > > > > On 2021/4/27 20:37, Chao Yu wrote:
> > > > > > > > I think just reverting dirty/free bitmap is not enough if checkpoint fails,
> > > > > > > > due to we have updated sbi->cur_cp_pack and nat/sit bitmap, next CP tries
> > > > > > > > to overwrite last valid meta/node/data, then filesystem will be corrupted.
> > > > > > > > 
> > > > > > > > So I suggest to set cp_error if do_checkpoint() fails until we can handle
> > > > > > > > all cases, which is not so easy.
> > > > > > > > 
> > > > > > > > How do you think?
> > > > > > > 
> > > > > > > Let's add below patch first before you figure out the patch which covers all
> > > > > > > things.
> > > > > > > 
> > > > > > >    From 3af957c98e9e04259f8bb93ca0b74ba164f3f27e Mon Sep 17 00:00:00 2001
> > > > > > > From: Chao Yu <chao@kernel.org>
> > > > > > > Date: Mon, 19 Jul 2021 16:37:44 +0800
> > > > > > > Subject: [PATCH] f2fs: fix to stop filesystem update once CP failed
> > > > > > > 
> > > > > > > During f2fs_write_checkpoint(), once we failed in
> > > > > > > f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
> > > > > > > such as prefree bitmap, nat/sit version bitmap won't be recovered,
> > > > > > > it may cause f2fs image to be inconsistent, let's just set CP error
> > > > > > > flag to avoid further updates until we figure out a scheme to rollback
> > > > > > > all metadatas in such condition.
> > > > > > > 
> > > > > > > Reported-by: Yangtao Li <frank.li@vivo.com>
> > > > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > ---
> > > > > > >     fs/f2fs/checkpoint.c | 10 +++++++---
> > > > > > >     1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > > > > > index 6c208108d69c..096c85022f62 100644
> > > > > > > --- a/fs/f2fs/checkpoint.c
> > > > > > > +++ b/fs/f2fs/checkpoint.c
> > > > > > > @@ -1639,8 +1639,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> > > > > > > 
> > > > > > >     	/* write cached NAT/SIT entries to NAT/SIT area */
> > > > > > >     	err = f2fs_flush_nat_entries(sbi, cpc);
> > > > > > > -	if (err)
> > > > > > > +	if (err) {
> > > > > > > +		f2fs_stop_checkpoint(sbi, false);
> > > > > > 
> > > > > > I think we should abuse this, since we can get any known ENOMEM as well.
> > > > > 
> > > > > Yup, but one critical issue here is it can break A/B update of NAT area,
> > > > > so, in order to fix this hole, how about using NOFAIL memory allocation
> > > > > in f2fs_flush_nat_entries() first until we figure out the finial scheme?
> > > > 
> > > > NOFAIL is risky, so how about adding a retry logic on ENOMEM with a message
> > > > and then giving up if we can't get the memory? BTW, what about EIO or other
> > > > family?
> > > 
> > > How about this?
> > 
> > Hmm, it seems we won't get ENOMEM.
> > 
> > __flush_nat_entry_set
> >   -> get_next_nat_page
> >     -> ...
> >      -> __get_meta_page
> >        -> repeat on ENOMEM, but stop_checkpoint on EIO
> 
> Correct, I missed to check __get_meta_page() and f2fs_get_meta_page_retry().
> 
> > 
> > If we have an error here, we should have stopped checkpoint. Have you seen other
> > issue?
> 
> Still we should fix the case from below path?
> 
> - f2fs_write_checkpoint
>  - do_checkpoint
>   - f2fs_flush_device_cache failed

What about adding a retry logic to deal with EIO in __submit_flush_wait()?
We probably need to retry submitting FLUSH commands, and then give up
with f2fs_stop_checkpoint(). And, then how about adding f2fs_bug_on() if
f2fs_flush_nat_entries() returns error without f2fs_cp_error()?

> 
> Thanks,
