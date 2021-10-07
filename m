Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADF4259B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhJGRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241071AbhJGRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:47:17 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A196C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:45:23 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 66so7606887vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/SSd9taA/ux/WcbF4zPpx1nrfRSaWr/6ufk+sBjGOU=;
        b=C6OV7fNTNszO83NEHaEe9WFS92ipi/64+l5QWmrSf08rqt21EdnbkzayDbeQbffi8q
         4EWmBrvGTjXk+RskDMJyaOKcdhNgkhuFRmA0dqtR+2QoW5HNYt3KBYu8nzbKLKgkjz93
         FQABPrg1LfIwwUdGSgzk8+H5moBYA8C7xiQueXjfOnfLBkqGIF7lssvawMvmoX7/PKWv
         7FheqBOhkduhYGMxsRwICIRa6gj+Y60RtPOTQnfFw3qEpiNyUyt6awddo1vVc94PK/D9
         ewFPU/aqeVl6SiMmF1dGHZH2dbPU1llOpwspC/hCI6y532BiXHKx06E64YciBBxxcwrd
         urow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/SSd9taA/ux/WcbF4zPpx1nrfRSaWr/6ufk+sBjGOU=;
        b=fOnftE9Z3Vlt7Hk5jVwvOjtimgkvYXy/p/tt5lFSRdFOjkoR1057kzx2czhDWGqyTt
         O+yG9w36gAu39V0zvoWL4Np/Be5qqFpkJkqA1TqS7zaLavdmh9cc+AUJDj85037kBkKf
         VdWJl8HdP7WPDsQB3l22tGQp+zJzjsrOCyJnPqoTxBwKwsKpkP6GI6XLwmNt60VGPHEr
         wTCnDVM7QN3GAmjIJ00Rw7tkuaiRXw4b9ofnTNKf9UAbsjpoxTKNcTkJss7bq/0RXiBV
         +kh3wu1us4HqbTu5ZvxAi7KXJkADKxkUQNxR5eaKDh3M0Za1WnsajNPYHgNK0RWzGswd
         R49g==
X-Gm-Message-State: AOAM530bd2tNu9Gthjn3hXVs4cpEeSiO0A8WFBEQSWkMZ31y/yK8v2Y/
        wRfeKam6JjkFtmDoPx3VR3F9pGRGfabtOtL1IKQynw==
X-Google-Smtp-Source: ABdhPJzs3BsUO8cKJEPJ0Qs45Sbe9/yBxJbj4v7ac+DJsZWM5TBVKa/rt3x2n3ALCUEU8THowSqy5JBQI6SxyrUFihM=
X-Received: by 2002:a67:d289:: with SMTP id z9mr6123652vsi.39.1633628722573;
 Thu, 07 Oct 2021 10:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211007140904.3085-1-semen.protsenko@linaro.org> <CAHp75Ve1+pJ3Mqc7ErDSheLu5rEvSOf2Cq9JtSfOxSFrazNObg@mail.gmail.com>
In-Reply-To: <CAHp75Ve1+pJ3Mqc7ErDSheLu5rEvSOf2Cq9JtSfOxSFrazNObg@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 7 Oct 2021 20:45:11 +0300
Message-ID: <CAPLW+4=3Mx9HuLdDo8YQ7tjVMi2kaTP23N1E2b5Krp_RJbO5-g@mail.gmail.com>
Subject: Re: [PATCH v4] clk: Add write operation for clk_parent debugfs node
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Thu, 7 Oct 2021 at 17:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 7, 2021 at 5:09 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >
> > Useful for testing mux clocks. One can write the index of the parent to
> > be set into clk_parent node, starting from 0. Example
> >
> >     # cd /sys/kernel/debug/clk/mout_peri_bus
> >     # cat clk_possible_parrents
> >       dout_shared0_div4 dout_shared1_div4
> >     # cat clk_parent
> >       dout_shared0_div4
> >     # echo 1 > clk_parent
> >     # cat clk_parent
> >       dout_shared1_div4
> >
> > CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> > order to use this feature.
>
> ...
>
> > +static ssize_t current_parent_write(struct file *file, const char __user *ubuf,
> > +                                   size_t count, loff_t *ppos)
> > +{
> > +       struct seq_file *s = file->private_data;
> > +       struct clk_core *core = s->private;
> > +       struct clk_core *parent;
>
> > +       char buf[4] = { 0 };
>
> We may use {} (in a more standardized way), but see below.
>
> > +       u8 idx;
> > +       int err;
>
> > +       if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> > +               return -EFAULT;
> > +
> > +       err = kstrtou8(buf, 0, &idx);
> > +       if (err)
> > +               return err;
>
> NIH kstrotu8_from_user().
>

Cool, didn't know about that API existence. Will fix in v5.

> > +       parent = clk_core_get_parent_by_index(core, idx);
> > +       if (!parent)
> > +               return -ENOENT;
> > +
> > +       clk_prepare_lock();
> > +       err = clk_core_set_parent_nolock(core, parent);
> > +       clk_prepare_unlock();
> > +       if (err)
> > +               return err;
> > +
> > +       return count;
> > +}
>
> ...
>
> > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > +               if (core->num_parents > 1) {
> > +                       debugfs_create_file("clk_parent", 0644, root, core,
> > +                                           &current_parent_rw_fops);
>
> > +               } else {
> > +                       debugfs_create_file("clk_parent", 0444, root, core,
> > +                                           &current_parent_fops);
> > +               }
> > +#else
> >                 debugfs_create_file("clk_parent", 0444, root, core,
> >                                     &current_parent_fops);
>
> Dup. You can avoid it.
>

You're right, will be fixed in v5.

Thanks for the review!

> > +#endif
> > +       }
>
> --
> With Best Regards,
> Andy Shevchenko
