Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03A413164
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhIUKSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhIUKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:18:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:17:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q26so37485320wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GObT1QYVLArBTvZ53NGOnJNRdUva3/8xKoXuesJHn/Q=;
        b=BaASjxyq8SgeaqU0juZT51Yv+Bfv3TpFjlq5dJY8za2s8dkyRKpgBsJXU8wXp3b5Dl
         3b6Fe1KWGtXs8hjSsuzDVZ49YYr0HVeibjdu8ZxPB9JM6q/nqpF7sV4sHATQ3qaVqUtK
         W/D+zFCtXzfCSnMIUkt2jEnvy/y1sfEffNeKmVpGTAqHNe7wgxLBFf0cf7XyJigxLfeV
         tS2h5tHtGHkKB6+u7Fmffr4dn7EdjQs30p19JcGJsx3y88xCk+nL6+q2BuQSn2sPrb9W
         lMhHLdRUZtTbSDlAfiCls1vQs2niCJB7z4cGWzArRqzfhJKmVlvX+UbqCRUJthG8T2FY
         0uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GObT1QYVLArBTvZ53NGOnJNRdUva3/8xKoXuesJHn/Q=;
        b=sF4qrm18q91OrO7GxxlL8lH7SgSgkmAXkOeGeFk8Y0ZDPxtLLsTHikMj9h3wHdYvBF
         OyAczY514kPLr1C7BgYxiwXecq1ESd9G3VKzs/z2EbKvmAOTPKRLezJa2AoWvFhzapeJ
         Z0YfIwbKTBjcbLhkjn9ABvtznzr3b4cqdXK6UwHv0F35oa6Az41gMN9BbCBqAcx0/CuL
         mrTE7aRTjZ1mHW2Bmjb5CUNBQxEtDMR1EsHVgPhxrI77y01sW7kmJlXDcXuctL3eMdfR
         Z5RoFB40BlbnJY2jKKV5GlNlzsp7iP2lCczZCPXxjVeeHSY/UTIA0tGiFHSjFjhNYJFL
         b/iw==
X-Gm-Message-State: AOAM533AYL7cdfZpByGh0gQ7DljGkgxlm10Z3UiJMQAW3ap7tlNny5AE
        TZjhyGmXKvFTGxDNZh50AgNSrOGMBn20P7Xj1jx/Nw==
X-Google-Smtp-Source: ABdhPJwS8af/THbsnVe/Np78G/uGepO75XhEk4CqOvW2fqhayqORudb14v9rogGJTqk1NDdaRJzHf+P6GCGZsOtvQgk=
X-Received: by 2002:adf:f50b:: with SMTP id q11mr11342711wro.306.1632219421062;
 Tue, 21 Sep 2021 03:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
In-Reply-To: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 Sep 2021 15:46:49 +0530
Message-ID: <CAAhSdy07KzQnTH+ad4esxtfhogzpXQagY8KeDkq1Kc81-Z33Yw@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:04 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> The SiFive Unmatched board uses the da9063 PMIC for reset: add a restart
> notifier that will execute a small i2c sequence allowing to reset the
> board.
>
> The original implementation comes from Marcus Comstedt and Anders Montonen
> (https://forums.sifive.com/t/reboot-command/4721/28).
>
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  drivers/mfd/da9063-core.c       | 25 +++++++++++++++++++++++++
>  include/linux/mfd/da9063/core.h |  3 +++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index df407c3afce3..c87b8d611f20 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -20,6 +20,7 @@
>  #include <linux/mutex.h>
>  #include <linux/mfd/core.h>
>  #include <linux/regmap.h>
> +#include <linux/reboot.h>
>
>  #include <linux/mfd/da9063/core.h>
>  #include <linux/mfd/da9063/registers.h>
> @@ -158,6 +159,18 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
>         return ret;
>  }
>
> +static int da9063_restart_notify(struct notifier_block *this,
> +                                unsigned long mode, void *cmd)
> +{
> +       struct da9063 *da9063 = container_of(this, struct da9063, restart_handler);
> +
> +       regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> +       regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> +       regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> +
> +       return NOTIFY_DONE;
> +}
> +
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  {
>         int ret;
> @@ -197,6 +210,18 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>                 }
>         }
>
> +       da9063->restart_handler.notifier_call = da9063_restart_notify;
> +       da9063->restart_handler.priority = 128;

How was this priority value chosen ?

I mean, we will be having SBI SRST as well so we should choose
a priority value lower than what we choose for SBI SRST handler.

Regards,
Anup

> +       ret = register_restart_handler(&da9063->restart_handler);
> +       if (ret) {
> +               dev_err(da9063->dev, "Failed to register restart handler\n");
> +               return ret;
> +       }
> +
> +       devm_add_action(da9063->dev,
> +                       (void (*)(void *))unregister_restart_handler,
> +                       &da9063->restart_handler);
> +
>         return ret;
>  }
>
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index fa7a43f02f27..1b20c498e340 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -85,6 +85,9 @@ struct da9063 {
>         int             chip_irq;
>         unsigned int    irq_base;
>         struct regmap_irq_chip_data *regmap_irq;
> +
> +       /* Restart */
> +       struct notifier_block restart_handler;
>  };
>
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq);
> --
> 2.30.2
>
