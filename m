Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7A4450AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhKDI7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:59:03 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:4049 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230229AbhKDI7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636016184; x=1667552184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8kP53ilHbnfctEcN2VIkpyUuRLllB+ffALcteXGhw1A=;
  b=f4El8VwRLwNvSwJD+iKAom2pHzGg/PLpfYCgzQAN67WhsRTNjU9Gl5sN
   m56iv6XWxDdvwKTxc6+5yFMXtfd04c9ezyHaX5ms5oAS55qztLUpfpYUU
   8brrbEVT84KOUEI3ZebRfXKntjy2l3rdh5aOYmTwFZ/RSBQdPkG4yBu84
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Nov 2021 01:56:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 01:56:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 4 Nov 2021 01:56:23 -0700
Received: from jinlmao-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 4 Nov 2021 01:56:19 -0700
Date:   Thu, 4 Nov 2021 16:56:16 +0800
From:   Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 03/10] Coresight: Add driver to support Coresight device
 TPDM
Message-ID: <20211104085611.GA19643@jinlmao-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-4-git-send-email-quic_taozha@quicinc.com>
 <20211102175920.GA325436@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211102175920.GA325436@p14s>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mathieu for the quick review.

On Tue, Nov 02, 2021 at 11:59:20AM -0600, Mathieu Poirier wrote:
> Good morning,
> 
> 
> On Thu, Oct 21, 2021 at 03:38:49PM +0800, Tao Zhang wrote:
> > Add driver to support Coresight device TPDM. This driver provides
> > support for configuring monitor. Monitors are primarily responsible
> > for data set collection and support the ability to collect any
> > permutation of data set types. Monitors are also responsible for
> > interaction with system cross triggering.
> 
> As far as I can tell there is nothing related to CTIs in this patch.  And if
> there is, it is not documented.
>

TPDM can create trigger outputs and monitor the trigger outputs by setting dsb_trig_type and dsb_trig_patt_mask.
we will documented the details in next version.
 
> > 
> > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > ---
> >  .../bindings/arm/coresight-tpdm.yaml          |  86 +++
> 
> As checkpatch says, this should be in a separate file.

We will create a separate patch for the dt binding changes.

> 
> >  MAINTAINERS                                   |   5 +
> 
> Since this is a coresight device Suzuki and I will continue the maintenance.
> The get_maintainer script will make sure you care CC'ed on patches related to
> the TPDM/TPDA drivers, and we would typically requried a "Reviewed-by" tag from
> you before merging.


We will update the maintainers.

