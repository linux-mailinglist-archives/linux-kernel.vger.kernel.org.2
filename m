Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1F3332FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhCJCIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhCJCIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:08:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDB5165007
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615342099;
        bh=bQ55CC6tmr8YhH0VQIaUBJ8fMpBAeOsrBFxLNLe1qoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=plKwgxGiotlX9H8juB66WOn2abcYfjQ4ZPEpIQi8fAbLvPuGkEdcwbPhplPCy69Mx
         2Wy5tsBwrvXtt9MmIiorA/2JmNY1WCcRSb+t8pdfAQRrBkOSb/+ey88fU6qLY35kNh
         hZ8BXethbJv35OQnadWvbRvLj+hc5kNP6aa3v9R0N36xurZ3df/8LPOq+nhhN3qb06
         SQ59T/KHUqsUSP1gyCUz16wYW7M0DJrw0/BEkaOnUSMt3MCSJtfyj4hJuMh0FE7xgp
         yVN7Dsl2aSXJeNY+VQwCRZG1Yf3BK6RnRsGYktTHP5TecjlPRunyWjzhMiheLF7WTu
         Id+kqwMwc3JrA==
Received: by mail-ej1-f44.google.com with SMTP id ci14so34084820ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 18:08:18 -0800 (PST)
X-Gm-Message-State: AOAM533P1/CZDCM8Ee+FDA8UCsRahIGwVAjGTXqP2YLqr8cTm7zDva7p
        U4U+66IKzNvsvyzx+KfSZP0TSAU+c/QmKpCUWQ==
X-Google-Smtp-Source: ABdhPJw9ajIWGdjNsTd246RLhKFda1I86Dm8k6yu75mEgWnrYmIED2kbAucwe1ggAH3lTiRQqSOo9MvgD8hj9Z/DSpI=
X-Received: by 2002:a17:906:1d44:: with SMTP id o4mr967756ejh.130.1615342097419;
 Tue, 09 Mar 2021 18:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
In-Reply-To: <20210220005204.1417200-1-bauerman@linux.ibm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 19:08:05 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
Message-ID: <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 6:52 PM Thiago Jung Bauermann
<bauerman@linux.ibm.com> wrote:
>
> Commit 2377c92e37fe ("powerpc/kexec_file: fix FDT size estimation for kdump
> kernel") fixed how elf64_load() estimates the FDT size needed by the
> crashdump kernel.
>
> At the same time, commit 130b2d59cec0 ("powerpc: Use common
> of_kexec_alloc_and_setup_fdt()") changed the same code to use the generic
> function of_kexec_alloc_and_setup_fdt() to calculate the FDT size. That
> change made the code overestimate it a bit by counting twice the space
> required for the kernel command line and /chosen properties.
>
> Therefore change kexec_fdt_totalsize_ppc64() to calculate just the extra
> space needed by the kdump kernel, and change the function name so that it
> better reflects what the function is now doing.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h  |  2 +-
>  arch/powerpc/kexec/elf_64.c       |  2 +-
>  arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
>  3 files changed, 10 insertions(+), 20 deletions(-)

I ended up delaying the referenced series til 5.13, but have applied
it now. Can I get an ack from the powerpc maintainers on this one?
I'll fixup the commit log to make sense given the commit id's aren't
valid.

Rob
