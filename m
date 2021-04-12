Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99F35C62B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbhDLMZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbhDLMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:25:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2041DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:25:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y204so5297134wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kkv9CDoo4yKuYtV2qePKbAhCHZuQHZmxU5/IB+rmDOI=;
        b=HROijH8ayPEWN/Rss10jBs9PnnnGzkZgp/DcZRh5L9xosxfqlznQP0bV69gRFakIbl
         KwgjHmKm+izgQ6lREnLrIEsBlyupsFIlenZwJTV716SY/4QEOrnKdlvzQSurYYc9bp9q
         8B5khl5mtPNEVMUmtB9utNjQXL5xh2eEgkikAchtOBJIm0OL184ygBwTbVEMO6foEfRv
         YnxlCOI4AVXQtyW9KV/HzkrHv5GfG5uWlawkZPg7B/TE73/mYfZc3aARiYx76DxvwWZM
         3lrLyMRluwgi2Om+KFH24LGmpVVWkfmGtessyzNLDjkakQZvaJD6mFqivbt1vqXqWe03
         ulSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kkv9CDoo4yKuYtV2qePKbAhCHZuQHZmxU5/IB+rmDOI=;
        b=TIq1/BIviGfGKygjyDRav4NHIfF9AmRVLSfpHZZoYQJAV2oiXygcjSFUFDkgF34AXu
         8Vi9PVNBv6HFTh6Jk+FCOZxWZUhGl1hqNc/skH3hDSbooCDlCWfBbHjHSL3V1ACgiTjn
         BV6bCtAAG3RtRihvjA75rtCUVxD3p8vxCQSOzQ38i9F1ZdnDn4ATw3UiG7QPd74Y/bMn
         m1Xs45r08nnYy0MprO1ftbvVe/1CWbhY9BHYdUKB8V++0nnHQWOGL8IpoUSF2cYS4Fy3
         6dANTL5Hhl2AMGLNvXwQqviXK8oLLiv0X2psatI/WXxP1GpcpmnR/qGZ2QgSW2bcmn/d
         SzmQ==
X-Gm-Message-State: AOAM531DTpSwbECSwxMZlLu5D2/woPLAfUEM4YCd6qKD1CgIDUAz8ex3
        o+/jSWQ9Z5Dz+Ccq9iPmGhotXNcoYWlJFY74bMho5w==
X-Google-Smtp-Source: ABdhPJyrw0OtL3xeTihskKKXadewNKwtl/ilKG15N+zKti/fq+1t55RZE0Iy3XoNBH1FdgLkFwewMmYEiAq1A0pXybI=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr15006408wmc.31.1618230312733;
 Mon, 12 Apr 2021 05:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210409103722.26290-1-mike.leach@linaro.org> <20210409103722.26290-8-mike.leach@linaro.org>
 <97d53224-0749-086b-b2b4-12c91ec8ad5a@arm.com> <CAJ9a7Vh23-nFNRdQQZY4s4fGD8xhnE+PQUAE0US8fpsr-ZnsRQ@mail.gmail.com>
In-Reply-To: <CAJ9a7Vh23-nFNRdQQZY4s4fGD8xhnE+PQUAE0US8fpsr-ZnsRQ@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 12 Apr 2021 13:25:01 +0100
Message-ID: <CAJ9a7VjE3qy9ir=NdHp4_yMn79GnjXZ8w-QW0yQ5T_3WOeXGLw@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] coresight: etm4x: Add complex configuration
 handlers to etmv4
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Yabin Cui <yabinc@google.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Suzuki

OK - realized that this is an aarch32 kernel thing on closer
inspection of the kernel test robot info.  Now have a reproducer so
can fix

Thanks

Mike

