Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3828E36CAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhD0R7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0R6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:58:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D12D613C0;
        Tue, 27 Apr 2021 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619546291;
        bh=UGJqCc4+/xgm/VnWrKNR8nxLugg0ogLVphDp7bF+svo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPAvxUaVRE6lRm/otvyVZ8f72iM5jCTEgLXDbIm3NB9MULNL5lfwVVR0mkWeci/il
         CG8qcPpLJ4TnE4k32Uh7GIKMuzk6VZAkKm6ilogZlLqGcadOSAjzSvX//WFTuvUmx/
         WjkKWES3onlTvpwbndbqsiHPYdAWN7P/XwpDuIyI=
Date:   Tue, 27 Apr 2021 19:58:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 066/190] Revert "bpf: Remove unnecessary assertion on
 fp_old"
Message-ID: <YIhQsRZ9LgZKlkPw@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-67-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-67-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:01PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 5bf2fc1f9c88397b125d5ec5f65b1ed9300ba59d.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: https
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/bpf/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 75244ecb2389..da29211ea5d8 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -230,6 +230,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
>  	struct bpf_prog *fp;
>  	u32 pages;
>  
> +	BUG_ON(fp_old == NULL);
> +
>  	size = round_up(size, PAGE_SIZE);
>  	pages = size / PAGE_SIZE;
>  	if (pages <= fp_old->pages)
> -- 
> 2.31.1
> 

The original commit here is correct, I'll drop this revert.

thanks,

greg k-h
