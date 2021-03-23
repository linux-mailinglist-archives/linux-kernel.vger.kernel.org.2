Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8388B345425
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhCWAtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhCWAtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE66C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m12so24105359lfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psFvZTcsXnFClDCw3WS/jrtZadVPprmyJZOMq/BiXME=;
        b=maZXsFKmzgvWfbafopsGnlJJGTcA1Ohpdek3S34FwKhEmK/rteIC/poImo8Zie1oYI
         Pd+ANDFgJgNpksWD9R0gjlX02HUfKLpGLDHGJwfGcyzAcnH8bGCyh77d8VCbqfW68XA/
         2TEwO7uOMWbDP9Gu0d8WglGRiyDWt3OiR5DEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psFvZTcsXnFClDCw3WS/jrtZadVPprmyJZOMq/BiXME=;
        b=JVtOyG/zqHPaJDLXCLOnbQCZeFSWwXPKB1CaKzxGzttkIb+K/CkSz2MhnHTnwTMNeJ
         L3Y/4mWaZzqC+j1PJZlqQb3YAPHjiwZ1iDHrLnMtS7yrgj9esWsQoSE0PMEwAL5qV5Cj
         kZ6G0IVjjvsjF86L3FCWmvsAUyJ8GDRxzZ5XLvOgwV/u9hFD7vEDQ/N1Y0R0EvL6JaaF
         e/ozTf5V1y92sv4JtK1c4T5S6p4mSNRscMYGUd8Zq8xey7lIIMHHuFgrLSyUw3dgXsOh
         S1ChEPipiPi/W4AGxnDo+gJGtsDeHWdS6TMy8yLNF7lcZPBWv4fQnQM+NtS6bPlxDGd1
         UaHw==
X-Gm-Message-State: AOAM530MIMNnM5CFyy6cnxQhpEyDezzu3yG0nTeQFXHCyfCT5jWVOyu6
        7AHk9aT7BLe9lIpf/31haLUGngP45jAMXA==
X-Google-Smtp-Source: ABdhPJxnAPclozX3KREEN7OabQPo6tngSYbMmWpwt9Kjp0KacfLYIKX4qKT8fr60E9hObdZi/40vVQ==
X-Received: by 2002:a19:dc0b:: with SMTP id t11mr1105127lfg.233.1616460560330;
        Mon, 22 Mar 2021 17:49:20 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b29sm1659133lfv.196.2021.03.22.17.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 17:49:19 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 184so23382911ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:19 -0700 (PDT)
X-Received: by 2002:a2e:2e19:: with SMTP id u25mr1335258lju.487.1616460558555;
 Mon, 22 Mar 2021 17:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <1614670085-26229-1-git-send-email-Fengquan.Chen@mediatek.com> <1614670085-26229-2-git-send-email-Fengquan.Chen@mediatek.com>
In-Reply-To: <1614670085-26229-2-git-send-email-Fengquan.Chen@mediatek.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Tue, 23 Mar 2021 11:48:52 +1100
X-Gmail-Original-Message-ID: <CAKz_xw2abQyS9Vvx7DUppGGd-AaDQAfdAOwi46fB9yLPJWJeUA@mail.gmail.com>
Message-ID: <CAKz_xw2abQyS9Vvx7DUppGGd-AaDQAfdAOwi46fB9yLPJWJeUA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: optimize systimer irq
 clear flow on Mediatek Socs
To:     Fengquan Chen <Fengquan.Chen@mediatek.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, dehui.sun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 11:07 AM Fengquan Chen
<Fengquan.Chen@mediatek.com> wrote:
>
> 1)ensure systimer is enabled before clear and disable interrupt, which only
> for systimer in Mediatek Socs.

Why does the timer need to be enabled before the interrupt can be
disabled? The datasheet I have does not suggest that this is required.

>
> 2)clear any pending timer-irq when shutdown to keep suspend flow clean,
> when use systimer as tick-broadcast timer
>
> Change-Id: Ia3eda83324af2fdaf5cbb3569a9bf020a11f8009
> Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
> ---
>  drivers/clocksource/timer-mediatek.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edc..9f1f095dc 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -75,6 +75,7 @@
>  static void mtk_syst_ack_irq(struct timer_of *to)

This function seems to be mis-named. It does more than just ack the irq.

>  {
>         /* Clear and disable interrupt */
> +       writel(SYST_CON_EN, SYST_CON_REG(to));

This line seems to enable the timer and disable the interrupt.

>         writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));

This line acks the interrupt and enables the timer and disables the interrupt.
Are these lines both necessary?
Maybe this function should just ack the interrupt without changing the
other bits.

>  }
>
> @@ -111,6 +112,9 @@ static int mtk_syst_clkevt_next_event(unsigned long ticks,
>
>  static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
>  {
> +       /* Clear any irq */
> +       mtk_syst_ack_irq(to_timer_of(clkevt));
> +
>         /* Disable timer */
>         writel(0, SYST_CON_REG(to_timer_of(clkevt)));

This is a third write to the same register, I believe all 3 writes can
be combined into 1. Is that possible?

>
> --
> 1.8.1.1.dirty
>
