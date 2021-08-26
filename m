Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF3F3F7FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 03:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhHZBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 21:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhHZBgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 21:36:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FAFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 18:36:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n12so727800plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 18:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RG0H94xd0UOZq/hx1Z7vIDohBIJ9x0ffRWEXS/+MBwQ=;
        b=VOUhqeYZMuitOX4NK4CEGVhmjQH5aQda9PVoc3zOBzkP9umHbTNzw11+Khc6cdgixJ
         kNlGI+tJIbIIr7kX3vEkbo0b0FBRJYpP+Ryx+Z5KQ0B28Kp+i4c9hapJ+4/IqMFR5XtS
         EKV8+Ji91+Er7NmdF5czVuw7+w8AycAmTnTfVA3hyAxGMFLRhBZ/5GJEZioFcPTZ0EBJ
         nt/nYemT1IXEfu8a6A2JSgfCTAG3XFQXtXus6yr2d0i6VeFRtROcUaABT/rCwz5Y1hHu
         KF0INEDC73PlqBhHdYgV4ojvXBvL7upl0bTYJf8H6SqJLeZJPjCJMw1i78+197LE0FWf
         FTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RG0H94xd0UOZq/hx1Z7vIDohBIJ9x0ffRWEXS/+MBwQ=;
        b=EoYuUFhSxyxFqYT/abq1HWL04sJRfYGLiC1L1Lvz9hfedc3hRTteSlwHy5lMESMDbB
         WllcEMCACsdhhxkUm7gy6Vpyi2457F+Uu6rwu9baUdR18nBMs9WkX3fAR1RT9FdVgIf0
         j80D6azfCp8EhyCT24e5x6bOGBuNjW8tiX4pRRw51ESCncj6UZspR+i67CIIcoIjwyhs
         lgrn8Pbzewkvnqoe9/xJSOEgAe17kyekX5U+aAze8XfpSFJJRjF3CZrY6W1OPZG4T7e3
         /NV7xLcmDTgwdanuZTmy9FKozaTc53RfumzIum4sQT23KEKAsZ2GpZkur713YCpi7PsE
         hw2A==
X-Gm-Message-State: AOAM5320Dog79EEjnOxa6nmrb/cF14M6944XTzRJEog8Z3COhtl3PT7h
        PoUMA8NN88eQWiGBkg8eLTVrK93fsteDWIxQEr+adg==
X-Google-Smtp-Source: ABdhPJw2EQoMk+VkGKH34pT9dv8bAf98oQur3rF5nOSjeRaWUuBWEh6Lixalh4VzsNZ6ymIsfgB6HzEtEAoKy/jbEuQ=
X-Received: by 2002:a17:902:ba90:b0:135:6709:705 with SMTP id
 k16-20020a170902ba9000b0013567090705mr1227850pls.79.1629941764989; Wed, 25
 Aug 2021 18:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210803113134.2262882-1-iwona.winiarska@intel.com> <20210803113134.2262882-8-iwona.winiarska@intel.com>
In-Reply-To: <20210803113134.2262882-8-iwona.winiarska@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Aug 2021 18:35:53 -0700
Message-ID: <CAPcyv4jPVSt9Wr2TkDActFVLP+ygaDwBnsKG410Nf1qfP_MB9A@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] peci: Add peci-aspeed controller driver
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        Device Tree <devicetree@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:35 AM Iwona Winiarska
<iwona.winiarska@intel.com> wrote:
>
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>
> ASPEED AST24xx/AST25xx/AST26xx SoCs supports the PECI electrical
> interface (a.k.a PECI wire).

Maybe a one sentence blurb here and in the Kconfig reminding people
why they should care if they have a PECI driver or not?

