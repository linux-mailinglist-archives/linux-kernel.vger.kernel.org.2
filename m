Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6D317156
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhBJU11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233224AbhBJUZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:25:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AC5364EDC;
        Wed, 10 Feb 2021 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988700;
        bh=4DjTUvBAiW5tn3IwIpk+FPIchSzhXHiwWLN2elYPlQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAknOCXjfwEYZb+LFXXSG5cqCityyvX266Z8XuMzniespmRCGf7fdJN/2QPZWCh0x
         YDM7gMkLaKMhbaV1xmkcfPHfTgcyn7CKWlfwUxEFa9/Q57a/ZtYmDeDfb07ZzguYAE
         L9TVzjDuj3/b0uGx8mTAxKraL1UePP3yf2qEyCsRoqqyZ6s2l+oPGTOZIjdFW6P6HG
         U73+GlAIRg2AqiMnAFTYyJHImOu0zvWSE9vKGqDX7Kr6fwH2ZXeluakP5pRM86lrz9
         J2eP395ADYfbXNynri7Z6vN4iaf+0/6S+cDkPpXEQ1nLhtD7rQIipQOU5YuJpT3WoI
         p+RRng1ZsPHuw==
Date:   Wed, 10 Feb 2021 12:24:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 5/5] dm: set DM_TARGET_PASSES_CRYPTO feature for some
 targets
Message-ID: <YCRBGnGq/LY0uNxM@gmail.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210201051019.1174983-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201051019.1174983-6-satyat@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:10:19AM +0000, Satya Tangirala wrote:
> dm-linear and dm-flakey obviously can pass through inline crypto support.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/md/dm-flakey.c | 4 +++-
>  drivers/md/dm-linear.c | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
> index a2cc9e45cbba..30c6bc151213 100644
> --- a/drivers/md/dm-flakey.c
> +++ b/drivers/md/dm-flakey.c
> @@ -482,8 +482,10 @@ static struct target_type flakey_target = {
>  	.name   = "flakey",
>  	.version = {1, 5, 0},
>  #ifdef CONFIG_BLK_DEV_ZONED
> -	.features = DM_TARGET_ZONED_HM,
> +	.features = DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
>  	.report_zones = flakey_report_zones,
> +#else
> +	.features = DM_TARGET_PASSES_CRYPTO,
>  #endif
>  	.module = THIS_MODULE,
>  	.ctr    = flakey_ctr,
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 00774b5d7668..fc9c4272c10d 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -229,10 +229,11 @@ static struct target_type linear_target = {
>  	.version = {1, 4, 0},
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
> -		    DM_TARGET_ZONED_HM,
> +		    DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
>  	.report_zones = linear_report_zones,
>  #else
> -	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT,
> +	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
> +		    DM_TARGET_PASSES_CRYPTO,
>  #endif
>  	.module = THIS_MODULE,
>  	.ctr    = linear_ctr,
> -- 

This latest version looks good to me.  If it's needed despite my
Co-developed-by, feel free to add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

BTW, the #ifdef for CONFIG_BLK_DEV_ZONED is error-prone (though it's a
pre-existing issue).  I wonder if DM_TARGET_ZONED_HM should be defined to 0 when
!CONFIG_BLK_DEV_ZONED, which would avoid the need for the #ifdef on .features.

- Eric
