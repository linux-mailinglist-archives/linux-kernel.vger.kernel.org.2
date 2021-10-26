Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774FB43B137
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhJZL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhJZL2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:28:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B8F160F9B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635247577;
        bh=tj9TPpbICm0vt1k7otsj987q68Wno50MNK6OwTmsIi8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aCed96h3OB1w5uvXwzkKT7C+d0iANTq1i7wJCZYfN6UzvWek+MKiA7CwNC9CpX30f
         vIDffSM6eiMK8zSi9UnJGAR2Ze/7hDTOkQe1Aoa5tiKdLs67CLJhC9BlerjQdXlZXS
         2d39B+7hM1FyW7FVnmXEci7OY0hkKraXSBWYTiTuBGXEr3ly6vYQr4t6kRRrlaJdaa
         IZ871Qlh9nEncwBAbHkFbkKh49sdwPCQHktFWWNtYHVMgKCigCckJw1hefOqm2bRZZ
         ZmkxcOiUpW0hTuTmlLwA7rzxc4X8ByW1X0eIR9PoLoKbMrRch5FHUA1VyMaZa3yAbq
         Cv/3Fz5AHeB6A==
Received: by mail-oi1-f174.google.com with SMTP id n63so20054700oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:26:17 -0700 (PDT)
X-Gm-Message-State: AOAM531GrNpjjXtOYdlGd7wHQM408wC048jJ7dkyvWAVfWVytmXHhhtH
        p7jatWd6DkhDL2hrx6V8eMZ3L+AJ/aWLYkJ2Dfo=
X-Google-Smtp-Source: ABdhPJx+ICu+8O5CPTn5C8IFOQNof1VH8143BDNaGEHGdQlYtaIOiG7eTODREgLFe3Hmqg/Dk92Re5dLbWWDihPSFR0=
X-Received: by 2002:a05:6808:1805:: with SMTP id bh5mr27062624oib.47.1635247576878;
 Tue, 26 Oct 2021 04:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
 <YXfDdmrCynZk/QW8@shell.armlinux.org.uk> <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
 <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
 <8905597e-49a9-c898-c78d-3d2f51180133@windriver.com> <YXfegIP+Xamfcnfp@shell.armlinux.org.uk>
 <CAMj1kXH+PZsSkCQSxWck-AuqkmRxyKy=4i5Xst8J+dqy_G92uQ@mail.gmail.com> <YXfjbteoVlZLFerq@shell.armlinux.org.uk>
In-Reply-To: <YXfjbteoVlZLFerq@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 Oct 2021 13:26:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH6HA1a_M54EjiW_5Z90LtoAhLDo99fwRrUp_vLgDsJqw@mail.gmail.com>
Message-ID: <CAMj1kXH6HA1a_M54EjiW_5Z90LtoAhLDo99fwRrUp_vLgDsJqw@mail.gmail.com>
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Quanyang Wang <quanyang.wang@windriver.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 at 13:16, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 26, 2021 at 12:56:08PM +0200, Ard Biesheuvel wrote:
> > On Tue, 26 Oct 2021 at 12:55, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Oct 26, 2021 at 06:38:16PM +0800, Quanyang Wang wrote:
> > > > Hi Ard,
> > > >
> > > > On 10/26/21 6:12 PM, Ard Biesheuvel wrote:
> > > > > On Tue, 26 Oct 2021 at 11:53, Quanyang Wang <quanyang.wang@windriver.com> wrote:
...
> > > > But the ptep is calculated by "kmap_pte - idx", which means all ptes must be
> > > > placed next to each other and no gaps. But for ARM, the ptes for the range
> > > > "0xffe00000~0xfff00000" is not next to the ptes for the range
> > > > "0xffc80000~0xffdfffff".
> > > >
> > > > When the idx is larger than 256, virtual address is in 0xffdxxxxx, access
> > > > this address will crash since its pteval isn't set correctly.
> > >
> > > Thanks for the explanation.
> > >
> > > Sadly, this does seem to be correct. Even if the PTE tables are
> > > located next to each other in memory, they _still_ won't be a
> > > contiguous array of entries due to being interleaved with the Linux
> > > PTE table and the hardware PTE table.
> > >
> > > Since the address range 0xffe00000-0xfff00000 is already half of one
> > > PTE table containing 512 contiguous entries, we are limited to 256
> > > fixmap PTEs maximum. If we have more than that we will start trampling
> > > over memory below the PTE table _and_ we will start corrupting Linux
> > > PTE entries in the 0xfff00000-0xffffffff range.
> > >
> > > I suspect this hasn't been seen because of a general lack of ARM
> > > systems with more than 4 CPUs.
> > >
> >
> > But doesn't that make it a kmap_local regression? Or do you think this
> > issue existed before that as well?
>
> It definitely is a bug in tglx's kmap_local code, which assumes all
> PTEs in the fixmap region are contiguously arranged.
>
> Looking back further, when local kmaps were handled in arch code, this
> bug did /not/ exist. We used to get the PTE entry to update via:
>
>         unsigned long vaddr = __fix_to_virt(idx);
>         pte_t *ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
>
> which later became:
>
>         pte_t *ptep = virt_to_kpte(vaddr);
>
> Both of which walk the page tables.
>
> So in summary a regression caused by converting ARM to kmap_local.
>
> I think we could fix it by providing our own arch_kmap_local_set_pte()
> which ignores the ptep argument, and instead walks the page tables
> using the vaddr argument.
>

Removing all occurrences of 'kmap_pte - idx' and replacing them with
virt_to_kpte() seems to do the trick. Unfortunately, these occur in
other places as well, not only on the map path, so I doubt that
overriding arch_kmap_local_set_pte will be sufficient.
