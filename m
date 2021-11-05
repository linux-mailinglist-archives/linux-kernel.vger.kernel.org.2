Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3C446070
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhKEIPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:15:09 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55565 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231837AbhKEIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636099944; x=1667635944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZSFOL9vIhrRdxXqQpeRaNhfPM5aIbGEwBEhlcjp/1Nk=;
  b=Kja4zeWk5mbIZqZHmBgCXFw/hai7RJ6b9nhDkY76bWEsPvu6eTZ9JiBV
   aKeCXIH/AJ2gh3lR3yXGwaieZJ3OlFJlPN6oJWQREr8BSDmAuDiyNjflj
   FYp8SWgfqpbmlwn83NUuZtMXpzBFkfFu+Z4FwvlOGyNm0q4bsutfmdF79
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Nov 2021 01:12:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 01:12:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:12:22 -0700
Received: from jinlmao-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:12:18 -0700
Date:   Fri, 5 Nov 2021 16:12:15 +0800
From:   Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
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
Message-ID: <20211105081209.GB25738@jinlmao-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-4-git-send-email-quic_taozha@quicinc.com>
 <20211102175920.GA325436@p14s>
 <04110d05-ad73-2b78-e261-1531befd2683@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04110d05-ad73-2b78-e261-1531befd2683@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon, Suzuki.  

On Thu, Nov 04, 2021 at 09:37:05AM +0000, Suzuki K Poulose wrote:
> Tao,
> 
> Some additional comments below.
> 
> On 02/11/2021 17:59, Mathieu Poirier wrote:
> > Good morning,
> > 
> > 
> > On Thu, Oct 21, 2021 at 03:38:49PM +0800, Tao Zhang wrote:
> > > Add driver to support Coresight device TPDM. This driver provides
> > > support for configuring monitor. Monitors are primarily responsible
> > > for data set collection and support the ability to collect any
> > > permutation of data set types. Monitors are also responsible for
> > > interaction with system cross triggering.
> > 
> > As far as I can tell there is nothing related to CTIs in this patch.  And if
> > there is, it is not documented.
> > 
> 
> Please could you add a separate file documenting  the TPDM and
> some of the specific details (what is used by the driver, e.g
> PERPHID0/1 et) under Documentation/trace/coresight/ , in a separate
> patch
> 
> > > 
> > > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > > ---
> > >   .../bindings/arm/coresight-tpdm.yaml          |  86 +++
> > 
> > As checkpatch says, this should be in a separate file.
> > 
> > >   MAINTAINERS                                   |   5 +
> > 
> > Since this is a coresight device Suzuki and I will continue the maintenance.
> > The get_maintainer script will make sure you care CC'ed on patches related to
> > the TPDM/TPDA drivers, and we would typically requried a "Reviewed-by" tag from
> > you before merging.
> > 
> > >   drivers/hwtracing/coresight/Kconfig           |   9 +
> > >   drivers/hwtracing/coresight/Makefile          |   1 +
> > >   drivers/hwtracing/coresight/coresight-tpdm.c  | 583 ++++++++++++++++++
> > >   5 files changed, 684 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> > >   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> > > new file mode 100644
> > > index 000000000000..44541075d77f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> > > @@ -0,0 +1,86 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/coresight-tpdm.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Trace, Profiling and Diagnostics Monitor - TPDM
> > > +
> > > +description: |
> > > +  The TPDM or Monitor serves as data collection component for various dataset
> > > +  types specified in the QPMDA spec. It covers Basic Counts (BC), Tenure
> > > +  Counts (TC), Continuous Multi-Bit (CMB), and Discrete Single Bit (DSB). It
> > > +  performs data collection in the data producing clock domain and transfers it
> > > +  to the data collection time domain, generally ATB clock domain.
> > > +
> > > +  The primary use case of the TPDM is to collect data from different data
> > > +  sources and send it to a TPDA for packetization, timestamping, and funneling.
> > > +
> > > +maintainers:
> > > +  - Tao Zhang <quic_taozha@quicinc.com>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^tpdm(@[0-9a-f]+)$"
> > > +  compatible:
> > > +    items:
> > > +      - const: arm,primecell
> 
> 
> You must have a compatible that identifies this as "tpdm", just like
> the other components, even though it is not functional.
>

We will add it.
 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: tpdm-base
> 
> Is the reg-name really necessary ?
> 

We will check and move it out of required if it is not necessary.

> > > +
> > > +  atid:
> > > +    maxItems: 1
> > > +    description: |
> > > +      The QPMDA specification repurposed the ATID field of the AMBA ATB
> > > +      specification to use it to convey packetization information to the
> > > +      Aggregator.
> 
> Please could you describe how this affects the device in the doc
> requested above.
> 

We will add more info about it. 

