Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBF3333A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhCJDJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhCJDJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:09:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F8E64DA3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 03:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615345778;
        bh=hHi9H5kl4wpnWvG7xJWgx+rlR2fSM4M2CJlmcTqk4Lc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcCRe4ahcLl+ilOI4Q2TmKUnNWQT709Ih1Ly31MOW62sbSIo2eqTOGJibYu64f86g
         9GE3K/HEKMJMs/DHsf0S+j9cJqY/h6n7Po9UmmGNLjB37Y0WS43B7ScWFUQmOyu+mw
         5lD0H1XelHCgY/HA/6+ZU4HIrDuih50Iz6J+Kfh/gUVj9n6ppOkNoKzwiGf+efP+k0
         cc3ycUWZi/OpppwwL+6FjndLw+7G/U773wFxHHv6cVF6RtJ69933jg2dZCpwv3MJs4
         2JEBKNrWL2Ntj37r//WTRSf7HVI5kfqPNgbrtmSzMJ32sNmAU9RYVNttTsPYw6+jxy
         KShrx5/XUKIiQ==
Received: by mail-ej1-f52.google.com with SMTP id hs11so34626082ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:09:37 -0800 (PST)
X-Gm-Message-State: AOAM5339mJutq2PqcZYhfyTA918dzxX0PdAoTvzFfrfQhCUi1FhgWVEo
        rQ3rUH0kzLDgdE7T3qaqmvWn7WQpeZqh8EZpRg==
X-Google-Smtp-Source: ABdhPJwE7Ujo2AxBz//6JFloBR3AHEXYZ0s2yT2uFYTIgO188foiD1hEWo4q88NF+iArryuCRjHmqLZRu8yeZDKzYg4=
X-Received: by 2002:a17:906:d153:: with SMTP id br19mr1192083ejb.360.1615345776316;
 Tue, 09 Mar 2021 19:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
 <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com> <7d0c6062-ca73-f183-110d-f5b75ae91d10@linux.microsoft.com>
In-Reply-To: <7d0c6062-ca73-f183-110d-f5b75ae91d10@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 20:09:25 -0700
X-Gmail-Original-Message-ID: <CAL_JsqK2M_Wfyd0MJK-0Qk7k=CspQZy6_FL6FTWkURmA_ZcARg@mail.gmail.com>
Message-ID: <CAL_JsqK2M_Wfyd0MJK-0Qk7k=CspQZy6_FL6FTWkURmA_ZcARg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 7:31 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 3/9/21 6:08 PM, Rob Herring wrote:
>
> Hi Rob,
>
> > On Fri, Feb 19, 2021 at 6:52 PM Thiago Jung Bauermann
> > <bauerman@linux.ibm.com> wrote:
> >>
> >> Commit 2377c92e37fe ("powerpc/kexec_file: fix FDT size estimation for kdump
> >> kernel") fixed how elf64_load() estimates the FDT size needed by the
> >> crashdump kernel.
> >>
> >> At the same time, commit 130b2d59cec0 ("powerpc: Use common
> >> of_kexec_alloc_and_setup_fdt()") changed the same code to use the generic
> >> function of_kexec_alloc_and_setup_fdt() to calculate the FDT size. That
> >> change made the code overestimate it a bit by counting twice the space
> >> required for the kernel command line and /chosen properties.
> >>
> >> Therefore change kexec_fdt_totalsize_ppc64() to calculate just the extra
> >> space needed by the kdump kernel, and change the function name so that it
> >> better reflects what the function is now doing.
> >>
> >> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >> ---
> >>   arch/powerpc/include/asm/kexec.h  |  2 +-
> >>   arch/powerpc/kexec/elf_64.c       |  2 +-
> >>   arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
> >>   3 files changed, 10 insertions(+), 20 deletions(-)
> >
> > I ended up delaying the referenced series til 5.13, but have applied
> > it now. Can I get an ack from the powerpc maintainers on this one?
> > I'll fixup the commit log to make sense given the commit id's aren't
> > valid.
>
> I checked the change applied in linux-next branch and also Device Tree's
> for-next branch - it looks like v1 of Thiago's patch has been applied.
> Could you please pick up the v2 patch?

Huh? This patch (v2) hasn't been applied to any tree AFAICT.

Rob
