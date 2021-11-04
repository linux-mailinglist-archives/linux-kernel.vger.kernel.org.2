Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E684450E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhKDJK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhKDJKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:10:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 474746120F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636016868;
        bh=R27FIfu7jHh5qwiMN++UMDXOmhpT/y+CHg7lzhq219M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dw4U3bB0ymILysfIXWK8vpcA+XA2+bV/vU8mel8F8THSsX+vvCa1RbDqb8E2vavY+
         7O1RGOWjWGAEKWg3xJ1v9ZOSFVrOOzYvkXO4NtwvTBlsY4Z4sSYfrPIXJedrJAGYdk
         NY77UNbvKRXRGp8O4P4b2Dhio0V22P2uFOjDuos8mIWbwGkocT5MsCxZGsh+YHdu0d
         E2JbUksN97kC84TWmM+WZpVc9GcPEfsQb7xYtcoPr5eOLONWgnoOx5ChK0fvfxsxIn
         uuCe0GtC+L/PRYz5X/HNn2I9lXgx2hDXHkDVnVgXOVinreR/QdB1dBDpeJKV+hZHlc
         pDZ5IqCCdR7ow==
Received: by mail-ot1-f52.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so4177354otv.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 02:07:48 -0700 (PDT)
X-Gm-Message-State: AOAM530vJB/Z7LGly+ar+fhQCxtSyQJzfcn+rLwTx+P8lV5i4amLUAv5
        f0xCPA1SHMaK8Vby5yDdfiF84c9LmMX2NrCFnnM=
X-Google-Smtp-Source: ABdhPJynE9PXEqIl6ipGPMx25k006zcLfIVGsi3mGi2l+xbvtl5qBGXky+cCQ9oxezjrNAEi/8Qhf0PVuYwpuv1/yY8=
X-Received: by 2002:a05:6830:14c:: with SMTP id j12mr7351037otp.147.1636016867558;
 Thu, 04 Nov 2021 02:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <990f4427968071d59bcbb7411da73acc379d3ac4.1635986046.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <990f4427968071d59bcbb7411da73acc379d3ac4.1635986046.git.mirq-linux@rere.qmqm.pl>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Nov 2021 10:07:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEsm1oK5uPqku7uJfF=FeKx1fEjTu80czZPguQPBO_z2w@mail.gmail.com>
Message-ID: <CAMj1kXEsm1oK5uPqku7uJfF=FeKx1fEjTu80czZPguQPBO_z2w@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix early early_iounmap()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jon Medhurst <tixy@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 at 01:46, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmq=
m.pl> wrote:
>
> Currently __set_fixmap() bails out with a warning when called in early bo=
ot
> from early_iounmap(). Fix it, and while at it, make the comment a bit eas=
ier
> to understand.
>
> Cc: <stable@vger.kernel.org>
> Fixes: b089c31c519c ("ARM: 8667/3: Fix memory attribute inconsistencies w=
hen using fixmap")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/mm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index a4e006005107..274e4f73fd33 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -390,9 +390,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr=
_t phys, pgprot_t prot)
>         BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) < FIXADDR_ST=
ART);
>         BUG_ON(idx >=3D __end_of_fixed_addresses);
>
> -       /* we only support device mappings until pgprot_kernel has been s=
et */
> +       /* We support only device mappings before pgprot_kernel is set. *=
/
>         if (WARN_ON(pgprot_val(prot) !=3D pgprot_val(FIXMAP_PAGE_IO) &&
> -                   pgprot_val(pgprot_kernel) =3D=3D 0))
> +                   pgprot_val(prot) && pgprot_val(pgprot_kernel) =3D=3D =
0))
>                 return;
>
>         if (pgprot_val(prot))
> --
> 2.30.2
>
