Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE62D41676E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbhIWVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbhIWVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:25:47 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651BCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:24:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i84so1273869ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NFD50f4D8OM/NybzmgBINAYXaCydfgGt6oGYeUyWVM=;
        b=a01KcFjfZE09aHK//1COGS+XgNwDx2f7ZNE1rGu2p5KFmmN7BH3qDdeknK+KiHCmF8
         l8FgeRboJYMsUN2OmKIWF9+qycX0wTwfirMsltIADGBAYuiRn8JvgxQiJCksG6iyd6NC
         7VNJFgLAbEll/y3DRc7wUIlZ9cWX089qCdBZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NFD50f4D8OM/NybzmgBINAYXaCydfgGt6oGYeUyWVM=;
        b=nLac9MctdlXNEe0i3Bf1MNdf6OFAUiw40lQA1MzJwKIV04cTTbTYISGwJL+xAMbX71
         P8/dM7oanwMi46M1LZQpMVzYMEIzGuTjgZJzrVOTyQPVS6usyR5J39qdp7dHOy3ELxRV
         2XDObXPHuSMt51ZpR3G3FBHv6Q1LWp3vV3T6Nb4g0NfIG7ttZV9vHLEVtY9fgtB4dEHy
         +MYubYEBk2vb9r2Szy9ofjimE+HKH1QtyyHxCVVT4WcHM5tE1yHbdXxchj+zkNjMPz+i
         YSbq4xLu9h62+QKCxvOfXpJMzOXTK1msiJh7jfdliLF6xN/Ka/mINqOb5azB6XA58NuN
         aDcA==
X-Gm-Message-State: AOAM53052BttzopuFNkHX4UyilK9C6wnsDXgn9Apq0bkt8RFU8EgXnxr
        XeCR7gITdQ1pEAg8NaTfW7TSEbHhd/CTNWi87IySTQ==
X-Google-Smtp-Source: ABdhPJyZItCG+2qGFbPGCky+CLR7O1xm1lchqIXJehrltvrT3SdTl4WvTGugSEg3MJCKJkRphhP5e6yaOzEESqTdIa0=
X-Received: by 2002:a25:81c5:: with SMTP id n5mr8514500ybm.276.1632432254531;
 Thu, 23 Sep 2021 14:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632420430.git.leonro@nvidia.com> <7b85ce0d2a5056af2c7e14dbd16c55d86aac659c.1632420431.git.leonro@nvidia.com>
In-Reply-To: <7b85ce0d2a5056af2c7e14dbd16c55d86aac659c.1632420431.git.leonro@nvidia.com>
From:   Edwin Peer <edwin.peer@broadcom.com>
Date:   Thu, 23 Sep 2021 14:23:38 -0700
Message-ID: <CAKOOJTzz1Pp9CYCWAO=gi3099xy2oBtdREp8iOftVzKqEC0hvQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] bnxt_en: Properly remove port parameter support
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com,
        Igor Russkikh <irusskikh@marvell.com>,
        intel-wired-lan@lists.osuosl.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Javed Hasan <jhasan@marvell.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Sathya Perla <sathya.perla@broadcom.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:13 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> This driver doesn't have any port parameters and registers
> devlink port parameters with empty table. Remove the useless
> calls to devlink_port_params_register and _unregister.
>
> Fixes: da203dfa89ce ("Revert "devlink: Add a generic wake_on_lan port parameter"")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> index dc0851f709f5..ed95e28d60ef 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> @@ -736,9 +736,6 @@ static const struct devlink_param bnxt_dl_params[] = {
>                              NULL),
>  };
>
> -static const struct devlink_param bnxt_dl_port_params[] = {
> -};
> -
>  static int bnxt_dl_params_register(struct bnxt *bp)
>  {
>         int rc;
> @@ -753,14 +750,6 @@ static int bnxt_dl_params_register(struct bnxt *bp)
>                             rc);
>                 return rc;
>         }
> -       rc = devlink_port_params_register(&bp->dl_port, bnxt_dl_port_params,
> -                                         ARRAY_SIZE(bnxt_dl_port_params));
> -       if (rc) {
> -               netdev_err(bp->dev, "devlink_port_params_register failed\n");
> -               devlink_params_unregister(bp->dl, bnxt_dl_params,
> -                                         ARRAY_SIZE(bnxt_dl_params));
> -               return rc;
> -       }
>         devlink_params_publish(bp->dl);
>
>         return 0;
> @@ -773,8 +762,6 @@ static void bnxt_dl_params_unregister(struct bnxt *bp)
>
>         devlink_params_unregister(bp->dl, bnxt_dl_params,
>                                   ARRAY_SIZE(bnxt_dl_params));
> -       devlink_port_params_unregister(&bp->dl_port, bnxt_dl_port_params,
> -                                      ARRAY_SIZE(bnxt_dl_port_params));
>  }
>
>  int bnxt_dl_register(struct bnxt *bp)
> --
> 2.31.1
>

Ah, looks like the revert in da203dfa89ce wasn't complete. Thanks for
the cleanup.

Reviewed-by: Edwin Peer <edwin.peer@broadcom.com>

Regards,
Edwin Peer
