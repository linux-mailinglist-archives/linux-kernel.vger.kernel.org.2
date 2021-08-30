Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06863FB7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhH3OSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbhH3OSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:18:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:17:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so21887453edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PhLhEsUAzqUuFfsscW0DyI/J5DCKBefy3mdhQUbyDaE=;
        b=hFbYrNf1BGA7EbIY3/fCL9Gwx/Ffing14F//0+cYUzQSxvcwICcE7Rag0RErTv4j8x
         q9/o2+bxiLl2n+HRA4/4O1H5rf+/a6V8NEMdoZBWeAE4L2jGfyOW33In6wKXESBD2ugj
         VmnL/1Vwt88n+e0TK7fAlDd5mbzFDA9uc/GzempJs4v38wM0X4ntS7estZIVPC6H/DXH
         V2z54eIRpliokdLYaqoir0M5ElAzRT598ozmmzG5Jjjw5SxnYxPpgIxITb8LP7AY3i/z
         OAebGDHmhn3dch+Kl8AazkXAXXlLyYpwg2jy2CtTeqHvR8FSaVHeA8On6he08wk+xAos
         7XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PhLhEsUAzqUuFfsscW0DyI/J5DCKBefy3mdhQUbyDaE=;
        b=RU20r8vG7BgTB45yMp0wakE0yZ9d3HSgoyvAZXmM+VOF34zg1bqbN9IjOOnLJrkT+I
         p0Ayj0DBcXtGE72xOIsp84II7829Hcr4ag1B8EiDQ19wB0p7tPXCGnBP+pRTm6xv5jRp
         5ZKmmebJYaeB+mhsNSvi9zF5sSydKePbBqAa5Mtyi1F1b9tsi9R/hHUOSYeOao7Fhfkr
         BsS/uKb89exZvgsQI+9bUpoNNW4WBB1SwJtGL4Zu/+qNTJKZ9+5hoFuZhgbrtzUsce8e
         U8i9AAn6BT26i9s6qnggSTCcIX2knUxPNL9+AycTe3iN8zZU+86vr5S/nZ36VbQkCYVV
         9mlQ==
X-Gm-Message-State: AOAM5308lGc4xvUR+qKMS5BDISAuRezXlIujRpMDa5PuXv5BQsggsa+8
        0+AU6ZJLjk5JurIHanWR8nJI3DAJTrQ3TW9cYvqg
X-Google-Smtp-Source: ABdhPJz3FfrmGcwM4/D9ULldGgAIwmlxACn09R0XQcGjmp55gorvp0R5dA9e1PjiKQW+a0+PR6TSBRaUxTeBzYdN+TE=
X-Received: by 2002:aa7:d9d2:: with SMTP id v18mr24947247eds.128.1630333036601;
 Mon, 30 Aug 2021 07:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com> <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com>
In-Reply-To: <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 10:17:05 -0400
Message-ID: <CAHC9VhTEs9E+ZeGGp96NnOhmr-6MZLXf6ckHeG8w5jh3AfgKiQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: fix NULL pointer reference in cipso_v4_doi_free
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 6:28 AM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.=
com> wrote:
>
> In netlbl_cipsov4_add_std() when 'doi_def->map.std' alloc
> failed, we sometime observe panic:
>
>   BUG: kernel NULL pointer dereference, address:
>   ...
>   RIP: 0010:cipso_v4_doi_free+0x3a/0x80
>   ...
>   Call Trace:
>    netlbl_cipsov4_add_std+0xf4/0x8c0
>    netlbl_cipsov4_add+0x13f/0x1b0
>    genl_family_rcv_msg_doit.isra.15+0x132/0x170
>    genl_rcv_msg+0x125/0x240
>
> This is because in cipso_v4_doi_free() there is no check
> on 'doi_def->map.std' when doi_def->type got value 1, which
> is possibe, since netlbl_cipsov4_add_std() haven't initialize
> it before alloc 'doi_def->map.std'.
>
> This patch just add the check to prevent panic happen in similar
> cases.
>
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  net/netlabel/netlabel_cipso_v4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I see this was already merged, but it looks good to me, thanks for
making those changes.

> diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cip=
so_v4.c
> index baf2357..344c228 100644
> --- a/net/netlabel/netlabel_cipso_v4.c
> +++ b/net/netlabel/netlabel_cipso_v4.c
> @@ -144,8 +144,8 @@ static int netlbl_cipsov4_add_std(struct genl_info *i=
nfo,
>                 return -ENOMEM;
>         doi_def->map.std =3D kzalloc(sizeof(*doi_def->map.std), GFP_KERNE=
L);
>         if (doi_def->map.std =3D=3D NULL) {
> -               ret_val =3D -ENOMEM;
> -               goto add_std_failure;
> +               kfree(doi_def);
> +               return -ENOMEM;
>         }
>         doi_def->type =3D CIPSO_V4_MAP_TRANS;
>
> --
> 1.8.3.1

--=20
paul moore
www.paul-moore.com
