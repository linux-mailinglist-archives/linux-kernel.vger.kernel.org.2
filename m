Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29467348213
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhCXTk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbhCXTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:39:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C357DC061763;
        Wed, 24 Mar 2021 12:39:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l1so15374154pgb.5;
        Wed, 24 Mar 2021 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y122+hh7VZbM6Pv84q4hVwE4i0uJDXbxaDcBcnu6Rfc=;
        b=I3cTg8YNELtwC0kqVlxBsoaVmgVf/e1cdWm5eS/OC3o5qFUamo3coptzYvP5CiNnLL
         +wEmYdpQy85QJA406771vzSTuI8ZWoANLsD4IwyxTM/s4jcpwFgTwv/DZPabKVTEb/uD
         47nGqcOPmjDxrr48H2KQjAua/K6BRD186Zb0WGu3cmsgjsRqzhgiSg08mzbXajlyBhTz
         /cRif4XkLl/pbN7i8vlEc+q8vNM/BpPlmpqF9uqk5dJ3KUgXvhbFXYfkU8f07nFAtmvQ
         V7lHYoDnegsRuYvdD+PIi0PRL4mZNOiLB1BIgQaEiI9CuFUC+3m2PcDGdJRFnE6Zw/Er
         5lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y122+hh7VZbM6Pv84q4hVwE4i0uJDXbxaDcBcnu6Rfc=;
        b=f3SCpGWPZqzbfzW+Gl/YgaQaHV3uuyWqnrY+kyApQb6ynxlS6M1eY9z2F/FBrQz3x/
         vo4h0GOCRZkwOeaiOPKMgznzT4D+bjSJQe+duCPKgUMOdoquS6xRoA8FgtoEBE5VWGoy
         rrzvTbhPiKukIsY8KiMr1aYcUFfwPdAQtEpnDyVCsDvnqzgb9diqHJINF0KrRUIpO710
         2MyouduMrR0a7AcNbyccAq4clnpUxWo9373SMaXF9OTKIuQLcG8rijxLjcdl4iwJHAwt
         I4cGHiZjQ5AsXuXzzgN3UTTNueVuKhDTuiiNxuRgdsYz0j0ayRR9DEinq+9DOiXQ0N9p
         cF8A==
X-Gm-Message-State: AOAM531YL28NFBAFEL6uqqTEbRkqZyVYyCRIMxz9KL0bzHMzweDmhxAs
        2Qm0JX9ZaaBIW9b956DjKsJ4EbnZb1ZZIbSe3Dk=
X-Google-Smtp-Source: ABdhPJzXhkimS+dJM6IVG+wKPibOYXznEWbnpZtbzgP1ecAboWhBuXB27sQuMtAvmYraQ5SvOytWbqqu/raPQ/BfeGU=
X-Received: by 2002:a65:4bc5:: with SMTP id p5mr4342231pgr.74.1616614791161;
 Wed, 24 Mar 2021 12:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com> <20210324183610.4574-3-maciej.kwapulinski@linux.intel.com>
