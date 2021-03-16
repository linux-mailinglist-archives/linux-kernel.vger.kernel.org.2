Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926FF33D133
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhCPJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhCPJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:54:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E447C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:54:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lr13so71115444ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtBnu91CX1ydlA23BUG5vY5e6nzQMbllcbsRH3s8rU8=;
        b=f9GM2rEELlpHfBPcMIBf6Acvdrvn5MkI3zIuVzR0Foq4kQ+0l3aiwqvBBwsHEgJYOJ
         FICDzdSX8ZRkY8wP5CgxXpMOCIw+b0CgPrfYhh+hIuPTJ4rzJxiRLtuP8C0RAFSvggDd
         wJKIGgbpYw84H3qIg8pV0jspnwjdvKdqxoF8SpH3gKjHAEg5P/D7Wmo+5y2NVY9xhzXC
         v5h9eLQR2TEawayeQp/RJEu+0n0yF2+Qb2yZcZPQaPA3LPcXj077hiTj1id/ROQ+XAfj
         RGpNWaduT7QSyl9hlo84Iuh/u2gKOBvZz5ekrYW/66ENpU0ee5rc2dm9vJk4ip5WSLLS
         3uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtBnu91CX1ydlA23BUG5vY5e6nzQMbllcbsRH3s8rU8=;
        b=Z6xVDDh4Si4N7UffZqNoPWehqGPQ8e+lFbQIE07mSjSXvpLweJB4A4Xxdxn5CnDmcm
         sBYoACwLe9ej07Cvxca2GuGfGSzzbQfH1k4w6pgqd/Td16WS9SDB3YnP2pnjaUsMgkqn
         JsQS8Eq7Wi31fEGacgPimaDO746NLPr+6fnaBkq+jDtgzAyW8VvQFrtdHQ4p8ZfF7pmj
         8s9dvPb+UCDD291pSg9psbpbDmucFeOLwJnIsa3+rTGi+wQpIbBcbVw2quzEDcnbBPdB
         rmgTv7KClStDJ6SFgiEWssSD2D85elP4Ap4/H+JWGTHsPSCnRqApsW+pKbm4+jNWYdUK
         m0QQ==
X-Gm-Message-State: AOAM530dQudYLaLhpyTwxGfZwTerSELf6MNVdchv3LmYgX6fozlJ2kbN
        n6Qfx2Pn95kp+uktQBVIvidMd2oGLaKBW2Ta8bA5JA==
X-Google-Smtp-Source: ABdhPJzInxL9TQPhls3p1JKPKNMxgywX9wnX7AZpQ5FbGXz5dlegzgj31uzCXjfTKxgFWssweLAgXRp8OJeVTKgUIZw=
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr28309624ejv.383.1615888446960;
 Tue, 16 Mar 2021 02:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210301142659.8971-1-brgl@bgdev.pl>
In-Reply-To: <20210301142659.8971-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 Mar 2021 10:53:56 +0100
Message-ID: <CAMRc=MejfxVtHfv_txym2DFAS+0ij_3s0FKCC-tR+Y-tFpO_Yw@mail.gmail.com>
Subject: Re: [RESEND PATCH] irq/irq_sim: shrink devm_irq_domain_create_sim()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 3:27 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We don't have to use a custom devres structure if all we manage is a
> single pointer - we can use devm_add_action_or_reset() for that and
> shrink the code a bit.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  kernel/irq/irq_sim.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index 48006608baf0..ee40a84641e5 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -24,10 +24,6 @@ struct irq_sim_irq_ctx {
>         struct irq_sim_work_ctx *work_ctx;
>  };
>
> -struct irq_sim_devres {
> -       struct irq_domain       *domain;
> -};
> -
>  static void irq_sim_irqmask(struct irq_data *data)
>  {
>         struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
> @@ -216,11 +212,11 @@ void irq_domain_remove_sim(struct irq_domain *domain)
>  }
>  EXPORT_SYMBOL_GPL(irq_domain_remove_sim);
>
> -static void devm_irq_domain_release_sim(struct device *dev, void *res)
> +static void devm_irq_domain_remove_sim(void *data)
>  {
> -       struct irq_sim_devres *this = res;
> +       struct irq_domain *domain = data;
>
> -       irq_domain_remove_sim(this->domain);
> +       irq_domain_remove_sim(domain);
>  }
>
>  /**
> @@ -238,20 +234,17 @@ struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
>                                               struct fwnode_handle *fwnode,
>                                               unsigned int num_irqs)
>  {
> -       struct irq_sim_devres *dr;
> +       struct irq_domain *domain;
> +       int ret;
>
> -       dr = devres_alloc(devm_irq_domain_release_sim,
> -                         sizeof(*dr), GFP_KERNEL);
> -       if (!dr)
> -               return ERR_PTR(-ENOMEM);
> +       domain = irq_domain_create_sim(fwnode, num_irqs);
> +       if (IS_ERR(domain))
> +               return domain;
>
> -       dr->domain = irq_domain_create_sim(fwnode, num_irqs);
> -       if (IS_ERR(dr->domain)) {
> -               devres_free(dr);
> -               return dr->domain;
> -       }
> +       ret = devm_add_action_or_reset(dev, devm_irq_domain_remove_sim, domain);
> +       if (!ret)
> +               return ERR_PTR(ret);
>
> -       devres_add(dev, dr);
> -       return dr->domain;
> +       return domain;
>  }
>  EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
> --
> 2.29.1
>

Gentle ping.

Bartosz
