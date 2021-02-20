Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2522332044A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 08:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBTHDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 02:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhBTHDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 02:03:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C7864EB8;
        Sat, 20 Feb 2021 07:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613804546;
        bh=Pvh5cvdWKO1LNmyetgVB1YyxbpJdDKcFN/Tg6OGL7+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmEaiT3r/F6fl71Sc7Hqap7ot1RTVLGh1ddbcZ03dVUXbg2yw6DhnQBAHtzdwzKWj
         pHRHxHJohqqkFnsAIOWK9oMMCXUueYM39jYhs4pl/B4sEXMJv7MSYaC8g9u+IYNBPW
         ep4njqFYZg12q0E39j6RthsylaOujRIHSjUewA2E=
Date:   Sat, 20 Feb 2021 08:02:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192e: fix kconfig dependency on CRYPTO
Message-ID: <YDCz/6gQgp07NGw2@kroah.com>
References: <8483722.hVsnvgcxvV@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8483722.hVsnvgcxvV@ubuntu-mate-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:14:57PM -0500, Julian Braha wrote:
> commit 1a3f343027d7f5a6475a019aa20be89795b8c8e0
> Author: Julian Braha <julianbraha@gmail.com>
> Date:   Fri Feb 19 17:02:24 2021 -0500
> 
>     staging: rtl8192e: fix kconfig dependency on CRYPTO
>     
>     When RTLLIB_CRYPTO_TKIP is enabled and CRYPTO is disabled,
>     Kbuild gives the following warning:
>     
>     WARNING: unmet direct dependencies detected for CRYPTO_MICHAEL_MIC
>       Depends on [n]: CRYPTO [=n]
>       Selected by [m]:
>       - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
>     
>     WARNING: unmet direct dependencies detected for CRYPTO_LIB_ARC4
>       Depends on [n]: CRYPTO [=n]
>       Selected by [m]:
>       - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
>       - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]
>     
>     This is because RTLLIB_CRYPTO_TKIP selects CRYPTO_MICHAEL_MIC and CRYPTO_LIB_ARC4,
>     without depending on or selecting CRYPTO, despite those config options
>     being subordinate to CRYPTO.
>     
>     Signed-off-by: Julian Braha <julianbraha@gmail.com>
> 
> diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
> index 03fcc23516fd..6e7d84ac06f5 100644
> --- a/drivers/staging/rtl8192e/Kconfig
> +++ b/drivers/staging/rtl8192e/Kconfig
> @@ -26,6 +26,7 @@ config RTLLIB_CRYPTO_CCMP
>  config RTLLIB_CRYPTO_TKIP
>         tristate "Support for rtllib TKIP crypto"
>         depends on RTLLIB
> +      select CRYPTO
>         select CRYPTO_LIB_ARC4
>         select CRYPTO_MICHAEL_MIC
>         default y

Odd indentation :(

