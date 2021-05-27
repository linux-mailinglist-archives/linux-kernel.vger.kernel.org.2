Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C039254E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhE0DSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhE0DSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:18:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:16:51 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id eb9so1925814qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BHrUTMC0A9hkyXXVJuK12l1GgGaS6cUb7CsZzONGBwY=;
        b=kwb+wZMz8w+yBbFDAD8m/aQuz/xpd3mjHyZZaf8GthoSRUXKfzCytdjJkJ/1l2vI/Q
         mVaDCgVB6axr6BJfQ+S3/vco0TWK4PqV8l4AFcjS6h13A4Vw+PXttYmGHZ340Rk0kdlP
         2I22GXm2W/eSIOjUcSHghrNPPFh8IvOC15Y9ii0omQ3WHWpogvK65ACdTGimuKw0XHao
         IRqxzSwKyarfZtnXMB4i4tkpofa9LMPGnU41plWQVHb2x35nmpSuaYaV38USoKODlrKq
         kzeN9WzbKwT0ECGZMMBjTowm3Z63Eho9LxLe9RrvWsse4KINUypGAQjOuZjeBy+sgM02
         Hrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHrUTMC0A9hkyXXVJuK12l1GgGaS6cUb7CsZzONGBwY=;
        b=WZjN+nTVBoTUSnOFNJt9/A0qfpOz6SJkwpgBIIjEfM82k5OmtzEllbYTXdZT8xHKEM
         h4rlUFz+EWREYQwd+6y/kFU8qkxEEsCCFTK5IiMKxH6fGcFxbRNhDDe+HeZln+l5mx+/
         0kiHo4GqpicB3ItLjStF/TFgpx10kj4s4pff0KdydNakfi0krCkk8G7u+vdeWxrhbXKw
         JLzMv1nxC07bp4q+6dOuDRU0j/ct+tGA4sc3o5wU/WaQWqDR/dHcx9d7/40hYurwFGAH
         iv7QS//PPFMVpTSJFCK+aPq0qrd9V3NN8eIFwOt7ulXgGYVcLRttebU042dV9ZC1T91y
         oM1w==
X-Gm-Message-State: AOAM530ImakojrcyyIKi8GNW14Vv7Gue6pMSRpbnVnnfhq+qXGZGk+NF
        XAqElRz1SEZjZnW+3Rco6RQ=
X-Google-Smtp-Source: ABdhPJxyRF5zBGc6uY1/68+k+gag0PMcDsncRojwutMelZctWDJHWxd5IlGRamlOyKyoY1lstg778w==
X-Received: by 2002:a05:6214:566:: with SMTP id cj6mr1764928qvb.54.1622085409982;
        Wed, 26 May 2021 20:16:49 -0700 (PDT)
Received: from crash.ini.cmu.edu (pool-108-39-255-32.pitbpa.fios.verizon.net. [108.39.255.32])
        by smtp.gmail.com with ESMTPSA id 7sm686043qtu.38.2021.05.26.20.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 20:16:49 -0700 (PDT)
Date:   Wed, 26 May 2021 23:17:36 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        pczarnecki@internships.antmicro.com,
        David Gow <davidgow@google.com>,
        Florent Kermarrec <florent@enjoy-digital.fr>
Subject: Re: [PATCH v2] drivers/soc/litex: remove 8-bit subregister option
Message-ID: <20210527031736.GA491539@crash.ini.cmu.edu>
References: <20210526105126.463931-1-gsomlo@gmail.com>
 <CACPK8XeHkQP+6hn0hgq4dKwXG8zXHSOYUdOwoOSO=aFOZ8faXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XeHkQP+6hn0hgq4dKwXG8zXHSOYUdOwoOSO=aFOZ8faXA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 02:12:40AM +0000, Joel Stanley wrote:
