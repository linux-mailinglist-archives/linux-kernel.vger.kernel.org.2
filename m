Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4353F913E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhH0AKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 20:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhH0AKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 20:10:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 17:09:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id me10so9957621ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hPyVKVcprvpzIUu+YVAu3LI+boeAeXeZuimDXv2TyLE=;
        b=yjA7NUnjujxbObs4sjgZmfo7b3pB3prQMmeDhPe6kS3hWe4jZtMcLhlga3n4OwHmKY
         lrqfPK/ZZXzcNGmHBZWe5WjZWajT5kLw66WD70QFFbNk9YWFp89oZvUVOcFPwBwNjVKp
         AsrQW3Vxi0rAAa4Zg6nWVKh5wN/8A6xvIMKsWSUVle8r+Af9xTmiAVU4cQu8A4SH7K41
         +UNpTAAKLPXIspTHwZW8dDwXY3D2CyBAmJtlplnTkQBRAnFDUDkHy+5hMKr+FsgS7TnM
         bVBr0TW8StnIJZo6fWjK+Kzo4wh8NgP9fDMT5XoQW1psek9aASbN2Z8evdfZ6WEo58Vc
         QVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hPyVKVcprvpzIUu+YVAu3LI+boeAeXeZuimDXv2TyLE=;
        b=p9l989aohzPXfCwbsWbzWX5VSevsOtASfH5FD5yFOFkDqTH+q3v4tGldkFuVXp4WRp
         w6iQaIkgDeziW8uMK/AcPI6J9ixqJgfQT0hREIm4eJ/NB3X+PsFNs+EX0yYtCywsPKmq
         fZk0+gQ+uEEPripQFj72p8d9LZ/8E5wG3AHH/C5rAnzwNBMOyAdcwU8yVlbFXzTKNECo
         aPaNz/Trm7WTy1fPdHT+HiT913Xmucoe1dJ3ij0DEm7coRHwmPgHrxK0OkXMnpqc4WWr
         fTEBGC07OzzWGcm2kSBVlXSA7wudPWdW6t/PrVgUaUfmJ4D9/4SmmYl8w5CBNH68rYB9
         RKTg==
X-Gm-Message-State: AOAM53163xGrsJkrvJByKDIOE9aFvDNMvt1ATm2h/3NbGITn15d+A5eD
        rzXOrcYGJlml34xPp96eB+z2W7/akE3MqP9slZ25odboYGQm
X-Google-Smtp-Source: ABdhPJwj37BNpQ6K0Yr3ao3caRv4TnSn8rfrzD0un5ailDcKqR5gpapeV8Ivz7J6l4VarTYBoAuasYZH+DRCpniyOlE=
X-Received: by 2002:a17:907:a04d:: with SMTP id gz13mr6934484ejc.91.1630022965481;
 Thu, 26 Aug 2021 17:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com>
In-Reply-To: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Aug 2021 20:09:14 -0400
Message-ID: <CAHC9VhRJtU48Zt7dUEaTvKRoO+ODki75rS-hdJ0HPBrPRmCfxQ@mail.gmail.com>
Subject: Re: [PATCH] net: fix NULL pointer reference in cipso_v4_doi_free
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

On Wed, Aug 25, 2021 at 11:42 PM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba=
.com> wrote:
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
> on 'doi_def->map.std' when 'doi_def->type' equal 1, which
> is possibe, since netlbl_cipsov4_add_std() haven't initialize
> it before alloc 'doi_def->map.std'.
>
> This patch just add the check to prevent panic happen for similar
> cases.
>
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>
>  net/ipv4/cipso_ipv4.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Thanks for the problem report.  It's hard to say for certain due to
the abbreviated backtrace without line number information, but it
looks like the problem you are describing is happening when the
allocation for doi_def->map.std fails near the top of
netlbl_cipsov4_add_std() which causes the function to jump the
add_std_failure target which ends up calling cipso_v4_doi_free().

  doi_def =3D kmalloc(sizeof(*doi_def), GFP_KERNEL);
  if (doi_def =3D=3D NULL)
    return -ENOMEM;
  doi_def->map.std =3D kzalloc(sizeof(*doi_def->map.std), GFP_KERNEL);
  if (doi_def->map.std =3D=3D NULL) {
    ret_val =3D -ENOMEM;
    goto add_std_failure;
  }
  ...
  add_std_failure:
    cipso_v4_doi_free(doi_def);

Since the doi_def allocation is not zero'd out, it is possible that
the doi_def->type value could have a value of CIPSO_V4_MAP_TRANS when
the doi_def->map.std allocation fails, causing the NULL pointer deref
in cipso_v4_doi_free().  As this is the only case where we would see a
problem like this, I suggest a better solution would be to change the
if-block following the doi_def->map.std allocation to something like
this:

  doi_def->map.std =3D kzalloc(sizeof(*doi_def->map.std), GFP_KERNEL);
  if (doi_def->map.std =3D=3D NULL) {
    kfree(doi_def);
    return -ENOMEM;
  }

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 099259f..7fbd0b5 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -465,14 +465,16 @@ void cipso_v4_doi_free(struct cipso_v4_doi *doi_def=
)
>         if (!doi_def)
>                 return;
>
> -       switch (doi_def->type) {
> -       case CIPSO_V4_MAP_TRANS:
> -               kfree(doi_def->map.std->lvl.cipso);
> -               kfree(doi_def->map.std->lvl.local);
> -               kfree(doi_def->map.std->cat.cipso);
> -               kfree(doi_def->map.std->cat.local);
> -               kfree(doi_def->map.std);
> -               break;
> +       if (doi_def->map.std) {
> +               switch (doi_def->type) {
> +               case CIPSO_V4_MAP_TRANS:
> +                       kfree(doi_def->map.std->lvl.cipso);
> +                       kfree(doi_def->map.std->lvl.local);
> +                       kfree(doi_def->map.std->cat.cipso);
> +                       kfree(doi_def->map.std->cat.local);
> +                       kfree(doi_def->map.std);
> +                       break;
> +               }
>         }
>         kfree(doi_def);
>  }
> --
> 1.8.3.1
>


--=20
paul moore
www.paul-moore.com
