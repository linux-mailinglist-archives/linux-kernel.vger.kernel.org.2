Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683883A57AF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhFMK3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231722AbhFMK3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58621611CC;
        Sun, 13 Jun 2021 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623580021;
        bh=jMfZUmtHh0e5AoMiIZXNSQV+E64D4H3MFVmGjvyGQ6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0kZVZPBdgNfuHs2ccce98GakQqil2D8h+K4Ov6U3jL90RKMphQES/XRll+30PFFS
         70z/K85gm/KXikMP14PtkBH6y0SPmNhl760/lsJf4PkMDExT5lzslLvBtwCr/rwi4a
         3rWhG36f/R7yes0sqTBzSvj8Bg6xkxg4hZPWHaeg=
Date:   Sun, 13 Jun 2021 12:26:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        maqianga@uniontech.com, marcocesati@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtw_security: fix cast to restricted __le32
Message-ID: <YMXdc/UtkcVOlZ70@kroah.com>
References: <20210613102229.1424495-1-fbihjmeric@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613102229.1424495-1-fbihjmeric@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 06:22:29PM +0800, Jhih-Ming Huang wrote:
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439328f1..2f4da67e31c6 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		arc4_crypt(ctx, payload, payload,  length);
>  
>  		/* calculate icv and compare the icv */
> -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +		*((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload, length - 4));

When you use __force, that usually implies something is wrong here.

Look at the recent changes that were just submitted for this a week or
so ago in the mailing list archives, and the discussion about them, to
see the issues involved here.

I would need to see a _LOT_ of description in the changelog about why
these changes are actually correct, before I can take them.

thanks,

greg k-h
