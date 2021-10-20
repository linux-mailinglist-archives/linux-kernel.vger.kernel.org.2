Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630144347B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTJSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:18:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46212 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634721360; x=1666257360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3wTRLSQGq2ujS5/mPCfMtkokVR6GwjYkuB6FQdYDuc=;
  b=Jmidj+0qp4vh4scj6gw8SopkfECgIqyBn3NjYcL8/YPXFgm9P11M62Q8
   HDdRWJz2QEmjkae8TpE+85fodnjIuSjAktmmF8sQ5ws8R1jy8CiTJogBl
   5l/fcpTTk7cNtxj7wAXBU18KjXuUAGSfzfX4oiQKEfVtgp5BaMBaYtJWf
   ITEJNAZSrG6vZhp0Dc5LLGBsWT0mhie4xIvVvPXY4pUunuBydTMkftLhE
   sa4assKKdHNjH0ztS39QSC8eNfTkDNKNhf36S0S6uNKn3fE6YJWmIfjaS
   frS4BknZL0RqmCbJ/qkOMUZW0bR3cdLzToxCoHne97rguabEEm3QKCPxx
   g==;
IronPort-SDR: 3zW9+Fia3dWrk63+C1zaWZdnxjvRKTe3uQ1C0ECxxpd7R0qNl24L4jKfLV/cvIM8i8kh8jjHjy
 /5uEo6GCdA8Tryv48iU4TF9t29HomTule4AAm7S//qr3TJzB/75DjXixA7Wy2yu6KawIN6dBNk
 UdwXnqToMSjOu02PUuZBS6Iz7ebNHwOt6Uvv8v4buInPRFl9VRz57OHJ8BBih4Jqogd5t26mkv
 VMe4Uu6qodY88juCKln9kLLW0rTOnK/ckp0kADkEyPUuob3mqeG9vsLLZNpIrqyRqfs6JvoZwd
 CnZkIMJZntmsI2uop93hCu+r
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="148840735"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:16:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:15:59 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 20 Oct 2021 02:15:59 -0700
Date:   Wed, 20 Oct 2021 11:17:33 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <kishon@ti.com>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] phy: Add lan966x ethernet serdes PHY driver
Message-ID: <20211020091733.fxph2pq3xa3byvry@soft-dev3-1.localhost>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-4-horatiu.vultur@microchip.com>
 <YW8HIHTCVgB+URJ5@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YW8HIHTCVgB+URJ5@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/19/2021 23:27, Vinod Koul wrote:
> 
> On 15-10-21, 14:39, Horatiu Vultur wrote:
> > Add the Microchip lan966x ethernet serdes PHY driver for interfaces
> > available in the lan966x SoC.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/phy/microchip/Kconfig               |   8 +
> >  drivers/phy/microchip/Makefile              |   1 +
> >  drivers/phy/microchip/lan966x_serdes.c      | 540 ++++++++++++++++++++
> >  drivers/phy/microchip/lan966x_serdes_regs.h | 482 +++++++++++++++++
> >  4 files changed, 1031 insertions(+)
> >  create mode 100644 drivers/phy/microchip/lan966x_serdes.c
> >  create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
> >
> > diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
> > index 3728a284bf64..38039ed0754c 100644
> > --- a/drivers/phy/microchip/Kconfig
> > +++ b/drivers/phy/microchip/Kconfig
> > @@ -11,3 +11,11 @@ config PHY_SPARX5_SERDES
> >       depends on HAS_IOMEM
> >       help
> >         Enable this for support of the 10G/25G SerDes on Microchip Sparx5.
> > +
> > +config PHY_LAN966X_SERDES
> > +     tristate "SerDes PHY driver for Microchip LAN966X"
> > +     select GENERIC_PHY
> > +     depends on OF
> > +     depends on MFD_SYSCON
> > +     help
> > +       Enable this for supporting SerDes muxing with Microchip LAN966X
> > diff --git a/drivers/phy/microchip/Makefile b/drivers/phy/microchip/Makefile
> > index 7b98345712aa..fd73b87960a5 100644
> > --- a/drivers/phy/microchip/Makefile
> > +++ b/drivers/phy/microchip/Makefile
> > @@ -4,3 +4,4 @@
> >  #
> >
> >  obj-$(CONFIG_PHY_SPARX5_SERDES) := sparx5_serdes.o
> > +obj-$(CONFIG_PHY_LAN966X_SERDES) := lan966x_serdes.o
> > diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
> > new file mode 100644
> > index 000000000000..e663bb9186a8
> > --- /dev/null
> > +++ b/drivers/phy/microchip/lan966x_serdes.c
> > @@ -0,0 +1,540 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> 
> Any reason why this is dual licensed, why not GPL only?

No reason, I think I copy this from a different file.

> 
> > +
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy.h>
> 
> Why this header?

This is required because we use the type 'phy_interface_t'

