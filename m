Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4317F361E39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbhDPKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhDPKsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:48:30 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:48:06 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c3so16596846ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C74aGVjrq9NIAUbXd935tljz2LVTxxnWW3CsspAw0SM=;
        b=SpgKXRUhLTKXI01i6cnlypw0MP3mhowAg4qaiV20M7s03kgW9L7qOnPV48VNvIuopm
         /fLYXOoYrWPMGFesjtgbzaEPCnshCYgTS4ikMsTrqdke7tXRRFeWG2232T1iFDfIdq+t
         LzJFnPtF6UIMoFsxR40jZKOkJJvIExmAxX7pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C74aGVjrq9NIAUbXd935tljz2LVTxxnWW3CsspAw0SM=;
        b=kE2rEkPEcDKuQHXVQ0CR6jj74SaShF0IsqL+C9tuqGgosnJkPHYihcRr72uMOmx09N
         XL/8ynTednhfOLDxVqPrtj7MI44cRNQCt6B82FCstUOQ4rHRDPZpDJixlrW6mfd+0E5W
         ppWH04vq5Kn1eJ+sMuVOqJqv1fY6jLaQP3Um08A3kjEi1/r0W6iaDSUF0NTIE9vll8h9
         WNOmotxWW9ALe8zKOwsz1Yn/W2VNjlPQ3BmMCtpQ1/ipO0u90wtBiDb3HhM3YNuvo2bE
         G7gB/3p+MBEGYme/0pctb3P6peWHG/lkmki8j5wumai3Gqs3DR9ajGizr8iOA5z8xwki
         1xig==
X-Gm-Message-State: AOAM5305PSb+vk8TJK+RVWDrlB5De5Dya5ZlEYzemJx7fl4hZtEvLzt6
        1Yw4o2Pua7+T9wDy+832WFb/gZwT0bpYdHHX07yAAQ==
X-Google-Smtp-Source: ABdhPJx1lpsYR8uqB8Dt2Mv/cWIzyoAlXwzfDls5vff3WgmSA1BM7Hj5eRWvVdDYgjTim2dW5iiRImMWRzIH1VqLXkk=
X-Received: by 2002:a05:6e02:1282:: with SMTP id y2mr6431543ilq.308.1618570085698;
 Fri, 16 Apr 2021 03:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <1617960162-1988-1-git-send-email-Fengquan.Chen@mediatek.com> <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
In-Reply-To: <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 16 Apr 2021 18:47:39 +0800
Message-ID: <CAJMQK-jyUzAQu_Yi5zJSRREC5fzPvQoTFpSVyKB8YBi1cK2j7g@mail.gmail.com>
Subject: Re: [PATCH] [v4, 1/1] clocksource/drivers/timer-mediatek: optimize
 systimer irq clear flow on shutdown
To:     Fengquan Chen <Fengquan.Chen@mediatek.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, dehui.sun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 5:22 PM Fengquan Chen <Fengquan.Chen@mediatek.com> wrote:
>
> mtk_syst_clkevt_shutdown is called after irq disabled in suspend flow,
> clear any pending systimer irq when shutdown to avoid suspend aborted
> due to timer irq pending
>
> Also as for systimer in mediatek socs, there must be firstly enable
> timer before clear systimer irq
>
> Fixes: e3af677607d9("clocksource/drivers/timer-mediatek: Add support for system timer")
> Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested on a mt8183 device. This patch solves an issue that device
would hang on resume during genpd_resume_noirq:

[  724.342834] mtk-smi-larb 17010000.larb: genpd_resume_noirq+0x0/0xd0
returned 0 after 976593 usecs
[  724.351721] mtk-smi-larb 1a001000.larb: calling
genpd_resume_noirq+0x0/0xd0 @ 6629, parent: soc
[  736.845047] Kernel panic - not syncing: Watchdog detected hard
LOCKUP on cpu 3
[  736.852268] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W
  5.10.26 #17
[  736.859743] Hardware name: MediaTek krane sku176 board (DT)
[  736.865309] Call trace:
[  736.867756]  dump_backtrace+0x0/0x1bc
[  736.871415]  show_stack+0x20/0x2c
[  736.874728]  dump_stack+0xc0/0x11c
[  736.878124]  panic+0x174/0x378
[  736.881178]  watchdog_check_hardlockup+0x11c/0x124
[  736.885963]  watchdog_timer_fn+0x70/0x274
<snip>



> ---
>  drivers/clocksource/timer-mediatek.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edc..6461fd3 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -60,9 +60,9 @@
>   * SYST_CON_EN: Clock enable. Shall be set to
>   *   - Start timer countdown.
>   *   - Allow timeout ticks being updated.
> - *   - Allow changing interrupt functions.
> + *   - Allow changing interrupt status,like clear irq pending.
>   *
> - * SYST_CON_IRQ_EN: Set to allow interrupt.
> + * SYST_CON_IRQ_EN: Set to enable interrupt.
>   *
>   * SYST_CON_IRQ_CLR: Set to clear interrupt.
>   */
> @@ -75,6 +75,7 @@
>  static void mtk_syst_ack_irq(struct timer_of *to)
>  {
>         /* Clear and disable interrupt */
> +       writel(SYST_CON_EN, SYST_CON_REG(to));
>         writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
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
>
> --
> 1.8.1.1.dirty
>
