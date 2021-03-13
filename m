Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C833A149
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhCMVGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhCMVGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:06:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB0956023B;
        Sat, 13 Mar 2021 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615669575;
        bh=nRkSD/5xR/33lcZ5c96XTS8hH4AJvo2B8m0TCEbKLa4=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=NJKH2DPZO+fLZ7vPSbtkBMo8ikLa53XiSbjbwUZGB494dxy4HieYT8JLNUsq9oS3c
         fTpo2X1xVaQwMfAkuWN43AvQ3CU+Z4joKjraM7PgdCvuZ6jh0oaf1txE9kCXQsKXNr
         BBFBR9HAhamFC+VacbmJJrBL0J8ydIWpKXNUvwnH/oXy6MsSqOxaq6sKGzPw3NU6Av
         F+urtyPdwCV91bLSshyrP4n/XSFe817cjGWejrucR45T5hLF3McoobEhH6zj7tcp87
         PrMrnI1KyZYGBOGin1zRmROVE1eSbYGSia48kB5BvnediTZQBc1NV2HTsOfcL2rjSe
         IM11DmgDIrOKA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210313034112.eqa7zxtes2ruklqj@pallavi>
References: <20210313034112.eqa7zxtes2ruklqj@pallavi>
Subject: Re: [PATCH] clk: clk.c: Fixed statics initialized to 0
From:   Stephen Boyd <sboyd@kernel.org>
To:     Pallavi Prabhu <rpallaviprabhu@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Date:   Sat, 13 Mar 2021 13:06:14 -0800
Message-ID: <161566957437.1478170.3351022111021245800@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pallavi Prabhu (2021-03-12 19:41:12)
> Uninitialized static variable from 0, as statics get auto-initialized to =
0 during execution.
> Signed-off-by: Pallavi Prabhu <rpallaviprabhu@gmail.com>

Need a newline between signed-off-by line and commit text. Also please
wrap the commit text at 80 or 78 characters or so.

> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 5052541a0986..763ad2c960bd 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2931,7 +2931,7 @@ EXPORT_SYMBOL_GPL(clk_is_match);
>  #include <linux/debugfs.h>
> =20
>  static struct dentry *rootdir;
> -static int inited =3D 0;
> +static int inited;

I think it's being explicit; although it is the same. Is this noticed by
some static checker or something? I'd like to ignore this patch if
possible.

>  static DEFINE_MUTEX(clk_debug_lock);
>  static HLIST_HEAD(clk_debug_list);
>
