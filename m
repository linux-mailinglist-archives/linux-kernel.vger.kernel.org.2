Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1100336C98B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhD0QhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237407AbhD0QhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:37:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A8C6613D8;
        Tue, 27 Apr 2021 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541378;
        bh=Gb/kAjfgJ71w92ow3r99e1saSqmZhbVQB2dr9jH88P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9vlDeju4Yom3JJy+qs17/eXyhvgFGwMWk8AiUtnZW5kN7EqIpaeWZKeuIddvn0jc
         yfAWkkWtds0IpmjkdKZ/CqCiFoyOMrFwRkqcTveeH3JUeSXWVGyTErz8dhQhvVr4Zb
         HmpkSplrpr2w4NpHx1caEeAmJ1t+rHVoo839ho34=
Date:   Tue, 27 Apr 2021 18:36:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 079/190] Revert "ASoC: rt5645: fix a NULL pointer
 dereference"
Message-ID: <YIg9gESfnZBUALDo@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-80-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-80-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:14PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 51dd97d1df5fb9ac58b9b358e63e67b530f6ae21.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  sound/soc/codecs/rt5645.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 63a7e052eaa0..ab06133a85da 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3407,9 +3407,6 @@ static int rt5645_probe(struct snd_soc_component *component)
>  		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
>  		GFP_KERNEL);
>  
> -	if (!rt5645->eq_param)
> -		return -ENOMEM;
> -
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 

Lots of things seem to be still allocated here, when this returns, so
I'm going to keep this revert and go back to it later and try to fix it
up properly...

thanks,

greg k-h
