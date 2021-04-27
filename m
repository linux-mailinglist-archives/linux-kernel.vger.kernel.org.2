Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E636C977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhD0Q3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238781AbhD0Q3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3DDA613DD;
        Tue, 27 Apr 2021 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540916;
        bh=SvRAOQ/b8X2yo7IGfvAYmJuvmzcrrn7qSWNZ+IBzouw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBgFJZiqXb1NiFaKbV7K2SXFz/acRuk0VyuX8WDsYj6gULRTtpDgbpuzV1qejhpcT
         XXwrzK87QCzFvzZ96vjshwBaXOKS5nSkxombktlIuG9IDhZjPe/UbQRlScuJWKrl9y
         D2xez1tKhR+xeQTuFEj8k1rl/MLEyyYNX/Aue4A4=
Date:   Tue, 27 Apr 2021 18:28:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 033/190] Revert "ASoC: img: Fix a reference count leak in
 img_i2s_in_set_fmt"
Message-ID: <YIg7sSTw8BTtCzqf@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-34-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-34-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:28PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit c4c59b95b7f7d4cef5071b151be2dadb33f3287b.
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
>  sound/soc/img/img-i2s-in.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
> index 0843235d73c9..e30b66b94bf6 100644
> --- a/sound/soc/img/img-i2s-in.c
> +++ b/sound/soc/img/img-i2s-in.c
> @@ -343,10 +343,8 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  	chan_control_mask = IMG_I2S_IN_CH_CTL_CLK_TRANS_MASK;
>  
>  	ret = pm_runtime_get_sync(i2s->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(i2s->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	for (i = 0; i < i2s->active_channels; i++)
>  		img_i2s_in_ch_disable(i2s, i);
> -- 
> 2.31.1
> 

Looks correct, dropping.

greg k-h
