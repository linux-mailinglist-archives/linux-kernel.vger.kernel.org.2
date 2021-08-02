Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB83DDED3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhHBR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhHBR72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:59:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDEB360243;
        Mon,  2 Aug 2021 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627927159;
        bh=f+dnO3iDFBJhoP3js15szCurvm9jJkhKj5KcO5eUtjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usnb03wJNcMmJoQSWj/2UEECYBjYNOifXNJ+MEWrkctCaImDVTelbsDe+jJPdRiGa
         +rgbYOfmnxC/KJHlV/Vi+tLbIj4nn/bfWe9r5tni70vEPeG8wOzLXUeI6Dj+M4HNFl
         Jak8pVesjhQcDXWcm+/WzOPo8vKzJVJfu5r8An0YJ1iG9OaNdFKePlNJ/bmruYqqkz
         0PuFKbmGLZ+JG4gkRcBsw2+SufsdqUKR3HmADlgurxg67uy8jgGNRECfF5VQT9piOL
         n6yApl7OptqfZaHFEUjsTQZtJ82xOf/37E0V4uqU7dAfpkdc6Qas5SySijKN5qd8av
         kqUXvKoWpQsxQ==
Date:   Mon, 2 Aug 2021 10:59:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: reset free segment to prefree status
 when do_checkpoint() fail
Message-ID: <YQgydetYHOkgY9+B@google.com>
References: <20210427082106.2755-1-frank.li@vivo.com>
 <12ae52df-bc5e-82c3-4f78-1eafe7723f93@huawei.com>
 <5f37995c-2390-e8ca-d002-3639ad39e0d3@kernel.org>
 <YPXDtEyBg5W2ToD/@google.com>
 <8d2e3a63-72f9-bcb2-24e5-dddd84136001@kernel.org>
 <YQR60QUh0Pim8vSf@google.com>
 <355ac2ff-f1f1-b9ea-bd8c-139cb24a03fb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355ac2ff-f1f1-b9ea-bd8c-139cb24a03fb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Chao Yu wrote:
> On 2021/7/31 6:18, Jaegeuk Kim wrote:
> > On 07/20, Chao Yu wrote:
> > > On 2021/7/20 2:25, Jaegeuk Kim wrote:
> > > > On 07/19, Chao Yu wrote:
> > > > > On 2021/4/27 20:37, Chao Yu wrote:
> > > > > > I think just reverting dirty/free bitmap is not enough if checkpoint fails,
> > > > > > due to we have updated sbi->cur_cp_pack and nat/sit bitmap, next CP tries
> > > > > > to overwrite last valid meta/node/data, then filesystem will be corrupted.
> > > > > > 
> > > > > > So I suggest to set cp_error if do_checkpoint() fails until we can handle
> > > > > > all cases, which is not so easy.
> > > > > > 
> > > > > > How do you think?
> > > > > 
> > > > > Let's add below patch first before you figure out the patch which covers all
> > > > > things.
> > > > > 
> > > > >   From 3af957c98e9e04259f8bb93ca0b74ba164f3f27e Mon Sep 17 00:00:00 2001
> > > > > From: Chao Yu <chao@kernel.org>
> > > > > Date: Mon, 19 Jul 2021 16:37:44 +0800
> > > > > Subject: [PATCH] f2fs: fix to stop filesystem update once CP failed
> > > > > 
> > > > > During f2fs_write_checkpoint(), once we failed in
> > > > > f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
> > > > > such as prefree bitmap, nat/sit version bitmap won't be recovered,
> > > > > it may cause f2fs image to be inconsistent, let's just set CP error
> > > > > flag to avoid further updates until we figure out a scheme to rollback
> > > > > all metadatas in such condition.
> > > > > 
> > > > > Reported-by: Yangtao Li <frank.li@vivo.com>
> > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > ---
> > > > >    fs/f2fs/checkpoint.c | 10 +++++++---
> > > > >    1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > > > index 6c208108d69c..096c85022f62 100644
> > > > > --- a/fs/f2fs/checkpoint.c
> > > > > +++ b/fs/f2fs/checkpoint.c
> > > > > @@ -1639,8 +1639,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> > > > > 
> > > > >    	/* write cached NAT/SIT entries to NAT/SIT area */
> > > > >    	err = f2fs_flush_nat_entries(sbi, cpc);
> > > > > -	if (err)
> > > > > +	if (err) {
> > > > > +		f2fs_stop_checkpoint(sbi, false);
> > > > 
> > > > I think we should abuse this, since we can get any known ENOMEM as well.
> > > 
> > > Yup, but one critical issue here is it can break A/B update of NAT area,
> > > so, in order to fix this hole, how about using NOFAIL memory allocation
> > > in f2fs_flush_nat_entries() first until we figure out the finial scheme?
> > 
> > NOFAIL is risky, so how about adding a retry logic on ENOMEM with a message
> > and then giving up if we can't get the memory? BTW, what about EIO or other
> > family?
> 
> How about this?

Hmm, it seems we won't get ENOMEM.

__flush_nat_entry_set
 -> get_next_nat_page
   -> ...
    -> __get_meta_page
      -> repeat on ENOMEM, but stop_checkpoint on EIO

If we have an error here, we should have stopped checkpoint. Have you seen other
issue?

> 
> From ffb50d9a8220be7d9e159b8555533adcf11957a8 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Mon, 19 Jul 2021 16:37:44 +0800
> Subject: [PATCH v2] f2fs: fix to stop filesystem update once CP failed
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
>  fs/f2fs/checkpoint.c | 12 +++++++++---
>  fs/f2fs/node.c       |  9 ++++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 6c208108d69c..f3f66871ae42 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1639,8 +1639,11 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 
>  	/* write cached NAT/SIT entries to NAT/SIT area */
>  	err = f2fs_flush_nat_entries(sbi, cpc);
> -	if (err)
> +	if (err) {
> +		f2fs_err(sbi, "f2fs_flush_nat_entries failed err:%d, stop checkpoint", err);
> +		f2fs_stop_checkpoint(sbi, false);
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
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 5840b82ce311..7162836d71c1 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -141,13 +141,20 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
>  	void *src_addr;
>  	void *dst_addr;
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	bool retried = false;
> 
>  	dst_off = next_nat_addr(sbi, current_nat_addr(sbi, nid));
> 
> +retry:
>  	/* get current nat block page with lock */
>  	src_page = get_current_nat_page(sbi, nid);
> -	if (IS_ERR(src_page))
> +	if (IS_ERR(src_page)) {
> +		if (PTR_ERR(src_page) == -ENOMEM && !retried) {
> +			retried = true;
> +			goto retry;
> +		}
>  		return src_page;
> +	}
>  	dst_page = f2fs_grab_meta_page(sbi, dst_off);
>  	f2fs_bug_on(sbi, PageDirty(src_page));
> 
> -- 
> 2.22.1
> 