> 
> >  drivers/hwtracing/coresight/Kconfig           |   9 +
> >  drivers/hwtracing/coresight/Makefile          |   1 +
> >  drivers/hwtracing/coresight/coresight-tpdm.c  | 583 ++++++++++++++++++
> >  5 files changed, 684 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> >  create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> > new file mode 100644
> > index 000000000000..44541075d77f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/coresight-tpdm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Trace, Profiling and Diagnostics Monitor - TPDM
> > +
> > +description: |
> > +  The TPDM or Monitor serves as data collection component for various dataset
> > +  types specified in the QPMDA spec. It covers Basic Counts (BC), Tenure
> > +  Counts (TC), Continuous Multi-Bit (CMB), and Discrete Single Bit (DSB). It
> > +  performs data collection in the data producing clock domain and transfers it
> > +  to the data collection time domain, generally ATB clock domain.
> > +
> > +  The primary use case of the TPDM is to collect data from different data
> > +  sources and send it to a TPDA for packetization, timestamping, and funneling.
> > +
> > +maintainers:
> > +  - Tao Zhang <quic_taozha@quicinc.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^tpdm(@[0-9a-f]+)$"
> > +  compatible:
> > +    items:
> > +      - const: arm,primecell
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reg-names:
> > +    items:
> > +      - const: tpdm-base
> > +
> > +  atid:
> > +    maxItems: 1
> > +    description: |
> > +      The QPMDA specification repurposed the ATID field of the AMBA ATB
> > +      specification to use it to convey packetization information to the
> > +      Aggregator.
> > +
> > +  out-ports:
> > +    description: |
> > +      Output connections from the TPDM to legacy CoreSight trace bus.
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    properties:
> > +      port:
> > +        description: Output connection from the TPDM to legacy CoreSight
> > +          Trace bus.
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - atid
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # minimum TPDM definition.
> > +  - |
> > +    tpdm@6980000 {
> > +      compatible = "arm,primecell";
> > +      reg = <0x6980000 0x1000>;
> > +      reg-names = "tpdm-base";
> > +
> > +      clocks = <&aoss_qmp>;
> > +      clock-names = "apb_pclk";
> > +
> > +      atid = <78>;
> > +      out-ports {
> > +        port {
> > +          tpdm_turing_out_funnel_turing: endpoint {
> > +            remote-endpoint =
> > +              <&funnel_turing_in_tpdm_turing>;
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index eeb4c70b3d5b..cabecf760488 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15303,6 +15303,11 @@ L:	netdev@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/net/ipa/
> >  
> > +QCOM CORESIGHT TPDM DRIVER
> > +M:	Tao Zhang <quic_taozha@quicinc.com>
> > +S:	Maintained
> > +F:	drivers/hwtracing/coresight/coresight-tpdm.c
> > +
> >  QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
> >  M:	Gabriel Somlo <somlo@cmu.edu>
> >  M:	"Michael S. Tsirkin" <mst@redhat.com>
> > diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> > index f026e5c0e777..abe244a968f6 100644
> > --- a/drivers/hwtracing/coresight/Kconfig
> > +++ b/drivers/hwtracing/coresight/Kconfig
> > @@ -188,4 +188,13 @@ config CORESIGHT_TRBE
> >  
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called coresight-trbe.
> > +
> > +config CORESIGHT_TPDM
> > +	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
> > +	select CORESIGHT_LINKS_AND_SINKS
> > +	help
> > +	  This driver provides support for configuring monitor. Monitors are
> > +	  primarily responsible for data set collection and support the
> > +	  ability to collect any permutation of data set types. Monitors are
> > +	  also responsible for interaction with system cross triggering.
> 
> You also need to indicate what the name of the module would be.  Please look at
> other extries in the Kconfig file for examples.


We will add module name here.

> 
> >  endif
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index b6c4a48140ec..e7392a0dddeb 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -25,5 +25,6 @@ obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> >  obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> >  obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
> >  obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
> > +obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
> >  coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
> >  		   coresight-cti-sysfs.o
> > diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> > new file mode 100644
> > index 000000000000..906776c859d6
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> > @@ -0,0 +1,583 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/amba/bus.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/fs.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/of.h>
> > +#include <linux/coresight.h>
> > +#include <linux/regulator/consumer.h>
> 
> These should be in alphabetical order.
> 

We will update the order.

> > +
> > +#include "coresight-priv.h"
> > +
> > +#define tpdm_writel(drvdata, val, off)	__raw_writel((val), drvdata->base + off)
> > +#define tpdm_readl(drvdata, off)		__raw_readl(drvdata->base + off)
> 
> writel/readl_relaxed() are defines for __raw_writel/readl and as such the above
> should not be needed.
>

 We will address your comments.
 
> > +
> > +#define TPDM_LOCK(drvdata)						\
> > +do {									\
> > +	mb(); /* ensure configuration take effect before we lock it */	\
> > +	tpdm_writel(drvdata, 0x0, CORESIGHT_LAR);			\
> > +} while (0)
> > +#define TPDM_UNLOCK(drvdata)						\
> > +do {									\
> > +	tpdm_writel(drvdata, CORESIGHT_UNLOCK, CORESIGHT_LAR);		\
> > +	mb(); /* ensure unlock take effect before we configure */	\
> > +} while (0)
> 
> That too isn't needed.  Simply use CS_LOCK/UNLOCK().
> 

We will address your comments.

> > +
> > +/* GPR Registers */
> > +#define TPDM_GPR_CR(n)		(0x0 + (n * 4))
> > +
> > +/* BC Subunit Registers */
> > +#define TPDM_BC_CR		(0x280)
> > +#define TPDM_BC_SATROLL		(0x284)
> > +#define TPDM_BC_CNTENSET	(0x288)
> > +#define TPDM_BC_CNTENCLR	(0x28C)
> > +#define TPDM_BC_INTENSET	(0x290)
> > +#define TPDM_BC_INTENCLR	(0x294)
> > +#define TPDM_BC_TRIG_LO(n)	(0x298 + (n * 4))
> > +#define TPDM_BC_TRIG_HI(n)	(0x318 + (n * 4))
> > +#define TPDM_BC_GANG		(0x398)
> > +#define TPDM_BC_OVERFLOW(n)	(0x39C + (n * 4))
> > +#define TPDM_BC_OVSR		(0x3C0)
> > +#define TPDM_BC_SELR		(0x3C4)
> > +#define TPDM_BC_CNTR_LO		(0x3C8)
> > +#define TPDM_BC_CNTR_HI		(0x3CC)
> > +#define TPDM_BC_SHADOW_LO(n)	(0x3D0 + (n * 4))
> > +#define TPDM_BC_SHADOW_HI(n)	(0x450 + (n * 4))
> > +#define TPDM_BC_SWINC		(0x4D0)
> > +#define TPDM_BC_MSR(n)		(0x4F0 + (n * 4))
> > +
> > +/* TC Subunit Registers */
> > +#define TPDM_TC_CR		(0x500)
> > +#define TPDM_TC_CNTENSET	(0x504)
> > +#define TPDM_TC_CNTENCLR	(0x508)
> > +#define TPDM_TC_INTENSET	(0x50C)
> > +#define TPDM_TC_INTENCLR	(0x510)
> > +#define TPDM_TC_TRIG_SEL(n)	(0x514 + (n * 4))
> > +#define TPDM_TC_TRIG_LO(n)	(0x534 + (n * 4))
> > +#define TPDM_TC_TRIG_HI(n)	(0x554 + (n * 4))
> > +#define TPDM_TC_OVSR_GP		(0x580)
> > +#define TPDM_TC_OVSR_IMPL	(0x584)
> > +#define TPDM_TC_SELR		(0x588)
> > +#define TPDM_TC_CNTR_LO		(0x58C)
> > +#define TPDM_TC_CNTR_HI		(0x590)
> > +#define TPDM_TC_SHADOW_LO(n)	(0x594 + (n * 4))
> > +#define TPDM_TC_SHADOW_HI(n)	(0x644 + (n * 4))
> > +#define TPDM_TC_SWINC		(0x700)
> > +#define TPDM_TC_MSR(n)		(0x768 + (n * 4))
> > +
> > +/* DSB Subunit Registers */
> > +#define TPDM_DSB_CR		(0x780)
> > +#define TPDM_DSB_TIER		(0x784)
> > +#define TPDM_DSB_TPR(n)		(0x788 + (n * 4))
> > +#define TPDM_DSB_TPMR(n)	(0x7A8 + (n * 4))
> > +#define TPDM_DSB_XPR(n)		(0x7C8 + (n * 4))
> > +#define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
> > +#define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
> > +#define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
> > +#define TPDM_DSB_CA_SELECT(n)	(0x86c + (n * 4))
> > +#define TPDM_DSB_MSR(n)		(0x980 + (n * 4))
> > +
> > +/* CMB/MCMB Subunit Registers */
> > +#define TPDM_CMB_CR		(0xA00)
> > +#define TPDM_CMB_TIER		(0xA04)
> > +#define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
> > +#define TPDM_CMB_TPMR(n)	(0xA10 + (n * 4))
> > +#define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
> > +#define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
> > +#define TPDM_CMB_MARKR		(0xA28)
> > +#define TPDM_CMB_READCTL	(0xA70)
> > +#define TPDM_CMB_READVAL	(0xA74)
> > +#define TPDM_CMB_MSR(n)		(0xA80 + (n * 4))
> > +
> > +/* TPDM Specific Registers */
> > +#define TPDM_ITATBCNTRL		(0xEF0)
> > +#define TPDM_CLK_CTRL		(0x220)
> > +#define TPDM_ITCNTRL		(0xF00)
> > +
> > +
> > +#define TPDM_DATASETS		32
> > +#define TPDM_BC_MAX_COUNTERS	32
> > +#define TPDM_BC_MAX_OVERFLOW	6
> > +#define TPDM_BC_MAX_MSR		4
> > +#define TPDM_TC_MAX_COUNTERS	44
> > +#define TPDM_TC_MAX_TRIG	8
> > +#define TPDM_TC_MAX_MSR		6
> > +#define TPDM_DSB_MAX_PATT	8
> > +#define TPDM_DSB_MAX_SELECT	8
> > +#define TPDM_DSB_MAX_MSR	32
> > +#define TPDM_DSB_MAX_EDCR	16
> > +#define TPDM_DSB_MAX_LINES	256
> > +#define TPDM_CMB_PATT_CMP	2
> > +#define TPDM_CMB_MAX_MSR	128
> > +#define TPDM_MCMB_MAX_LANES	8
> > +
> > +/* DSB programming modes */
> > +#define TPDM_DSB_MODE_CYCACC(val)	BMVAL(val, 0, 2)
> > +#define TPDM_DSB_MODE_PERF		BIT(3)
> > +#define TPDM_DSB_MODE_HPBYTESEL(val)	BMVAL(val, 4, 8)
> > +#define TPDM_MODE_ALL			(0xFFFFFFF)
> > +
> > +#define NUM_OF_BITS		32
> > +#define TPDM_GPR_REGS_MAX	160
> > +
> > +#define TPDM_TRACE_ID_START	128
> > +
> > +#define TPDM_REVISION_A		0
> > +#define TPDM_REVISION_B		1
> > +
> > +#define HW_ENABLE_CHECK_VALUE   0x10
> > +
> > +
> 
> Extra newline

We will address your comments.

> 
> > +#define ATBCNTRL_VAL_32		0xC00F1409
> > +#define ATBCNTRL_VAL_64		0xC01F1409
> > +
> 
> All of the above should be in a header file.
> 

We will move these to header file. 

> > +
> > +enum tpdm_dataset {
> > +	TPDM_DS_IMPLDEF,
> > +	TPDM_DS_DSB,
> > +	TPDM_DS_CMB,
> > +	TPDM_DS_TC,
> > +	TPDM_DS_BC,
> > +	TPDM_DS_GPR,
> > +	TPDM_DS_MCMB,
> > +};
> > +
> > +enum tpdm_mode {
> > +	TPDM_MODE_ATB,
> > +	TPDM_MODE_APB,
> > +};
> > +
> > +enum tpdm_support_type {
> > +	TPDM_SUPPORT_TYPE_FULL,
> > +	TPDM_SUPPORT_TYPE_PARTIAL,
> > +	TPDM_SUPPORT_TYPE_NO,
> > +};
> > +
> > +enum tpdm_cmb_patt_bits {
> > +	TPDM_CMB_LSB,
> > +	TPDM_CMB_MSB,
> > +};
> 
> These too.
> 

We will move these to header file.

> > +
> > +#ifdef CONFIG_CORESIGHT_TPDM_DEFAULT_ENABLE
> > +static int boot_enable = 1;
> > +#else
> > +static int boot_enable;
> > +#endif
> 
> That isn't the proper way to do this.  Look at how it is done in
> coresight-etm4x.c
> 
> > +
> > +struct gpr_dataset {
> > +	DECLARE_BITMAP(gpr_dirty, TPDM_GPR_REGS_MAX);
> > +	uint32_t		gp_regs[TPDM_GPR_REGS_MAX];
> 
> Shouldn't this be u32?
> 

uint32_t is the same as u32.
typedef u32			uint32_t;

> > +};
> > +
> > +struct bc_dataset {
> > +	enum tpdm_mode		capture_mode;
> > +	enum tpdm_mode		retrieval_mode;
> > +	uint32_t		sat_mode;
> > +	uint32_t		enable_counters;
> > +	uint32_t		clear_counters;
> > +	uint32_t		enable_irq;
> > +	uint32_t		clear_irq;
> > +	uint32_t		trig_val_lo[TPDM_BC_MAX_COUNTERS];
> > +	uint32_t		trig_val_hi[TPDM_BC_MAX_COUNTERS];
> > +	uint32_t		enable_ganging;
> > +	uint32_t		overflow_val[TPDM_BC_MAX_OVERFLOW];
> > +	uint32_t		msr[TPDM_BC_MAX_MSR];
> > +};
> > +
> > +struct tc_dataset {
> > +	enum tpdm_mode		capture_mode;
> > +	enum tpdm_mode		retrieval_mode;
> > +	bool			sat_mode;
> > +	uint32_t		enable_counters;
> > +	uint32_t		clear_counters;
> > +	uint32_t		enable_irq;
> > +	uint32_t		clear_irq;
> > +	uint32_t		trig_sel[TPDM_TC_MAX_TRIG];
> > +	uint32_t		trig_val_lo[TPDM_TC_MAX_TRIG];
> > +	uint32_t		trig_val_hi[TPDM_TC_MAX_TRIG];
> > +	uint32_t		msr[TPDM_TC_MAX_MSR];
> > +};
> > +
> > +struct dsb_dataset {
> > +	uint32_t		mode;
> > +	uint32_t		edge_ctrl[TPDM_DSB_MAX_EDCR];
> > +	uint32_t		edge_ctrl_mask[TPDM_DSB_MAX_EDCR / 2];
> > +	uint32_t		patt_val[TPDM_DSB_MAX_PATT];
> > +	uint32_t		patt_mask[TPDM_DSB_MAX_PATT];
> > +	bool			patt_ts;
> > +	bool			patt_type;
> > +	uint32_t		trig_patt_val[TPDM_DSB_MAX_PATT];
> > +	uint32_t		trig_patt_mask[TPDM_DSB_MAX_PATT];
> > +	bool			trig_ts;
> > +	bool			trig_type;
> > +	uint32_t		select_val[TPDM_DSB_MAX_SELECT];
> > +	uint32_t		msr[TPDM_DSB_MAX_MSR];
> > +};
> > +
> > +struct mcmb_dataset {
> > +	uint8_t		mcmb_trig_lane;
> > +	uint8_t		mcmb_lane_select;
> > +};
> > +
> > +struct cmb_dataset {
> > +	bool			trace_mode;
> > +	uint32_t		cycle_acc;
> > +	uint32_t		patt_val[TPDM_CMB_PATT_CMP];
> > +	uint32_t		patt_mask[TPDM_CMB_PATT_CMP];
> > +	bool			patt_ts;
> > +	uint32_t		trig_patt_val[TPDM_CMB_PATT_CMP];
> > +	uint32_t		trig_patt_mask[TPDM_CMB_PATT_CMP];
> > +	bool			trig_ts;
> > +	bool			ts_all;
> > +	uint32_t		msr[TPDM_CMB_MAX_MSR];
> > +	uint8_t			read_ctl_reg;
> > +	struct mcmb_dataset	*mcmb;
> > +};
> > +
> > +DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
> > +
> > +struct tpdm_drvdata {
> > +	void __iomem		*base;
> > +	struct device		*dev;
> > +	struct coresight_device	*csdev;
> > +	int			nr_tclk;
> > +	struct clk		**tclk;
> > +	int			nr_treg;
> > +	struct regulator	**treg;
> > +	struct mutex		lock;
> > +	bool			enable;
> > +	bool			clk_enable;
> > +	DECLARE_BITMAP(datasets, TPDM_DATASETS);
> > +	DECLARE_BITMAP(enable_ds, TPDM_DATASETS);
> > +	enum tpdm_support_type	tc_trig_type;
> > +	enum tpdm_support_type	bc_trig_type;
> > +	enum tpdm_support_type	bc_gang_type;
> > +	uint32_t		bc_counters_avail;
> > +	uint32_t		tc_counters_avail;
> > +	struct gpr_dataset	*gpr;
> > +	struct bc_dataset	*bc;
> > +	struct tc_dataset	*tc;
> > +	struct dsb_dataset	*dsb;
> > +	struct cmb_dataset	*cmb;
> > +	int			traceid;
> > +	uint32_t		version;
> > +	bool			msr_support;
> > +	bool			msr_fix_req;
> > +	bool			cmb_msr_skip;
> > +};
> 
> All of these should also be in a header file and properly documented.
> 

We will move these to header file and add the documentation.

> > +
> > +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata);
> 
> This isn't needed.

We will remove this.
> 
> > +
> > +static void __tpdm_enable(struct tpdm_drvdata *drvdata)
> > +{
> > +	TPDM_UNLOCK(drvdata);
> > +
> > +	if (drvdata->clk_enable)
> > +		tpdm_writel(drvdata, 0x1, TPDM_CLK_CTRL);
> > +
> > +	TPDM_LOCK(drvdata);
> > +}
> > +
> > +static int tpdm_enable(struct coresight_device *csdev,
> > +		       struct perf_event *event, u32 mode)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > +	int ret = 0;
> > +
> > +	if (drvdata->enable) {
> 
> This a race condition.
>

Need to add it to mutex_lock. We will update.
 
> > +		dev_err(drvdata->dev,
> > +			"TPDM setup already enabled,Skipping enablei\n");
> 
> Please remove this.
> 

We will remove this.

> > +		return ret;
> 
> Shouldn't this be return -EBUSY? 

We will address your comments.

> 
> > +	}
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	__tpdm_enable(drvdata);
> > +	drvdata->enable = true;
> > +	mutex_unlock(&drvdata->lock);
> > +
> > +	dev_info(drvdata->dev, "TPDM tracing enabled\n");
> > +	return 0;
> > +}
> > +
> > +static void __tpdm_disable(struct tpdm_drvdata *drvdata)
> > +{
> > +	TPDM_UNLOCK(drvdata);
> > +
> > +	if (drvdata->clk_enable)
> > +		tpdm_writel(drvdata, 0x0, TPDM_CLK_CTRL);
> > +
> > +	TPDM_LOCK(drvdata);
> > +}
> > +
> > +static void tpdm_disable(struct coresight_device *csdev,
> > +			 struct perf_event *event)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +	if (!drvdata->enable) {
> > +		dev_err(drvdata->dev,
> > +			"TPDM setup already disabled, Skipping disable\n");
> > +		return;
> > +	}
> > +	mutex_lock(&drvdata->lock);
> > +	__tpdm_disable(drvdata);
> > +	drvdata->enable = false;
> > +	mutex_unlock(&drvdata->lock);
> 
> Same comments as above.
> 

We will address your comments.

> > +
> > +	dev_info(drvdata->dev, "TPDM tracing disabled\n");
> > +}
> > +
> > +static int tpdm_trace_id(struct coresight_device *csdev)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +	return drvdata->traceid;
> > +}
> > +
> > +static const struct coresight_ops_source tpdm_source_ops = {
> > +	.trace_id	= tpdm_trace_id,
> > +	.enable		= tpdm_enable,
> > +	.disable	= tpdm_disable,
> > +};
> > +
> > +static const struct coresight_ops tpdm_cs_ops = {
> > +	.source_ops	= &tpdm_source_ops,
> > +};
> > +
> > +static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
> > +{
> > +	if (test_bit(TPDM_DS_GPR, drvdata->datasets)) {
> > +		drvdata->gpr = devm_kzalloc(drvdata->dev, sizeof(*drvdata->gpr),
> > +					    GFP_KERNEL);
> > +		if (!drvdata->gpr)
> > +			return -ENOMEM;
> > +	}
> > +	if (test_bit(TPDM_DS_BC, drvdata->datasets)) {
> > +		drvdata->bc = devm_kzalloc(drvdata->dev, sizeof(*drvdata->bc),
> > +					   GFP_KERNEL);
> > +		if (!drvdata->bc)
> > +			return -ENOMEM;
> > +	}
> > +	if (test_bit(TPDM_DS_TC, drvdata->datasets)) {
> > +		drvdata->tc = devm_kzalloc(drvdata->dev, sizeof(*drvdata->tc),
> > +					   GFP_KERNEL);
> > +		if (!drvdata->tc)
> > +			return -ENOMEM;
> > +	}
> > +	if (test_bit(TPDM_DS_DSB, drvdata->datasets)) {
> > +		drvdata->dsb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->dsb),
> > +					    GFP_KERNEL);
> > +		if (!drvdata->dsb)
> > +			return -ENOMEM;
> > +	}
> > +	if (test_bit(TPDM_DS_CMB, drvdata->datasets)) {
> > +		drvdata->cmb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->cmb),
> > +					    GFP_KERNEL);
> > +		if (!drvdata->cmb)
> > +			return -ENOMEM;
> > +	} else if (test_bit(TPDM_DS_MCMB, drvdata->datasets)) {
> > +		drvdata->cmb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->cmb),
> > +					    GFP_KERNEL);
> > +		if (!drvdata->cmb)
> > +			return -ENOMEM;
> > +		drvdata->cmb->mcmb = devm_kzalloc(drvdata->dev,
> > +						  sizeof(*drvdata->cmb->mcmb),
> > +						  GFP_KERNEL);
> > +		if (!drvdata->cmb->mcmb)
> > +			return -ENOMEM;
> 
> How can I understand what the above does when:
> 
> 1) There isn't a single line of comments.
> 2) I don't know the HW.
> 3) I don't have access to the documentation.
> 

