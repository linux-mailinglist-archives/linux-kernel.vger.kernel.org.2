Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9D3B97AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhGAUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbhGAUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:36:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CCC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 13:34:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a6so10269233ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMMTpunk2rCY31/itiEgvN4IOL4r5+Mqwa9/O4MKcGk=;
        b=iUtWrJWg8vB/1Z560py1lFcKOiE+AKpkTVqxbYO0senY7UUa+tTV30pIWsx6stA3B8
         HUSTPJC3htDuwxtdvw3HYctOIW3vxp53ItnI41pKocoqhJ2bxuz3GXfo9lK1Ka1h7zTO
         EdnrfRt8Gv74bxgHfm+CCZje+pihTV6ZYxCOhlgKkWVsa/amhVi26SaRNCEupQbbHcRf
         8s3aiOWCxUjzNUupHRPCmCy10jp/ZY+lYdC/y7tuZZm2ESWeaEXq5Y9zChAMiTHU15tE
         CQR5bJgG1n4HPp/HeyHnsRNLBi28aKqo0dhhyPmy3xbgcFZyCWPBk+eIuwNz5G90xWSe
         AGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMMTpunk2rCY31/itiEgvN4IOL4r5+Mqwa9/O4MKcGk=;
        b=D6gOA2ZmXFuYHfPgm4NGw13DsV+Dg+r51kkTndRZIT1OccUwblUBD1BkeBTbgzRSmA
         Z5J7aKWjC9cjXz3jrJh057WzOUQ8XtS45cztgHlQ+nPsmF0rdmNYeIlz2llGTEP5fSgD
         QEU3iVg+h64/uuiHIWskN/CpW52mmSWgfHuvXNWoVdWBcPZUxkdEFbzJXZXQjjsMl0uu
         2ZTIBcyZ2JY2i/JKq8Oiqku98XUtfLW9A+B4nVq/3yFMQ09CiI2FaTouZDaEuRKWJl1B
         jswGGp5MAlzs7p6/SUL96WXETZcxwbUPrLgNB/iwu6Va3QTQ/wG/EKfzt9QejKkHznUB
         zmyw==
X-Gm-Message-State: AOAM5337bfIDABW8HXrnmWQi7cFAi1gwRes+8SHSYkyvkdGSxffB+P6L
        deWSIax6yV7wNYFPCByVrkHvrdqbxAb3yOuMXddI7Q==
X-Google-Smtp-Source: ABdhPJwq8trRBKUDEGBZw1/PLvi4+9lccj2M21zGmy72qGV+weTWBPo4kUOoRMab4y9/E20e8wEFKIm19jzLq5gf7RE=
X-Received: by 2002:a05:651c:b12:: with SMTP id b18mr1060720ljr.260.1625171654416;
 Thu, 01 Jul 2021 13:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <f5dbb1ed01d13d4eac2b719db42cb02bf8166ceb.1625170569.git.christophe.jaillet@wanadoo.fr>
 <2a1bcfa7f84f63ab2076175c6a5c0a5a181d3bcb.1625170569.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <2a1bcfa7f84f63ab2076175c6a5c0a5a181d3bcb.1625170569.git.christophe.jaillet@wanadoo.fr>
From:   Catherine Sullivan <csully@google.com>
Date:   Thu, 1 Jul 2021 13:33:37 -0700
Message-ID: <CAH_-1qwt9qjUhrs0nkvu6cg+0K26XR1on2pHf0Q7jLc2V46U7A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] gve: Propagate error codes to caller
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sagi Shahar <sagis@google.com>, Jon Olson <jonolson@google.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        David Awogbemila <awogbemila@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Yangchun Fu <yangchun@google.com>,
        Bailey Forrest <bcf@google.com>, Kuo Zhao <kuozhao@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:18 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If 'gve_probe()' fails, we should propagate the error code, instead of
> hard coding a -ENXIO value.
> Make sure that all error handling paths set a correct value for 'err'.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Catherine Sullivan <csully@google.com>

> ---
> v2: Unchanged
>     The previous serie had 3 patches. Now their are only 2
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 44262c9f9ec2..c03984b26db4 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1469,7 +1469,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>         err = pci_enable_device(pdev);
>         if (err)
> -               return -ENXIO;
> +               return err;
>
>         err = pci_request_regions(pdev, "gvnic-cfg");
>         if (err)
> @@ -1512,6 +1512,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         dev = alloc_etherdev_mqs(sizeof(*priv), max_tx_queues, max_rx_queues);
>         if (!dev) {
>                 dev_err(&pdev->dev, "could not allocate netdev\n");
> +               err = -ENOMEM;
>                 goto abort_with_db_bar;
>         }
>         SET_NETDEV_DEV(dev, &pdev->dev);
> @@ -1593,7 +1594,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>  abort_with_enabled:
>         pci_disable_device(pdev);
> -       return -ENXIO;
> +       return err;
>  }
>
>  static void gve_remove(struct pci_dev *pdev)
> --
> 2.30.2
>

Thanks for the fix!
