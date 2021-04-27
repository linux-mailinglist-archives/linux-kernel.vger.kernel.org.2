Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB136C974
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhD0Q3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237655AbhD0Q3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EF40613EB;
        Tue, 27 Apr 2021 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540904;
        bh=9v8ALoy93dFOoBkKZmtRZHJ+1AkbCcPLTcAkygYs4RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUn7Mip1M7TUZ5GgU8sMxasivdrDHg/2RgdQFM1CQE5WG+TowZzJZBqP7vmN0n4HX
         lSD6bWf1PoviUoAwEtzAN/OAGfg0+N3foGT6LpVpSUFdUXo0ZsPE9vNqsnqyRAVYjZ
         y6KpcFlnklxHUpT8iRdNrSVVukl0+6yW11pCfQKo=
Date:   Tue, 27 Apr 2021 18:28:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 032/190] Revert "ASoC: img-parallel-out: Fix a reference
 count leak"
Message-ID: <YIg7plCKyGRcx582@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-33-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-33-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:27PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 6b9fbb073636906eee9fe4d4c05a4f445b9e2a23.
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
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: https
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  sound/soc/img/img-parallel-out.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
> index 4da49a42e854..5ddbe3a31c2e 100644
> --- a/sound/soc/img/img-parallel-out.c
> +++ b/sound/soc/img/img-parallel-out.c
> @@ -163,10 +163,8 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  	}
>  
>  	ret = pm_runtime_get_sync(prl->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(prl->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
>  	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
> -- 
> 2.31.1
> 

Looks correct, dropping.