We will add comments here.

> > +	}
> > +	return 0;
> > +}
> > +
> > +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> > +{
> > +	if (test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		drvdata->bc->retrieval_mode = TPDM_MODE_ATB;
> > +
> > +	if (test_bit(TPDM_DS_TC, drvdata->datasets))
> > +		drvdata->tc->retrieval_mode = TPDM_MODE_ATB;
> > +
> > +	if (test_bit(TPDM_DS_DSB, drvdata->datasets)) {
> > +		drvdata->dsb->trig_ts = true;
> > +		drvdata->dsb->trig_type = false;
> > +	}
> > +
> > +	if (test_bit(TPDM_DS_CMB, drvdata->datasets) ||
> > +	    test_bit(TPDM_DS_MCMB, drvdata->datasets))
> > +		drvdata->cmb->trig_ts = true;
> > +}
> > +
> > +static int tpdm_parse_of_data(struct tpdm_drvdata *drvdata)
> > +{
> > +	int i, ret;
> > +	const char *tclk_name, *treg_name;
> > +	struct device_node *node = drvdata->dev->of_node;
> > +
> > +	drvdata->clk_enable = of_property_read_bool(node, "qcom,clk-enable");
> > +	drvdata->msr_fix_req = of_property_read_bool(node, "qcom,msr-fix-req");
> > +	drvdata->cmb_msr_skip = of_property_read_bool(node,
> > +					"qcom,cmb-msr-skip");
> > +
> > +	drvdata->nr_tclk = of_property_count_strings(node, "qcom,tpdm-clks");
> > +	if (drvdata->nr_tclk > 0) {
> > +		drvdata->tclk = devm_kzalloc(drvdata->dev, drvdata->nr_tclk *
> > +					     sizeof(*drvdata->tclk),
> > +					     GFP_KERNEL);
> > +		if (!drvdata->tclk)
> > +			return -ENOMEM;
> > +
> > +		for (i = 0; i < drvdata->nr_tclk; i++) {
> > +			ret = of_property_read_string_index(node,
> > +					    "qcom,tpdm-clks", i, &tclk_name);
> > +			if (ret)
> > +				return ret;
> > +
> > +			drvdata->tclk[i] = devm_clk_get(drvdata->dev,
> > +							tclk_name);
> > +			if (IS_ERR(drvdata->tclk[i]))
> > +				return PTR_ERR(drvdata->tclk[i]);
> > +		}
> > +	}
> > +
> > +	drvdata->nr_treg = of_property_count_strings(node, "qcom,tpdm-regs");
> > +	if (drvdata->nr_treg > 0) {
> > +		drvdata->treg = devm_kzalloc(drvdata->dev, drvdata->nr_treg *
> > +					     sizeof(*drvdata->treg),
> > +					     GFP_KERNEL);
> > +		if (!drvdata->treg)
> > +			return -ENOMEM;
> > +
> > +		for (i = 0; i < drvdata->nr_treg; i++) {
> > +			ret = of_property_read_string_index(node,
> > +					    "qcom,tpdm-regs", i, &treg_name);
> > +			if (ret)
> > +				return ret;
> > +
> > +			drvdata->treg[i] = devm_regulator_get(drvdata->dev,
> > +							treg_name);
> > +			if (IS_ERR(drvdata->treg[i]))
> > +				return PTR_ERR(drvdata->treg[i]);
> > +		}
> > +	}
> 
> _None_ of the above are defined in the yaml file and/or part of the example that
> is shown there.  Moreover they don't appear in patch 10/10 where TPDM and TPDA are
> supposed to be introduced.  I will comment on patch 10/10 when I'm done with
> this one.
> 

We will update the dtsi change in next version.

> > +
> > +	return 0;
> > +}
> > +
> > +static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> > +{
> > +	int ret, i;
> > +	uint32_t pidr, devid;
> > +	struct device *dev = &adev->dev;
> > +	struct coresight_platform_data *pdata;
> > +	struct tpdm_drvdata *drvdata;
> > +	struct coresight_desc desc = { 0 };
> > +	static int traceid = TPDM_TRACE_ID_START;
> > +	uint32_t version;
> > +
> > +	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
> > +	if (!desc.name)
> > +		return -ENOMEM;
> > +	pdata = coresight_get_platform_data(dev);
> > +	if (IS_ERR(pdata))
> > +		return PTR_ERR(pdata);
> > +	adev->dev.platform_data = pdata;
> > +
> > +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +	drvdata->dev = &adev->dev;
> > +	dev_set_drvdata(dev, drvdata);
> > +
> > +	drvdata->base = devm_ioremap_resource(dev, &adev->res);
> > +	if (!drvdata->base)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&drvdata->lock);
> > +
> > +	ret = tpdm_parse_of_data(drvdata);
> > +	if (ret) {
> > +		dev_err(drvdata->dev, "TPDM parse of data fail\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> > +	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> 
> Why is this of subtype CORESIGHT_DEV_SUBTYPE_SOURCE_PROC when TPDMs are not
> associated with a CPU?  Here we should probably introduce something like
> CORESIGHT_DEV_SUBTYPE_SOURCE_SYS


We will check and update.

> 
> > +	desc.ops = &tpdm_cs_ops;
> > +	desc.pdata = adev->dev.platform_data;
> > +	desc.dev = &adev->dev;
> > +	drvdata->csdev = coresight_register(&desc);
> > +	if (IS_ERR(drvdata->csdev))
> > +		return PTR_ERR(drvdata->csdev);
> > +
> > +	version = tpdm_readl(drvdata, CORESIGHT_PERIPHIDR2);
> > +	drvdata->version = BMVAL(version, 4, 7);
> > +
> 
> What is MSR support?  This should be documented.  Looking more closely at this
> patch, not a single line of documentation is provided.  If you look at other
> drivers, you will find things to be quite different.  The coresight subsystem
> has become very complex and documentation helps us, and anyone trying to
> contribute, understand what the code does.
> 

We will add more documentation in the driver.


> > +	if (drvdata->version)
> > +		drvdata->msr_support = true;
> > +
> > +	pidr = tpdm_readl(drvdata, CORESIGHT_PERIPHIDR0);
> > +	for (i = 0; i < TPDM_DATASETS; i++) {
> > +		if (pidr & BIT(i)) {
> > +			__set_bit(i, drvdata->datasets);
> > +			__set_bit(i, drvdata->enable_ds);
> > +		}
> > +	}
> > +
> > +	ret = tpdm_datasets_alloc(drvdata);
> > +	if (ret) {
> > +		coresight_unregister(drvdata->csdev);
> > +		return ret;
> > +	}
> > +
> > +	tpdm_init_default_data(drvdata);
> > +
> > +	devid = tpdm_readl(drvdata, CORESIGHT_DEVID);
> > +	drvdata->tc_trig_type = BMVAL(devid, 27, 28);
> > +	drvdata->bc_trig_type = BMVAL(devid, 25, 26);
> > +	drvdata->bc_gang_type = BMVAL(devid, 23, 24);
> > +	drvdata->bc_counters_avail = BMVAL(devid, 6, 10) + 1;
> > +	drvdata->tc_counters_avail = BMVAL(devid, 4, 5) + 1;
> 
> Shouldn't this be part of tpdm_init_default_data()?
> 

We will address your comments.

> > +
> > +	drvdata->traceid = traceid++;
> 
> For this to work a new function needs to be introduced in coresight-pmu.h.
> Something like:
> 
> static inline int coresight_get_system_trace_id(int id)
> {
>         /* Start system IDs above the highest per CPU trace ID. */
>         return coresigth_get_trace_id(cpumask_last(cpu_possible_mask) + 1);
> }
> 

We will address your comments.

> > +
> > +	dev_dbg(drvdata->dev, "TPDM initialized\n");
> 
> Please remove this.
>

We will remove it.
 
> > +
> > +	if (boot_enable)
> > +		coresight_enable(drvdata->csdev);
> > +
> > +	pm_runtime_put(&adev->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct amba_id tpdm_ids[] = {
> > +	{
> > +		.id     = 0x001f0e00,
> > +		.mask   = 0x00ffff00,
> 
> Any way we can use CS_AMBA_ID() here?
> 

We will address your comments.

> > +		.data	= "TPDM",
> 
> What is .data used for?

It is just to fill the structure. We will remove it if it is not necessary.

> 
> > +	},
> > +	{ 0, 0},
> > +};
> > +
> > +static struct amba_driver tpdm_driver = {
> > +	.drv = {
> > +		.name   = "coresight-tpdm",
> > +		.owner	= THIS_MODULE,
> > +		.suppress_bind_attrs = true,
> > +	},
> > +	.probe          = tpdm_probe,
> > +	.id_table	= tpdm_ids,
> > +};
> > +
> > +module_amba_driver(tpdm_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
> > -- 
> > 2.17.1
> > 
