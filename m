Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934283648A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhDSQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239432AbhDSQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1902F61157;
        Mon, 19 Apr 2021 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618851437;
        bh=3dmEuV6yQnYs+WvENMHQ1GFdBQ3rQzjD8hIFXwwaDEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upUv8v+s/Hv7tEJrZ8W+uGHlGnRmuCZFWdOlt+hLPf4JJgSz48dQ+1OSjcWw8k2g3
         shPYs5CIpoDtZ9v0YVVnPPMrzSFuYonPB/r08c0Lo+nThMX52yU1ceP63LLnUz9fwb
         MNBOo/wZwIX/O72FFKMx2OjkDRfoREzvXkdqecEHvLrW17LNrvClnOyJjCHgqsGNSf
         k3ujEbqNdwdG5sgoU4qj6FzzVymP9dXprWSuxacId4lVpr6Dtq76Sp99YBxcSI21WO
         m9mX4teKXFRJH8eEVUr5v+2KjUcGUT5jZhtZTVDZP9Lcb7dyxMLzuky/S9Z4CGOjab
         ev3KYtBrejrlw==
Date:   Mon, 19 Apr 2021 09:57:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to cover allocate_segment() with lock
Message-ID: <YH22a55sexxwmGCe@google.com>
References: <20210414012134.128066-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012134.128066-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Chao Yu wrote:
> As we did for other cases, in fix_curseg_write_pointer(), let's
> change as below:
> - use callback function s_ops->allocate_segment() instead of
> raw function allocate_segment_by_default();
> - cover allocate_segment() with curseg_lock and sentry_lock.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b2ee6b7791b0..daf9531ec58f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4848,7 +4848,12 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
>  
>  	f2fs_notice(sbi, "Assign new section to curseg[%d]: "
>  		    "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff);
> -	allocate_segment_by_default(sbi, type, true);
> +
> +	down_read(&SM_I(sbi)->curseg_lock);
> +	down_write(&SIT_I(sbi)->sentry_lock);
> +	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
> +	up_write(&SIT_I(sbi)->sentry_lock);
> +	up_read(&SM_I(sbi)->curseg_lock);

Seems f2fs_allocate_new_section()?

>  
>  	/* check consistency of the zone curseg pointed to */
>  	if (check_zone_write_pointer(sbi, zbd, &zone))
> -- 
> 2.29.2
