Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0323930FC7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhBDTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbhBDTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:18:48 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693FEC061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:18:05 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y4so4257993ybk.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1JzSELb4pc4aQnnwI2bcbtcLQTicwP2YL8nGY3wKCA=;
        b=efKrSjioXHaXuLl4l8z7BVxglWGws/GBLX7rdNZe6QAjb6O241+JhlAD9koy7qNr8V
         8ST3l75Cp0NvedUNDZUZ6Yp+7dZbXAOs7RMdHs1a6XvfdHX31D6MrM2tZKMOsE9ON0f4
         3XV5Wwkl8vfFXtnDvDX0puRN8aTTbIyAyXN08qRpQWeitloQcQMa9EaD4zyE/SlpLgrQ
         2W6Z4Hk3Numq2+uir5rTYfiO8p8mDuoTxLR8v5BATxJw0ADTIwkmvFrYjB4tBwOGcImQ
         GfyquAAEn+FvpLkOfRRv6Zuz9pj7vV7m53iMNGKPUmk7xysc3gbYjodEBpwMNOl2cl1W
         CKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1JzSELb4pc4aQnnwI2bcbtcLQTicwP2YL8nGY3wKCA=;
        b=miKUnyKAodM2Xwi8FKzHvN4Brg+oaD2gt1AK7rBrZed0nxMeLNA+adIeJCCnivxfgC
         d9Ul9gfmRCLNQsqpuhfFiCsAeFsSjipPyxbzgGfYeAHV9XzALeguUHmVCiHfSJdzJjAz
         oB1Vh6406zRUps2HxZITAGJ3Wd4KLfFumISgNx8W7JS4+jAV5ScBmem/c/LD/Pyp81Pu
         LcQTU33eJbPyKSSV/uv9FXwjACMdhOzd7BDu4otwmuiAxKUkqcu+Glt06LvWMu3eUOm7
         2jotYKRn2SXiEMuc8yMeTbMWaEWQw+rTEaa/Qfp3i64eeaenex4N2A44rd27NbD5Q5uI
         CIgA==
X-Gm-Message-State: AOAM5303chq3bSihhQr/HA+NqC8dDQGblcbuAXGSX7T6Gy8BC8iiH9Z3
        ISvJUk/di/PxEzbi9fT9s5W9MYzrJIWqDXif+bGRBw==
X-Google-Smtp-Source: ABdhPJwlhb6alK+UFA4q6j/4796x+229EtmwiRPdj4AriY85G89neLwTo3eHgw3OuwSf6JrAYBoLNelnQZ9weCeg8as=
X-Received: by 2002:a25:718b:: with SMTP id m133mr1229246ybc.412.1612466283803;
 Thu, 04 Feb 2021 11:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com> <20210202043345.3778765-4-saravanak@google.com>
In-Reply-To: <20210202043345.3778765-4-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 Feb 2021 11:17:27 -0800
Message-ID: <CAGETcx8H8axt7r=qrqauJCAuOmg5puR0Bp595yxh1CksjAkNeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] of: property: Don't add links to absent suppliers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 8:33 PM Saravana Kannan <saravanak@google.com> wrote:
>
> If driver core marks a firmware node as not a device, don't add fwnode
> links where it's a supplier.
>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6287c6d60bb7..53d163c8d39b 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1103,7 +1103,9 @@ static int of_link_to_phandle(struct device_node *con_np,
>          * created for them.
>          */
>         sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> -       if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
> +       if (!sup_dev &&
> +           (of_node_check_flag(sup_np, OF_POPULATED) ||
> +            sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
>                 pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
>                          con_np, sup_np);
>                 of_node_put(sup_np);
> --
> 2.30.0.365.g02bc693789-goog
>

Rob, Can I get an Ack or reviewed-by for this? I want to land this
patch and another one on driver-core.

Thanks,
Saravana
