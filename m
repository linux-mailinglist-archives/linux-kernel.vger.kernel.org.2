Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5463E9B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhHKXy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHKXy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:54:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367CCC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:54:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nt11so6319088pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BfnxJUIum/GqIyPdmVGfVe7SAmeaJmks+RumyxR/fU=;
        b=OP56ebMQGRpCRrLw6NB7S6hJH3uBzWIouq8V4aMAtLkW0MY8hcMq/gabH0fRTE+xt/
         /Yzj3ItRP61oCAgQSdADawbhoVPjfd0w8ykOvnh49KAg2m7/mRoFt102fRsnbIv/py7B
         vXO9KybQ8MRK3Vv+p74C0oqqVNm9Ri1FP9vqdrkxcUo+BR1pyxwlIv8quGcLyXiPC+Aq
         EO/GG/MiJyynilp2C/TmmHOL4sOBC7ogOX4sM6hWflqqtknwwZhftHspc6u9/Xe6qUEJ
         ic+GrrM2tr5nBzlrAGFDxYzB3IisJXem1AnOeQmy1AfAQ0ashKb4KglbeUA2on7dR1CE
         o7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BfnxJUIum/GqIyPdmVGfVe7SAmeaJmks+RumyxR/fU=;
        b=C490vznGYHDbir+nNpCpBTAPfu3QYRGvAL229dQPzFV21AKzDnOBo4Kbud3AruHQ1w
         Li/xULbhaJ3LieqSZ2a+5pG9AjA7D/N5a2d2omRndDU3FgZZU1Dg9kNLgy20RM6GJS8U
         hZYqHwh1RvwYremEu4OxNTuqtyzyHxk3IAl+QyEKXZ/phVUPgbG2sgM1jR0LSbslACcz
         dKbKxokIoHCTtTm8V1i3ZUWmujTOpiNuAM03mYa0rI4U/APRVQnaFu5lv/FYVNp+iYbL
         cyMeH3PtGVE2ptpGE/tbWzLe2h2eLwfy4zG3xkShhJyq0Nwf6y0R6Jm4AzrufPlsiY+v
         O1oA==
X-Gm-Message-State: AOAM533UwA/zc2y3o03SbK05RjhcLvjCDbYLusfUM68hY/bOPGv2uc3P
        KbHE5GTODPloibvcUJkzfpo7WUnKH7ygDRMaSSVKmg==
X-Google-Smtp-Source: ABdhPJwMQgiLfKy68hyqHxu0Tp/geWrxhjyw/YdEhxhmUx6bbRQrT0xaDP+FkFn+yryA8X6HO7hDsZQJl/65jow/7sw=
X-Received: by 2002:a17:902:ac87:b029:12d:3e59:cb7d with SMTP id
 h7-20020a170902ac87b029012d3e59cb7dmr1256113plr.22.1628726041809; Wed, 11 Aug
 2021 16:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210811201450.31366-1-martin@kaiser.cx> <20210811201450.31366-4-martin@kaiser.cx>
In-Reply-To: <20210811201450.31366-4-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 00:53:51 +0100
Message-ID: <CAA=Fs0nmM4EKX7x0ZrHJrsE9KJ50sBW6ROXkY=djryG-6TKJZg@mail.gmail.com>
Subject: Re: [PATCH 4/5] staging: r8188eu: use proper way to build a module
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:15, Martin Kaiser <martin@kaiser.cx> wrote:
>
> It seems that for now, we can only build this driver as a module.
>
> Use the same mechanism as other drivers (such as rtl8723bs or the
> deprecated rtl8188eu) to enforce building as a module, i.e. depend on m
> in Kconfig instead of setting CONFIG_R8188EU = m in the Makefile.
>
> If we set CONFIG_R8188EU in the Makefile, this setting will not be visible
> in .config.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/Kconfig  | 1 +
>  drivers/staging/r8188eu/Makefile | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/Kconfig b/drivers/staging/r8188eu/Kconfig
> index 6323d63a4a1b..dc1719d3f2e4 100644
> --- a/drivers/staging/r8188eu/Kconfig
> +++ b/drivers/staging/r8188eu/Kconfig
> @@ -2,6 +2,7 @@
>  config R8188EU
>         tristate "Realtek RTL8188EU Wireless LAN NIC driver"
>         depends on WLAN && USB && CFG80211
> +       depends on m
>         select WIRELESS_EXT
>         select WEXT_PRIV
>         select LIB80211
> diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
> index 7f6658f931d1..cca7a58c5f29 100644
> --- a/drivers/staging/r8188eu/Makefile
> +++ b/drivers/staging/r8188eu/Makefile
> @@ -4,8 +4,6 @@ EXTRA_CFLAGS += -O1
>
>  ccflags-y += -D__CHECK_ENDIAN__
>
> -CONFIG_R8188EU = m
> -
>  CONFIG_USB_HCI = y
>
>  CONFIG_BT_COEXIST = n
> --
> 2.20.1
>

Dear Martin,

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
