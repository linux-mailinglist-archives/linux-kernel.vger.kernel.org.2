Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D96B33F518
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhCQQIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhCQQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:08:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED1CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:08:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g8so1784570wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XDMv1l7XAvPIRZCp+58wmK6/e7cNobRtB9Ufy6uc9M=;
        b=nwPTF7pDSnHH3Es3Iq1rOSMIIXvxOFqefNZqEtlEJoGPFFTUjOSW9l4D0hPGVm/B+M
         frNbiFFBzsLYDueELZkibCgO7IgKhSTlA56HkvIIztRpBC2bh9RE+trur/qrEOwBLQV+
         N5/NkBYix41z5ZX3pEfIebjqR87x4iXd95j+idTEm77EKWCY12Scciq+M57RhbgF3+UO
         /dR0TDLi9p+kUjmQDX9tJBY9riau7H54Mzp9vnxaJX/udQ6AmfThFMsGv0C8GhEWRMKi
         9unQ7GULSbVZZu3KL8Bt2vTLISD6FoVqkWQjtrWHYFZOlUEITFvtlwO+R2m/0qJDUcSg
         iSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XDMv1l7XAvPIRZCp+58wmK6/e7cNobRtB9Ufy6uc9M=;
        b=gs6LrcD5ebwj1gTcKXLYAYJgu0K6pTZOqoF1T+vqKl+97blkrN9xGaiMUKurKkSP8C
         xxiWPYKRixBMj1bsRZvI3T5sP2KbZmcKZWhNKxvPfBYZQeHzYfb6mnkJRCydlukzyCQn
         4/ZRT5x6mCkCufKmJT+Nokg0jV80N53D7TfZUMpidLxon2wzknGNF5nW5iCbF0eirBA0
         X+8pqKKYw34gCrQkpgZDW6qNN3AFWnbbKiD3DpUNx7KHWp9C5fWrINNAU+5XzyAOekkQ
         rLKgqIQmcZI29AXmUW8nAaVH4qEaLiF+sWw3s9s5UYmlZcXoeKahefsnc/1f5Iy7NXzp
         rIPg==
X-Gm-Message-State: AOAM5320oedZOpoP/NgS5SRgCU1IMeNwtcrAWgLNv/OfCzoW46N2Yrpy
        d8eG+wS8Gc0Qljg53aqvHZohlZbu38iR0b68OlCxK8+M4o4=
X-Google-Smtp-Source: ABdhPJz+OuLzsHEG/wkrZphnViraRX5y1YPemL1jnIMIAc4cTYNU8Yji1dHKFv/B3EpDZIatCiRAbMqFriHRE3qjkZY=
X-Received: by 2002:a7b:c209:: with SMTP id x9mr4130958wmi.92.1615993488753;
 Wed, 17 Mar 2021 08:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-8-mike.leach@linaro.org>
 <a82fe115-69b2-9b90-ed28-b75248811343@arm.com>
In-Reply-To: <a82fe115-69b2-9b90-ed28-b75248811343@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 17 Mar 2021 15:04:38 +0000
Message-ID: <CAJ9a7VjKp16y7zmOSmbLbBH=AhHf7J+YaMcQVj0+1J1yM9hptQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] coresight: etm4x: Add complex configuration
 handlers to etmv4
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Yabin Cui <yabinc@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

Realised I hadn't answered the question below...