In-Reply-To: <20210324183610.4574-3-maciej.kwapulinski@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Mar 2021 21:39:34 +0200
Message-ID: <CAHp75Vdbb2f10MyN_xwZNk8fjB2d2MjP3qCVoSZqbrOrJ_DHNQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] intel_gna: add component of hardware operation
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 8:38 PM Maciej Kwapulinski
<maciej.kwapulinski@linux.intel.com> wrote:
>
> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
>
> Add definitions and utilities to interact with the hardware
> device.
>
> Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
> Tested-by: Savo Novakovic <savox.novakovic@intel.com>
> Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> ---
>  drivers/misc/intel/gna/Kbuild       |   2 +-
>  drivers/misc/intel/gna/gna_device.h |   4 +
>  drivers/misc/intel/gna/gna_hw.c     | 125 ++++++++++++++++++++++++++++
>  drivers/misc/intel/gna/gna_hw.h     |  62 ++++++++++++++
>  4 files changed, 192 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/intel/gna/gna_hw.c
>  create mode 100644 drivers/misc/intel/gna/gna_hw.h
>
> diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
> index 5d3becc71683..0cf083bb211a 100644
> --- a/drivers/misc/intel/gna/Kbuild
> +++ b/drivers/misc/intel/gna/Kbuild
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
> -intel_gna-y := gna_device.o gna_driver.o
> +intel_gna-y := gna_device.o gna_driver.o gna_hw.o
>
>  obj-$(CONFIG_INTEL_GNA) += intel_gna.o
> diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
> index d0b47f75f47f..39dc03d53feb 100644
> --- a/drivers/misc/intel/gna/gna_device.h
> +++ b/drivers/misc/intel/gna/gna_device.h
> @@ -6,6 +6,8 @@
>
>  #include <linux/types.h>
>
> +#include "gna_hw.h"
> +
>  struct gna_driver_private;
>  struct pci_device_id;
>  struct pci_dev;
> @@ -17,6 +19,8 @@ struct gna_drv_info {
>         u32 num_page_entries;
>         u32 max_layer_count;
>         u64 max_hw_mem;
> +
> +       struct gna_desc_info desc_info;
>  };
>
>  struct gna_private {
> diff --git a/drivers/misc/intel/gna/gna_hw.c b/drivers/misc/intel/gna/gna_hw.c
> new file mode 100644
> index 000000000000..7d2f4ef00136
> --- /dev/null
> +++ b/drivers/misc/intel/gna/gna_hw.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2017-2021 Intel Corporation
> +
> +#include <linux/pci.h>
> +
> +#include <uapi/misc/intel/gna.h>
> +
> +#include "gna_device.h"
> +#include "gna_driver.h"
> +#include "gna_hw.h"
> +
> +int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status)
> +{
> +       int status;

Redundant. See below.

> +
> +       if (hw_status & GNA_ERROR) {
> +               dev_dbg(&gna_priv->pdev->dev, "GNA completed with errors: %#x\n", hw_status);

Exactly my point, you need only one struct device, w/o these tricks.

> +               status = -EIO;

return -EIO;

> +       } else if (hw_status & GNA_STS_SCORE_COMPLETED) {

...drop else

> +               status = 0;
> +               dev_dbg(&gna_priv->pdev->dev, "GNA completed successfully: %#x\n", hw_status);
> +       } else {
> +               dev_err(&gna_priv->pdev->dev, "GNA not completed, status: %#x\n", hw_status);
> +               status = -ENODATA;
> +       }
> +
> +       return status;

As above.

> +}
> +
> +void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status)
> +{
> +       if (hw_status & GNA_STS_PARAM_OOR)
> +               dev_dbg(&gna_priv->pdev->dev, "GNA error: Param Out Range Error\n");
> +
> +       if (hw_status & GNA_STS_VA_OOR)
> +               dev_dbg(&gna_priv->pdev->dev, "GNA error: VA Out of Range Error\n");
> +
> +       if (hw_status & GNA_STS_PCI_MMU_ERR)
> +               dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI MMU Error\n");
> +
> +       if (hw_status & GNA_STS_PCI_DMA_ERR)
> +               dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI MMU Error\n");
> +
> +       if (hw_status & GNA_STS_PCI_UNEXCOMPL_ERR)
> +               dev_dbg(&gna_priv->pdev->dev, "GNA error: PCI Unexpected Completion Error\n");
> +
> +       if (hw_status & GNA_STS_SATURATE)
> +               dev_dbg(&gna_priv->pdev->dev, "GNA error: Saturation Reached !\n");
> +}
> +
> +bool gna_hw_perf_enabled(struct gna_private *gna_priv)
> +{
> +       void __iomem *addr = gna_priv->bar0_base;
> +       u32 ctrl = gna_reg_read(addr, GNA_MMIO_CTRL);

If you want to have better helpers, supply priv directly to them. Look
into other (recent enough) drivers in the kernel how they do it.

Ditto for all cases.

> +       return FIELD_GET(GNA_CTRL_COMP_STATS_EN, ctrl) ? true : false;

Missed bitfield.h.

Redundant ternary. Use !!

> +}
> +
> +void gna_start_scoring(struct gna_private *gna_priv, void __iomem *addr,
> +                      struct gna_compute_cfg *compute_cfg)
> +{
> +       u32 ctrl = gna_reg_read(addr, GNA_MMIO_CTRL);
> +
> +       ctrl |= GNA_CTRL_START_ACCEL | GNA_CTRL_COMP_INT_EN | GNA_CTRL_ERR_INT_EN;
> +
> +       ctrl &= ~GNA_CTRL_COMP_STATS_EN;
> +       ctrl |= FIELD_PREP(GNA_CTRL_COMP_STATS_EN,
> +                       compute_cfg->hw_perf_encoding & FIELD_MAX(GNA_CTRL_COMP_STATS_EN));
> +
> +       ctrl &= ~GNA_CTRL_ACTIVE_LIST_EN;
> +       ctrl |= FIELD_PREP(GNA_CTRL_ACTIVE_LIST_EN,
> +                       compute_cfg->active_list_on & FIELD_MAX(GNA_CTRL_ACTIVE_LIST_EN));
> +
> +       ctrl &= ~GNA_CTRL_OP_MODE;
> +       ctrl |= FIELD_PREP(GNA_CTRL_OP_MODE,
> +                       compute_cfg->gna_mode & FIELD_MAX(GNA_CTRL_OP_MODE));
> +
> +       gna_reg_write(addr, GNA_MMIO_CTRL, ctrl);
> +
> +       dev_dbg(&gna_priv->pdev->dev, "scoring started...\n");
> +}
> +
> +static void gna_clear_saturation(struct gna_private *gna_priv)
> +{
> +       void __iomem *addr = gna_priv->bar0_base;
> +       u32 val;
> +
> +       val = gna_reg_read(addr, GNA_MMIO_STS);
> +       if (val & GNA_STS_SATURATE) {
> +               dev_dbg(&gna_priv->pdev->dev, "saturation reached\n");
> +               dev_dbg(&gna_priv->pdev->dev, "status: %#x\n", val);
> +
> +               val = val & GNA_STS_SATURATE;
> +               gna_reg_write(addr, GNA_MMIO_STS, val);
> +       }
> +}
> +
> +void gna_abort_hw(struct gna_private *gna_priv)
> +{
> +       void __iomem *addr = gna_priv->bar0_base;
> +       u32 val;

> +       int i;

unsigned.

> +       /* saturation bit in the GNA status register needs
> +        * to be explicitly cleared.
> +        */
> +       gna_clear_saturation(gna_priv);
> +
> +       val = gna_reg_read(addr, GNA_MMIO_STS);
> +       dev_dbg(&gna_priv->pdev->dev, "status before abort: %#x\n", val);
> +
> +       val = gna_reg_read(addr, GNA_MMIO_CTRL);
> +       val |= GNA_CTRL_ABORT_CLR_ACCEL;
> +       gna_reg_write(addr, GNA_MMIO_CTRL, val);
> +
> +       i = 100;
> +       do {
> +               val = gna_reg_read(addr, GNA_MMIO_STS);
> +               if ((val & 0x1) == 0)
> +                       break;
> +       } while (--i);

NIH or readx_poll_timeout() from iopoll.h.

> +       if (i == 0)
> +               dev_err(&gna_priv->pdev->dev, "abort did not complete\n");
> +}
> diff --git a/drivers/misc/intel/gna/gna_hw.h b/drivers/misc/intel/gna/gna_hw.h
> new file mode 100644
> index 000000000000..dd682f95094e
> --- /dev/null
> +++ b/drivers/misc/intel/gna/gna_hw.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2017-2021 Intel Corporation */
> +
> +#ifndef __GNA_HW_H__
> +#define __GNA_HW_H__
> +
> +#include <linux/bits.h>

