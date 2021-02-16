Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC5431C7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBPJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhBPJKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:10:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FDC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:09:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id b21so5836165pgk.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpjgJuNjtKtWA761imwPHlmI/2f8QxBoEjVaErSVOF4=;
        b=o0eQ1LM3Qv4IQRjWy6f2MWrt6Re8OIwZFunhQ8HjlkJfcs8mugA0E9sqKbDC0fHNei
         vanXa+gvBPqfKCKVRUHTGuOwPvXB/+2hawc3t1k+d24VLLhtz+xhFo/zSXfxDmgJIDNp
         n+wZbvBxnXLFBvpxsoAye3dSP+zUgQmEAexKRtUrtfalSIxGsCrg6nZk8vTWc0n1YPbc
         Ntjr0OJc6bYKqb7GgtKFjldjfZYUp7QQj5wg1KocQLXXYGzPwXOZBfpR4lLVGepNlHIh
         wyUQDEi2DM4CzSBCkQLWM/eyAh/wy/vIrDFZNH2qTUyiScsCPdN89RxTbeMfqfN+6UmV
         fxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpjgJuNjtKtWA761imwPHlmI/2f8QxBoEjVaErSVOF4=;
        b=fWsyBDDPTGCzjqGau9H3XMnK97w7qoN4U82YpwqQpnKxyHY06IUxtcGrnxM3ZQwPB2
         x0Q3aRLboJT1aOma0at4GrnRRXi97qU2p3adY3mtyrx6xQfqZ3xJELnhsdZFh4KT2UZV
         GHx04R+P6CWMNmfWTdJmxKq5kbrvGNSnv3G+FvOgXx8Ioe6Iy23/4DJ8OQOmsYiASf2h
         qYBQrSbEIuyFfiJwyAbM9OMAP1qNcUABdJJleTnzkY9SiAjYVHHYWZBQwzu1rrhsN8tO
         KA/jstwTP/59X49B29LT5wT9Nei/ado2EuhDEPV89p/UIskMTkF7Czhq4nNM8ccT9uzg
         GWuQ==
X-Gm-Message-State: AOAM531tI/Pjf/upEl/2u/Ft/jGaAoBJ+PxtcEPfc2nqXdbvT5nFAgxw
        LCOR7WhIvFlyy4P+erDxjADKS3vIrDLstFxyagPvq7AsTuymWcNgSwk=
X-Google-Smtp-Source: ABdhPJwXrvmtXDcEVq1uSnFQgtJ7DognUvtEq53YOKvW7L0RrWC13XTeeNe8QuwyQdkgeEdWtMMSW3QQ6UwM8dfMP5c=
X-Received: by 2002:a65:5ac9:: with SMTP id d9mr18258982pgt.74.1613466570006;
 Tue, 16 Feb 2021 01:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20210216072334.7575-1-jbe@pengutronix.de> <20210216072334.7575-2-jbe@pengutronix.de>
In-Reply-To: <20210216072334.7575-2-jbe@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Feb 2021 11:09:13 +0200
Message-ID: <CAHp75Vcha++UUE6hw0n_pBnA24q_uJQekABSSktmjCoinfpSoA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: ubifs: set s_uuid in super block to support
 ima/evm uuid options
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 9:24 AM Juergen Borleis <jbe@pengutronix.de> wrote:
>
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> This is required to provide uuid based integrity functionality for:
> ima_policy (fsuuid option) and the 'evmctl' command ('--uuid' option).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
One issue below has to be addressed nevertheless.

> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Co-developed-by: Juergen Borleis <jbe@pengutronix.de>

According to the documentation [1] above has two issues:
- all Co-developed-by *must* be accompanied with corresponding SoBs
- commiter must provide his SoB (but it will be implied by the
previous requirement in this case)

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  fs/ubifs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 138b9426c6c1..a8383ca39a47 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -2230,6 +2230,8 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
>                 goto out_umount;
>         }
>
> +       import_uuid(&sb->s_uuid, c->uuid);
> +
>         mutex_unlock(&c->umount_mutex);
>         return 0;
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
