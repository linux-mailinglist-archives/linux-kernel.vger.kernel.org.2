Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC1309488
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhA3Kiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:38:50 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46787 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhA3Kit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:38:49 -0500
Received: by mail-ot1-f48.google.com with SMTP id d1so11188155otl.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 02:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oa1dItTmNYKHh5pZMMxxZ+w/cNjCvp3zbGbPpGitjzI=;
        b=gK44i0YIgajYuuAfxQzY1X8lmDseo2JOdrtyI2W4YiNSCndUZz43Wr2BmXVndWMEea
         reRiXr37WAh6lYcqlzpmUH5cT6j9tlpIWRtf0T92/phIZWLb7txzePiorHMAToC8ZhY3
         sFEVMjshUDif0Yfu5fjW00AhiXnxoAWyYek2c3rm02ImsoOdPkQeWaUBF4OlRZNX4kY7
         24/uUDH05vYTtEZNeCyM9ltsqgwg8VbswGzHaW1wQ9d4vrrVmgdt1tkkKfcRMEm09H5d
         aAp3poeZo3GFno9j7qNrfoJFyUrS5UXkwEbzDQYPrKLtTuYpZfIUhp2fswx8Pts2kbdq
         lqWA==
X-Gm-Message-State: AOAM533G6tYf9MPziUnV3ZWHf+nBCrOvDUWjpE3dgzZc/fZxCLsJRCeH
        IIzUfNXEBanpZZ/YytrOnXehVPKgqvHuUTaw+6E=
X-Google-Smtp-Source: ABdhPJw3wzLfopSk6lGbIsIPqDvA4bNPP3OSC7KLiyn2sxLU3oC58ZhxZv/Ts6Jv4aL6XloKpg/pRBDqnZEBnR8fG3g=
X-Received: by 2002:a05:6830:1489:: with SMTP id s9mr5600635otq.250.1612003088374;
 Sat, 30 Jan 2021 02:38:08 -0800 (PST)
MIME-Version: 1.0
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
In-Reply-To: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 30 Jan 2021 11:37:57 +0100
Message-ID: <CAMuHMdWcJuBv94pQ-1Bf7QAb6e3=AjSz7GBFCPLqiCJ0CjXjqA@mail.gmail.com>
Subject: Re: [PATCH] openrisc: use device tree to determine present cpus
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Fri, Jan 29, 2021 at 7:34 PM Jan Henrik Weinstock
<jan.weinstock@rwth-aachen.de> wrote:
> This patch proposes to use the device tree to determine the present cpus
> instead of assuming all CONFIG_NRCPUS are actually present in the system.
>
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>

Thanks for your patch!

> --- a/arch/openrisc/kernel/smp.c
> +++ b/arch/openrisc/kernel/smp.c

> @@ -68,14 +69,25 @@ void __init smp_init_cpus(void)
>
>   void __init smp_prepare_cpus(unsigned int max_cpus)
>   {
> -       int i;
> +       u32 cpu_id;
> +       struct device_node *cpu, *cpus;
>
>         /*
>          * Initialise the present map, which describes the set of CPUs
>          * actually populated at the present time.
>          */
> -       for (i = 0; i < max_cpus; i++)
> -               set_cpu_present(i, true);
> +       cpus = of_find_node_by_path("/cpus");
> +       for_each_child_of_node(cpus, cpu) {

for_each_of_cpu_node()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
