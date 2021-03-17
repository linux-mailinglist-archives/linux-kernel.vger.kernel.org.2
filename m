Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53BE33EB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCQIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCQIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:31:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F287C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:31:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so784206wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vjiwbzbA8IYE1XV320ax9Kro96quaaA91f7yjl2jDg=;
        b=w0OYVWsfUOclHsEp9Zg5Mb7BBfeg554unIreZ2+JU7Dw9Iazmmquuvl8/08zIYY8p7
         vjzYTh9Mb1X9ups5tq7/8pX/8FfQ6jelvZAVXkYJKi6+0swjA1NXuajz5TJ9zSIfKArO
         MaDDQSzdeo8xp86IPUwhrnmb3EKCuwRiskp6UJQDUcWo/WvK8jsE8COIFPKrTAgh2pkF
         hOshDXkPJkcwnhKWVsXm6BTO56Xz+XU9XfLOWuisWdK2+BkHa2hq5Cgbpc4NKNyWfl0y
         rIfGZELZhcbZ/LNM7A6v/8tbM296weOpDYSdaenULKGIVKsFJd5AYnKRRvEPuWPZOwGl
         p+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vjiwbzbA8IYE1XV320ax9Kro96quaaA91f7yjl2jDg=;
        b=Vaq7VAstNtlkfdjUwuhnGuNqzKptceqgSy19wZbUyMzFDm5dt4mOP0wHR/kHpC2oTK
         xEVtEO4RgWWYyGx8tBLAwrAdrAEHKiWZ84nVV+/l3lInwaOQgTt+SEntP1bJlIpvkUP4
         RqfglEXJooaRWCf10VNncD86TcTUVHjh4BEgZAfyX6v1df7gW/GVRZD7b6ddppwcX/jf
         aP6IdPVyI44cG4XxMwM6mcSrEZ9ntph2Fk0c/4iVxTWBt1MzvLg1ppHouQxHCQcmmgEh
         /8O3KKSzhYS0l0K2ouYPdTOYllehSBUEM0PmwJulnFJvikrNF2F6/0qa91BF7JEZzY37
         Q1sA==
X-Gm-Message-State: AOAM5326nZIopxTLXmtMQo4cujOD6m8nhxq6VV84epICJIXVmafVBt23
        9wrSj/BARhwsxgPCJm9hsT0Z9bcpQSER7RiBfdBzvg==
X-Google-Smtp-Source: ABdhPJzjxW0MI2nIZu00KPfbZrQJvdakT/LohkLISl3B3zJubs3TMKed8g8s9zrp8uVcUglvefASoIAZ2/iTHto+Duo=
X-Received: by 2002:a1c:bd55:: with SMTP id n82mr2488447wmf.3.1615969879781;
 Wed, 17 Mar 2021 01:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210315110500.802897-2-anup.patel@wdc.com> <mhng-15799b77-832f-49f3-ac18-af2ec08eebf5@palmerdabbelt-glaptop>
In-Reply-To: <mhng-15799b77-832f-49f3-ac18-af2ec08eebf5@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 17 Mar 2021 14:01:06 +0530
Message-ID: <CAAhSdy3BzeU42CYO2fJ0LN31hpE=+CTxb=ys1GcC+h4uPVQ-jQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] RISC-V: Don't print SBI version for all detected extensions
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:38 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 15 Mar 2021 04:04:59 PDT (-0700), Anup Patel wrote:
> > The sbi_init() already prints SBI version before detecting
> > various SBI extensions so we don't need to print SBI version
> > for all detected SBI extensions.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/kernel/sbi.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index f4a7db3d309e..c0dcebdd30ec 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -577,19 +577,19 @@ void __init sbi_init(void)
> >                       sbi_get_firmware_id(), sbi_get_firmware_version());
> >               if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
> >                       __sbi_set_timer = __sbi_set_timer_v02;
> > -                     pr_info("SBI v0.2 TIME extension detected\n");
> > +                     pr_info("SBI TIME extension detected\n");
> >               } else {
> >                       __sbi_set_timer = __sbi_set_timer_v01;
> >               }
> >               if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
> >                       __sbi_send_ipi  = __sbi_send_ipi_v02;
> > -                     pr_info("SBI v0.2 IPI extension detected\n");
> > +                     pr_info("SBI IPI extension detected\n");
> >               } else {
> >                       __sbi_send_ipi  = __sbi_send_ipi_v01;
> >               }
> >               if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
> >                       __sbi_rfence    = __sbi_rfence_v02;
> > -                     pr_info("SBI v0.2 RFENCE extension detected\n");
> > +                     pr_info("SBI RFENCE extension detected\n");
> >               } else {
> >                       __sbi_rfence    = __sbi_rfence_v01;
> >               }
>
> Thanks.  I'm just putting this one on for-next so you don't have to carry
> around the diff.

Thanks Palmer.
