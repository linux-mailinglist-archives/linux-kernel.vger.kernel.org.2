Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD284067B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhIJHcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhIJHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:31:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:30:35 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mOazU-0007me-BA; Fri, 10 Sep 2021 09:30:28 +0200
Date:   Fri, 10 Sep 2021 09:30:28 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused macro ROUND
Message-ID: <20210910073028.7p64fv4fxnpixwnx@viti.kaiser.cx>
References: <20210909202130.28508-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909202130.28508-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The macro ROUND is not used in the driver, remove it.
> Found with GCC -Wunused-macros.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_security.c | 13 -------------
>  1 file changed, 13 deletions(-)

> diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
> index 82987255400a..db35f326bbb1 100644
> --- a/drivers/staging/r8188eu/core/rtw_security.c
> +++ b/drivers/staging/r8188eu/core/rtw_security.c
> @@ -1555,16 +1555,3 @@ const u8 rcons[] = {
>  	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1B, 0x36
>  	/* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
>  };
> -
> -/**
> - * Expand the cipher key into the encryption key schedule.
> - *
> - * @return	the number of rounds for the given cipher key size.
> - */
> -#define ROUND(i, d, s) \
> -do {									\
> -	d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
> -	d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
> -	d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
> -	d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]; \
> -} while (0);
> -- 
> 2.33.0

I noticed this as well when a W=1 build brought up a warning about the
/** comment.

Acked-by: Martin Kaiser <martin@kaiser.cx>
