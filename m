Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFAB36D2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhD1HMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhD1HMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBD48613E8;
        Wed, 28 Apr 2021 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619593875;
        bh=kCkThJgnYF9IXPhmKsQ3RjJ7SvL0Lv7X3t1df9LBL9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnwqoIm/2IB+cMi7mQ5iPNDS+3KAU48b4E6HrAokYyGZdP+uKunBTKODKFYHDeBnp
         bKvI+ETG97RtM+zeMyxqBaxrwCrKObcyN43F2jaok2G7TXWHSb2GZsRM5LDER7V8fC
         3RMgdThso05OXCBW/NQX4Zm+TtJAgvbic3lTbNNc=
Date:   Wed, 28 Apr 2021 09:11:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 031/190] Revert "test_objagg: Fix potential memory leak
 in error handling"
Message-ID: <YIkKkHJgiWCjZt2y@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-32-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-32-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:26PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit a6379f0ad6375a707e915518ecd5c2270afcd395.
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
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  lib/test_objagg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_objagg.c b/lib/test_objagg.c
> index da137939a410..72c1abfa154d 100644
> --- a/lib/test_objagg.c
> +++ b/lib/test_objagg.c
> @@ -979,10 +979,10 @@ static int test_hints_case(const struct hints_case *hints_case)
>  err_world2_obj_get:
>  	for (i--; i >= 0; i--)
>  		world_obj_put(&world2, objagg, hints_case->key_ids[i]);
> -	i = hints_case->key_ids_count;
> +	objagg_hints_put(hints);
>  	objagg_destroy(objagg2);
> +	i = hints_case->key_ids_count;
>  err_check_expect_hints_stats:
> -	objagg_hints_put(hints);
>  err_hints_get:
>  err_check_expect_stats:
>  err_world_obj_get:
> -- 
> 2.31.1
> 

This commit looks correct to me, so I will drop the revert.

greg k-h
