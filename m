Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60853A89D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFOT5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOT5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E87B1613B3;
        Tue, 15 Jun 2021 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623786910;
        bh=bituzxZsqdopUSe7H+7dgGu7+/LuAeIRC6g+riCNdW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pyYvj+5I7sSOM9PEvRIdjBFDj2k8DBIhVZ0dpMl9Nipibi6OTDUsR+HHdSA8FH1s9
         wKsXp4YNj/fHsswHPFqu4J9FpHoL3GJdk3JzLSRK0bCEVSb6CQS/sqjKHR8Ryr/KJW
         Lz0q+s8eV1flDjDJ7HvOA0+QJkSoZcGcx+ppvEfDDK01P/SdsZ7BDDF1kMJUuir8u0
         95YKeKsTJglBnu6eo2NVMSA6UdQlm6XDYQchq5KC1KqRys978oCJt+rkf5vt3McavD
         gBEl/MTUh6RpaTfwd/bqRgXsPAcwCUsgTrjwkBXnptgdWO+mjVLDIBODCv/zLZ9Te+
         wwPMULhbckVjQ==
Received: by mail-ej1-f41.google.com with SMTP id nd37so16738114ejc.3;
        Tue, 15 Jun 2021 12:55:10 -0700 (PDT)
X-Gm-Message-State: AOAM532XgPE24jdSvqQurgsHldCkzg9AXh2PLTlYq/BCRfPbweQhcBrx
        CZiNngfErN76922LOJPKCOHOA678DSslG9ykFw==
X-Google-Smtp-Source: ABdhPJwgw4hx5crsunBDkcPAMm2Nmrwncl6HIzcmyuFxYmWV/H4yT2u/a4jul9wKeNr6Pje8ZrIZBI9vMUxDEZ7ekHE=
X-Received: by 2002:a17:907:2059:: with SMTP id pg25mr1310053ejb.130.1623786909575;
 Tue, 15 Jun 2021 12:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623780059.git.geert+renesas@glider.be> <8661d652968d050489852ccb50df5ad4cc048900.1623780059.git.geert+renesas@glider.be>
In-Reply-To: <8661d652968d050489852ccb50df5ad4cc048900.1623780059.git.geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 13:54:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Ozd_+__+v7LEsDjvydymuRF=+T9NnmOd-htqCQ22nCA@mail.gmail.com>
Message-ID: <CAL_Jsq+Ozd_+__+v7LEsDjvydymuRF=+T9NnmOd-htqCQ22nCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] of: fdt: Add generic support for parsing elf core
 header properties
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:17 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There are two methods to specify the location of the elf core header:
> using the "elfcorehdr=" kernel parameter, as handled by generic code in
> kernel/crash_dump.c, or using the "linux,elfcorehdr" property under the
> "/chosen" node in the Device Tree, as handled by architecture-specific
> code in arch/arm64/mm/init.c.
>
> Extend support for "linux,elfcorehdr" to all platforms supporting DT by
> adding platform-agnostic handling for parsing this property to the FDT
> core code.  This can co-exist safely with the architecture-specific
> handling, until the latter has been removed.
>
> This requires moving the call to of_scan_flat_dt() up, as the code
> scanning the "/chosen" node now needs to be aware of the values of
> "#address-cells" and "#size-cells".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/chosen.txt |  6 ++--
>  drivers/of/fdt.c                             | 37 ++++++++++++++++++--
>  2 files changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646c537..5b0b94eb2d04e79d 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -106,9 +106,9 @@ respectively, of the root node.
>  linux,elfcorehdr
>  ----------------
>
> -This property (currently used only on arm64) holds the memory range,
> -the address and the size, of the elf core header which mainly describes
> -the panicked kernel's memory layout as PT_LOAD segments of elf format.
> +This property holds the memory range, the address and the size, of the elf
> +core header which mainly describes the panicked kernel's memory layout as
> +PT_LOAD segments of elf format.
>  e.g.
>
>  / {
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a03d43f95495d8e1..f13db831c8028cce 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt)    "OF: fdt: " fmt
>
> +#include <linux/crash_dump.h>
>  #include <linux/crc32.h>
>  #include <linux/kernel.h>
>  #include <linux/initrd.h>
> @@ -909,6 +910,35 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
> +#ifdef CONFIG_CRASH_DUMP
> +/**
> + * early_init_dt_check_for_elfcorehdr - Decode elfcorehdr location from flat
> + * tree
> + * @node: reference to node containing elfcorehdr location ('chosen')
> + */
> +static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
> +{
> +       const __be32 *prop;
> +       int len;
> +
> +       pr_debug("Looking for elfcorehdr property... ");
> +
> +       prop = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
> +       if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +               return;
> +
> +       elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +       elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &prop);

If these declarations were moved outside the '#ifdef
CONFIG_CRASH_DUMP' in crash_dump.h, then IS_ENABLED() could be used in
this function.


> +
> +       pr_debug("elfcorehdr_start=0x%llx elfcorehdr_size=0x%llx\n",
> +                elfcorehdr_addr, elfcorehdr_size);
> +}
> +#else
> +static inline void early_init_dt_check_for_elfcorehdr(unsigned long node)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_SERIAL_EARLYCON
>
>  int __init early_init_dt_scan_chosen_stdout(void)
> @@ -1057,6 +1087,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>                 return 0;
>
>         early_init_dt_check_for_initrd(node);
> +       early_init_dt_check_for_elfcorehdr(node);
>
>         /* Retrieve command line */
>         p = of_get_flat_dt_prop(node, "bootargs", &l);
> @@ -1201,14 +1232,14 @@ void __init early_init_dt_scan_nodes(void)
>  {
>         int rc = 0;
>
> +       /* Initialize {size,address}-cells info */
> +       of_scan_flat_dt(early_init_dt_scan_root, NULL);
> +
>         /* Retrieve various information from the /chosen node */
>         rc = of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
>         if (!rc)
>                 pr_warn("No chosen node found, continuing without\n");
>
> -       /* Initialize {size,address}-cells info */
> -       of_scan_flat_dt(early_init_dt_scan_root, NULL);
> -
>         /* Setup memory, calling early_init_dt_add_memory_arch */
>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>  }
> --
> 2.25.1
>
