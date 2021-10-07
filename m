Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA842559C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhJGOlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:41:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DFFC061570;
        Thu,  7 Oct 2021 07:39:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x7so23487376edd.6;
        Thu, 07 Oct 2021 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDd26SQflN3P15ZnRadh5CKU3JrRFB6su1ADFuo1p5Q=;
        b=aXjT2T8U43nvqPI2L6L8w9OE+OIk6DuNIqUQSPyjSEf9XYdclcKF5RXhssyOOA2vlL
         7auIDaSc5CEdbQGZMQtgzhq4siGf2Tk4qO8RHzle07tp0QXSLQI1LNvrn2JCi/Jll1LZ
         S2KuP4XdnLEN5WQ7cAYWzwjdSw/6rhvH+tSXT5Oxay/paOh0Cg+ToAz/3n3PTui9tioJ
         pIVzR/HoM9tAd37qi8pPZ7acSJOULeO5UXVUPjJk60cJTMsMSUSvDTYxORhbhIWI+zbi
         1uLUTJgRf84K6UA4Ig6GAoxdKdfRwIGYhoVMhCw1G8MA2E3CASe7GwLZdfiuG2KnRnTo
         Ie0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDd26SQflN3P15ZnRadh5CKU3JrRFB6su1ADFuo1p5Q=;
        b=I/Mc8ylyHSpVrPN90NQ38ghb8gIw/oI4+sVd4ktYv4RtTUtwaxeMtjGjn88mjlLrd0
         0eUWDSqSfLrHAzdy/3DSFq4i59pQZhsxbNdXScs2/+dca+X196NoDvTusDH4jQGj53Je
         tw8XGg9tbAPNxZ0POyGRKcv51PauugdyKDadO8pZo8dB9WpJvyqULlK4xDC1AEEeVb7D
         CkHhAeYT3uvKnHlpTHMhFTA/3QIbj75rue0AjKOmLqGgSjAD3DHmMTTmkunR9nodz8jk
         twvwGZpTARVbrD0+o+Zeza/hpT0LUCeeGZUWEKnwXpu1gKRJ8ZkBL3mANHjjxaZULWME
         rukQ==
X-Gm-Message-State: AOAM530EoDDlssUKZIxoeJC3A1R9paufjgLDAMxxlc1SlfuHWk6lP+cj
        XWJ8DVlHU1JHrMMGjtTD7KEIyLIHofi0prrK4hI=
X-Google-Smtp-Source: ABdhPJy0saGklfOotT2S0NR7z3BspcHZidiLqxG4LQ11G1f9JKWJq0vbux4MMkLZhGWyd7GdAD7MmHU5U/86H3vI6Jk=
X-Received: by 2002:a05:6402:358a:: with SMTP id y10mr6698350edc.238.1633617595253;
 Thu, 07 Oct 2021 07:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211007140904.3085-1-semen.protsenko@linaro.org>
In-Reply-To: <20211007140904.3085-1-semen.protsenko@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 17:39:18 +0300
Message-ID: <CAHp75Ve1+pJ3Mqc7ErDSheLu5rEvSOf2Cq9JtSfOxSFrazNObg@mail.gmail.com>
Subject: Re: [PATCH v4] clk: Add write operation for clk_parent debugfs node
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 5:09 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Useful for testing mux clocks. One can write the index of the parent to
> be set into clk_parent node, starting from 0. Example
>
>     # cd /sys/kernel/debug/clk/mout_peri_bus
>     # cat clk_possible_parrents
>       dout_shared0_div4 dout_shared1_div4
>     # cat clk_parent
>       dout_shared0_div4
>     # echo 1 > clk_parent
>     # cat clk_parent
>       dout_shared1_div4
>
> CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> order to use this feature.

...

> +static ssize_t current_parent_write(struct file *file, const char __user *ubuf,
> +                                   size_t count, loff_t *ppos)
> +{
> +       struct seq_file *s = file->private_data;
> +       struct clk_core *core = s->private;
> +       struct clk_core *parent;

> +       char buf[4] = { 0 };

We may use {} (in a more standardized way), but see below.

> +       u8 idx;
> +       int err;

> +       if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +               return -EFAULT;
> +
> +       err = kstrtou8(buf, 0, &idx);
> +       if (err)
> +               return err;

NIH kstrotu8_from_user().

> +       parent = clk_core_get_parent_by_index(core, idx);
> +       if (!parent)
> +               return -ENOENT;
> +
> +       clk_prepare_lock();
> +       err = clk_core_set_parent_nolock(core, parent);
> +       clk_prepare_unlock();
> +       if (err)
> +               return err;
> +
> +       return count;
> +}

...

> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> +               if (core->num_parents > 1) {
> +                       debugfs_create_file("clk_parent", 0644, root, core,
> +                                           &current_parent_rw_fops);

> +               } else {
> +                       debugfs_create_file("clk_parent", 0444, root, core,
> +                                           &current_parent_fops);
> +               }
> +#else
>                 debugfs_create_file("clk_parent", 0444, root, core,
>                                     &current_parent_fops);

Dup. You can avoid it.

> +#endif
> +       }

-- 
With Best Regards,
Andy Shevchenko
