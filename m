Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D443DF480
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbhHCSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238836AbhHCSP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:15:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9733460F94;
        Tue,  3 Aug 2021 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628014517;
        bh=hLVKfXDfBbYG+vuudBBsmhloXJZnrpsdo74uilvto0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFs0iMYHM1AzNWC6XP5r12NGDGEE++nlqD1+TgrMtq9b9CVvEUjeJEqCpMc8i+Zln
         X7AM16ZK6kKojRqYgkvUpyqZ2ph+eg7dFkz964UG1/sMiDdXqOFHrxfg+yfcZm7sb/
         xKvF135uUQojTPEUYfmKOAdznldhlnIpbVYhwmkpQP5KlMWbh4va0Sqk+Qbs2bqs8E
         3YQQ+jU5g+JQ4PICvUybO0OX4FoO+45izlXJGFGU27WqXsOqVePPvxXqOzBFPybhfc
         nqOZ2HAKoZhS/1hwJtSr20C099aFFHs3E8LkZ32bw0vaJIjsZtI4iXKhCS0XNHrtfL
         DS6Du2XYi2AiA==
Date:   Tue, 3 Aug 2021 11:15:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: reset free segment to prefree status
 when do_checkpoint() fail
Message-ID: <YQmHtFQHMWNW8sFK@google.com>
References: <12ae52df-bc5e-82c3-4f78-1eafe7723f93@huawei.com>
 <5f37995c-2390-e8ca-d002-3639ad39e0d3@kernel.org>
 <YPXDtEyBg5W2ToD/@google.com>
 <8d2e3a63-72f9-bcb2-24e5-dddd84136001@kernel.org>
 <YQR60QUh0Pim8vSf@google.com>
 <355ac2ff-f1f1-b9ea-bd8c-139cb24a03fb@kernel.org>
 <YQgydetYHOkgY9+B@google.com>
 <3d3ef5c9-fbb6-df85-26f7-e493da594b22@kernel.org>
 <YQifkGIYCHfaQ/AJ@google.com>
 <a37e3ec3-365d-6eb6-85e6-1d7610b93784@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37e3ec3-365d-6eb6-85e6-1d7610b93784@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03, Chao Yu wrote:
