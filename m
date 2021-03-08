Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E734F330FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCHNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCHNkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:40:47 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE31C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:40:47 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z128so9130953qkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmXU+4B3Yh05wPO2dTCkwdtjQSLG4/1qvxif7cROYeQ=;
        b=pvHQei8+E+5HPL6xfSHqPN9aNzy2vUJNGtq6VVgd2f2btP4+58I254GZfQEVWsF1zF
         nQmzPa/2jebHoP51nncWLcvUg3PjEHS9sYWr4uxKMCzGpgjRXyuZNnt1Qs6DNAS9xjHV
         foZuvFg47ynVVCgiWZ4ytQWS/9vBNik9ibJw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmXU+4B3Yh05wPO2dTCkwdtjQSLG4/1qvxif7cROYeQ=;
        b=KkTZxuZNB4qk151moO0Ho65VQ3mNO5AtvwLqOrUB5gtINGg0MlM49EyoIbnCs586ie
         PBk+q27XedKAdKKvqWrR+MFsl320V7xHe75trOl7Fj9dLh+XLqrmhzaMsPYKw+c2rl2y
         l16AGpKa2pWTZJGraAIXVfpRFPErPmhPAQFsmZiku6ZRiz8VK8sQXcpIy7RN7OT+omdD
         +FqrAJ6nu9XLk2Wx81SgP1U/Q7FJVEo3YZKmQgQWEz5WE7w9CMVdJ7ybVugN2pBmBJ6V
         f673t2xnrNkoGrgMWOLek10B8hwalL1Gumj6BtPBxvznlkolSxpYhkTc1ZnEXdCn6ucm
         d9qg==
X-Gm-Message-State: AOAM5305x8Fub+I0/CsMfI4w732b3NhgVytryRPTV9BKgaNZ3vFONGAz
        dXkEbD+bjtHwkwU/FVonbBXQbmk01WCht/1x57gjlA==
X-Google-Smtp-Source: ABdhPJwicXanOfSurZr872caF2q06P/DdnLaFBVEUAiV9z7HyChhULk1R9gqs4uIAdFKoOTMr46m4YqxGaYNy3hXV+o=
X-Received: by 2002:a37:bd84:: with SMTP id n126mr20169728qkf.54.1615210846918;
 Mon, 08 Mar 2021 05:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20210308060538.11164-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210308060538.11164-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 8 Mar 2021 22:40:36 +0900
Message-ID: <CAFr9PXmiR9Wo9HxhRLj-k6+O5qu-uLSTCvQRqW-Yqgkk8YK-Tw@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

On Mon, 8 Mar 2021 at 15:05, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> +static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
> +{
> +       if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
> +               return -EINVAL;
> +

Does this mean we can't do rising or falling edge interrupts?

Thanks,

Daniel
