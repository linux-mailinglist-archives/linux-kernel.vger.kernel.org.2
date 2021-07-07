Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5131D3BE236
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 06:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhGGEyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 00:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhGGEyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:54:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E568C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 21:52:13 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o10so1083021ils.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 21:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SuV0FS1Rmoq2JFer3xZi2jCgPPZLaF0oc2gCHaleOM=;
        b=OE3rk9upNVuoBlg+S2FZC+WQOPTU90LRqwI1CCNWOyhd6+bkXnLf3nIRzq4W3VCBSh
         LLyvE490ASL8/g+d3MKXrNj+gqK8yvsLZ144duceQHqhgJFADs7tOhmmII4sOpsnYtp7
         Q5C2VdNCiTlmnv2Jlp6rbiMtg1Ri+VMj2U4Y8XBjXmXXOeID090UMkuEsy/MJe1PW91B
         sfdg2Upoq5JiJgEJEZe+wCCYPgs+qkLbM+Et7KvXEDwKMBzg0CgPzvjk40weG7uHiVrN
         yGKFN/wcNzfjb0KYHm26Dep6xw8Ddtqt0elM9NFborabjYIkvjGVJrCuDlDfJd5fE4q3
         jAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SuV0FS1Rmoq2JFer3xZi2jCgPPZLaF0oc2gCHaleOM=;
        b=jyAt6Z/Dk27wOJwHMqQvtubJdZSm+xy6VNeVlvDaJQ7I/mpWX3530ok6+JCvj4GQgE
         ryUG8oMlJWGOAfJezFunf9FK3XFG4fCnPUUaRN/FIhZAWBCFbnjZc88M8D9nQ8QJya0t
         U/XOVJrbC8Y6KqKjeAWF7rJU5A5Iej5+H/RuhTnx+g4gALkfXtHChvKPVqajEB9pUwi3
         dlr4lDV1uFEJMVrsi/JQTPKpLfyxrSkzgQTvSTAzt77pVH5mbSuFDpLAxPfZngRhEX4x
         ZZABWrqRbbs51MnWdrMByd9qLcOOrs7d50e+hns3lJ6xpe0+yBtxIU6pobAZe40J8yXV
         KWVg==
X-Gm-Message-State: AOAM533Oe8+1HnTENXImJJKZX8FGVqZvUuQuxlaWqzNhow3B2UE3Bm5M
        mTYFC3nOPGfp7DXQNIGGIUYKB9grCd5iQiYrItw=
X-Google-Smtp-Source: ABdhPJwutmRF0xhwqWDnQeZqfITo2przfyRs+GJ69artAEM7SBEH/nNL/HCxzkPAOccuLhyN7A1tbbgBdj3e45PayYA=
X-Received: by 2002:a92:a00e:: with SMTP id e14mr17027629ili.126.1625633533082;
 Tue, 06 Jul 2021 21:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
 <20210706030904.1411775-6-chenhuacai@loongson.cn> <874kd78u0c.wl-maz@kernel.org>
In-Reply-To: <874kd78u0c.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 12:52:01 +0800
Message-ID: <CAAhV-H7=uMXF0EHiuBSWwEskuLrqpKjKaUMB8T_qi6kpDDJp+A@mail.gmail.com>
Subject: Re: [PATCH 5/9] irqchip/loongson-htvec: Add ACPI init support
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

On Tue, Jul 6, 2021 at 9:13 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 06 Jul 2021 04:09:00 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not MIPS)
> > support. LoongArch use ACPI other than DT as its boot protocol, so
> > add ACPI init support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-htvec.c | 102 ++++++++++++++++++++++++++-
> >  1 file changed, 101 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
> > index 60a335d7e64e..69452d4a33c0 100644
> > --- a/drivers/irqchip/irq-loongson-htvec.c
> > +++ b/drivers/irqchip/irq-loongson-htvec.c
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
> > + *                   Jianmin Lv <lvjianmin@loongson.cn>
> > + *                   Huacai Chen <chenhuacai@loongson.cn>
>
> Drop this, move the suspend/resume code to its own patch, de-duplicate
> the probing code.
>
> Do I sound like a stuck record?
OK, I will rework this.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
