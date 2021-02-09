Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65240314564
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBIBNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhBIBLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:11:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1165C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:11:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g3so8823919plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ce+TAyz/o7S91Chv55i/MyiuAhSqiQmmYvbIlKJlGig=;
        b=ifgYO7R/BdrSlt3Lkt2JGQBaTU51EptYbg1L+QIXOXCSGoECDii7JYUBDu8RMNi/Xq
         ZInTiiA8YSB5bl1DPU1866RcDsJOdGgglLEFpFnPSPeyeHQC5+XoanPl2YxDQz1blrke
         tYmaewhrkS4lkmBrfDuD4+T6v+a8iQjj7O32tlZezBvtYjzqhyC+u3Fhjy/ldWpQkcH7
         uUsHwy02WwDdxu/tUzydJPmwAn8xCp7YnMSHqVkGQaDIUtMnji6xJm6rKNmhrik7Q49R
         oi/NJIM51Yqtqz7F0fEcLUj5y7GsO8M0wITBsh1iTzYoG49uR6/z0oRgbFvZPAaHF0ec
         dpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ce+TAyz/o7S91Chv55i/MyiuAhSqiQmmYvbIlKJlGig=;
        b=WtSAxbXEoYxEXemSb6ETNk94t7uz12qwO8R04CtHCezJ8VKQ0DHhrWm/10QpelJiej
         4xKlghGBLfOy+H73gGzHN9rfMGZXtCrGER7S2taEglgk2nRxew1tPqXuToa2BHHNJmfZ
         4DQbCKCmUtHJJrERZCPyuuybT7+fYoYKvj49+NWrH7tcnREO/+xFqDUPBBMvE3yNN89L
         z9hQWfq8QrmhHiWTnyDw3LBH9fC3AGmtFNTz/m2im0SjxA+1WEG3jQptB3aylJJmd10R
         AEmNOvsqM+ceGJeowfdXwZOZdaZib6kZ/FM6tmLFITZZEpkn76gAMzodZS3NeZnAU3Mr
         /kNw==
X-Gm-Message-State: AOAM532pyFssIeZQjeN4c3D0YWBNxUuIspirIVLHEnDr2oLJRRXTpQtd
        4y7qLppakszkc1D1MbdIg7I=
X-Google-Smtp-Source: ABdhPJwjC7RcC2kx0LfWL/8ZDlcX11eR15Q9dHbpe3LPq69ABi0I9iKy5XCz0SvDjIMx0lj2M1AvSA==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr1507951pjg.138.1612833066915;
        Mon, 08 Feb 2021 17:11:06 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id o124sm7926232pfg.108.2021.02.08.17.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:11:06 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:11:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 05/22] powerpc/irq: Add helper to set regs->softe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <5f37d1177a751fdbca79df461d283850ca3a34a2.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5f37d1177a751fdbca79df461d283850ca3a34a2.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612832745.vhjk6358hf.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> regs->softe doesn't exist on PPC32.
>=20
> Add irq_soft_mask_regs_set_state() helper to set regs->softe.
> This helper will void on PPC32.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index 614957f74cee..ed0c3b049dfd 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -38,6 +38,8 @@
>  #define PACA_IRQ_MUST_HARD_MASK	(PACA_IRQ_EE)
>  #endif
> =20
> +#endif /* CONFIG_PPC64 */
> +
>  /*
>   * flags for paca->irq_soft_mask
>   */
> @@ -46,8 +48,6 @@
>  #define IRQS_PMI_DISABLED	2
>  #define IRQS_ALL_DISABLED	(IRQS_DISABLED | IRQS_PMI_DISABLED)
> =20
> -#endif /* CONFIG_PPC64 */
> -
>  #ifndef __ASSEMBLY__
> =20
>  #ifdef CONFIG_PPC64
> @@ -287,6 +287,10 @@ extern void irq_set_pending_from_srr1(unsigned long =
srr1);
> =20
>  extern void force_external_irq_replay(void);
> =20
> +static inline void irq_soft_mask_regs_set_state(struct pt_regs *regs, un=
signed long val)
> +{
> +	regs->softe =3D val;
> +}
>  #else /* CONFIG_PPC64 */
> =20
>  static inline unsigned long arch_local_save_flags(void)
> @@ -355,6 +359,9 @@ static inline bool arch_irq_disabled_regs(struct pt_r=
egs *regs)
> =20
>  static inline void may_hard_irq_enable(void) { }
> =20
> +static inline void irq_soft_mask_regs_set_state(struct pt_regs *regs, un=
signed long val)
> +{
> +}
>  #endif /* CONFIG_PPC64 */
> =20
>  #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST

What I don't like about this where you use it is it kind of pollutes
the ppc32 path with this function which is not valid to use.

I would prefer if you had this purely so it could compile with:

  if (IS_ENABLED(CONFIG_PPC64)))
      irq_soft_mask_regs_set_state(regs, blah);

And then you could make the ppc32 cause a link error if it did not
get eliminated at compile time (e.g., call an undefined function).

You could do the same with the kuap_ functions to change some ifdefs
to IS_ENABLED.

That's just my preference but if you prefer this way I guess that's
okay.

Thanks,
Nick
