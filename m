Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6B3B57C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 05:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhF1DWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 23:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1DWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:22:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E43C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 20:19:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a18so7536884lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PKivKn2YgF+EaJ9ZOG0XShilM2vuyjG7wHbJAWBD/M=;
        b=Hh7ZkIh2PJbKCECj27TKD1qQ046damE9dJ6ufdj3sEg6dkB8SxOAWF+kCIvuqN9qrP
         ZW21Q2eOBoFucUaYKQXBrKiDLHz1i5u94Cd6dIrHNiO8bpJC1KE5Gk4GBVSd33LdK1p/
         j6PwYUUK64HGjJuhYvwcO/QBpcOdcMLXuchTyrB1Yas8LlMrV2HY4Xz4gHA5vFTVXlGQ
         /752bUrseqrVwIJU6aukEPMRDPHNmA7ymbptSu38muX9wcQ6PMmF65CrAeKexMRDEpLV
         nUMbo57dDg9UoXN0mj+XXlfO97siMAnpzmtg7G+Fd/jd89PNkaGPfdQDbMEuwPBOrMRa
         6+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PKivKn2YgF+EaJ9ZOG0XShilM2vuyjG7wHbJAWBD/M=;
        b=KGZXQNkplV3DZ+OL4UyeX/LHHhySLyFV2K1sKIe9mqGUH5IzxO2llBAMw5NR2855NM
         wylZQVpij+2C+yMciPNDjXSyprRM2ijHh0RXfeX3TNVGhoOpFYtGvJEVyt+GIkv+9cZH
         egflS3uYw5Bi0xkP/bJoaeiN1gWLdVvGdbiTWLBHBWQ6hpL0oXBSbXMjSMn9qS7KfqmZ
         VlCieUY4Dpxk1m+cfOD3TIcTcxZVO0XgMYO/062P0VlgVWcJ7qLqYMFLbUhFcfYMkeZl
         H3fNJyKn5RdK4X+yobO0Bbufa/f8axKKya3P8+JyVeE5nuoQoF2bUm++F+hujwoed6eQ
         FauQ==
X-Gm-Message-State: AOAM5314krA1YRF0e6YThXvlslZE0380wjbSTlthZ7LYWFqMV1Pj/CSD
        LjdJosm44G1zhpl8GxdWEF23Q0PYNYvSa8Ss9Ec=
X-Google-Smtp-Source: ABdhPJwpUyvqSBxKOSv0dRgiH2wGi5Y9qQe5ewBVwUvFFEoff4BfIh8H3D+FoADccnlGan/38lNafUO9Cb7i5SaCQs0=
X-Received: by 2002:ac2:419a:: with SMTP id z26mr17201069lfh.307.1624850373008;
 Sun, 27 Jun 2021 20:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210627142320.455525-1-sxwjean@me.com>
In-Reply-To: <20210627142320.455525-1-sxwjean@me.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 28 Jun 2021 11:19:06 +0800
Message-ID: <CAEVVKH8bb1Y5hLttmUFR_gAkA5p=SjcCqMvUoh-=iZ6sVaYPpA@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Fix meaningless usages output of lock classes
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch, it's not good. I will improve it.

Regards,
Xiongwei

On Sun, Jun 27, 2021 at 10:23 PM Xiongwei Song <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <sxwjean@gmail.com>
>
> When enabling CONFIG_LOCK_STAT, then CONFIG_LOCKDEP is forcedly enabled.
> We can get output from /proc/lockdep, which currently includes usages of
> classes. But the usages of classes are meaningless, see the output
> below:
>
> / # cat /proc/lockdep
> all lock classes:
> ffffffff9af63350 ....: cgroup_mutex
>
> ffffffff9af54eb8 ....: (console_sem).lock
>
> ffffffff9af54e60 ....: console_lock
>
> ffffffff9ae74c38 ....: console_owner_lock
>
> ffffffff9ae74c80 ....: console_owner
>
> ffffffff9ae66e60 ....: cpu_hotplug_lock
>
> Only one usage context for each lock, this is because each usage is only
> changed in mark_lock() that is in CONFIG_PROVE_LOCKING defined section,
> however in the test situation, it's not.
>
> The fix is to move the usages reading and seq_print from
> CONFIG_PROVE_LOCKING undefined setcion to it defined section.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  kernel/locking/lockdep_proc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index 806978314496..1b1103ee7dc6 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -73,10 +73,11 @@ static int l_show(struct seq_file *m, void *v)
>  #ifdef CONFIG_PROVE_LOCKING
>         seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
>         seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
> -#endif
>
>         get_usage_chars(class, usage);
>         seq_printf(m, " %s", usage);
> +#endif
> +
>
>         seq_printf(m, ": ");
>         print_name(m, class);
> --
> 2.30.2
>
