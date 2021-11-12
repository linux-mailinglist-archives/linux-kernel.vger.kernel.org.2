Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9306A44EC2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhKLRwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:52:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235420AbhKLRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:52:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D0F61029;
        Fri, 12 Nov 2021 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636739370;
        bh=8SIeWHSpc4GOTIKuj+16/C53joVarOR9V6253bRe61c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=llkYecQP/5zw3tNjyTiqg3ojlE6vpXGdN6ybXpzcZ9e9vUF4Z+ELiTEwae1cHE1i5
         L4NnkahwbB5SAHRzEWvo2Amzk2s2Up1NYhV3J3sa3aDTfwYeM5C4EogNJcKLhZgt2t
         nDrCESnIxWwwvHS3yobWe0mXLdEm4sHWozS1HQY8ZHYsQoiB9GGEnDo3U145D8fPXv
         +LXz3N8FXNooFxJwR81JQiX0j7oZ2UFXN52YjHPBdWkIHU9MnZbIgx4ztc3osMXm6x
         zs1+uqeoVr6IaC++NLdYvRWGGBRto8CfvApU2SyNVV2nmxw1g8IIr00CUEbx2Uy+fd
         mLhgM7eFlwdKQ==
Received: by pali.im (Postfix)
        id 626D979D; Fri, 12 Nov 2021 18:49:27 +0100 (CET)
Date:   Fri, 12 Nov 2021 18:49:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Fix warning on /proc/i8k creation error
Message-ID: <20211112174927.733zi3nt2reox6nz@pali>
References: <20211112171440.59006-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211112171440.59006-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 November 2021 18:14:40 Armin Wolf wrote:
> The removal function is called regardless of whether
> /proc/i8k was created successfully or not, the later
> causing a WARN() on module removal.
> Fix that by only registering the removal function
> if /proc/i8k was created successfully.
> 
> Tested on a Inspiron 3505.
> 
> Fixes: 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index eaace478f508..5596c211f38d 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -627,10 +627,9 @@ static void __init i8k_init_procfs(struct device *dev)
>  {
>  	struct dell_smm_data *data = dev_get_drvdata(dev);
> 
> -	/* Register the proc entry */
> -	proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data);
> -
> -	devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
> +	/* Only register exit function if creation was successful */
> +	if (proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data))
> +		devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
>  }
> 
>  #else
> --
> 2.30.2
> 
