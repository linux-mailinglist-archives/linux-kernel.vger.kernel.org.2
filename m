Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B707B3E10D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbhHEJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:07:34 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:53995 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbhHEJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:07:29 -0400
Date:   Thu, 05 Aug 2021 09:06:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628154421;
        bh=Q7Fpsl4J3iKuFHJljFspjzLHt+Wd1fhMNWimQI06REc=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=JRZsbsaD47JzMGRnDdmIpHJz6FDtMXrjBfONBv2Xpr1N8t/wngddu/SLkotkLu8k9
         MaHkBVv7A1KwXqvQLA8yq4Z3DFEl40c5Zd/4pkPGt1UAK3CA+Vn1i4VzaXkYXy1nil
         mSh8OowwNWbqq5jvtorwZ6XnFbMyTXsmQfJPVAdg=
To:     bjorn.andersson@linaro.org
From:   Sireesh Kodali <sireeshkodali@protonmail.com>
Cc:     agross@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vladimir Lypak <junak.pub@gmail.com>,
        Adam Skladowski <a_skl39@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sireesh Kodali <sireeshkodali@protonmail.com>
Reply-To: Sireesh Kodali <sireeshkodali@protonmail.com>
Subject: [PATCH RESEND 2/2] clk: qcom: Add Global Clock Controller driver for MSM8953
Message-ID: <IPvVnyRWbHuQFswiFz0W08Kj1dKoH55ddQVyIIPhMJw@cp7-web-043.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <junak.pub@gmail.com>

This driver provides clocks, resets and power domains for MSM8953
and compatible SoCs: APQ8053, SDM450, SDA450, SDM632, SDA632.

Signed-off-by: Vladimir Lypak <junak.pub@gmail.com>
Signed-off-by: Adam Skladowski <a_skl39@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Sireesh Kodali <sireeshkodali@protonmail.com>
---
 drivers/clk/qcom/Kconfig       |    8 +
 drivers/clk/qcom/Makefile      |    1 +
 drivers/clk/qcom/gcc-msm8953.c | 4250 ++++++++++++++++++++++++++++++++
 3 files changed, 4259 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-msm8953.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 62e00e15495c..a1cab9245b5e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -240,6 +240,14 @@ config MSM_MMCC_8960
 =09  Say Y if you want to support multimedia devices such as display,
 =09  graphics, video encode/decode, camera, etc.
=20
+config MSM_GCC_8953
+=09tristate "MSM8953 Global Clock Controller"
+=09select QCOM_GDSC
+=09help
+=09  Support for the global clock controller on msm8953 devices.
+=09  Say Y if you want to use devices such as UART, SPI i2c, USB,
+=09  SD/eMMC, display, graphics, camera etc.
+
 config MSM_GCC_8974
 =09tristate "MSM8974 Global Clock Controller"
 =09select QCOM_GDSC
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index c2a1cafb31bc..1d9bfc1b67b7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_MDM_LCC_9615) +=3D lcc-mdm9615.o
 obj-$(CONFIG_MSM_GCC_8660) +=3D gcc-msm8660.o
 obj-$(CONFIG_MSM_GCC_8916) +=3D gcc-msm8916.o
 obj-$(CONFIG_MSM_GCC_8939) +=3D gcc-msm8939.o
+obj-$(CONFIG_MSM_GCC_8953) +=3D gcc-msm8953.o
 obj-$(CONFIG_MSM_GCC_8960) +=3D gcc-msm8960.o
 obj-$(CONFIG_MSM_GCC_8974) +=3D gcc-msm8974.o
 obj-$(CONFIG_MSM_GCC_8994) +=3D gcc-msm8994.o
diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.=
c
new file mode 100644
index 000000000000..49513f1366ff
--- /dev/null
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -0,0 +1,4250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2021, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/qcom,gcc-msm8953.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "common.h"
+#include "gdsc.h"
+#include "reset.h"
+
+enum {
+=09P_XO,
+=09P_SLEEP_CLK,
+=09P_GPLL0,
+=09P_GPLL0_DIV2,
+=09P_GPLL2,
+=09P_GPLL3,
+=09P_GPLL4,
+=09P_GPLL6,
+=09P_GPLL6_DIV2,
+=09P_DSI0PLL,
+=09P_DSI0PLL_BYTE,
+=09P_DSI1PLL,
+=09P_DSI1PLL_BYTE,
+};
+
+static struct clk_alpha_pll gpll0_early =3D {
+=09.offset =3D 0x21000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45000,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gpll0_early",
+=09=09=09.parent_data =3D &(const struct clk_parent_data) {
+=09=09=09=09.fw_name =3D "xo",
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_alpha_pll_fixed_ops,
+=09=09},
+=09},
+};
+
+static struct clk_fixed_factor gpll0_early_div =3D {
+=09.mult =3D 1,
+=09.div =3D 2,
+=09.hw.init =3D &(struct clk_init_data){
+=09=09.name =3D "gpll0_early_div",
+=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09&gpll0_early.clkr.hw,
+=09=09},
+=09=09.num_parents =3D 1,
+=09=09.ops =3D &clk_fixed_factor_ops,
+=09},
+};
+
+static struct clk_alpha_pll_postdiv gpll0 =3D {
+=09.offset =3D 0x21000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr.hw.init =3D &(struct clk_init_data){
+=09=09.name =3D "gpll0",
+=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09&gpll0_early.clkr.hw,
+=09=09},
+=09=09.num_parents =3D 1,
+=09=09.ops =3D &clk_alpha_pll_postdiv_ro_ops,
+=09},
+};
+
+static struct clk_alpha_pll gpll2_early =3D {
+=09.offset =3D 0x4a000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45000,
+=09=09.enable_mask =3D BIT(2),
+=09=09.hw.init =3D &(struct clk_init_data){
+=09=09=09.name =3D "gpll2_early",
+=09=09=09.parent_data =3D &(const struct clk_parent_data) {
+=09=09=09=09.fw_name =3D "xo",
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_alpha_pll_fixed_ops,
+=09=09},
+=09},
+};
+
+static struct clk_alpha_pll_postdiv gpll2 =3D {
+=09.offset =3D 0x4a000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr.hw.init =3D &(struct clk_init_data){
+=09=09.name =3D "gpll2",
+=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09&gpll2_early.clkr.hw,
+=09=09},
+=09=09.num_parents =3D 1,
+=09=09.ops =3D &clk_alpha_pll_postdiv_ro_ops,
+=09},
+};
+
+static const struct pll_vco gpll3_p_vco[] =3D {
+=09{ 1000000000, 2000000000, 0 },
+};
+
+static const struct alpha_pll_config gpll3_early_config =3D {
+=09.l =3D 63,
+=09.config_ctl_val =3D 0x4001055b,
+=09.early_output_mask =3D 0,
+=09.post_div_mask =3D GENMASK(11, 8),
+=09.post_div_val =3D BIT(8),
+};
+
+static struct clk_alpha_pll gpll3_early =3D {
+=09.offset =3D 0x22000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.vco_table =3D gpll3_p_vco,
+=09.num_vco =3D ARRAY_SIZE(gpll3_p_vco),
+=09.flags =3D SUPPORTS_DYNAMIC_UPDATE,
+=09.clkr =3D {
+=09=09.hw.init =3D &(struct clk_init_data){
+=09=09=09.name =3D "gpll3_early",
+=09=09=09.parent_data =3D &(const struct clk_parent_data) {
+=09=09=09=09.fw_name =3D "xo",
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_alpha_pll_ops,
+=09=09},
+=09},
+};
+
+static struct clk_alpha_pll_postdiv gpll3 =3D {
+=09.offset =3D 0x22000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr.hw.init =3D &(struct clk_init_data){
+=09=09.name =3D "gpll3",
+=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09&gpll3_early.clkr.hw,
+=09=09},
+=09=09.num_parents =3D 1,
+=09=09.ops =3D &clk_alpha_pll_postdiv_ops,
+=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09},
+};
+
+static struct clk_alpha_pll gpll4_early =3D {
+=09.offset =3D 0x24000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45000,
+=09=09.enable_mask =3D BIT(5),
+=09=09.hw.init =3D &(struct clk_init_data){
+=09=09=09.name =3D "gpll4_early",
+=09=09=09.parent_data =3D &(const struct clk_parent_data) {
+=09=09=09=09.fw_name =3D "xo",
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_alpha_pll_fixed_ops,
+=09=09},
+=09},
+};
+
+static struct clk_alpha_pll_postdiv gpll4 =3D {
+=09.offset =3D 0x24000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr.hw.init =3D &(struct clk_init_data){
+=09=09.name =3D "gpll4",
+=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09&gpll4_early.clkr.hw,
+=09=09},
+=09=09.num_parents =3D 1,
+=09=09.ops =3D &clk_alpha_pll_postdiv_ro_ops,
+=09},
+};
+
+static struct clk_alpha_pll gpll6_early =3D {
+=09.offset =3D 0x37000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45000,
+=09=09.enable_mask =3D BIT(7),
+=09=09.hw.init =3D &(struct clk_init_data){
+=09=09=09.name =3D "gpll6_early",
+=09=09=09.parent_data =3D &(const struct clk_parent_data) {
+=09=09=09=09.fw_name =3D "xo",
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_alpha_pll_fixed_ops,
+=09=09},
+=09},
+};
+
+static struct clk_fixed_factor gpll6_early_div =3D {
+=09.mult =3D 1,
+=09.div =3D 2,
+=09.hw.init =3D &(struct clk_init_data){
+=09=09.name =3D "gpll6_early_div",
+=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09&gpll6_early.clkr.hw,
+=09=09},
+=09=09.num_parents =3D 1,
+=09=09.ops =3D &clk_fixed_factor_ops,
+=09},
+};
+
+static struct clk_alpha_pll_postdiv gpll6 =3D {
+=09.offset =3D 0x37000,
+=09.regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+=09.clkr.hw.init =3D &(struct clk_init_data){
+=09=09.name =3D "gpll6",
+=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09&gpll6_early.clkr.hw,
+=09=09},
+=09=09.num_parents =3D 1,
+=09=09.ops =3D &clk_alpha_pll_postdiv_ro_ops,
+=09},
+};
+
+static const struct parent_map gcc_xo_gpll0_gpll0div2_2_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL0_DIV2, 2 },
+};
+
+static const struct parent_map gcc_xo_gpll0_gpll0div2_4_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL0_DIV2, 4 },
+};
+
+static const struct clk_parent_data gcc_xo_gpll0_gpll0div2_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct parent_map gcc_apc_droop_detector_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL4, 2 },
+};
+
+static const struct clk_parent_data gcc_apc_droop_detector_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll4.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_apc_droop_detector_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(400000000, P_GPLL0, 2, 0, 0),
+=09F(576000000, P_GPLL4, 2, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 apc0_droop_detector_clk_src =3D {
+=09.cmd_rcgr =3D 0x78008,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_apc_droop_detector_clk_src,
+=09.parent_map =3D gcc_apc_droop_detector_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "apc0_droop_detector_clk_src",
+=09=09.parent_data =3D gcc_apc_droop_detector_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_apc_droop_detector_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+static struct clk_rcg2 apc1_droop_detector_clk_src =3D {
+=09.cmd_rcgr =3D 0x79008,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_apc_droop_detector_clk_src,
+=09.parent_map =3D gcc_apc_droop_detector_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "apc1_droop_detector_clk_src",
+=09=09.parent_data =3D gcc_apc_droop_detector_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_apc_droop_detector_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_apss_ahb_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(25000000, P_GPLL0_DIV2, 16, 0, 0),
+=09F(50000000, P_GPLL0, 16, 0, 0),
+=09F(100000000, P_GPLL0, 8, 0, 0),
+=09F(133330000, P_GPLL0, 6, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 apss_ahb_clk_src =3D {
+=09.cmd_rcgr =3D 0x46000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_apss_ahb_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_4_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "apss_ahb_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_blsp_i2c_apps_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(25000000, P_GPLL0_DIV2, 16, 0, 0),
+=09F(50000000, P_GPLL0, 16, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0200c,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup1_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x03000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup2_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x04000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup3_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x05000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup4_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup1_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0c00c,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup1_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup2_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0d000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup2_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup3_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0f000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup3_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup4_i2c_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x18000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_blsp_i2c_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup4_i2c_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_blsp_spi_apps_clk_src[] =3D {
+=09F(960000, P_XO, 10, 1, 2),
+=09F(4800000, P_XO, 4, 0, 0),
+=09F(9600000, P_XO, 2, 0, 0),
+=09F(12500000, P_GPLL0_DIV2, 16, 1, 2),
+=09F(16000000, P_GPLL0, 10, 1, 5),
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(25000000, P_GPLL0, 16, 1, 2),
+=09F(50000000, P_GPLL0, 16, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x02024,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup1_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x03014,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup2_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x04024,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup3_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x05024,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_qup4_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup1_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0c024,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup1_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup2_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0d014,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup2_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup3_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0f024,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup3_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_qup4_spi_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x18024,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_blsp_spi_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_qup4_spi_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_blsp_uart_apps_clk_src[] =3D {
+=09F(3686400, P_GPLL0_DIV2, 1, 144, 15625),
+=09F(7372800, P_GPLL0_DIV2, 1, 288, 15625),
+=09F(14745600, P_GPLL0_DIV2, 1, 576, 15625),
+=09F(16000000, P_GPLL0_DIV2, 5, 1, 5),
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(24000000, P_GPLL0, 1, 3, 100),
+=09F(25000000, P_GPLL0, 16, 1, 2),
+=09F(32000000, P_GPLL0, 1, 1, 25),
+=09F(40000000, P_GPLL0, 1, 1, 20),
+=09F(46400000, P_GPLL0, 1, 29, 500),
+=09F(48000000, P_GPLL0, 1, 3, 50),
+=09F(51200000, P_GPLL0, 1, 8, 125),
+=09F(56000000, P_GPLL0, 1, 7, 100),
+=09F(58982400, P_GPLL0, 1, 1152, 15625),
+=09F(60000000, P_GPLL0, 1, 3, 40),
+=09F(64000000, P_GPLL0, 1, 2, 25),
+=09{ }
+};
+
+static struct clk_rcg2 blsp1_uart1_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x02044,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 16,
+=09.freq_tbl =3D ftbl_blsp_uart_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_4_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_uart1_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp1_uart2_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x03034,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 16,
+=09.freq_tbl =3D ftbl_blsp_uart_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_4_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp1_uart2_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_uart1_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0c044,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 16,
+=09.freq_tbl =3D ftbl_blsp_uart_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_4_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_uart1_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 blsp2_uart2_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x0d034,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 16,
+=09.freq_tbl =3D ftbl_blsp_uart_apps_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_4_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "blsp2_uart2_apps_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_byte0_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_DSI0PLL_BYTE, 1 },
+=09{ P_DSI1PLL_BYTE, 3 },
+};
+
+static const struct parent_map gcc_byte1_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_DSI0PLL_BYTE, 3 },
+=09{ P_DSI1PLL_BYTE, 1 },
+};
+
+static const struct clk_parent_data gcc_byte_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .fw_name =3D "dsi0pllbyte", .name =3D "dsi0pllbyte" },
+=09{ .fw_name =3D "dsi1pllbyte", .name =3D "dsi1pllbyte" },
+};
+
+static struct clk_rcg2 byte0_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d044,
+=09.hid_width =3D 5,
+=09.parent_map =3D gcc_byte0_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "byte0_clk_src",
+=09=09.parent_data =3D gcc_byte_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_byte_data),
+=09=09.ops =3D &clk_byte2_ops,
+=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09}
+};
+
+static struct clk_rcg2 byte1_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d0b0,
+=09.hid_width =3D 5,
+=09.parent_map =3D gcc_byte1_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "byte1_clk_src",
+=09=09.parent_data =3D gcc_byte_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_byte_data),
+=09=09.ops =3D &clk_byte2_ops,
+=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09}
+};
+
+static const struct parent_map gcc_gp_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 2 },
+=09{ P_GPLL0_DIV2, 4 },
+=09{ P_SLEEP_CLK, 6 },
+};
+
+static const struct clk_parent_data gcc_gp_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+=09{ .fw_name =3D "sleep", .name =3D "sleep" },
+};
+
+static const struct freq_tbl ftbl_camss_gp_clk_src[] =3D {
+=09F(50000000, P_GPLL0_DIV2, 8, 0, 0),
+=09F(100000000, P_GPLL0, 8, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(266670000, P_GPLL0, 3, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 camss_gp0_clk_src =3D {
+=09.cmd_rcgr =3D 0x54000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_camss_gp_clk_src,
+=09.parent_map =3D gcc_gp_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "camss_gp0_clk_src",
+=09=09.parent_data =3D gcc_gp_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_gp_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 camss_gp1_clk_src =3D {
+=09.cmd_rcgr =3D 0x55000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_camss_gp_clk_src,
+=09.parent_map =3D gcc_gp_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "camss_gp1_clk_src",
+=09=09.parent_data =3D gcc_gp_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_gp_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_camss_top_ahb_clk_src[] =3D {
+=09F(40000000, P_GPLL0_DIV2, 10, 0, 0),
+=09F(80000000, P_GPLL0, 10, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 camss_top_ahb_clk_src =3D {
+=09.cmd_rcgr =3D 0x5a000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_camss_top_ahb_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "camss_top_ahb_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_cci_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 2 },
+=09{ P_GPLL0_DIV2, 3 },
+=09{ P_SLEEP_CLK, 6 },
+};
+
+static const struct clk_parent_data gcc_cci_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+=09{ .fw_name =3D "sleep", .name =3D "sleep" },
+};
+
+static const struct freq_tbl ftbl_cci_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(37500000, P_GPLL0_DIV2, 1, 3, 32),
+=09{ }
+};
+
+static struct clk_rcg2 cci_clk_src =3D {
+=09.cmd_rcgr =3D 0x51000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_cci_clk_src,
+=09.parent_map =3D gcc_cci_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "cci_clk_src",
+=09=09.parent_data =3D gcc_cci_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_cci_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_cpp_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 3 },
+=09{ P_GPLL2, 4 },
+=09{ P_GPLL0_DIV2, 5 },
+};
+
+static const struct clk_parent_data gcc_cpp_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll2.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_cpp_clk_src[] =3D {
+=09F(100000000, P_GPLL0_DIV2, 4, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(266670000, P_GPLL0, 3, 0, 0),
+=09F(320000000, P_GPLL0, 2.5, 0, 0),
+=09F(400000000, P_GPLL0, 2, 0, 0),
+=09F(465000000, P_GPLL2, 2, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 cpp_clk_src =3D {
+=09.cmd_rcgr =3D 0x58018,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_cpp_clk_src,
+=09.parent_map =3D gcc_cpp_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "cpp_clk_src",
+=09=09.parent_data =3D gcc_cpp_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_cpp_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_crypto_clk_src[] =3D {
+=09F(40000000, P_GPLL0_DIV2, 10, 0, 0),
+=09F(80000000, P_GPLL0, 10, 0, 0),
+=09F(100000000, P_GPLL0, 8, 0, 0),
+=09F(160000000, P_GPLL0, 5, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 crypto_clk_src =3D {
+=09.cmd_rcgr =3D 0x16004,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_crypto_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_4_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "crypto_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_csi0_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL2, 4 },
+=09{ P_GPLL0_DIV2, 5 },
+};
+
+static const struct parent_map gcc_csi12_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL2, 5 },
+=09{ P_GPLL0_DIV2, 4 },
+};
+
+static const struct clk_parent_data gcc_csi_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll2.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_csi_clk_src[] =3D {
+=09F(100000000, P_GPLL0_DIV2, 4, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(310000000, P_GPLL2, 3, 0, 0),
+=09F(400000000, P_GPLL0, 2, 0, 0),
+=09F(465000000, P_GPLL2, 2, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 csi0_clk_src =3D {
+=09.cmd_rcgr =3D 0x4e020,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_clk_src,
+=09.parent_map =3D gcc_csi0_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi0_clk_src",
+=09=09.parent_data =3D gcc_csi_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_csi_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 csi1_clk_src =3D {
+=09.cmd_rcgr =3D 0x4f020,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_clk_src,
+=09.parent_map =3D gcc_csi12_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi1_clk_src",
+=09=09.parent_data =3D gcc_csi_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_csi_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 csi2_clk_src =3D {
+=09.cmd_rcgr =3D 0x3c020,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_clk_src,
+=09.parent_map =3D gcc_csi12_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi2_clk_src",
+=09=09.parent_data =3D gcc_csi_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_csi_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_csip_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL4, 3 },
+=09{ P_GPLL2, 4 },
+=09{ P_GPLL0_DIV2, 5 },
+};
+
+static const struct clk_parent_data gcc_csip_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll4.clkr.hw },
+=09{ .hw =3D &gpll2.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_csi_p_clk_src[] =3D {
+=09F(66670000, P_GPLL0_DIV2, 6, 0, 0),
+=09F(133330000, P_GPLL0, 6, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(266670000, P_GPLL0, 3, 0, 0),
+=09F(310000000, P_GPLL2, 3, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 csi0p_clk_src =3D {
+=09.cmd_rcgr =3D 0x58084,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_p_clk_src,
+=09.parent_map =3D gcc_csip_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi0p_clk_src",
+=09=09.parent_data =3D gcc_csip_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_csip_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 csi1p_clk_src =3D {
+=09.cmd_rcgr =3D 0x58094,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_p_clk_src,
+=09.parent_map =3D gcc_csip_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi1p_clk_src",
+=09=09.parent_data =3D gcc_csip_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_csip_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 csi2p_clk_src =3D {
+=09.cmd_rcgr =3D 0x580a4,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_p_clk_src,
+=09.parent_map =3D gcc_csip_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi2p_clk_src",
+=09=09.parent_data =3D gcc_csip_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_csip_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_csi_phytimer_clk_src[] =3D {
+=09F(100000000, P_GPLL0_DIV2, 4, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(266670000, P_GPLL0, 3, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 csi0phytimer_clk_src =3D {
+=09.cmd_rcgr =3D 0x4e000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_phytimer_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi0phytimer_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 csi1phytimer_clk_src =3D {
+=09.cmd_rcgr =3D 0x4f000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_phytimer_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi1phytimer_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 csi2phytimer_clk_src =3D {
+=09.cmd_rcgr =3D 0x4f05c,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_csi_phytimer_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "csi2phytimer_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_esc_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 3 },
+};
+
+static const struct clk_parent_data gcc_esc_vsync_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_esc0_1_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 esc0_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d05c,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_esc0_1_clk_src,
+=09.parent_map =3D gcc_esc_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "esc0_clk_src",
+=09=09.parent_data =3D gcc_esc_vsync_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_esc_vsync_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 esc1_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d0a8,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_esc0_1_clk_src,
+=09.parent_map =3D gcc_esc_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "esc1_clk_src",
+=09=09.parent_data =3D gcc_esc_vsync_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_esc_vsync_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_gfx3d_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL3, 2 },
+=09{ P_GPLL6, 3 },
+=09{ P_GPLL4, 4 },
+=09{ P_GPLL0_DIV2, 5 },
+=09{ P_GPLL6_DIV2, 6 },
+};
+
+static const struct clk_parent_data gcc_gfx3d_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll3.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll4.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+=09{ .hw =3D &gpll6_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_gfx3d_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(50000000, P_GPLL0_DIV2, 8, 0, 0),
+=09F(80000000, P_GPLL0_DIV2, 5, 0, 0),
+=09F(100000000, P_GPLL0_DIV2, 4, 0, 0),
+=09F(133330000, P_GPLL0_DIV2, 3, 0, 0),
+=09F(160000000, P_GPLL0_DIV2, 2.5, 0, 0),
+=09F(200000000, P_GPLL0_DIV2, 2, 0, 0),
+=09F(266670000, P_GPLL0, 3.0, 0, 0),
+=09F(320000000, P_GPLL0, 2.5, 0, 0),
+=09F(400000000, P_GPLL0, 2, 0, 0),
+=09F(460800000, P_GPLL4, 2.5, 0, 0),
+=09F(510000000, P_GPLL3, 2, 0, 0),
+=09F(560000000, P_GPLL3, 2, 0, 0),
+=09F(600000000, P_GPLL3, 2, 0, 0),
+=09F(650000000, P_GPLL3, 2, 0, 0),
+=09F(685000000, P_GPLL3, 2, 0, 0),
+=09F(725000000, P_GPLL3, 2, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 gfx3d_clk_src =3D {
+=09.cmd_rcgr =3D 0x59000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_gfx3d_clk_src,
+=09.parent_map =3D gcc_gfx3d_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "gfx3d_clk_src",
+=09=09.parent_data =3D gcc_gfx3d_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_gfx3d_data),
+=09=09.ops =3D &clk_rcg2_floor_ops,
+=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09}
+};
+
+static const struct freq_tbl ftbl_gp_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 gp1_clk_src =3D {
+=09.cmd_rcgr =3D 0x08004,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_gp_clk_src,
+=09.parent_map =3D gcc_gp_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "gp1_clk_src",
+=09=09.parent_data =3D gcc_gp_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_gp_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 gp2_clk_src =3D {
+=09.cmd_rcgr =3D 0x09004,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_gp_clk_src,
+=09.parent_map =3D gcc_gp_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "gp2_clk_src",
+=09=09.parent_data =3D gcc_gp_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_gp_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 gp3_clk_src =3D {
+=09.cmd_rcgr =3D 0x0a004,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_gp_clk_src,
+=09.parent_map =3D gcc_gp_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "gp3_clk_src",
+=09=09.parent_data =3D gcc_gp_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_gp_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_jpeg0_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 2 },
+=09{ P_GPLL0_DIV2, 4 },
+=09{ P_GPLL2, 5 },
+};
+
+static const struct clk_parent_data gcc_jpeg0_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+=09{ .hw =3D &gpll2.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_jpeg0_clk_src[] =3D {
+=09F(66670000, P_GPLL0_DIV2, 6, 0, 0),
+=09F(133330000, P_GPLL0, 6, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(266670000, P_GPLL0, 3, 0, 0),
+=09F(310000000, P_GPLL2, 3, 0, 0),
+=09F(320000000, P_GPLL0, 2.5, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 jpeg0_clk_src =3D {
+=09.cmd_rcgr =3D 0x57000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_jpeg0_clk_src,
+=09.parent_map =3D gcc_jpeg0_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "jpeg0_clk_src",
+=09=09.parent_data =3D gcc_jpeg0_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_jpeg0_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_mclk_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 2 },
+=09{ P_GPLL0_DIV2, 4 },
+=09{ P_GPLL6_DIV2, 5 },
+=09{ P_SLEEP_CLK, 6 },
+};
+
+static const struct clk_parent_data gcc_mclk_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+=09{ .hw =3D &gpll6_early_div.hw },
+=09{ .fw_name =3D "sleep", .name =3D "sleep" },
+};
+
+static const struct freq_tbl ftbl_mclk_clk_src[] =3D {
+=09F(19200000, P_GPLL6, 5, 4, 45),
+=09F(24000000, P_GPLL6_DIV2, 1, 2, 45),
+=09F(26000000, P_GPLL0, 1, 4, 123),
+=09F(33330000, P_GPLL0_DIV2, 12, 0, 0),
+=09F(36610000, P_GPLL6, 1, 2, 59),
+=09F(66667000, P_GPLL0, 12, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 mclk0_clk_src =3D {
+=09.cmd_rcgr =3D 0x52000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_mclk_clk_src,
+=09.parent_map =3D gcc_mclk_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "mclk0_clk_src",
+=09=09.parent_data =3D gcc_mclk_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_mclk_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 mclk1_clk_src =3D {
+=09.cmd_rcgr =3D 0x53000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_mclk_clk_src,
+=09.parent_map =3D gcc_mclk_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "mclk1_clk_src",
+=09=09.parent_data =3D gcc_mclk_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_mclk_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 mclk2_clk_src =3D {
+=09.cmd_rcgr =3D 0x5c000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_mclk_clk_src,
+=09.parent_map =3D gcc_mclk_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "mclk2_clk_src",
+=09=09.parent_data =3D gcc_mclk_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_mclk_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 mclk3_clk_src =3D {
+=09.cmd_rcgr =3D 0x5e000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_mclk_clk_src,
+=09.parent_map =3D gcc_mclk_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "mclk3_clk_src",
+=09=09.parent_data =3D gcc_mclk_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_mclk_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_mdp_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 3 },
+=09{ P_GPLL0_DIV2, 4 },
+};
+
+static const struct clk_parent_data gcc_mdp_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_mdp_clk_src[] =3D {
+=09F(50000000, P_GPLL0_DIV2, 8, 0, 0),
+=09F(80000000, P_GPLL0_DIV2, 5, 0, 0),
+=09F(160000000, P_GPLL0_DIV2, 2.5, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(266670000, P_GPLL0, 3, 0, 0),
+=09F(320000000, P_GPLL0, 2.5, 0, 0),
+=09F(400000000, P_GPLL0, 2, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 mdp_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d014,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_mdp_clk_src,
+=09.parent_map =3D gcc_mdp_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "mdp_clk_src",
+=09=09.parent_data =3D gcc_mdp_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_mdp_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_pclk0_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_DSI0PLL, 1 },
+=09{ P_DSI1PLL, 3 },
+};
+
+static const struct parent_map gcc_pclk1_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_DSI0PLL, 3 },
+=09{ P_DSI1PLL, 1 },
+};
+
+static const struct clk_parent_data gcc_pclk_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .fw_name =3D "dsi0pll", .name =3D "dsi0pll" },
+=09{ .fw_name =3D "dsi1pll", .name =3D "dsi1pll" },
+};
+
+static struct clk_rcg2 pclk0_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d000,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.parent_map =3D gcc_pclk0_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "pclk0_clk_src",
+=09=09.parent_data =3D gcc_pclk_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_pclk_data),
+=09=09.ops =3D &clk_pixel_ops,
+=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09}
+};
+
+static struct clk_rcg2 pclk1_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d0b8,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.parent_map =3D gcc_pclk1_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "pclk1_clk_src",
+=09=09.parent_data =3D gcc_pclk_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_pclk_data),
+=09=09.ops =3D &clk_pixel_ops,
+=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09}
+};
+
+static const struct freq_tbl ftbl_pdm2_clk_src[] =3D {
+=09F(32000000, P_GPLL0_DIV2, 12.5, 0, 0),
+=09F(64000000, P_GPLL0, 12.5, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 pdm2_clk_src =3D {
+=09.cmd_rcgr =3D 0x44010,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_pdm2_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "pdm2_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_rbcpr_gfx_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(50000000, P_GPLL0, 16, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 rbcpr_gfx_clk_src =3D {
+=09.cmd_rcgr =3D 0x3a00c,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_rbcpr_gfx_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_4_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "rbcpr_gfx_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_sdcc1_ice_core_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 2 },
+=09{ P_GPLL0_DIV2, 4 },
+};
+
+static const struct clk_parent_data gcc_sdcc1_ice_core_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_sdcc1_ice_core_clk_src[] =3D {
+=09F(80000000, P_GPLL0_DIV2, 5, 0, 0),
+=09F(160000000, P_GPLL0, 5, 0, 0),
+=09F(270000000, P_GPLL6, 4, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 sdcc1_ice_core_clk_src =3D {
+=09.cmd_rcgr =3D 0x5d000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_sdcc1_ice_core_clk_src,
+=09.parent_map =3D gcc_sdcc1_ice_core_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "sdcc1_ice_core_clk_src",
+=09=09.parent_data =3D gcc_sdcc1_ice_core_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_sdcc1_ice_core_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_sdcc_apps_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL4, 2 },
+=09{ P_GPLL0_DIV2, 4 },
+};
+
+static const struct clk_parent_data gcc_sdcc_apss_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll4.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] =3D {
+=09F(144000, P_XO, 16, 3, 25),
+=09F(400000, P_XO, 12, 1, 4),
+=09F(20000000, P_GPLL0_DIV2, 5, 1, 4),
+=09F(25000000, P_GPLL0_DIV2, 16, 0, 0),
+=09F(50000000, P_GPLL0, 16, 0, 0),
+=09F(100000000, P_GPLL0, 8, 0, 0),
+=09F(177770000, P_GPLL0, 4.5, 0, 0),
+=09F(192000000, P_GPLL4, 6, 0, 0),
+=09F(384000000, P_GPLL4, 3, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 sdcc1_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x42004,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_sdcc1_apps_clk_src,
+=09.parent_map =3D gcc_sdcc_apps_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "sdcc1_apps_clk_src",
+=09=09.parent_data =3D gcc_sdcc_apss_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_sdcc_apss_data),
+=09=09.ops =3D &clk_rcg2_floor_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_sdcc2_apps_clk_src[] =3D {
+=09F(144000, P_XO, 16, 3, 25),
+=09F(400000, P_XO, 12, 1, 4),
+=09F(20000000, P_GPLL0_DIV2, 5, 1, 4),
+=09F(25000000, P_GPLL0_DIV2, 16, 0, 0),
+=09F(50000000, P_GPLL0, 16, 0, 0),
+=09F(100000000, P_GPLL0, 8, 0, 0),
+=09F(177770000, P_GPLL0, 4.5, 0, 0),
+=09F(192000000, P_GPLL4, 6, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 sdcc2_apps_clk_src =3D {
+=09.cmd_rcgr =3D 0x43004,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_sdcc2_apps_clk_src,
+=09.parent_map =3D gcc_sdcc_apps_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "sdcc2_apps_clk_src",
+=09=09.parent_data =3D gcc_sdcc_apss_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_sdcc_apss_data),
+=09=09.ops =3D &clk_rcg2_floor_ops,
+=09}
+};
+
+static const struct freq_tbl ftbl_usb30_master_clk_src[] =3D {
+=09F(80000000, P_GPLL0_DIV2, 5, 0, 0),
+=09F(100000000, P_GPLL0, 8, 0, 0),
+=09F(133330000, P_GPLL0, 6, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 usb30_master_clk_src =3D {
+=09.cmd_rcgr =3D 0x3f00c,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_usb30_master_clk_src,
+=09.parent_map =3D gcc_xo_gpll0_gpll0div2_2_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "usb30_master_clk_src",
+=09=09.parent_data =3D gcc_xo_gpll0_gpll0div2_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_xo_gpll0_gpll0div2_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_usb30_mock_utmi_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL6, 1 },
+=09{ P_GPLL6_DIV2, 2 },
+=09{ P_GPLL0, 3 },
+=09{ P_GPLL0_DIV2, 4 },
+};
+
+static const struct clk_parent_data gcc_usb30_mock_utmi_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll6_early_div.hw },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_usb30_mock_utmi_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09F(60000000, P_GPLL6_DIV2, 9, 1, 1),
+=09{ }
+};
+
+static struct clk_rcg2 usb30_mock_utmi_clk_src =3D {
+=09.cmd_rcgr =3D 0x3f020,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_usb30_mock_utmi_clk_src,
+=09.parent_map =3D gcc_usb30_mock_utmi_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "usb30_mock_utmi_clk_src",
+=09=09.parent_data =3D gcc_usb30_mock_utmi_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_usb30_mock_utmi_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_usb3_aux_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_SLEEP_CLK, 6 },
+};
+
+static const struct clk_parent_data gcc_usb3_aux_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .fw_name =3D "sleep", .name =3D "sleep" },
+};
+
+static const struct freq_tbl ftbl_usb3_aux_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 usb3_aux_clk_src =3D {
+=09.cmd_rcgr =3D 0x3f05c,
+=09.hid_width =3D 5,
+=09.mnd_width =3D 8,
+=09.freq_tbl =3D ftbl_usb3_aux_clk_src,
+=09.parent_map =3D gcc_usb3_aux_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "usb3_aux_clk_src",
+=09=09.parent_data =3D gcc_usb3_aux_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_usb3_aux_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_vcodec0_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 2 },
+=09{ P_GPLL2, 3 },
+=09{ P_GPLL0_DIV2, 4 },
+};
+
+static const struct clk_parent_data gcc_vcodec0_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll2.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_vcodec0_clk_src[] =3D {
+=09F(114290000, P_GPLL0_DIV2, 3.5, 0, 0),
+=09F(228570000, P_GPLL0, 3.5, 0, 0),
+=09F(310000000, P_GPLL2, 3, 0, 0),
+=09F(360000000, P_GPLL6, 3, 0, 0),
+=09F(400000000, P_GPLL0, 2, 0, 0),
+=09F(465000000, P_GPLL2, 2, 0, 0),
+=09F(540000000, P_GPLL6, 2, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 vcodec0_clk_src =3D {
+=09.cmd_rcgr =3D 0x4c000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_vcodec0_clk_src,
+=09.parent_map =3D gcc_vcodec0_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "vcodec0_clk_src",
+=09=09.parent_data =3D gcc_vcodec0_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_vcodec0_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_vfe_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 1 },
+=09{ P_GPLL6, 2 },
+=09{ P_GPLL4, 3 },
+=09{ P_GPLL2, 4 },
+=09{ P_GPLL0_DIV2, 5 },
+};
+
+static const struct clk_parent_data gcc_vfe_data[] =3D {
+=09{ .fw_name =3D "xo" },
+=09{ .hw =3D &gpll0.clkr.hw },
+=09{ .hw =3D &gpll6.clkr.hw },
+=09{ .hw =3D &gpll4.clkr.hw },
+=09{ .hw =3D &gpll2.clkr.hw },
+=09{ .hw =3D &gpll0_early_div.hw },
+};
+
+static const struct freq_tbl ftbl_vfe_clk_src[] =3D {
+=09F(50000000, P_GPLL0_DIV2, 8, 0, 0),
+=09F(100000000, P_GPLL0_DIV2, 4, 0, 0),
+=09F(133330000, P_GPLL0, 6, 0, 0),
+=09F(160000000, P_GPLL0, 5, 0, 0),
+=09F(200000000, P_GPLL0, 4, 0, 0),
+=09F(266670000, P_GPLL0, 3, 0, 0),
+=09F(310000000, P_GPLL2, 3, 0, 0),
+=09F(400000000, P_GPLL0, 2, 0, 0),
+=09F(465000000, P_GPLL2, 2, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 vfe0_clk_src =3D {
+=09.cmd_rcgr =3D 0x58000,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_vfe_clk_src,
+=09.parent_map =3D gcc_vfe_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "vfe0_clk_src",
+=09=09.parent_data =3D gcc_vfe_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_vfe_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_rcg2 vfe1_clk_src =3D {
+=09.cmd_rcgr =3D 0x58054,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_vfe_clk_src,
+=09.parent_map =3D gcc_vfe_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "vfe1_clk_src",
+=09=09.parent_data =3D gcc_vfe_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_vfe_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static const struct parent_map gcc_vsync_map[] =3D {
+=09{ P_XO, 0 },
+=09{ P_GPLL0, 2 },
+};
+
+static const struct freq_tbl ftbl_vsync_clk_src[] =3D {
+=09F(19200000, P_XO, 1, 0, 0),
+=09{ }
+};
+
+static struct clk_rcg2 vsync_clk_src =3D {
+=09.cmd_rcgr =3D 0x4d02c,
+=09.hid_width =3D 5,
+=09.freq_tbl =3D ftbl_vsync_clk_src,
+=09.parent_map =3D gcc_vsync_map,
+=09.clkr.hw.init =3D &(struct clk_init_data) {
+=09=09.name =3D "vsync_clk_src",
+=09=09.parent_data =3D gcc_esc_vsync_data,
+=09=09.num_parents =3D ARRAY_SIZE(gcc_esc_vsync_data),
+=09=09.ops =3D &clk_rcg2_ops,
+=09}
+};
+
+static struct clk_branch gcc_apc0_droop_detector_gpll0_clk =3D {
+=09.halt_reg =3D 0x78004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x78004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_apc0_droop_detector_gpll0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&apc0_droop_detector_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_apc1_droop_detector_gpll0_clk =3D {
+=09.halt_reg =3D 0x79004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x79004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_apc1_droop_detector_gpll0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&apc1_droop_detector_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_apss_ahb_clk =3D {
+=09.halt_reg =3D 0x4601c,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(14),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_apss_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&apss_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_apss_axi_clk =3D {
+=09.halt_reg =3D 0x46020,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(13),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_apss_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_apss_tcu_async_clk =3D {
+=09.halt_reg =3D 0x12018,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(1),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_apss_tcu_async_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_bimc_gfx_clk =3D {
+=09.halt_reg =3D 0x59034,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x59034,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_bimc_gfx_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_bimc_gpu_clk =3D {
+=09.halt_reg =3D 0x59030,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x59030,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_bimc_gpu_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_ahb_clk =3D {
+=09.halt_reg =3D 0x01008,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(10),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_ahb_clk =3D {
+=09.halt_reg =3D 0x0b008,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(20),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x02008,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x02008,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup1_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup1_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x03010,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x03010,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup2_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup2_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup3_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x04020,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x04020,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup3_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup3_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup4_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x05020,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x05020,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup4_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup4_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup1_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x0c008,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0c008,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup1_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup1_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup2_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x0d010,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0d010,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup2_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup2_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup3_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x0f020,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0f020,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup3_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup3_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup4_i2c_apps_clk =3D {
+=09.halt_reg =3D 0x18020,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x18020,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup4_i2c_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup4_i2c_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup1_spi_apps_clk =3D {
+=09.halt_reg =3D 0x02004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x02004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup1_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup1_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup2_spi_apps_clk =3D {
+=09.halt_reg =3D 0x0300c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0300c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup2_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup2_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup3_spi_apps_clk =3D {
+=09.halt_reg =3D 0x0401c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0401c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup3_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup3_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_qup4_spi_apps_clk =3D {
+=09.halt_reg =3D 0x0501c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0501c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_qup4_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_qup4_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup1_spi_apps_clk =3D {
+=09.halt_reg =3D 0x0c004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0c004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup1_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup1_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup2_spi_apps_clk =3D {
+=09.halt_reg =3D 0x0d00c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0d00c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup2_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup2_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup3_spi_apps_clk =3D {
+=09.halt_reg =3D 0x0f01c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0f01c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup3_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup3_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_qup4_spi_apps_clk =3D {
+=09.halt_reg =3D 0x1801c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x1801c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_qup4_spi_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_qup4_spi_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_uart1_apps_clk =3D {
+=09.halt_reg =3D 0x0203c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0203c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_uart1_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_uart1_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp1_uart2_apps_clk =3D {
+=09.halt_reg =3D 0x0302c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0302c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp1_uart2_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp1_uart2_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_uart1_apps_clk =3D {
+=09.halt_reg =3D 0x0c03c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0c03c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_uart1_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_uart1_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_blsp2_uart2_apps_clk =3D {
+=09.halt_reg =3D 0x0d02c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0d02c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_blsp2_uart2_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&blsp2_uart2_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_boot_rom_ahb_clk =3D {
+=09.halt_reg =3D 0x1300c,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(7),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_boot_rom_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_ahb_clk =3D {
+=09.halt_reg =3D 0x56004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x56004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_cci_ahb_clk =3D {
+=09.halt_reg =3D 0x5101c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5101c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_cci_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_cci_clk =3D {
+=09.halt_reg =3D 0x51018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x51018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_cci_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&cci_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_cpp_ahb_clk =3D {
+=09.halt_reg =3D 0x58040,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58040,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_cpp_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_cpp_axi_clk =3D {
+=09.halt_reg =3D 0x58064,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58064,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_cpp_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_cpp_clk =3D {
+=09.halt_reg =3D 0x5803c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5803c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_cpp_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&cpp_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi0_ahb_clk =3D {
+=09.halt_reg =3D 0x4e040,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4e040,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi0_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi1_ahb_clk =3D {
+=09.halt_reg =3D 0x4f040,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4f040,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi1_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi2_ahb_clk =3D {
+=09.halt_reg =3D 0x3c040,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3c040,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi2_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi0_clk =3D {
+=09.halt_reg =3D 0x4e03c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4e03c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi1_clk =3D {
+=09.halt_reg =3D 0x4f03c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4f03c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi2_clk =3D {
+=09.halt_reg =3D 0x3c03c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3c03c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi2_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi2_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi0_csiphy_3p_clk =3D {
+=09.halt_reg =3D 0x58090,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58090,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi0_csiphy_3p_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi0p_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi1_csiphy_3p_clk =3D {
+=09.halt_reg =3D 0x580a0,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x580a0,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi1_csiphy_3p_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi1p_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi2_csiphy_3p_clk =3D {
+=09.halt_reg =3D 0x580b0,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x580b0,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi2_csiphy_3p_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi2p_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi0phy_clk =3D {
+=09.halt_reg =3D 0x4e048,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4e048,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi0phy_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi1phy_clk =3D {
+=09.halt_reg =3D 0x4f048,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4f048,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi1phy_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi2phy_clk =3D {
+=09.halt_reg =3D 0x3c048,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3c048,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi2phy_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi2_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi0phytimer_clk =3D {
+=09.halt_reg =3D 0x4e01c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4e01c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi0phytimer_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi0phytimer_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi1phytimer_clk =3D {
+=09.halt_reg =3D 0x4f01c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4f01c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi1phytimer_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi1phytimer_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi2phytimer_clk =3D {
+=09.halt_reg =3D 0x4f068,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4f068,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi2phytimer_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi2phytimer_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi0pix_clk =3D {
+=09.halt_reg =3D 0x4e058,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4e058,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi0pix_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi1pix_clk =3D {
+=09.halt_reg =3D 0x4f058,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4f058,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi1pix_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi2pix_clk =3D {
+=09.halt_reg =3D 0x3c058,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3c058,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi2pix_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi2_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi0rdi_clk =3D {
+=09.halt_reg =3D 0x4e050,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4e050,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi0rdi_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi1rdi_clk =3D {
+=09.halt_reg =3D 0x4f050,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4f050,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi1rdi_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi2rdi_clk =3D {
+=09.halt_reg =3D 0x3c050,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3c050,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi2rdi_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&csi2_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi_vfe0_clk =3D {
+=09.halt_reg =3D 0x58050,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58050,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi_vfe0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&vfe0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_csi_vfe1_clk =3D {
+=09.halt_reg =3D 0x58074,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58074,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_csi_vfe1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&vfe1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_gp0_clk =3D {
+=09.halt_reg =3D 0x54018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x54018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_gp0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_gp0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_gp1_clk =3D {
+=09.halt_reg =3D 0x55018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x55018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_gp1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_gp1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_ispif_ahb_clk =3D {
+=09.halt_reg =3D 0x50004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x50004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_ispif_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_jpeg0_clk =3D {
+=09.halt_reg =3D 0x57020,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x57020,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_jpeg0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&jpeg0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_jpeg_ahb_clk =3D {
+=09.halt_reg =3D 0x57024,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x57024,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_jpeg_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_jpeg_axi_clk =3D {
+=09.halt_reg =3D 0x57028,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x57028,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_jpeg_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_mclk0_clk =3D {
+=09.halt_reg =3D 0x52018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x52018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_mclk0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&mclk0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_mclk1_clk =3D {
+=09.halt_reg =3D 0x53018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x53018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_mclk1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&mclk1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_mclk2_clk =3D {
+=09.halt_reg =3D 0x5c018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5c018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_mclk2_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&mclk2_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_mclk3_clk =3D {
+=09.halt_reg =3D 0x5e018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5e018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_mclk3_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&mclk3_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_micro_ahb_clk =3D {
+=09.halt_reg =3D 0x5600c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5600c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_micro_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_top_ahb_clk =3D {
+=09.halt_reg =3D 0x5a014,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5a014,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_top_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_vfe0_ahb_clk =3D {
+=09.halt_reg =3D 0x58044,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58044,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_vfe0_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_vfe0_axi_clk =3D {
+=09.halt_reg =3D 0x58048,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58048,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_vfe0_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_vfe0_clk =3D {
+=09.halt_reg =3D 0x58038,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58038,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_vfe0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&vfe0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_vfe1_ahb_clk =3D {
+=09.halt_reg =3D 0x58060,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58060,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_vfe1_ahb_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&camss_top_ahb_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_vfe1_axi_clk =3D {
+=09.halt_reg =3D 0x58068,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x58068,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_vfe1_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_camss_vfe1_clk =3D {
+=09.halt_reg =3D 0x5805c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5805c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_camss_vfe1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&vfe1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_cpp_tbu_clk =3D {
+=09.halt_reg =3D 0x12040,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(14),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_cpp_tbu_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_crypto_ahb_clk =3D {
+=09.halt_reg =3D 0x16024,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_crypto_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_crypto_axi_clk =3D {
+=09.halt_reg =3D 0x16020,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(1),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_crypto_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_crypto_clk =3D {
+=09.halt_reg =3D 0x1601c,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(2),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_crypto_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&crypto_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_dcc_clk =3D {
+=09.halt_reg =3D 0x77004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x77004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_dcc_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_gp1_clk =3D {
+=09.halt_reg =3D 0x08000,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x08000,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_gp1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&gp1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_gp2_clk =3D {
+=09.halt_reg =3D 0x09000,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x09000,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_gp2_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&gp2_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_gp3_clk =3D {
+=09.halt_reg =3D 0x0a000,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x0a000,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_gp3_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&gp3_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_jpeg_tbu_clk =3D {
+=09.halt_reg =3D 0x12034,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(10),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_jpeg_tbu_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdp_tbu_clk =3D {
+=09.halt_reg =3D 0x1201c,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(4),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdp_tbu_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_ahb_clk =3D {
+=09.halt_reg =3D 0x4d07c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d07c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_axi_clk =3D {
+=09.halt_reg =3D 0x4d080,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d080,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_byte0_clk =3D {
+=09.halt_reg =3D 0x4d094,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d094,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_byte0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&byte0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_byte1_clk =3D {
+=09.halt_reg =3D 0x4d0a0,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d0a0,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_byte1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&byte1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_esc0_clk =3D {
+=09.halt_reg =3D 0x4d098,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d098,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_esc0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&esc0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_esc1_clk =3D {
+=09.halt_reg =3D 0x4d09c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d09c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_esc1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&esc1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_mdp_clk =3D {
+=09.halt_reg =3D 0x4d088,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d088,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_mdp_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&mdp_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_pclk0_clk =3D {
+=09.halt_reg =3D 0x4d084,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d084,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_pclk0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&pclk0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_pclk1_clk =3D {
+=09.halt_reg =3D 0x4d0a4,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d0a4,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_pclk1_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&pclk1_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mdss_vsync_clk =3D {
+=09.halt_reg =3D 0x4d090,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4d090,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mdss_vsync_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&vsync_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mss_cfg_ahb_clk =3D {
+=09.halt_reg =3D 0x49000,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x49000,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mss_cfg_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_mss_q6_bimc_axi_clk =3D {
+=09.halt_reg =3D 0x49004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x49004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_mss_q6_bimc_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_oxili_ahb_clk =3D {
+=09.halt_reg =3D 0x59028,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x59028,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_oxili_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_oxili_aon_clk =3D {
+=09.halt_reg =3D 0x59044,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x59044,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_oxili_aon_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&gfx3d_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_oxili_gfx3d_clk =3D {
+=09.halt_reg =3D 0x59020,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x59020,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_oxili_gfx3d_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&gfx3d_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_oxili_timer_clk =3D {
+=09.halt_reg =3D 0x59040,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x59040,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_oxili_timer_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_pcnoc_usb3_axi_clk =3D {
+=09.halt_reg =3D 0x3f038,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f038,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_pcnoc_usb3_axi_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&usb30_master_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_pdm2_clk =3D {
+=09.halt_reg =3D 0x4400c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4400c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_pdm2_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&pdm2_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_pdm_ahb_clk =3D {
+=09.halt_reg =3D 0x44004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x44004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_pdm_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_prng_ahb_clk =3D {
+=09.halt_reg =3D 0x13004,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(8),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_prng_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_qdss_dap_clk =3D {
+=09.halt_reg =3D 0x29084,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x45004,
+=09=09.enable_mask =3D BIT(11),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_qdss_dap_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_qusb_ref_clk =3D {
+=09.halt_reg =3D 0,
+=09.halt_check =3D BRANCH_HALT_SKIP,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x41030,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_qusb_ref_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_rbcpr_gfx_clk =3D {
+=09.halt_reg =3D 0x3a004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3a004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_rbcpr_gfx_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&rbcpr_gfx_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_sdcc1_ice_core_clk =3D {
+=09.halt_reg =3D 0x5d014,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x5d014,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_sdcc1_ice_core_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&sdcc1_ice_core_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_sdcc1_ahb_clk =3D {
+=09.halt_reg =3D 0x4201c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4201c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_sdcc1_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_sdcc2_ahb_clk =3D {
+=09.halt_reg =3D 0x4301c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4301c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_sdcc2_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_sdcc1_apps_clk =3D {
+=09.halt_reg =3D 0x42018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x42018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_sdcc1_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&sdcc1_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_sdcc2_apps_clk =3D {
+=09.halt_reg =3D 0x43018,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x43018,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_sdcc2_apps_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&sdcc2_apps_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_smmu_cfg_clk =3D {
+=09.halt_reg =3D 0x12038,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(12),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_smmu_cfg_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_usb30_master_clk =3D {
+=09.halt_reg =3D 0x3f000,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f000,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_usb30_master_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&usb30_master_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_usb30_mock_utmi_clk =3D {
+=09.halt_reg =3D 0x3f008,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f008,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_usb30_mock_utmi_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&usb30_mock_utmi_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_usb30_sleep_clk =3D {
+=09.halt_reg =3D 0x3f004,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f004,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_usb30_sleep_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_usb3_aux_clk =3D {
+=09.halt_reg =3D 0x3f044,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f044,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_usb3_aux_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&usb3_aux_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_usb3_pipe_clk =3D {
+=09.halt_reg =3D 0,
+=09.halt_check =3D BRANCH_HALT_DELAY,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f040,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_usb3_pipe_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_usb_phy_cfg_ahb_clk =3D {
+=09.halt_reg =3D 0x3f080,
+=09.halt_check =3D BRANCH_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f080,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_usb_phy_cfg_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_usb_ss_ref_clk =3D {
+=09.halt_reg =3D 0,
+=09.halt_check =3D BRANCH_HALT_SKIP,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x3f07c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_usb_ss_ref_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_venus0_ahb_clk =3D {
+=09.halt_reg =3D 0x4c020,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4c020,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_venus0_ahb_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_venus0_axi_clk =3D {
+=09.halt_reg =3D 0x4c024,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4c024,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_venus0_axi_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_venus0_core0_vcodec0_clk =3D {
+=09.halt_reg =3D 0x4c02c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4c02c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_venus0_core0_vcodec0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&vcodec0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_venus0_vcodec0_clk =3D {
+=09.halt_reg =3D 0x4c01c,
+=09.halt_check =3D BRANCH_HALT,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4c01c,
+=09=09.enable_mask =3D BIT(0),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_venus0_vcodec0_clk",
+=09=09=09.parent_hws =3D (const struct clk_hw*[]){
+=09=09=09=09&vcodec0_clk_src.clkr.hw,
+=09=09=09},
+=09=09=09.num_parents =3D 1,
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09=09.flags =3D CLK_SET_RATE_PARENT,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_venus_tbu_clk =3D {
+=09.halt_reg =3D 0x12014,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(5),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_venus_tbu_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_vfe1_tbu_clk =3D {
+=09.halt_reg =3D 0x12090,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(17),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_vfe1_tbu_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct clk_branch gcc_vfe_tbu_clk =3D {
+=09.halt_reg =3D 0x1203c,
+=09.halt_check =3D BRANCH_HALT_VOTED,
+=09.clkr =3D {
+=09=09.enable_reg =3D 0x4500c,
+=09=09.enable_mask =3D BIT(9),
+=09=09.hw.init =3D &(struct clk_init_data) {
+=09=09=09.name =3D "gcc_vfe_tbu_clk",
+=09=09=09.ops =3D &clk_branch2_ops,
+=09=09}
+=09}
+};
+
+static struct gdsc usb30_gdsc =3D {
+=09.gdscr =3D 0x3f078,
+=09.pd =3D {
+=09=09.name =3D "usb30_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+=09/*
+=09 * FIXME: dwc3 usb gadget cannot resume after GDSC power off
+=09 * dwc3 7000000.dwc3: failed to enable ep0out
+=09 */
+=09.flags =3D ALWAYS_ON,
+};
+
+static struct gdsc venus_gdsc =3D {
+=09.gdscr =3D 0x4c018,
+=09.cxcs =3D (unsigned int []){ 0x4c024, 0x4c01c },
+=09.cxc_count =3D 2,
+=09.pd =3D {
+=09=09.name =3D "venus_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct gdsc venus_core0_gdsc =3D {
+=09.gdscr =3D 0x4c028,
+=09.cxcs =3D (unsigned int []){ 0x4c02c },
+=09.cxc_count =3D 1,
+=09.pd =3D {
+=09=09.name =3D "venus_core0",
+=09},
+=09.flags =3D HW_CTRL,
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct gdsc mdss_gdsc =3D {
+=09.gdscr =3D 0x4d078,
+=09.cxcs =3D (unsigned int []){ 0x4d080, 0x4d088 },
+=09.cxc_count =3D 2,
+=09.pd =3D {
+=09=09.name =3D "mdss_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct gdsc jpeg_gdsc =3D {
+=09.gdscr =3D 0x5701c,
+=09.cxcs =3D (unsigned int []){ 0x57020, 0x57028 },
+=09.cxc_count =3D 2,
+=09.pd =3D {
+=09=09.name =3D "jpeg_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct gdsc vfe0_gdsc =3D {
+=09.gdscr =3D 0x58034,
+=09.cxcs =3D (unsigned int []){ 0x58038, 0x58048, 0x5600c, 0x58050 },
+=09.cxc_count =3D 4,
+=09.pd =3D {
+=09=09.name =3D "vfe0_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct gdsc vfe1_gdsc =3D {
+=09.gdscr =3D 0x5806c,
+=09.cxcs =3D (unsigned int []){ 0x5805c, 0x58068, 0x5600c, 0x58074 },
+=09.cxc_count =3D 4,
+=09.pd =3D {
+=09=09.name =3D "vfe1_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct gdsc oxili_gx_gdsc =3D {
+=09.gdscr =3D 0x5901c,
+=09.clamp_io_ctrl =3D 0x5b00c,
+=09.cxcs =3D (unsigned int []){ 0x59000, 0x59024 },
+=09.cxc_count =3D 2,
+=09.pd =3D {
+=09=09.name =3D "oxili_gx_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+=09.flags =3D CLAMP_IO,
+};
+
+static struct gdsc oxili_cx_gdsc =3D {
+=09.gdscr =3D 0x5904c,
+=09.cxcs =3D (unsigned int []){ 0x59020 },
+=09.cxc_count =3D 1,
+=09.pd =3D {
+=09=09.name =3D "oxili_cx_gdsc",
+=09},
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct gdsc cpp_gdsc =3D {
+=09.gdscr =3D 0x58078,
+=09.cxcs =3D (unsigned int []){ 0x5803c, 0x58064 },
+=09.cxc_count =3D 2,
+=09.pd =3D {
+=09=09.name =3D "cpp_gdsc",
+=09},
+=09.flags =3D ALWAYS_ON,
+=09.pwrsts =3D PWRSTS_OFF_ON,
+};
+
+static struct clk_hw *gcc_msm8953_hws[] =3D {
+=09&gpll0_early_div.hw,
+=09&gpll6_early_div.hw,
+};
+
+static struct clk_regmap *gcc_msm8953_clocks[] =3D {
+=09[GPLL0] =3D &gpll0.clkr,
+=09[GPLL0_EARLY] =3D &gpll0_early.clkr,
+=09[GPLL2] =3D &gpll2.clkr,
+=09[GPLL2_EARLY] =3D &gpll2_early.clkr,
+=09[GPLL3] =3D &gpll3.clkr,
+=09[GPLL3_EARLY] =3D &gpll3_early.clkr,
+=09[GPLL4] =3D &gpll4.clkr,
+=09[GPLL4_EARLY] =3D &gpll4_early.clkr,
+=09[GPLL6] =3D &gpll6.clkr,
+=09[GPLL6_EARLY] =3D &gpll6_early.clkr,
+=09[GCC_APSS_AHB_CLK] =3D &gcc_apss_ahb_clk.clkr,
+=09[GCC_APSS_AXI_CLK] =3D &gcc_apss_axi_clk.clkr,
+=09[GCC_BLSP1_AHB_CLK] =3D &gcc_blsp1_ahb_clk.clkr,
+=09[GCC_BLSP2_AHB_CLK] =3D &gcc_blsp2_ahb_clk.clkr,
+=09[GCC_BOOT_ROM_AHB_CLK] =3D &gcc_boot_rom_ahb_clk.clkr,
+=09[GCC_CRYPTO_AHB_CLK] =3D &gcc_crypto_ahb_clk.clkr,
+=09[GCC_CRYPTO_AXI_CLK] =3D &gcc_crypto_axi_clk.clkr,
+=09[GCC_CRYPTO_CLK] =3D &gcc_crypto_clk.clkr,
+=09[GCC_PRNG_AHB_CLK] =3D &gcc_prng_ahb_clk.clkr,
+=09[GCC_QDSS_DAP_CLK] =3D &gcc_qdss_dap_clk.clkr,
+=09[GCC_APSS_TCU_ASYNC_CLK] =3D &gcc_apss_tcu_async_clk.clkr,
+=09[GCC_CPP_TBU_CLK] =3D &gcc_cpp_tbu_clk.clkr,
+=09[GCC_JPEG_TBU_CLK] =3D &gcc_jpeg_tbu_clk.clkr,
+=09[GCC_MDP_TBU_CLK] =3D &gcc_mdp_tbu_clk.clkr,
+=09[GCC_SMMU_CFG_CLK] =3D &gcc_smmu_cfg_clk.clkr,
+=09[GCC_VENUS_TBU_CLK] =3D &gcc_venus_tbu_clk.clkr,
+=09[GCC_VFE1_TBU_CLK] =3D &gcc_vfe1_tbu_clk.clkr,
+=09[GCC_VFE_TBU_CLK] =3D &gcc_vfe_tbu_clk.clkr,
+=09[CAMSS_TOP_AHB_CLK_SRC] =3D &camss_top_ahb_clk_src.clkr,
+=09[CSI0_CLK_SRC] =3D &csi0_clk_src.clkr,
+=09[APSS_AHB_CLK_SRC] =3D &apss_ahb_clk_src.clkr,
+=09[CSI1_CLK_SRC] =3D &csi1_clk_src.clkr,
+=09[CSI2_CLK_SRC] =3D &csi2_clk_src.clkr,
+=09[VFE0_CLK_SRC] =3D &vfe0_clk_src.clkr,
+=09[VCODEC0_CLK_SRC] =3D &vcodec0_clk_src.clkr,
+=09[CPP_CLK_SRC] =3D &cpp_clk_src.clkr,
+=09[JPEG0_CLK_SRC] =3D &jpeg0_clk_src.clkr,
+=09[USB30_MASTER_CLK_SRC] =3D &usb30_master_clk_src.clkr,
+=09[VFE1_CLK_SRC] =3D &vfe1_clk_src.clkr,
+=09[APC0_DROOP_DETECTOR_CLK_SRC] =3D &apc0_droop_detector_clk_src.clkr,
+=09[APC1_DROOP_DETECTOR_CLK_SRC] =3D &apc1_droop_detector_clk_src.clkr,
+=09[BLSP1_QUP1_I2C_APPS_CLK_SRC] =3D &blsp1_qup1_i2c_apps_clk_src.clkr,
+=09[BLSP1_QUP1_SPI_APPS_CLK_SRC] =3D &blsp1_qup1_spi_apps_clk_src.clkr,
+=09[BLSP1_QUP2_I2C_APPS_CLK_SRC] =3D &blsp1_qup2_i2c_apps_clk_src.clkr,
+=09[BLSP1_QUP2_SPI_APPS_CLK_SRC] =3D &blsp1_qup2_spi_apps_clk_src.clkr,
+=09[BLSP1_QUP3_I2C_APPS_CLK_SRC] =3D &blsp1_qup3_i2c_apps_clk_src.clkr,
+=09[BLSP1_QUP3_SPI_APPS_CLK_SRC] =3D &blsp1_qup3_spi_apps_clk_src.clkr,
+=09[BLSP1_QUP4_I2C_APPS_CLK_SRC] =3D &blsp1_qup4_i2c_apps_clk_src.clkr,
+=09[BLSP1_QUP4_SPI_APPS_CLK_SRC] =3D &blsp1_qup4_spi_apps_clk_src.clkr,
+=09[BLSP1_UART1_APPS_CLK_SRC] =3D &blsp1_uart1_apps_clk_src.clkr,
+=09[BLSP1_UART2_APPS_CLK_SRC] =3D &blsp1_uart2_apps_clk_src.clkr,
+=09[BLSP2_QUP1_I2C_APPS_CLK_SRC] =3D &blsp2_qup1_i2c_apps_clk_src.clkr,
+=09[BLSP2_QUP1_SPI_APPS_CLK_SRC] =3D &blsp2_qup1_spi_apps_clk_src.clkr,
+=09[BLSP2_QUP2_I2C_APPS_CLK_SRC] =3D &blsp2_qup2_i2c_apps_clk_src.clkr,
+=09[BLSP2_QUP2_SPI_APPS_CLK_SRC] =3D &blsp2_qup2_spi_apps_clk_src.clkr,
+=09[BLSP2_QUP3_I2C_APPS_CLK_SRC] =3D &blsp2_qup3_i2c_apps_clk_src.clkr,
+=09[BLSP2_QUP3_SPI_APPS_CLK_SRC] =3D &blsp2_qup3_spi_apps_clk_src.clkr,
+=09[BLSP2_QUP4_I2C_APPS_CLK_SRC] =3D &blsp2_qup4_i2c_apps_clk_src.clkr,
+=09[BLSP2_QUP4_SPI_APPS_CLK_SRC] =3D &blsp2_qup4_spi_apps_clk_src.clkr,
+=09[BLSP2_UART1_APPS_CLK_SRC] =3D &blsp2_uart1_apps_clk_src.clkr,
+=09[BLSP2_UART2_APPS_CLK_SRC] =3D &blsp2_uart2_apps_clk_src.clkr,
+=09[CCI_CLK_SRC] =3D &cci_clk_src.clkr,
+=09[CSI0P_CLK_SRC] =3D &csi0p_clk_src.clkr,
+=09[CSI1P_CLK_SRC] =3D &csi1p_clk_src.clkr,
+=09[CSI2P_CLK_SRC] =3D &csi2p_clk_src.clkr,
+=09[CAMSS_GP0_CLK_SRC] =3D &camss_gp0_clk_src.clkr,
+=09[CAMSS_GP1_CLK_SRC] =3D &camss_gp1_clk_src.clkr,
+=09[MCLK0_CLK_SRC] =3D &mclk0_clk_src.clkr,
+=09[MCLK1_CLK_SRC] =3D &mclk1_clk_src.clkr,
+=09[MCLK2_CLK_SRC] =3D &mclk2_clk_src.clkr,
+=09[MCLK3_CLK_SRC] =3D &mclk3_clk_src.clkr,
+=09[CSI0PHYTIMER_CLK_SRC] =3D &csi0phytimer_clk_src.clkr,
+=09[CSI1PHYTIMER_CLK_SRC] =3D &csi1phytimer_clk_src.clkr,
+=09[CSI2PHYTIMER_CLK_SRC] =3D &csi2phytimer_clk_src.clkr,
+=09[CRYPTO_CLK_SRC] =3D &crypto_clk_src.clkr,
+=09[GP1_CLK_SRC] =3D &gp1_clk_src.clkr,
+=09[GP2_CLK_SRC] =3D &gp2_clk_src.clkr,
+=09[GP3_CLK_SRC] =3D &gp3_clk_src.clkr,
+=09[PDM2_CLK_SRC] =3D &pdm2_clk_src.clkr,
+=09[RBCPR_GFX_CLK_SRC] =3D &rbcpr_gfx_clk_src.clkr,
+=09[SDCC1_APPS_CLK_SRC] =3D &sdcc1_apps_clk_src.clkr,
+=09[SDCC1_ICE_CORE_CLK_SRC] =3D &sdcc1_ice_core_clk_src.clkr,
+=09[SDCC2_APPS_CLK_SRC] =3D &sdcc2_apps_clk_src.clkr,
+=09[USB30_MOCK_UTMI_CLK_SRC] =3D &usb30_mock_utmi_clk_src.clkr,
+=09[USB3_AUX_CLK_SRC] =3D &usb3_aux_clk_src.clkr,
+=09[GCC_APC0_DROOP_DETECTOR_GPLL0_CLK] =3D &gcc_apc0_droop_detector_gpll0_=
clk.clkr,
+=09[GCC_APC1_DROOP_DETECTOR_GPLL0_CLK] =3D &gcc_apc1_droop_detector_gpll0_=
clk.clkr,
+=09[GCC_BLSP1_QUP1_I2C_APPS_CLK] =3D &gcc_blsp1_qup1_i2c_apps_clk.clkr,
+=09[GCC_BLSP1_QUP1_SPI_APPS_CLK] =3D &gcc_blsp1_qup1_spi_apps_clk.clkr,
+=09[GCC_BLSP1_QUP2_I2C_APPS_CLK] =3D &gcc_blsp1_qup2_i2c_apps_clk.clkr,
+=09[GCC_BLSP1_QUP2_SPI_APPS_CLK] =3D &gcc_blsp1_qup2_spi_apps_clk.clkr,
+=09[GCC_BLSP1_QUP3_I2C_APPS_CLK] =3D &gcc_blsp1_qup3_i2c_apps_clk.clkr,
+=09[GCC_BLSP1_QUP3_SPI_APPS_CLK] =3D &gcc_blsp1_qup3_spi_apps_clk.clkr,
+=09[GCC_BLSP1_QUP4_I2C_APPS_CLK] =3D &gcc_blsp1_qup4_i2c_apps_clk.clkr,
+=09[GCC_BLSP1_QUP4_SPI_APPS_CLK] =3D &gcc_blsp1_qup4_spi_apps_clk.clkr,
+=09[GCC_BLSP1_UART1_APPS_CLK] =3D &gcc_blsp1_uart1_apps_clk.clkr,
+=09[GCC_BLSP1_UART2_APPS_CLK] =3D &gcc_blsp1_uart2_apps_clk.clkr,
+=09[GCC_BLSP2_QUP1_I2C_APPS_CLK] =3D &gcc_blsp2_qup1_i2c_apps_clk.clkr,
+=09[GCC_BLSP2_QUP1_SPI_APPS_CLK] =3D &gcc_blsp2_qup1_spi_apps_clk.clkr,
+=09[GCC_BLSP2_QUP2_I2C_APPS_CLK] =3D &gcc_blsp2_qup2_i2c_apps_clk.clkr,
+=09[GCC_BLSP2_QUP2_SPI_APPS_CLK] =3D &gcc_blsp2_qup2_spi_apps_clk.clkr,
+=09[GCC_BLSP2_QUP3_I2C_APPS_CLK] =3D &gcc_blsp2_qup3_i2c_apps_clk.clkr,
+=09[GCC_BLSP2_QUP3_SPI_APPS_CLK] =3D &gcc_blsp2_qup3_spi_apps_clk.clkr,
+=09[GCC_BLSP2_QUP4_I2C_APPS_CLK] =3D &gcc_blsp2_qup4_i2c_apps_clk.clkr,
+=09[GCC_BLSP2_QUP4_SPI_APPS_CLK] =3D &gcc_blsp2_qup4_spi_apps_clk.clkr,
+=09[GCC_BLSP2_UART1_APPS_CLK] =3D &gcc_blsp2_uart1_apps_clk.clkr,
+=09[GCC_BLSP2_UART2_APPS_CLK] =3D &gcc_blsp2_uart2_apps_clk.clkr,
+=09[GCC_CAMSS_CCI_AHB_CLK] =3D &gcc_camss_cci_ahb_clk.clkr,
+=09[GCC_CAMSS_CCI_CLK] =3D &gcc_camss_cci_clk.clkr,
+=09[GCC_CAMSS_CPP_AHB_CLK] =3D &gcc_camss_cpp_ahb_clk.clkr,
+=09[GCC_CAMSS_CPP_AXI_CLK] =3D &gcc_camss_cpp_axi_clk.clkr,
+=09[GCC_CAMSS_CPP_CLK] =3D &gcc_camss_cpp_clk.clkr,
+=09[GCC_CAMSS_CSI0_AHB_CLK] =3D &gcc_camss_csi0_ahb_clk.clkr,
+=09[GCC_CAMSS_CSI0_CLK] =3D &gcc_camss_csi0_clk.clkr,
+=09[GCC_CAMSS_CSI0_CSIPHY_3P_CLK] =3D &gcc_camss_csi0_csiphy_3p_clk.clkr,
+=09[GCC_CAMSS_CSI0PHY_CLK] =3D &gcc_camss_csi0phy_clk.clkr,
+=09[GCC_CAMSS_CSI0PIX_CLK] =3D &gcc_camss_csi0pix_clk.clkr,
+=09[GCC_CAMSS_CSI0RDI_CLK] =3D &gcc_camss_csi0rdi_clk.clkr,
+=09[GCC_CAMSS_CSI1_AHB_CLK] =3D &gcc_camss_csi1_ahb_clk.clkr,
+=09[GCC_CAMSS_CSI1_CLK] =3D &gcc_camss_csi1_clk.clkr,
+=09[GCC_CAMSS_CSI1_CSIPHY_3P_CLK] =3D &gcc_camss_csi1_csiphy_3p_clk.clkr,
+=09[GCC_CAMSS_CSI1PHY_CLK] =3D &gcc_camss_csi1phy_clk.clkr,
+=09[GCC_CAMSS_CSI1PIX_CLK] =3D &gcc_camss_csi1pix_clk.clkr,
+=09[GCC_CAMSS_CSI1RDI_CLK] =3D &gcc_camss_csi1rdi_clk.clkr,
+=09[GCC_CAMSS_CSI2_AHB_CLK] =3D &gcc_camss_csi2_ahb_clk.clkr,
+=09[GCC_CAMSS_CSI2_CLK] =3D &gcc_camss_csi2_clk.clkr,
+=09[GCC_CAMSS_CSI2_CSIPHY_3P_CLK] =3D &gcc_camss_csi2_csiphy_3p_clk.clkr,
+=09[GCC_CAMSS_CSI2PHY_CLK] =3D &gcc_camss_csi2phy_clk.clkr,
+=09[GCC_CAMSS_CSI2PIX_CLK] =3D &gcc_camss_csi2pix_clk.clkr,
+=09[GCC_CAMSS_CSI2RDI_CLK] =3D &gcc_camss_csi2rdi_clk.clkr,
+=09[GCC_CAMSS_CSI_VFE0_CLK] =3D &gcc_camss_csi_vfe0_clk.clkr,
+=09[GCC_CAMSS_CSI_VFE1_CLK] =3D &gcc_camss_csi_vfe1_clk.clkr,
+=09[GCC_CAMSS_GP0_CLK] =3D &gcc_camss_gp0_clk.clkr,
+=09[GCC_CAMSS_GP1_CLK] =3D &gcc_camss_gp1_clk.clkr,
+=09[GCC_CAMSS_ISPIF_AHB_CLK] =3D &gcc_camss_ispif_ahb_clk.clkr,
+=09[GCC_CAMSS_JPEG0_CLK] =3D &gcc_camss_jpeg0_clk.clkr,
+=09[GCC_CAMSS_JPEG_AHB_CLK] =3D &gcc_camss_jpeg_ahb_clk.clkr,
+=09[GCC_CAMSS_JPEG_AXI_CLK] =3D &gcc_camss_jpeg_axi_clk.clkr,
+=09[GCC_CAMSS_MCLK0_CLK] =3D &gcc_camss_mclk0_clk.clkr,
+=09[GCC_CAMSS_MCLK1_CLK] =3D &gcc_camss_mclk1_clk.clkr,
+=09[GCC_CAMSS_MCLK2_CLK] =3D &gcc_camss_mclk2_clk.clkr,
+=09[GCC_CAMSS_MCLK3_CLK] =3D &gcc_camss_mclk3_clk.clkr,
+=09[GCC_CAMSS_MICRO_AHB_CLK] =3D &gcc_camss_micro_ahb_clk.clkr,
+=09[GCC_CAMSS_CSI0PHYTIMER_CLK] =3D &gcc_camss_csi0phytimer_clk.clkr,
+=09[GCC_CAMSS_CSI1PHYTIMER_CLK] =3D &gcc_camss_csi1phytimer_clk.clkr,
+=09[GCC_CAMSS_CSI2PHYTIMER_CLK] =3D &gcc_camss_csi2phytimer_clk.clkr,
+=09[GCC_CAMSS_AHB_CLK] =3D &gcc_camss_ahb_clk.clkr,
+=09[GCC_CAMSS_TOP_AHB_CLK] =3D &gcc_camss_top_ahb_clk.clkr,
+=09[GCC_CAMSS_VFE0_CLK] =3D &gcc_camss_vfe0_clk.clkr,
+=09[GCC_CAMSS_VFE0_AHB_CLK] =3D &gcc_camss_vfe0_ahb_clk.clkr,
+=09[GCC_CAMSS_VFE0_AXI_CLK] =3D &gcc_camss_vfe0_axi_clk.clkr,
+=09[GCC_CAMSS_VFE1_AHB_CLK] =3D &gcc_camss_vfe1_ahb_clk.clkr,
+=09[GCC_CAMSS_VFE1_AXI_CLK] =3D &gcc_camss_vfe1_axi_clk.clkr,
+=09[GCC_CAMSS_VFE1_CLK] =3D &gcc_camss_vfe1_clk.clkr,
+=09[GCC_DCC_CLK] =3D &gcc_dcc_clk.clkr,
+=09[GCC_GP1_CLK] =3D &gcc_gp1_clk.clkr,
+=09[GCC_GP2_CLK] =3D &gcc_gp2_clk.clkr,
+=09[GCC_GP3_CLK] =3D &gcc_gp3_clk.clkr,
+=09[GCC_MSS_CFG_AHB_CLK] =3D &gcc_mss_cfg_ahb_clk.clkr,
+=09[GCC_MSS_Q6_BIMC_AXI_CLK] =3D &gcc_mss_q6_bimc_axi_clk.clkr,
+=09[GCC_PCNOC_USB3_AXI_CLK] =3D &gcc_pcnoc_usb3_axi_clk.clkr,
+=09[GCC_PDM2_CLK] =3D &gcc_pdm2_clk.clkr,
+=09[GCC_PDM_AHB_CLK] =3D &gcc_pdm_ahb_clk.clkr,
+=09[GCC_RBCPR_GFX_CLK] =3D &gcc_rbcpr_gfx_clk.clkr,
+=09[GCC_SDCC1_AHB_CLK] =3D &gcc_sdcc1_ahb_clk.clkr,
+=09[GCC_SDCC1_APPS_CLK] =3D &gcc_sdcc1_apps_clk.clkr,
+=09[GCC_SDCC1_ICE_CORE_CLK] =3D &gcc_sdcc1_ice_core_clk.clkr,
+=09[GCC_SDCC2_AHB_CLK] =3D &gcc_sdcc2_ahb_clk.clkr,
+=09[GCC_SDCC2_APPS_CLK] =3D &gcc_sdcc2_apps_clk.clkr,
+=09[GCC_USB30_MASTER_CLK] =3D &gcc_usb30_master_clk.clkr,
+=09[GCC_USB30_MOCK_UTMI_CLK] =3D &gcc_usb30_mock_utmi_clk.clkr,
+=09[GCC_USB30_SLEEP_CLK] =3D &gcc_usb30_sleep_clk.clkr,
+=09[GCC_USB3_AUX_CLK] =3D &gcc_usb3_aux_clk.clkr,
+=09[GCC_USB_PHY_CFG_AHB_CLK] =3D &gcc_usb_phy_cfg_ahb_clk.clkr,
+=09[GCC_VENUS0_AHB_CLK] =3D &gcc_venus0_ahb_clk.clkr,
+=09[GCC_VENUS0_AXI_CLK] =3D &gcc_venus0_axi_clk.clkr,
+=09[GCC_VENUS0_CORE0_VCODEC0_CLK] =3D &gcc_venus0_core0_vcodec0_clk.clkr,
+=09[GCC_VENUS0_VCODEC0_CLK] =3D &gcc_venus0_vcodec0_clk.clkr,
+=09[GCC_QUSB_REF_CLK] =3D &gcc_qusb_ref_clk.clkr,
+=09[GCC_USB_SS_REF_CLK] =3D &gcc_usb_ss_ref_clk.clkr,
+=09[GCC_USB3_PIPE_CLK] =3D &gcc_usb3_pipe_clk.clkr,
+=09[MDP_CLK_SRC] =3D &mdp_clk_src.clkr,
+=09[PCLK0_CLK_SRC] =3D &pclk0_clk_src.clkr,
+=09[BYTE0_CLK_SRC] =3D &byte0_clk_src.clkr,
+=09[ESC0_CLK_SRC] =3D &esc0_clk_src.clkr,
+=09[PCLK1_CLK_SRC] =3D &pclk1_clk_src.clkr,
+=09[BYTE1_CLK_SRC] =3D &byte1_clk_src.clkr,
+=09[ESC1_CLK_SRC] =3D &esc1_clk_src.clkr,
+=09[VSYNC_CLK_SRC] =3D &vsync_clk_src.clkr,
+=09[GCC_MDSS_AHB_CLK] =3D &gcc_mdss_ahb_clk.clkr,
+=09[GCC_MDSS_AXI_CLK] =3D &gcc_mdss_axi_clk.clkr,
+=09[GCC_MDSS_PCLK0_CLK] =3D &gcc_mdss_pclk0_clk.clkr,
+=09[GCC_MDSS_BYTE0_CLK] =3D &gcc_mdss_byte0_clk.clkr,
+=09[GCC_MDSS_ESC0_CLK] =3D &gcc_mdss_esc0_clk.clkr,
+=09[GCC_MDSS_PCLK1_CLK] =3D &gcc_mdss_pclk1_clk.clkr,
+=09[GCC_MDSS_BYTE1_CLK] =3D &gcc_mdss_byte1_clk.clkr,
+=09[GCC_MDSS_ESC1_CLK] =3D &gcc_mdss_esc1_clk.clkr,
+=09[GCC_MDSS_MDP_CLK] =3D &gcc_mdss_mdp_clk.clkr,
+=09[GCC_MDSS_VSYNC_CLK] =3D &gcc_mdss_vsync_clk.clkr,
+=09[GCC_OXILI_TIMER_CLK] =3D &gcc_oxili_timer_clk.clkr,
+=09[GCC_OXILI_GFX3D_CLK] =3D &gcc_oxili_gfx3d_clk.clkr,
+=09[GCC_OXILI_AON_CLK] =3D &gcc_oxili_aon_clk.clkr,
+=09[GCC_OXILI_AHB_CLK] =3D &gcc_oxili_ahb_clk.clkr,
+=09[GCC_BIMC_GFX_CLK] =3D &gcc_bimc_gfx_clk.clkr,
+=09[GCC_BIMC_GPU_CLK] =3D &gcc_bimc_gpu_clk.clkr,
+=09[GFX3D_CLK_SRC] =3D &gfx3d_clk_src.clkr,
+};
+
+static const struct qcom_reset_map gcc_msm8953_resets[] =3D {
+=09[GCC_CAMSS_MICRO_BCR]=09=3D { 0x56008 },
+=09[GCC_MSS_BCR]=09=09=3D { 0x71000 },
+=09[GCC_QUSB2_PHY_BCR]=09=3D { 0x4103c },
+=09[GCC_USB3PHY_PHY_BCR]=09=3D { 0x3f03c },
+=09[GCC_USB3_PHY_BCR]=09=3D { 0x3f034 },
+=09[GCC_USB_30_BCR]=09=3D { 0x3f070 },
+};
+
+static const struct regmap_config gcc_msm8953_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x80000,
+=09.fast_io=09=3D true,
+};
+
+static struct gdsc *gcc_msm8953_gdscs[] =3D {
+=09[CPP_GDSC] =3D &cpp_gdsc,
+=09[JPEG_GDSC] =3D &jpeg_gdsc,
+=09[MDSS_GDSC] =3D &mdss_gdsc,
+=09[OXILI_CX_GDSC] =3D &oxili_cx_gdsc,
+=09[OXILI_GX_GDSC] =3D &oxili_gx_gdsc,
+=09[USB30_GDSC] =3D &usb30_gdsc,
+=09[VENUS_CORE0_GDSC] =3D &venus_core0_gdsc,
+=09[VENUS_GDSC] =3D &venus_gdsc,
+=09[VFE0_GDSC] =3D &vfe0_gdsc,
+=09[VFE1_GDSC] =3D &vfe1_gdsc,
+};
+
+static const struct qcom_cc_desc gcc_msm8953_desc =3D {
+=09.config =3D &gcc_msm8953_regmap_config,
+=09.clks =3D gcc_msm8953_clocks,
+=09.num_clks =3D ARRAY_SIZE(gcc_msm8953_clocks),
+=09.resets =3D gcc_msm8953_resets,
+=09.num_resets =3D ARRAY_SIZE(gcc_msm8953_resets),
+=09.gdscs =3D gcc_msm8953_gdscs,
+=09.num_gdscs =3D ARRAY_SIZE(gcc_msm8953_gdscs),
+=09.clk_hws =3D gcc_msm8953_hws,
+=09.num_clk_hws =3D ARRAY_SIZE(gcc_msm8953_hws),
+};
+
+static int gcc_msm8953_probe(struct platform_device *pdev)
+{
+=09struct regmap *regmap;
+
+=09regmap  =3D qcom_cc_map(pdev, &gcc_msm8953_desc);
+=09if (IS_ERR(regmap))
+=09=09return PTR_ERR(regmap);
+
+=09clk_alpha_pll_configure(&gpll3_early, regmap, &gpll3_early_config);
+
+=09return qcom_cc_really_probe(pdev, &gcc_msm8953_desc, regmap);
+}
+
+static const struct of_device_id gcc_msm8953_match_table[] =3D {
+=09{ .compatible =3D "qcom,gcc-msm8953" },
+=09{},
+};
+
+static struct platform_driver gcc_msm8953_driver =3D {
+=09.probe =3D gcc_msm8953_probe,
+=09.driver =3D {
+=09=09.name =3D "gcc-msm8953",
+=09=09.of_match_table =3D gcc_msm8953_match_table,
+=09=09.owner =3D THIS_MODULE,
+=09},
+};
+
+static int __init gcc_msm8953_init(void)
+{
+=09return platform_driver_register(&gcc_msm8953_driver);
+}
+core_initcall(gcc_msm8953_init);
+
+static void __exit gcc_msm8953_exit(void)
+{
+=09platform_driver_unregister(&gcc_msm8953_driver);
+}
+module_exit(gcc_msm8953_exit);
+
+MODULE_DESCRIPTION("Qualcomm GCC MSM8953 Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.32.0


