Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C93AD2CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhFRTcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFRTcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:32:05 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C13C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:29:55 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luKB2-009jVk-HT; Fri, 18 Jun 2021 19:29:16 +0000
Date:   Fri, 18 Jun 2021 19:29:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rtw_security: fix cast to restricted __le32
Message-ID: <YMz0DH0+v39xsCYU@zeniv-ca.linux.org.uk>
References: <YMeL7PjstV601pbN@zeniv-ca.linux.org.uk>
 <20210618181751.95967-1-fbihjmeric@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618181751.95967-1-fbihjmeric@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2021 at 02:17:51AM +0800, Jhih-Ming Huang wrote:
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> There was a change for replacing private CRC-32 routines with in kernel
> ones.
> However, the author used le32_to_cpu to convert crc32_le(), and we
> should cpu_to_le32.
> 
> Ths commit also fixes the payload checking by memcmp instead of checking element
> by element.
> 
> Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439328f1..97a7485f8f58 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		arc4_crypt(ctx, payload, payload,  length);
>  
>  		/* calculate icv and compare the icv */
> -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +		*crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));

Huh?  crc is u8[4]; that assignment will truncate that le32 to u8 and store it in
the first byte of your 4-element array.  How the hell does sparse *not* complain
on that?

Either make crc __le32 (and turn assignment into crc = cpu_to_le32(...)), or
make that *(__le32 *)crc = ...

> @@ -618,10 +618,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  			arc4_setkey(ctx, rc4key, 16);
>  			arc4_crypt(ctx, payload, payload, length);
>  
> -			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> +			*crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));

Ditto.  Declare crc as __le32 and use
			crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
here.