> On Wed, 26 May 2021 at 10:55, Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > Since upstream LiteX recommends that Linux support be limited to
> > designs configured with 32-bit CSR subregisters (see commit a2b71fde
> > in upstream LiteX, https://github.com/enjoy-digital/litex), remove
> > the option to select 8-bit subregisters, significantly reducing the
> > complexity of LiteX CSR (MMIO register) accessor methods.
> >
> > NOTE: for details on the underlying mechanics of LiteX CSR registers,
> > see https://github.com/enjoy-digital/litex/wiki/CSR-Bus or the original
> > LiteX accessors (litex/soc/software/include/hw/common.h in the upstream
> > repository).
> >
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> I like how this simplifies things.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks!
 
> With this change, is there any need to keep the litex acessors around?
> 
> There's the 64 bit case, but we don't have any 64 bit CSR registers do we?
 
Off the top of my head, the LiteSDcard driver uses 64-bit CSR writes:
https://github.com/litex-hub/linux/blob/litex-rebase/drivers/mmc/host/litex_mmc.c#L403
and
https://github.com/litex-hub/linux/blob/litex-rebase/drivers/mmc/host/litex_mmc.c#L421

These are both DMA base-address registers that support rv64*.

Thanks,
--Gabriel
 
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Florent Kermarrec <florent@enjoy-digital.fr>
> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > ---
> > Changes since v1:
> >  - remove LITEX_SUBREG_* macros as suggested by Stafford Horne
> >
> >  drivers/soc/litex/Kconfig          |  12 ----
> >  drivers/soc/litex/litex_soc_ctrl.c |   3 +-
> >  include/linux/litex.h              | 103 +++++------------------------
> >  3 files changed, 16 insertions(+), 102 deletions(-)
> >
> > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > index e7011d665b15..e6ba3573a772 100644
> > --- a/drivers/soc/litex/Kconfig
> > +++ b/drivers/soc/litex/Kconfig
> > @@ -17,16 +17,4 @@ config LITEX_SOC_CONTROLLER
> >           All drivers that use functions from litex.h must depend on
> >           LITEX.
> >
> > -config LITEX_SUBREG_SIZE
> > -       int "Size of a LiteX CSR subregister, in bytes"
> > -       depends on LITEX
> > -       range 1 4
> > -       default 4
> > -       help
> > -       LiteX MMIO registers (referred to as Configuration and Status
> > -       registers, or CSRs) are spread across adjacent 8- or 32-bit
> > -       subregisters, located at 32-bit aligned MMIO addresses. Use
> > -       this to select the appropriate size (1 or 4 bytes) matching
> > -       your particular LiteX build.
> > -
> >  endmenu
> > diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> > index c3e379a990f2..f75790091d38 100644
> > --- a/drivers/soc/litex/litex_soc_ctrl.c
> > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > @@ -62,8 +62,7 @@ static int litex_check_csr_access(void __iomem *reg_addr)
> >         /* restore original value of the SCRATCH register */
> >         litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
> >
> > -       pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
> > -               LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);
> > +       pr_info("LiteX SoC Controller driver initialized");
> >
> >         return 0;
> >  }
> > diff --git a/include/linux/litex.h b/include/linux/litex.h
> > index 5ea9ccf5cce4..f2edb86d5f44 100644
> > --- a/include/linux/litex.h
> > +++ b/include/linux/litex.h
> > @@ -11,18 +11,6 @@
> >
> >  #include <linux/io.h>
> >
> > -/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
> > -#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
> > -       (CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
> > -#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
> > -#else
> > -#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
> > -#endif
> > -#define LITEX_SUBREG_SIZE_BIT   (LITEX_SUBREG_SIZE * 8)
> > -
> > -/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
> > -#define LITEX_SUBREG_ALIGN       0x4
> > -
> >  static inline void _write_litex_subregister(u32 val, void __iomem *addr)
> >  {
> >         writel((u32 __force)cpu_to_le32(val), addr);
> > @@ -42,115 +30,54 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
> >   * 32-bit wide logical CSR will be laid out as four 32-bit physical
> >   * subregisters, each one containing one byte of meaningful data.
> >   *
> > + * For Linux support, upstream LiteX enforces a 32-bit wide CSR bus, which
> > + * means that only larger-than-32-bit CSRs will be split across multiple
> > + * subregisters (e.g., a 64-bit CSR will be spread across two consecutive
> > + * 32-bit subregisters).
> > + *
> >   * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> >   */
> >
> > -/* number of LiteX subregisters needed to store a register of given reg_size */
> > -#define _litex_num_subregs(reg_size) \
> > -       (((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
> > -
> > -/*
> > - * since the number of 4-byte aligned subregisters required to store a single
> > - * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
> > - * next adjacent LiteX CSR register w.r.t. the offset of the current one also
> > - * depends on how many subregisters the latter is spread across
> > - */
> > -#define _next_reg_off(off, size) \
> > -       ((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
> > -
> > -/*
> > - * The purpose of `_litex_[set|get]_reg()` is to implement the logic of
> > - * writing to/reading from the LiteX CSR in a single place that can be then
> > - * reused by all LiteX drivers via the `litex_[write|read][8|16|32|64]()`
> > - * accessors for the appropriate data width.
> > - * NOTE: direct use of `_litex_[set|get]_reg()` by LiteX drivers is strongly
> > - * discouraged, as they perform no error checking on the requested data width!
> > - */
> > -
> > -/**
> > - * _litex_set_reg() - Writes a value to the LiteX CSR (Control&Status Register)
> > - * @reg: Address of the CSR
> > - * @reg_size: The width of the CSR expressed in the number of bytes
> > - * @val: Value to be written to the CSR
> > - *
> > - * This function splits a single (possibly multi-byte) LiteX CSR write into
> > - * a series of subregister writes with a proper offset.
> > - * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
> > - */
> > -static inline void _litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
> > -{
> > -       u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
> > -
> > -       while (shift > 0) {
> > -               shift -= LITEX_SUBREG_SIZE_BIT;
> > -               _write_litex_subregister(val >> shift, reg);
> > -               reg += LITEX_SUBREG_ALIGN;
> > -       }
> > -}
> > -
> > -/**
> > - * _litex_get_reg() - Reads a value of the LiteX CSR (Control&Status Register)
> > - * @reg: Address of the CSR
> > - * @reg_size: The width of the CSR expressed in the number of bytes
> > - *
> > - * Return: Value read from the CSR
> > - *
> > - * This function generates a series of subregister reads with a proper offset
> > - * and joins their results into a single (possibly multi-byte) LiteX CSR value.
> > - * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
> > - */
> > -static inline u64 _litex_get_reg(void __iomem *reg, size_t reg_size)
> > -{
> > -       u64 r;
> > -       u8 i;
> > -
> > -       r = _read_litex_subregister(reg);
> > -       for (i = 1; i < _litex_num_subregs(reg_size); i++) {
> > -               r <<= LITEX_SUBREG_SIZE_BIT;
> > -               reg += LITEX_SUBREG_ALIGN;
> > -               r |= _read_litex_subregister(reg);
> > -       }
> > -       return r;
> > -}
> > -
> >  static inline void litex_write8(void __iomem *reg, u8 val)
> >  {
> > -       _litex_set_reg(reg, sizeof(u8), val);
> > +       _write_litex_subregister(val, reg);
> >  }
> >
> >  static inline void litex_write16(void __iomem *reg, u16 val)
> >  {
> > -       _litex_set_reg(reg, sizeof(u16), val);
> > +       _write_litex_subregister(val, reg);
> >  }
> >
> >  static inline void litex_write32(void __iomem *reg, u32 val)
> >  {
> > -       _litex_set_reg(reg, sizeof(u32), val);
> > +       _write_litex_subregister(val, reg);
> >  }
> >
> >  static inline void litex_write64(void __iomem *reg, u64 val)
> >  {
> > -       _litex_set_reg(reg, sizeof(u64), val);
> > +       _write_litex_subregister(val >> 32, reg);
> > +       _write_litex_subregister(val, reg + 4);
> >  }
> >
> >  static inline u8 litex_read8(void __iomem *reg)
> >  {
> > -       return _litex_get_reg(reg, sizeof(u8));
> > +       return _read_litex_subregister(reg);
> >  }
> >
> >  static inline u16 litex_read16(void __iomem *reg)
> >  {
> > -       return _litex_get_reg(reg, sizeof(u16));
> > +       return _read_litex_subregister(reg);
> >  }
> >
> >  static inline u32 litex_read32(void __iomem *reg)
> >  {
> > -       return _litex_get_reg(reg, sizeof(u32));
> > +       return _read_litex_subregister(reg);
> >  }
> >
> >  static inline u64 litex_read64(void __iomem *reg)
> >  {
> > -       return _litex_get_reg(reg, sizeof(u64));
> > +       return ((u64)_read_litex_subregister(reg) << 32) |
> > +               _read_litex_subregister(reg + 4);
> >  }
> >
> >  #endif /* _LINUX_LITEX_H */
> > --
> > 2.31.1
> >
