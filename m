Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6312429391
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhJKPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243701AbhJKPjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B54F60C49;
        Mon, 11 Oct 2021 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633966634;
        bh=FYqUw2kqkpM1DyrtfaYbrUz43GROjaDL9qhLZeZKSHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnEwP3jXLhW/kkBdFK240IKzVDBWwrB2McxnaSed+2Q7aZcTB1gefyv+On5HW7XpK
         +C7MON9sKw+5Rsw9mIROp1BMU6c8cnUKxTman4S83uX8tU/IYRARhfHz6Ot3XMnUYh
         5ZcvTV+sket4R6EyIIXIbP5gPwtSNLFrQXYi78C8=
Date:   Mon, 11 Oct 2021 17:37:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: select CRYPTO_HASH/CRYPTO_MICHAEL_MIC
Message-ID: <YWRaJfSqKsTqsRdr@kroah.com>
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

What commit caused these issues?

thanks,

greg k-h