> +#include <linux/bitfield.h>

No user of it here.

> +#include <linux/interrupt.h>

Ditto.

> +#include <linux/io.h>

> +/* GNA MMIO registers */
> +#define GNA_MMIO_STS           0x80
> +#define GNA_MMIO_CTRL          0x84
> +#define GNA_MMIO_PTC           0x8C
> +#define GNA_MMIO_PSC           0x90
> +#define GNA_MMIO_DESBASE       0xB0
> +#define GNA_MMIO_IBUFFS                0xB4
> +
> +#define GNA_PT_ENTRY_SIZE              4
> +/* there are up to 1024 32-bit pointers in one page in Page Table (L1) */
> +#define GNA_PT_LENGTH           (PAGE_SIZE / GNA_PT_ENTRY_SIZE)

Missed header for PAGE_SIZE.

> +#define GNA_PGDIRN_LEN                 64
> +#define GNA_PGDIR_ENTRIES              1024 /* 32-bit page addresses */
> +#define GNA_PGDIR_INVALID              1
> +
> +#define GNA_CTRL_START_ACCEL           BIT(0)
> +#define GNA_CTRL_ACTIVE_LIST_EN                BIT(1)
> +#define GNA_CTRL_ABORT_CLR_ACCEL       BIT(2)
> +#define GNA_CTRL_OP_MODE               GENMASK(6, 5)
> +#define GNA_CTRL_COMP_INT_EN           BIT(8)
> +#define GNA_CTRL_ERR_INT_EN            BIT(10)
> +#define GNA_CTRL_COMP_STATS_EN         GENMASK(15, 12)
> +
> +struct gna_mmu_info {
> +       u32 vamax_size;
> +       u32 rsvd_size;
> +       u32 pd_size;
> +};

Missed types.h.

> +struct gna_desc_info {
> +       u32 rsvd_size;
> +       u32 cfg_size;
> +       u32 desc_size;
> +       struct gna_mmu_info mmu_info;
> +};
> +
> +struct gna_private;
> +struct gna_compute_cfg;
> +
> +void gna_abort_hw(struct gna_private *gna_priv);
> +bool gna_hw_perf_enabled(struct gna_private *gna_priv);
> +int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status);
> +void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status);
> +void gna_start_scoring(struct gna_private *gna_priv, void __iomem *addr,

Missed header for __iomem (but I guess it's guaranteed to be included
by types.h, double check this).

> +                      struct gna_compute_cfg *compute_cfg);
> +
> +#define gna_reg_read(addr, offset)             readl((addr) + (offset))
> +#define gna_reg_write(addr, offset, value)     writel((value), (addr) + (offset))

No point And make them functions, not macros.

> +
> +#endif // __GNA_HW_H__
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
