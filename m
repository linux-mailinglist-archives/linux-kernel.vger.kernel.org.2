Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB28634A924
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhCZN4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4380B619A0;
        Fri, 26 Mar 2021 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616766992;
        bh=O7IRWgd00UHT0VyHJxToyfBcxmszCLnq1Pe7Rl41vIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHBx1s7kmQhhBdrxT2Z/StHNZaSpQs15JgcY3TEZa9jr0JBap0+i+ekF9XWvPHU5q
         nVaQDuxy0f31kCs8QT/kxdhz1LWCJ/hfhZndhBocLqIGCRbEUkj8nMDOZpPx4w54Eq
         UGwx4xomCwc5VeSGTK8+jgMiPOE7cGiAJ3IadIGM=
Date:   Fri, 26 Mar 2021 14:56:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH resend] jfs: fix use-after-free in lbmIODone
Message-ID: <YF3oDrnN3RJBFQ0P@kroah.com>
References: <20210322161147.5593-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322161147.5593-1-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:41:47PM +0530, Anirudh Rayabharam wrote:
> Fix use-after-free by waiting for ongoing IO to complete before freeing
> lbufs in lbmLogShutdown. Add a counter in struct jfs_log to keep track
> of the number of in-flight IO operations and a wait queue to wait on for
> the IO operations to complete.
> 
> Reported-by: syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  fs/jfs/jfs_logmgr.c | 17 ++++++++++++++---
>  fs/jfs/jfs_logmgr.h |  2 ++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 9330eff210e0..82d20c4687aa 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1815,6 +1815,8 @@ static int lbmLogInit(struct jfs_log * log)
>  	 */
>  	init_waitqueue_head(&log->free_wait);
>  
> +	init_waitqueue_head(&log->io_waitq);
> +
>  	log->lbuf_free = NULL;
>  
>  	for (i = 0; i < LOGPAGES;) {
> @@ -1864,6 +1866,7 @@ static void lbmLogShutdown(struct jfs_log * log)
>  	struct lbuf *lbuf;
>  
>  	jfs_info("lbmLogShutdown: log:0x%p", log);
> +	wait_event(log->io_waitq, !atomic_read(&log->io_inflight));
>  
>  	lbuf = log->lbuf_free;
>  	while (lbuf) {
> @@ -1990,6 +1993,8 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
>  	bio->bi_end_io = lbmIODone;
>  	bio->bi_private = bp;
>  	bio->bi_opf = REQ_OP_READ;
> +
> +	atomic_inc(&log->io_inflight);
>  	/*check if journaling to disk has been disabled*/
>  	if (log->no_integrity) {
>  		bio->bi_iter.bi_size = 0;
> @@ -2135,6 +2140,7 @@ static void lbmStartIO(struct lbuf * bp)
>  	bio->bi_private = bp;
>  	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
>  
> +	atomic_inc(&log->io_inflight);

Why use an atomic for this?  The value can change after you test for it,
as there's no lock involved.

Do you really need to keep track of all of these "inflight"?  That feels
very "heavy" to me.

jfs developers, any ideas?

thanks,

greg k-h
