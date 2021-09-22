Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BBA4148F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhIVMeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:34:20 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:36783 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbhIVMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:34:19 -0400
Received: by mail-vk1-f171.google.com with SMTP id t186so1077273vkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/nhv1c3kfB+8GUpcbKdwWWl/t1iJqUbmVf63u/XqWY=;
        b=fHP/xYtCuLN+tA4vsSqFwHgav0TX/QXdNOER72wqr7opICZ7U+h/04Hwwm9+qPjn4V
         IiLQmotEf6J8eLofy5i9ynsyyKshWE12W9pNVpuxOsOupUEcTCJzsp+LhJClH41P+ssD
         6cCXdWPtNkFy+VteHdO8wOSTt7lRPA0rRP+ElGE9FpEHsICyrGkqOnoUIJAFyX2N4ldK
         j3P6VB+voU1kK/cU0MO+MSbT08aWleReGkbU2VxDcnwJq6K8UvoQRgIHr1qrOf/08RO7
         d8kKJ/ujM9CH6ZShLrGBWvNw58iWLSzHaXvcFKiK60rv3ERyTl3Moq1rffhmPxbx53KJ
         KtIw==
X-Gm-Message-State: AOAM532mkMecTdXOGV8cjlOnhNlBFUjmoQWa8PtIQ6XBQvni+DJo+9hG
        +MwWh+yOOiU3xwV5syDSbyTapmLsLnxTPoteyF0=
X-Google-Smtp-Source: ABdhPJxth2FYG46f0S5OWGAuSsEkUNQOSjbi8d7mL7ridoO4xhKND97RZqrl1VQPIyKGRp4zN7o8NWtJxjo0/BMvl6c=
X-Received: by 2002:a1f:5e14:: with SMTP id s20mr23127866vkb.7.1632313969468;
 Wed, 22 Sep 2021 05:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210921215218.89844-1-michael.christie@oracle.com> <20210921215218.89844-4-michael.christie@oracle.com>
In-Reply-To: <20210921215218.89844-4-michael.christie@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Sep 2021 14:32:37 +0200
Message-ID: <CAMuHMdXhtq-6vcU_1qYfT_ChPGsnhLAA_yZwPz7ERJgxJERK7Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] fork: move PF_IO_WORKER's kernel frame setup to
 new flag
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, Christoph Hellwig <hch@infradead.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Sep 21, 2021 at 11:55 PM Mike Christie
<michael.christie@oracle.com> wrote:
> The vhost worker threads need the same frame setup as io_uring's worker
> threads, but handle signals differently and do not need the same
> scheduling behavior. This patch separate's the frame setup parts of
> PF_IO_WORKER into a kernel_clone_args flag, KERN_WORKER_USER.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Thanks for your patch!

> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -157,7 +157,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>          */
>         p->thread.fs = get_fs().seg;
>
> -       if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +       if (unlikely(p->flags & (PF_KTHREAD) ||
> +                    worker_flags & KERN_WORKER_USER)) {

I guess it wouldn't hurt to add parentheses to improve
readability:

    if (unlikely((p->flags & (PF_KTHREAD)) ||
                 (worker_flags & KERN_WORKER_USER))) {

>                 /* kernel thread */
>                 memset(frame, 0, sizeof(struct fork_frame));
>                 frame->regs.sr = PS_S;

With the above fixed, for m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
