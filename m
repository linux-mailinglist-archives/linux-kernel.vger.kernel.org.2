Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC138CAB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhEUQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237439AbhEUQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621613611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0dYw+1ty9M4F1TS3R0pdrlfe9TmD8aidnu0vhpgiO6k=;
        b=S1ahRIpkt1JFtDf/awzvZ3bugymB/yeeVEVzstjJhD/yKnmVi1HnCMyzFxGYtLwAnTy94t
        03/t8/HEZVgUn+HCVYGDckExSAq3Fd1UyCE7jvoNhCDBhV4Yqn11GWjLa0z2qLGdbVlC71
        4f8LnYaYgqaYH36U9MhnW7NcH+s7Pfw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-kGqli1clMDChazkxSg4h4w-1; Fri, 21 May 2021 12:13:28 -0400
X-MC-Unique: kGqli1clMDChazkxSg4h4w-1
Received: by mail-lf1-f69.google.com with SMTP id d26-20020a194f1a0000b02902390d1deb9dso4505340lfb.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dYw+1ty9M4F1TS3R0pdrlfe9TmD8aidnu0vhpgiO6k=;
        b=IgK4TF50yBXCEc2u1pS7x9jNu7AQH7rtHRLIpbPpTRtbkUEigfb1D4Nb6MJ4/MHBt2
         rmlb+jmIT4g6R545SBbDaL2EEmsG1p76ElMK3d/16UjXekjwsM+y2BTzlHeJWrp1KGjb
         IIeKuAdf9lJ+bnnWTArDeOdHxAt01tn8tyJBe6Bty4y8Y+qIF4raYON1M1buz4cXa9uI
         cGWt/oWYahRreHhhecp9I+ISOLdP2AxMs+zimt9HRe5PG9to+f2uNAnd5OdAP3elEM7u
         EkN3l/tCRiWsjObcqSJUxbIjMwvG2cSsy4TQog3/wUjiXqIFs3kqEoByFp+AZARZCyDR
         XtVQ==
X-Gm-Message-State: AOAM533Q1AlXG2wgwkImL/9RzaZ8eLDpSfFUJHiWh3PRzuQgXA9yoYgB
        WZdBwsKcN+p/5BoKqp9UmNphr4AuI3Z9JL57YrLuj1Huj1dNy+LpikYJoihgJPAfHHlzgaS4xLA
        Id0jQ6FX6ZXWdVqZgGakdgOPUtWhnF6Cd8RNWM0Q0
X-Received: by 2002:a19:6a13:: with SMTP id u19mr2632862lfu.252.1621613606477;
        Fri, 21 May 2021 09:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcQ1NWe596jnGhcNjYe2J09TkPUM7blmWDbIf1NVN1FdeURq8gjDCG56i3qI32jqqzyZ4Ad08J+veH32YL/kw=
X-Received: by 2002:a19:6a13:: with SMTP id u19mr2632844lfu.252.1621613606258;
 Fri, 21 May 2021 09:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210504092340.00006c61@intel.com> <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de> <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de> <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 21 May 2021 12:13:15 -0400
Message-ID: <CAFki+LkqBHnVYB5VBx_8Ch0u8RfXrJsRzxyuDfHhbR-dCeN3Lg@mail.gmail.com>
Subject: Re: [PATCH] genirq: Provide new interfaces for affinity hints
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com,
        Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 8:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The discussion about removing the side effect of irq_set_affinity_hint() of
> actually applying the cpumask (if not NULL) as affinity to the interrupt,
> unearthed a few unpleasantries:
>
>   1) The modular perf drivers rely on the current behaviour for the very
>      wrong reasons.
>
>   2) While none of the other drivers prevents user space from changing
>      the affinity, a cursorily inspection shows that there are at least
>      expectations in some drivers.
>
> #1 needs to be cleaned up anyway, so that's not a problem
>
> #2 might result in subtle regressions especially when irqbalanced (which
>    nowadays ignores the affinity hint) is disabled.
>
> Provide new interfaces:
>
>   irq_update_affinity_hint() - Only sets the affinity hint pointer
>   irq_apply_affinity_hint()  - Set the pointer and apply the affinity to
>                                the interrupt
>

Any reason why you ruled out the usage of irq_set_affinity_and_hint()?
IMHO the latter makes it very clear what the function is meant to do.


> Make irq_set_affinity_hint() a wrapper around irq_apply_affinity_hint() and
> document it to be phased out.

Right, so eventually we will be only left with the following APIs that
the driver will use:
irq_set_affinity()- for drivers that only wants to set the affinity mask
irq_apply_affinity_hint/irq_set_affinity_and_hint() - for drivers that
wants to set same affinity and hint mask
irq_update_affinity_hint() - for drivers that only wants to update the hint mask

Thanks for clearing this.

>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20210501021832.743094-1-jesse.brandeburg@intel.com
> ---
> Applies on:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> ---
>  include/linux/interrupt.h |   41 ++++++++++++++++++++++++++++++++++++++++-
>  kernel/irq/manage.c       |    8 ++++----
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -328,7 +328,46 @@ extern int irq_force_affinity(unsigned i
>  extern int irq_can_set_affinity(unsigned int irq);
>  extern int irq_select_affinity(unsigned int irq);
>
> -extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
> +extern int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> +                                    bool setaffinity);
> +
> +/**
> + * irq_update_affinity_hint - Update the affinity hint
> + * @irq:       Interrupt to update
> + * @cpumask:   cpumask pointer (NULL to clear the hint)
> + *
> + * Updates the affinity hint, but does not change the affinity of the interrupt.
> + */
> +static inline int
> +irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return __irq_apply_affinity_hint(irq, m, true);
> +}
> +
> +/**
> + * irq_apply_affinity_hint - Update the affinity hint and apply the provided
> + *                          cpumask to the interrupt
> + * @irq:       Interrupt to update
> + * @cpumask:   cpumask pointer (NULL to clear the hint)
> + *
> + * Updates the affinity hint and if @cpumask is not NULL it applies it as
> + * the affinity of that interrupt.
> + */
> +static inline int
> +irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return __irq_apply_affinity_hint(irq, m, true);
> +}
> +
> +/*
> + * Deprecated. Use irq_update_affinity_hint() or irq_apply_affinity_hint()
> + * instead.
> + */
> +static inline int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return irq_apply_affinity_hint(irq, cpumask);
> +}
> +
>  extern int irq_update_affinity_desc(unsigned int irq,
>                                     struct irq_affinity_desc *affinity);
>
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -487,7 +487,8 @@ int irq_force_affinity(unsigned int irq,
>  }
>  EXPORT_SYMBOL_GPL(irq_force_affinity);
>
> -int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> +                             bool setaffinity)
>  {
>         unsigned long flags;
>         struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> @@ -496,12 +497,11 @@ int irq_set_affinity_hint(unsigned int i
>                 return -EINVAL;
>         desc->affinity_hint = m;
>         irq_put_desc_unlock(desc, flags);
> -       /* set the initial affinity to prevent every interrupt being on CPU0 */
> -       if (m)
> +       if (m && setaffinity)
>                 __irq_set_affinity(irq, m, false);
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
> +EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>
>  static void irq_affinity_notify(struct work_struct *work)
>  {
>


--
Nitesh

