Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0942BFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhJMM2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhJMM2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:28:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2138A610C8;
        Wed, 13 Oct 2021 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634127993;
        bh=2fq6zyYLD+W6dU0Wn2WXwU+KmGA4y3AuDF93YE5DFww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R45cB/hxFwHK2zjDvx34BSH21obPkrwh03BP8PwhTvV2f0onhVE2O3vSb3/OJvrS/
         YY0wf2ueBt0keXWnXy/ryyQtN+ZEVBptuucVVwLgL4TZ5cuOsnOo3IZUVEKKHVRbVn
         D0oKfVxyiVBxzx3z9vhUjZ7l1z6z3dxzcfnTyjzg=
Date:   Wed, 13 Oct 2021 14:26:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: select CRYPTO_HASH/CRYPTO_MICHAEL_MIC
Message-ID: <YWbQd51r8R3BprMi@kroah.com>
References: <20211011152941.12847-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011152941.12847-1-vegard.nossum@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 05:29:41PM +0200, Vegard Nossum wrote:
> Fix the following build/link errors:
> 
>   ld: drivers/staging/ks7010/ks_hostif.o: in function `michael_mic.constprop.0':
>   ks_hostif.c:(.text+0x95b): undefined reference to `crypto_alloc_shash'
>   ld: ks_hostif.c:(.text+0x97a): undefined reference to `crypto_shash_setkey'
>   ld: ks_hostif.c:(.text+0xa13): undefined reference to `crypto_shash_update'
>   ld: ks_hostif.c:(.text+0xa28): undefined reference to `crypto_shash_update'
>   ld: ks_hostif.c:(.text+0xa48): undefined reference to `crypto_shash_finup'
>   ld: ks_hostif.c:(.text+0xa6d): undefined reference to `crypto_destroy_tfm'
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  drivers/staging/ks7010/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/ks7010/Kconfig b/drivers/staging/ks7010/Kconfig
> index 0987fdc2f70db..8ea6c09286798 100644
> --- a/drivers/staging/ks7010/Kconfig
> +++ b/drivers/staging/ks7010/Kconfig
> @@ -5,6 +5,9 @@ config KS7010
>  	select WIRELESS_EXT
>  	select WEXT_PRIV
>  	select FW_LOADER
> +	select CRYPTO
> +	select CRYPTO_HASH
> +	select CRYPTO_MICHAEL_MIC

Let's try to rely on 'depend' and not 'select' please.

thanks,

greg k-h