On Fri, 5 Mar 2021 at 10:18, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 1/28/21 5:09 PM, Mike Leach wrote:
> > Adds in handlers to allow the ETMv4 to use the complex configuration
> > support. Features and configurations can be loaded and selected in the
> > device.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/Makefile          |   3 +-
> >   .../hwtracing/coresight/coresight-etm4x-cfg.c | 184 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-etm4x-cfg.h |  29 +++
> >   .../coresight/coresight-etm4x-core.c          |  38 +++-
> >   .../coresight/coresight-etm4x-sysfs.c         |   3 +
> >   5 files changed, 254 insertions(+), 3 deletions(-)
> >   create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> >   create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index daad9f103a78..ea544206204d 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -16,7 +16,8 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
> >   coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
> >                    coresight-etm3x-sysfs.o
> >   obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
> > -coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
> > +coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o \
> > +                     coresight-etm4x-cfg.o
> >   obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
> >   obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> >   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > new file mode 100644
> > index 000000000000..f237a8d02360
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > @@ -0,0 +1,184 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(C) 2020 Linaro Limited. All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +
> > +#include "coresight-etm4x.h"
> > +#include "coresight-etm4x-cfg.h"
> > +#include "coresight-priv.h"
> > +#include "coresight-syscfg.h"
> > +
> > +/**
> > + * etm4_cfg_map_reg_offset - validate and map the register offset into a
> > + *                        location in the driver config struct.
> > + *
> > + * Limits the number of registers that can be accessed and programmed in
> > + * features, to those which are used to control the trace capture parameters.
> > + *
> > + * Omits or limits access to those which the driver must use exclusively.
> > + *
> > + * Invalid offsets will result in fail code return and feature load failure.
> > + *
> > + * @drvdata: driver data to map into.
> > + * @reg:     register to map.
> > + * @offset:  device offset for the register
> > + */
> > +static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
> > +                                struct cscfg_reg_csdev *reg, u32 offset)
> > +{
> > +     int err = -EINVAL, idx;
> > +     struct etmv4_config *drvcfg = &drvdata->config;
> > +     u32 off_mask;
> > +
> > +#define CHECKREG(cval, elem) \
> > +     { \
> > +             if (offset == cval) { \
> > +                     reg->drv_store = &drvcfg->elem; \
> > +                     err = 0; \
> > +                     break; \
> > +             } \
> > +     }
> > +
> > +#define CHECKREGIDX(cval, elem, off_idx, mask)       \
> > +     { \
> > +             if (mask == cval) { \
> > +                     reg->drv_store = &drvcfg->elem[off_idx]; \
> > +                     err = 0; \
> > +                     break; \
> > +             } \
> > +     }
> > +
>
> I think we can live with switch-case, ignoring the Warnings generated by the
> checkpatch, making the code much more readable and less error prone.
>
> Otherwise, please could you move the above macro definitions to the top,
> outside this function ?
>
> > +     if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
> > +         ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
> > +         ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
> > +             do {
> > +                     CHECKREG(TRCEVENTCTL0R, eventctrl0);
> > +                     CHECKREG(TRCEVENTCTL1R, eventctrl1);
> > +                     CHECKREG(TRCSTALLCTLR, stall_ctrl);
> > +                     CHECKREG(TRCTSCTLR, ts_ctrl);
> > +                     CHECKREG(TRCSYNCPR, syncfreq);
> > +                     CHECKREG(TRCCCCTLR, ccctlr);
> > +                     CHECKREG(TRCBBCTLR, bb_ctrl);
> > +                     CHECKREG(TRCVICTLR, vinst_ctrl);
> > +                     CHECKREG(TRCVIIECTLR, viiectlr);
> > +                     CHECKREG(TRCVISSCTLR, vissctlr);
> > +                     CHECKREG(TRCVIPCSSCTLR, vipcssctlr);
> > +                     CHECKREG(TRCSEQRSTEVR, seq_rst);
> > +                     CHECKREG(TRCSEQSTR, seq_state);
> > +                     CHECKREG(TRCEXTINSELR, ext_inp);
> > +                     CHECKREG(TRCCIDCCTLR0, ctxid_mask0);
> > +                     CHECKREG(TRCCIDCCTLR1, ctxid_mask1);
> > +                     CHECKREG(TRCVMIDCCTLR0, vmid_mask0);
> > +                     CHECKREG(TRCVMIDCCTLR1, vmid_mask1);
> > +             } while (0);
> > +     } else if ((offset & GENMASK(11, 4)) == TRCSEQEVRn(0)) {
> > +             /* sequencer state control registers */
> > +             idx = (offset & GENMASK(3, 0)) / 4;
> > +             if (idx < ETM_MAX_SEQ_STATES) {
> > +                     reg->drv_store = &drvcfg->seq_ctrl[idx];
> > +                     err = 0;
> > +             }
> > +     } else if ((offset >= TRCSSCCRn(0)) && (offset <= TRCSSPCICRn(7))) {
> > +             /* 32 bit, 8 off indexed register sets */
> > +             idx = (offset & GENMASK(4, 0)) / 4;
> > +             off_mask =  (offset & GENMASK(11, 5));
> > +             do {
> > +                     CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
> > +                     CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
> > +                     CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
> > +             } while (0);
> > +     } else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
> > +             /* 64 bit, 8 off indexed register sets */
> > +             idx = (offset & GENMASK(5, 0)) / 8;
> > +             off_mask = (offset & GENMASK(11, 6));
> > +             do {
> > +                     CHECKREGIDX(TRCCIDCVRn(0), ctxid_pid, idx, off_mask);
> > +                     CHECKREGIDX(TRCVMIDCVRn(0), vmid_val, idx, off_mask);
> > +             } while (0);
> > +     } else if ((offset >= TRCRSCTLRn(2)) &&
> > +                (offset <= TRCRSCTLRn((ETM_MAX_RES_SEL - 1)))) {
> > +             /* 32 bit resource selection regs, 32 off, skip fixed 0,1 */
> > +             idx = (offset & GENMASK(6, 0)) / 4;
> > +             if (idx < ETM_MAX_RES_SEL) {
> > +                     reg->drv_store = &drvcfg->res_ctrl[idx];
> > +                     err = 0;
> > +             }
> > +     } else if ((offset >= TRCACVRn(0)) &&
> > +                (offset <= TRCACATRn((ETM_MAX_SINGLE_ADDR_CMP - 1)))) {
> > +             /* 64 bit addr cmp regs, 16 off */
> > +             idx = (offset & GENMASK(6, 0)) / 8;
> > +             off_mask = offset & GENMASK(11, 7);
> > +             do {
> > +                     CHECKREGIDX(TRCACVRn(0), addr_val, idx, off_mask);
> > +                     CHECKREGIDX(TRCACATRn(0), addr_acc, idx, off_mask);
>
> What happens if the ETM doesn't have enough resources ? Do we fail the load
> here ? Or do we fail the activation during enabling the ETM ? Or do we assume
> all ETMs have the resources required for statically defined configs ?
>

Resource management will be in a follow-up set - dynamic load of
features and configurations will be gated on sufficient resources.
There are two stages where this can fail:-
1) a feature requires resources that the ETM does not have - this will
fail on load.  Any dependent configuration will fail at this point
too. Where this is the result of dynamic load of a configuration and
features the load of that module will be failed.
2) a configuration uses more features than devices have total
resources for - this will fail on enable as a feature cannot be
programmed due to lack of resources.

