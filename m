Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A64223C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhJEKpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:45:13 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:42905 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhJEKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:45:10 -0400
Received: by mail-vk1-f180.google.com with SMTP id r25so266242vkl.9;
        Tue, 05 Oct 2021 03:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgfAA5tuaR0skShOha2ZwCdxx+sB32VR21cf+MP43iA=;
        b=b5O2/bal3QQH1oliV7cKeq4hxlFYmJkqjDIYawaQXQr0pLN0snP23X/t3a5nMSN6wF
         GLTc6CArRydwBawrfcAgt0XHYZFXpT/a/Zk1augaWH4A6w7cI8Kpjd2mvoEiiHoWyy7G
         wTI4rFJP4k+v7oKTVN4x0cveD+x6KtPP9pMqcjnA+hLJAyZyYG7TmWRxeGIy1BpVdbnZ
         UhPZubVU3B6cJEwJy+vTG44JFD94qokO7JvI1fkHd4cNwPJxaMmRy46vt9Xv5VTFV4Fh
         eTp9F/hiQ+4RR2V+wYZ+cMm4nZe8kvn4gwHRz32g3MaCKvQ1GqDIjOzHpfUMSwd30Pla
         W/3g==
X-Gm-Message-State: AOAM532CgU8FrgxOnHQz5rPz/psM6Sa0fg+s4vUSyXP+IuXydlTQB6st
        UApemvrOlHumzv1zQ6xIO0ReTD4+wUATWoUUyVA=
X-Google-Smtp-Source: ABdhPJx5z+ZLiuL95t0JLquECq+CX9RzQsCP3ZndO98AruVdmMPxTE+9mWnqM8WfSDDepPcd9SrcP9wCHWu3sTkAS6k=
X-Received: by 2002:a1f:230c:: with SMTP id j12mr19610053vkj.11.1633430599705;
 Tue, 05 Oct 2021 03:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210914141939.26410-1-semen.protsenko@linaro.org> <CAPLW+4mhr4pJAUyGNpfWDnxgTsJ7-fj0hw=ehV8YkqRmaBSnag@mail.gmail.com>
In-Reply-To: <CAPLW+4mhr4pJAUyGNpfWDnxgTsJ7-fj0hw=ehV8YkqRmaBSnag@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Oct 2021 12:43:08 +0200
Message-ID: <CAMuHMdXVM4HZ6H4e=7u14qwmqszmR4cvNZ=K4h9O079fxZB95g@mail.gmail.com>
Subject: Re: [PATCH] clk: Add clk_set_parent debugfs node
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Tue, Oct 5, 2021 at 12:11 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> On Tue, 14 Sept 2021 at 17:19, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> > Useful for testing mux clocks. One can write the index of the parent to
> > set into clk_set_parent node, starting from 0. Example
> >
> >     # cat clk_possible_parrents
> >       dout_shared0_div4 dout_shared1_div4
> >     # cat clk_parent
> >       dout_shared0_div4
> >     # echo 1 > clk_set_parent
> >     # cat clk_parent
> >       dout_shared1_div4
> >
> > Define CLOCK_ALLOW_WRITE_DEBUGFS in drivers/clk/clk.c in order to use
> > this feature.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
>
> + Adding more folks for review
>
> Guys, can you please review this one?

Thanks for your patch!

> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3214,6 +3214,30 @@ static int current_parent_show(struct seq_file *s, void *data)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(current_parent);
> >
> > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > +static int clk_set_parent_set(void *data, u64 val)

u64 is overkill, num_parents is u8.

> > +{
> > +       struct clk_core *core = data, *parent;
> > +       int ret;
> > +
> > +       if (val >= core->num_parents)
> > +               return -EINVAL;

clk_core_get_parent_by_index() called below already checks this.

> > +
> > +       parent = clk_core_get_parent_by_index(core, val);
> > +       if (IS_ERR_OR_NULL(parent))
> > +               return PTR_ERR(parent);
> > +
> > +       clk_prepare_lock();
> > +       ret = clk_core_set_parent_nolock(core, parent);
> > +       clk_prepare_unlock();
> > +
> > +       return ret;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(clk_set_parent_fops, NULL, clk_set_parent_set,
> > +                        "%llu\n");
> > +#endif
> > +
> >  static int clk_duty_cycle_show(struct seq_file *s, void *data)
> >  {
> >         struct clk_core *core = s->private;
> > @@ -3285,9 +3309,14 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
> >                 debugfs_create_file("clk_parent", 0444, root, core,
> >                                     &current_parent_fops);
> >
> > -       if (core->num_parents > 1)
> > +       if (core->num_parents > 1) {
> >                 debugfs_create_file("clk_possible_parents", 0444, root, core,
> >                                     &possible_parents_fops);
> > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > +               debugfs_create_file("clk_set_parent", 0200, root, core,
> > +                                   &clk_set_parent_fops);
> > +#endif

Why add a new file, instead of making the existing "clk_parent" file
writable, like is done for "clk_rate"?
Yes, "clk_parent" prints a name, while you use a parent number, but
I guess that can be fixed? Or even both can be accepted?

> > +       }
> >
> >         if (core->ops->debug_init)
> >                 core->ops->debug_init(core->hw, core->dentry);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
