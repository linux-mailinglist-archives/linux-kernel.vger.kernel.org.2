Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BB420444
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhJCWSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhJCWSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:18:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495DC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 15:16:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so63103527lfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzkTIQlWqZRG2Zb0hdr5rkICTLhL0XajYhtt4w+t2gY=;
        b=nCi896ZVJ+XlHPgC/hVF3y+2DogSrixg8Iv5PKYCvEuvU71pn6aDEwNkdL3tOWmYxS
         8w+a8aAOgj/tDt6dUZ/H0WkQCzt1gG029eDv8zeoFL1evfaLZXgL+V4mKTv6fm5J3uu5
         zeQyieGB1SJQjv50AZg17MtTKJRnMTNl7Sevkd/1PhY/dg9ZfV8GjbcQTzKJaV6wsuPX
         LeA2ByGzZEjDV8xvF9k+F9Q6k4uI0KitpOVCMzX2Nx5ViDo36fh9CkzDDedU//EIfpba
         3RW7q/QiuZT58slMeqWvp4HMJqAywV/KipY0FQKmWjtYlGi2uMYTHnlLg/j67pBhovr1
         lCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzkTIQlWqZRG2Zb0hdr5rkICTLhL0XajYhtt4w+t2gY=;
        b=2A38Hfn8RaibRdfpoVYW84Qbe76Zf0DMeb/J081Mvre3B7cSubK+hm+0OCwIWBkApA
         L8CyLCd1fKFQi9FNC1Ohpmj9cwfWqeGQDn3ofIgP9+RryV8ME73+ljZmk0nnmv0RqAeM
         PmFNagppdZ/1nvh4UkZhDIr7n62uBs+keVorYoJK88Wk07EgCM94zzEvLwu4NK9kJiVL
         ETpxpLSRFk0A65teSesE6OwfspnJrgUHi1dNd250B2NX4PlunDogRfTvvNbmJomKtp8J
         vNJusQZQN3RnWxJI4Ovm2pUmHHYb61m6H/DjHqcF3ATOc42bnT6/UrAxlOATmTaDooNT
         610g==
X-Gm-Message-State: AOAM533KvGGdEk/qaJadXr8/o08PXd7IUNluje5InpE3MBxBOeFP1OUQ
        NBfK6LanwSLXRokZtdZ9+LF9bHLDGIVHiuociz2rhpJDJjQ=
X-Google-Smtp-Source: ABdhPJzJNcxs126/Cswt/LOh3w+e3WQG9QzaKgVRFp6ZuMTVSDMfwDrCeBQ+YuPNqm3O5zUMs7QE0ShXTfpn6nb2iq0=
X-Received: by 2002:a19:c10a:: with SMTP id r10mr9180470lff.95.1633299379618;
 Sun, 03 Oct 2021 15:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211002162000.3708238-1-daniel@0x0f.com>
In-Reply-To: <20211002162000.3708238-1-daniel@0x0f.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Oct 2021 00:16:08 +0200
Message-ID: <CACRpkdZmhZcGXi2Xg=r1BGaf8-QLPDawY_7Kp3d-xmvHuDe0xQ@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: Move setting the flow handler and don't set
 it at all if there is a parent domain
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

thanks for your patch!

On Sat, Oct 2, 2021 at 6:20 PM Daniel Palmer <daniel@0x0f.com> wrote:

> Calling irq_domain_set_info() before irq_domain_alloc_irqs_parent()
> can cause a null pointer dereference as the parent domain isn't
> ready yet.
>
> Move irq_domain_set_info() to after irq_domain_alloc_irqs_parent().
> A side effect of this is that irq_domain_set_info() will now overwrite
> the flow handler from the parent domain. So if there is a parent
> domain do not set the flow handler anymore.
>
> This allows gpio-msc313.c to level it's irq domain on top of the
> new irq controller in later SigmaStar SoCs without crashing.
>
> Link: https://lore.kernel.org/linux-arm-kernel/20210914100415.1549208-1-daniel@0x0f.com/
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Suggested-by: Marc Zyngier <maz@kernel.org>

If Marc says this is the way to go I think it is the way to go!

>         kfree(parent_arg);
> +
> +       if (!ret) {

Please just exit on error so invert this.

if (ret)
  return ret;

and just de-indent the below code (easier to follow)

> +               /* If there is a parent domain leave the flow handler alone */
> +               if (d->parent)
> +                       irq_domain_set_hwirq_and_chip(d,
> +                                                     irq,
> +                                                     hwirq,
> +                                                     gc->irq.chip,
> +                                                     gc);
> +               /* Otherwise set the flow handler supplied by the gpio driver */
> +               else
> +                       irq_domain_set_info(d,
> +                                           irq,
> +                                           hwirq,
> +                                           gc->irq.chip,
> +                                           gc,
> +                                           girq->handler,
> +                                           NULL, NULL);
> +               irq_set_probe(irq);
> +       }

Should we print an error if girq->handler is not NULL and we find
a parent domain, like
if (d->parent && girq->handler)
  dev_err(dev, "parent domain and flow handler both specified\n");

Yours,
Linus Walleij
