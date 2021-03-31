Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B8350420
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhCaQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:06:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56746 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233767AbhCaQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:06:41 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VG3R8T009627;
        Wed, 31 Mar 2021 18:06:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pa6mk3ADurOHKB91VtYeoou921Y+1mFGdpCGMs0+3dk=;
 b=tP1tU1PD8StDtBsoAwL8hd8gPgy9hNfOpFAx+tRwvuCVA2kf4XoEnPIuQRCerJPSQGeS
 6bXxrtbAJiFu0EFdNaFvBRwdlLRsWUZbFd/+vS280daLXUMebOoeGDTH+eLmhYY3GanI
 MTT9cdLJBd85eR05iRyFz/HXOsZclYMRniTZ/UqnH4Fj9qqUOko1GsnfOK16SZRvBT+9
 5GO9febmwnW+DIpqoKy46qkpUJPJtfEJgBtqL1sA89OW2K77bsEEW3vYEk9kWhiMtSn5
 nMMMGMOL5sRzs1P7LUlsxN5GvzwuqAy/CZ+Tk6JiI+9PvulECDT8ThHQimK0wv0e6WoQ 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37maamwt65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 18:06:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BF3A10002A;
        Wed, 31 Mar 2021 18:06:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83D11215EFA;
        Wed, 31 Mar 2021 18:06:23 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 18:06:22 +0200
Subject: Re: [PATCH v3 2/7] clk: st: flexgen: embed soc clock outputs within
 compatible data
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210330205125.25708-1-avolmat@me.com>
 <20210330205125.25708-3-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <c1595010-c001-807c-b109-a3d8e572dd4d@foss.st.com>
Date:   Wed, 31 Mar 2021 18:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330205125.25708-3-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_08:2021-03-31,2021-03-31 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

I have tested your series on STiH410-B2260 board and it misses a critical flag, see below

