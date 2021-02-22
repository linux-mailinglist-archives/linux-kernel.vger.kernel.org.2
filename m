Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A4C32212A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhBVVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhBVVOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:14:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D3CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uvvxHpxjpRDChkcLEuz/w9isIoe8ffoa8WKElKGpxLg=; b=qcVt3B5qUZhOe1+3Fvy1vUW2UW
        IGVigTv5c/u0qDQL+9cL1hKNSu+vEkrGr3Y+Gxti77SpQlOLYV9BpAf00AsbW5Zil8KzpfONvIraK
        eykqUElkB12/bQldmhoABtRYV+8LTL0OKUQuPbu/gSFotUUmKieWAfV9fV+1MRIueVV0opRokVPZw
        j9ht9zXLmbvunpixo080IqgEHTpV+eDExj14gnpz3qpqrariiuFWS1VpNcQM1dmiPwSN4glZT3XOE
        Wnvs+KDUdMYbxvcfN6nWztObuUBEu2JKqEYBCa5xtePF3wGEDNIgvkrsgr6sikFLCmMcht2ETBdAT
        VFPoZ+cQ==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEIWn-0001NA-VI; Mon, 22 Feb 2021 21:14:02 +0000
Subject: Re: [PATCH] staging: rtl8192e: fix kconfig dependency on CRYPTO
To:     Julian Braha <julianbraha@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
References: <20210222180607.399753-1-julianbraha@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e220235-6ef6-dd49-8333-d32bc0cdcf8f@infradead.org>
Date:   Mon, 22 Feb 2021 13:13:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222180607.399753-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 10:06 AM, Julian Braha wrote:
> When RTLLIB_CRYPTO_TKIP is enabled and CRYPTO is disabled,
> Kbuild gives the following warning:
> 
> WARNING: unmet direct dependencies detected for CRYPTO_MICHAEL_MIC
>   Depends on [n]: CRYPTO [=n]
>   Selected by [m]:
>   - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
> 
> WARNING: unmet direct dependencies detected for CRYPTO_LIB_ARC4
>   Depends on [n]: CRYPTO [=n]
>   Selected by [m]:
>   - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
>   - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]
> 
> This is because RTLLIB_CRYPTO_TKIP selects CRYPTO_MICHAEL_MIC and
> CRYPTO_LIB_ARC4, without depending on or selecting CRYPTO,
> despite those config options being subordinate to CRYPTO.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/staging/rtl8192e/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
> index 03fcc23516fd..6e7d84ac06f5 100644
> --- a/drivers/staging/rtl8192e/Kconfig
> +++ b/drivers/staging/rtl8192e/Kconfig
> @@ -26,6 +26,7 @@ config RTLLIB_CRYPTO_CCMP
>  config RTLLIB_CRYPTO_TKIP
>  	tristate "Support for rtllib TKIP crypto"
>  	depends on RTLLIB
> +	select CRYPTO
>  	select CRYPTO_LIB_ARC4
>  	select CRYPTO_MICHAEL_MIC
>  	default y
> 


-- 
~Randy

