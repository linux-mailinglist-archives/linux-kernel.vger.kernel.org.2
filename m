Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58464207E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhJDJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:11:05 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57618
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhJDJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:11:00 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EDF1640600
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633338550;
        bh=rPuJDjYQWPRwMXkpdOJmSbsQIFCuINqKAXWHwqAnZoQ=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=PNgAWb31pY6naBjK2/Td8zUSM1yxhn2RNRuRVuHWD2l/WHOmyNwpsKZ6Cd6OVxvrq
         waJP4WM7iDPl9+dljKLQzDOBYeKQ2bWoc8JL6DwBn8b0JuS/X0zmaqexkpbwvXrJKz
         EN1nVo3SJsgPlz2TJdT8Y7/18apGNylAXkRt7KPNVNNy2Wtl+PvkSvixzSpFOjKJef
         fzOOp3W9AbmNhjibYJ55UMgQOJFu9AIbmE3Yxd3OOiotBZTMXIzta//dYy/9wc099B
         Cb+uLyIwJOi8BsjZfFeonBj9SKLe08gottWkzOFsT3ApADK3wzRRmfwMer3XQ/Exoh
         FQcKHzw51VWVg==
Received: by mail-lf1-f71.google.com with SMTP id s8-20020ac25c48000000b003faf62e104eso13617804lfp.22
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 02:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rPuJDjYQWPRwMXkpdOJmSbsQIFCuINqKAXWHwqAnZoQ=;
        b=DCn6S+b0RxGsm/3D1i0oxD5Gi4UTTok1+/QV0fA0CVxgb/mwj05fNYn4nGaUBUcMnk
         4opZuYotnpneJTWtGlKxjs8zpJWQTEy5TydRgsvcTVdKRkUkzvE3Qk9VAbeQH/z/Ajaz
         PRB8QgS4y41Hf07l1Rh+gULWyfHm7yoYVP5jcg1qA7nNaYIMnBWFknITx/EowkffyY8O
         5ERqCEnbyjMztDyPP5sfQjAmzRhV79lElhLnrAhLw3AJLi1oIz0tKGLeBykagnZrXZpU
         RympRHmxttxjw31lvkkFTjLekRmHm1uDqveNNmGUxPKEhR1thb8EXBZrClKG0V93PfgC
         9n8g==
X-Gm-Message-State: AOAM530w/OyCfX4tK0WS10KCVn9wgeNUtRDlvji2T3hjQNYSb35NEZaR
        84ezSoZzUhpwLMtWU9jwBI+xvNbTU9DIBxEIL2iTOl7E9G6+taUmpn20N94mLgY/f41Tudy44TV
        mqf29nk/6ZI89I0gBEWo5n8AhUEb43zriSlH6lH9T5Q==
X-Received: by 2002:a19:c1d2:: with SMTP id r201mr8649228lff.364.1633338550332;
        Mon, 04 Oct 2021 02:09:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/dn80ttD8wiRdWooI+R8DXE1sQr3xZVkoSZeqW6NrNY7JYFLeZVbN/OOAFXfLwAz3PWav5Q==
X-Received: by 2002:a19:c1d2:: with SMTP id r201mr8649205lff.364.1633338550068;
        Mon, 04 Oct 2021 02:09:10 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id v3sm1445005lfr.295.2021.10.04.02.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 02:09:09 -0700 (PDT)
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20211003013235.2357-1-digetx@gmail.com>
 <20211003013235.2357-5-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 4/4] memory: tegra20-emc: Support matching timings by
 LPDDR2 configuration