> 
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <dt-bindings/phy/phy-lan966x-serdes.h>
> > +#include "lan966x_serdes_regs.h"
> > +
> > +#define lan_offset_(id, tinst, tcnt,                 \
> > +                gbase, ginst, gcnt, gwidth,          \
> > +                raddr, rinst, rcnt, rwidth)          \
> > +     (gbase + ((ginst) * gwidth) + raddr + ((rinst) * rwidth))
> > +#define lan_offset(...) lan_offset_(__VA_ARGS__)
> > +
> > +static void lan_rmw_(u32 val, u32 mask, void __iomem *mem, u32 offset)
> > +{
> > +     u32 v;
> > +
> > +     v = readl(mem + offset);
> > +     v = (v & ~mask) | (val & mask);
> > +     writel(v, mem + offset);
> > +}
> > +
> > +#define lan_rmw(val, mask, reg, off)         \
> > +     lan_rmw_(val, mask, reg, lan_offset(off))
> > +
> > +struct serdes_ctrl {
> > +     void __iomem            *regs;
> > +     struct device           *dev;
> > +     struct phy              *phys[SERDES_MAX];
> > +     int                     ref125;
> > +};
> > +
> > +struct serdes_macro {
> > +     u8                      idx;
> > +     int                     port;
> > +     struct serdes_ctrl      *ctrl;
> > +     int                     speed;
> > +     phy_interface_t         mode;
> > +};
> > +
> > +enum lan966x_sd6g40_mode {
> > +     LAN966X_SD6G40_MODE_QSGMII,
> > +     LAN966X_SD6G40_MODE_SGMII,
> > +};
> > +
> > +enum lan966x_sd6g40_ltx2rx {
> > +     LAN966X_SD6G40_TX2RX_LOOP_NONE,
> > +     LAN966X_SD6G40_LTX2RX
> > +};
> > +
> > +struct lan966x_sd6g40_setup_args {
> > +     enum lan966x_sd6g40_mode        mode;
> > +     enum lan966x_sd6g40_ltx2rx      tx2rx_loop;
> > +     bool                            txinvert;
> > +     bool                            rxinvert;
> > +     bool                            refclk125M;
> > +     bool                            mute;
> > +};
> > +
> > +struct lan966x_sd6g40_mode_args {
> > +     enum lan966x_sd6g40_mode        mode;
> > +     u8                               lane_10bit_sel;
> > +     u8                               mpll_multiplier;
> > +     u8                               ref_clkdiv2;
> > +     u8                               tx_rate;
> > +     u8                               rx_rate;
> > +};
> > +
> > +struct lan966x_sd6g40_setup {
> > +     u8      rx_term_en;
> > +     u8      lane_10bit_sel;
> > +     u8      tx_invert;
> > +     u8      rx_invert;
> > +     u8      mpll_multiplier;
> > +     u8      lane_loopbk_en;
> > +     u8      ref_clkdiv2;
> > +     u8      tx_rate;
> > +     u8      rx_rate;
> > +};
> > +
> > +static int lan966x_sd6g40_reg_cfg(struct serdes_macro *macro,
> > +                               struct lan966x_sd6g40_setup *res_struct,
> > +                               u32 idx)
> > +{
> > +     u32 value;
> > +
> > +     /* Note: SerDes HSIO is configured in 1G_LAN mode */
> > +     lan_rmw(HSIO_SD_CFG_LANE_10BIT_SEL(res_struct->lane_10bit_sel) |
> > +             HSIO_SD_CFG_RX_RATE(res_struct->rx_rate) |
> > +             HSIO_SD_CFG_TX_RATE(res_struct->tx_rate) |
> > +             HSIO_SD_CFG_TX_INVERT(res_struct->tx_invert) |
> > +             HSIO_SD_CFG_RX_INVERT(res_struct->rx_invert) |
> > +             HSIO_SD_CFG_LANE_LOOPBK_EN(res_struct->lane_loopbk_en) |
> > +             HSIO_SD_CFG_RX_RESET(0) |
> > +             HSIO_SD_CFG_TX_RESET(0),
> > +             HSIO_SD_CFG_LANE_10BIT_SEL_M |
> > +             HSIO_SD_CFG_RX_RATE_M |
> > +             HSIO_SD_CFG_TX_RATE_M |
> > +             HSIO_SD_CFG_TX_INVERT_M |
> > +             HSIO_SD_CFG_RX_INVERT_M |
> > +             HSIO_SD_CFG_LANE_LOOPBK_EN_M |
> > +             HSIO_SD_CFG_RX_RESET_M |
> > +             HSIO_SD_CFG_TX_RESET_M,
> > +             macro->ctrl->regs, HSIO_SD_CFG(idx));
> > +
> > +     lan_rmw(HSIO_MPLL_CFG_MPLL_MULTIPLIER(res_struct->mpll_multiplier) |
> > +             HSIO_MPLL_CFG_REF_CLKDIV2(res_struct->ref_clkdiv2),
> > +             HSIO_MPLL_CFG_MPLL_MULTIPLIER_M |
> > +             HSIO_MPLL_CFG_REF_CLKDIV2_M,
> > +             macro->ctrl->regs, HSIO_MPLL_CFG(idx));
> > +
> > +     lan_rmw(HSIO_SD_CFG_RX_TERM_EN(res_struct->rx_term_en),
> > +             HSIO_SD_CFG_RX_TERM_EN_M,
> > +             macro->ctrl->regs, HSIO_SD_CFG(idx));
> > +
> > +     lan_rmw(HSIO_MPLL_CFG_REF_SSP_EN(1),
> > +             HSIO_MPLL_CFG_REF_SSP_EN_M,
> > +             macro->ctrl->regs, HSIO_MPLL_CFG(idx));
> > +
> > +     usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> > +
> > +     lan_rmw(HSIO_SD_CFG_PHY_RESET(0),
> > +             HSIO_SD_CFG_PHY_RESET_M,
> > +             macro->ctrl->regs, HSIO_SD_CFG(idx));
> > +
> > +     usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> > +
> > +     lan_rmw(HSIO_MPLL_CFG_MPLL_EN(1),
> > +             HSIO_MPLL_CFG_MPLL_EN_M,
> > +             macro->ctrl->regs, HSIO_MPLL_CFG(idx));
> > +
> > +     usleep_range(7 * USEC_PER_MSEC, 8 * USEC_PER_MSEC);
> > +
> > +     value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
> > +     value = HSIO_SD_STAT_MPLL_STATE_X(value);
> > +     if (value != 0x1) {
> > +             pr_info("Unexpected sd_sd_stat[%u] mpll_state was 0x1 but is 0x%x\n",
> > +                     idx, value);
> 
> maybe an err log? Also why not use dev_err here?

I will use dev_err.

> 
> > +             return -EIO;
> > +     }
> > +
> > +     lan_rmw(HSIO_SD_CFG_TX_CM_EN(1),
> > +             HSIO_SD_CFG_TX_CM_EN_M,
> > +             macro->ctrl->regs, HSIO_SD_CFG(idx));
> > +
> > +     usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> > +
> > +     value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
> > +     value = HSIO_SD_STAT_TX_CM_STATE_X(value);
> > +     if (value != 0x1) {
> > +             pr_info("Unexpected sd_sd_stat[%u] tx_cm_state was 0x1 but is 0x%x\n",
> > +                     idx, value);
> 
> here as well
> 
> > +             return -EIO;
> > +     }
> > +
> > +     lan_rmw(HSIO_SD_CFG_RX_PLL_EN(1) |
> > +             HSIO_SD_CFG_TX_EN(1),
> > +             HSIO_SD_CFG_RX_PLL_EN_M |
> > +             HSIO_SD_CFG_TX_EN_M,
> > +             macro->ctrl->regs, HSIO_SD_CFG(idx));
> > +
> > +     usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> > +
> > +     /* Waiting for serdes 0 rx DPLL to lock...  */
> > +     value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
> > +     value = HSIO_SD_STAT_RX_PLL_STATE_X(value);
> > +     if (value != 0x1) {
> > +             pr_info("Unexpected sd_sd_stat[%u] rx_pll_state was 0x1 but is 0x%x\n",
> > +                     idx, value);
> > +             return -EIO;
> > +     }
> > +
> > +     /* Waiting for serdes 0 tx operational...  */
> > +     value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
> > +     value = HSIO_SD_STAT_TX_STATE_X(value);
> > +     if (value != 0x1) {
> > +             pr_info("Unexpected sd_sd_stat[%u] tx_state was 0x1 but is 0x%x\n",
> > +                     idx, value);
> > +             return -EIO;
> > +     }
> > +
> > +     lan_rmw(HSIO_SD_CFG_TX_DATA_EN(1) |
> > +             HSIO_SD_CFG_RX_DATA_EN(1),
> > +             HSIO_SD_CFG_TX_DATA_EN_M |
> > +             HSIO_SD_CFG_RX_DATA_EN_M,
> > +             macro->ctrl->regs, HSIO_SD_CFG(idx));
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_sd6g40_get_conf_from_mode(struct serdes_macro *macro,
> > +                                          enum lan966x_sd6g40_mode f_mode,
> > +                                          bool ref125M,
> > +                                          struct lan966x_sd6g40_mode_args *ret_val)
> > +{
> > +     switch (f_mode) {
> > +     case LAN966X_SD6G40_MODE_QSGMII:
> > +             ret_val->lane_10bit_sel = 0;
> > +             if (ref125M) {
> > +                     ret_val->mpll_multiplier = 40;
> > +                     ret_val->ref_clkdiv2 = 0x1;
> > +                     ret_val->tx_rate = 0x0;
> > +                     ret_val->rx_rate = 0x0;
> > +             } else {
> > +                     ret_val->mpll_multiplier = 100;
> > +                     ret_val->ref_clkdiv2 = 0x0;
> > +                     ret_val->tx_rate = 0x0;
> > +                     ret_val->rx_rate = 0x0;
> > +             }
> > +             break;
> 
> empty line here please
> 
> > +     case LAN966X_SD6G40_MODE_SGMII:
> > +             ret_val->lane_10bit_sel = 1;
> > +             if (ref125M) {
> > +                     ret_val->mpll_multiplier = macro->speed == SPEED_2500 ? 50 : 40;
> > +                     ret_val->ref_clkdiv2 = 0x1;
> > +                     ret_val->tx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
> > +                     ret_val->rx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
> > +             } else {
> > +                     ret_val->mpll_multiplier = macro->speed == SPEED_2500 ? 125 : 100;
> > +                     ret_val->ref_clkdiv2 = 0x0;
> > +                     ret_val->tx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
> > +                     ret_val->rx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
> > +             }
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_calc_sd6g40_setup_lane(struct serdes_macro *macro,
> > +                                       struct lan966x_sd6g40_setup_args config,
> > +                                       struct lan966x_sd6g40_setup *ret_val)
> > +{
> > +     struct lan966x_sd6g40_mode_args sd6g40_mode;
> > +     struct lan966x_sd6g40_mode_args *mode_args = &sd6g40_mode;
> > +     int ret;
> > +
> > +     ret = lan966x_sd6g40_get_conf_from_mode(macro, config.mode,
> > +                                             config.refclk125M, mode_args);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret_val->lane_10bit_sel = mode_args->lane_10bit_sel;
> > +     ret_val->rx_rate = mode_args->rx_rate;
> > +     ret_val->tx_rate = mode_args->tx_rate;
> > +     ret_val->mpll_multiplier = mode_args->mpll_multiplier;
> > +     ret_val->ref_clkdiv2 = mode_args->ref_clkdiv2;
> > +     ret_val->rx_term_en = 0;
> > +
> > +     if (config.tx2rx_loop == LAN966X_SD6G40_LTX2RX)
> > +             ret_val->lane_loopbk_en = 1;
> > +     else
> > +             ret_val->lane_loopbk_en = 0;
> > +
> > +     if (config.txinvert)
> > +             ret_val->tx_invert = 1;
> > +     else
> > +             ret_val->tx_invert = 0;
> 
>         ret_val->tx_invert = !!config.txinvert;
> 
> > +
> > +     if (config.rxinvert)
> > +             ret_val->rx_invert = 1;
> > +     else
> > +             ret_val->rx_invert = 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_sd6g40_setup_lane(struct serdes_macro *macro,
> > +                                  struct lan966x_sd6g40_setup_args config,
> > +                                  u32 idx)
> > +{
> > +     struct lan966x_sd6g40_setup calc_results;
> > +     int ret;
> > +
> > +     memset(&calc_results, 0x0, sizeof(calc_results));
> 
> why not initialize calc_results and skip memeset
> 
>         struct lan966x_sd6g40_setup calc_results = {};
> > +
> > +     ret = lan966x_calc_sd6g40_setup_lane(macro, config, &calc_results);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return lan966x_sd6g40_reg_cfg(macro, &calc_results, idx);
> > +}
> > +
> > +static int lan966x_sd6g40_setup(struct serdes_macro *macro, u32 idx, int mode)
> > +{
> > +     struct lan966x_sd6g40_setup_args conf;
> > +
> > +     memset(&conf, 0x0, sizeof(conf));
> 
> here too
> 
> > +     conf.refclk125M = macro->ctrl->ref125;
> > +
> > +     if (mode == PHY_INTERFACE_MODE_QSGMII)
> > +             conf.mode = LAN966X_SD6G40_MODE_QSGMII;
> > +     else
> > +             conf.mode = LAN966X_SD6G40_MODE_SGMII;
> > +
> > +     return lan966x_sd6g40_setup_lane(macro, conf, idx);
> > +}
> > +
> > +struct serdes_mux {
> > +     u8                      idx;
> > +     u8                      port;
> > +     enum phy_mode           mode;
> > +     int                     submode;
> > +     u32                     mask;
> > +     u32                     mux;
> > +};
> > +
> > +#define SERDES_MUX(_idx, _port, _mode, _submode, _mask, _mux) { \
> > +     .idx = _idx,                                            \
> > +     .port = _port,                                          \
> > +     .mode = _mode,                                          \
> > +     .submode = _submode,                                    \
> > +     .mask = _mask,                                          \
> > +     .mux = _mux,                                            \
> > +}
> 
> structs and macros at the top fo the file pls
> 
> > +
> > +#define SERDES_MUX_GMII(i, p, m, c) \
> > +     SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_GMII, m, c)
> > +#define SERDES_MUX_SGMII(i, p, m, c) \
> > +     SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_SGMII, m, c)
> > +#define SERDES_MUX_QSGMII(i, p, m, c) \
> > +     SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_QSGMII, m, c)
> > +#define SERDES_MUX_RGMII(i, p, m, c) \
> > +     SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_RGMII, m, c)
> > +
> > +static const struct serdes_mux lan966x_serdes_muxes[] = {
> > +     SERDES_MUX_QSGMII(SERDES6G(1), 0, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(0))),
> > +     SERDES_MUX_QSGMII(SERDES6G(1), 1, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(0))),
> > +     SERDES_MUX_QSGMII(SERDES6G(1), 2, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(0))),
> > +     SERDES_MUX_QSGMII(SERDES6G(1), 3, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(0))),
> > +
> > +     SERDES_MUX_QSGMII(SERDES6G(2), 4, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(1))),
> > +     SERDES_MUX_QSGMII(SERDES6G(2), 5, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(1))),
> > +     SERDES_MUX_QSGMII(SERDES6G(2), 6, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(1))),
> > +     SERDES_MUX_QSGMII(SERDES6G(2), 7, HSIO_HW_CFG_QSGMII_ENA_M,
> > +                       HSIO_HW_CFG_QSGMII_ENA(BIT(1))),
> > +
> > +     SERDES_MUX_GMII(PHY(0), 0, HSIO_HW_CFG_GMII_ENA_M,
> > +                     HSIO_HW_CFG_GMII_ENA(BIT(0))),
> > +     SERDES_MUX_GMII(PHY(1), 1, HSIO_HW_CFG_GMII_ENA_M,
> > +                     HSIO_HW_CFG_GMII_ENA(BIT(1))),
> > +
> > +     SERDES_MUX_SGMII(SERDES6G(0), 0, HSIO_HW_CFG_SD6G_0_CFG_M, 0),
> > +     SERDES_MUX_SGMII(SERDES6G(1), 1, HSIO_HW_CFG_SD6G_1_CFG_M, 0),
> > +     SERDES_MUX_SGMII(SERDES6G(0), 2, HSIO_HW_CFG_SD6G_0_CFG_M,
> > +                      HSIO_HW_CFG_SD6G_0_CFG(1)),
> > +     SERDES_MUX_SGMII(SERDES6G(1), 3, HSIO_HW_CFG_SD6G_1_CFG_M,
> > +                      HSIO_HW_CFG_SD6G_1_CFG(1)),
> > +
> > +     SERDES_MUX_RGMII(RGMII(0), 2, HSIO_HW_CFG_RGMII_0_CFG_M |
> > +                      HSIO_HW_CFG_RGMII_ENA_M,
> > +                      HSIO_HW_CFG_RGMII_0_CFG(BIT(0)) |
> > +                      HSIO_HW_CFG_RGMII_ENA(BIT(0))),
> > +     SERDES_MUX_RGMII(RGMII(1), 3, HSIO_HW_CFG_RGMII_1_CFG_M |
> > +                      HSIO_HW_CFG_RGMII_ENA_M,
> > +                      HSIO_HW_CFG_RGMII_1_CFG(BIT(0)) |
> > +                      HSIO_HW_CFG_RGMII_ENA(BIT(1))),
> > +     SERDES_MUX_RGMII(RGMII(0), 5, HSIO_HW_CFG_RGMII_0_CFG_M |
> > +                      HSIO_HW_CFG_RGMII_ENA_M,
> > +                      HSIO_HW_CFG_RGMII_0_CFG(BIT(0)) |
> > +                      HSIO_HW_CFG_RGMII_ENA(BIT(0))),
> > +     SERDES_MUX_RGMII(RGMII(1), 6, HSIO_HW_CFG_RGMII_1_CFG_M |
> > +                      HSIO_HW_CFG_RGMII_ENA_M,
> > +                      HSIO_HW_CFG_RGMII_1_CFG(BIT(0)) |
> > +                      HSIO_HW_CFG_RGMII_ENA(BIT(1))),
> > +};
> > +
> > +static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> > +{
> > +     struct serdes_macro *macro = phy_get_drvdata(phy);
> > +     unsigned int i;
> > +     int val;
> > +
> > +     /* As of now only PHY_MODE_ETHERNET is supported */
> > +     if (mode != PHY_MODE_ETHERNET)
> > +             return -EOPNOTSUPP;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(lan966x_serdes_muxes); i++) {
> > +             if (macro->idx != lan966x_serdes_muxes[i].idx ||
> > +                 mode != lan966x_serdes_muxes[i].mode ||
> > +                 submode != lan966x_serdes_muxes[i].submode ||
> > +                 macro->port != lan966x_serdes_muxes[i].port)
> > +                     continue;
> > +
> > +             val = readl(macro->ctrl->regs + lan_offset(HSIO_HW_CFG));
> > +             val |= lan966x_serdes_muxes[i].mux;
> > +             lan_rmw(val, lan966x_serdes_muxes[i].mask,
> > +                     macro->ctrl->regs, HSIO_HW_CFG);
> > +
> > +             macro->mode = lan966x_serdes_muxes[i].submode;
> > +
> > +             if (macro->idx < PHY_MAX)
> > +                     return 0;
> > +
> > +             if (macro->idx < SERDES6G_MAX)
> > +                     return lan966x_sd6g40_setup(macro,
> > +                                                 macro->idx - (PHY_MAX + 1),
> > +                                                 macro->mode);
> > +
> > +             if (macro->idx < RGMII_MAX)
> > +                     return 0;
> > +
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int serdes_set_speed(struct phy *phy, int speed)
> > +{
> > +     struct serdes_macro *macro = phy_get_drvdata(phy);
> > +
> > +     macro->speed = speed;
> > +
> > +     return lan966x_sd6g40_setup(macro, macro->idx - (PHY_MAX + 1),
> > +                                 macro->mode);
> > +}
> > +
> > +static const struct phy_ops serdes_ops = {
> > +     .set_mode       = serdes_set_mode,
> > +     .set_speed      = serdes_set_speed,
> > +     .owner          = THIS_MODULE,
> > +};
> > +
> > +static struct phy *serdes_simple_xlate(struct device *dev,
> > +                                    struct of_phandle_args *args)
> > +{
> > +     struct serdes_ctrl *ctrl = dev_get_drvdata(dev);
> > +     unsigned int port, idx, i;
> > +
> > +     if (args->args_count != 2)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     port = args->args[0];
> > +     idx = args->args[1];
> > +
> > +     for (i = 0; i < SERDES_MAX; i++) {
> > +             struct serdes_macro *macro = phy_get_drvdata(ctrl->phys[i]);
> > +
> > +             if (idx != macro->idx)
> > +                     continue;
> > +
> > +             macro->port = port;
> > +             return ctrl->phys[i];
> > +     }
> > +
> > +     return ERR_PTR(-ENODEV);
> > +}
> > +
> > +static int serdes_phy_create(struct serdes_ctrl *ctrl, u8 idx, struct phy **phy)
> > +{
> > +     struct serdes_macro *macro;
> > +
> > +     *phy = devm_phy_create(ctrl->dev, NULL, &serdes_ops);
> > +     if (IS_ERR(*phy))
> > +             return PTR_ERR(*phy);
> > +
> > +     macro = devm_kzalloc(ctrl->dev, sizeof(*macro), GFP_KERNEL);
> > +     if (!macro)
> > +             return -ENOMEM;
> > +
> > +     macro->idx = idx;
> > +     macro->ctrl = ctrl;
> > +     macro->speed = SPEED_1000;
> > +     macro->port = -1;
> > +
> > +     phy_set_drvdata(*phy, macro);
> > +
> > +     return 0;
> > +}
> > +
> > +static int serdes_probe(struct platform_device *pdev)
> > +{
> > +     struct phy_provider *provider;
> > +     struct serdes_ctrl *ctrl;
> > +     void __iomem *hw_stat;
> > +     unsigned int i;
> > +     u32 val;
> > +     int ret;
> > +
> > +     ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
> > +     if (!ctrl)
> > +             return -ENOMEM;
> > +
> > +     ctrl->dev = &pdev->dev;
> > +     ctrl->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> > +     if (IS_ERR(ctrl->regs))
> > +             return PTR_ERR(ctrl->regs);
> > +
> > +     hw_stat = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
> > +     if (IS_ERR(hw_stat))
> > +             return PTR_ERR(hw_stat);
> > +
> > +     for (i = 0; i < SERDES_MAX; i++) {
> > +             ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     val = readl(hw_stat);
> > +     val = (GENMASK(4, 3) & val) >> 3;
> > +     ctrl->ref125 = (val == 1 || val == 2);
> 
> lots of magic values pls define them
> 
> > +
> > +     dev_set_drvdata(&pdev->dev, ctrl);
> > +
> > +     provider = devm_of_phy_provider_register(ctrl->dev,
> > +                                              serdes_simple_xlate);
> > +
> > +     return PTR_ERR_OR_ZERO(provider);
> > +}
> > +
> > +static const struct of_device_id serdes_ids[] = {
> > +     { .compatible = "microchip,lan966x-serdes", },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, serdes_ids);
> > +
> > +static struct platform_driver mscc_lan966x_serdes = {
> > +     .probe          = serdes_probe,
> > +     .driver         = {
> > +             .name   = "microchip,lan966x-serdes",
> > +             .of_match_table = of_match_ptr(serdes_ids),
> > +     },
> > +};
> 
> No MODULE_LICENSE()?
> 
> > +
> > +module_platform_driver(mscc_lan966x_serdes);
> > diff --git a/drivers/phy/microchip/lan966x_serdes_regs.h b/drivers/phy/microchip/lan966x_serdes_regs.h
> > new file mode 100644
> > index 000000000000..c3d3d16c1e97
> > --- /dev/null
> > +++ b/drivers/phy/microchip/lan966x_serdes_regs.h
> > @@ -0,0 +1,482 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/*
> > + * Microchip LAN966x Switch driver
> > + *
> > + * License: Dual MIT/GPL
> > + * Copyright (c) 2020 Microchip Technology Inc.
> > + */
> > +
> > +/* This file is autogenerated by cml-utils 2021-05-12 15:48:55 +0200.
> 
> what is this cml-utils?

This is an internal tool that helps to generate these register files.
I should remove this message.

> 
> > + * Commit ID: dbe188f718027a2c414b90d45f152b73468cbc5c (dirty)
> > + */
> > +
> > +#ifndef _LAN966X_HSIO_REGS_H_
> > +#define _LAN966X_HSIO_REGS_H_
> > +
> > +#include <linux/bitops.h>
> > +
> > +#define LAN966X_BUILD_ID_REG GCB_BUILDID
> > +enum lan966x_target {
> > +     TARGET_HSIO = 32,
> > +     NUM_TARGETS = 66
> > +};
> > +
> > +#define __REG(...)    __VA_ARGS__
> > +
> > +/*      HSIO:SYNC_ETH_CFG:SYNC_ETH_CFG */
> > +#define HSIO_SYNC_ETH_CFG(r)      __REG(TARGET_HSIO,\
> > +                                     0, 1, 0, 0, 1, 8, 0, r, 2, 4)
> > +
> > +#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_SRC(x)    (((x) << 4) & GENMASK(6, 4))
> > +#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_SRC_M     GENMASK(6, 4)
> > +#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_SRC_X(x)  (((x) & GENMASK(6, 4)) >> 4)
> > +
> > +#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_DIV(x)    (((x) << 1) & GENMASK(3, 1))
> > +#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_DIV_M     GENMASK(3, 1)
> > +#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_DIV_X(x)  (((x) & GENMASK(3, 1)) >> 1)
> > +
> > +#define HSIO_SYNC_ETH_CFG_RECO_CLK_ENA(x)        ((x) & GENMASK(0, 0))
> > +#define HSIO_SYNC_ETH_CFG_RECO_CLK_ENA_M         GENMASK(0, 0)
> > +#define HSIO_SYNC_ETH_CFG_RECO_CLK_ENA_X(x)      ((x) & GENMASK(0, 0))
> > +
> > +/*      HSIO:SD:SD_CFG */
> > +#define HSIO_SD_CFG(g)            __REG(TARGET_HSIO,\
> > +                                     0, 1, 8, g, 3, 32, 0, 0, 1, 4)
> > +
> > +#define HSIO_SD_CFG_TEST_POWERDOWN(x)            (((x) << 28) & GENMASK(28, 28))
> > +#define HSIO_SD_CFG_TEST_POWERDOWN_M             GENMASK(28, 28)
> > +#define HSIO_SD_CFG_TEST_POWERDOWN_X(x)          (((x) & GENMASK(28, 28)) >> 28)
> > +
> > +#define HSIO_SD_CFG_PHY_RESET(x)                 (((x) << 27) & GENMASK(27, 27))
> > +#define HSIO_SD_CFG_PHY_RESET_M                  GENMASK(27, 27)
> > +#define HSIO_SD_CFG_PHY_RESET_X(x)               (((x) & GENMASK(27, 27)) >> 27)
> > +
> > +#define HSIO_SD_CFG_RX_LOS_FILT_CNT(x)           (((x) << 20) & GENMASK(26, 20))
> > +#define HSIO_SD_CFG_RX_LOS_FILT_CNT_M            GENMASK(26, 20)
> > +#define HSIO_SD_CFG_RX_LOS_FILT_CNT_X(x)         (((x) & GENMASK(26, 20)) >> 20)
> > +
> > +#define HSIO_SD_CFG_TX_VBOOST_EN(x)              (((x) << 19) & GENMASK(19, 19))
> > +#define HSIO_SD_CFG_TX_VBOOST_EN_M               GENMASK(19, 19)
> > +#define HSIO_SD_CFG_TX_VBOOST_EN_X(x)            (((x) & GENMASK(19, 19)) >> 19)
> > +
> > +#define HSIO_SD_CFG_TX_RESET(x)                  (((x) << 18) & GENMASK(18, 18))
> > +#define HSIO_SD_CFG_TX_RESET_M                   GENMASK(18, 18)
> > +#define HSIO_SD_CFG_TX_RESET_X(x)                (((x) & GENMASK(18, 18)) >> 18)
> > +
> > +#define HSIO_SD_CFG_TX_RATE(x)                   (((x) << 16) & GENMASK(17, 16))
> > +#define HSIO_SD_CFG_TX_RATE_M                    GENMASK(17, 16)
> > +#define HSIO_SD_CFG_TX_RATE_X(x)                 (((x) & GENMASK(17, 16)) >> 16)
> > +
> > +#define HSIO_SD_CFG_TX_INVERT(x)                 (((x) << 15) & GENMASK(15, 15))
> > +#define HSIO_SD_CFG_TX_INVERT_M                  GENMASK(15, 15)
> > +#define HSIO_SD_CFG_TX_INVERT_X(x)               (((x) & GENMASK(15, 15)) >> 15)
> > +
> > +#define HSIO_SD_CFG_TX_EN(x)                     (((x) << 14) & GENMASK(14, 14))
> > +#define HSIO_SD_CFG_TX_EN_M                      GENMASK(14, 14)
> > +#define HSIO_SD_CFG_TX_EN_X(x)                   (((x) & GENMASK(14, 14)) >> 14)
> > +
> > +#define HSIO_SD_CFG_TX_DETECT_RX_REQ(x)          (((x) << 13) & GENMASK(13, 13))
> > +#define HSIO_SD_CFG_TX_DETECT_RX_REQ_M           GENMASK(13, 13)
> > +#define HSIO_SD_CFG_TX_DETECT_RX_REQ_X(x)        (((x) & GENMASK(13, 13)) >> 13)
> > +
> > +#define HSIO_SD_CFG_TX_DATA_EN(x)                (((x) << 12) & GENMASK(12, 12))
> > +#define HSIO_SD_CFG_TX_DATA_EN_M                 GENMASK(12, 12)
> > +#define HSIO_SD_CFG_TX_DATA_EN_X(x)              (((x) & GENMASK(12, 12)) >> 12)
> > +
> > +#define HSIO_SD_CFG_TX_CM_EN(x)                  (((x) << 11) & GENMASK(11, 11))
> > +#define HSIO_SD_CFG_TX_CM_EN_M                   GENMASK(11, 11)
> > +#define HSIO_SD_CFG_TX_CM_EN_X(x)                (((x) & GENMASK(11, 11)) >> 11)
> > +
> > +#define HSIO_SD_CFG_LANE_10BIT_SEL(x)            (((x) << 10) & GENMASK(10, 10))
> > +#define HSIO_SD_CFG_LANE_10BIT_SEL_M             GENMASK(10, 10)
> > +#define HSIO_SD_CFG_LANE_10BIT_SEL_X(x)          (((x) & GENMASK(10, 10)) >> 10)
> > +
> > +#define HSIO_SD_CFG_RX_TERM_EN(x)                (((x) << 9) & GENMASK(9, 9))
> > +#define HSIO_SD_CFG_RX_TERM_EN_M                 GENMASK(9, 9)
> > +#define HSIO_SD_CFG_RX_TERM_EN_X(x)              (((x) & GENMASK(9, 9)) >> 9)
> > +
> > +#define HSIO_SD_CFG_RX_RESET(x)                  (((x) << 8) & GENMASK(8, 8))
> > +#define HSIO_SD_CFG_RX_RESET_M                   GENMASK(8, 8)
> > +#define HSIO_SD_CFG_RX_RESET_X(x)                (((x) & GENMASK(8, 8)) >> 8)
> > +
> > +#define HSIO_SD_CFG_RX_RATE(x)                   (((x) << 6) & GENMASK(7, 6))
> > +#define HSIO_SD_CFG_RX_RATE_M                    GENMASK(7, 6)
> > +#define HSIO_SD_CFG_RX_RATE_X(x)                 (((x) & GENMASK(7, 6)) >> 6)
> > +
> > +#define HSIO_SD_CFG_RX_PLL_EN(x)                 (((x) << 5) & GENMASK(5, 5))
> > +#define HSIO_SD_CFG_RX_PLL_EN_M                  GENMASK(5, 5)
> > +#define HSIO_SD_CFG_RX_PLL_EN_X(x)               (((x) & GENMASK(5, 5)) >> 5)
> > +
> > +#define HSIO_SD_CFG_RX_LOS_EN(x)                 (((x) << 4) & GENMASK(4, 4))
> > +#define HSIO_SD_CFG_RX_LOS_EN_M                  GENMASK(4, 4)
> > +#define HSIO_SD_CFG_RX_LOS_EN_X(x)               (((x) & GENMASK(4, 4)) >> 4)
> > +
> > +#define HSIO_SD_CFG_RX_INVERT(x)                 (((x) << 3) & GENMASK(3, 3))
> > +#define HSIO_SD_CFG_RX_INVERT_M                  GENMASK(3, 3)
> > +#define HSIO_SD_CFG_RX_INVERT_X(x)               (((x) & GENMASK(3, 3)) >> 3)
> > +
> > +#define HSIO_SD_CFG_RX_DATA_EN(x)                (((x) << 2) & GENMASK(2, 2))
> > +#define HSIO_SD_CFG_RX_DATA_EN_M                 GENMASK(2, 2)
> > +#define HSIO_SD_CFG_RX_DATA_EN_X(x)              (((x) & GENMASK(2, 2)) >> 2)
> > +
> > +#define HSIO_SD_CFG_RX_ALIGN_EN(x)               (((x) << 1) & GENMASK(1, 1))
> > +#define HSIO_SD_CFG_RX_ALIGN_EN_M                GENMASK(1, 1)
> > +#define HSIO_SD_CFG_RX_ALIGN_EN_X(x)             (((x) & GENMASK(1, 1)) >> 1)
> > +
> > +#define HSIO_SD_CFG_LANE_LOOPBK_EN(x)            ((x) & GENMASK(0, 0))
> > +#define HSIO_SD_CFG_LANE_LOOPBK_EN_M             GENMASK(0, 0)
> > +#define HSIO_SD_CFG_LANE_LOOPBK_EN_X(x)          ((x) & GENMASK(0, 0))
> > +
> > +/*      HSIO:SD:SD_CFG2 */
> > +#define HSIO_SD_CFG2(g)           __REG(TARGET_HSIO,\
> > +                                     0, 1, 8, g, 3, 32, 4, 0, 1, 4)
> > +
> > +#define HSIO_SD_CFG2_RX_EQ(x)                    (((x) << 25) & GENMASK(27, 25))
> > +#define HSIO_SD_CFG2_RX_EQ_M                     GENMASK(27, 25)
> > +#define HSIO_SD_CFG2_RX_EQ_X(x)                  (((x) & GENMASK(27, 25)) >> 25)
> 
> You should look at bitfield.h for helpers, you can skip these

I will update that.

> --
> ~Vinod

-- 
/Horatiu
