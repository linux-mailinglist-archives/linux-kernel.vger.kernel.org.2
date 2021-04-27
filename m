Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D097636C987
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhD0Qfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236606AbhD0Qfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:35:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87A7613CA;
        Tue, 27 Apr 2021 16:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541285;
        bh=K31Hq1a37anITaJoL/GTuv5AShH7McwCTuWq17PbdbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzQl4eHKGt2SHGjSMCpMKi5Y9jGhUTG8231pMdQiI4GfKaKWr9PMSqMbklV9IfFKn
         UCGV7hImCrBNM1VgQPo8ROjT+8aPvXWpglIpUOiamWVJQhCU+LFTQv+KIte1QZd8UC
         TEefAiGJhK1Y/IaaNq6kU0qe+DZaIivND+s1Op90=
Date:   Tue, 27 Apr 2021 18:34:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 078/190] Revert "ASoC: cs43130: fix a NULL pointer
 dereference"
Message-ID: <YIg9ImoNlfuQNOFX@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-79-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-79-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:13PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit a2be42f18d409213bb7e7a736e3ef6ba005115bb.
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
>  sound/soc/codecs/cs43130.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
> index 80bc7c10ed75..c2b6f0ae6d57 100644
> --- a/sound/soc/codecs/cs43130.c
> +++ b/sound/soc/codecs/cs43130.c
> @@ -2319,8 +2319,6 @@ static int cs43130_probe(struct snd_soc_component *component)
>  			return ret;
>  
>  		cs43130->wq = create_singlethread_workqueue("cs43130_hp");
> -		if (!cs43130->wq)
> -			return -ENOMEM;
>  		INIT_WORK(&cs43130->work, cs43130_imp_meas);
>  	}
>  
> -- 
> 2.31.1
> 

The original patch here is not correct, lots of resources are allocated
and files created that are not unwound.  I will keep this revert and fix
it up "properly".

thanks,

greg k-h