> On 2021/8/3 9:44, Jaegeuk Kim wrote:
> > On 08/03, Chao Yu wrote:
> > > On 2021/8/3 1:59, Jaegeuk Kim wrote:
> > > > On 08/01, Chao Yu wrote:
> > > > > On 2021/7/31 6:18, Jaegeuk Kim wrote:
> > > > > > On 07/20, Chao Yu wrote:
> > > > > > > On 2021/7/20 2:25, Jaegeuk Kim wrote:
> > > > > > > > On 07/19, Chao Yu wrote:
> > > > > > > > > On 2021/4/27 20:37, Chao Yu wrote:
> > > > > > > > > > I think just reverting dirty/free bitmap is not enough if checkpoint fails,
> > > > > > > > > > due to we have updated sbi->cur_cp_pack and nat/sit bitmap, next CP tries
> > > > > > > > > > to overwrite last valid meta/node/data, then filesystem will be corrupted.
> > > > > > > > > > 
> > > > > > > > > > So I suggest to set cp_error if do_checkpoint() fails until we can handle
> > > > > > > > > > all cases, which is not so easy.
> > > > > > > > > > 
> > > > > > > > > > How do you think?
> > > > > > > > > 
> > > > > > > > > Let's add below patch first before you figure out the patch which covers all
> > > > > > > > > things.
> > > > > > > > > 
> > > > > > > > >     From 3af957c98e9e04259f8bb93ca0b74ba164f3f27e Mon Sep 17 00:00:00 2001
> > > > > > > > > From: Chao Yu <chao@kernel.org>
> > > > > > > > > Date: Mon, 19 Jul 2021 16:37:44 +0800
> > > > > > > > > Subject: [PATCH] f2fs: fix to stop filesystem update once CP failed
> > > > > > > > > 
> > > > > > > > > During f2fs_write_checkpoint(), once we failed in
> > > > > > > > > f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
> > > > > > > > > such as prefree bitmap, nat/sit version bitmap won't be recovered,
> > > > > > > > > it may cause f2fs image to be inconsistent, let's just set CP error
> > > > > > > > > flag to avoid further updates until we figure out a scheme to rollback
> > > > > > > > > all metadatas in such condition.
> > > > > > > > > 
> > > > > > > > > Reported-by: Yangtao Li <frank.li@vivo.com>
> > > > > > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > > > ---
> > > > > > > > >      fs/f2fs/checkpoint.c | 10 +++++++---
> > > > > > > > >      1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > > > > > > > index 6c208108d69c..096c85022f62 100644
> > > > > > > > > --- a/fs/f2fs/checkpoint.c
> > > > > > > > > +++ b/fs/f2fs/checkpoint.c
> > > > > > > > > @@ -1639,8 +1639,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> > > > > > > > > 
> > > > > > > > >      	/* write cached NAT/SIT entries to NAT/SIT area */
> > > > > > > > >      	err = f2fs_flush_nat_entries(sbi, cpc);
> > > > > > > > > -	if (err)
> > > > > > > > > +	if (err) {
> > > > > > > > > +		f2fs_stop_checkpoint(sbi, false);
> > > > > > > > 
> > > > > > > > I think we should abuse this, since we can get any known ENOMEM as well.
> > > > > > > 
> > > > > > > Yup, but one critical issue here is it can break A/B update of NAT area,
> > > > > > > so, in order to fix this hole, how about using NOFAIL memory allocation
> > > > > > > in f2fs_flush_nat_entries() first until we figure out the finial scheme?
> > > > > > 
> > > > > > NOFAIL is risky, so how about adding a retry logic on ENOMEM with a message
> > > > > > and then giving up if we can't get the memory? BTW, what about EIO or other
> > > > > > family?
> > > > > 
> > > > > How about this?
> > > > 
> > > > Hmm, it seems we won't get ENOMEM.
> > > > 
> > > > __flush_nat_entry_set
> > > >    -> get_next_nat_page
> > > >      -> ...
> > > >       -> __get_meta_page
> > > >         -> repeat on ENOMEM, but stop_checkpoint on EIO
> > > 
> > > Correct, I missed to check __get_meta_page() and f2fs_get_meta_page_retry().
> > > 
> > > > 
> > > > If we have an error here, we should have stopped checkpoint. Have you seen other
> > > > issue?
> > > 
> > > Still we should fix the case from below path?
> > > 
> > > - f2fs_write_checkpoint
> > >   - do_checkpoint
> > >    - f2fs_flush_device_cache failed
> > 
> > What about adding a retry logic to deal with EIO in __submit_flush_wait()?
> > We probably need to retry submitting FLUSH commands, and then give up
> > with f2fs_stop_checkpoint(). And, then how about adding f2fs_bug_on() if
> > f2fs_flush_nat_entries() returns error without f2fs_cp_error()?
> 
> Agreed, how about this?
> 
> From 357da99968f6a31375ea47423b691400c5f66547 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Mon, 19 Jul 2021 16:37:44 +0800
> Subject: [PATCH v3] f2fs: fix to stop filesystem update once CP failed
> 
> During f2fs_write_checkpoint(), once we failed in
> f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
> such as prefree bitmap, nat/sit version bitmap won't be recovered,
> it may cause f2fs image to be inconsistent, let's just set CP error
> flag to avoid further updates until we figure out a scheme to rollback
> all metadatas in such condition.
> 
> Reported-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - add f2fs_bug_on in error path of f2fs_flush_nat_entries()
> - add retry logic in f2fs_flush_device_cache()
>  fs/f2fs/checkpoint.c | 12 +++++++++---
>  fs/f2fs/f2fs.h       |  1 +
>  fs/f2fs/segment.c    |  8 +++++++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 6c208108d69c..1d5a2a867282 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1639,8 +1639,11 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 
>  	/* write cached NAT/SIT entries to NAT/SIT area */
>  	err = f2fs_flush_nat_entries(sbi, cpc);
> -	if (err)
> +	if (err) {
> +		f2fs_err(sbi, "f2fs_flush_nat_entries failed err:%d, stop checkpoint", err);
> +		f2fs_bug_on(sbi, !f2fs_cp_error(sbi));
>  		goto stop;
> +	}
> 
>  	f2fs_flush_sit_entries(sbi, cpc);
> 
> @@ -1648,10 +1651,13 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	f2fs_save_inmem_curseg(sbi);
> 
>  	err = do_checkpoint(sbi, cpc);
> -	if (err)
> +	if (err) {
> +		f2fs_err(sbi, "do_checkpoint failed err:%d, stop checkpoint", err);
> +		f2fs_stop_checkpoint(sbi, false);
>  		f2fs_release_discard_addrs(sbi);
> -	else
> +	} else {
>  		f2fs_clear_prefree_segments(sbi, cpc);
> +	}
> 
>  	f2fs_restore_inmem_curseg(sbi);
>  stop:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1feef4cb78b6..97eae0e066ee 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -548,6 +548,7 @@ enum {
>  };
> 
>  #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
> +#define DEFAULT_RETRY_FLUSH_COUNT	3	/* maximum retry flush count */
> 
>  /* congestion wait timeout value, default: 20ms */
>  #define	DEFAULT_IO_TIMEOUT	(msecs_to_jiffies(20))
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 80f26158e304..37c7a05659fe 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -776,9 +776,15 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
>  		return 0;
> 
>  	for (i = 1; i < sbi->s_ndevs; i++) {
> +		int count = DEFAULT_RETRY_FLUSH_COUNT;
> +
>  		if (!f2fs_test_bit(i, (char *)&sbi->dirty_device))
>  			continue;
> -		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
> +
> +		do {
> +			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
> +		} while (ret && --count);
> +
>  		if (ret)

Actually, we need to stop checkpoint here?

>  			break;
> 
> -- 
> 2.22.1
> 