>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  MAINTAINERS                           |   9 +
>  drivers/peci/Kconfig                  |   6 +
>  drivers/peci/Makefile                 |   3 +
>  drivers/peci/controller/Kconfig       |  16 +
>  drivers/peci/controller/Makefile      |   3 +
>  drivers/peci/controller/peci-aspeed.c | 445 ++++++++++++++++++++++++++
>  6 files changed, 482 insertions(+)
>  create mode 100644 drivers/peci/controller/Kconfig
>  create mode 100644 drivers/peci/controller/Makefile
>  create mode 100644 drivers/peci/controller/peci-aspeed.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d411974aaa5e..6e9d53ff68ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2866,6 +2866,15 @@ S:       Maintained
>  F:     Documentation/hwmon/asc7621.rst
>  F:     drivers/hwmon/asc7621.c
>
> +ASPEED PECI CONTROLLER
> +M:     Iwona Winiarska <iwona.winiarska@intel.com>
> +M:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> +L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
> +S:     Supported
> +F:     Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> +F:     drivers/peci/controller/peci-aspeed.c
> +
>  ASPEED PINCTRL DRIVERS
>  M:     Andrew Jeffery <andrew@aj.id.au>
>  L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
> index 71a4ad81225a..99279df97a78 100644
> --- a/drivers/peci/Kconfig
> +++ b/drivers/peci/Kconfig
> @@ -13,3 +13,9 @@ menuconfig PECI
>
>           This support is also available as a module. If so, the module
>           will be called peci.
> +
> +if PECI
> +
> +source "drivers/peci/controller/Kconfig"
> +
> +endif # PECI
> diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
> index e789a354e842..926d8df15cbd 100644
> --- a/drivers/peci/Makefile
> +++ b/drivers/peci/Makefile
> @@ -3,3 +3,6 @@
>  # Core functionality
>  peci-y := core.o
>  obj-$(CONFIG_PECI) += peci.o
> +
> +# Hardware specific bus drivers
> +obj-y += controller/
> diff --git a/drivers/peci/controller/Kconfig b/drivers/peci/controller/Kconfig
> new file mode 100644
> index 000000000000..6d48df08db1c
> --- /dev/null
> +++ b/drivers/peci/controller/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config PECI_ASPEED
> +       tristate "ASPEED PECI support"
> +       depends on ARCH_ASPEED || COMPILE_TEST
> +       depends on OF
> +       depends on HAS_IOMEM
> +       help
> +         This option enables PECI controller driver for ASPEED AST2400,
> +         AST2500 and AST2600 SoCs.
> +
> +         Say Y here if your system runs on ASPEED SoC and you are using it
> +         as BMC for Intel platform.
> +
> +         This driver can also be built as a module. If so, the module will
> +         be called peci-aspeed.
> diff --git a/drivers/peci/controller/Makefile b/drivers/peci/controller/Makefile
> new file mode 100644
> index 000000000000..022c28ef1bf0
> --- /dev/null
> +++ b/drivers/peci/controller/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_PECI_ASPEED)      += peci-aspeed.o
> diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
> new file mode 100644
> index 000000000000..1d708c983749
> --- /dev/null
> +++ b/drivers/peci/controller/peci-aspeed.c
> @@ -0,0 +1,445 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (C) 2012-2017 ASPEED Technology Inc.
> +// Copyright (c) 2018-2021 Intel Corporation

Why different copyright capitalization?

> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/peci.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include <asm/unaligned.h>

Why is this included?