For the built in config - for now we assume any platform has the
resources - in future we will fail the load of the feature, but not
the load of coresight itself.
Moving forwards I would expect that we will avoid having too many
built-in configs and push for all new ones to be a separate loadable
module as a minimum.

Thanks

Mike


> > +             } while (0);
> > +     } else if ((offset >= TRCCNTRLDVRn(0)) &&
> > +                (offset <= TRCCNTVRn((ETMv4_MAX_CNTR - 1)))) {
> > +             /* 32 bit counter regs, 4 off (ETMv4_MAX_CNTR - 1) */
> > +             idx = (offset &  GENMASK(3, 0)) / 4;
> > +             off_mask = offset &  GENMASK(11, 4);
> > +             do {
> > +                     CHECKREGIDX(TRCCNTRLDVRn(0), cntrldvr, idx, off_mask);
> > +                     CHECKREGIDX(TRCCNTCTLRn(0), cntr_ctrl, idx, off_mask);
> > +                     CHECKREGIDX(TRCCNTVRn(0), cntr_val, idx, off_mask);
> > +             } while (0);
> > +     }
> > +     return err;
> > +}
> > +
> > +/**
> > + * etm4_cfg_load_feature - load a feature into a device instance.
> > + *
> > + * @csdev:   An ETMv4 CoreSight device.
> > + * @feat:    The feature to be loaded.
> > + *
> > + * The function will load a feature instance into the device, checking that
> > + * the register definitions are valid for the device.
> > + *
> > + * Parameter and register definitions will be converted into internal
> > + * structures that are used to set the values in the driver when the
> > + * feature is enabled for the device.
> > + *
> > + * The feature spinlock pointer is initialised to the same spinlock
> > + * that the driver uses to protect the internal register values.
> > + */
> > +static int etm4_cfg_load_feature(struct coresight_device *csdev,
> > +                              struct cscfg_feature_csdev *feat)
> > +{
> > +     struct device *dev = csdev->dev.parent;
> > +     struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> > +     const struct cscfg_feature_desc *feat_desc = feat->desc;
> > +     u32 offset;
> > +     int i = 0, err = 0;
> > +
> > +     /*
> > +      * essential we set the device spinlock - this is used in the generic
> > +      * programming routines when copying values into the drvdata structures
> > +      * via the pointers setup in etm4_cfg_map_reg_offset().
> > +      */
> > +     feat->csdev_spinlock = &drvdata->spinlock;
> > +
> > +     /* process the register descriptions */
> > +     for (i = 0; i < feat->nr_regs && !err; i++) {
> > +             offset = feat_desc->regs[i].offset;
> > +             err = etm4_cfg_map_reg_offset(drvdata, &feat->regs[i], offset);
> > +     }
> > +     return err;
> > +}
> > +
> > +/* match information when loading configurations */
> > +#define CS_CFG_ETM4_MATCH_FLAGS      (CS_CFG_MATCH_CLASS_SRC_ALL | \
> > +                                      CS_CFG_MATCH_CLASS_SRC_ETM4)
> > +
> > +int etm4_cscfg_register(struct coresight_device *csdev, const char *dev_name)
> > +{
> > +     struct cscfg_match_desc cfg_info;
> > +     struct cscfg_csdev_feat_ops ops;
> > +
> > +     cfg_info.match_flags = CS_CFG_ETM4_MATCH_FLAGS;
> > +
> > +     ops.load_feat = &etm4_cfg_load_feature;
> > +
> > +     return cscfg_register_csdev(csdev, &cfg_info, &ops);
> > +}
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.h b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> > new file mode 100644
> > index 000000000000..9e279c5da55d
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#ifndef _CORESIGHT_CORESIGHT_ETM4X_CFG_H
> > +#define _CORESIGHT_CORESIGHT_ETM4X_CFG_H
> > +
> > +#include "coresight-config.h"
> > +#include "coresight-etm4x.h"
> > +
> > +/* ETMv4 specific config defines */
> > +
> > +/* resource IDs */
> > +
> > +#define ETM4_CFG_RES_CTR     0x001
> > +#define ETM4_CFG_RES_CMP     0x002
> > +#define ETM4_CFG_RES_CMP_PAIR0       0x003
> > +#define ETM4_CFG_RES_CMP_PAIR1       0x004
> > +#define ETM4_CFG_RES_SEL     0x005
> > +#define ETM4_CFG_RES_SEL_PAIR0       0x006
> > +#define ETM4_CFG_RES_SEL_PAIR1       0x007
> > +#define ETM4_CFG_RES_SEQ     0x008
> > +#define ETM4_CFG_RES_TS              0x009
> > +#define ETM4_CFG_RES_MASK    0x00F
>
> Where are these used ? Probably better to move it to the patch
> where they are actually used.
>
> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
