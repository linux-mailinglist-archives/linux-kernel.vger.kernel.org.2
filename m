Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A36B242
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhDZLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhDZLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:19:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 04:18:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r20so34108722ejo.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 04:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p8tbZ7a5zFyrcPXQfjOozo6JYlYmD/rPExYpSEVlPwI=;
        b=dEGlQDN4STTfi5saN3978Av3M6UluLprWoDm6It+bMg0c+ZayvrJ4ARHw5XdzDj1/h
         vuDm4xBz1WOXZwW9nR37gAGyIDkFnHyl3Qr27RfnjnuDG+E+6y1X55cUCdZcTjvE6P7P
         toMoJ5mo1S4epG2KEYNT+R9hAlRdofAmwVmaxex4uLyhKUFLYeGYpVSoWFYZMBhmnzhs
         cTg12wYB6jXvKtGLKkUUlNiWGa+HpqSRrkC22qpAcTZyJHHDd1qO4yS391dgGf1s5XA6
         JFNl1UL92o2/f9Pcv7/0k7Isv5yuGnkwkr/IgON3UnuIxvQPmrkUfF5YPkUD1Dlynrot
         Z+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p8tbZ7a5zFyrcPXQfjOozo6JYlYmD/rPExYpSEVlPwI=;
        b=h+pYtS8wtlPwlRgovF9hixwrH2GBeroD6LQ6irbdm9Q3va5PLJcbtcVR/H87HpQDqu
         SBKepL5xebOd0XIRmA2DpovMP+LGDM50HflrlKm57FYYcHNryOFXRbQ8kbgxpDW5/shN
         oOW2b+9b4KgQWEcUdT5/yxFf5FuhPP7vNtpelgjQDluiI71BASM0obXHMYf5/rcb4dxX
         Ng2+u26e+Wxko+Cw7uqBuSTZuqxWdG//J0RLPDCUBDS1OQk+ZQBjvCLFS5GlDrYZcTb0
         UyRNqjY5dVs3x4fazPzYayTjENW0lCsq9YriDkR0VjbQwqWa8HfMKLvnMGfxURjsHuyD
         hH3w==
X-Gm-Message-State: AOAM530kd42FJHTqM8gwkdZmtsUdIfKhmMQFQIqmfn94rBOE5rT1Dc7T
        edRRxfVLuvm2REoKrNRB5v0=
X-Google-Smtp-Source: ABdhPJyxXiEdLiFT5NOcz9Hlo9N49hZr+rfdFmnVvc8QMZb4Ng24CXc9TX9ChmRTmToZj6C1lWku6g==
X-Received: by 2002:a17:906:9ac5:: with SMTP id ah5mr17765112ejc.360.1619435918911;
        Mon, 26 Apr 2021 04:18:38 -0700 (PDT)
Received: from [10.80.0.92] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d15sm14252873edu.86.2021.04.26.04.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 04:18:38 -0700 (PDT)
Subject: Re: [PATCH 046/190] Revert "net/mlx4_core: fix a memory leak bug."
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-47-gregkh@linuxfoundation.org>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
Message-ID: <1027d8d1-5cea-0a04-4974-3f9672ff7d4e@gmail.com>
Date:   Mon, 26 Apr 2021 14:18:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-47-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2021 3:58 PM, Greg Kroah-Hartman wrote:
> This reverts commit febfd9d3c7f74063e8e630b15413ca91b567f963.
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
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
> index f6cfec81ccc3..380e027ba5df 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/fw.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
> @@ -2734,7 +2734,7 @@ void mlx4_opreq_action(struct work_struct *work)
>   		if (err) {
>   			mlx4_err(dev, "Failed to retrieve required operation: %d\n",
>   				 err);
> -			goto out;
> +			return;
>   		}
>   		MLX4_GET(modifier, outbox, GET_OP_REQ_MODIFIER_OFFSET);
>   		MLX4_GET(token, outbox, GET_OP_REQ_TOKEN_OFFSET);
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

The original commit febfd9d3c7f74063e8e630b15413ca91b567f963 is a bad 
commit. Not to be re-submitted.

Regards,
Tariq