> +
> +/* ASPEED PECI Registers */
> +/* Control Register */
> +#define ASPEED_PECI_CTRL                       0x00
> +#define   ASPEED_PECI_CTRL_SAMPLING_MASK       GENMASK(19, 16)
> +#define   ASPEED_PECI_CTRL_RD_MODE_MASK                GENMASK(13, 12)
> +#define     ASPEED_PECI_CTRL_RD_MODE_DBG       BIT(13)
> +#define     ASPEED_PECI_CTRL_RD_MODE_COUNT     BIT(12)
> +#define   ASPEED_PECI_CTRL_CLK_SOURCE          BIT(11)
> +#define   ASPEED_PECI_CTRL_CLK_DIV_MASK                GENMASK(10, 8)
> +#define   ASPEED_PECI_CTRL_INVERT_OUT          BIT(7)
> +#define   ASPEED_PECI_CTRL_INVERT_IN           BIT(6)
> +#define   ASPEED_PECI_CTRL_BUS_CONTENTION_EN   BIT(5)
> +#define   ASPEED_PECI_CTRL_PECI_EN             BIT(4)
> +#define   ASPEED_PECI_CTRL_PECI_CLK_EN         BIT(0)
> +
> +/* Timing Negotiation Register */
> +#define ASPEED_PECI_TIMING_NEGOTIATION         0x04
> +#define   ASPEED_PECI_T_NEGO_MSG_MASK          GENMASK(15, 8)
> +#define   ASPEED_PECI_T_NEGO_ADDR_MASK         GENMASK(7, 0)
> +
> +/* Command Register */
> +#define ASPEED_PECI_CMD                                0x08
> +#define   ASPEED_PECI_CMD_PIN_MONITORING       BIT(31)
> +#define   ASPEED_PECI_CMD_STS_MASK             GENMASK(27, 24)
> +#define     ASPEED_PECI_CMD_STS_ADDR_T_NEGO    0x3
> +#define   ASPEED_PECI_CMD_IDLE_MASK            \
> +         (ASPEED_PECI_CMD_STS_MASK | ASPEED_PECI_CMD_PIN_MONITORING)
> +#define   ASPEED_PECI_CMD_FIRE                 BIT(0)
> +
> +/* Read/Write Length Register */
> +#define ASPEED_PECI_RW_LENGTH                  0x0c
> +#define   ASPEED_PECI_AW_FCS_EN                        BIT(31)
> +#define   ASPEED_PECI_RD_LEN_MASK              GENMASK(23, 16)
> +#define   ASPEED_PECI_WR_LEN_MASK              GENMASK(15, 8)
> +#define   ASPEED_PECI_TARGET_ADDR_MASK         GENMASK(7, 0)
> +
> +/* Expected FCS Data Register */
> +#define ASPEED_PECI_EXPECTED_FCS               0x10
> +#define   ASPEED_PECI_EXPECTED_RD_FCS_MASK     GENMASK(23, 16)
> +#define   ASPEED_PECI_EXPECTED_AW_FCS_AUTO_MASK        GENMASK(15, 8)
> +#define   ASPEED_PECI_EXPECTED_WR_FCS_MASK     GENMASK(7, 0)
> +
> +/* Captured FCS Data Register */
> +#define ASPEED_PECI_CAPTURED_FCS               0x14
> +#define   ASPEED_PECI_CAPTURED_RD_FCS_MASK     GENMASK(23, 16)
> +#define   ASPEED_PECI_CAPTURED_WR_FCS_MASK     GENMASK(7, 0)
> +
> +/* Interrupt Register */
> +#define ASPEED_PECI_INT_CTRL                   0x18
> +#define   ASPEED_PECI_TIMING_NEGO_SEL_MASK     GENMASK(31, 30)
> +#define     ASPEED_PECI_1ST_BIT_OF_ADDR_NEGO   0
> +#define     ASPEED_PECI_2ND_BIT_OF_ADDR_NEGO   1
> +#define     ASPEED_PECI_MESSAGE_NEGO           2
> +#define   ASPEED_PECI_INT_MASK                 GENMASK(4, 0)
> +#define     ASPEED_PECI_INT_BUS_TIMEOUT                BIT(4)
> +#define     ASPEED_PECI_INT_BUS_CONTENTION     BIT(3)
> +#define     ASPEED_PECI_INT_WR_FCS_BAD         BIT(2)
> +#define     ASPEED_PECI_INT_WR_FCS_ABORT       BIT(1)
> +#define     ASPEED_PECI_INT_CMD_DONE           BIT(0)
> +
> +/* Interrupt Status Register */
> +#define ASPEED_PECI_INT_STS                    0x1c
> +#define   ASPEED_PECI_INT_TIMING_RESULT_MASK   GENMASK(29, 16)
> +         /* bits[4..0]: Same bit fields in the 'Interrupt Register' */
> +
> +/* Rx/Tx Data Buffer Registers */
> +#define ASPEED_PECI_WR_DATA0                   0x20
> +#define ASPEED_PECI_WR_DATA1                   0x24
> +#define ASPEED_PECI_WR_DATA2                   0x28
> +#define ASPEED_PECI_WR_DATA3                   0x2c
> +#define ASPEED_PECI_RD_DATA0                   0x30
> +#define ASPEED_PECI_RD_DATA1                   0x34
> +#define ASPEED_PECI_RD_DATA2                   0x38
> +#define ASPEED_PECI_RD_DATA3                   0x3c
> +#define ASPEED_PECI_WR_DATA4                   0x40
> +#define ASPEED_PECI_WR_DATA5                   0x44
> +#define ASPEED_PECI_WR_DATA6                   0x48
> +#define ASPEED_PECI_WR_DATA7                   0x4c
> +#define ASPEED_PECI_RD_DATA4                   0x50
> +#define ASPEED_PECI_RD_DATA5                   0x54
> +#define ASPEED_PECI_RD_DATA6                   0x58
> +#define ASPEED_PECI_RD_DATA7                   0x5c
> +#define   ASPEED_PECI_DATA_BUF_SIZE_MAX                32
> +
> +/* Timing Negotiation */
> +#define ASPEED_PECI_RD_SAMPLING_POINT_DEFAULT  8
> +#define ASPEED_PECI_RD_SAMPLING_POINT_MAX      (BIT(4) - 1)
> +#define ASPEED_PECI_CLK_DIV_DEFAULT            0
> +#define ASPEED_PECI_CLK_DIV_MAX                        (BIT(3) - 1)
> +#define ASPEED_PECI_MSG_TIMING_DEFAULT         1
> +#define ASPEED_PECI_MSG_TIMING_MAX             (BIT(8) - 1)
> +#define ASPEED_PECI_ADDR_TIMING_DEFAULT                1
> +#define ASPEED_PECI_ADDR_TIMING_MAX            (BIT(8) - 1)
> +
> +/* Timeout */
> +#define ASPEED_PECI_IDLE_CHECK_TIMEOUT_US      (50 * USEC_PER_MSEC)
> +#define ASPEED_PECI_IDLE_CHECK_INTERVAL_US     (10 * USEC_PER_MSEC)
> +#define ASPEED_PECI_CMD_TIMEOUT_MS_DEFAULT     (1000)
> +#define ASPEED_PECI_CMD_TIMEOUT_MS_MAX         (1000)
> +
> +struct aspeed_peci {
> +       struct peci_controller *controller;
> +       struct device *dev;
> +       void __iomem *base;
> +       struct clk *clk;
> +       struct reset_control *rst;
> +       int irq;
> +       spinlock_t lock; /* to sync completion status handling */
> +       struct completion xfer_complete;
> +       u32 status;
> +       u32 cmd_timeout_ms;
> +       u32 msg_timing;
> +       u32 addr_timing;
> +       u32 rd_sampling_point;
> +       u32 clk_div;
> +};
> +
> +static void aspeed_peci_init_regs(struct aspeed_peci *priv)
> +{
> +       u32 val;
> +
> +       val = FIELD_PREP(ASPEED_PECI_CTRL_CLK_DIV_MASK, ASPEED_PECI_CLK_DIV_DEFAULT);
> +       val |= ASPEED_PECI_CTRL_PECI_CLK_EN;
> +       writel(val, priv->base + ASPEED_PECI_CTRL);
> +       /*
> +        * Timing negotiation period setting.
> +        * The unit of the programmed value is 4 times of PECI clock period.
> +        */
> +       val = FIELD_PREP(ASPEED_PECI_T_NEGO_MSG_MASK, priv->msg_timing);
> +       val |= FIELD_PREP(ASPEED_PECI_T_NEGO_ADDR_MASK, priv->addr_timing);
> +       writel(val, priv->base + ASPEED_PECI_TIMING_NEGOTIATION);
> +
> +       /* Clear interrupts */
> +       val = readl(priv->base + ASPEED_PECI_INT_STS) | ASPEED_PECI_INT_MASK;
> +       writel(val, priv->base + ASPEED_PECI_INT_STS);
> +
> +       /* Set timing negotiation mode and enable interrupts */
> +       val = FIELD_PREP(ASPEED_PECI_TIMING_NEGO_SEL_MASK, ASPEED_PECI_1ST_BIT_OF_ADDR_NEGO);
> +       val |= ASPEED_PECI_INT_MASK;
> +       writel(val, priv->base + ASPEED_PECI_INT_CTRL);
> +
> +       val = FIELD_PREP(ASPEED_PECI_CTRL_SAMPLING_MASK, priv->rd_sampling_point);
> +       val |= FIELD_PREP(ASPEED_PECI_CTRL_CLK_DIV_MASK, priv->clk_div);
> +       val |= ASPEED_PECI_CTRL_PECI_EN;
> +       val |= ASPEED_PECI_CTRL_PECI_CLK_EN;
> +       writel(val, priv->base + ASPEED_PECI_CTRL);
> +}
> +
> +static inline int aspeed_peci_check_idle(struct aspeed_peci *priv)
> +{
> +       u32 cmd_sts = readl(priv->base + ASPEED_PECI_CMD);
> +
> +       if (FIELD_GET(ASPEED_PECI_CMD_STS_MASK, cmd_sts) == ASPEED_PECI_CMD_STS_ADDR_T_NEGO)
> +               aspeed_peci_init_regs(priv);
> +
> +       return readl_poll_timeout(priv->base + ASPEED_PECI_CMD,
> +                                 cmd_sts,
> +                                 !(cmd_sts & ASPEED_PECI_CMD_IDLE_MASK),
> +                                 ASPEED_PECI_IDLE_CHECK_INTERVAL_US,
> +                                 ASPEED_PECI_IDLE_CHECK_TIMEOUT_US);
> +}
> +
> +static int aspeed_peci_xfer(struct peci_controller *controller,
> +                           u8 addr, struct peci_request *req)
> +{
> +       struct aspeed_peci *priv = dev_get_drvdata(controller->dev.parent);
> +       unsigned long flags, timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
> +       u32 peci_head;
> +       int ret;
> +
> +       if (req->tx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX ||
> +           req->rx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX)
> +               return -EINVAL;
> +
> +       /* Check command sts and bus idle state */
> +       ret = aspeed_peci_check_idle(priv);
> +       if (ret)
> +               return ret; /* -ETIMEDOUT */
> +
> +       spin_lock_irqsave(&priv->lock, flags);
> +       reinit_completion(&priv->xfer_complete);
> +
> +       peci_head = FIELD_PREP(ASPEED_PECI_TARGET_ADDR_MASK, addr) |
> +                   FIELD_PREP(ASPEED_PECI_WR_LEN_MASK, req->tx.len) |
> +                   FIELD_PREP(ASPEED_PECI_RD_LEN_MASK, req->rx.len);
> +
> +       writel(peci_head, priv->base + ASPEED_PECI_RW_LENGTH);
> +
> +       memcpy_toio(priv->base + ASPEED_PECI_WR_DATA0, req->tx.buf, min_t(u8, req->tx.len, 16));
> +       if (req->tx.len > 16)
> +               memcpy_toio(priv->base + ASPEED_PECI_WR_DATA4, req->tx.buf + 16,
> +                           req->tx.len - 16);
> +
> +       dev_dbg(priv->dev, "HEAD : 0x%08x\n", peci_head);
> +       print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf, req->tx.len);

