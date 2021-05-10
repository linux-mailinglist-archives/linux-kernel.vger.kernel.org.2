Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9B379723
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhEJSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:41:47 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:15298 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:41:46 -0400
Date:   Mon, 10 May 2021 18:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620672036;
        bh=dTw13JLDYtRUczCTi6U9+NbRwXC4w9gGQHjk+D82rrI=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=BH2pMv68SIVljra/vGeYxbLVS99BGDww5ELi8ycyTfSN5VDJH9nUVUM/lX4OsKmNg
         +3ViAa7YDg2huz995v09iXJV03c0/tDa8E6+aBhAXbqNYaWGAFKDurRBJhNggVrXgg
         QkZGXt9YCu916EeGo9ctYY2yIAbRyhPPN6Zuz9H4=
To:     "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     "agross@kernel.org" <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v5 1/3] soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
Message-ID: <HlKgfVyFuKjJEozBiamG7OpJNtXapuXyTiBzrned5KC3onTAJ4hO9l0LzpfDL9WQ4PKv5gNXSDAHPh6-nqSwjsOjrh-wS8_OIl-ChUSvbiE=@protonmail.com>
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

In-Reply-To: <20210121194051.484209-2-angelogioacchino.delregno@somainline.=
org>

On Thu, 21 Jan 2021 20:40:49 +0100, AngeloGioacchino Del Regno wrote:
> This commit introduces a new driver, based on the one for cpr v1,
> to enable support for the newer Qualcomm Core Power Reduction
> hardware, known downstream as CPR3, CPR4 and CPRh, and support
> for MSM8998 and SDM630 CPU power reduction.
>
> In these new versions of the hardware, support for various new
> features was introduced, including voltage reduction for the GPU,
> security hardening and a new way of controlling CPU DVFS,
> consisting in internal communication between microcontrollers,
> specifically the CPR-Hardened and the Operating State Manager.
>
> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
> from the mid-range to the high end ones including, but not limited
> to, MSM8953/8996/8998, SDM630/636/660/845.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@soma=
inline.org>
> ---
>  drivers/soc/qcom/Kconfig      |   17 +
>  drivers/soc/qcom/Makefile     |    1 +
>  drivers/soc/qcom/cpr-common.c |   35 +-
>  drivers/soc/qcom/cpr-common.h |    4 +
>  drivers/soc/qcom/cpr3.c       | 2915 +++++++++++++++++++++++++++++++++
>  5 files changed, 2966 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/soc/qcom/cpr3.c

I tried adding support for MSM8996 (testing with Xiaomi Mi Note 2, MSM8996P=
ro
speedbin 0), and I've been able to get it to work to some extent. I have so=
me
comments/issues/questions:

> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index fe3c486ae32d..10b365f0bb8f 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -42,6 +42,23 @@ config QCOM_CPR
>  =09  To compile this driver as a module, choose M here: the module will
>  =09  be called qcom-cpr
>
> +config QCOM_CPR3
> +=09tristate "QCOM Core Power Reduction (CPR v3/v4/Hardened) support"
> +=09depends on ARCH_QCOM && HAS_IOMEM
> +=09select PM_OPP
> +=09select REGMAP
> +=09help
> +=09  Say Y here to enable support for the CPR hardware found on a broad
> +=09  variety of Qualcomm SoCs like MSM8996, MSM8998, SDM630, SDM660,
> +=09  SDM845 and others.
> +
> +=09  This driver populates OPP tables and makes adjustments to them
> +=09  based on feedback from the CPR hardware. If you want to do CPU
> +=09  and/or GPU frequency scaling say Y here.
> +
> +=09  To compile this driver as a module, choose M here: the module will
> +=09  be called qcom-cpr3
> +
>  config QCOM_GENI_SE
>  =09tristate "QCOM GENI Serial Engine Driver"
>  =09depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 778a2a5f07bb..0500283c2dc5 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=3D=09qcom_aoss.o
>  obj-$(CONFIG_QCOM_GENI_SE) +=3D=09qcom-geni-se.o
>  obj-$(CONFIG_QCOM_COMMAND_DB) +=3D cmd-db.o
>  obj-$(CONFIG_QCOM_CPR)=09=09+=3D cpr-common.o cpr.o
> +obj-$(CONFIG_QCOM_CPR3)=09=09+=3D cpr-common.o cpr3.o
>  obj-$(CONFIG_QCOM_GSBI)=09+=3D=09qcom_gsbi.o
>  obj-$(CONFIG_QCOM_MDT_LOADER)=09+=3D mdt_loader.o
>  obj-$(CONFIG_QCOM_OCMEM)=09+=3D ocmem.o
> diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.=
c
> index 70e1e0f441db..8a2650c94a10 100644
> --- a/drivers/soc/qcom/cpr-common.c
> +++ b/drivers/soc/qcom/cpr-common.c
> @@ -252,6 +252,29 @@ u32 cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 =
tid)
>  =09of_node_put(np);
>
>  =09return fc;
> +
> +}
> +
> +void cpr_get_corner_post_vadj(struct dev_pm_opp *opp, u32 tid,
> +=09=09=09      s32 *open_loop, s32 *closed_loop)
> +{
> +=09struct device_node *np;
> +
> +=09/*
> +=09 * There is no of_property_read_s32_index, so we just store the
> +=09 * result into a s32 variable. After all, the OF API is doing
> +=09 * the exact same for of_property_read_s32...
> +=09 */
> +=09np =3D dev_pm_opp_get_of_node(opp);
> +=09if (of_property_read_u32_index(np, "qcom,opp-oloop-vadj", tid,
> +=09=09=09=09       open_loop))
> +=09=09*open_loop =3D 0;
> +
> +=09if (of_property_read_u32_index(np, "qcom,opp-cloop-vadj", tid,
> +=09=09=09=09       closed_loop))
> +=09=09*closed_loop =3D 0;
> +
> +=09of_node_put(np);
>  }
>
>  unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
> @@ -294,11 +317,10 @@ int cpr_calculate_scaling(const char *quot_offset,
>  =09=09=09  const struct fuse_corner_data *fdata,
>  =09=09=09  const struct corner *corner)
>  {
> -=09u32 quot_diff =3D 0;
> -=09unsigned long freq_diff;
> -=09int scaling;
> +=09u64 freq_diff;
>  =09const struct fuse_corner *fuse, *prev_fuse;
> -=09int ret;
> +=09u32 quot_diff;
> +=09int scaling, ret;
>
>  =09fuse =3D corner->fuse_corner;
>  =09prev_fuse =3D fuse - 1;
> @@ -315,8 +337,9 @@ int cpr_calculate_scaling(const char *quot_offset,
>  =09}
>
>  =09freq_diff =3D fuse->max_freq - prev_fuse->max_freq;
> -=09freq_diff /=3D 1000000; /* Convert to MHz */
> -=09scaling =3D 1000 * quot_diff / freq_diff;
> +=09freq_diff =3D div_u64(freq_diff, 1000000); /* Convert to MHz */
> +=09scaling =3D 1000 * quot_diff;
> +=09do_div(scaling, freq_diff);
>  =09return min(scaling, fdata->max_quot_scale);
>  }
>
> diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.=
h
> index 83a1f7c941b8..96ff6301c81e 100644
> --- a/drivers/soc/qcom/cpr-common.h
> +++ b/drivers/soc/qcom/cpr-common.h
> @@ -65,6 +65,8 @@ struct corner {
>  struct corner_data {
>  =09unsigned int fuse_corner;
>  =09unsigned long freq;
> +=09int oloop_vadj;
> +=09int cloop_vadj;
>  };
>
>  struct acc_desc {
> @@ -101,6 +103,8 @@ int cpr_populate_fuse_common(struct device *dev,
>  int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
>  =09=09=09    struct corner *corners, int num_corners);
>  u32 cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid);
> +void cpr_get_corner_post_vadj(struct dev_pm_opp *opp, u32 tid,
> +=09=09=09      s32 *open_loop, s32 *closed_loop);
>  unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
>  =09=09=09=09     struct device *cpu_dev);
>  int cpr_calculate_scaling(const char *quot_offset,
> diff --git a/drivers/soc/qcom/cpr3.c b/drivers/soc/qcom/cpr3.c
> new file mode 100644
> index 000000000000..fd7b78267390
> --- /dev/null
> +++ b/drivers/soc/qcom/cpr3.c
> @@ -0,0 +1,2915 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2013-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2019 Linaro Limited
> + * Copyright (c) 2020, AngeloGioacchino Del Regno
> + *                     <angelogioacchino.delregno@somainline.org>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/debugfs.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
> +#include <linux/clk.h>
> +#include <linux/nvmem-consumer.h>
> +#include "cpr-common.h"
> +
> +#define CPR3_RO_COUNT=09=09=09=0916
> +#define CPR3_RO_MASK=09=09=09=09GENMASK(CPR3_RO_COUNT - 1, 0)
> +
> +/* CPR3 registers */
> +#define CPR3_REG_CPR_VERSION=09=09=090x0
> +#define CPRH_CPR_VERSION_4P5=09=09=090x40050000
> +
> +#define CPR3_REG_CPR_CTL=09=09=090x4
> +#define CPR3_CPR_CTL_LOOP_EN_MASK=09=09BIT(0)
> +#define CPR3_CPR_CTL_IDLE_CLOCKS_MASK=09=09GENMASK(5, 1)
> +#define CPR3_CPR_CTL_IDLE_CLOCKS_SHIFT=09=091
> +#define CPR3_CPR_CTL_COUNT_MODE_MASK=09=09GENMASK(7, 6)
> +#define CPR3_CPR_CTL_COUNT_MODE_SHIFT=09=096
> +#define CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN=090
> +#define CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MAX=091
> +#define CPR3_CPR_CTL_COUNT_MODE_STAGGERED=092
> +#define CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_AGE=093
> +#define CPR3_CPR_CTL_COUNT_REPEAT_MASK=09=09GENMASK(31, 9)
> +#define CPR3_CPR_CTL_COUNT_REPEAT_SHIFT=09=099
> +
> +#define CPR3_REG_CPR_STATUS=09=09=090x8
> +#define CPR3_CPR_STATUS_BUSY_MASK=09=09BIT(0)
> +
> +/*
> + * This register is not present on controllers that support HW closed-lo=
op
> + * except CPR4 APSS controller.
> + */
> +#define CPR3_REG_CPR_TIMER_AUTO_CONT=09=090xC
> +
> +#define CPR3_REG_CPR_STEP_QUOT=09=09=090x14
> +#define CPR3_CPR_STEP_QUOT_MIN_MASK=09=09GENMASK(5, 0)
> +#define CPR3_CPR_STEP_QUOT_MIN_SHIFT=09=090
> +#define CPR3_CPR_STEP_QUOT_MAX_MASK=09=09GENMASK(11, 6)
> +#define CPR3_CPR_STEP_QUOT_MAX_SHIFT=09=096
> +#define CPRH_DELTA_QUOT_STEP_FACTOR=09=094
> +
> +#define CPR3_REG_GCNT(ro)=09=09=09(0xA0 + 0x4 * (ro))
> +#define CPR3_REG_SENSOR_OWNER(sensor)=09=09(0x200 + 0x4 * (sensor))
> +
> +#define CPR3_REG_CONT_CMD=09=09=090x800
> +#define CPR3_CONT_CMD_ACK=09=09=090x1
> +#define CPR3_CONT_CMD_NACK=09=09=090x0
> +
> +#define CPR3_REG_THRESH(thread)=09=09=09(0x808 + 0x440 * (thread))
> +#define CPR3_THRESH_CONS_DOWN_MASK=09=09GENMASK(3, 0)
> +#define CPR3_THRESH_CONS_DOWN_SHIFT=09=090
> +#define CPR3_THRESH_CONS_UP_MASK=09=09GENMASK(7, 4)
> +#define CPR3_THRESH_CONS_UP_SHIFT=09=094
> +#define CPR3_THRESH_DOWN_THRESH_MASK=09=09GENMASK(12, 8)
> +#define CPR3_THRESH_DOWN_THRESH_SHIFT=09=098
> +#define CPR3_THRESH_UP_THRESH_MASK=09=09GENMASK(17, 13)
> +#define CPR3_THRESH_UP_THRESH_SHIFT=09=0913
> +
> +#define CPR3_REG_RO_MASK(thread)=09=09(0x80C + 0x440 * (thread))
> +
> +#define CPR3_REG_RESULT0(thread)=09=09(0x810 + 0x440 * (thread))
> +#define CPR3_RESULT0_BUSY_MASK=09=09=09BIT(0)
> +#define CPR3_RESULT0_STEP_DN_MASK=09=09BIT(1)
> +#define CPR3_RESULT0_STEP_UP_MASK=09=09BIT(2)
> +#define CPR3_RESULT0_ERROR_STEPS_MASK=09=09GENMASK(7, 3)
> +#define CPR3_RESULT0_ERROR_STEPS_SHIFT=09=093
> +#define CPR3_RESULT0_ERROR_MASK=09=09=09GENMASK(19, 8)
> +#define CPR3_RESULT0_ERROR_SHIFT=09=098
> +
> +#define CPR3_REG_RESULT1(thread)=09=09(0x814 + 0x440 * (thread))
> +#define CPR3_RESULT1_QUOT_MIN_MASK=09=09GENMASK(11, 0)
> +#define CPR3_RESULT1_QUOT_MIN_SHIFT=09=090
> +#define CPR3_RESULT1_QUOT_MAX_MASK=09=09GENMASK(23, 12)
> +#define CPR3_RESULT1_QUOT_MAX_SHIFT=09=0912
> +#define CPR3_RESULT1_RO_MIN_MASK=09=09GENMASK(27, 24)
> +#define CPR3_RESULT1_RO_MIN_SHIFT=09=0924
> +#define CPR3_RESULT1_RO_MAX_MASK=09=09GENMASK(31, 28)
> +#define CPR3_RESULT1_RO_MAX_SHIFT=09=0928
> +
> +#define CPR3_REG_RESULT2(thread)=09=09(0x818 + 0x440 * (thread))
> +#define CPR3_RESULT2_STEP_QUOT_MIN_MASK=09=09GENMASK(5, 0)
> +#define CPR3_RESULT2_STEP_QUOT_MIN_SHIFT=090
> +#define CPR3_RESULT2_STEP_QUOT_MAX_MASK=09=09GENMASK(11, 6)
> +#define CPR3_RESULT2_STEP_QUOT_MAX_SHIFT=096
> +#define CPR3_RESULT2_SENSOR_MIN_MASK=09=09GENMASK(23, 16)
> +#define CPR3_RESULT2_SENSOR_MIN_SHIFT=09=0916
> +#define CPR3_RESULT2_SENSOR_MAX_MASK=09=09GENMASK(31, 24)
> +#define CPR3_RESULT2_SENSOR_MAX_SHIFT=09=0924
> +
> +#define CPR3_REG_IRQ_EN=09=09=09=090x81C
> +#define CPR3_REG_IRQ_CLEAR=09=09=090x820
> +#define CPR3_REG_IRQ_STATUS=09=09=090x824
> +#define CPR3_IRQ_UP=09=09=09=09BIT(3)
> +#define CPR3_IRQ_MID=09=09=09=09BIT(2)
> +#define CPR3_IRQ_DOWN=09=09=09=09BIT(1)
> +#define CPR3_IRQ_ALL=09=09=09=09(CPR3_IRQ_UP | CPR3_IRQ_MID | CPR3_IRQ_D=
OWN)
> +
> +#define CPR3_REG_TARGET_QUOT(thread, ro)=09(0x840 + 0x440 * (thread) + 0=
x4 * (ro))
> +
> +/* Registers found only on controllers that support HW closed-loop. */
> +#define CPR3_REG_PD_THROTTLE=09=09=090xE8
> +
> +#define CPR3_REG_HW_CLOSED_LOOP_DISABLED=090x3000
> +#define CPR3_REG_CPR_TIMER_MID_CONT=09=090x3004
> +#define CPR3_REG_CPR_TIMER_UP_DN_CONT=09=090x3008
> +
> +/* CPR4 controller specific registers and bit definitions */
> +#define CPR4_REG_CPR_TIMER_CLAMP=09=09=090x10
> +#define CPR4_CPR_TIMER_CLAMP_THREAD_AGGREGATION_EN=09BIT(27)
> +
> +#define CPR4_REG_MISC=09=09=09=090x700
> +#define CPR4_MISC_RESET_STEP_QUOT_LOOP_EN=09BIT(2)
> +#define CPR4_MISC_THREAD_HAS_ALWAYS_VOTE_EN=09BIT(3)
> +
> +#define CPR4_REG_SAW_ERROR_STEP_LIMIT=09=090x7A4
> +#define CPR4_SAW_ERROR_STEP_LIMIT_UP_MASK=09GENMASK(4, 0)
> +#define CPR4_SAW_ERROR_STEP_LIMIT_UP_SHIFT=090
> +#define CPR4_SAW_ERROR_STEP_LIMIT_DN_MASK=09GENMASK(9, 5)
> +#define CPR4_SAW_ERROR_STEP_LIMIT_DN_SHIFT=095
> +
> +#define CPR4_REG_MARGIN_TEMP_CORE_TIMERS=09=09=090x7A8
> +#define CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_MASK=09GENMASK=
(28, 18)
> +#define CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_SHFT=0918
> +
> +#define CPR4_REG_MARGIN_ADJ_CTL=09=09=09=090x7F8
> +#define CPR4_MARGIN_ADJ_HW_CLOSED_LOOP_EN=09=09BIT(4)
> +#define CPR4_MARGIN_ADJ_PER_RO_KV_MARGIN_EN=09=09BIT(7)
> +#define CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_MASK=09=09GENMASK(16, 12)
> +#define CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_SHIFT=09=0912
> +#define CPR4_MARGIN_ADJ_KV_MARGIN_ADJ_STEP_QUOT_MASK=09GENMASK(31, 26)
> +#define CPR4_MARGIN_ADJ_KV_MARGIN_ADJ_STEP_QUOT_SHIFT=0926
> +
> +#define CPR4_REG_CPR_MASK_THREAD(thread)=09=09(0x80C + 0x440 * (thread))
> +#define CPR4_CPR_MASK_THREAD_DISABLE_THREAD=09=09BIT(31)
> +#define CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK=09GENMASK(15, 0)
> +
> +/* CPRh controller specific registers and bit definitions */
> +#define __CPRH_REG_CORNER(rbase, tbase, tid, cnum) (rbase + (tbase * tid=
) + \
> +=09=09=09=09=09=09    (0x4 * cnum))
> +#define CPRH_REG_CORNER(d, t, c) __CPRH_REG_CORNER(d->reg_corner,     \
> +=09=09=09=09=09=09   d->reg_corner_tid, \
> +=09=09=09=09=09=09   t, c)
> +
> +#define CPRH_CTL_OSM_ENABLED=09=09=09BIT(0)
> +#define CPRH_CTL_BASE_VOLTAGE_MASK=09=09GENMASK(10, 1)
> +#define CPRH_CTL_BASE_VOLTAGE_SHIFT=09=091
> +#define CPRH_CTL_MODE_SWITCH_DELAY_MASK=09=09GENMASK(24, 17)
> +#define CPRH_CTL_MODE_SWITCH_DELAY_SHIFT=0917
> +#define CPRH_CTL_VOLTAGE_MULTIPLIER_MASK=09GENMASK(28, 25)
> +#define CPRH_CTL_VOLTAGE_MULTIPLIER_SHIFT=0925
> +
> +#define CPRH_CORNER_INIT_VOLTAGE_MASK=09=09GENMASK(7, 0)
> +#define CPRH_CORNER_INIT_VOLTAGE_SHIFT=09=090
> +#define CPRH_CORNER_FLOOR_VOLTAGE_MASK=09=09GENMASK(15, 8)
> +#define CPRH_CORNER_FLOOR_VOLTAGE_SHIFT=09=098
> +#define CPRH_CORNER_QUOT_DELTA_MASK=09=09GENMASK(24, 16)
> +#define CPRH_CORNER_QUOT_DELTA_SHIFT=09=0916
> +#define CPRH_CORNER_RO_SEL_MASK=09=09=09GENMASK(28, 25)
> +#define CPRH_CORNER_RO_SEL_SHIFT=09=0925
> +#define CPRH_CORNER_CPR_CL_DISABLE=09=09BIT(29)
> +
> +#define CPRH_CORNER_INIT_VOLTAGE_MAX_VALUE=09255
> +#define CPRH_CORNER_FLOOR_VOLTAGE_MAX_VALUE=09255
> +#define CPRH_CORNER_QUOT_DELTA_MAX_VALUE=09511
> +
> +enum cpr_type {
> +=09CTRL_TYPE_CPR3,
> +=09CTRL_TYPE_CPR4,
> +=09CTRL_TYPE_CPRH,
> +=09CTRL_TYPE_MAX,
> +};
> +
> +/*
> + * struct cpr_thread_desc - CPR Thread-specific parameters
> + *
> + * @controller_id:      Identifier of the CPR controller expected by the=
 HW
> + * @ro_scaling_factor:  Scaling factor for each ring oscillator entry
> + * @hw_tid:             Identifier of the CPR thread expected by the HW
> + * @init_voltage_step:  Voltage in uV for number of steps read from fuse=
 array
> + * @init_voltage_width: Bit-width of the voltage read from the fuse arra=
y
> + * @sensor_range_start: First sensor ID used by a thread
> + * @sensor_range_end:   Last sensor ID used by a thread
> + * @num_fuse_corners:   Number of valid entries in fuse_corner_data
> + * @step_quot_init_min: Minimum achievable step quotient for this corner
> + * @step_quot_init_max: Maximum achievable step quotient for this corner
> + * @fuse_corner_data:   Parameters for calculation of each fuse corner
> + */
> +struct cpr_thread_desc {
> +=09u8=09=09controller_id;
> +=09u8=09=09hw_tid;
> +=09const int=09(*ro_scaling_factor)[CPR3_RO_COUNT];
> +=09int=09=09ro_avail_corners;
> +=09int=09=09init_voltage_step;
> +=09int=09=09init_voltage_width;
> +=09u8=09=09sensor_range_start;
> +=09u8=09=09sensor_range_end;
> +=09u8=09=09step_quot_init_min;
> +=09u8=09=09step_quot_init_max;
> +=09unsigned int=09num_fuse_corners;
> +=09struct fuse_corner_data *fuse_corner_data;
> +};
> +
> +/*
> + * struct cpr_desc - Driver instance-wide CPR parameters
> + *
> + * @cpr_type:              Type (base version) of the CPR controller
> + * @num_threads:           Max. number of threads supported by this cont=
roller
> + * @timer_delay_us:        Loop delay time in uS
> + * @timer_updn_delay_us:   Voltage after-up/before-down delay time in uS
> + * @timer_cons_up:         Wait between consecutive up requests in uS
> + * @timer_cons_down:       Wait between consecutive down requests in uS
> + * @up_threshold:          Generic corner up threshold
> + * @down_threshold:        Generic corner down threshold
> + * @idle_clocks:           CPR Sensor: idle timer in cpr clocks unit
> + * @count_mode:            CPR Sensor: counting mode
> + * @count_repeat:          CPR Sensor: number of times to repeat reading
> + * @gcnt_us:               CPR measurement interval in uS
> + * @vreg_step_fixed:       Regulator voltage per step (if vreg unusable)
> + * @vreg_step_up_limit:    Num. of steps up at once before re-measuring =
sensors
> + * @vreg_step_down_limit:  Num. of steps dn at once before re-measuring =
sensors
> + * @vdd_settle_time_us:    Settling timer to account for one VDD supply =
step
> + * @corner_settle_time_us: Settle time for corner switch request
> + * @mem_acc_threshold:     Memory Accelerator (MEM-ACC) voltage threshol=
d
> + * @apm_threshold:         Array Power Mux (APM) voltage threshold
> + * @apm_crossover:         Array Power Mux (APM) corner crossover voltag=
e
> + * @apm_hysteresis:        Hysteresis for APM V-threshold related calcul=
ations
> + * @cpr_base_voltage:      Safety: Absolute minimum voltage (uV) on this=
 CPR
> + * @cpr_max_voltage:       Safety: Absolute maximum voltage (uV) on this=
 CPR
> + * @pd_throttle_val:       CPR Power Domain throttle during voltage swit=
ch
> + * @threads:               Array containing "CPR Thread" specific parame=
ters
> + * @reduce_to_fuse_uV:     Reduce corner max volts (if higher) to fuse c=
eiling
> + * @reduce_to_corner_uV:   Reduce corner max volts (if higher) to corner=
 ceil.
> + * @hw_closed_loop_en:     Enable CPR HW Closed-Loop voltage auto-adjust=
ment
> + */
> +struct cpr_desc {
> +=09enum cpr_type=09=09cpr_type;
> +=09unsigned int=09=09num_threads;
> +=09unsigned int=09=09timer_delay_us;
> +=09u8=09=09=09timer_updn_delay_us;
> +=09u8=09=09=09timer_cons_up;
> +=09u8=09=09=09timer_cons_down;
> +=09u8=09=09=09up_threshold;
> +=09u8=09=09=09down_threshold;
> +=09u8=09=09=09idle_clocks;
> +=09u8=09=09=09count_mode;
> +=09u8=09=09=09count_repeat;
> +=09u8=09=09=09gcnt_us;
> +=09u16=09=09=09vreg_step_fixed;
> +=09u8=09=09=09vreg_step_up_limit;
> +=09u8=09=09=09vreg_step_down_limit;
> +=09u8=09=09=09vdd_settle_time_us;
> +=09u8=09=09=09corner_settle_time_us;
> +=09int=09=09=09mem_acc_threshold;
> +=09int=09=09=09apm_threshold;
> +=09int=09=09=09apm_crossover;
> +=09int=09=09=09apm_hysteresis;
> +=09u32=09=09=09cpr_base_voltage;
> +=09u32=09=09=09cpr_max_voltage;
> +=09u32=09=09=09pd_throttle_val;
> +
> +=09const struct cpr_thread_desc **threads;
> +=09bool reduce_to_fuse_uV;
> +=09bool reduce_to_corner_uV;
> +=09bool hw_closed_loop_en;
> +};
> +
> +struct cpr_drv;
> +struct cpr_thread {
> +=09int=09=09=09num_corners;
> +=09int=09=09=09id;
> +=09bool=09=09=09enabled;
> +=09void __iomem=09=09*base;
> +=09struct clk=09=09*cpu_clk;
> +=09struct corner=09=09*corner;
> +=09struct corner=09=09*corners;
> +=09struct fuse_corner=09*fuse_corners;
> +=09struct cpr_drv=09=09*drv;
> +=09struct generic_pm_domain pd;
> +=09struct device=09=09*attached_cpu_dev;
> +=09struct work_struct=09restart_work;
> +=09bool=09=09=09restarting;
> +
> +=09const struct cpr_fuse=09*cpr_fuses;
> +=09const struct cpr_thread_desc *desc;
> +};
> +
> +struct cpr_drv {
> +=09int=09=09=09irq;
> +=09unsigned int=09=09ref_clk_khz;
> +=09struct device=09=09*dev;
> +=09struct mutex=09=09lock;
> +=09struct regulator=09*vreg;
> +=09struct regmap=09=09*tcsr;
> +=09u32=09=09=09gcnt;
> +=09u32=09=09=09speed_bin;
> +=09u32=09=09=09fusing_rev;
> +=09u32=09=09=09last_uV;
> +=09u32=09=09=09cpr_hw_rev;
> +=09u32=09=09=09reg_corner;
> +=09u32=09=09=09reg_corner_tid;
> +=09u32=09=09=09reg_ctl;
> +=09u32=09=09=09reg_status;
> +=09int=09=09=09fuse_level_set;
> +=09int=09=09=09extra_corners;
> +=09unsigned int=09=09vreg_step;
> +=09bool=09=09=09enabled;
> +
> +=09struct cpr_thread=09*threads;
> +=09struct genpd_onecell_data cell_data;
> +
> +=09const struct cpr_desc=09*desc;
> +=09const struct acc_desc=09*acc_desc;
> +=09struct dentry=09=09*debugfs;
> +};
> +
> +/*
> + * cpr_get_ring_osc_factor - Get fuse corner ring oscillator factor
> + *
> + * Not all threads have different scaling factors for each
> + * Fuse Corner: if the RO factors are the same for all corners,
> + * then only one is specified, instead of uselessly repeating
> + * the same array for FC-times.
> + * This function checks for the same and gives back the right
> + * factor for the requested ring oscillator.
> + *
> + * Returns: Ring oscillator factor
> + */
> +static int cpr_get_ro_factor(const struct cpr_thread_desc *tdesc,
> +=09=09=09     int fnum, int ro_idx)
> +{
> +=09int ro_fnum;
> +
> +=09if (tdesc->ro_avail_corners =3D=3D tdesc->num_fuse_corners)
> +=09=09ro_fnum =3D fnum;
> +=09else
> +=09=09ro_fnum =3D 0;
> +
> +=09return tdesc->ro_scaling_factor[ro_fnum][ro_idx];
> +}
> +
> +static void cpr_write(struct cpr_thread *thread, u32 offset, u32 value)
> +{
> +=09writel_relaxed(value, thread->base + offset);
> +}
> +
> +static u32 cpr_read(struct cpr_thread *thread, u32 offset)
> +{
> +=09return readl_relaxed(thread->base + offset);
> +}
> +
> +static void
> +cpr_masked_write(struct cpr_thread *thread, u32 offset, u32 mask, u32 va=
lue)
> +{
> +=09u32 val;
> +
> +=09val =3D readl_relaxed(thread->base + offset);
> +=09val &=3D ~mask;
> +=09val |=3D value & mask;
> +=09writel_relaxed(val, thread->base + offset);
> +}
> +
> +static void cpr_irq_clr(struct cpr_thread *thread)
> +{
> +=09cpr_write(thread, CPR3_REG_IRQ_CLEAR, CPR3_IRQ_ALL);
> +}
> +
> +static void cpr_irq_clr_nack(struct cpr_thread *thread)
> +{
> +=09cpr_irq_clr(thread);
> +=09cpr_write(thread, CPR3_REG_CONT_CMD, CPR3_CONT_CMD_NACK);
> +}
> +
> +static void cpr_irq_clr_ack(struct cpr_thread *thread)
> +{
> +=09cpr_irq_clr(thread);
> +=09cpr_write(thread, CPR3_REG_CONT_CMD, CPR3_CONT_CMD_ACK);
> +}
> +
> +static void cpr_irq_set(struct cpr_thread *thread, u32 int_bits)
> +{
> +=09/* On CPR-hardened, interrupts are managed by and on firmware */
> +=09if (thread->drv->desc->cpr_type =3D=3D CTRL_TYPE_CPRH)
> +=09=09return;
> +
> +=09cpr_write(thread, CPR3_REG_IRQ_EN, int_bits);
> +}
> +
> +/**
> + * cpr_ctl_enable - Enable CPR thread
> + * @thread:     Structure holding CPR thread-specific parameters
> + */
> +static void cpr_ctl_enable(struct cpr_thread *thread)
> +{
> +=09if (thread->drv->enabled && !thread->restarting)
> +=09=09cpr_masked_write(thread, CPR3_REG_CPR_CTL,
> +=09=09=09=09CPR3_CPR_CTL_LOOP_EN_MASK,
> +=09=09=09=09CPR3_CPR_CTL_LOOP_EN_MASK);
> +}
> +
> +/**
> + * cpr_ctl_disable - Disable CPR thread
> + * @thread:     Structure holding CPR thread-specific parameters
> + */
> +static void cpr_ctl_disable(struct cpr_thread *thread)
> +{
> +=09const struct cpr_desc *desc =3D thread->drv->desc;
> +
> +=09if (desc->cpr_type !=3D CTRL_TYPE_CPRH) {
> +=09=09cpr_irq_set(thread, 0);
> +=09=09cpr_irq_clr(thread);
> +=09}
> +
> +=09cpr_masked_write(thread, CPR3_REG_CPR_CTL,
> +=09=09=09 CPR3_CPR_CTL_LOOP_EN_MASK, 0);
> +}
> +
> +/**
> + * cpr_ctl_is_enabled - Check if thread is enabled
> + * @thread:     Structure holding CPR thread-specific parameters
> + *
> + * Returns: true if the CPR is enabled, false if it is disabled.
> + */
> +static bool cpr_ctl_is_enabled(struct cpr_thread *thread)
> +{
> +=09u32 reg_val;
> +
> +=09reg_val =3D cpr_read(thread, CPR3_REG_CPR_CTL);
> +=09return reg_val & CPR3_CPR_CTL_LOOP_EN_MASK;
> +}
> +
> +/**
> + * cpr_check_any_thread_busy - Check if HW is done processing
> + * @thread:     Structure holding CPR thread-specific parameters
> + *
> + * Returns: true if the CPR is busy, false if it is ready.
> + */
> +static bool cpr_check_any_thread_busy(struct cpr_thread *thread)
> +{
> +=09int i;
> +
> +=09for (i =3D 0; i < thread->drv->desc->num_threads; i++)
> +=09=09if (cpr_read(thread, CPR3_REG_RESULT0(i)) &
> +=09=09    CPR3_RESULT0_BUSY_MASK)
> +=09=09=09return true;
> +
> +=09return false;
> +}
> +
> +static void cpr_restart_worker(struct work_struct *work)
> +{
> +=09struct cpr_thread *thread =3D container_of(work, struct cpr_thread,
> +=09=09=09=09=09=09 restart_work);
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09int i;
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09thread->restarting =3D true;
> +=09cpr_ctl_disable(thread);
> +=09disable_irq(drv->irq);
> +
> +=09mutex_unlock(&drv->lock);
> +
> +=09for (i =3D 0; i < 20; i++) {
> +=09=09u32 cpr_status =3D cpr_read(thread, CPR3_REG_CPR_STATUS);
> +=09=09u32 ctl =3D cpr_read(thread, CPR3_REG_CPR_CTL);
> +
> +=09=09if ((cpr_status & CPR3_CPR_STATUS_BUSY_MASK) &&
> +=09=09   !(ctl & CPR3_CPR_CTL_LOOP_EN_MASK))
> +=09=09=09break;
> +
> +=09=09udelay(10);
> +=09}
> +
> +=09cpr_irq_clr(thread);
> +
> +=09for (i =3D 0; i < 20; i++) {
> +=09=09u32 status =3D cpr_read(thread, CPR3_REG_IRQ_STATUS);
> +
> +=09=09if (!(status & CPR3_IRQ_ALL))
> +=09=09=09break;
> +=09=09udelay(10);
> +=09}
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09thread->restarting =3D false;
> +=09enable_irq(drv->irq);
> +=09cpr_ctl_enable(thread);
> +
> +=09mutex_unlock(&drv->lock);
> +}
> +
> +/**
> + * cpr_corner_restore - Restore saved corner level
> + * @thread: Structure holding CPR thread-specific parameters
> + * @corner: Structure holding the saved corner level
> + */
> +static void cpr_corner_restore(struct cpr_thread *thread,
> +=09=09=09       struct corner *corner)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09struct fuse_corner *fuse =3D corner->fuse_corner;
> +=09const struct cpr_thread_desc *tdesc =3D thread->desc;
> +=09u32 ro_sel =3D fuse->ring_osc_idx;
> +
> +=09cpr_write(thread, CPR3_REG_GCNT(ro_sel), drv->gcnt);
> +
> +=09cpr_write(thread, CPR3_REG_RO_MASK(tdesc->hw_tid),
> +=09=09  CPR3_RO_MASK & ~BIT(ro_sel));
> +
> +=09cpr_write(thread, CPR3_REG_TARGET_QUOT(tdesc->hw_tid, ro_sel),
> +=09=09  fuse->quot - corner->quot_adjust);
> +
> +=09if (drv->desc->cpr_type =3D=3D CTRL_TYPE_CPR4) {
> +=09=09cpr_masked_write(thread,
> +=09=09=09=09 CPR4_REG_CPR_MASK_THREAD(tdesc->hw_tid),
> +=09=09=09=09 CPR4_CPR_MASK_THREAD_DISABLE_THREAD |
> +=09=09=09=09 CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK, 0);
> +=09}
> +
> +=09thread->corner =3D corner;
> +=09corner->last_uV =3D corner->uV;
> +}
> +
> +/**
> + * cpr_set_acc - Set fuse level to the mem-acc
> + * @thread: Structure holding CPR thread-specific parameters
> + * @f:      Fuse level
> + */
> +static void cpr_set_acc(struct cpr_drv *drv, int f)
> +{
> +=09const struct acc_desc *desc =3D drv->acc_desc;
> +=09struct reg_sequence *s =3D desc->settings;
> +=09int n =3D desc->num_regs_per_fuse;
> +
> +=09if (!s || f =3D=3D drv->fuse_level_set)
> +=09=09return;
> +
> +=09regmap_multi_reg_write(drv->tcsr, s + (n * f), n);
> +=09drv->fuse_level_set =3D f;
> +}
> +
> +/**
> + * cpr_post_voltage - Actions to execute before setting voltage

Nitpick: should be cpr_pre_voltage here.

> + * @thread:     Structure holding CPR thread-specific parameters
> + * @dir:        Enumeration for voltage change direction
> + * @fuse_level: Fuse corner for mem-acc, if supported.
> + *
> + * Returns: Zero for success or negative number on errors.
> + */
> +static int cpr_pre_voltage(struct cpr_thread *thread,
> +=09=09=09   enum voltage_change_dir dir,
> +=09=09=09   int fuse_level)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +
> +=09if (drv->desc->cpr_type =3D=3D CTRL_TYPE_CPR3 &&
> +=09    drv->desc->pd_throttle_val)
> +=09=09cpr_write(thread, CPR3_REG_PD_THROTTLE,
> +=09=09=09  drv->desc->pd_throttle_val);
> +
> +=09if (drv->tcsr && dir =3D=3D DOWN)
> +=09=09cpr_set_acc(drv, fuse_level);
> +
> +=09return 0;
> +}
> +
> +/**
> + * cpr_post_voltage - Actions to execute after setting voltage
> + * @thread:     Structure holding CPR thread-specific parameters
> + * @dir:        Enumeration for voltage change direction
> + * @fuse_level: Fuse corner for mem-acc, if supported.
> + *
> + * Returns: Zero for success or negative number on errors.
> + */
> +static int cpr_post_voltage(struct cpr_thread *thread,
> +=09=09=09    enum voltage_change_dir dir,
> +=09=09=09    int fuse_level)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +
> +=09if (drv->tcsr && dir =3D=3D UP)
> +=09=09cpr_set_acc(drv, fuse_level);
> +
> +=09if (drv->desc->cpr_type =3D=3D CTRL_TYPE_CPR3)
> +=09=09cpr_write(thread, CPR3_REG_PD_THROTTLE, 0);
> +
> +=09return 0;
> +}
> +
> +/**
> + * cpr_commit_state - Set the newly requested voltage
> + * @thread:     Structure holding CPR thread-specific parameters
> + *
> + * Returns: IRQ_SUCCESS for success, IRQ_NONE if the CPR is disabled.
> + */
> +static int cpr_commit_state(struct cpr_thread *thread)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09int min_uV =3D 0, max_uV =3D 0, new_uV =3D 0, fuse_level =3D 0;
> +=09enum voltage_change_dir dir;
> +=09u32 next_irqmask =3D 0;
> +=09int ret, i;
> +
> +=09/* On CPRhardened, control states are managed in firmware */
> +=09if (drv->desc->cpr_type =3D=3D CTRL_TYPE_CPRH)
> +=09=09return 0;
> +
> +=09for (i =3D 0; i < drv->desc->num_threads; i++) {
> +=09=09struct cpr_thread *thread =3D &drv->threads[i];
> +
> +=09=09if (!thread->corner)
> +=09=09=09continue;
> +
> +=09=09fuse_level =3D max(fuse_level,
> +=09=09=09=09 (int) (thread->corner->fuse_corner -
> +=09=09=09=09 &thread->fuse_corners[0]));
> +
> +=09=09max_uV =3D max(max_uV, thread->corner->max_uV);
> +=09=09min_uV =3D max(min_uV, thread->corner->min_uV);
> +=09=09new_uV =3D max(new_uV, thread->corner->last_uV);
> +=09}
> +=09dev_vdbg(drv->dev, "%s: new uV: %d, last uV: %d\n",
> +=09=09 __func__, new_uV, drv->last_uV);
> +
> +=09/*
> +=09 * Safety measure: if the voltage is out of the globally allowed
> +=09 * range, then go out and warn the user.
> +=09 * This should *never* happen.
> +=09 */
> +=09if (new_uV > drv->desc->cpr_max_voltage ||
> +=09    new_uV < drv->desc->cpr_base_voltage) {
> +=09=09dev_warn(drv->dev, "Voltage (%u uV) out of range.", new_uV);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09if (new_uV =3D=3D drv->last_uV || fuse_level =3D=3D drv->fuse_level_s=
et)
> +=09=09goto out;

As far as I understand, corners under the same fuse corner can have differe=
nt
voltages, so a change in fuse corner shouldn't be required to change voltag=
e.

> +
> +=09if (fuse_level > drv->fuse_level_set)
> +=09=09dir =3D UP;
> +=09else
> +=09=09dir =3D DOWN;
> +
> +=09ret =3D cpr_pre_voltage(thread, fuse_level, dir);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09dev_vdbg(drv->dev, "setting voltage: %d\n", new_uV);
> +
> +=09ret =3D regulator_set_voltage(drv->vreg, new_uV, new_uV);
> +=09if (ret) {
> +=09=09dev_err_ratelimited(drv->dev, "failed to set voltage %d: %d\n",
> +=09=09=09=09    new_uV, ret);
> +=09=09return ret;
> +=09}
> +
> +=09ret =3D cpr_post_voltage(thread, fuse_level, dir);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09drv->last_uV =3D new_uV;
> +out:
> +=09if (new_uV > min_uV)
> +=09=09next_irqmask |=3D CPR3_IRQ_DOWN;
> +=09if (new_uV < max_uV)
> +=09=09next_irqmask |=3D CPR3_IRQ_UP;
> +
> +=09cpr_irq_set(thread, next_irqmask);
> +
> +=09return 0;
> +}
> +
> +static unsigned int cpr_get_cur_perf_state(struct cpr_thread *thread)
> +{
> +=09return thread->corner ? thread->corner - thread->corners + 1 : 0;
> +}
> +
> +/**
> + * cpr_scale - Calculate new voltage for the received direction
> + * @thread: Structure holding CPR thread-specific parameters
> + * @dir:    Enumeration for voltage change direction
> + *
> + * The CPR scales one by one: this function calculates the new
> + * voltage to set when a voltage-UP or voltage-DOWN request comes
> + * and stores it into the per-thread structure that gets passed.
> + */
> +static void cpr_scale(struct cpr_thread *thread, enum voltage_change_dir=
 dir)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09const struct cpr_thread_desc *tdesc =3D thread->desc;