On 3/30/21 10:51 PM, Alain Volmat wrote:
> In order to avoid relying on the old style description via the DT
> clock-output-names, add compatible data describing the flexgen
> outputs clocks for all STiH407/STiH410 and STiH418 SOCs.
> 
> In order to ease transition between the two methods, this commit
> introduce the new compatible without removing the old method.
> Once DTs will be fixed, the method relying on DT clock-output-names
> will be removed from this driver as well as old compatibles.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v3: add comments about CLK_IS_CRITICAL reason
>     don't put clk-proc-stfe as CLK_IS_CRITICAL
> v2: add some missing clock as CLK_IS_CRITICAL
> 
>  drivers/clk/st/clk-flexgen.c | 366 +++++++++++++++++++++++++++++++++--
>  1 file changed, 352 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
> index 55873d4b7603..69711c6c47a4 100644
> --- a/drivers/clk/st/clk-flexgen.c
> +++ b/drivers/clk/st/clk-flexgen.c
> @@ -16,9 +16,16 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  
> +struct clkgen_clk_out {
> +	const char *name;
> +	unsigned long flags;
> +};
> +
>  struct clkgen_data {
>  	unsigned long flags;
>  	bool mode;
> +	const struct clkgen_clk_out *outputs;
> +	const unsigned int outputs_nb;
>  };
>  
>  struct flexgen {
> @@ -295,6 +302,289 @@ static const struct clkgen_data clkgen_video = {
>  	.mode = 1,
>  };
>  
> +static const struct clkgen_clk_out clkgen_stih407_a0_clk_out[] = {
> +	/* This clk needs to be on so that memory interface is accessible */
> +	{ .name = "clk-ic-lmi0", .flags = CLK_IS_CRITICAL },
> +};
> +
> +static const struct clkgen_data clkgen_stih407_a0 = {
> +	.outputs = clkgen_stih407_a0_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih407_a0_clk_out),
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih410_a0_clk_out[] = {
> +	/* Those clks need to be on so that memory interface is accessible */
> +	{ .name = "clk-ic-lmi0", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-ic-lmi1", .flags = CLK_IS_CRITICAL },
> +};
> +
> +static const struct clkgen_data clkgen_stih410_a0 = {
> +	.outputs = clkgen_stih410_a0_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih410_a0_clk_out),
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih407_c0_clk_out[] = {
> +	{ .name = "clk-icn-gpu", },
> +	{ .name = "clk-fdma", },
> +	{ .name = "clk-nand", },
> +	{ .name = "clk-hva", },
> +	{ .name = "clk-proc-stfe", },
> +	{ .name = "clk-proc-tp", },
> +	{ .name = "clk-rx-icn-dmu", },
> +	{ .name = "clk-rx-icn-hva", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-cpu", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-tx-icn-dmu", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-mmc-0", },
> +	{ .name = "clk-mmc-1", },
> +	{ .name = "clk-jpegdec", },
> +	/* This clk needs to be on to keep A9 running */
> +	{ .name = "clk-ext2fa9", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-ic-bdisp-0", },
> +	{ .name = "clk-ic-bdisp-1", },
> +	{ .name = "clk-pp-dmu", },
> +	{ .name = "clk-vid-dmu", },
> +	{ .name = "clk-dss-lpc", },
> +	{ .name = "clk-st231-aud-0", },
> +	{ .name = "clk-st231-gp-1", },
> +	{ .name = "clk-st231-dmu", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-lmi", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-tx-icn-disp-1", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-sbc", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-stfe-frc2", },
> +	{ .name = "clk-eth-phy", },
> +	{ .name = "clk-eth-ref-phyclk", },
> +	{ .name = "clk-flash-promip", },
> +	{ .name = "clk-main-disp", },
> +	{ .name = "clk-aux-disp", },
> +	{ .name = "clk-compo-dvp", },
> +};
> +
> +static const struct clkgen_data clkgen_stih407_c0 = {
> +	.outputs = clkgen_stih407_c0_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih407_c0_clk_out),
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih410_c0_clk_out[] = {
> +	{ .name = "clk-icn-gpu", },
> +	{ .name = "clk-fdma", },
> +	{ .name = "clk-nand", },
> +	{ .name = "clk-hva", },
> +	{ .name = "clk-proc-stfe", },
> +	{ .name = "clk-proc-tp", },
> +	{ .name = "clk-rx-icn-dmu", },
> +	{ .name = "clk-rx-icn-hva", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-cpu", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-tx-icn-dmu", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-mmc-0", },
> +	{ .name = "clk-mmc-1", },
> +	{ .name = "clk-jpegdec", },
> +	/* This clk needs to be on to keep A9 running */
> +	{ .name = "clk-ext2fa9", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-ic-bdisp-0", },
> +	{ .name = "clk-ic-bdisp-1", },
> +	{ .name = "clk-pp-dmu", },
> +	{ .name = "clk-vid-dmu", },
> +	{ .name = "clk-dss-lpc", },
> +	{ .name = "clk-st231-aud-0", },
> +	{ .name = "clk-st231-gp-1", },
> +	{ .name = "clk-st231-dmu", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-lmi", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-tx-icn-disp-1", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-sbc", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-stfe-frc2", },
> +	{ .name = "clk-eth-phy", },
> +	{ .name = "clk-eth-ref-phyclk", },
> +	{ .name = "clk-flash-promip", },
> +	{ .name = "clk-main-disp", },
> +	{ .name = "clk-aux-disp", },
> +	{ .name = "clk-compo-dvp", },
> +	{ .name = "clk-tx-icn-hades", },
> +	{ .name = "clk-rx-icn-hades", },
> +	{ .name = "clk-icn-reg-16", },

Need to add CLK_IS_CRITICAL for clk-icn-reg-16
This was a long time bug which is hidden by usage of clk_ignore_unused in bootargs.

With that fix, you can add 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

> +	{ .name = "clk-pp-hades", },
> +	{ .name = "clk-clust-hades", },
> +	{ .name = "clk-hwpe-hades", },
> +	{ .name = "clk-fc-hades", },
> +};
> +
> +static const struct clkgen_data clkgen_stih410_c0 = {
> +	.outputs = clkgen_stih410_c0_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih410_c0_clk_out),
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih418_c0_clk_out[] = {
> +	{ .name = "clk-icn-gpu", },
> +	{ .name = "clk-fdma", },
> +	{ .name = "clk-nand", },
> +	{ .name = "clk-hva", },
> +	{ .name = "clk-proc-stfe", },
> +	{ .name = "clk-tp", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-rx-icn-dmu", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-rx-icn-hva", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-icn-cpu", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-tx-icn-dmu", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-mmc-0", },
> +	{ .name = "clk-mmc-1", },
> +	{ .name = "clk-jpegdec", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-reg", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-proc-bdisp-0", },
> +	{ .name = "clk-proc-bdisp-1", },
> +	{ .name = "clk-pp-dmu", },
> +	{ .name = "clk-vid-dmu", },
> +	{ .name = "clk-dss-lpc", },
> +	{ .name = "clk-st231-aud-0", },
> +	{ .name = "clk-st231-gp-1", },
> +	{ .name = "clk-st231-dmu", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-lmi", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-tx-icn-1", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-sbc", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-stfe-frc2", },
> +	{ .name = "clk-eth-phyref", },
> +	{ .name = "clk-eth-ref-phyclk", },
> +	{ .name = "clk-flash-promip", },
> +	{ .name = "clk-main-disp", },
> +	{ .name = "clk-aux-disp", },
> +	{ .name = "clk-compo-dvp", },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-tx-icn-hades", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-rx-icn-hades", .flags = CLK_IS_CRITICAL },
> +	/* This clk needs to be on to keep bus interconnect alive */
> +	{ .name = "clk-icn-reg-16", .flags = CLK_IS_CRITICAL },
> +	{ .name = "clk-pp-hevc", },
> +	{ .name = "clk-clust-hevc", },
> +	{ .name = "clk-hwpe-hevc", },
> +	{ .name = "clk-fc-hevc", },
> +	{ .name = "clk-proc-mixer", },
> +	{ .name = "clk-proc-sc", },
> +	{ .name = "clk-avsp-hevc", },
> +};
> +
> +static const struct clkgen_data clkgen_stih418_c0 = {
> +	.outputs = clkgen_stih418_c0_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih418_c0_clk_out),
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih407_d0_clk_out[] = {
> +	{ .name = "clk-pcm-0", },
> +	{ .name = "clk-pcm-1", },
> +	{ .name = "clk-pcm-2", },
> +	{ .name = "clk-spdiff", },
> +};
> +
> +static const struct clkgen_data clkgen_stih407_d0 = {
> +	.flags = CLK_SET_RATE_PARENT,
> +	.outputs = clkgen_stih407_d0_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih407_d0_clk_out),
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih410_d0_clk_out[] = {
> +	{ .name = "clk-pcm-0", },
> +	{ .name = "clk-pcm-1", },
> +	{ .name = "clk-pcm-2", },
> +	{ .name = "clk-spdiff", },
> +	{ .name = "clk-pcmr10-master", },
> +	{ .name = "clk-usb2-phy", },
> +};
> +
> +static const struct clkgen_data clkgen_stih410_d0 = {
> +	.flags = CLK_SET_RATE_PARENT,
> +	.outputs = clkgen_stih410_d0_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih410_d0_clk_out),
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih407_d2_clk_out[] = {
> +	{ .name = "clk-pix-main-disp", },
> +	{ .name = "clk-pix-pip", },
> +	{ .name = "clk-pix-gdp1", },
> +	{ .name = "clk-pix-gdp2", },
> +	{ .name = "clk-pix-gdp3", },
> +	{ .name = "clk-pix-gdp4", },
> +	{ .name = "clk-pix-aux-disp", },
> +	{ .name = "clk-denc", },
> +	{ .name = "clk-pix-hddac", },
> +	{ .name = "clk-hddac", },
> +	{ .name = "clk-sddac", },
> +	{ .name = "clk-pix-dvo", },
> +	{ .name = "clk-dvo", },
> +	{ .name = "clk-pix-hdmi", },
> +	{ .name = "clk-tmds-hdmi", },
> +	{ .name = "clk-ref-hdmiphy", },
> +};
> +
> +static const struct clkgen_data clkgen_stih407_d2 = {
> +	.outputs = clkgen_stih407_d2_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih407_d2_clk_out),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.mode = 1,
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih418_d2_clk_out[] = {
> +	{ .name = "clk-pix-main-disp", },
> +	{ .name = "", },
> +	{ .name = "", },
> +	{ .name = "", },
> +	{ .name = "", },
> +	{ .name = "clk-tmds-hdmi-div2", },
> +	{ .name = "clk-pix-aux-disp", },
> +	{ .name = "clk-denc", },
> +	{ .name = "clk-pix-hddac", },
> +	{ .name = "clk-hddac", },
> +	{ .name = "clk-sddac", },
> +	{ .name = "clk-pix-dvo", },
> +	{ .name = "clk-dvo", },
> +	{ .name = "clk-pix-hdmi", },
> +	{ .name = "clk-tmds-hdmi", },
> +	{ .name = "clk-ref-hdmiphy", },
> +	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "", }, { .name = "", }, { .name = "", },
> +	{ .name = "clk-vp9", },
> +};
> +
> +static const struct clkgen_data clkgen_stih418_d2 = {
> +	.outputs = clkgen_stih418_d2_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih418_d2_clk_out),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.mode = 1,
> +};
> +
> +static const struct clkgen_clk_out clkgen_stih407_d3_clk_out[] = {
> +	{ .name = "clk-stfe-frc1", },
> +	{ .name = "clk-tsout-0", },
> +	{ .name = "clk-tsout-1", },
> +	{ .name = "clk-mchi", },
> +	{ .name = "clk-vsens-compo", },
> +	{ .name = "clk-frc1-remote", },
> +	{ .name = "clk-lpc-0", },
> +	{ .name = "clk-lpc-1", },
> +};
> +
> +static const struct clkgen_data clkgen_stih407_d3 = {
> +	.outputs = clkgen_stih407_d3_clk_out,
> +	.outputs_nb = ARRAY_SIZE(clkgen_stih407_d3_clk_out),
> +};
> +
>  static const struct of_device_id flexgen_of_match[] = {
>  	{
>  		.compatible = "st,flexgen-audio",
> @@ -304,6 +594,46 @@ static const struct of_device_id flexgen_of_match[] = {
>  		.compatible = "st,flexgen-video",
>  		.data = &clkgen_video,
>  	},
> +	{
> +		.compatible = "st,flexgen-stih407-a0",
> +		.data = &clkgen_stih407_a0,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih410-a0",
> +		.data = &clkgen_stih410_a0,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih407-c0",
> +		.data = &clkgen_stih407_c0,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih410-c0",
> +		.data = &clkgen_stih410_c0,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih418-c0",
> +		.data = &clkgen_stih418_c0,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih407-d0",
> +		.data = &clkgen_stih407_d0,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih410-d0",
> +		.data = &clkgen_stih410_d0,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih407-d2",
> +		.data = &clkgen_stih407_d2,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih418-d2",
> +		.data = &clkgen_stih418_d2,
> +	},
> +	{
> +		.compatible = "st,flexgen-stih407-d3",
> +		.data = &clkgen_stih407_d3,
> +	},
>  	{}
>  };
>  
> @@ -320,6 +650,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
>  	unsigned long flex_flags = 0;
>  	int ret;
>  	bool clk_mode = 0;
> +	const char *clk_name;
>  
>  	pnode = of_get_parent(np);
>  	if (!pnode)
> @@ -347,13 +678,17 @@ static void __init st_of_flexgen_setup(struct device_node *np)
>  	if (!clk_data)
>  		goto err;
>  
> -	ret = of_property_count_strings(np, "clock-output-names");
> -	if (ret <= 0) {
> -		pr_err("%s: Failed to get number of output clocks (%d)",
> -				__func__, clk_data->clk_num);
> -		goto err;
> -	}
> -	clk_data->clk_num = ret;
> +	/* First try to get output information from the compatible data */
> +	if (!data || !data->outputs_nb || !data->outputs) {
> +		ret = of_property_count_strings(np, "clock-output-names");
> +		if (ret <= 0) {
> +			pr_err("%s: Failed to get number of output clocks (%d)",
> +					__func__, clk_data->clk_num);
> +			goto err;
> +		}
> +		clk_data->clk_num = ret;
> +	} else
> +		clk_data->clk_num = data->outputs_nb;
>  
>  	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
>  			GFP_KERNEL);
> @@ -368,16 +703,19 @@ static void __init st_of_flexgen_setup(struct device_node *np)
>  
>  	for (i = 0; i < clk_data->clk_num; i++) {
>  		struct clk *clk;
> -		const char *clk_name;
>  
> -		if (of_property_read_string_index(np, "clock-output-names",
> -						  i, &clk_name)) {
> -			break;
> +		if (!data || !data->outputs_nb || !data->outputs) {
> +			if (of_property_read_string_index(np,
> +							  "clock-output-names",
> +							  i, &clk_name))
> +				break;
> +			flex_flags &= ~CLK_IS_CRITICAL;
> +			of_clk_detect_critical(np, i, &flex_flags);
> +		} else {
> +			clk_name = data->outputs[i].name;
> +			flex_flags = data->flags | data->outputs[i].flags;
>  		}
>  
> -		flex_flags &= ~CLK_IS_CRITICAL;
> -		of_clk_detect_critical(np, i, &flex_flags);
> -
>  		/*
>  		 * If we read an empty clock name then the output is unused
>  		 */
> 
