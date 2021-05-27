Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF33924BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhE0CO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhE0CO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:14:26 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F217C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:12:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ez19so1871309qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tanaD28eog9yBPXOmkpNBLXvgDR4mL/nwt0O/x+V9/k=;
        b=BPMBbv1KdHy+svXIkWnndOqA2O/1X+yCJ9faCarWcs63jRRkE9T0XWY/jfMBKYY8/Q
         F8798ViB41nGCKSUKV2Jh2KucYOO+z5TthNDdl+EtD1DJ9ERDju6Xj2lKwnaLTBQ2Esf
         guRqx4K4Ze6B1QK955diV8mIfElVNABfmQAdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tanaD28eog9yBPXOmkpNBLXvgDR4mL/nwt0O/x+V9/k=;
        b=BVaElJUtLrCVSYz11GMVRKvdYCg1G8JWdIW3aARVh00M8KcFCD+0QPynUUnjYGBIUI
         NT1NrOq7o8PRobahwaPtmM4OsJzcgpBEXw+MNlu1G9h/peiS5CDXkpAuB8M5Nkd7zYbm
         vr7+5wbnjPeK7LVgBfXnWgxXhwc+Yk77PVhG4s+4U8URwTVlGTFRYMxDIXz18sExyXwM
         NGnF3TXCU+6ZAw6BmXWyRA0q+Ri3deVE+S7BYvw9YrX+Hn6Dem4AYlpUSIiuNYoWgVnZ
         SHTLmo8DNWo1iXGaXxaRdJN8XkR1n5qhI/eezin4hoiyyauQq2nbRFCP/TMuZb4xL4Vb
         qqMg==
X-Gm-Message-State: AOAM532cjLl5D0Hrd6dCvWYtnEr/REzXVta75TiqvJOTEPXp/iiQrg5f
        g9zaFyC4v7/WGXP2yAJOnK0PDjUT7im4iY8xiCo=
X-Google-Smtp-Source: ABdhPJx3BmjYlz2S9tJHMEOIAyobkQ/SnYtgh3arapNU6eHGMC7HGrc9MISItYOaZH5cSC0qPmf+uDkWtwdJUSwNRLM=
X-Received: by 2002:a0c:d409:: with SMTP id t9mr1362467qvh.18.1622081572667;
 Wed, 26 May 2021 19:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210526105126.463931-1-gsomlo@gmail.com>
In-Reply-To: <20210526105126.463931-1-gsomlo@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 May 2021 02:12:40 +0000
Message-ID: <CACPK8XeHkQP+6hn0hgq4dKwXG8zXHSOYUdOwoOSO=aFOZ8faXA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/soc/litex: remove 8-bit subregister option
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        pczarnecki@internships.antmicro.com,
        David Gow <davidgow@google.com>,
        Florent Kermarrec <florent@enjoy-digital.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 at 10:55, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Since upstream LiteX recommends that Linux support be limited to
