Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27E23EBDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 23:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhHMVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 17:39:56 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:42886 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhHMVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 17:39:54 -0400
Received: by mail-qt1-f170.google.com with SMTP id t16so9436938qta.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 14:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZCHXkE0Ngtxkg8sy8FZkEEy5v/vMEhkY+n7hsSWU9w=;
        b=d4cokYyXzzAtS8fruA2+0oGJV/ilX4yI6JiBa+CAu4ClL8WzJ41EX3H8GrXHUyoiRk
         fdIqM4iBzhDUEck3UmLd0CDz3rX/2HPaSIwmXS/uTyccpso51zytKLURIZXnmQm72TW5
         stBs3BlhSNhsq6Ld2X6fQj4G4lNPUY0WfJStG0jgKBL89d40fjnWtfoMdeTARHmXneMR
         6mLe+ysZ5UodFJwMGIfoQaqFe63pSPPxf3rT2RqfKrgu1fhSoUZA94b5uwzLGdq84gIp
         NxFVEqoDMOmASC6I0J6M3VHhaevUgA+Jbjtn9+ZuuXkyrNs1wQdY0sWMGltRVDcdNPyp
         yHkw==
X-Gm-Message-State: AOAM5300yIU+UXL6Gpx9hN1HAamQFD6Fo7LtXoWIVelaXqOZc4uEuP9n
        jeW6qEkpotOyvqzKQugmMEUVC/YKuRE=
X-Google-Smtp-Source: ABdhPJztZf3ykPudS1nstfqNDjEo3B1ply6y3/9vonBr06wLkhbQ9qgOLg9zt8GynIWwT3uL+sT3ww==
X-Received: by 2002:ac8:574e:: with SMTP id 14mr1418033qtx.300.1628890766536;
        Fri, 13 Aug 2021 14:39:26 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 62sm1479246qtg.58.2021.08.13.14.39.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 14:39:26 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id r21so1433573qtw.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 14:39:25 -0700 (PDT)
X-Received: by 2002:ac8:5c82:: with SMTP id r2mr3686098qta.283.1628890765336;
 Fri, 13 Aug 2021 14:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210811071036.44658-1-fido_max@inbox.ru>
In-Reply-To: <20210811071036.44658-1-fido_max@inbox.ru>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 13 Aug 2021 16:39:14 -0500
X-Gmail-Original-Message-ID: <CADRPPNSP+vZ_B+myoAs9LxKQH=moKgq_McXfihxyEbc=7NnxWA@mail.gmail.com>
Message-ID: <CADRPPNSP+vZ_B+myoAs9LxKQH=moKgq_McXfihxyEbc=7NnxWA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: fix static checker warning
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 2:10 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>
> The patch be7ecbd240b2: "soc: fsl: qe: convert QE interrupt
> controller to platform_device" from Aug 3, 2021, leads to the
> following static checker warning:
>
>         drivers/soc/fsl/qe/qe_ic.c:438 qe_ic_init()
>         warn: unsigned 'qe_ic->virq_low' is never less than zero.
>
> In old variant irq_of_parse_and_map() returns zero if failed so
> unsigned int for virq_high/virq_low was ok.
> In new variant platform_get_irq() returns negative error codes
> if failed so we need to use int for virq_high/virq_low.
>
> Also simplify high_handler checking and remove the curly braces
> to make checkpatch happy.
>
> Fixes: be7ecbd240b2 ("soc: fsl: qe: convert QE interrupt controller to platform_device")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/soc/fsl/qe/qe_ic.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index e710d554425d..bff34ee2150a 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ic.c
> @@ -54,8 +54,8 @@ struct qe_ic {
>         struct irq_chip hc_irq;
>
>         /* VIRQ numbers of QE high/low irqs */
> -       unsigned int virq_high;
> -       unsigned int virq_low;
> +       int virq_high;
> +       int virq_low;
>  };
>
>  /*
> @@ -435,9 +435,8 @@ static int qe_ic_init(struct platform_device *pdev)
>         qe_ic->virq_high = platform_get_irq(pdev, 0);
>         qe_ic->virq_low = platform_get_irq(pdev, 1);
>
> -       if (qe_ic->virq_low < 0) {
> +       if (qe_ic->virq_low < 0)

Probably should be <= 0 here.

>                 return -ENODEV;
> -       }
>
>         if (qe_ic->virq_high != qe_ic->virq_low) {

Probably we should check if qe_ic->virq_high > 0 here if we rely on
this to decide whether to set the handler later.

Applied with the above changes.  Thanks

>                 low_handler = qe_ic_cascade_low;
> @@ -459,7 +458,7 @@ static int qe_ic_init(struct platform_device *pdev)
>         irq_set_handler_data(qe_ic->virq_low, qe_ic);
>         irq_set_chained_handler(qe_ic->virq_low, low_handler);
>
> -       if (qe_ic->virq_high && qe_ic->virq_high != qe_ic->virq_low) {
> +       if (high_handler) {
>                 irq_set_handler_data(qe_ic->virq_high, qe_ic);
>                 irq_set_chained_handler(qe_ic->virq_high, high_handler);
>         }
> --
> 2.31.1
>