> > > +
> > > +  out-ports:
> > > +    description: |
> > > +      Output connections from the TPDM to legacy CoreSight trace bus.
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    properties:
> > > +      port:
> > > +        description: Output connection from the TPDM to legacy CoreSight
> > > +          Trace bus.
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - atid
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  # minimum TPDM definition.
> > > +  - |
> > > +    tpdm@6980000 {
> > > +      compatible = "arm,primecell";
> 
> Like other components, we must have :
> 	  compatible = "qcom,<new-compatible>", "arm,primecell";
> 
> > > +      reg = <0x6980000 0x1000>;
> > > +      reg-names = "tpdm-base";
> > > +
> > > +      clocks = <&aoss_qmp>;
> > > +      clock-names = "apb_pclk";
> > > +
> > > +      atid = <78>;
> > > +      out-ports {
> > > +        port {
> > > +          tpdm_turing_out_funnel_turing: endpoint {
> > > +            remote-endpoint =
> > > +              <&funnel_turing_in_tpdm_turing>;
> > > +          };
> > > +        };
> > > +      };
> > > +    };
> > > +
> > > +...
> 
> > > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > > index b6c4a48140ec..e7392a0dddeb 100644
> > > --- a/drivers/hwtracing/coresight/Makefile
> > > +++ b/drivers/hwtracing/coresight/Makefile
> > > @@ -25,5 +25,6 @@ obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> > >   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> > >   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
> > >   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
> > > +obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
> > >   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
> > >   		   coresight-cti-sysfs.o
> > > diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> > > new file mode 100644
> > > index 000000000000..906776c859d6
> > > --- /dev/null
> > > +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> 
> ...
> 
> > > +
> > > +#ifdef CONFIG_CORESIGHT_TPDM_DEFAULT_ENABLE
> > > +static int boot_enable = 1;
> > > +#else
> > > +static int boot_enable;
> > > +#endif
> > 
> > That isn't the proper way to do this.  Look at how it is done in
> > coresight-etm4x.c
> > 
> > > +
> > > +struct gpr_dataset {
> > > +	DECLARE_BITMAP(gpr_dirty, TPDM_GPR_REGS_MAX);
> > > +	uint32_t		gp_regs[TPDM_GPR_REGS_MAX];
> > 
> > Shouldn't this be u32?
> > 
> > > +};
> > > +
> > > +struct bc_dataset {
> > > +	enum tpdm_mode		capture_mode;
> > > +	enum tpdm_mode		retrieval_mode;
> > > +	uint32_t		sat_mode;
> > > +	uint32_t		enable_counters;
> > > +	uint32_t		clear_counters;
> > > +	uint32_t		enable_irq;
> > > +	uint32_t		clear_irq;
> > > +	uint32_t		trig_val_lo[TPDM_BC_MAX_COUNTERS];
> > > +	uint32_t		trig_val_hi[TPDM_BC_MAX_COUNTERS];
> > > +	uint32_t		enable_ganging;
> > > +	uint32_t		overflow_val[TPDM_BC_MAX_OVERFLOW];
> > > +	uint32_t		msr[TPDM_BC_MAX_MSR];
> > > +};
> > > +
> > > +struct tc_dataset {
> > > +	enum tpdm_mode		capture_mode;
> > > +	enum tpdm_mode		retrieval_mode;
> > > +	bool			sat_mode;
> > > +	uint32_t		enable_counters;
> > > +	uint32_t		clear_counters;
> > > +	uint32_t		enable_irq;
> > > +	uint32_t		clear_irq;
> > > +	uint32_t		trig_sel[TPDM_TC_MAX_TRIG];
> > > +	uint32_t		trig_val_lo[TPDM_TC_MAX_TRIG];
> > > +	uint32_t		trig_val_hi[TPDM_TC_MAX_TRIG];
> > > +	uint32_t		msr[TPDM_TC_MAX_MSR];
> > > +};
> > > +
> > > +struct dsb_dataset {
> > > +	uint32_t		mode;
> > > +	uint32_t		edge_ctrl[TPDM_DSB_MAX_EDCR];
> > > +	uint32_t		edge_ctrl_mask[TPDM_DSB_MAX_EDCR / 2];
> > > +	uint32_t		patt_val[TPDM_DSB_MAX_PATT];
> > > +	uint32_t		patt_mask[TPDM_DSB_MAX_PATT];
> > > +	bool			patt_ts;
> > > +	bool			patt_type;
> > > +	uint32_t		trig_patt_val[TPDM_DSB_MAX_PATT];
> > > +	uint32_t		trig_patt_mask[TPDM_DSB_MAX_PATT];
> > > +	bool			trig_ts;
> > > +	bool			trig_type;
> > > +	uint32_t		select_val[TPDM_DSB_MAX_SELECT];
> > > +	uint32_t		msr[TPDM_DSB_MAX_MSR];
> > > +};
> > > +
> > > +struct mcmb_dataset {
> > > +	uint8_t		mcmb_trig_lane;
> > > +	uint8_t		mcmb_lane_select;
> > > +};
> > > +
> > > +struct cmb_dataset {
> > > +	bool			trace_mode;
> > > +	uint32_t		cycle_acc;
> > > +	uint32_t		patt_val[TPDM_CMB_PATT_CMP];
> > > +	uint32_t		patt_mask[TPDM_CMB_PATT_CMP];
> > > +	bool			patt_ts;
> > > +	uint32_t		trig_patt_val[TPDM_CMB_PATT_CMP];
> > > +	uint32_t		trig_patt_mask[TPDM_CMB_PATT_CMP];
> > > +	bool			trig_ts;
> > > +	bool			ts_all;
> > > +	uint32_t		msr[TPDM_CMB_MAX_MSR];
> > > +	uint8_t			read_ctl_reg;
> > > +	struct mcmb_dataset	*mcmb;
> > > +};
> > > +
> > > +DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
> > > +
> > > +struct tpdm_drvdata {
> > > +	void __iomem		*base;
> > > +	struct device		*dev;
> > > +	struct coresight_device	*csdev;
> > > +	int			nr_tclk;
> > > +	struct clk		**tclk;
> > > +	int			nr_treg;
> > > +	struct regulator	**treg;
> > > +	struct mutex		lock;
> > > +	bool			enable;
> > > +	bool			clk_enable;
> > > +	DECLARE_BITMAP(datasets, TPDM_DATASETS);
> > > +	DECLARE_BITMAP(enable_ds, TPDM_DATASETS);
> > > +	enum tpdm_support_type	tc_trig_type;
> > > +	enum tpdm_support_type	bc_trig_type;
> > > +	enum tpdm_support_type	bc_gang_type;
> > > +	uint32_t		bc_counters_avail;
> > > +	uint32_t		tc_counters_avail;
> > > +	struct gpr_dataset	*gpr;
> > > +	struct bc_dataset	*bc;
> > > +	struct tc_dataset	*tc;
> > > +	struct dsb_dataset	*dsb;
> > > +	struct cmb_dataset	*cmb;
> > > +	int			traceid;
> > > +	uint32_t		version;
> > > +	bool			msr_support;
> > > +	bool			msr_fix_req;
> > > +	bool			cmb_msr_skip;
> > > +};
> > 
> > All of these should also be in a header file and properly documented.
> > 
> > > +
> > > +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata);
> > 
> > This isn't needed.
> > 
> > > +
> > > +static void __tpdm_enable(struct tpdm_drvdata *drvdata)
> > > +{
> > > +	TPDM_UNLOCK(drvdata);
> > > +
> > > +	if (drvdata->clk_enable)
> > > +		tpdm_writel(drvdata, 0x1, TPDM_CLK_CTRL);
> > > +
> > > +	TPDM_LOCK(drvdata);
> > > +}
> > > +
> 
> > > +static const struct coresight_ops_source tpdm_source_ops = {
> > > +	.trace_id	= tpdm_trace_id,
> > > +	.enable		= tpdm_enable,
> > > +	.disable	= tpdm_disable,
> > > +};
> > > +
> > > +static const struct coresight_ops tpdm_cs_ops = {
> > > +	.source_ops	= &tpdm_source_ops,
> > > +};
> > > +
> > > +static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
> > > +{
> > > +	if (test_bit(TPDM_DS_GPR, drvdata->datasets)) {
> > > +		drvdata->gpr = devm_kzalloc(drvdata->dev, sizeof(*drvdata->gpr),
> > > +					    GFP_KERNEL);
> > > +		if (!drvdata->gpr)
> > > +			return -ENOMEM;
> > > +	}
> > > +	if (test_bit(TPDM_DS_BC, drvdata->datasets)) {
> > > +		drvdata->bc = devm_kzalloc(drvdata->dev, sizeof(*drvdata->bc),
> > > +					   GFP_KERNEL);
> > > +		if (!drvdata->bc)
> > > +			return -ENOMEM;
> > > +	}
> > > +	if (test_bit(TPDM_DS_TC, drvdata->datasets)) {
> > > +		drvdata->tc = devm_kzalloc(drvdata->dev, sizeof(*drvdata->tc),
> > > +					   GFP_KERNEL);
> > > +		if (!drvdata->tc)
> > > +			return -ENOMEM;
> > > +	}
> > > +	if (test_bit(TPDM_DS_DSB, drvdata->datasets)) {
> > > +		drvdata->dsb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->dsb),
> > > +					    GFP_KERNEL);
> > > +		if (!drvdata->dsb)
> > > +			return -ENOMEM;
> > > +	}
> > > +	if (test_bit(TPDM_DS_CMB, drvdata->datasets)) {
> > > +		drvdata->cmb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->cmb),
> > > +					    GFP_KERNEL);
> > > +		if (!drvdata->cmb)
> > > +			return -ENOMEM;
> > > +	} else if (test_bit(TPDM_DS_MCMB, drvdata->datasets)) {
> > > +		drvdata->cmb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->cmb),
> > > +					    GFP_KERNEL);
> > > +		if (!drvdata->cmb)
> > > +			return -ENOMEM;
> > > +		drvdata->cmb->mcmb = devm_kzalloc(drvdata->dev,
> > > +						  sizeof(*drvdata->cmb->mcmb),
> > > +						  GFP_KERNEL);
> > > +		if (!drvdata->cmb->mcmb)
> > > +			return -ENOMEM;
> > 
> > How can I understand what the above does when:
> > 
> > 1) There isn't a single line of comments.
> > 2) I don't know the HW.
> > 3) I don't have access to the documentation.
> 
> +1
> 
> > 
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> > > +{
> > > +	if (test_bit(TPDM_DS_BC, drvdata->datasets))
> > > +		drvdata->bc->retrieval_mode = TPDM_MODE_ATB;
> > > +
> > > +	if (test_bit(TPDM_DS_TC, drvdata->datasets))
> > > +		drvdata->tc->retrieval_mode = TPDM_MODE_ATB;
> > > +
> > > +	if (test_bit(TPDM_DS_DSB, drvdata->datasets)) {
> > > +		drvdata->dsb->trig_ts = true;
> > > +		drvdata->dsb->trig_type = false;
> > > +	}
> > > +
> > > +	if (test_bit(TPDM_DS_CMB, drvdata->datasets) ||
> > > +	    test_bit(TPDM_DS_MCMB, drvdata->datasets))
> > > +		drvdata->cmb->trig_ts = true;
> > > +}
> > > +
> > > +static int tpdm_parse_of_data(struct tpdm_drvdata *drvdata)
> > > +{
> > > +	int i, ret;
> > > +	const char *tclk_name, *treg_name;
> > > +	struct device_node *node = drvdata->dev->of_node;
> > > +
> > > +	drvdata->clk_enable = of_property_read_bool(node, "qcom,clk-enable");
> > > +	drvdata->msr_fix_req = of_property_read_bool(node, "qcom,msr-fix-req");
> > > +	drvdata->cmb_msr_skip = of_property_read_bool(node,
> > > +					"qcom,cmb-msr-skip");
> > > +
> 
> These properties must be listed as optional/mandatory in the DT binding
> with proper description.

We will add them to dt binding doc.
> 
> > > +	drvdata->nr_tclk = of_property_count_strings(node, "qcom,tpdm-clks");
> > > +	if (drvdata->nr_tclk > 0) {
> > > +		drvdata->tclk = devm_kzalloc(drvdata->dev, drvdata->nr_tclk *
> > > +					     sizeof(*drvdata->tclk),
> > > +					     GFP_KERNEL);
> > > +		if (!drvdata->tclk)
> > > +			return -ENOMEM;
> > > +
> > > +		for (i = 0; i < drvdata->nr_tclk; i++) {
> > > +			ret = of_property_read_string_index(node,
> > > +					    "qcom,tpdm-clks", i, &tclk_name);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			drvdata->tclk[i] = devm_clk_get(drvdata->dev,
> > > +							tclk_name);
> > > +			if (IS_ERR(drvdata->tclk[i]))
> > > +				return PTR_ERR(drvdata->tclk[i]);
> > > +		}
> > > +	}
> > > +
> > > +	drvdata->nr_treg = of_property_count_strings(node, "qcom,tpdm-regs");
> 
> Where is this documented in the DT ?
>

We will add the doc for this.
 
> > > +	if (drvdata->nr_treg > 0) {
> > > +		drvdata->treg = devm_kzalloc(drvdata->dev, drvdata->nr_treg *
> > > +					     sizeof(*drvdata->treg),
> > > +					     GFP_KERNEL);
> > > +		if (!drvdata->treg)
> > > +			return -ENOMEM;
> > > +
> > > +		for (i = 0; i < drvdata->nr_treg; i++) {
> > > +			ret = of_property_read_string_index(node,
> > > +					    "qcom,tpdm-regs", i, &treg_name);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			drvdata->treg[i] = devm_regulator_get(drvdata->dev,
> > > +							treg_name);
> > > +			if (IS_ERR(drvdata->treg[i]))
> > > +				return PTR_ERR(drvdata->treg[i]);
> > > +		}
> > > +	}
> > 
> > _None_ of the above are defined in the yaml file and/or part of the example that
> > is shown there.  Moreover they don't appear in patch 10/10 where TPDM and TPDA are
> > supposed to be introduced.  I will comment on patch 10/10 when I'm done with
> > this one.
> 
> +1
> 
> Suzuki