> designs configured with 32-bit CSR subregisters (see commit a2b71fde
> in upstream LiteX, https://github.com/enjoy-digital/litex), remove
> the option to select 8-bit subregisters, significantly reducing the
> complexity of LiteX CSR (MMIO register) accessor methods.
>
> NOTE: for details on the underlying mechanics of LiteX CSR registers,
> see https://github.com/enjoy-digital/litex/wiki/CSR-Bus or the original
> LiteX accessors (litex/soc/software/include/hw/common.h in the upstream
> repository).
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

I like how this simplifies things.

Reviewed-by: Joel Stanley <joel@jms.id.au>

With this change, is there any need to keep the litex acessors around?

There's the 64 bit case, but we don't have any 64 bit CSR registers do we?



> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Joel Stanley <joel@jms.id.au>
> ---
> Changes since v1:
>  - remove LITEX_SUBREG_* macros as suggested by Stafford Horne
>
>  drivers/soc/litex/Kconfig          |  12 ----
>  drivers/soc/litex/litex_soc_ctrl.c |   3 +-
>  include/linux/litex.h              | 103 +++++------------------------
>  3 files changed, 16 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> index e7011d665b15..e6ba3573a772 100644
> --- a/drivers/soc/litex/Kconfig
> +++ b/drivers/soc/litex/Kconfig
> @@ -17,16 +17,4 @@ config LITEX_SOC_CONTROLLER
>           All drivers that use functions from litex.h must depend on
>           LITEX.
>
> -config LITEX_SUBREG_SIZE
> -       int "Size of a LiteX CSR subregister, in bytes"
> -       depends on LITEX
> -       range 1 4
> -       default 4
> -       help
> -       LiteX MMIO registers (referred to as Configuration and Status
> -       registers, or CSRs) are spread across adjacent 8- or 32-bit
> -       subregisters, located at 32-bit aligned MMIO addresses. Use
> -       this to select the appropriate size (1 or 4 bytes) matching
> -       your particular LiteX build.
> -
>  endmenu
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index c3e379a990f2..f75790091d38 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -62,8 +62,7 @@ static int litex_check_csr_access(void __iomem *reg_addr)
>         /* restore original value of the SCRATCH register */
>         litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
>
> -       pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
> -               LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);
> +       pr_info("LiteX SoC Controller driver initialized");
>
>         return 0;
>  }
> diff --git a/include/linux/litex.h b/include/linux/litex.h
> index 5ea9ccf5cce4..f2edb86d5f44 100644
> --- a/include/linux/litex.h
> +++ b/include/linux/litex.h
> @@ -11,18 +11,6 @@
>
>  #include <linux/io.h>
>
> -/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
> -#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
> -       (CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
> -#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
> -#else
> -#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
> -#endif
> -#define LITEX_SUBREG_SIZE_BIT   (LITEX_SUBREG_SIZE * 8)
> -
> -/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
> -#define LITEX_SUBREG_ALIGN       0x4
> -
>  static inline void _write_litex_subregister(u32 val, void __iomem *addr)
>  {
>         writel((u32 __force)cpu_to_le32(val), addr);
> @@ -42,115 +30,54 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
>   * 32-bit wide logical CSR will be laid out as four 32-bit physical
>   * subregisters, each one containing one byte of meaningful data.
>   *
> + * For Linux support, upstream LiteX enforces a 32-bit wide CSR bus, which
> + * means that only larger-than-32-bit CSRs will be split across multiple
> + * subregisters (e.g., a 64-bit CSR will be spread across two consecutive
> + * 32-bit subregisters).
> + *
>   * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
>   */
>
> -/* number of LiteX subregisters needed to store a register of given reg_size */
> -#define _litex_num_subregs(reg_size) \
> -       (((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
> -
> -/*
> - * since the number of 4-byte aligned subregisters required to store a single
> - * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
> - * next adjacent LiteX CSR register w.r.t. the offset of the current one also
> - * depends on how many subregisters the latter is spread across
> - */
> -#define _next_reg_off(off, size) \
> -       ((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
> -
> -/*
> - * The purpose of `_litex_[set|get]_reg()` is to implement the logic of
> - * writing to/reading from the LiteX CSR in a single place that can be then
> - * reused by all LiteX drivers via the `litex_[write|read][8|16|32|64]()`
> - * accessors for the appropriate data width.
> - * NOTE: direct use of `_litex_[set|get]_reg()` by LiteX drivers is strongly
> - * discouraged, as they perform no error checking on the requested data width!
> - */
> -
> -/**
> - * _litex_set_reg() - Writes a value to the LiteX CSR (Control&Status Register)
> - * @reg: Address of the CSR
> - * @reg_size: The width of the CSR expressed in the number of bytes
> - * @val: Value to be written to the CSR
> - *
> - * This function splits a single (possibly multi-byte) LiteX CSR write into
> - * a series of subregister writes with a proper offset.
> - * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
> - */
> -static inline void _litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
> -{
> -       u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
> -
> -       while (shift > 0) {
> -               shift -= LITEX_SUBREG_SIZE_BIT;
> -               _write_litex_subregister(val >> shift, reg);
> -               reg += LITEX_SUBREG_ALIGN;
> -       }
> -}
> -
> -/**
> - * _litex_get_reg() - Reads a value of the LiteX CSR (Control&Status Register)
> - * @reg: Address of the CSR
> - * @reg_size: The width of the CSR expressed in the number of bytes
> - *
> - * Return: Value read from the CSR
> - *
> - * This function generates a series of subregister reads with a proper offset
> - * and joins their results into a single (possibly multi-byte) LiteX CSR value.
> - * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
> - */
> -static inline u64 _litex_get_reg(void __iomem *reg, size_t reg_size)
> -{
> -       u64 r;
> -       u8 i;
> -
> -       r = _read_litex_subregister(reg);
> -       for (i = 1; i < _litex_num_subregs(reg_size); i++) {
> -               r <<= LITEX_SUBREG_SIZE_BIT;
> -               reg += LITEX_SUBREG_ALIGN;
> -               r |= _read_litex_subregister(reg);
> -       }
> -       return r;
> -}
> -
>  static inline void litex_write8(void __iomem *reg, u8 val)
>  {
> -       _litex_set_reg(reg, sizeof(u8), val);
> +       _write_litex_subregister(val, reg);
>  }
>
>  static inline void litex_write16(void __iomem *reg, u16 val)
>  {
> -       _litex_set_reg(reg, sizeof(u16), val);
> +       _write_litex_subregister(val, reg);
>  }
>
>  static inline void litex_write32(void __iomem *reg, u32 val)
>  {
> -       _litex_set_reg(reg, sizeof(u32), val);
> +       _write_litex_subregister(val, reg);
>  }
>
>  static inline void litex_write64(void __iomem *reg, u64 val)
>  {
> -       _litex_set_reg(reg, sizeof(u64), val);
> +       _write_litex_subregister(val >> 32, reg);
> +       _write_litex_subregister(val, reg + 4);
>  }
>
>  static inline u8 litex_read8(void __iomem *reg)
>  {
> -       return _litex_get_reg(reg, sizeof(u8));
> +       return _read_litex_subregister(reg);
>  }
>
>  static inline u16 litex_read16(void __iomem *reg)
>  {
> -       return _litex_get_reg(reg, sizeof(u16));
> +       return _read_litex_subregister(reg);
>  }
>
>  static inline u32 litex_read32(void __iomem *reg)
>  {
> -       return _litex_get_reg(reg, sizeof(u32));
> +       return _read_litex_subregister(reg);
>  }
>
>  static inline u64 litex_read64(void __iomem *reg)
>  {
> -       return _litex_get_reg(reg, sizeof(u64));
> +       return ((u64)_read_litex_subregister(reg) << 32) |
> +               _read_litex_subregister(reg + 4);
>  }
>
>  #endif /* _LINUX_LITEX_H */
> --
> 2.31.1
>
