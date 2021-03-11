Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9383372AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhCKMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhCKMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:32:12 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:32:12 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n79so20342811qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7/MPGIZ4WfmL4CRUvFWlovc/8lRT5Q/WOgdo9DvGsk=;
        b=q1H/SxQD3WDk3KLYZMwT6Gf63+upJzj5dCh1F/YNzNXw5uyBTozuGVXrxupcAsUfIz
         7j+gAgISYDyG2F5C7PkLQszFIFP9Mg1Pk84HaCQLRkMKJyxa2LY1Rn5Lpp6aLd0aEyw0
         pBr8pscVWyZww9IlPVkBnPHRacGB6Zu17GRrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7/MPGIZ4WfmL4CRUvFWlovc/8lRT5Q/WOgdo9DvGsk=;
        b=lqMAkCES+t/yEN0UPVfoRUAD1x1eyEyN7dq29a2BV1Etnwwzs5S8OlXnbXJYLxAPQu
         y+8nk6sO2CKtF5A+aDwy3cNOIBDJLDrGEsatEiqj36OrchtyXZeXlNXlO7YKHtcGAOTo
         JxlLClfvrOgQMf7NGRrWdiOYgz3YMklE4N14lnSIbtcQGMSsDqVSkCiRWytQr4tKrE8V
         mjEfe93vrTRJmoD+J0VMz/mw3LGpvgIbDGarxEDKMiI1OeSp5bDu58QFRfmyi9SeuDcX
         1zjbaZHkOVQ5DeRMLby1CtGetij2I8U73p3Pror7pyeAEID3/p8xsQBvqhaMlty8XJ4D
         PWwA==
X-Gm-Message-State: AOAM532ylmoVEG0PQ99mBAUUOjcf6ywk6BAMsA8SBGqSK5wgV2+zSTK5
        iv0Fff2yDKvhmBPXI5AZAfWZ9N2WTQ524KP/fIffMg==
X-Google-Smtp-Source: ABdhPJyqzMhTize0o3im7e/84suA7f3v+q1shYGatAI+5T5rjPbXSF2InfyTmTybfE7igSCyXptOIKTj8WO8ntrhm/s=
X-Received: by 2002:a37:ef09:: with SMTP id j9mr7386300qkk.390.1615465931646;
 Thu, 11 Mar 2021 04:32:11 -0800 (PST)
MIME-Version: 1.0
References: <CAFr9PX=dz1kt_BphpWr250asLiHFQNeBgNPhuPje==hzkcHWhg@mail.gmail.com>
 <20210311031242.24232-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210311031242.24232-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 11 Mar 2021 21:33:35 +0900
Message-ID: <CAFr9PXmHhB=PT1kRoYYowf2dw2fqa1-LGCD5S52hW9jJtq5Q4w@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Daniel Palmer <daniel@thingy.jp>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK.

On Thu, 11 Mar 2021 at 12:12, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> For a fiq controller, the input edge signal will be convert to level and
> keep the interrupt status until we do EOI operation.
> That means if a rising edge input if trigger the ouput line will keep high
> until we clear the interrupt status.

I think maybe the fiq is always edge triggered?
It seems like it latches on an edge and holds it's output to the GIC
high until it is reset by eoi and then only triggers again on another
edge.
I can experiment to confirm that's what it actually does for the chips I have.

Then it seems like the irq version is almost just a configurable
inverter that passes either the input signal or the inverted input
signal to the GIC.

So maybe fiq should only accept edge type interrupts and irq could
accept either?

>  static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
>  {
> -       if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
> -               return -EINVAL;
> -
> -       if (type == IRQ_TYPE_LEVEL_LOW) {
> +       if (type == IRQ_TYPE_EDGE_FALLING) {
> +               mst_set_irq(data, INTC_REV_POLARITY);
> +               type = IRQ_TYPE_EDGE_RISING;
> +       } else if (type == IRQ_TYPE_LEVEL_LOW) {
>                 mst_set_irq(data, INTC_REV_POLARITY);
>                 type = IRQ_TYPE_LEVEL_HIGH;
>         }

I think this still needs the logic to check that type is something we
can handle (not IRQ_TYPE_EDGE_BOTH) and maybe if the fiq controller
can only do edge interrupts level types should return -EINVAL?

Thanks,

Daniel
