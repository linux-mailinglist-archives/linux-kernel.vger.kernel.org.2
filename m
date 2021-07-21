Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84C3D142B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhGUPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhGUPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:46:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276CC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:27:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bu12so4211871ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6rxBSnZCujLbQhKhyDascpF8n6wsyclfCgFL5qiQVUM=;
        b=rabb6ZSTLhR2YVkWsN+WNhK+GHdYeQAPSj+sPk6eI9AdL+37iTIzKhZbaG9Z73fA5M
         gqlsDfYKlb6kYHl2R4qRFguJg1MB60FxphwWrV40SvLmHCMGYOlje/83s8dXa8ElYXAd
         xq/AOf2Nkm7dNbh8dh66H29eb86gpBwON+sdePsQ4OZIjbX6k3mmU2nWMo+Dw54viKXT
         UBR7Ywlpbjz6oRE0RnWlPICDQjaQeFsqcGsH/al8Fjng2PsOAcgLPCHvo2XIAVIGvYp3
         4oT4eA7nJR/6TuId09Mpjmi4n6VSH5JPJshw85l5L63o4b5eMw9p8o0sGYU0ve0WTfHb
         94oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6rxBSnZCujLbQhKhyDascpF8n6wsyclfCgFL5qiQVUM=;
        b=rVaVuJ5W5VoOPfU5WaJl1enQYEHqLsdKGyMyKKU/anwv4/rmXP0enTcPm4s7DU/6IE
         ndGOaKQzZHbiLfWLckS0SYkBc2pMkLa9UXB0qYrkUwL2dPUaWs4Ew/q/3dPnu0+o8M4K
         1x1wM65inw97ZZmcexEtY2zZh0fFjhRjLl2+z1M/+ryJ9DKpHk2RwZq/JcOScU6BeLL9
         bgtX51zdvidu4sMq2OdGeRdD4CUq91w4Hvef5cK9KXKrLs0iFRfV4GZYZ5h2Dik+JUir
         jPOP1Dd1o+lw+8fiSoidhMgQIZIPW+RYyi3+H3YssudygsVqzJojW7iKLKocWzGgUScd
         zScA==
X-Gm-Message-State: AOAM533XFGKyE/s1Zt2FKEWC3OqSvrm1Ys0sLX9xXFWj25nMmru94S2b
        11tXv37v6Drtixf9+50bYpg=
X-Google-Smtp-Source: ABdhPJyR57ay+APBdznlFocgeTsTCHeL6lLYxI4NGz1IDP0jrmffPfWNh/IoLsIkk51Vv8Rp3M5s0w==
X-Received: by 2002:a17:907:a079:: with SMTP id ia25mr11319079ejc.515.1626884819304;
        Wed, 21 Jul 2021 09:26:59 -0700 (PDT)
Received: from agape.jhs ([5.171.81.22])
        by smtp.gmail.com with ESMTPSA id n18sm8572472ejl.74.2021.07.21.09.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:26:59 -0700 (PDT)
Date:   Wed, 21 Jul 2021 18:26:53 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: select CONFIG_CRYPTO_LIB_ARC4
Message-ID: <20210721162645.GA1395@agape.jhs>
References: <20210721153550.3624490-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721153550.3624490-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:35:44PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The other rtlwifi drivers already have this, but r8723bs
> was converted to the generic implementation without adding
> the select:
> 
> ERROR: modpost: "arc4_crypt" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> ERROR: modpost: "arc4_setkey" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> 
> Fixes: 1b11e893eda0 ("staging: rtl8723bs: replace private arc4 encryption with in-kernel one")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rtl8723bs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
> index a88467334dac..7eae820eae3b 100644
> --- a/drivers/staging/rtl8723bs/Kconfig
> +++ b/drivers/staging/rtl8723bs/Kconfig
> @@ -5,6 +5,7 @@ config RTL8723BS
>  	depends on m
>  	select WIRELESS_EXT
>  	select WEXT_PRIV
> +	select CRYPTO_LIB_ARC4
>  	help
>  	This option enables support for RTL8723BS SDIO drivers, such as
>  	the wifi found on the 1st gen Intel Compute Stick, the CHIP
> -- 
> 2.29.2
> 

Acked-by: Fabio Aiuto <fabioaiuto83@gmail.com>

thank you,

fabio
