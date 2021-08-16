Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1C3ECD30
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhHPDUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPDUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:20:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B09C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 20:20:11 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a21so6223012ioq.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mgTgXEaZzvsP8DL3dw/IwEPp0dYGUFizEq3vwXvq3U=;
        b=oM9EsyMzkOPgKjtGreRlmyh/05v1OAf/wn925f06olzGhC/DS/BtFPqJ3kvj1l2sX6
         cQuyzDOOwVwc3kKET1ofTE69nZSQ+um64rw5lhzhmA3QLLIWDHcy6EqTREPvnGAbuz53
         WDL1Uf0QMckPmmT4T6hzjTqVXQZOYS6501hBh2G7uHF9tpTAB/TDPpnQAi2isoGI/PQJ
         xn/kq8ZBBOXEbIiC6rW6IF2LsS2IAy3pzkXHs7Fe/b9EoLk/aNWgPnTr0/Nrc+H2e78p
         ZFEz1nNx5z1jLEpG1wo0v7UCP/iv5pb5O5IT6/rT2qbA6gq2cJm+/oLS/tRviS93PhEW
         W5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mgTgXEaZzvsP8DL3dw/IwEPp0dYGUFizEq3vwXvq3U=;
        b=qvFlR1BNyE7N5xCGrM6fHAfkIM9BkL/OA1/UMapXNKBAFlFowNx9sRFkfLKJk2/7S7
         2L0/iOTBCv9mAib7dezJhc+CZYfaVDIIYXGEkM6hH1qXDwXGomIO2W1D1CMBc0M/FBmR
         6kPEogcfLqYEryhbe2xohjJcjMMiwzSz5BlWjVUv01zOMVTk6bSsoFdb8Ovxcl8i7+qn
         FcYC8d660zKiQMfBH/+9OMnB/v3OjxTqMh/TQvZz28xv0QUWJdHVvvaxnG157bJlSVnV
         dvRE3CJ2HzK/Uzhy799uPGHsXamlyZvkadoVWNpyvQjj3wDYoFbA0xV0CPauBAG3Jrot
         KS/Q==
X-Gm-Message-State: AOAM532qbtOj/2ppzHbDlikjZrvh8bgthj2QoCe8Xs37pDacmxfrrck5
        3QfrgfTETYoxqLOcrQeDhUjCQUne3j5rQQ3wNE157clhnuk=
X-Google-Smtp-Source: ABdhPJw8YGq4FFkeaZ1WRh7W942dygJHFAOWuGBus5ph7DkQ/BIURJ9uhr5EFcX1I78cU72AP+EnTvnl0owqQ94BKEw=
X-Received: by 2002:a5d:97d0:: with SMTP id k16mr7304406ios.38.1629084010641;
 Sun, 15 Aug 2021 20:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
 <20210706030904.1411775-4-chenhuacai@loongson.cn> <877di38u5c.wl-maz@kernel.org>
 <CAAhV-H6Fr3hp9kp778SbY7gqRGRntYG=QfT-XJ8zD1c0KJUFgA@mail.gmail.com>
 <CAAhV-H7H9ednNRjPB6k9GxsmbjUGOyo4V_r==+yoyy2cX03zWQ@mail.gmail.com> <87zgtm94hr.wl-maz@kernel.org>
In-Reply-To: <87zgtm94hr.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 16 Aug 2021 11:19:58 +0800
Message-ID: <CAAhV-H5VWfiMu5RGjvmMTbZHJ2b7XmLB1wQcKP1VRuaEnHickw@mail.gmail.com>
Subject: Re: [PATCH 3/9] irqchip/loongson-pch-pic: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Thu, Aug 12, 2021 at 9:28 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 12 Aug 2021 13:23:27 +0100,
> Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> [...]
>
> > > > > +struct fwnode_handle *pch_pic_acpi_init(struct fwnode_handle *parent,
> > > > > +                                     struct acpi_madt_bio_pic *acpi_pchpic)
> > > > > +{
> > > > > +     int count;
> > > > > +     struct pch_pic *priv;
> > > > > +     struct irq_domain *parent_domain;
> > > > > +
> > > > > +     priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > > > > +     if (!priv)
> > > > > +             return NULL;
> > > > > +
> > > > > +     raw_spin_lock_init(&priv->pic_lock);
> > > > > +     priv->base = ioremap(acpi_pchpic->address, acpi_pchpic->size);
> > > > > +     if (!priv->base)
> > > > > +             goto free_priv;
> > > > > +
> > > > > +     priv->domain_handle = irq_domain_alloc_fwnode(priv->base);
> > > > > +     if (!priv->domain_handle) {
> > > > > +             pr_err("Unable to allocate domain handle\n");
> > > > > +             goto iounmap_base;
> > > > > +     }
> > > > > +
> > > > > +     priv->ht_vec_base = acpi_pchpic->gsi_base;
> > > > > +     count = ((readq(priv->base) >> 48) & 0xff) + 1;
> > > > > +     parent_domain = irq_find_matching_fwnode(parent, DOMAIN_BUS_ANY);
> > > > > +     if (!parent_domain) {
> > > > > +             pr_err("Failed to find the parent domain\n");
> > > > > +             goto iounmap_base;
> > > > > +     }
> > > > > +
> > > > > +     priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
> > > > > +                                             count, priv->domain_handle,
> > > > > +                                             &pch_pic_domain_ops, priv);
> > > > > +
> > > > > +     if (!priv->pic_domain) {
> > > > > +             pr_err("Failed to create IRQ domain\n");
> > > > > +             goto iounmap_base;
> > > > > +     }
> > > > > +
> > > > > +     pch_pic_reset(priv);
> > > > > +     pch_pic_priv[nr_pch_pics++] = priv;
> > > > > +
> > > > > +     register_syscore_ops(&pch_pic_syscore_ops);
> > > > > +
> > > > > +     return priv->domain_handle;
> > > > > +
> > > > > +iounmap_base:
> > > > > +     iounmap(priv->base);
> > > > > +free_priv:
> > > > > +     kfree(priv);
> > > > > +
> > > > > +     return NULL;
> > > > > +}
> > > > > +
> > > > > +#endif
> > > >
> > > > A lot of this code is common with its OF counterpart. How about making
> > > > this logic common?
> > > OK, let me think about.
> > Though pch_pic_acpi_init() is similar to pch_pic_of_init(), but it is
> > difficult to make a common function, because we cannot prepare
> > everything before the common function. For example, ioremap() can be
> > the common part, but pch_pic_acpi_init() should get the vector count
> > after ioremap(). If we use an argument to distinguish the caller in
> > the common function, the complexity increases and seems no benefits.
>
> All firmware implementations allocate private data structures, irq
> domains, map MMIO regions, etc. All that can be common. We even have
> APIs that deal with both firmware interfaces.
>
> As for the 'read the vector count from the HW', what does it have to
> do with driving the HW using DT or ACPI? The HW doesn't *know*. If you
> are conflating HW changes and firmware interfaces, then you have
> already lost.
OK, I know, thanks.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
