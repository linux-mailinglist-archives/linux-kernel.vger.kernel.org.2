Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA29402281
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhIGDhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhIGDhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:37:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 20:36:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d6so11672301wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFELlCxACkPlVqOqccw5bz/5Ef/2jWKLWio/1Ljd534=;
        b=MNytY5sC4yk+LE2yIrQUn4UbJewA24iX2y7cU4snKj2frfStKGIw9fmt62Wjs6mg0D
         WsTmOnLKSRFv1bLPiM9WahCcDyjbYW3H6mVYNVOHemm/cGk1SkkMYa/xStEIsawZfICo
         Ky0aNyy5xAZT3FqYqBIRENMy33XbOOsW5oNZ/GuwjcuALXZqmkBfRoaODP8ps1qb24HO
         3suPmJ2xTvpkmZVBsqd2hsXA7pEVpJ0ih2oF3SgeO89HdbuMCCKvvpTKIpACrZN6ggt5
         3R0DPxoE6kVq4ogkouS7oQVGOzejWrltmL46pBmiefuC4xRVf8nEmjVlRgUHVCgTyp+R
         Df/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFELlCxACkPlVqOqccw5bz/5Ef/2jWKLWio/1Ljd534=;
        b=ZQrk4biVg6m0fNHNXUyF/O4vLsL0ZqnknixdwTFDQ3C6DhyMJ5U2BQ6kvD61CHNN9d
         VciHs1VVF/eOqtk2CB/CyI9uEbVKqyWLilSpcPHbsYWbpf5cp0H9Ep7D8iP7YI+z2UIj
         PVAkrfvE87hsWGZ9MpXlMlgl2QiszHAFiCHEWkSHhaDzA9Il/lyl2e2wfRIf30OBv+Ww
         lxDRcVniEbdpNCegOO35khof6r9bZEfG3pxK1Wuq/UMWXPHG+J8zqVjUXeMsxqTnBkgM
         rI8ac9B/gzBiyfGV7QIMNCaOKwCdYJ18n4j0izD9dfOAJo5Kh9WvLqibFGBOx/yNk+9M
         ExAg==
X-Gm-Message-State: AOAM533iwQUjfVDUiteXWREuQh0nnMQqe0BX7YlwKUCRHUR1odGaH9Gq
        uPQgZRpiEaT4ojZTyTLDLlIPXdGIBRawnF/mCt3LUcXr8N019A==
X-Google-Smtp-Source: ABdhPJw0jsRQpQYdLTeQEAq/WEySFTHLaluzVK0XmoOQYkXfHBdDEWdGDJSkJJCNVq+B7V2qp0ZSHoMCdHQuIOJCYtI=
X-Received: by 2002:adf:f984:: with SMTP id f4mr16548430wrr.331.1630985798777;
 Mon, 06 Sep 2021 20:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210907002847.111633-1-dimitri.ledkov@canonical.com>
In-Reply-To: <20210907002847.111633-1-dimitri.ledkov@canonical.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 7 Sep 2021 09:06:27 +0530
Message-ID: <CAAhSdy0E5x3e4mkYtL0gk6be2hZEF8KbSTP4DpWCkH_ce3AvYg@mail.gmail.com>
Subject: Re: [PATCH] riscv: set default pm_power_off to NULL
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 5:59 AM Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> Set pm_power_off to NULL like on all other architectures, check if it
> is set in machine_halt() and machine_power_off() and fallback to
> default_power_off if no other power driver got registered.
>
> This brings riscv architecture inline with all other architectures,
> and allows to reuse exiting power drivers unmodified.
>
> Kernels without legacy SBI v0.1 extensions (CONFIG_RISCV_SBI_V01 is
> not set), do not set pm_power_off to sbi_shutdown(). There is no
> support for SBI v0.3 system reset extension either. This prevents
> using gpio_poweroff on SiFive HiFive Unmatched.
>
> Tested on SiFive HiFive unmatched, with a dtb specifying gpio-poweroff
> node and kernel complied without CONFIG_RISCV_SBI_V01.
>
> BugLink: https://bugs.launchpad.net/bugs/1942806
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

BTW, SBI v0.3 system reset patch can be merged any day
because SBI v0.3 spec is already released.

Regards,
Anup

> ---
>  arch/riscv/kernel/reset.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index ee5878d968..9c842c4168 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -12,7 +12,7 @@ static void default_power_off(void)
>                 wait_for_interrupt();
>  }
>
> -void (*pm_power_off)(void) = default_power_off;
> +void (*pm_power_off)(void) = NULL;
>  EXPORT_SYMBOL(pm_power_off);
>
>  void machine_restart(char *cmd)
> @@ -23,10 +23,16 @@ void machine_restart(char *cmd)
>
>  void machine_halt(void)
>  {
> -       pm_power_off();
> +       if (pm_power_off != NULL)
> +               pm_power_off();
> +       else
> +               default_power_off();
>  }
>
>  void machine_power_off(void)
>  {
> -       pm_power_off();
> +       if (pm_power_off != NULL)
> +               pm_power_off();
> +       else
> +               default_power_off();
>  }
> --
> 2.30.2
>
