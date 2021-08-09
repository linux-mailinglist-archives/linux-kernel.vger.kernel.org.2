Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A453E4990
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhHIQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhHIQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:17:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601BC06179A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:16:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h17so13096294ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSGTRvI+dU9/OZ+C1LQvAOAFprB1mz1jW2qsFy5VOj8=;
        b=J4HR25xyJWVAE1giNlTN3BGiIqkZJJ1e0QM6OYYhESILiqjRzic0l72mh4qaM3kv7a
         DIeMIs5NCIQthXz8l5tzywRHdzLOtZzcEBjSRp5/wq5Bw4MpeYtH6CXj3UCcgqi3q0D2
         yhAo3WBBbN8rWcqHHEg7+RZ055xcaYUcpdlzOaV3eR9mOwf3we+Se6FoFAdUIFhGkODC
         DHVZBDIDGsdDFdgJG0AHL3RFNId7798nIoZoHi/zDK1NMLPA6hYagiawIt557Sn9bLTN
         tedfaEwr5UWj+a4Dk384EX9Xo5LKfkb1y9Ol69XatQBNbzBnKiRNC6BIfKlrzhdy9rAJ
         CQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSGTRvI+dU9/OZ+C1LQvAOAFprB1mz1jW2qsFy5VOj8=;
        b=JSvB05LWf4Zwnj3Nr/gzXQt58R9jGbbe8a+x61f6GTpd3cwS62BGdltRtntSmXFyOd
         MslKELBk51oaUcoBcPqZIOcjK23H4YRIGipY79fHCkUt/E5eOEu4x4HcjHKHKvI6STw2
         iglkl39BK/AqC7rRvB02rTZO1Q2R257CqDYeoVqQcgmr6rpcUYc3UStv9WIQBdPN3emV
         IBf0fUsf0l6cX6ki9MKoi9HQ14qxcXvr+dtGBIArr6DRPPgtErmidhJS9gRzYpnLvoEk
         xrSBl5VT/XhBJszhBAv/RMHcabX8IQ8EOhKxgCVUGciiz3sfXpB5HW8NCIjFZcTnvTKK
         DKpQ==
X-Gm-Message-State: AOAM530aFzwQRjS8NTvVDsaqnLGh9xfX12dQvmGkl/rPU4RAFS8AXIWS
        M6c/4bl+VRR324q7vj4356hytirBRTXQeTZWXNwKgA==
X-Google-Smtp-Source: ABdhPJxPOGOQK06zO5eNCgjZEzV4581j/YDQ549IQmrcxK3iGj75Pach3oioOh9HrNJLaCOjfPrwARpRkg4nj8O2TJI=
X-Received: by 2002:a2e:bd81:: with SMTP id o1mr16136845ljq.65.1628525809606;
 Mon, 09 Aug 2021 09:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-5-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-5-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 09:16:38 -0700
Message-ID: <CAOQ_QshxJgSP1y0R3uCgGepTKTqQkU4ELv3BTmQNPY0-B4rTsA@mail.gmail.com>
Subject: Re: [PATCH 04/13] clocksource/arm_arch_timer: Move drop _tval from
 erratum function names
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 8:27 AM Marc Zyngier <maz@kernel.org> wrote:
>
> The '_tval' name in the erratum handling function names doesn't
> make much sense anymore (and they were using CVAL the first place).
>
> Drop the _tval tag.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 898a07dc01cd..160464f75017 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -371,7 +371,7 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>
>  static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
>
> -static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
> +static void erratum_set_next_event_generic(const int access, unsigned long evt,
>                                                 struct clock_event_device *clk)
>  {
>         unsigned long ctrl;
> @@ -392,17 +392,17 @@ static void erratum_set_next_event_tval_generic(const int access, unsigned long
>         arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>  }
>
> -static __maybe_unused int erratum_set_next_event_tval_virt(unsigned long evt,
> +static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
>                                             struct clock_event_device *clk)
>  {
> -       erratum_set_next_event_tval_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
> +       erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
>         return 0;
>  }
>
> -static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
> +static __maybe_unused int erratum_set_next_event_phys(unsigned long evt,
>                                             struct clock_event_device *clk)
>  {
> -       erratum_set_next_event_tval_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
> +       erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
>         return 0;
>  }
>
> @@ -414,8 +414,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .desc = "Freescale erratum a005858",
>                 .read_cntpct_el0 = fsl_a008585_read_cntpct_el0,
>                 .read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
> -               .set_next_event_phys = erratum_set_next_event_tval_phys,
> -               .set_next_event_virt = erratum_set_next_event_tval_virt,
> +               .set_next_event_phys = erratum_set_next_event_phys,
> +               .set_next_event_virt = erratum_set_next_event_virt,
>         },
>  #endif
>  #ifdef CONFIG_HISILICON_ERRATUM_161010101
> @@ -425,8 +425,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .desc = "HiSilicon erratum 161010101",
>                 .read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
>                 .read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
> -               .set_next_event_phys = erratum_set_next_event_tval_phys,
> -               .set_next_event_virt = erratum_set_next_event_tval_virt,
> +               .set_next_event_phys = erratum_set_next_event_phys,
> +               .set_next_event_virt = erratum_set_next_event_virt,
>         },
>         {
>                 .match_type = ate_match_acpi_oem_info,
> @@ -434,8 +434,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .desc = "HiSilicon erratum 161010101",
>                 .read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
>                 .read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
> -               .set_next_event_phys = erratum_set_next_event_tval_phys,
> -               .set_next_event_virt = erratum_set_next_event_tval_virt,
> +               .set_next_event_phys = erratum_set_next_event_phys,
> +               .set_next_event_virt = erratum_set_next_event_virt,
>         },
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_858921
> @@ -454,8 +454,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .desc = "Allwinner erratum UNKNOWN1",
>                 .read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
>                 .read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
> -               .set_next_event_phys = erratum_set_next_event_tval_phys,
> -               .set_next_event_virt = erratum_set_next_event_tval_virt,
> +               .set_next_event_phys = erratum_set_next_event_phys,
> +               .set_next_event_virt = erratum_set_next_event_virt,
>         },
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_1418040
> --
> 2.30.2
>
