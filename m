Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8C34799E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhCXNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhCXN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:29:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F3C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:29:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u9so32863559ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PgVEYZSY9NfCWwR2RJxuZCY5immorWw9IvrU7FEyMZY=;
        b=UfacaA3RcLXv73AcHDgJVuzH7YaisiE/ItZkS1uBCiSsqiLdWBFj5OF+zflnrnsnYx
         thUzVL+tmZYONqMfijfYvZh9KKy38ZVe3ey1RBu19Et4GjUIPC2BNLhXkOOj251o6RaW
         8XtBzRFZKyeNdJxct3Rszmmy3GIlPfZ2VEtjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PgVEYZSY9NfCWwR2RJxuZCY5immorWw9IvrU7FEyMZY=;
        b=dmNgdG3u9mUCb+aXYKCl6RXemrpqO9ryFSUfKbDVczA7FE8oGp1nOzjKrg5yQ9bIsr
         +aqc9PfSGj4w88ruf9jed5wTjPSatlFtUO8MNJ3xLk0E+p86LZoFc4mG1kWnsAVDTl3R
         7nT9v/vvUfShiHOuLKsg+rExW3MtkgX/ZW7DuJWln6Mq95+Hg+oDnN4hWWEyvdYGqzhM
         d4W/nU/xsAZcHEGWyRzdayWKq5k1vtKbDryotvusUmh78U26QTpfA72d4TXEwCD2RWE4
         RD/KI97ynJOUtXMJ6JAlXsosMP6PiEqkUedN0fuX6hl+9Oisg1ccTEdE308cZ/3IHuX3
         kUeg==
X-Gm-Message-State: AOAM530p2re7+uj7WaY+poERffFx5APtvt4wlPymXv4zBk/7qwKuOHF0
        IzbfnPouvdw+j72blYKBgIC/N23shwU0BlTh
X-Google-Smtp-Source: ABdhPJxwxP/zoW96bzshYo9WwqHEtz/uzdvBB0Uh76Zv+xKUOFCRnDORCj3YobzDL1Kd8hSaa2YApQ==
X-Received: by 2002:a17:906:3159:: with SMTP id e25mr3694270eje.303.1616592590531;
        Wed, 24 Mar 2021 06:29:50 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id u16sm1178887edq.4.2021.03.24.06.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 06:29:50 -0700 (PDT)
Subject: Re: [PATCH] [v2] hinic: avoid gcc -Wrestrict warning
To:     Arnd Bergmann <arnd@kernel.org>, Bin Luo <luobin9@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210324130731.1513798-1-arnd@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f3d1c643-56ef-7fe0-52f0-1f030c890a38@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 14:29:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324130731.1513798-1-arnd@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 14.07, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With extra warnings enabled, gcc complains that snprintf should not
> take the same buffer as source and destination:
> 
> drivers/net/ethernet/huawei/hinic/hinic_ethtool.c: In function 'hinic_set_settings_to_hw':
> drivers/net/ethernet/huawei/hinic/hinic_ethtool.c:480:9: error: 'snprintf' argument 4 overlaps destination object 'set_link_str' [-Werror=restrict]
>   480 |   err = snprintf(set_link_str, SET_LINK_STR_MAX_LEN,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   481 |           "%sspeed %d ", set_link_str, speed);
>       |           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/huawei/hinic/hinic_ethtool.c:464:7: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>   464 |  char set_link_str[SET_LINK_STR_MAX_LEN] = {0};
> 
> Rewrite this to avoid the nested sprintf and instead use separate
> buffers, which is simpler.
> 

This looks much better. Thanks.

> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rework according to feedback from Rasmus. This one could
>     easily avoid most of the pitfalls
> ---
>  .../net/ethernet/huawei/hinic/hinic_ethtool.c | 25 ++++++++-----------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> index c340d9acba80..d7e20dab6e48 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> @@ -34,7 +34,7 @@
>  #include "hinic_rx.h"
>  #include "hinic_dev.h"
>  
> -#define SET_LINK_STR_MAX_LEN	128
> +#define SET_LINK_STR_MAX_LEN	16
>  
>  #define GET_SUPPORTED_MODE	0
>  #define GET_ADVERTISED_MODE	1
> @@ -462,24 +462,19 @@ static int hinic_set_settings_to_hw(struct hinic_dev *nic_dev,
>  {
>  	struct hinic_link_ksettings_info settings = {0};
>  	char set_link_str[SET_LINK_STR_MAX_LEN] = {0};
> +	const char *autoneg_str;
>  	struct net_device *netdev = nic_dev->netdev;
>  	enum nic_speed_level speed_level = 0;
>  	int err;
>  
> -	err = snprintf(set_link_str, SET_LINK_STR_MAX_LEN, "%s",
> -		       (set_settings & HILINK_LINK_SET_AUTONEG) ?
> -		       (autoneg ? "autong enable " : "autong disable ") : "");
> -	if (err < 0 || err >= SET_LINK_STR_MAX_LEN) {
> -		netif_err(nic_dev, drv, netdev, "Failed to snprintf link state, function return(%d) and dest_len(%d)\n",
> -			  err, SET_LINK_STR_MAX_LEN);
> -		return -EFAULT;
> -	}
> +	autoneg_str = (set_settings & HILINK_LINK_SET_AUTONEG) ?
> +		      (autoneg ? "autong enable " : "autong disable ") : "";
>  
>  	if (set_settings & HILINK_LINK_SET_SPEED) {
>  		speed_level = hinic_ethtool_to_hw_speed_level(speed);
>  		err = snprintf(set_link_str, SET_LINK_STR_MAX_LEN,
> -			       "%sspeed %d ", set_link_str, speed);
> -		if (err <= 0 || err >= SET_LINK_STR_MAX_LEN) {
> +			       "speed %d ", speed);
> +		if (err >= SET_LINK_STR_MAX_LEN) {
>  			netif_err(nic_dev, drv, netdev, "Failed to snprintf link speed, function return(%d) and dest_len(%d)\n",
>  				  err, SET_LINK_STR_MAX_LEN);
>  			return -EFAULT;

It's not your invention of course, but this both seems needlessly harsh
and EFAULT is a weird error to return. It's just a printk() message that
might be truncated, and now that the format string only has a %d
specifier, it can actually be verified statically that overflow will
never happen (though I don't know or think gcc can do that, perhaps
there's some locale nonsense in the standard that allows using
utf16-encoded sanskrit runes). So probably that test should just be
dropped, but that's a separate thing.

Reviewed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