On Mon, 12 Apr 2021 at 12:29, Mike Leach <mike.leach@linaro.org> wrote:
>
> HI Suzuki,
>
> On Mon, 12 Apr 2021 at 11:28, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
> > On 09/04/2021 11:37, Mike Leach wrote:
> > > Adds in handlers to allow the ETMv4 to use the complex configuration
> > > support. Features and configurations can be loaded and selected in the
> > > device.
> > >
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >   drivers/hwtracing/coresight/Makefile          |   3 +-
> > >   .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++++++++++++++++
> > >   .../hwtracing/coresight/coresight-etm4x-cfg.h |  15 ++
> > >   .../coresight/coresight-etm4x-core.c          |  38 +++-
> > >   .../coresight/coresight-etm4x-sysfs.c         |   3 +
> > >   5 files changed, 238 insertions(+), 3 deletions(-)
> > >   create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > >   create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> > >
> > > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > > index 63ecfc3cf66d..9420d33b23ac 100644
> > > --- a/drivers/hwtracing/coresight/Makefile
> > > +++ b/drivers/hwtracing/coresight/Makefile
> > > @@ -16,7 +16,8 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
> > >   coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
> > >                    coresight-etm3x-sysfs.o
> > >   obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
> > > -coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
> > > +coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o \
> > > +                     coresight-etm4x-cfg.o
> > >   obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
> > >   obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> > >   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > > new file mode 100644
> > > index 000000000000..d2ea903231b2
> > > --- /dev/null
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > > @@ -0,0 +1,182 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright(C) 2020 Linaro Limited. All rights reserved.
> > > + * Author: Mike Leach <mike.leach@linaro.org>
> > > + */
> > > +
> >
> > > +#include "coresight-etm4x.h"
> > > +#include "coresight-etm4x-cfg.h"
> > > +#include "coresight-priv.h"
> > > +#include "coresight-syscfg.h"
> > > +
> > > +/* defines to associate register IDs with driver data locations */
> > > +#define CHECKREG(cval, elem) \
> > > +     { \
> > > +             if (offset == cval) { \
> > > +                     reg_csdev->driver_regval = &drvcfg->elem; \
> > > +                     err = 0; \
> > > +                     break; \
> > > +             } \
> > > +     }
> > > +
> > > +#define CHECKREGIDX(cval, elem, off_idx, mask)       \
> > > +     { \
> > > +             if (mask == cval) { \
> > > +                     reg_csdev->driver_regval = &drvcfg->elem[off_idx]; \
> > > +                     err = 0; \
> > > +                     break; \
> > > +             } \
> > > +     }
> > > +
> > > +/**
> > > + * etm4_cfg_map_reg_offset - validate and map the register offset into a
> > > + *                        location in the driver config struct.
> > > + *
> > > + * Limits the number of registers that can be accessed and programmed in
> > > + * features, to those which are used to control the trace capture parameters.
> > > + *
> > > + * Omits or limits access to those which the driver must use exclusively.
> > > + *
> > > + * Invalid offsets will result in fail code return and feature load failure.
> > > + *
> > > + * @drvdata: driver data to map into.
> > > + * @reg:     register to map.
> > > + * @offset:  device offset for the register
> > > + */
> > > +static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
> > > +                                struct cscfg_regval_csdev *reg_csdev, u32 offset)
> > > +{
> > > +     int err = -EINVAL, idx;
> > > +     struct etmv4_config *drvcfg = &drvdata->config;
> > > +     u32 off_mask;
> > > +
> > > +     if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
> > > +         ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
> > > +         ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
> > > +             do {
> > > +                     CHECKREG(TRCEVENTCTL0R, eventctrl0);
> > > +                     CHECKREG(TRCEVENTCTL1R, eventctrl1);
> > > +                     CHECKREG(TRCSTALLCTLR, stall_ctrl);
> > > +                     CHECKREG(TRCTSCTLR, ts_ctrl);
> > > +                     CHECKREG(TRCSYNCPR, syncfreq);
> > > +                     CHECKREG(TRCCCCTLR, ccctlr);
> > > +                     CHECKREG(TRCBBCTLR, bb_ctrl);
> > > +                     CHECKREG(TRCVICTLR, vinst_ctrl);
> > > +                     CHECKREG(TRCVIIECTLR, viiectlr);
> > > +                     CHECKREG(TRCVISSCTLR, vissctlr);
> > > +                     CHECKREG(TRCVIPCSSCTLR, vipcssctlr);
> > > +                     CHECKREG(TRCSEQRSTEVR, seq_rst);
> > > +                     CHECKREG(TRCSEQSTR, seq_state);
> > > +                     CHECKREG(TRCEXTINSELR, ext_inp);
> > > +                     CHECKREG(TRCCIDCCTLR0, ctxid_mask0);
> > > +                     CHECKREG(TRCCIDCCTLR1, ctxid_mask1);
> > > +                     CHECKREG(TRCVMIDCCTLR0, vmid_mask0);
> > > +                     CHECKREG(TRCVMIDCCTLR1, vmid_mask1);
> > > +             } while (0);
> > > +     } else if ((offset & GENMASK(11, 4)) == TRCSEQEVRn(0)) {
> > > +             /* sequencer state control registers */
> > > +             idx = (offset & GENMASK(3, 0)) / 4;
> > > +             if (idx < ETM_MAX_SEQ_STATES) {
> > > +                     reg_csdev->driver_regval = &drvcfg->seq_ctrl[idx];
> > > +                     err = 0;
> > > +             }
> > > +     } else if ((offset >= TRCSSCCRn(0)) && (offset <= TRCSSPCICRn(7))) {
> > > +             /* 32 bit, 8 off indexed register sets */
> > > +             idx = (offset & GENMASK(4, 0)) / 4;
> > > +             off_mask =  (offset & GENMASK(11, 5));
> > > +             do {
> > > +                     CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
> > > +                     CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
> > > +                     CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
> > > +             } while (0);
> > > +     } else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
> > > +             /* 64 bit, 8 off indexed register sets */
> > > +             idx = (offset & GENMASK(5, 0)) / 8;
> > > +             off_mask = (offset & GENMASK(11, 6));
> > > +             do {
> > > +                     CHECKREGIDX(TRCCIDCVRn(0), ctxid_pid, idx, off_mask);
> > > +                     CHECKREGIDX(TRCVMIDCVRn(0), vmid_val, idx, off_mask);
> > > +             } while (0);
> > > +     } else if ((offset >= TRCRSCTLRn(2)) &&
> > > +                (offset <= TRCRSCTLRn((ETM_MAX_RES_SEL - 1)))) {
> > > +             /* 32 bit resource selection regs, 32 off, skip fixed 0,1 */
> > > +             idx = (offset & GENMASK(6, 0)) / 4;
> > > +             if (idx < ETM_MAX_RES_SEL) {
> > > +                     reg_csdev->driver_regval = &drvcfg->res_ctrl[idx];
> > > +                     err = 0;
> > > +             }
> > > +     } else if ((offset >= TRCACVRn(0)) &&
> > > +                (offset <= TRCACATRn((ETM_MAX_SINGLE_ADDR_CMP - 1)))) {
> > > +             /* 64 bit addr cmp regs, 16 off */
> > > +             idx = (offset & GENMASK(6, 0)) / 8;
> > > +             off_mask = offset & GENMASK(11, 7);
> > > +             do {
> > > +                     CHECKREGIDX(TRCACVRn(0), addr_val, idx, off_mask);
> > > +                     CHECKREGIDX(TRCACATRn(0), addr_acc, idx, off_mask);
> > > +             } while (0);
> > > +     } else if ((offset >= TRCCNTRLDVRn(0)) &&
> > > +                (offset <= TRCCNTVRn((ETMv4_MAX_CNTR - 1)))) {
> > > +             /* 32 bit counter regs, 4 off (ETMv4_MAX_CNTR - 1) */
> > > +             idx = (offset &  GENMASK(3, 0)) / 4;
> > > +             off_mask = offset &  GENMASK(11, 4);
> > > +             do {
> > > +                     CHECKREGIDX(TRCCNTRLDVRn(0), cntrldvr, idx, off_mask);
> > > +                     CHECKREGIDX(TRCCNTCTLRn(0), cntr_ctrl, idx, off_mask);
> > > +                     CHECKREGIDX(TRCCNTVRn(0), cntr_val, idx, off_mask);
> > > +             } while (0);
> > > +     }
> > > +     return err;
> > > +}
> > > +
> > > +/**
> > > + * etm4_cfg_load_feature - load a feature into a device instance.
> > > + *
> > > + * @csdev:   An ETMv4 CoreSight device.
> > > + * @feat:    The feature to be loaded.
> > > + *
> > > + * The function will load a feature instance into the device, checking that
> > > + * the register definitions are valid for the device.
> > > + *
> > > + * Parameter and register definitions will be converted into internal
> > > + * structures that are used to set the values in the driver when the
> > > + * feature is enabled for the device.
> > > + *
> > > + * The feature spinlock pointer is initialised to the same spinlock
> > > + * that the driver uses to protect the internal register values.
> > > + */
> > > +static int etm4_cfg_load_feature(struct coresight_device *csdev,
> > > +                              struct cscfg_feature_csdev *feat_csdev)
> > > +{
> > > +     struct device *dev = csdev->dev.parent;
> > > +     struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> > > +     const struct cscfg_feature_desc *feat_desc = feat_csdev->feat_desc;
> > > +     u32 offset;
> > > +     int i = 0, err = 0;
> > > +
> > > +     /*
> > > +      * essential we set the device spinlock - this is used in the generic
> > > +      * programming routines when copying values into the drvdata structures
> > > +      * via the pointers setup in etm4_cfg_map_reg_offset().
> > > +      */
> > > +     feat_csdev->drv_spinlock = &drvdata->spinlock;
> > > +
> > > +     /* process the register descriptions */
> > > +     for (i = 0; i < feat_csdev->nr_regs && !err; i++) {
> > > +             offset = feat_desc->regs_desc[i].offset;
> > > +             err = etm4_cfg_map_reg_offset(drvdata, &feat_csdev->regs_csdev[i], offset);
> > > +     }
> > > +     return err;
> > > +}
> > > +
> > > +/* match information when loading configurations */
> > > +#define CS_CFG_ETM4_MATCH_FLAGS      (CS_CFG_MATCH_CLASS_SRC_ALL | \
> > > +                              CS_CFG_MATCH_CLASS_SRC_ETM4)
> > > +
> > > +int etm4_cscfg_register(struct coresight_device *csdev)
> > > +{
> > > +     struct cscfg_csdev_feat_ops ops;
> > > +
> > > +     ops.load_feat = &etm4_cfg_load_feature;
> > > +
> > > +     return cscfg_register_csdev(csdev, CS_CFG_ETM4_MATCH_FLAGS, &ops);
> > > +}
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.h b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> > > new file mode 100644
> > > index 000000000000..a204ad9a4792
> > > --- /dev/null
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> > > @@ -0,0 +1,15 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2014-2020, The Linux Foundation. All rights reserved.
> > > + */
> > > +
> > > +#ifndef _CORESIGHT_ETM4X_CFG_H
> > > +#define _CORESIGHT_ETM4X_CFG_H
> >
> >
> > Looks like this must be guarded by the CONFIG_CORESIGHT_SOURCE_ETM4X to
> > prevent the build failures on arm, as reported by the test robot.
> >
>
> The test robot was complaining about
> #include <asm/sysregs.h>
> in the next patch and not this one. I haven't seen any issues reported
> with this patch.
>
> Moreover - if this is required - then removing the ETM4 module from
> the config - i.e. not defining CONFIG_CORESIGHT_SOURCE_ETM4X - should
> trigger the error. I have done a clean build, without ETM4 and the
> error does not occur. (I also tried out gcc 9 in case this was a
> factor - it was not)
>
> I have to confess I am completely puzzled by this - how can this
> include only trigger an issue with my patch when it has been in the
> source for some time, and the same header (coresight-etm4x.h) is
> included without apparent problems elsewhere in the coresight build.
>
> Without a reliable reproducer, or a credible explanation, I can only
> assume that this is an issue with the test robot itself.
>
> I am open to further suggestions!
>
> Thanks
>
> Mike
>
>
> > #ifdef CONFIG_CORESIGHT_SOURCE_ETM4X
> >
> > > +
> > > +#include "coresight-config.h"
> > > +#include "coresight-etm4x.h"
> > > +
> > > +/* ETMv4 specific config functions */
> > > +int etm4_cscfg_register(struct coresight_device *csdev);
> > > +
> >
> > endif /* ETM4X */
> >
> > Cheers
> > Suzuki
> >
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