Message-ID: <636b147b-0a71-8c40-7038-1227918986e5@canonical.com>
Date:   Mon, 4 Oct 2021 11:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211003013235.2357-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2021 03:32, Dmitry Osipenko wrote:
> Asus Transformer TF101 doesn't provide RAM code and in this case memory
> timings should be selected based on identity information read out from
> SDRAM chip. Support matching timings by LPDDR2 configuration.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |   1 +
>  drivers/memory/tegra/tegra20-emc.c | 191 +++++++++++++++++++++++++++--
>  2 files changed, 179 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
> index f9bae36c03a3..7951764b4efe 100644
> --- a/drivers/memory/tegra/Kconfig
> +++ b/drivers/memory/tegra/Kconfig
> @@ -16,6 +16,7 @@ config TEGRA20_EMC
>  	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_DEVFREQ
> +	select DDR
>  	help
>  	  This driver is for the External Memory Controller (EMC) found on
>  	  Tegra20 chips. The EMC controls the external DRAM on the board.
> diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
> index c3462dbc8c22..8965cdff43b9 100644
> --- a/drivers/memory/tegra/tegra20-emc.c
> +++ b/drivers/memory/tegra/tegra20-emc.c
> @@ -5,6 +5,7 @@
>   * Author: Dmitry Osipenko <digetx@gmail.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/debugfs.h>
> @@ -27,11 +28,15 @@
>  #include <soc/tegra/common.h>
>  #include <soc/tegra/fuse.h>
>  
> +#include "../jedec_ddr.h"
> +#include "../of_memory.h"
> +
>  #include "mc.h"
>  
>  #define EMC_INTSTATUS				0x000
>  #define EMC_INTMASK				0x004
>  #define EMC_DBG					0x008
> +#define EMC_ADR_CFG_0				0x010
>  #define EMC_TIMING_CONTROL			0x028
>  #define EMC_RC					0x02c
>  #define EMC_RFC					0x030
> @@ -68,6 +73,7 @@
>  #define EMC_QUSE_EXTRA				0x0ac
>  #define EMC_ODT_WRITE				0x0b0
>  #define EMC_ODT_READ				0x0b4
> +#define EMC_MRR					0x0ec
>  #define EMC_FBIO_CFG5				0x104
>  #define EMC_FBIO_CFG6				0x114
>  #define EMC_STAT_CONTROL			0x160
> @@ -94,6 +100,7 @@
>  
>  #define EMC_REFRESH_OVERFLOW_INT		BIT(3)
>  #define EMC_CLKCHANGE_COMPLETE_INT		BIT(4)
> +#define EMC_MRR_DIVLD_INT			BIT(5)
>  
>  #define EMC_DBG_READ_MUX_ASSEMBLY		BIT(0)
>  #define EMC_DBG_WRITE_MUX_ACTIVE		BIT(1)
> @@ -102,11 +109,25 @@
>  #define EMC_DBG_CFG_PRIORITY			BIT(24)
>  
>  #define EMC_FBIO_CFG5_DRAM_WIDTH_X16		BIT(4)
> +#define EMC_FBIO_CFG5_DRAM_TYPE			GENMASK(1, 0)
> +
> +#define EMC_MRR_DEV_SELECTN			GENMASK(31, 30)
> +#define EMC_MRR_MRR_MA				GENMASK(23, 16)
> +#define EMC_MRR_MRR_DATA			GENMASK(15, 0)
> +
> +#define EMC_ADR_CFG_0_EMEM_NUMDEV		GENMASK(25, 24)
>  
>  #define EMC_PWR_GATHER_CLEAR			(1 << 8)
>  #define EMC_PWR_GATHER_DISABLE			(2 << 8)
>  #define EMC_PWR_GATHER_ENABLE			(3 << 8)
>  
> +enum emc_dram_type {
> +	DRAM_TYPE_RESERVED,
> +	DRAM_TYPE_DDR1,
> +	DRAM_TYPE_LPDDR2,
> +	DRAM_TYPE_DDR2,
> +};
> +
>  static const u16 emc_timing_registers[] = {
>  	EMC_RC,
>  	EMC_RFC,
> @@ -201,6 +222,12 @@ struct tegra_emc {
>  	struct mutex rate_lock;
>  
>  	struct devfreq_simple_ondemand_data ondemand_data;
> +
> +	/* memory chip identity information */
> +	union lpddr2_basic_config4 basic_conf4;
> +	unsigned int manufacturer_id;
> +	unsigned int revision_id1;
> +	unsigned int revision_id2;
>  };
>  
>  static irqreturn_t tegra_emc_isr(int irq, void *data)
> @@ -401,6 +428,9 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
>  	timing = emc->timings;
>  
>  	for_each_child_of_node(node, child) {
> +		if (of_node_name_eq(child, "lpddr2-configuration"))
> +			continue;
> +
>  		err = load_one_timing_from_dt(emc, timing++, child);
>  		if (err) {
>  			of_node_put(child);
> @@ -422,8 +452,9 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
>  }
>  
>  static struct device_node *
> -tegra_emc_find_node_by_ram_code(struct device *dev)
> +tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
>  {
> +	struct device *dev = emc->dev;
>  	struct device_node *np;
>  	u32 value, ram_code;
>  	int err;
> @@ -442,8 +473,53 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
>  	     np = of_find_node_by_name(np, "emc-tables")) {
>  		err = of_property_read_u32(np, "nvidia,ram-code", &value);
>  		if (err || value != ram_code) {
> -			of_node_put(np);
> -			continue;
> +			struct device_node *lpddr2_np;
> +			bool conf_mismatches = false;
> +
> +			lpddr2_np = of_find_node_by_name(np, "lpddr2-configuration");
> +			if (lpddr2_np) {
> +				struct lpddr2_configuration cfg;
> +
> +				err = of_lpddr2_get_config(lpddr2_np, &cfg);
> +				if (!err) {
> +					if (cfg.manufacturer_id >= 0 &&
> +					    cfg.manufacturer_id != emc->manufacturer_id)
> +						conf_mismatches = true;
> +
> +					if (cfg.revision_id1 >= 0 &&
> +					    cfg.revision_id1 != emc->revision_id1)
> +						conf_mismatches = true;
> +
> +					if (cfg.revision_id2 >= 0 &&
> +					    cfg.revision_id2 != emc->revision_id2)
> +						conf_mismatches = true;
> +
> +					if (cfg.density >= 0 &&
> +					    cfg.density != 64 << emc->basic_conf4.density)
> +						conf_mismatches = true;
> +
> +					if (cfg.io_width >= 0 &&
> +					    cfg.io_width != 32 >> emc->basic_conf4.io_width)
> +						conf_mismatches = true;
> +
> +					if (cfg.arch_type >= 0 &&
> +					    cfg.arch_type != emc->basic_conf4.arch_type)
> +						conf_mismatches = true;
> +				} else {
> +					dev_err(emc->dev, "failed to parse %pOF: %d\n",
> +						lpddr2_np, err);
> +					conf_mismatches = true;
> +				}
> +
> +				of_node_put(lpddr2_np);
> +			} else {
> +				conf_mismatches = true;
> +			}
> +
> +			if (conf_mismatches) {
> +				of_node_put(np);
> +				continue;
> +			}
>  		}
>  
>  		return np;
> @@ -455,10 +531,70 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
>  	return NULL;
>  }
>  
> +static int emc_read_lpddr_mode_register(struct tegra_emc *emc,
> +					unsigned int emem_dev,
> +					unsigned int register_addr,
> +					unsigned int *register_data)
> +{
> +	u32 val, memory_dev = emem_dev + 1, mr_mask = 0xff;

One initialization per line, in reversed christmas tree (which matches
rest of the file, I thnk).

> +	int err;
> +
> +	/* clear data-valid interrupt status */
> +	writel_relaxed(EMC_MRR_DIVLD_INT, emc->regs + EMC_INTSTATUS);
> +
> +	/* issue mode register read request */
> +	val  = FIELD_PREP(EMC_MRR_DEV_SELECTN, memory_dev);
> +	val |= FIELD_PREP(EMC_MRR_MRR_MA, register_addr);
> +
> +	writel_relaxed(val, emc->regs + EMC_MRR);
> +
> +	/* wait for the LPDDR2 data-valid interrupt */
> +	err = readl_relaxed_poll_timeout_atomic(emc->regs + EMC_INTSTATUS, val,
> +						val & EMC_MRR_DIVLD_INT,
> +						1, 100);
> +	if (err) {
> +		dev_err(emc->dev, "mode-register %u read failed: %d\n",
> +			register_addr, err);
> +		return err;
> +	}
> +
> +	/* read out register data */
> +	val = readl_relaxed(emc->regs + EMC_MRR);
> +	*register_data = FIELD_GET(EMC_MRR_MRR_DATA, val) & mr_mask;
> +
> +	return 0;
> +}
> +
> +static void emc_read_lpddr_sdram_info(struct tegra_emc *emc,
> +				      unsigned int emem_dev,
> +				      bool print_out)
> +{
> +	/* these registers are standard for all LPDDR JEDEC memory chips */
> +	emc_read_lpddr_mode_register(emc, emem_dev, 5, &emc->manufacturer_id);
> +	emc_read_lpddr_mode_register(emc, emem_dev, 6, &emc->revision_id1);
> +	emc_read_lpddr_mode_register(emc, emem_dev, 7, &emc->revision_id2);
> +	emc_read_lpddr_mode_register(emc, emem_dev, 8, &emc->basic_conf4.value);

You ignore the return codes but you should not try to load timings in
such case. The DT could (by mistake or on purpose) have values '0' for
the fields you compare.

> +
> +	if (!print_out)
> +		return;
> +
> +	dev_info(emc->dev, "SDRAM[dev%u]: manufacturer: 0x%x (%s) rev1: 0x%x rev2: 0x%x prefetch: S%u density: %uMbit iowidth: %ubit\n",
> +		 emem_dev, emc->manufacturer_id,
> +		 lpddr2_jedec_manufacturer(emc->manufacturer_id),
> +		 emc->revision_id1, emc->revision_id2,
> +		 4 >> emc->basic_conf4.arch_type,
> +		 64 << emc->basic_conf4.density,
> +		 32 >> emc->basic_conf4.io_width);
> +}
> +
>  static int emc_setup_hw(struct tegra_emc *emc)
>  {
> +	u32 emc_cfg, emc_dbg, emc_fbio, emc_adr_cfg;
>  	u32 intmask = EMC_REFRESH_OVERFLOW_INT;
> -	u32 emc_cfg, emc_dbg, emc_fbio;
> +	static bool print_sdram_info_once;

How about moving print_sdram_info_once to emc_read_lpddr_sdram_info()?
Less code here.

> +	enum emc_dram_type dram_type;
> +	const char *dram_type_str;
> +	unsigned int emem_numdev;
>  
>  	emc_cfg = readl_relaxed(emc->regs + EMC_CFG_2);
>  
> @@ -496,7 +632,36 @@ static int emc_setup_hw(struct tegra_emc *emc)
>  	else
>  		emc->dram_bus_width = 32;
>  

Best regards,
Krzysztof