On CONFIG_DYNAMIC_DEBUG=n builds the kernel will do all the work of
reading through this buffer, but skip emitting it. Are you sure you
want to pay that overhead for every transaction?

> +
> +       priv->status = 0;
> +       writel(ASPEED_PECI_CMD_FIRE, priv->base + ASPEED_PECI_CMD);
> +       spin_unlock_irqrestore(&priv->lock, flags);
> +
> +       ret = wait_for_completion_interruptible_timeout(&priv->xfer_complete, timeout);

spin_lock_irqsave() says "I don't know if interrupts are disabled
already, so I'll save the state, whatever it is, and restore later"

wait_for_completion_interruptible_timeout() says "I know I am in a
sleepable context where interrupts are enabled"

So, one of those is wrong, i.e. should it be spin_{lock,unlock}_irq()?


> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret == 0) {
> +               dev_dbg(priv->dev, "Timeout waiting for a response!\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       spin_lock_irqsave(&priv->lock, flags);
> +
> +       writel(0, priv->base + ASPEED_PECI_CMD);
> +
> +       if (priv->status != ASPEED_PECI_INT_CMD_DONE) {
> +               spin_unlock_irqrestore(&priv->lock, flags);
> +               dev_dbg(priv->dev, "No valid response!\n");
> +               return -EIO;
> +       }
> +
> +       spin_unlock_irqrestore(&priv->lock, flags);
> +
> +       memcpy_fromio(req->rx.buf, priv->base + ASPEED_PECI_RD_DATA0, min_t(u8, req->rx.len, 16));
> +       if (req->rx.len > 16)
> +               memcpy_fromio(req->rx.buf + 16, priv->base + ASPEED_PECI_RD_DATA4,
> +                             req->rx.len - 16);
> +
> +       print_hex_dump_bytes("RX : ", DUMP_PREFIX_NONE, req->rx.buf, req->rx.len);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t aspeed_peci_irq_handler(int irq, void *arg)
> +{
> +       struct aspeed_peci *priv = arg;
> +       u32 status;
> +
> +       spin_lock(&priv->lock);
> +       status = readl(priv->base + ASPEED_PECI_INT_STS);
> +       writel(status, priv->base + ASPEED_PECI_INT_STS);
> +       priv->status |= (status & ASPEED_PECI_INT_MASK);
> +
> +       /*
> +        * In most cases, interrupt bits will be set one by one but also note
> +        * that multiple interrupt bits could be set at the same time.
> +        */
> +       if (status & ASPEED_PECI_INT_BUS_TIMEOUT)
> +               dev_dbg_ratelimited(priv->dev, "ASPEED_PECI_INT_BUS_TIMEOUT\n");
> +
> +       if (status & ASPEED_PECI_INT_BUS_CONTENTION)
> +               dev_dbg_ratelimited(priv->dev, "ASPEED_PECI_INT_BUS_CONTENTION\n");
> +
> +       if (status & ASPEED_PECI_INT_WR_FCS_BAD)
> +               dev_dbg_ratelimited(priv->dev, "ASPEED_PECI_INT_WR_FCS_BAD\n");
> +
> +       if (status & ASPEED_PECI_INT_WR_FCS_ABORT)
> +               dev_dbg_ratelimited(priv->dev, "ASPEED_PECI_INT_WR_FCS_ABORT\n");

Are you sure these would not be better as tracepoints? If you're
debugging an interrupt related failure, the ratelimiting might get in
your way when you really need to know when one of these error
interrupts fire relative to another event.

> +
> +       /*
> +        * All commands should be ended up with a ASPEED_PECI_INT_CMD_DONE bit
> +        * set even in an error case.
> +        */
> +       if (status & ASPEED_PECI_INT_CMD_DONE)
> +               complete(&priv->xfer_complete);

Hmm, no need to check if there was a sequencing error, like a command
was never submitted?

> +
> +       spin_unlock(&priv->lock);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void aspeed_peci_property_sanitize(struct device *dev, const char *propname,
> +                                         u32 min, u32 max, u32 default_val, u32 *propval)
> +{
> +       u32 val;
> +       int ret;
> +
> +       ret = device_property_read_u32(dev, propname, &val);
> +       if (ret) {
> +               val = default_val;
> +       } else if (val > max || val < min) {
> +               dev_warn(dev, "Invalid %s: %u, falling back to: %u\n",
> +                        propname, val, default_val);
> +
> +               val = default_val;
> +       }
> +
> +       *propval = val;
> +}
> +
> +static void aspeed_peci_property_setup(struct aspeed_peci *priv)
> +{
> +       aspeed_peci_property_sanitize(priv->dev, "aspeed,clock-divider",
> +                                     0, ASPEED_PECI_CLK_DIV_MAX,
> +                                     ASPEED_PECI_CLK_DIV_DEFAULT, &priv->clk_div);
> +       aspeed_peci_property_sanitize(priv->dev, "aspeed,msg-timing",
> +                                     0, ASPEED_PECI_MSG_TIMING_MAX,
> +                                     ASPEED_PECI_MSG_TIMING_DEFAULT, &priv->msg_timing);
> +       aspeed_peci_property_sanitize(priv->dev, "aspeed,addr-timing",
> +                                     0, ASPEED_PECI_ADDR_TIMING_MAX,
> +                                     ASPEED_PECI_ADDR_TIMING_DEFAULT, &priv->addr_timing);
> +       aspeed_peci_property_sanitize(priv->dev, "aspeed,rd-sampling-point",
> +                                     0, ASPEED_PECI_RD_SAMPLING_POINT_MAX,
> +                                     ASPEED_PECI_RD_SAMPLING_POINT_DEFAULT,
> +                                     &priv->rd_sampling_point);
> +       aspeed_peci_property_sanitize(priv->dev, "cmd-timeout-ms",
> +                                     1, ASPEED_PECI_CMD_TIMEOUT_MS_MAX,
> +                                     ASPEED_PECI_CMD_TIMEOUT_MS_DEFAULT, &priv->cmd_timeout_ms);
> +}
> +
> +static struct peci_controller_ops aspeed_ops = {
> +       .xfer = aspeed_peci_xfer,
> +};
> +
> +static void aspeed_peci_reset_control_release(void *data)
> +{
> +       reset_control_assert(data);
> +}
> +
> +int aspeed_peci_reset_control_deassert(struct device *dev, struct reset_control *rst)

I'd recommend naming this devm_aspeed_peci_reset_control_deassert(),
because I came looking here from reading probe for why there was no
reassertion of reset on driver ->remove().

> +{
> +       int ret;
> +
> +       ret = reset_control_deassert(rst);
> +       if (ret)
> +               return ret;
> +
> +       return devm_add_action_or_reset(dev, aspeed_peci_reset_control_release, rst);
> +}
> +
> +static void aspeed_peci_clk_release(void *data)
> +{
> +       clk_disable_unprepare(data);
> +}
> +
> +static int aspeed_peci_clk_enable(struct device *dev, struct clk *clk)

...ditto on the devm prefix, just to speed readability.

> +{
> +       int ret;
> +
> +       ret = clk_prepare_enable(clk);
> +       if (ret)
> +               return ret;
> +
> +       return devm_add_action_or_reset(dev, aspeed_peci_clk_release, clk);
> +}
> +
> +static int aspeed_peci_probe(struct platform_device *pdev)
> +{
> +       struct peci_controller *controller;
> +       struct aspeed_peci *priv;
> +       int ret;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = &pdev->dev;
> +       dev_set_drvdata(priv->dev, priv);
> +
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       priv->irq = platform_get_irq(pdev, 0);
> +       if (!priv->irq)
> +               return priv->irq;
> +
> +       ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
> +                              0, "peci-aspeed", priv);
> +       if (ret)
> +               return ret;
> +
> +       init_completion(&priv->xfer_complete);
> +       spin_lock_init(&priv->lock);
> +
> +       priv->rst = devm_reset_control_get(&pdev->dev, NULL);
> +       if (IS_ERR(priv->rst))
> +               return dev_err_probe(priv->dev, PTR_ERR(priv->rst),
> +                                    "failed to get reset control\n");
> +
> +       ret = aspeed_peci_reset_control_deassert(priv->dev, priv->rst);
> +       if (ret)
> +               return dev_err_probe(priv->dev, ret, "cannot deassert reset control\n");
> +
> +       priv->clk = devm_clk_get(priv->dev, NULL);
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(priv->dev, PTR_ERR(priv->clk), "failed to get clk\n");
> +
> +       ret = aspeed_peci_clk_enable(priv->dev, priv->clk);
> +       if (ret)
> +               return dev_err_probe(priv->dev, ret, "failed to enable clock\n");
> +
> +       aspeed_peci_property_setup(priv);
> +
> +       aspeed_peci_init_regs(priv);
> +
> +       controller = devm_peci_controller_add(priv->dev, &aspeed_ops);
> +       if (IS_ERR(controller))
> +               return dev_err_probe(priv->dev, PTR_ERR(controller),
> +                                    "failed to add aspeed peci controller\n");
> +
> +       priv->controller = controller;
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id aspeed_peci_of_table[] = {
> +       { .compatible = "aspeed,ast2400-peci", },
> +       { .compatible = "aspeed,ast2500-peci", },
> +       { .compatible = "aspeed,ast2600-peci", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_peci_of_table);
> +
> +static struct platform_driver aspeed_peci_driver = {
> +       .probe  = aspeed_peci_probe,
> +       .driver = {
> +               .name           = "peci-aspeed",
> +               .of_match_table = aspeed_peci_of_table,
> +       },
> +};
> +module_platform_driver(aspeed_peci_driver);
> +
> +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> +MODULE_DESCRIPTION("ASPEED PECI driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PECI);
> --
> 2.31.1
>
