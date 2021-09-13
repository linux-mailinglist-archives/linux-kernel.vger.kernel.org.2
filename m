Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052BF408959
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbhIMKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239098AbhIMKuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:50:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8023B60F6F;
        Mon, 13 Sep 2021 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631530150;
        bh=mR1pVV2kOMI80Ja7yzXvmNiM7iNo0TC3CDna+Eb+WW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=whffSoOuEHQv+u4VNzKHW5BcvMrgy5hCzCn6P4DZFqfaXn2ImQuMedBArVOO3O5KI
         To52PolxSa5r7tu7ub+XcIhaGvegyOQ9CX0WLS5CqwyreEaftLtsf/q2lAZsSO3kAu
         3whEoYyG+bygYrNXLMQhkmU34eLWgYU/mTKyNGQs=
Date:   Mon, 13 Sep 2021 12:49:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, axboe@kernel.dk,
        stable-commits@vger.kernel.org
Subject: Re: Patch "io_uring: fail links of cancelled timeouts" has been
 added to the 5.13-stable tree
Message-ID: <YT8so5i420vp4LRZ@kroah.com>
References: <163152631411232@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163152631411232@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:45:14AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     io_uring: fail links of cancelled timeouts
> 
> to the 5.13-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      io_uring-fail-links-of-cancelled-timeouts.patch
> and it can be found in the queue-5.13 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 2ae2eb9dde18979b40629dd413b9adbd6c894cdf Mon Sep 17 00:00:00 2001
> From: Pavel Begunkov <asml.silence@gmail.com>
> Date: Thu, 9 Sep 2021 13:56:27 +0100
> Subject: io_uring: fail links of cancelled timeouts
> 
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> commit 2ae2eb9dde18979b40629dd413b9adbd6c894cdf upstream.
> 
> When we cancel a timeout we should mark it with REQ_F_FAIL, so
> linked requests are cancelled as well, but not queued for further
> execution.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Link: https://lore.kernel.org/r/fff625b44eeced3a5cae79f60e6acf3fbdf8f990.1631192135.git.asml.silence@gmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/io_uring.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1307,6 +1307,8 @@ static void io_kill_timeout(struct io_ki
>  	struct io_timeout_data *io = req->async_data;
>  
>  	if (hrtimer_try_to_cancel(&io->timer) != -1) {
> +		if (status)
> +			req_set_fail(req);
>  		atomic_set(&req->ctx->cq_timeouts,
>  			atomic_read(&req->ctx->cq_timeouts) + 1);
>  		list_del_init(&req->timeout.list);
> 
> 
> Patches currently in stable-queue which might be from asml.silence@gmail.com are
> 
> queue-5.13/io_uring-limit-fixed-table-size-by-rlimit_nofile.patch
> queue-5.13/io_uring-reexpand-under-reexpanded-iters.patch
> queue-5.13/io_uring-fail-links-of-cancelled-timeouts.patch
> queue-5.13/bio-fix-page-leak-bio_add_hw_page-failure.patch
> queue-5.13/io_uring-refactor-io_submit_flush_completions.patch

Breaks the build on 5.13.y so dropping it from there.

thanks,

greg k-h