> +=09u32 val, error_steps;
> +=09int last_uV, new_uV;
> +=09struct corner *corner;
> +
> +=09if (dir !=3D UP && dir !=3D DOWN)
> +=09=09return;
> +
> +=09corner =3D thread->corner;
> +=09val =3D cpr_read(thread, CPR3_REG_RESULT0(tdesc->hw_tid));
> +=09error_steps =3D val >> CPR3_RESULT0_ERROR_STEPS_SHIFT;
> +=09error_steps &=3D CPR3_RESULT0_ERROR_STEPS_MASK;
> +
> +=09last_uV =3D corner->last_uV;
> +
> +=09if (dir =3D=3D UP) {
> +=09=09if (!(val & CPR3_RESULT0_STEP_UP_MASK))
> +=09=09=09return;
> +
> +=09=09/* Calculate new voltage */
> +=09=09new_uV =3D last_uV + drv->vreg_step;
> +=09=09new_uV =3D min(new_uV, corner->max_uV);
> +
> +=09=09dev_vdbg(drv->dev,
> +=09=09=09"[T%u] UP - new_uV=3D%d last_uV=3D%d p-state=3D%u st=3D%u\n",
> +=09=09=09thread->id, new_uV, last_uV,
> +=09=09=09cpr_get_cur_perf_state(thread), error_steps);
> +=09} else {
> +=09=09if (!(val & CPR3_RESULT0_STEP_DN_MASK))
> +=09=09=09return;
> +
> +=09=09/* Calculate new voltage */
> +=09=09new_uV =3D last_uV - drv->vreg_step;
> +=09=09new_uV =3D max(new_uV, corner->min_uV);
> +=09=09dev_vdbg(drv->dev,
> +=09=09=09"[T%u] DOWN - new_uV=3D%d last_uV=3D%d p-state=3D%u st=3D%u\n",
> +=09=09=09thread->id, new_uV, last_uV,
> +=09=09=09cpr_get_cur_perf_state(thread), error_steps);
> +=09}
> +=09corner->last_uV =3D new_uV;
> +}
> +
> +/**
> + * cpr_irq_handler - Handle CPR3/CPR4 status interrupts
> + * @irq: Number of the interrupt
> + * @dev: Pointer to the cpr_thread structure
> + *
> + * Handle the interrupts coming from non-hardened CPR HW as to get
> + * an ok to scale voltages immediately, or to pass error status to
> + * the hardware (either success/ACK or failure/NACK).
> + *
> + * Returns: IRQ_SUCCESS for success, IRQ_NONE if the CPR is disabled.
> + */
> +static irqreturn_t cpr_irq_handler(int irq, void *dev)
> +{
> +=09struct cpr_thread *thread =3D dev;
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09irqreturn_t ret =3D IRQ_HANDLED;
> +=09int i, rc;
> +=09enum voltage_change_dir dir =3D NO_CHANGE;
> +=09u32 val;
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09val =3D cpr_read(thread, CPR3_REG_IRQ_STATUS);
> +
> +=09dev_vdbg(drv->dev, "IRQ_STATUS =3D %#02x\n", val);
> +
> +=09if (!cpr_ctl_is_enabled(thread)) {
> +=09=09dev_vdbg(drv->dev, "CPR is disabled\n");
> +=09=09ret =3D IRQ_NONE;
> +=09} else if (cpr_check_any_thread_busy(thread)) {
> +=09=09cpr_irq_clr_nack(thread);
> +=09=09dev_dbg(drv->dev, "CPR measurement is not ready\n");
> +=09} else {
> +=09=09/*
> +=09=09 * Following sequence of handling is as per each IRQ's
> +=09=09 * priority
> +=09=09 */
> +=09=09if (val & CPR3_IRQ_UP)
> +=09=09=09dir =3D UP;
> +=09=09else if (val & CPR3_IRQ_DOWN)
> +=09=09=09dir =3D DOWN;
> +
> +=09=09if (dir !=3D NO_CHANGE) {
> +=09=09=09for (i =3D 0; i < drv->desc->num_threads; i++) {
> +=09=09=09=09thread =3D &drv->threads[i];
> +=09=09=09=09cpr_scale(thread, dir);
> +=09=09=09}
> +
> +=09=09=09rc =3D cpr_commit_state(thread);
> +=09=09=09if (rc)
> +=09=09=09=09cpr_irq_clr_nack(thread);
> +=09=09=09else
> +=09=09=09=09cpr_irq_clr_ack(thread);
> +=09=09} else if (val & CPR3_IRQ_MID) {
> +=09=09=09dev_dbg(drv->dev, "IRQ occurred for Mid Flag\n");
> +=09=09} else {
> +=09=09=09dev_warn(drv->dev,
> +=09=09=09=09 "IRQ occurred for unknown flag (%#08x)\n",
> +=09=09=09=09 val);
> +=09=09=09schedule_work(&thread->restart_work);
> +=09=09}
> +=09}
> +
> +=09mutex_unlock(&drv->lock);
> +
> +=09return ret;
> +}
> +
> +static int cpr_switch(struct cpr_drv *drv)
> +{
> +=09int i, ret;
> +=09bool enabled =3D false;
> +
> +=09if (drv->desc->cpr_type =3D=3D CTRL_TYPE_CPRH)
> +=09=09return 0;
> +
> +=09for (i =3D 0; i < drv->desc->num_threads && !enabled; i++)
> +=09=09enabled =3D drv->threads[i].enabled;
> +
> +=09dev_vdbg(drv->dev, "%s: enabled =3D %d\n", __func__, enabled);
> +
> +=09if (enabled =3D=3D drv->enabled)
> +=09=09return 0;
> +
> +=09if (enabled) {
> +=09=09ret =3D regulator_enable(drv->vreg);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09drv->enabled =3D enabled;
> +
> +=09=09for (i =3D 0; i < drv->desc->num_threads; i++)
> +=09=09=09if (drv->threads[i].corner)
> +=09=09=09=09break;
> +
> +=09=09if (i < drv->desc->num_threads) {
> +=09=09=09cpr_irq_clr(&drv->threads[i]);
> +
> +=09=09=09cpr_commit_state(&drv->threads[i]);
> +=09=09=09cpr_ctl_enable(&drv->threads[i]);
> +=09=09}
> +=09} else {
> +=09=09for (i =3D 0; i < drv->desc->num_threads && !enabled; i++)
> +=09=09=09cpr_ctl_disable(&drv->threads[i]);
> +
> +=09=09drv->enabled =3D enabled;
> +
> +=09=09ret =3D regulator_disable(drv->vreg);
> +=09=09if (ret < 0)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +/**
> + * cpr_enable - Enables a CPR thread
> + * @thread: Structure holding CPR thread-specific parameters
> + *
> + * Returns: Zero for success or negative number on errors.
> + */
> +static int cpr_enable(struct cpr_thread *thread)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09int ret;
> +
> +=09dev_dbg(drv->dev, "Enabling thread %d\n", thread->id);
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09thread->enabled =3D true;
> +=09ret =3D cpr_switch(thread->drv);
> +
> +=09mutex_unlock(&drv->lock);
> +
> +=09return ret;
> +}
> +
> +/**
> + * cpr_disable - Disables a CPR thread
> + * @thread: Structure holding CPR thread-specific parameters
> + *
> + * Returns: Zero for success or negative number on errors.
> + */
> +static int cpr_disable(struct cpr_thread *thread)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09int ret;
> +
> +=09dev_dbg(drv->dev, "Disabling thread %d\n", thread->id);
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09thread->enabled =3D false;
> +=09ret =3D cpr_switch(thread->drv);
> +
> +=09mutex_unlock(&drv->lock);
> +
> +=09return ret;
> +}
> +
> +/**
> + * cpr_configure - Configure main HW parameters
> + * @thread: Structure holding CPR thread-specific parameters
> + *
> + * This function configures the main CPR hardware parameters, such as
> + * internal timers (and delays), sensor ownerships, activates and/or
> + * deactivates cpr-threads and others, as one sequence for all of the
> + * versions supported in this driver. By design, the function may
> + * return a success earlier if the sequence for "a previous version"
> + * has ended.
> + *
> + * NOTE: The CPR must be clocked before calling this function!
> + *
> + * Returns: Zero for success or negative number on errors.
> + */
> +static int cpr_configure(struct cpr_thread *thread)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09const struct cpr_desc *desc =3D drv->desc;
> +=09const struct cpr_thread_desc *tdesc =3D thread->desc;
> +=09u32 val;
> +=09int i;
> +
> +=09/* Disable interrupt and CPR */
> +=09cpr_irq_set(thread, 0);
> +=09cpr_write(thread, CPR3_REG_CPR_CTL, 0);
> +
> +=09/* Init and save gcnt */
> +=09drv->gcnt =3D drv->ref_clk_khz * desc->gcnt_us;
> +=09do_div(drv->gcnt, 1000);
> +
> +=09/* Program the delay count for the timer */
> +=09val =3D drv->ref_clk_khz * desc->timer_delay_us;
> +=09do_div(val, 1000);
> +=09if (desc->cpr_type =3D=3D CTRL_TYPE_CPR3) {
> +=09=09cpr_write(thread, CPR3_REG_CPR_TIMER_MID_CONT, val);
> +
> +=09=09val =3D drv->ref_clk_khz * desc->timer_updn_delay_us;
> +=09=09do_div(val, 1000);
> +=09=09cpr_write(thread, CPR3_REG_CPR_TIMER_UP_DN_CONT, val);
> +=09} else {
> +=09=09cpr_write(thread, CPR3_REG_CPR_TIMER_AUTO_CONT, val);
> +=09}
> +=09dev_dbg(drv->dev, "Timer count: %#0x (for %d us)\n", val,
> +=09=09desc->timer_delay_us);
> +
> +=09/* Program the control register */
> +=09val =3D desc->idle_clocks << CPR3_CPR_CTL_IDLE_CLOCKS_SHIFT
> +=09    | desc->count_mode << CPR3_CPR_CTL_COUNT_MODE_SHIFT
> +=09    | desc->count_repeat << CPR3_CPR_CTL_COUNT_REPEAT_SHIFT;
> +=09cpr_write(thread, CPR3_REG_CPR_CTL, val);
> +
> +=09/* Configure CPR default step quotients */
> +=09val =3D tdesc->step_quot_init_min << CPR3_CPR_STEP_QUOT_MIN_SHIFT
> +=09    | tdesc->step_quot_init_max << CPR3_CPR_STEP_QUOT_MAX_SHIFT;
> +
> +=09cpr_write(thread, CPR3_REG_CPR_STEP_QUOT, val);
> +
> +=09/*
> +=09 * Configure the CPR sensor ownership always on thread 0
> +=09 * TODO: SDM845 has different ownership for sensors!!
> +=09 */
> +=09for (i =3D tdesc->sensor_range_start; i < tdesc->sensor_range_end; i+=
+)
> +=09=09cpr_write(thread, CPR3_REG_SENSOR_OWNER(i), 0);
> +
> +=09/* Program Consecutive Up & Down */
> +=09val =3D desc->timer_cons_up << CPR3_THRESH_CONS_UP_SHIFT;
> +=09val |=3D desc->timer_cons_down << CPR3_THRESH_CONS_DOWN_SHIFT;
> +=09val |=3D desc->up_threshold << CPR3_THRESH_UP_THRESH_SHIFT;
> +=09val |=3D desc->down_threshold << CPR3_THRESH_DOWN_THRESH_SHIFT;
> +=09cpr_write(thread, CPR3_REG_THRESH(tdesc->hw_tid), val);
> +
> +=09/* Mask all ring oscillators for all threads initially */
> +=09cpr_write(thread, CPR3_REG_RO_MASK(tdesc->hw_tid), CPR3_RO_MASK);
> +
> +=09/* HW Closed-loop control */
> +=09if (desc->cpr_type =3D=3D CTRL_TYPE_CPR3)
> +=09=09cpr_write(thread, CPR3_REG_HW_CLOSED_LOOP_DISABLED,
> +=09=09=09  !desc->hw_closed_loop_en);
> +=09else
> +=09=09cpr_masked_write(thread, CPR4_REG_MARGIN_ADJ_CTL,
> +=09=09=09=09CPR4_MARGIN_ADJ_HW_CLOSED_LOOP_EN,
> +=09=09=09=09desc->hw_closed_loop_en ?
> +=09=09=09=09CPR4_MARGIN_ADJ_HW_CLOSED_LOOP_EN : 0);
> +
> +=09/* Additional configuration for CPR4 and beyond */
> +=09if (desc->cpr_type < CTRL_TYPE_CPR4)
> +=09=09return 0;
> +
> +=09/* Disable threads initially only on non-hardened CPR4 */
> +=09if (desc->cpr_type =3D=3D CTRL_TYPE_CPR4)
> +=09=09cpr_masked_write(thread, CPR4_REG_CPR_MASK_THREAD(1),
> +=09=09=09=09CPR4_CPR_MASK_THREAD_DISABLE_THREAD |
> +=09=09=09=09CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK,
> +=09=09=09=09CPR4_CPR_MASK_THREAD_DISABLE_THREAD |
> +=09=09=09=09CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK);
> +
> +=09if (tdesc->hw_tid > 0)
> +=09=09cpr_masked_write(thread, CPR4_REG_MISC,
> +=09=09=09=09 CPR4_MISC_RESET_STEP_QUOT_LOOP_EN |
> +=09=09=09=09 CPR4_MISC_THREAD_HAS_ALWAYS_VOTE_EN,
> +=09=09=09=09 CPR4_MISC_RESET_STEP_QUOT_LOOP_EN |
> +=09=09=09=09 CPR4_MISC_THREAD_HAS_ALWAYS_VOTE_EN);
> +
> +=09val =3D drv->vreg_step;
> +=09do_div(val, 1000);
> +=09cpr_masked_write(thread, CPR4_REG_MARGIN_ADJ_CTL,
> +=09=09=09 CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_MASK,
> +=09=09=09 val << CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_SHIFT);
> +
> +=09cpr_masked_write(thread, CPR4_REG_SAW_ERROR_STEP_LIMIT,
> +=09=09=09 CPR4_SAW_ERROR_STEP_LIMIT_DN_MASK,
> +=09=09=09 desc->vreg_step_down_limit <<
> +=09=09=09 CPR4_SAW_ERROR_STEP_LIMIT_DN_SHIFT);
> +
> +=09cpr_masked_write(thread, CPR4_REG_SAW_ERROR_STEP_LIMIT,
> +=09=09=09 CPR4_SAW_ERROR_STEP_LIMIT_UP_MASK,
> +=09=09=09 desc->vreg_step_up_limit <<
> +=09=09=09 CPR4_SAW_ERROR_STEP_LIMIT_UP_SHIFT);
> +
> +=09cpr_masked_write(thread, CPR4_REG_MARGIN_ADJ_CTL,
> +=09=09=09 CPR4_MARGIN_ADJ_PER_RO_KV_MARGIN_EN,
> +=09=09=09 CPR4_MARGIN_ADJ_PER_RO_KV_MARGIN_EN);
> +
> +=09if (tdesc->hw_tid > 0)
> +=09=09cpr_masked_write(thread, CPR4_REG_CPR_TIMER_CLAMP,
> +=09=09=09=09 CPR4_CPR_TIMER_CLAMP_THREAD_AGGREGATION_EN,
> +=09=09=09=09 CPR4_CPR_TIMER_CLAMP_THREAD_AGGREGATION_EN);
> +
> +=09/* Settling timer to account for one VDD supply step */
> +=09if (desc->vdd_settle_time_us > 0) {
> +=09=09u32 m =3D CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_MASK;
> +=09=09u32 s =3D CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_SHFT;
> +
> +=09=09cpr_masked_write(thread, CPR4_REG_MARGIN_TEMP_CORE_TIMERS,
> +=09=09=09=09 m, desc->vdd_settle_time_us << s);
> +=09}
> +
> +=09/* Additional configuration for CPR-hardened */
> +=09if (desc->cpr_type < CTRL_TYPE_CPRH)
> +=09=09return 0;
> +
> +=09/* Settling timer to account for one corner-switch request */
> +=09if (desc->corner_settle_time_us > 0)
> +=09=09cpr_masked_write(thread, drv->reg_ctl,
> +=09=09=09=09 CPRH_CTL_MODE_SWITCH_DELAY_MASK,
> +=09=09=09=09 desc->corner_settle_time_us <<
> +=09=09=09=09 CPRH_CTL_MODE_SWITCH_DELAY_SHIFT);
> +
> +=09/* Base voltage and multiplier values for CPRh internal calculations =
*/
> +=09cpr_masked_write(thread, drv->reg_ctl,
> +=09=09=09 CPRH_CTL_BASE_VOLTAGE_MASK,
> +=09=09=09 (DIV_ROUND_UP(desc->cpr_base_voltage,
> +=09=09=09=09       drv->vreg_step) <<
> +=09=09=09  CPRH_CTL_BASE_VOLTAGE_SHIFT));
> +
> +=09cpr_masked_write(thread, drv->reg_ctl,
> +=09=09=09 CPRH_CTL_VOLTAGE_MULTIPLIER_MASK,
> +=09=09=09 DIV_ROUND_UP(drv->vreg_step, 1000) <<
> +=09=09=09 CPRH_CTL_VOLTAGE_MULTIPLIER_SHIFT);
> +
> +=09return 0;
> +}
> +
> +static int cpr_set_performance_state(struct generic_pm_domain *domain,
> +=09=09=09=09     unsigned int state)
> +{
> +=09struct cpr_thread *thread =3D container_of(domain, struct cpr_thread,=
 pd);
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09struct corner *corner, *end;
> +=09int ret =3D 0;
> +
> +=09/* On CPRhardened, performance states are managed in firmware */
> +=09if (drv->desc->cpr_type =3D=3D CTRL_TYPE_CPRH)
> +=09=09return 0;
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09dev_dbg(drv->dev,
> +=09=09"setting perf state: %u (prev state: %u thread: %u)\n",
> +=09=09state, cpr_get_cur_perf_state(thread), thread->id);
> +
> +=09/*
> +=09 * Determine new corner we're going to.
> +=09 * Remove one since lowest performance state is 1.
> +=09 */
> +=09corner =3D thread->corners + state - 1;
> +=09end =3D &thread->corners[thread->num_corners - 1];
> +=09if (corner > end || corner < thread->corners) {
> +=09=09ret =3D -EINVAL;
> +=09=09goto unlock;
> +=09}
> +
> +=09cpr_ctl_disable(thread);
> +
> +=09cpr_irq_clr(thread);
> +=09if (thread->corner !=3D corner)
> +=09=09cpr_corner_restore(thread, corner);
> +
> +=09ret =3D cpr_commit_state(thread);
> +=09if (ret)
> +=09=09goto unlock;
> +
> +=09cpr_ctl_enable(thread);
> +unlock:
> +=09mutex_unlock(&drv->lock);
> +
> +=09dev_dbg(drv->dev,
> +=09=09"set perf state %u on thread %u\n", state, thread->id);
> +
> +=09return ret;
> +}
> +
> +/**
> + * cpr3_adjust_quot - Adjust the closed-loop quotients
> + * @thread: Structure holding CPR thread-specific parameters
> + *
> + * Calculates the quotient adjustment factor based on closed-loop
> + * quotients and ring oscillator factor.
> + *
> + * Returns: Adjusted quotient
> + */
> +static int cpr3_adjust_quot(int ring_osc_factor, int volt_closed_loop)
> +{
> +=09s64 temp;
> +
> +=09if (ring_osc_factor =3D=3D 0 || volt_closed_loop =3D=3D 0)
> +=09=09return 0;
> +
> +=09temp =3D (s64)(ring_osc_factor * volt_closed_loop);
> +=09return (int)div_s64(temp, 1000000);
> +}
> +
> +/**
> + * cpr_fuse_corner_init - Calculate fuse corner table
> + * @thread: Structure holding CPR thread-specific parameters
> + *
> + * This function populates the fuse corners table by reading the
> + * values from the fuses, eventually adjusting them with a fixed
> + * per-corner offset and doing basic checks about them being
> + * supported by the regulator that is assigned to this CPR - if
> + * it is available (on CPR-Hardened, there is no usable vreg, as
> + * that is protected by the hypervisor).
> + *
> + * Returns: Zero for success, negative number on error
> + */
> +static int cpr_fuse_corner_init(struct cpr_thread *thread)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09const struct cpr_thread_desc *desc =3D thread->desc;
> +=09const struct cpr_fuse *cpr_fuse =3D thread->cpr_fuses;
> +=09struct fuse_corner_data *fdata;
> +=09struct fuse_corner *fuse, *prev_fuse, *end;
> +=09int i, ret;
> +
> +=09/* Populate fuse_corner members */
> +=09fuse =3D thread->fuse_corners;
> +=09prev_fuse =3D &fuse[0];
> +=09end =3D &fuse[desc->num_fuse_corners - 1];
> +=09fdata =3D desc->fuse_corner_data;
> +
> +=09for (i =3D 0; fuse <=3D end; fuse++, cpr_fuse++, i++, fdata++) {
> +=09=09int factor =3D cpr_get_ro_factor(desc, i, fuse->ring_osc_idx);
> +
> +=09=09ret =3D cpr_populate_fuse_common(drv->dev, fdata, cpr_fuse,
> +=09=09=09=09=09       fuse, drv->vreg_step,
> +=09=09=09=09=09       desc->init_voltage_width,
> +=09=09=09=09=09       desc->init_voltage_step);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09/*
> +=09=09 * Adjust the fuse quot with per-fuse-corner closed-loop
> +=09=09 * voltage adjustment parameters.
> +=09=09 */
> +=09=09fuse->quot +=3D cpr3_adjust_quot(factor,
> +=09=09=09=09=09       fdata->volt_cloop_adjust);
> +
> +=09=09/* CPRh: no regulator access... */
> +=09=09if (drv->desc->cpr_type =3D=3D CTRL_TYPE_CPRH)
> +=09=09=09goto skip_pvs_restrict;
> +
> +=09=09/* Re-check if corner voltage range is supported by regulator */
> +=09=09ret =3D cpr_check_vreg_constraints(drv->dev, drv->vreg, fuse);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +skip_pvs_restrict:
> +=09=09if (fuse->uV < prev_fuse->uV)
> +=09=09=09fuse->uV =3D prev_fuse->uV;
> +=09=09prev_fuse =3D fuse;
> +=09=09dev_dbg(drv->dev,
> +=09=09=09"fuse corner %d: [%d %d %d] RO%hhu quot %d\n",
> +=09=09=09i, fuse->min_uV, fuse->uV, fuse->max_uV,
> +=09=09=09fuse->ring_osc_idx, fuse->quot);
> +
> +=09=09/* Check if constraints are valid */
> +=09=09if (fuse->uV < fuse->min_uV || fuse->uV > fuse->max_uV) {
> +=09=09=09dev_err(drv->dev,
> +=09=09=09=09"fuse corner %d: Bad voltage range.\n", i);
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void cpr3_restrict_corner(struct corner *corner, int threshold,
> +=09=09=09=09 int hysteresis, int step)
> +{
> +=09if (threshold > corner->min_uV && threshold <=3D corner->max_uV) {
> +=09=09if (corner->uV >=3D threshold) {
> +=09=09=09corner->min_uV =3D max(corner->min_uV,
> +=09=09=09=09=09     threshold - hysteresis);
> +=09=09=09if (corner->min_uV > corner->uV)
> +=09=09=09=09corner->uV =3D corner->min_uV;
> +=09=09} else {
> +=09=09=09corner->max_uV =3D threshold;
> +=09=09=09corner->max_uV -=3D step;
> +=09=09}
> +=09}
> +}
> +
> +/*
> + * cprh_corner_adjust_opps - Set voltage on each CPU OPP table entry
> + *
> + * On CPR-Hardened, the voltage level is controlled internally through
> + * the OSM hardware: in order to initialize the latter, we have to
> + * communicate the voltage to its driver, so that it will be able to
> + * write the right parameters (as they have to be set both on the CPRh
> + * and on the OSM) on it.
> + * This function is called only for CPRh.
> + *
> + * Return: Zero for success, negative number for error.
> + */
> +static int cprh_corner_adjust_opps(struct cpr_thread *thread)
> +{
> +=09struct corner *corner =3D thread->corners;
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09struct opp_table *tbl;
> +=09int i, ret;
> +
> +=09tbl =3D dev_pm_opp_get_opp_table(thread->attached_cpu_dev);
> +=09if (IS_ERR(tbl)) {
> +=09=09dev_err(drv->dev, "Cannot get OPP table: %ld\n", PTR_ERR(tbl));
> +=09=09return PTR_ERR(tbl);
> +=09}
> +
> +=09for (i =3D 0; i < thread->num_corners; i++) {
> +=09=09ret =3D dev_pm_opp_adjust_voltage(thread->attached_cpu_dev,
> +=09=09=09=09=09=09corner[i].freq,
> +=09=09=09=09=09=09corner[i].uV,
> +=09=09=09=09=09=09corner[i].min_uV,
> +=09=09=09=09=09=09corner[i].max_uV);
> +=09=09if (ret) {
> +=09=09=09dev_err(drv->dev,
> +=09=09=09=09"Failed to adjust OPP for %lu Khz, %d uV\n",
> +=09=09=09=09corner[i].freq, corner[i].uV);
> +=09=09=09break;
> +=09=09}
> +
> +=09=09dev_dbg(drv->dev,
> +=09=09=09"OPP voltage adjusted for %lu kHz, %d uV\n",
> +=09=09=09corner[i].freq, corner[i].uV);
> +=09}
> +
> +=09dev_pm_opp_put_opp_table(tbl);
> +=09return ret;
> +}
> +
> +/**
> + * cpr3_corner_init - Calculate and set-up corners for the CPR HW
> + * @thread: Structure holding CPR thread-specific parameters
> + *
> + * This function calculates all the corner parameters by comparing
> + * and interpolating the values read from the various set-points
> + * read from the fuses (also called "fuse corners") to generate and
> + * program to the CPR a lookup table that describes each voltage
> + * step, mapped to a performance level (or corner number).
> + *
> + * It also programs other essential parameters on the CPR and - if
> + * we are dealing with CPR-Hardened, it will also enable the internal
> + * interface between the Operating State Manager (OSM) and the CPRh
> + * in order to achieve CPU DVFS.
> + *
> + * Returns: Zero for success, negative number on error
> + */
> +static int cpr3_corner_init(struct cpr_thread *thread)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09const struct cpr_desc *desc =3D drv->desc;
> +=09const struct cpr_thread_desc *tdesc =3D thread->desc;
> +=09const struct cpr_fuse *fuses =3D thread->cpr_fuses;
> +=09int i, ret, total_corners, extra_corners, level, scaling =3D 0;
> +=09unsigned int fnum, fc;
> +=09const char *quot_offset;
> +=09const struct fuse_corner_data *fdata;
> +=09struct fuse_corner *fuse, *prev_fuse;
> +=09struct corner *corner, *prev_corner, *end;
> +=09struct corner_data *cdata;
> +=09struct dev_pm_opp *opp;
> +=09unsigned long freq;
> +=09u32 ring_osc_mask =3D CPR3_RO_MASK, min_quotient =3D U32_MAX;
> +
> +=09corner =3D thread->corners;
> +=09prev_corner =3D &thread->corners[0];
> +=09end =3D &corner[thread->num_corners - 1];
> +
> +=09cdata =3D devm_kcalloc(drv->dev,
> +=09=09=09     thread->num_corners + drv->extra_corners,
> +=09=09=09     sizeof(struct corner_data),
> +=09=09=09     GFP_KERNEL);
> +=09if (!cdata)
> +=09=09return -ENOMEM;
> +
> +=09for (level =3D 1; level <=3D thread->num_corners; level++) {
> +=09=09opp =3D dev_pm_opp_find_level_exact(&thread->pd.dev, level);
> +=09=09if (IS_ERR(opp))
> +=09=09=09return -EINVAL;
> +
> +=09=09/*
> +=09=09 * If there is only one specified qcom,opp-fuse-level, then
> +=09=09 * it is assumed that this only one is global and valid for
> +=09=09 * all IDs, so try to get the specific one but, on failure,
> +=09=09 * go for the global one.
> +=09=09 */
> +=09=09fc =3D cpr_get_fuse_corner(opp, thread->id);
> +=09=09if (fc =3D=3D 0) {
> +=09=09=09fc =3D cpr_get_fuse_corner(opp, 0);
> +=09=09=09if (fc =3D=3D 0) {
> +=09=09=09=09dev_err(drv->dev,
> +=09=09=09=09=09"qcom,opp-fuse-level is missing!\n");
> +=09=09=09=09dev_pm_opp_put(opp);
> +=09=09=09=09return -EINVAL;
> +=09=09=09}
> +=09=09}
> +=09=09fnum =3D fc - 1;
> +
> +=09=09freq =3D cpr_get_opp_hz_for_req(opp, thread->attached_cpu_dev);
> +=09=09if (!freq) {
> +=09=09=09thread->num_corners =3D max(level - 1, 0);
> +=09=09=09end =3D &thread->corners[thread->num_corners - 1];
> +=09=09=09break;
> +=09=09}
> +
> +=09=09/*
> +=09=09 * If any post-vadj (open/closed loop) is not specified, then
> +=09=09 * it's zero, meaning that it is not required for this corner.
> +=09=09 */
> +=09=09cpr_get_corner_post_vadj(opp, thread->id,
> +=09=09=09=09=09 &cdata[level - 1].oloop_vadj,
> +=09=09=09=09=09 &cdata[level - 1].cloop_vadj);
> +=09=09cdata[level - 1].fuse_corner =3D fnum;
> +=09=09cdata[level - 1].freq =3D freq;
> +
> +=09=09fuse =3D &thread->fuse_corners[fnum];
> +=09=09dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
> +=09=09=09freq, dev_pm_opp_get_level(opp) - 1, fnum);
> +=09=09if (freq > fuse->max_freq)
> +=09=09=09fuse->max_freq =3D freq;
> +=09=09dev_pm_opp_put(opp);
> +
> +=09=09/*
> +=09=09 * Make sure that the frequencies in the table are in ascending
> +=09=09 * order, as this is critical for the algorithm to work.
> +=09=09 */
> +=09=09if (cdata[level - 2].freq > freq) {
> +=09=09=09dev_err(drv->dev,
> +=09=09=09=09"Frequency table not in ascending order.\n");
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09}
> +
> +=09if (thread->num_corners < 2) {
> +=09=09dev_err(drv->dev, "need at least 2 OPPs to use CPR\n");
> +=09=09return -EINVAL;
> +=09}
> +
> +=09/*
> +=09 * Get the quotient adjustment scaling factor, according to:
> +=09 *
> +=09 * scaling =3D min(1000 * (QUOT(corner_N) - QUOT(corner_N-1))
> +=09 *=09=09/ (freq(corner_N) - freq(corner_N-1)), max_factor)
> +=09 *
> +=09 * QUOT(corner_N):=09quotient read from fuse for fuse corner N
> +=09 * QUOT(corner_N-1):=09quotient read from fuse for fuse corner (N - 1=
)
> +=09 * freq(corner_N):=09max frequency in MHz supported by fuse corner N
> +=09 * freq(corner_N-1):=09max frequency in MHz supported by fuse corner
> +=09 *=09=09=09 (N - 1)
> +=09 *
> +=09 * Then walk through the corners mapped to each fuse corner
> +=09 * and calculate the quotient adjustment for each one using the
> +=09 * following formula:
> +=09 *
> +=09 * quot_adjust =3D (freq_max - freq_corner) * scaling / 1000
> +=09 *
> +=09 * freq_max: max frequency in MHz supported by the fuse corner
> +=09 * freq_corner: frequency in MHz corresponding to the corner
> +=09 * scaling: calculated from above equation
> +=09 *
> +=09 *
> +=09 *     +                           +
> +=09 *     |                         v |
> +=09 *   q |           f c           o |           f c
> +=09 *   u |         c               l |         c
> +=09 *   o |       f                 t |       f
> +=09 *   t |     c                   a |     c
> +=09 *     | c f                     g | c f
> +=09 *     |                         e |
> +=09 *     +---------------            +----------------
> +=09 *       0 1 2 3 4 5 6               0 1 2 3 4 5 6
> +=09 *          corner                      corner
> +=09 *
> +=09 *    c =3D corner
> +=09 *    f =3D fuse corner
> +=09 *
> +=09 */
> +=09for (i =3D 0; corner <=3D end; corner++, i++) {
> +=09=09unsigned long freq_diff_mhz;
> +=09=09int ro_fac, vadj, prev_quot;
> +
> +=09=09fnum =3D cdata[i].fuse_corner;
> +=09=09fdata =3D &tdesc->fuse_corner_data[fnum];
> +=09=09quot_offset =3D fuses[fnum].quotient_offset;
> +=09=09fuse =3D &thread->fuse_corners[fnum];
> +=09=09ring_osc_mask &=3D (u16)(~BIT(fuse->ring_osc_idx));
> +=09=09if (fnum)
> +=09=09=09prev_fuse =3D &thread->fuse_corners[fnum - 1];
> +=09=09else
> +=09=09=09prev_fuse =3D NULL;
> +
> +=09=09corner->fuse_corner =3D fuse;
> +=09=09corner->freq =3D cdata[i].freq;
> +=09=09corner->uV =3D fuse->uV;
> +
> +=09=09if (prev_fuse) {
> +=09=09=09if (prev_fuse->ring_osc_idx =3D=3D fuse->ring_osc_idx)
> +=09=09=09=09quot_offset =3D NULL;
> +
> +=09=09=09scaling =3D cpr_calculate_scaling(quot_offset, drv->dev,
> +=09=09=09=09=09=09=09fdata, corner);
> +=09=09=09if (scaling < 0)
> +=09=09=09=09return scaling;
> +
> +=09=09=09freq_diff_mhz =3D fuse->max_freq - corner->freq;
> +=09=09=09do_div(freq_diff_mhz, 1000000); /* now in MHz */
> +
> +=09=09=09corner->quot_adjust =3D scaling * freq_diff_mhz;
> +=09=09=09do_div(corner->quot_adjust, 1000);
> +
> +=09=09=09/* Fine-tune QUOT (closed-loop) based on fixed values */
> +=09=09=09ro_fac =3D cpr_get_ro_factor(tdesc, fnum, fuse->ring_osc_idx);
> +=09=09=09vadj =3D cdata[i].cloop_vadj;
> +=09=09=09corner->quot_adjust -=3D cpr3_adjust_quot(ro_fac, vadj);
> +=09=09=09dev_vdbg(drv->dev,
> +=09=09=09=09 "Quot fine-tuning to %d for post-vadj=3D%d\n",
> +=09=09=09=09 corner->quot_adjust, vadj);
> +
> +=09=09=09/*
> +=09=09=09 * Make sure that we scale (up) monotonically.
> +=09=09=09 * P.S.: Fuse quots can never be descending.
> +=09=09=09 */
> +=09=09=09prev_quot =3D prev_corner->fuse_corner->quot;
> +=09=09=09prev_quot -=3D prev_corner->quot_adjust;
> +=09=09=09if (fuse->quot - corner->quot_adjust < prev_quot) {
> +=09=09=09=09int new_adj =3D prev_corner->fuse_corner->quot;
> +=09=09=09=09new_adj -=3D fuse->quot;
> +=09=09=09=09dev_vdbg(drv->dev,
> +=09=09=09=09=09 "Monotonic increase forced: %d->%d\n",
> +=09=09=09=09=09 corner->quot_adjust, new_adj);
> +=09=09=09=09corner->quot_adjust =3D new_adj;
> +=09=09=09}
> +
> +=09=09=09corner->uV =3D cpr_interpolate(corner,
> +=09=09=09=09=09=09     drv->vreg_step, fdata);
> +=09=09}
> +=09=09/* Negative fuse quotients are nonsense. */
> +=09=09if (fuse->quot < corner->quot_adjust)
> +=09=09=09return -EINVAL;
> +
> +=09=09min_quotient =3D min(min_quotient,
> +=09=09=09=09   (u32)(fuse->quot - corner->quot_adjust));
> +
> +=09=09/* Fine-tune voltages (open-loop) based on fixed values */
> +=09=09corner->uV +=3D cdata[i].oloop_vadj;
> +=09=09dev_dbg(drv->dev,
> +=09=09=09 "Voltage fine-tuning to %d for post-vadj=3D%d\n",
> +=09=09=09 corner->uV, cdata[i].oloop_vadj);
> +
> +=09=09corner->max_uV =3D fuse->max_uV;
> +=09=09corner->min_uV =3D fuse->min_uV;
> +=09=09corner->uV =3D clamp(corner->uV, corner->min_uV, corner->max_uV);
> +=09=09dev_vdbg(drv->dev, "Clamped after interpolation: [%d %d %d]\n",
> +=09=09=09corner->min_uV, corner->uV, corner->max_uV);
> +
> +=09=09/* Make sure that we scale monotonically here, too. */
> +=09=09if (corner->uV < prev_corner->uV)
> +=09=09=09corner->uV =3D prev_corner->uV;
> +
> +=09=09corner->last_uV =3D corner->uV;
> +
> +=09=09/* Reduce the ceiling voltage if needed */
> +=09=09if (desc->reduce_to_corner_uV && corner->uV < corner->max_uV)
> +=09=09=09corner->max_uV =3D corner->uV;
> +=09=09else if (desc->reduce_to_fuse_uV && fuse->uV < corner->max_uV)
> +=09=09=09corner->max_uV =3D max(corner->min_uV, fuse->uV);
> +
> +=09=09corner->min_uV =3D max(corner->max_uV - fdata->range_uV,
> +=09=09=09=09     corner->min_uV);
> +
> +=09=09/*
> +=09=09 * Adjust per-corner floor and ceiling voltages so that
> +=09=09 * they do not overlap the memory Array Power Mux (APM)
> +=09=09 * nor the Memory Accelerator (MEM-ACC) threshold voltages.
> +=09=09 */
> +=09=09if (desc->apm_threshold)
> +=09=09=09cpr3_restrict_corner(corner, desc->apm_threshold,
> +=09=09=09=09=09     desc->apm_hysteresis,
> +=09=09=09=09=09     drv->vreg_step);
> +=09=09if (desc->mem_acc_threshold)
> +=09=09=09cpr3_restrict_corner(corner, desc->mem_acc_threshold,
> +=09=09=09=09=09     0, drv->vreg_step);
> +
> +=09=09prev_corner =3D corner;
> +=09=09dev_dbg(drv->dev, "corner %d: [%d %d %d] scaling %d quot %d\n", i,
> +=09=09=09corner->min_uV, corner->uV, corner->max_uV, scaling,
> +=09=09=09fuse->quot - corner->quot_adjust);
> +=09}
> +
> +=09/* Additional setup for CPRh only */
> +=09if (desc->cpr_type < CTRL_TYPE_CPRH)
> +=09=09return 0;
> +
> +=09/* If the OPPs can't be adjusted, programming the CPRh is useless */
> +=09ret =3D cprh_corner_adjust_opps(thread);
> +=09if (ret) {
> +=09=09dev_err(drv->dev, "Cannot adjust CPU OPP voltages: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09total_corners =3D thread->num_corners;
> +=09extra_corners =3D drv->extra_corners;
> +
> +=09/* If the APM extra corner exists, add it now. */
> +=09if (desc->apm_crossover && desc->apm_threshold && extra_corners) {
> +=09=09/* Program the APM crossover corner on the CPR-Hardened */
> +=09=09thread->corners[total_corners].uV =3D desc->apm_crossover;
> +=09=09thread->corners[total_corners].min_uV =3D desc->apm_crossover;
> +=09=09thread->corners[total_corners].max_uV =3D desc->apm_crossover;
> +=09=09thread->corners[total_corners].is_open_loop =3D true;
> +
> +=09=09/*
> +=09=09 * Also add and disable an opp with zero frequency: other
> +=09=09 * drivers will need to know what is the APM *threshold*
> +=09=09 * voltage.
> +=09=09 */
> +=09=09ret =3D dev_pm_opp_add(thread->attached_cpu_dev, 0,
> +=09=09=09=09     desc->apm_threshold);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09ret =3D dev_pm_opp_disable(thread->attached_cpu_dev, 0);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09dev_dbg(drv->dev, "corner %d (APM): [%d %d %d] Open-Loop\n",
> +=09=09=09total_corners, desc->apm_crossover,
> +=09=09=09desc->apm_crossover, desc->apm_crossover);
> +
> +=09=09total_corners++;
> +=09=09extra_corners--;
> +=09}
> +
> +=09if (desc->mem_acc_threshold && extra_corners) {
> +=09=09/* Program the Memory Accelerator threshold corner to CPRh */
> +=09=09thread->corners[total_corners].uV =3D desc->mem_acc_threshold;
> +=09=09thread->corners[total_corners].min_uV =3D desc->mem_acc_threshold;
> +=09=09thread->corners[total_corners].max_uV =3D desc->mem_acc_threshold;
> +=09=09thread->corners[total_corners].is_open_loop =3D true;
> +
> +=09=09/*
> +=09=09 * Add and disable an opp with zero frequency: other
> +=09=09 * drivers will also need to know about any mem-acc
> +=09=09 * threshold to respect.
> +=09=09 */
> +=09=09ret =3D dev_pm_opp_add(thread->attached_cpu_dev, 1,
> +=09=09=09=09     desc->mem_acc_threshold);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09ret =3D dev_pm_opp_disable(thread->attached_cpu_dev, 1);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09dev_dbg(drv->dev, "corner %d (MEMACC): [%d %d %d] Open-Loop\n",
> +=09=09=09total_corners, desc->mem_acc_threshold,
> +=09=09=09desc->mem_acc_threshold, desc->mem_acc_threshold);
> +
> +=09=09total_corners++;
> +=09=09extra_corners--;
> +=09}
> +
> +=09/*
> +=09 * If there are any extra corners left, it means that even though we
> +=09 * expect to fill in both APM and MEM-ACC crossovers, one couldn't
> +=09 * satisfy requirements, which means that the specified parameters
> +=09 * are wrong: in this case, inform the user and bail out, otherwise
> +=09 * if we go on writing the (invalid) table to the CPR-Hardened, the
> +=09 * hardware (in this case, the CPU) will surely freeze and crash.
> +=09 */
> +=09if (unlikely(extra_corners)) {
> +=09=09dev_err(drv->dev, "APM/MEM-ACC corners: bad parameters.\n");
> +=09=09return -EINVAL;
> +=09}
> +=09/* Reassign extra_corners, as we have to exclude delta_quot for them =
*/
> +=09extra_corners =3D drv->extra_corners;
> +
> +=09/* Disable the interface between OSM and CPRh */
> +=09cpr_masked_write(thread, drv->reg_ctl,
> +=09=09=09 CPRH_CTL_OSM_ENABLED, 0);
> +
> +=09/* Program the GCNT before unmasking ring oscillator(s) */
> +=09for (i =3D 0; i < CPR3_RO_COUNT; i++) {
> +=09=09if (!(ring_osc_mask & BIT(i))) {
> +=09=09=09cpr_write(thread, CPR3_REG_GCNT(i), drv->gcnt);
> +=09=09=09dev_vdbg(drv->dev, "RO%d gcnt=3D%d\n", i, drv->gcnt);
> +=09=09}
> +=09}
> +
> +=09/*
> +=09 * Unmask the ring oscillator(s) that we're going to use: it seems
> +=09 * to be mandatory to do this *before* sending the rest of the
> +=09 * CPRhardened specific configuration.
> +=09 */
> +=09dev_dbg(drv->dev,
> +=09=09"Unmasking ring oscillators with mask 0x%x\n", ring_osc_mask);
> +=09cpr_write(thread, CPR3_REG_RO_MASK(tdesc->hw_tid), ring_osc_mask);
> +
> +=09/* Setup minimum quotients for ring oscillators */
> +=09for (i =3D 0; i < CPR3_RO_COUNT; i++) {
> +=09=09u32 tgt_quot_reg =3D CPR3_REG_TARGET_QUOT(tdesc->hw_tid, i);
> +=09=09u32 tgt_quot_val =3D 0;
> +
> +=09=09if (!(ring_osc_mask & BIT(i)))
> +=09=09=09tgt_quot_val =3D min_quotient;
> +
> +=09=09cpr_write(thread, tgt_quot_reg, tgt_quot_val);
> +=09=09dev_vdbg(drv->dev,
> +=09=09=09 "Programmed min quotient %u for Ring Oscillator %d\n",
> +=09=09=09 tgt_quot_val, tgt_quot_reg);
> +=09}
> +
> +=09for (i =3D 0; i < total_corners; i++) {
> +=09=09int volt_oloop_steps, volt_floor_steps, delta_quot_steps;
> +=09=09int ring_osc;
> +=09=09u32 val;
> +
> +=09=09fnum =3D cdata[i].fuse_corner;
> +=09=09fuse =3D &thread->fuse_corners[fnum];
> +
> +=09=09val =3D thread->corners[i].uV - desc->cpr_base_voltage;
> +=09=09volt_oloop_steps =3D DIV_ROUND_UP(val, drv->vreg_step);
> +
> +=09=09val =3D thread->corners[i].min_uV - desc->cpr_base_voltage;
> +=09=09volt_floor_steps =3D DIV_ROUND_UP(val, drv->vreg_step);
> +
> +=09=09/*
> +=09=09 * If we are accessing corners that are not used as
> +=09=09 * an active DCVS set-point, then always select RO 0
> +=09=09 * and zero out the delta quotient.
> +=09=09 */
> +=09=09if (i >=3D thread->num_corners) {
> +=09=09=09ring_osc =3D 0;
> +=09=09=09delta_quot_steps =3D 0;
> +=09=09} else {
> +=09=09=09ring_osc =3D fuse->ring_osc_idx;
> +=09=09=09val =3D fuse->quot - thread->corners[i].quot_adjust;
> +=09=09=09val -=3D min_quotient;
> +=09=09=09delta_quot_steps =3D DIV_ROUND_UP(val,
> +=09=09=09=09=09=09CPRH_DELTA_QUOT_STEP_FACTOR);
> +=09=09}
> +
> +=09=09if (volt_oloop_steps > CPRH_CORNER_INIT_VOLTAGE_MAX_VALUE  ||
> +=09=09    volt_floor_steps > CPRH_CORNER_FLOOR_VOLTAGE_MAX_VALUE ||
> +=09=09    delta_quot_steps > CPRH_CORNER_QUOT_DELTA_MAX_VALUE) {
> +=09=09=09dev_err(drv->dev,
> +=09=09=09=09"Invalid cfg: oloop=3D%d, floor=3D%d, delta=3D%d\n",
> +=09=09=09=09volt_oloop_steps, volt_floor_steps,
> +=09=09=09=09delta_quot_steps);
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09=09/* Green light: Go, Go, Go! */
> +
> +=09=09/* Set number of open-loop steps */
> +=09=09val =3D volt_oloop_steps << CPRH_CORNER_INIT_VOLTAGE_SHIFT;
> +=09=09val &=3D CPRH_CORNER_INIT_VOLTAGE_MASK;
> +
> +=09=09/* Set number of floor voltage steps */
> +=09=09val |=3D (volt_floor_steps << CPRH_CORNER_FLOOR_VOLTAGE_SHIFT) &
> +=09=09       CPRH_CORNER_FLOOR_VOLTAGE_MASK;
> +
> +=09=09/* Set number of target quotient delta steps */
> +=09=09val |=3D (delta_quot_steps << CPRH_CORNER_QUOT_DELTA_SHIFT) &
> +=09=09       CPRH_CORNER_QUOT_DELTA_MASK;
> +
> +=09=09/* Select ring oscillator for this corner */
> +=09=09val |=3D (ring_osc << CPRH_CORNER_RO_SEL_SHIFT) &
> +=09=09       CPRH_CORNER_RO_SEL_MASK;
> +
> +=09=09/* Open loop corner is usually APM/ACC crossover */
> +=09=09if (thread->corners[i].is_open_loop) {
> +=09=09=09dev_dbg(drv->dev,
> +=09=09=09=09"Disabling Closed-Loop on corner %d\n", i);
> +=09=09=09val |=3D CPRH_CORNER_CPR_CL_DISABLE;
> +=09=09}
> +=09=09cpr_write(thread, CPRH_REG_CORNER(drv, tdesc->hw_tid, i), val);
> +
> +=09=09dev_dbg(drv->dev,
> +=09=09=09"steps [%d]: open-loop %d, floor %d, delta_quot %d\n",
> +=09=09=09i, volt_oloop_steps, volt_floor_steps,
> +=09=09=09delta_quot_steps);
> +=09}
> +
> +=09/* YAY! Setup is done! Enable the internal loop to start CPR. */
> +=09cpr_masked_write(thread, CPR3_REG_CPR_CTL,
> +=09=09=09CPR3_CPR_CTL_LOOP_EN_MASK,
> +=09=09=09CPR3_CPR_CTL_LOOP_EN_MASK);
> +
> +=09/*
> +=09 * Make sure that all the writes go through before enabling
> +=09 * internal communication between the OSM and the CPRh
> +=09 * controllers, otherwise there is a high risk of hardware
> +=09 * lockups due to under-voltage for the selected CPU clock.
> +=09 *
> +=09 * Please note that the CPR-hardened gets set-up in Linux but
> +=09 * then gets actually used in firmware (and only by the OSM);
> +=09 * after handing it off we will have no more control on it,
> +=09 * hence the only way to get things up properly for sure here
> +=09 * is a write barrier.
> +=09 */
> +=09wmb();
> +
> +=09/* Enable the interface between OSM and CPRh */
> +=09cpr_masked_write(thread, drv->reg_ctl,
> +=09=09=09 CPRH_CTL_OSM_ENABLED,
> +=09=09=09 CPRH_CTL_OSM_ENABLED);
> +
> +=09/* On success, free cdata manually */
> +=09devm_kfree(drv->dev, cdata);
> +=09return 0;
> +}
> +
> +/**
> + * cpr3_init_parameters - Initialize CPR global parameters
> + * @drv: Main driver structure
> + *
> + * Initial "integrity" checks and setup for the thread-independent param=
eters.
> + *
> + * Returns: Zero for success, negative number on error
> + */
> +static int cpr3_init_parameters(struct cpr_drv *drv)
> +{
> +=09const struct cpr_desc *desc =3D drv->desc;
> +=09struct clk *clk;
> +
> +=09clk =3D devm_clk_get(drv->dev, "ref");
> +=09if (IS_ERR(clk))
> +=09=09return PTR_ERR(clk);
> +
> +=09drv->ref_clk_khz =3D clk_get_rate(clk);
> +=09do_div(drv->ref_clk_khz, 1000);
> +
> +=09/* On CPRh this clock is not always-on... */
> +=09if (desc->cpr_type =3D=3D CTRL_TYPE_CPRH)
> +=09=09clk_prepare_enable(clk);
> +=09else
> +=09=09devm_clk_put(drv->dev, clk);
> +
> +=09if (desc->timer_cons_up > CPR3_THRESH_CONS_UP_MASK ||
> +=09    desc->timer_cons_down > CPR3_THRESH_CONS_DOWN_MASK ||
> +=09    desc->up_threshold > CPR3_THRESH_UP_THRESH_MASK ||
> +=09    desc->down_threshold > CPR3_THRESH_DOWN_THRESH_MASK ||
> +=09    desc->idle_clocks > CPR3_CPR_CTL_IDLE_CLOCKS_MASK ||
> +=09    desc->count_mode > CPR3_CPR_CTL_COUNT_MODE_MASK ||
> +=09    desc->count_repeat > CPR3_CPR_CTL_COUNT_REPEAT_MASK)
> +=09=09return -EINVAL;
> +
> +=09/*
> +=09 * Read the CPR version register only from CPR3 onwards:
> +=09 * this is needed to get the additional register offsets.
> +=09 *
> +=09 * Note: When threaded, even if multi-controller, there
> +=09 *       is no chance to have different versions at the
> +=09 *       same time in the same domain, so it is safe to
> +=09 *       check this only on the first controller/thread.
> +=09 */
> +=09drv->cpr_hw_rev =3D cpr_read(&drv->threads[0],
> +=09=09=09=09   CPR3_REG_CPR_VERSION);
> +=09dev_dbg(drv->dev,
> +=09=09"CPR hardware revision: 0x%x\n", drv->cpr_hw_rev);
> +
> +=09if (drv->cpr_hw_rev >=3D CPRH_CPR_VERSION_4P5) {
> +=09=09drv->reg_corner =3D 0x3500;
> +=09=09drv->reg_corner_tid =3D 0xa0;
> +=09=09drv->reg_ctl =3D 0x3a80;
> +=09=09drv->reg_status =3D 0x3a84;
> +=09} else {
> +=09=09drv->reg_corner =3D 0x3a00;
> +=09=09drv->reg_corner_tid =3D 0;
> +=09=09drv->reg_ctl =3D 0x3aa0;
> +=09=09drv->reg_status =3D 0x3aa4;
> +=09}
> +
> +=09dev_dbg(drv->dev, "up threshold =3D %u, down threshold =3D %u\n",
> +=09=09desc->up_threshold, desc->down_threshold);
> +
> +=09return 0;
> +}
> +
> +/**
> + * cpr3_find_initial_corner - Finds boot-up p-state and enables CPR
> + * @thread: Structure holding CPR thread-specific parameters
> + *
> + * Differently from CPRv1, from CPRv3 onwards when we successfully find
> + * the target boot-up performance state, we must refresh the HW
> + * immediately to guarantee system stability and to avoid overheating
> + * during the boot process, thing that would more likely happen without
> + * this driver doing its job.
> + *
> + * Returns: Zero for success, negative number on error
> + */
> +static int cpr3_find_initial_corner(struct cpr_thread *thread)
> +{
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09struct corner *corner;
> +=09int uV, idx;
> +
> +=09idx =3D cpr_find_initial_corner(drv->dev, thread->cpu_clk,
> +=09=09=09=09      thread->corners,
> +=09=09=09=09      thread->num_corners);
> +=09if (idx < 0)
> +=09=09return idx;
> +
> +=09cpr_ctl_disable(thread);
> +
> +=09corner =3D &thread->corners[idx];
> +=09cpr_corner_restore(thread, corner);
> +
> +=09uV =3D regulator_get_voltage(drv->vreg);
> +=09uV =3D clamp(uV, corner->min_uV, corner->max_uV);
> +
> +=09corner->last_uV =3D uV;
> +=09if (!drv->last_uV)
> +=09=09drv->last_uV =3D uV;
> +
> +=09cpr_commit_state(thread);
> +=09thread->enabled =3D true;
> +=09cpr_switch(drv);
> +
> +=09return 0;
> +}
> +
> +static const int msm8998_gold_scaling_factor[][CPR3_RO_COUNT] =3D {
> +=09/* Fuse Corner 0 */
> +=09{
> +=09=092857, 3057, 2828, 2952, 2699, 2798, 2446, 2631,
> +=09=092629, 2578, 2244, 3344, 3289, 3137, 3164, 2655
> +=09},
> +=09/* Fuse Corner 1 */
> +=09{
> +=09=092857, 3057, 2828, 2952, 2699, 2798, 2446, 2631,
> +=09=092629, 2578, 2244, 3344, 3289, 3137, 3164, 2655
> +=09},
> +=09/* Fuse Corner 2 */
> +=09{
> +=09=092603, 2755, 2676, 2777, 2573, 2685, 2465, 2610,
> +=09=092312, 2423, 2243, 3104, 3022, 3036, 2740, 2303
> +=09},
> +=09/* Fuse Corner 3 */
> +=09{
> +=09=091901, 2016, 2096, 2228, 2034, 2161, 2077, 2188,
> +=09=091565, 1870, 1925, 2235, 2205, 2413, 1762, 1478
> +=09}
> +};
> +
> +static const int msm8998_silver_scaling_factor[][CPR3_RO_COUNT] =3D {
> +=09/* Fuse Corner 0 */
> +=09{
> +=09=092595, 2794, 2577, 2762, 2471, 2674, 2199, 2553,
> +=09=093189, 3255, 3192, 2962, 3054, 2982, 2042, 2945
> +=09},
> +=09/* Fuse Corner 1 */
> +=09{
> +=09=092595, 2794, 2577, 2762, 2471, 2674, 2199, 2553,
> +=09=093189, 3255, 3192, 2962, 3054, 2982, 2042, 2945
> +=09},
> +=09/* Fuse Corner 2 */
> +=09{
> +=09=092391, 2550, 2483, 2638, 2382, 2564, 2259, 2555,
> +=09=092766, 3041, 2988, 2935, 2873, 2688, 2013, 2784
> +=09},
> +=09/* Fuse Corner 3 */
> +=09{
> +=09=092066, 2153, 2300, 2434, 2220, 2386, 2288, 2465,
> +=09=092028, 2511, 2487, 2734, 2554, 2117, 1892, 2377
> +=09}
> +};
> +
> +static const struct cpr_thread_desc msm8998_thread_gold =3D {
> +=09.controller_id =3D 1,
> +=09.hw_tid =3D 0,
> +=09.ro_scaling_factor =3D msm8998_gold_scaling_factor,
> +=09.ro_avail_corners =3D ARRAY_SIZE(msm8998_gold_scaling_factor),
> +=09.sensor_range_start =3D 0,
> +=09.sensor_range_end =3D 9,
> +=09.init_voltage_step =3D 10000,
> +=09.init_voltage_width =3D 6,
> +=09.step_quot_init_min =3D 9,
> +=09.step_quot_init_max =3D 14,
> +=09.num_fuse_corners =3D 4,
> +=09.fuse_corner_data =3D (struct fuse_corner_data[]){
> +=09=09/* fuse corner 0 */
> +=09=09{
> +=09=09=09.ref_uV =3D 756000,
> +=09=09=09.max_uV =3D 828000,
> +=09=09=09.min_uV =3D 568000,
> +=09=09=09.range_uV =3D 32000,
> +=09=09=09.volt_cloop_adjust =3D 0,
> +=09=09=09.volt_oloop_adjust =3D 8000,
> +=09=09=09.max_volt_scale =3D 4,
> +=09=09=09.max_quot_scale =3D 10,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,

Where do you get the values starting from max_volt_scale from?

> +=09=09},
> +=09=09/* fuse corner 1 */
> +=09=09{
> +=09=09=09.ref_uV =3D 756000,
> +=09=09=09.max_uV =3D 900000,
> +=09=09=09.min_uV =3D 624000,
> +=09=09=09.range_uV =3D 32000,
> +=09=09=09.volt_cloop_adjust =3D 0,
> +=09=09=09.volt_oloop_adjust =3D 0,
> +=09=09=09.max_volt_scale =3D 320,
> +=09=09=09.max_quot_scale =3D 350,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 2 */
> +=09=09{
> +=09=09=09.ref_uV =3D 828000,
> +=09=09=09.max_uV =3D 952000,
> +=09=09=09.min_uV =3D 632000,
> +=09=09=09.range_uV =3D 32000,
> +=09=09=09.volt_cloop_adjust =3D 12000,
> +=09=09=09.volt_oloop_adjust =3D 12000,
> +=09=09=09.max_volt_scale =3D 620,
> +=09=09=09.max_quot_scale =3D 750,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 3 */
> +=09=09{
> +=09=09=09.ref_uV =3D 1056000,
> +=09=09=09.max_uV =3D 1136000,
> +=09=09=09.min_uV =3D 772000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D 50000,
> +=09=09=09.volt_oloop_adjust =3D 52000,
> +=09=09=09.max_volt_scale =3D 580,
> +=09=09=09.max_quot_scale =3D 1040,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09},
> +};
> +
> +static const struct cpr_thread_desc msm8998_thread_silver =3D {
> +=09.controller_id =3D 0,
> +=09.hw_tid =3D 0,
> +=09.ro_scaling_factor =3D msm8998_silver_scaling_factor,
> +=09.ro_avail_corners =3D ARRAY_SIZE(msm8998_silver_scaling_factor),
> +=09.sensor_range_start =3D 0,
> +=09.sensor_range_end =3D 6,
> +=09.init_voltage_step =3D 10000,
> +=09.init_voltage_width =3D 6,
> +=09.step_quot_init_min =3D 11,
> +=09.step_quot_init_max =3D 12,
> +=09.num_fuse_corners =3D 4,
> +=09.fuse_corner_data =3D (struct fuse_corner_data[]){
> +=09=09/* fuse corner 0 */
> +=09=09{
> +=09=09=09.ref_uV =3D 688000,
> +=09=09=09.max_uV =3D 828000,
> +=09=09=09.min_uV =3D 568000,
> +=09=09=09.range_uV =3D 32000,
> +=09=09=09.volt_cloop_adjust =3D 20000,
> +=09=09=09.volt_oloop_adjust =3D 40000,
> +=09=09=09.max_volt_scale =3D 4,
> +=09=09=09.max_quot_scale =3D 10,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 1 */
> +=09=09{
> +=09=09=09.ref_uV =3D 756000,
> +=09=09=09.max_uV =3D 900000,
> +=09=09=09.min_uV =3D 632000,
> +=09=09=09.range_uV =3D 32000,
> +=09=09=09.volt_cloop_adjust =3D 26000,
> +=09=09=09.volt_oloop_adjust =3D 24000,
> +=09=09=09.max_volt_scale =3D 500,
> +=09=09=09.max_quot_scale =3D 800,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 2 */
> +=09=09{
> +=09=09=09.ref_uV =3D 828000,
> +=09=09=09.max_uV =3D 952000,
> +=09=09=09.min_uV =3D 664000,
> +=09=09=09.range_uV =3D 32000,
> +=09=09=09.volt_cloop_adjust =3D 12000,
> +=09=09=09.volt_oloop_adjust =3D 12000,
> +=09=09=09.max_volt_scale =3D 280,
> +=09=09=09.max_quot_scale =3D 650,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +
> +=09=09},
> +=09=09/* fuse corner 3 */
> +=09=09{
> +=09=09=09.ref_uV =3D 1056000,
> +=09=09=09.max_uV =3D 1056000,
> +=09=09=09.min_uV =3D 772000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D 30000,
> +=09=09=09.volt_oloop_adjust =3D 30000,
> +=09=09=09.max_volt_scale =3D 430,
> +=09=09=09.max_quot_scale =3D 800,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09},
> +};
> +
> +static const struct cpr_desc msm8998_cpr_desc =3D {
> +=09.cpr_type =3D CTRL_TYPE_CPRH,
> +=09.num_threads =3D 2,
> +=09.mem_acc_threshold =3D 852000,
> +=09.apm_threshold =3D 800000,
> +=09.apm_crossover =3D 880000,
> +=09.apm_hysteresis =3D 0,
> +=09.cpr_base_voltage =3D 352000,
> +=09.cpr_max_voltage =3D 1200000,
> +=09.timer_delay_us =3D 5000,
> +=09.timer_cons_up =3D 0,
> +=09.timer_cons_down =3D 2,
> +=09.up_threshold =3D 2,
> +=09.down_threshold =3D 2,
> +=09.idle_clocks =3D 15,
> +=09.count_mode =3D CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN,
> +=09.count_repeat =3D 14,
> +=09.gcnt_us =3D 1,
> +=09.vreg_step_fixed =3D 4000,
> +=09.vreg_step_up_limit =3D 1,
> +=09.vreg_step_down_limit =3D 1,
> +=09.vdd_settle_time_us =3D 34,
> +=09.corner_settle_time_us =3D 6,
> +=09.reduce_to_corner_uV =3D true,
> +=09.hw_closed_loop_en =3D true,
> +=09.threads =3D (const struct cpr_thread_desc *[]) {
> +=09=09&msm8998_thread_silver,
> +=09=09&msm8998_thread_gold,
> +=09},
> +};
> +
> +static const struct cpr_acc_desc msm8998_cpr_acc_desc =3D {
> +=09.cpr_desc =3D &msm8998_cpr_desc,
> +};
> +
> +static const int sdm630_gold_scaling_factor[][CPR3_RO_COUNT] =3D {
> +=09/* Same RO factors for all fuse corners */
> +=09{
> +=09=094040, 3230,    0, 2210, 2560, 2450, 2230, 2220,
> +=09=092410, 2300, 2560, 2470, 1600, 3120, 2620, 2280
> +=09}
> +};
> +
> +static const int sdm630_silver_scaling_factor[][CPR3_RO_COUNT] =3D {
> +=09/* Same RO factors for all fuse corners */
> +=09{
> +=09=093600, 3600, 3830, 2430, 2520, 2700, 1790, 1760,
> +=09=091970, 1880, 2110, 2010, 2510, 4900, 4370, 4780,
> +=09}
> +};
> +
> +static const struct cpr_thread_desc sdm630_thread_gold =3D {
> +=09.controller_id =3D 0,
> +=09.hw_tid =3D 0,
> +=09.ro_scaling_factor =3D sdm630_gold_scaling_factor,
> +=09.ro_avail_corners =3D ARRAY_SIZE(sdm630_gold_scaling_factor),
> +=09.sensor_range_start =3D 0,
> +=09.sensor_range_end =3D 6,
> +=09.init_voltage_step =3D 10000,
> +=09.init_voltage_width =3D 6,
> +=09.step_quot_init_min =3D 12,
> +=09.step_quot_init_max =3D 14,
> +=09.num_fuse_corners =3D 5,
> +=09.fuse_corner_data =3D (struct fuse_corner_data[]){
> +=09=09/* fuse corner 0 */
> +=09=09{
> +=09=09=09.ref_uV =3D 644000,
> +=09=09=09.max_uV =3D 724000,
> +=09=09=09.min_uV =3D 588000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 15000,
> +=09=09=09.max_volt_scale =3D 10,
> +=09=09=09.max_quot_scale =3D 300,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 1 */
> +=09=09{
> +=09=09=09.ref_uV =3D 788000,
> +=09=09=09.max_uV =3D 788000,
> +=09=09=09.min_uV =3D 652000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 5000,
> +=09=09=09.max_volt_scale =3D 320,
> +=09=09=09.max_quot_scale =3D 275,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 2 */
> +=09=09{
> +=09=09=09.ref_uV =3D 868000,
> +=09=09=09.max_uV =3D 868000,
> +=09=09=09.min_uV =3D 712000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 5000,
> +=09=09=09.max_volt_scale =3D 350,
> +=09=09=09.max_quot_scale =3D 800,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 3 */
> +=09=09{
> +=09=09=09.ref_uV =3D 988000,
> +=09=09=09.max_uV =3D 988000,
> +=09=09=09.min_uV =3D 784000,
> +=09=09=09.range_uV =3D 66000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 0,
> +=09=09=09.max_volt_scale =3D 868,
> +=09=09=09.max_quot_scale =3D 980,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 4 */
> +=09=09{
> +=09=09=09.ref_uV =3D 1068000,
> +=09=09=09.max_uV =3D 1068000,
> +=09=09=09.min_uV =3D 844000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 0,
> +=09=09=09.max_volt_scale =3D 868,
> +=09=09=09.max_quot_scale =3D 980,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09},
> +};
> +
> +static const struct cpr_thread_desc sdm630_thread_silver =3D {
> +=09.controller_id =3D 1,
> +=09.hw_tid =3D 0,
> +=09.ro_scaling_factor =3D sdm630_silver_scaling_factor,
> +=09.ro_avail_corners =3D ARRAY_SIZE(sdm630_silver_scaling_factor),
> +=09.sensor_range_start =3D 0,
> +=09.sensor_range_end =3D 6,
> +=09.init_voltage_step =3D 10000,
> +=09.init_voltage_width =3D 6,
> +=09.step_quot_init_min =3D 12,
> +=09.step_quot_init_max =3D 14,
> +=09.num_fuse_corners =3D 3,
> +=09.fuse_corner_data =3D (struct fuse_corner_data[]){
> +=09=09/* fuse corner 0 */
> +=09=09{
> +=09=09=09.ref_uV =3D 644000,
> +=09=09=09.max_uV =3D 724000,
> +=09=09=09.min_uV =3D 588000,
> +=09=09=09.range_uV =3D 32000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 0,
> +=09=09=09.max_volt_scale =3D 10,
> +=09=09=09.max_quot_scale =3D 360,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 1 */
> +=09=09{
> +=09=09=09.ref_uV =3D 788000,
> +=09=09=09.max_uV =3D 788000,
> +=09=09=09.min_uV =3D 652000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 0,
> +=09=09=09.max_volt_scale =3D 500,
> +=09=09=09.max_quot_scale =3D 550,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09=09/* fuse corner 2 */
> +=09=09{
> +=09=09=09.ref_uV =3D 1068000,
> +=09=09=09.max_uV =3D 1068000,
> +=09=09=09.min_uV =3D 800000,
> +=09=09=09.range_uV =3D 40000,
> +=09=09=09.volt_cloop_adjust =3D -30000,
> +=09=09=09.volt_oloop_adjust =3D 0,
> +=09=09=09.max_volt_scale =3D 2370,
> +=09=09=09.max_quot_scale =3D 550,
> +=09=09=09.quot_offset =3D 0,
> +=09=09=09.quot_scale =3D 1,
> +=09=09=09.quot_adjust =3D 0,
> +=09=09=09.quot_offset_scale =3D 5,
> +=09=09=09.quot_offset_adjust =3D 0,
> +=09=09},
> +=09},
> +};
> +
> +static const struct cpr_desc sdm630_cpr_desc =3D {
> +=09.cpr_type =3D CTRL_TYPE_CPRH,
> +=09.num_threads =3D 2,
> +=09.apm_threshold =3D 872000,
> +=09.apm_crossover =3D 872000,
> +=09.apm_hysteresis =3D 20000,
> +=09.cpr_base_voltage =3D 400000,
> +=09.cpr_max_voltage =3D 1300000,
> +=09.timer_delay_us =3D 5000,
> +=09.timer_cons_up =3D 0,
> +=09.timer_cons_down =3D 2,
> +=09.up_threshold =3D 2,
> +=09.down_threshold =3D 2,
> +=09.idle_clocks =3D 15,
> +=09.count_mode =3D CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN,
> +=09.count_repeat =3D 14,
> +=09.gcnt_us =3D 1,
> +=09.vreg_step_fixed =3D 4000,
> +=09.vreg_step_up_limit =3D 1,
> +=09.vreg_step_down_limit =3D 1,
> +=09.vdd_settle_time_us =3D 34,
> +=09.corner_settle_time_us =3D 5,
> +=09.reduce_to_corner_uV =3D true,
> +=09.hw_closed_loop_en =3D true,
> +=09.threads =3D (const struct cpr_thread_desc *[]) {
> +=09=09&sdm630_thread_gold,
> +=09=09&sdm630_thread_silver,
> +=09},
> +};
> +
> +static const struct cpr_acc_desc sdm630_cpr_acc_desc =3D {
> +=09.cpr_desc =3D &sdm630_cpr_desc,
> +};
> +
> +static unsigned int cpr_get_performance_state(struct generic_pm_domain *=
genpd,
> +=09=09=09=09=09      struct dev_pm_opp *opp)
> +{
> +=09return dev_pm_opp_get_level(opp);
> +}
> +
> +static int cpr_power_off(struct generic_pm_domain *domain)
> +{
> +=09struct cpr_thread *thread =3D container_of(domain, struct cpr_thread,=
 pd);
> +
> +=09return cpr_disable(thread);
> +}
> +
> +static int cpr_power_on(struct generic_pm_domain *domain)
> +{
> +=09struct cpr_thread *thread =3D container_of(domain, struct cpr_thread,=
 pd);
> +
> +=09return cpr_enable(thread);
> +}
> +
> +static void cpr_pd_detach_dev(struct generic_pm_domain *domain,
> +=09=09=09      struct device *dev)
> +{
> +=09struct cpr_thread *thread =3D container_of(domain, struct cpr_thread,=
 pd);
> +=09struct cpr_drv *drv =3D thread->drv;
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09dev_dbg(drv->dev, "detach callback for: %s\n", dev_name(dev));
> +=09thread->attached_cpu_dev =3D NULL;
> +
> +=09mutex_unlock(&drv->lock);
> +}
> +
> +static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
> +=09=09=09     struct device *dev)
> +{
> +=09struct cpr_thread *thread =3D container_of(domain, struct cpr_thread,=
 pd);
> +=09struct cpr_drv *drv =3D thread->drv;
> +=09const struct acc_desc *acc_desc =3D drv->acc_desc;
> +=09int ret =3D 0;
> +
> +=09mutex_lock(&drv->lock);
> +
> +=09dev_dbg(drv->dev, "attach callback for: %s\n", dev_name(dev));
> +
> +=09/*
> +=09 * This driver only supports scaling voltage for a CPU cluster
> +=09 * where all CPUs in the cluster share a single regulator.
> +=09 * Therefore, save the struct device pointer only for the first
> +=09 * CPU device that gets attached. There is no need to do any
> +=09 * additional initialization when further CPUs get attached.
> +=09 */
> +=09if (thread->attached_cpu_dev)
> +=09=09goto unlock;
> +
> +=09/*
> +=09 * cpr_scale_voltage() requires the direction (if we are changing
> +=09 * to a higher or lower OPP). The first time
> +=09 * cpr_set_performance_state() is called, there is no previous
> +=09 * performance state defined. Therefore, we call
> +=09 * cpr_find_initial_corner() that gets the CPU clock frequency
> +=09 * set by the bootloader, so that we can determine the direction
> +=09 * the first time cpr_set_performance_state() is called.
> +=09 */
> +=09thread->cpu_clk =3D devm_clk_get(dev, NULL);
> +=09if (drv->desc->cpr_type < CTRL_TYPE_CPRH &&
> +=09    IS_ERR(thread->cpu_clk)) {
> +=09=09ret =3D PTR_ERR(thread->cpu_clk);
> +=09=09if (ret !=3D -EPROBE_DEFER)
> +=09=09=09dev_err(drv->dev, "could not get cpu clk: %d\n", ret);
> +=09=09goto unlock;
> +=09}
> +=09thread->attached_cpu_dev =3D dev;
> +
> +=09dev_dbg(drv->dev, "using cpu clk from: %s\n",
> +=09=09dev_name(thread->attached_cpu_dev));
> +
> +=09/* Install the OPP table for external updates */
> +=09ret =3D dev_pm_opp_of_add_table(dev);
> +=09if (ret) {
> +=09=09dev_err(drv->dev, "Invalid OPP table in Device tree %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09/*
> +=09 * Everything related to (virtual) corners has to be initialized
> +=09 * here, when attaching to the power domain, since we need to know
> +=09 * the maximum frequency for each fuse corner, and this is only
> +=09 * available after the cpufreq driver has attached to us.
> +=09 * The reason for this is that we need to know the highest
> +=09 * frequency associated with each fuse corner.
> +=09 */
> +=09ret =3D dev_pm_opp_get_opp_count(&thread->pd.dev);
> +=09if (ret < 0) {
> +=09=09dev_err(drv->dev, "could not get OPP count\n");
> +=09=09thread->attached_cpu_dev =3D NULL;
> +=09=09goto remove_opps;
> +=09}
> +=09thread->num_corners =3D ret;
> +
> +=09thread->corners =3D devm_kcalloc(drv->dev,
> +=09=09=09=09       thread->num_corners +
> +=09=09=09=09       drv->extra_corners,
> +=09=09=09=09       sizeof(*thread->corners),
> +=09=09=09=09       GFP_KERNEL);
> +=09if (!thread->corners) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto remove_opps;
> +=09}
> +
> +=09ret =3D cpr3_corner_init(thread);
> +=09if (ret)
> +=09=09goto remove_opps;
> +
> +=09if (drv->desc->cpr_type < CTRL_TYPE_CPRH) {
> +=09=09ret =3D cpr3_find_initial_corner(thread);
> +=09=09if (ret)
> +=09=09=09goto remove_opps;
> +
> +=09=09if (acc_desc->config)
> +=09=09=09regmap_multi_reg_write(drv->tcsr, acc_desc->config,
> +=09=09=09=09=09       acc_desc->num_regs_per_fuse);
> +
> +=09=09/* Enable ACC if required */
> +=09=09if (acc_desc->enable_mask)
> +=09=09=09regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
> +=09=09=09=09=09   acc_desc->enable_mask,
> +=09=09=09=09=09   acc_desc->enable_mask);
> +=09}
> +=09dev_info(drv->dev, "thread %d initialized with %u OPPs\n",
> +=09=09 thread->id, thread->num_corners);
> +
> +remove_opps:
> +=09/*
> +=09 * If anything went wrong, remove all of the dynamic OPPs
> +=09 * that we have created during cpr3_corner_init to leave
> +=09 * everything in a clean state.
> +=09 */
> +=09if (ret)
> +=09=09dev_pm_opp_remove_all_dynamic(dev);
> +unlock:
> +=09mutex_unlock(&drv->lock);
> +
> +=09return ret;
> +}
> +
> +static int cpr3_debug_info_show(struct seq_file *s, void *unused)
> +{
> +=09u32 ro_sel, ctl, irq_status, reg, quot;
> +=09struct cpr_thread *thread =3D s->private;
> +=09struct corner *corner =3D thread->corners;
> +=09struct fuse_corner *fuse =3D thread->fuse_corners;
> +=09unsigned int i;
> +
> +=09const struct {
> +=09=09const char *name;
> +=09=09uint32_t mask;
> +=09=09uint8_t shift;
> +=09} result0_fields[] =3D {
> +=09=09{ "busy", 1, 0 },
> +=09=09{ "step_dn", 1, 1 },
> +=09=09{ "step_up", 1, 2 },
> +=09=09{ "error_steps", CPR3_RESULT0_ERROR_STEPS_MASK,
> +=09=09=09=09 CPR3_RESULT0_ERROR_STEPS_SHIFT },
> +=09=09{ "error", CPR3_RESULT0_ERROR_MASK, CPR3_RESULT0_ERROR_SHIFT },
> +=09=09{ "negative", 1, 20 },
> +=09}, result1_fields[] =3D {
> +=09=09{ "quot_min", CPR3_RESULT1_QUOT_MIN_MASK,
> +=09=09=09      CPR3_RESULT1_QUOT_MIN_SHIFT },
> +=09=09{ "quot_max", CPR3_RESULT1_QUOT_MAX_MASK,
> +=09=09=09      CPR3_RESULT1_QUOT_MAX_SHIFT },
> +=09=09{ "ro_min", CPR3_RESULT1_RO_MIN_MASK,
> +=09=09=09    CPR3_RESULT1_RO_MIN_SHIFT },
> +=09=09{ "ro_max", CPR3_RESULT1_RO_MAX_MASK,
> +=09=09=09    CPR3_RESULT1_RO_MAX_SHIFT },
> +=09}, result2_fields[] =3D {
> +=09=09{ "qout_step_min", CPR3_RESULT2_STEP_QUOT_MIN_MASK,
> +=09=09=09=09   CPR3_RESULT2_STEP_QUOT_MIN_SHIFT },
> +=09=09{ "qout_step_max", CPR3_RESULT2_STEP_QUOT_MAX_MASK,
> +=09=09=09=09   CPR3_RESULT2_STEP_QUOT_MAX_SHIFT },
> +=09=09{ "sensor_min", CPR3_RESULT2_SENSOR_MIN_MASK,
> +=09=09=09=09CPR3_RESULT2_SENSOR_MIN_SHIFT },
> +=09=09{ "sensor_max", CPR3_RESULT2_SENSOR_MAX_MASK,
> +=09=09=09=09CPR3_RESULT2_SENSOR_MAX_SHIFT },
> +=09};
> +
> +=09if (thread->drv->desc->cpr_type < CTRL_TYPE_CPRH)
> +=09=09seq_printf(s, "current_volt =3D %d uV\n", thread->drv->last_uV);
> +
> +=09irq_status =3D cpr_read(thread, CPR3_REG_IRQ_STATUS);
> +=09seq_printf(s, "irq_status =3D %#02X\n", irq_status);
> +
> +=09ctl =3D cpr_read(thread, CPR3_REG_CPR_CTL);
> +=09seq_printf(s, "cpr_ctl =3D %#02X\n", ctl);
> +
> +=09seq_printf(s, "thread %d - hw tid: %u - enabled: %d:\n",
> +=09=09   thread->id, thread->desc->hw_tid, thread->enabled);
> +=09seq_printf(s, "%d corners, derived from %d fuse corners\n",
> +=09=09   thread->num_corners, thread->desc->num_fuse_corners);
> +
> +=09for (i =3D 0; i < thread->num_corners; i++, corner++)
> +=09=09seq_printf(s, "corner %d - uV=3D[%d %d %d] quot=3D%d freq=3D%lu\n"=
,
> +=09=09=09   i, corner->min_uV, corner->uV, corner->max_uV,
> +=09=09=09   corner->quot_adjust, corner->freq);
> +
> +=09for (i =3D 0; i < thread->desc->num_fuse_corners; i++, fuse++)
> +=09=09seq_printf(s, "fuse %d - uV=3D[%d %d %d] quot=3D%d freq=3D%lu\n",
> +=09=09=09   i, fuse->min_uV, fuse->uV, fuse->max_uV,
> +=09=09=09   fuse->quot, corner->freq);
> +
> +=09seq_printf(s, "requested voltage: %d uV\n",
> +=09=09   thread->corner->last_uV);
> +
> +=09ro_sel =3D corner->fuse_corner->ring_osc_idx;
> +=09quot =3D cpr_read(thread, CPR3_REG_TARGET_QUOT(i, ro_sel));
> +=09seq_printf(s, "quot_target (%u) =3D %#02X\n", ro_sel, quot);
> +
> +=09reg =3D cpr_read(thread, CPR3_REG_RESULT0(i));
> +=09seq_printf(s, "cpr_result_0 =3D %#02X\n  [", reg);
> +=09for (i =3D 0; i < ARRAY_SIZE(result0_fields); i++)
> +=09=09seq_printf(s, "%s%s =3D %u",
> +=09=09=09   i ? ", " : "",
> +=09=09=09   result0_fields[i].name,
> +=09=09=09   (reg >> result0_fields[i].shift) &
> +=09=09=09=09result0_fields[i].mask);
> +=09seq_puts(s, "]\n");
> +=09reg =3D cpr_read(thread, CPR3_REG_RESULT1(i));
> +=09seq_printf(s, "cpr_result_1 =3D %#02X\n  [", reg);
> +=09for (i =3D 0; i < ARRAY_SIZE(result1_fields); i++)
> +=09=09seq_printf(s, "%s%s =3D %u",
> +=09=09=09   i ? ", " : "",
> +=09=09=09   result1_fields[i].name,
> +=09=09=09   (reg >> result1_fields[i].shift) &
> +=09=09=09=09result1_fields[i].mask);
> +=09seq_puts(s, "]\n");
> +=09reg =3D cpr_read(thread, CPR3_REG_RESULT2(i));
> +=09seq_printf(s, "cpr_result_2 =3D %#02X\n  [", reg);
> +=09for (i =3D 0; i < ARRAY_SIZE(result2_fields); i++)
> +=09=09seq_printf(s, "%s%s =3D %u",
> +=09=09=09   i ? ", " : "",
> +=09=09=09   result2_fields[i].name,
> +=09=09=09   (reg >> result2_fields[i].shift) &
> +=09=09=09=09result2_fields[i].mask);
> +=09seq_puts(s, "]\n");
> +
> +=09return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(cpr3_debug_info);
> +
> +static void cpr3_debugfs_init(struct cpr_drv *drv)
> +{
> +=09int i;
> +
> +=09drv->debugfs =3D debugfs_create_dir("qcom_cpr3", NULL);
> +
> +=09for (i =3D 0; i < drv->desc->num_threads; i++) {
> +=09=09char buf[50];
> +
> +=09=09snprintf(buf, sizeof(buf), "thread%d", i);
> +
> +=09=09debugfs_create_file(buf, 0444, drv->debugfs, &drv->threads[i],
> +=09=09=09=09    &cpr3_debug_info_fops);
> +=09}
> +}
> +
> +/**
> + * cpr_thread_init - Initialize CPR thread related parameters
> + * @drv: Main driver structure
> + * @tid: Thread ID
> + *
> + * Returns: Zero for success, negative number on error
> + */
> +static int cpr_thread_init(struct cpr_drv *drv, int tid)
> +{
> +=09const struct cpr_desc *desc =3D drv->desc;
> +=09const struct cpr_thread_desc *tdesc =3D desc->threads[tid];
> +=09struct cpr_thread *thread =3D &drv->threads[tid];
> +=09int ret;
> +
> +=09if (tdesc->step_quot_init_min > CPR3_CPR_STEP_QUOT_MIN_MASK ||
> +=09    tdesc->step_quot_init_max > CPR3_CPR_STEP_QUOT_MAX_MASK)
> +=09=09return -EINVAL;
> +
> +=09thread->id =3D tid;
> +=09thread->drv =3D drv;
> +=09thread->desc =3D tdesc;
> +=09thread->fuse_corners =3D devm_kcalloc(drv->dev,
> +=09=09=09=09=09    tdesc->num_fuse_corners +
> +=09=09=09=09=09    drv->extra_corners,
> +=09=09=09=09=09    sizeof(*thread->fuse_corners),
> +=09=09=09=09=09    GFP_KERNEL);
> +=09if (!thread->fuse_corners)
> +=09=09return -ENOMEM;
> +
> +=09thread->cpr_fuses =3D cpr_get_fuses(drv->dev, tid,
> +=09=09=09=09=09  tdesc->num_fuse_corners);
> +=09if (IS_ERR(thread->cpr_fuses))
> +=09=09return PTR_ERR(thread->cpr_fuses);
> +
> +=09ret =3D cpr_populate_ring_osc_idx(thread->drv->dev, thread->fuse_corn=
ers,
> +=09=09=09=09=09thread->cpr_fuses,
> +=09=09=09=09=09tdesc->num_fuse_corners);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D cpr_fuse_corner_init(thread);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09thread->pd.name =3D devm_kasprintf(drv->dev, GFP_KERNEL,
> +=09=09=09=09=09 "%s_thread%d",
> +=09=09=09=09=09 drv->dev->of_node->full_name,
> +=09=09=09=09=09 thread->id);
> +=09if (!thread->pd.name)
> +=09=09return -EINVAL;
> +
> +=09thread->pd.power_off =3D cpr_power_off;
> +=09thread->pd.power_on =3D cpr_power_on;
> +=09thread->pd.set_performance_state =3D cpr_set_performance_state;
> +=09thread->pd.opp_to_performance_state =3D cpr_get_performance_state;
> +=09thread->pd.attach_dev =3D cpr_pd_attach_dev;
> +=09thread->pd.detach_dev =3D cpr_pd_detach_dev;
> +
> +=09/* Anything later than CPR1 must be always-on for now */
> +=09thread->pd.flags =3D GENPD_FLAG_ALWAYS_ON;
> +
> +=09drv->cell_data.domains[tid] =3D &thread->pd;
> +
> +=09ret =3D pm_genpd_init(&thread->pd, NULL, false);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* On CPRhardened, the interrupts are managed in firmware */
> +=09if (desc->cpr_type < CTRL_TYPE_CPRH) {
> +=09=09INIT_WORK(&thread->restart_work, cpr_restart_worker);
> +
> +=09=09ret =3D devm_request_threaded_irq(drv->dev, drv->irq,
> +=09=09=09=09=09=09NULL, cpr_irq_handler,
> +=09=09=09=09=09=09IRQF_ONESHOT |
> +=09=09=09=09=09=09IRQF_TRIGGER_RISING,
> +=09=09=09=09=09=09"cpr", drv);
> +=09=09if (ret)
> +=09=09=09return ret;

There's only one IRQ here, so this returns -EBUSY when the second thread ge=
ts
initialized and re-requests the IRQ. This should be moved to cpr_probe().

> +=09}
> +
> +=09return 0;
> +}
> +
> +/**
> + * cpr3_resources_init - Initialize resources used by this driver
> + * @pdev: Platform device
> + * @drv:  Main driver structure
> + *
> + * Returns: Zero for success, negative number on error
> + */
> +static int cpr3_resources_init(struct platform_device *pdev,
> +=09=09=09       struct cpr_drv *drv)
> +{
> +=09const struct cpr_desc *desc =3D drv->desc;
> +=09struct cpr_thread *threads =3D drv->threads;
> +=09unsigned int i;
> +=09u8 cid_mask =3D 0;
> +
> +=09/*
> +=09 * Here, we are accounting for the following usecases:
> +=09 * - One controller
> +=09 *   - One or multiple threads on the same iospace
> +=09 *
> +=09 * - Multiple controllers
> +=09 *   - Each controller has its own iospace and each
> +=09 *     may have one or multiple threads in their
> +=09 *     parent controller's iospace
> +=09 *
> +=09 * Then, to avoid complicating the code for no reason,
> +=09 * this also needs a mandatory order in the list of
> +=09 * threads which implies that all of them from the same
> +=09 * controllers are specified sequentially. As an example:
> +=09 *
> +=09 *      C0-T0, C0-T1...C0-Tn, C1-T0, C1-T1...C1-Tn
> +=09 */
> +=09for (i =3D 0; i < desc->num_threads; i++) {
> +=09=09u8 cid =3D desc->threads[i]->controller_id;
> +
> +=09=09if (cid_mask & BIT(cid)) {
> +=09=09=09if (desc->threads[i - 1]->controller_id !=3D cid) {
> +=09=09=09=09dev_err(drv->dev,
> +=09=09=09=09=09"Bad threads order. Please fix!\n");
> +=09=09=09=09return -EINVAL;
> +=09=09=09}
> +=09=09=09threads[i].base =3D threads[i - 1].base;
> +=09=09=09continue;
> +=09=09}
> +=09=09threads[i].base =3D devm_platform_ioremap_resource(pdev, cid);
> +=09=09if (IS_ERR(threads[i].base))
> +=09=09=09return PTR_ERR(threads[i].base);
> +=09=09cid_mask |=3D BIT(cid);
> +=09}
> +=09return 0;
> +}
> +
> +static int cpr_probe(struct platform_device *pdev)
> +{
> +=09struct device *dev =3D &pdev->dev;
> +=09struct cpr_drv *drv;
> +=09const struct cpr_desc *desc;
> +=09const struct cpr_acc_desc *data;
> +=09struct device_node *np;
> +=09unsigned int i;
> +=09int ret;
> +
> +=09data =3D of_device_get_match_data(dev);
> +=09if (!data || !data->cpr_desc)
> +=09=09return -EINVAL;
> +
> +=09desc =3D data->cpr_desc;
> +
> +=09/* CPRh disallows MEM-ACC access from the HLOS */
> +=09if (!data->acc_desc && desc->cpr_type < CTRL_TYPE_CPRH)
> +=09=09return -EINVAL;
> +
> +=09drv =3D devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +=09if (!drv)
> +=09=09return -ENOMEM;
> +
> +=09drv->dev =3D dev;
> +=09drv->desc =3D desc;
> +=09drv->threads =3D devm_kcalloc(dev, desc->num_threads,
> +=09=09=09=09    sizeof(*drv->threads), GFP_KERNEL);
> +=09if (!drv->threads)
> +=09=09return -ENOMEM;
> +
> +=09drv->cell_data.num_domains =3D desc->num_threads;
> +=09drv->cell_data.domains =3D devm_kcalloc(drv->dev,
> +=09=09=09=09=09      drv->cell_data.num_domains,
> +=09=09=09=09=09      sizeof(*drv->cell_data.domains),
> +=09=09=09=09=09      GFP_KERNEL);
> +=09if (!drv->cell_data.domains)
> +=09=09return -ENOMEM;
> +
> +=09if (data->acc_desc)
> +=09=09drv->acc_desc =3D data->acc_desc;
> +
> +=09mutex_init(&drv->lock);
> +
> +=09if (desc->cpr_type < CTRL_TYPE_CPRH) {
> +=09=09np =3D of_parse_phandle(dev->of_node, "acc-syscon", 0);
> +=09=09if (!np)
> +=09=09=09return -ENODEV;
> +
> +=09=09drv->tcsr =3D syscon_node_to_regmap(np);
> +=09=09of_node_put(np);
> +=09=09if (IS_ERR(drv->tcsr))
> +=09=09=09return PTR_ERR(drv->tcsr);
> +=09}
> +
> +=09ret =3D cpr3_resources_init(pdev, drv);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09drv->irq =3D platform_get_irq_optional(pdev, 0);
> +=09if ((desc->cpr_type !=3D CTRL_TYPE_CPRH) && (drv->irq < 0))
> +=09=09return -EINVAL;
> +
> +=09/* On CPRhardened, vreg access it not allowed */
> +=09drv->vreg =3D devm_regulator_get_optional(dev, "vdd");
> +=09if (desc->cpr_type !=3D CTRL_TYPE_CPRH && IS_ERR(drv->vreg))
> +=09=09return PTR_ERR(drv->vreg);
> +
> +=09/*
> +=09 * On at least CPRhardened, vreg is unaccessible and there is no
> +=09 * way to read linear step from that regulator, hence it is hardcoded
> +=09 * in the driver;
> +=09 * When the vreg_step is not declared in the cpr data (or is zero),
> +=09 * then having access to the vreg regulator is mandatory, as this
> +=09 * will be retrieved through the regulator API.
> +=09 */
> +=09if (desc->vreg_step_fixed)
> +=09=09drv->vreg_step =3D desc->vreg_step_fixed;
> +=09else
> +=09=09drv->vreg_step =3D regulator_get_linear_step(drv->vreg);
> +
> +=09if (!drv->vreg_step)
> +=09=09return -EINVAL;
> +
> +=09/*
> +=09 * Initialize fuse corners, since it simply depends
> +=09 * on data in efuses.
> +=09 * Everything related to (virtual) corners has to be
> +=09 * initialized after attaching to the power domain,
> +=09 * since it depends on the CPU's OPP table.
> +=09 */
> +=09ret =3D cpr_read_efuse(dev, "cpr_fuse_revision", &drv->fusing_rev);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D cpr_read_efuse(dev, "cpr_speed_bin", &drv->speed_bin);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/*
> +=09 * Some SoCs require extra corners for MEM-ACC or APM: if
> +=09 * the related parameters have been specified, then reserve
> +=09 * a corner for the APM and/or MEM-ACC crossover, used by
> +=09 * OSM and CPRh HW to set the supply voltage during the APM
> +=09 * and/or MEM-ACC switch routine.
> +=09 */
> +=09if (desc->cpr_type =3D=3D CTRL_TYPE_CPRH) {
> +=09=09if (desc->apm_crossover && desc->apm_hysteresis >=3D 0)
> +=09=09=09drv->extra_corners++;
> +
> +=09=09if (desc->mem_acc_threshold)
> +=09=09=09drv->extra_corners++;
> +=09}
> +
> +=09/* Initialize all threads */
> +=09for (i =3D 0; i < desc->num_threads; i++) {
> +=09=09ret =3D cpr_thread_init(drv, i);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09/* Initialize global parameters */
> +=09ret =3D cpr3_init_parameters(drv);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Write initial configuration on all threads */
> +=09for (i =3D 0; i < desc->num_threads; i++) {
> +=09=09ret =3D cpr_configure(&drv->threads[i]);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09ret =3D of_genpd_add_provider_onecell(dev->of_node, &drv->cell_data);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09platform_set_drvdata(pdev, drv);
> +=09cpr3_debugfs_init(drv);
> +
> +=09return 0;
> +}
> +
> +static int cpr_remove(struct platform_device *pdev)
> +{
> +=09struct cpr_drv *drv =3D platform_get_drvdata(pdev);
> +=09int i;
> +
> +=09of_genpd_del_provider(pdev->dev.of_node);
> +
> +=09for (i =3D 0; i < drv->desc->num_threads; i++) {
> +=09=09cpr_ctl_disable(&drv->threads[i]);
> +=09=09cpr_irq_set(&drv->threads[i], 0);
> +=09=09pm_genpd_remove(&drv->threads[i].pd);
> +=09}
> +
> +=09debugfs_remove_recursive(drv->debugfs);
> +
> +=09return 0;
> +}
> +
> +static const struct of_device_id cpr3_match_table[] =3D {
> +=09{ .compatible =3D "qcom,msm8998-cprh", .data =3D &msm8998_cpr_acc_des=
c },
> +=09{ .compatible =3D "qcom,sdm630-cprh", .data =3D &sdm630_cpr_acc_desc =
},
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(of, cpr3_match_table);
> +
> +static struct platform_driver cpr3_driver =3D {
> +=09.probe=09=09=3D cpr_probe,
> +=09.remove=09=09=3D cpr_remove,
> +=09.driver=09=09=3D {
> +=09=09.name=09=3D "qcom-cpr3",
> +=09=09.of_match_table =3D cpr3_match_table,
> +=09},
> +};
> +module_platform_driver(cpr3_driver)
> +
> +MODULE_DESCRIPTION("Core Power Reduction (CPR) v3/v4 driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.30.0
>
>

Regards,
Yassine
