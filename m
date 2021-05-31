Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1291539567C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhEaHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:50:59 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:33457 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhEaHul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:50:41 -0400
Received: by mail-vs1-f50.google.com with SMTP id f11so5611345vst.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Xn0sTFdfNg/ZPLEokjKLyZnGIfrnZNIxA8L+PBXePI=;
        b=n5Lls8KTHEd1el1Hikd8p9NYeopmI8ZsaXFw8aTV+/j+pvz0ok+x09ZPU7a8bfBeNi
         quJqLdC65g5YlKC1ZD4ZM1H+2omFWOkY7rbWOrMYnabGCf8CE45Jnw5CtnlbQCks1TtW
         GmPg3LPVPF9Qyb9V042zZzxUT+/dYjvQzLbhZ5vqfQQ78CNsssuoON6zZzj02yues0yd
         u3f9uFZKTZ7/6jB/xhaU6XBYMYJsGQtXP6u5nQfjbXzXOAR5SotyXmcThQY018RSEeP4
         CDQEnngG68YlPb3ZvF0HCuIhFShNSrei4MMWwMfoArWE8ju3ki6F7ocPR94rP04cn0p+
         Ksxw==
X-Gm-Message-State: AOAM530ws6IeNeOczLdcQ+N5sVuZFW4yEJCKClOjQQhKLKqSZ6FRa5wo
        QiXAJAXsORHoqrd4ooEfAe2n9IjTL3eGAX7uuYpNHrx0rUQ=
X-Google-Smtp-Source: ABdhPJzKLiOVWGMINLfFwg58wnT/4kxtS0yf4gFrwbmlA0kvKJzN5BFl88UD/JkIgEkkGnyihno49+7adaKOyfHXRfs=
X-Received: by 2002:a67:8713:: with SMTP id j19mr13087195vsd.3.1622447341220;
 Mon, 31 May 2021 00:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com> <20210529105504.180544-7-wangkefeng.wang@huawei.com>
In-Reply-To: <20210529105504.180544-7-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 09:48:50 +0200
Message-ID: <CAMuHMdU_y5g86owbK4J1gP6xntxCCmNGT_MCXZkVfosTjYdEqg@mail.gmail.com>
Subject: Re: [PATCH 06/15] h8300: convert to setup_initial_init_mm()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Sat, May 29, 2021 at 12:47 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Use setup_initial_init_mm() helper to simplify code.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks for your patch!

> --- a/arch/h8300/kernel/setup.c
> +++ b/arch/h8300/kernel/setup.c
> @@ -97,10 +97,7 @@ void __init setup_arch(char **cmdline_p)
>  {
>         unflatten_and_copy_device_tree();
>
> -       init_mm.start_code = (unsigned long) _stext;
> -       init_mm.end_code = (unsigned long) _etext;
> -       init_mm.end_data = (unsigned long) _edata;
> -       init_mm.brk = (unsigned long) 0;
> +       setup_initial_init_mm(_stext, _etext, _edata, (void *)0);

Please use NULL instead of (void *)0.

>
>         pr_notice("\r\n\nuClinux " CPU "\n");
>         pr_notice("Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne\n");

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
