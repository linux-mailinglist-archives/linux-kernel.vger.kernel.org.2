Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B604C434308
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhJTBo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:44:56 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:37635 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJTBox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:44:53 -0400
Received: by mail-qt1-f174.google.com with SMTP id w8so1734052qts.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phuizum7Jvmwq/i5uKXc0tZWrbM+XXyJMZ25fUOpTLs=;
        b=YSVIYkhsKPvt6sUNEjv9JGF7yIuB6VRoyVm5XFNV1zudfhZ4K0sV2QwTcLq6Pzvv25
         vIk/8BzCrKw6zLOdGC2uhbp9mHiNqecCYw/rlwB9PeL74weto9dQbb26UiF7kVmjf2Rz
         dfXsLgB3E3I2lgTpRNotqr7jvZnuMyy85aP8pXfLW+crroYVCuomFSk9bwSKK3CHKpw0
         4MCqOl6k58htD1OazvPFg37d+QlciwNLTol5nKjEOgU4PrkkGvxYgXo+FeUbr/FW70cz
         EkbuEJZJAB3MjpgH56hwMyu9SY0405iWvU9WGAmRwUIgd4DZg/WZ7VIxxhkWoNPn6M4A
         U2jw==
X-Gm-Message-State: AOAM531asVH2an0AFLKdSCXUHZK6VmCUQMCuo1ESp6jTJ9rl2sL/VYU1
        3kTOMLWTV7RSa1v45oxZSPHI+X1RQ8Q=
X-Google-Smtp-Source: ABdhPJy/ja1TkZRKcCm+Ky9EHmqtXH4D1fagNoNn6u0z9Zj/KxqXnbkYKrFruIhz/G/TbCgCtq1T0Q==
X-Received: by 2002:ac8:1e9e:: with SMTP id c30mr3783791qtm.238.1634694158854;
        Tue, 19 Oct 2021 18:42:38 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id d23sm346913qtm.11.2021.10.19.18.42.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 18:42:38 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id t16so1728321qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:42:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1050:: with SMTP id f16mr3965552qte.127.1634694158181;
 Tue, 19 Oct 2021 18:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211019030555.29461-1-Meng.Li@windriver.com>
In-Reply-To: <20211019030555.29461-1-Meng.Li@windriver.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 19 Oct 2021 20:42:27 -0500
X-Gmail-Original-Message-ID: <CADRPPNSuZ9Jidm7tg+BTu_iwbxHE8i+1J3wkPLF0CZuGNd3RDg@mail.gmail.com>
Message-ID: <CADRPPNSuZ9Jidm7tg+BTu_iwbxHE8i+1J3wkPLF0CZuGNd3RDg@mail.gmail.com>
Subject: Re: [PATCH] driver: soc: dpio: use the whole functions to protect
 critical zone
To:     Meng.Li@windriver.com
Cc:     Youri Querry <youri.querry_1@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:07 PM <Meng.Li@windriver.com> wrote:
>
> From: Meng Li <Meng.Li@windriver.com>
>
> In orininal code, use 2 function spin_lock() and local_irq_save() to
> protect the critical zone. But when enable the kernel debug config,
> there are below inconsistent lock state detected.
> ================================
> WARNING: inconsistent lock state
> 5.10.63-yocto-standard #1 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> lock_torture_wr/226 [HC0[0]:SC1[5]:HE1:SE0] takes:
> ffff002005b2dd80 (&p->access_spinlock){+.?.}-{3:3}, at: qbman_swp_enqueue_multiple_mem_back+0x44/0x270
> {SOFTIRQ-ON-W} state was registered at:
>   lock_acquire.part.0+0xf8/0x250
>   lock_acquire+0x68/0x84
>   _raw_spin_lock+0x68/0x90
>   qbman_swp_enqueue_multiple_mem_back+0x44/0x270
>   ......
>   cryptomgr_test+0x38/0x60
>   kthread+0x158/0x164
>   ret_from_fork+0x10/0x38
> irq event stamp: 4498
> hardirqs last  enabled at (4498): [<ffff800010fcf980>] _raw_spin_unlock_irqrestore+0x90/0xb0
> hardirqs last disabled at (4497): [<ffff800010fcffc4>] _raw_spin_lock_irqsave+0xd4/0xe0
> softirqs last  enabled at (4458): [<ffff8000100108c4>] __do_softirq+0x674/0x724
> softirqs last disabled at (4465): [<ffff80001005b2a4>] __irq_exit_rcu+0x190/0x19c
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>        CPU0
>        ----
>   lock(&p->access_spinlock);
>   <Interrupt>
>     lock(&p->access_spinlock);
>  *** DEADLOCK ***
>
> So, in order to avoid deadlock, use the whole functinos

s/functinos/functions/

> spin_lock_irqsave/spin_unlock_irqrestore() to protect critical zone.
>
> Fixes: 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Applied for fix.  Thanks.

> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
> index 845e91416b58..a56dbe4de34f 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -785,8 +785,7 @@ int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
>         int i, num_enqueued = 0;
>         unsigned long irq_flags;
>
> -       spin_lock(&s->access_spinlock);
> -       local_irq_save(irq_flags);
> +       spin_lock_irqsave(&s->access_spinlock, irq_flags);
>
>         half_mask = (s->eqcr.pi_ci_mask>>1);
>         full_mask = s->eqcr.pi_ci_mask;
> @@ -797,8 +796,7 @@ int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
>                 s->eqcr.available = qm_cyc_diff(s->eqcr.pi_ring_size,
>                                         eqcr_ci, s->eqcr.ci);
>                 if (!s->eqcr.available) {
> -                       local_irq_restore(irq_flags);
> -                       spin_unlock(&s->access_spinlock);
> +                       spin_unlock_irqrestore(&s->access_spinlock, irq_flags);
>                         return 0;
>                 }
>         }
> @@ -837,8 +835,7 @@ int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
>         dma_wmb();
>         qbman_write_register(s, QBMAN_CINH_SWP_EQCR_PI,
>                                 (QB_RT_BIT)|(s->eqcr.pi)|s->eqcr.pi_vb);
> -       local_irq_restore(irq_flags);
> -       spin_unlock(&s->access_spinlock);
> +       spin_unlock_irqrestore(&s->access_spinlock, irq_flags);
>
>         return num_enqueued;
>  }
> --
> 2.17.1
>
