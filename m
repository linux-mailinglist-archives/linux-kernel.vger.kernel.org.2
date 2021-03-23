Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157E2346BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhCWWHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhCWWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:06:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED048C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:06:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b4so5000188lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXkprPtYGMO2ih6Z+KDNNlc8UFFhBMXJ52/OD2yHyRA=;
        b=jIfAj/g677rjJSNndS+/qsDgpJ0hh6AXSK8GOqbRwRegLsMLs27R77ZqwRANW342Rk
         E3bDHsZaIfMZQGLcotveoNLySBM8V1bI+s7jy0qo6GSMaXGd+CzsFVcyr20jPFBjIiSZ
         F0webGGJZna1+8YO1lwSUK0qf86smbBz3Qcg5YSx4Uwr/xIF/YwtVRrIzCplN6z4gdp/
         WQLY7FqGXOks3zdVAqgk5oW1zhwZeTEHXETBmgTolWvjg21zlw8iCI5dETuOA3jUATGH
         IUX+WprY3FipJyzBxamOafZQSO3427qVvXKn1uofRj4dx6vPFDgPDnazsAVpx2zcU0kL
         9inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXkprPtYGMO2ih6Z+KDNNlc8UFFhBMXJ52/OD2yHyRA=;
        b=RLv2xz/CliqztaGO9oNwpHI6vvHEeDu1AjTqe65rSGLwLqc+2JWDAWdNbTX1myTMU0
         JnX3qLOgaFOz4h7W7h87Pykc5IFrq0nxpqNE88Ru4RvdVWP4aSZrPkUmw2tvEZ1dUjz+
         stwoim6fELaf8UqLNpKeVfhYPZ4AP+LWYXpA7k0NiO80tFB1EfdTi+1MGrBAiQFW1ebp
         ekLnuHPgmduv0f1c3Yw5IVZOd+37fi6qivm/VM4xS1ALDDtb+QCrnGqeh7TwaN2ftOeG
         WsSW8+CDgqsok3WCXVhK2cRm4yzxk/aPe2jFvbyzJAu1ln2ydo8E2NQp6y7/UrysJD8r
         QxmA==
X-Gm-Message-State: AOAM530R8xb+lI6ufrmDCDvkbick3uFzR04kGPyyBMmiLiEcjxn5xNsJ
        8w6tylBRxTrAJIULOlPpOdbBzzv0B2RvNZbzT2L1SA==
X-Google-Smtp-Source: ABdhPJxZq4d912WBxVcV8gMula8r3RlEu8CAiFHByk8kJES7omUWrsgvBWL6dBUVyd6JyK8qb9nILHDOtEyOqiZHtp0=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr82260lft.368.1616537193207;
 Tue, 23 Mar 2021 15:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210323131842.2773094-1-arnd@kernel.org>
In-Reply-To: <20210323131842.2773094-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Mar 2021 15:06:22 -0700
Message-ID: <CAKwvOdkBEQdVC73_datkwa+meitAGskDgTEr5LzX6AEnE4xd-w@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: fix OF_BAD_ADDR error handling
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 6:18 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When building with extra warnings enabled, clang points out a
> mistake in the error handling:
>
> drivers/irqchip/irq-gic-v3-mbi.c:306:21: error: result of comparison of constant 18446744073709551615 with expression of type 'phys_addr_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

Looks like based on CONFIG_PHYS_ADDR_T_64BIT, phys_addr_t can be u64
or u32, but of_translate_address always returns a u64.  This is fine
for the current value of OF_BAD_ADDR, but I think there's a risk of
losing the top 32b of the return value of of_translate_address() here?

>                 if (mbi_phys_base == OF_BAD_ADDR) {
>
> Truncate the constant to the same type as the variable it gets compared
> to, to shut make the check work and void the warning.
>
> Fixes: 505287525c24 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/irqchip/irq-gic-v3-mbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
> index 563a9b366294..e81e89a81cb5 100644
> --- a/drivers/irqchip/irq-gic-v3-mbi.c
> +++ b/drivers/irqchip/irq-gic-v3-mbi.c
> @@ -303,7 +303,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
>         reg = of_get_property(np, "mbi-alias", NULL);
>         if (reg) {
>                 mbi_phys_base = of_translate_address(np, reg);
> -               if (mbi_phys_base == OF_BAD_ADDR) {
> +               if (mbi_phys_base == (phys_addr_t)OF_BAD_ADDR) {
>                         ret = -ENXIO;
>                         goto err_free_mbi;
>                 }
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
