Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A537233F7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhCQSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhCQSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:02:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25718C06174A;
        Wed, 17 Mar 2021 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=9lsHS9lOU27LyGTG7QJBu3yVy8h5bkH/PgY8pAOOR6k=; b=f4pi4tMaDfirLHGE08FIvAgRrr
        emtuq8/Wn4S30m/LlkVScDaZjuS6e18BBe653aSuW19aCIasGjXIOS21WDVhFx5287m20ib43T3xL
        0JhMHMUjY5whZQ/6HhuUy8oTP2bPTgHjWTs9w3y/jRxGT6ks6HitaR0boEEjd2eVudVzvX1PQOS2K
        Ic7SXOoLv2omP2NCkHMfNlMcc5IZCgvJ11X9xy5Civg44+CmMqej/mdvVqJUUpOTurtZlvKHaqY6v
        YJ42GMxeTJUWbnO427ZFaH9Km3JLKVECucn5zXLrZF6B0P2vG7jR72xq4aBjKdn/eQFFWyBBDUoJt
        eIL6GPlA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaUp-001fk0-4S; Wed, 17 Mar 2021 18:02:15 +0000
Subject: Re: [PATCH] platform: mellanox: Typo fix in the file mlxbf-bootctl.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, andy@infradead.org,
        dvhart@infradead.org, vadimp@nvidia.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317095650.2036419-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e7f14e71-87fe-3619-3d4b-fff47643c14e@infradead.org>
Date:   Wed, 17 Mar 2021 11:02:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317095650.2036419-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 2:56 AM, Bhaskar Chowdhury wrote:
> 
> s/progamming/programming/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/platform/mellanox/mlxbf-bootctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 5d21c6adf1ab..1c7a288b59a5 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -208,7 +208,7 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
>  	 * 0011 = version 1, 0111 = version 2, 1111 = version 3). Upper 4 bits
>  	 * are a thermometer code indicating key programming has completed for
>  	 * key n (same encodings as the start bits). This allows for detection
> -	 * of an interruption in the progamming process which has left the key
> +	 * of an interruption in the programming process which has left the key
>  	 * partially programmed (and thus invalid). The process is to burn the
>  	 * eFuse for the new key start bit, burn the key eFuses, then burn the
>  	 * eFuse for the new key complete bit.
> --


-- 
~Randy

