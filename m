Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF43B67B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhF1RbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:31:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhF1RbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:31:10 -0400
Received: from [192.168.1.155] ([77.9.21.236]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0nzR-1l4Jjk2qw9-00wjTP; Mon, 28 Jun 2021 19:28:37 +0200
Subject: Re: [PATCH] SUNIX SDC PCIe multi-function card core driver
To:     Moriis Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com
References: <20210625085520.10573-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <df512124-af4d-2528-d752-04337957fa71@metux.net>
Date:   Mon, 28 Jun 2021 19:28:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625085520.10573-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QHizMrCniQ4JXdQED0CifoAFpVTfbAmkyLVZYQJAfXybd4lr20l
 hncTvv162jVf81Cp6a7bBUlJGxWl3nSpqOzcXPpN4n30fzkq9njyRtnaBkwcbTtM0i+ZWPj
 nvBABF7PPCg7xgAurfHsyldG1drhWW8MnSKofETFkEcQ+NzUyU1ucLM/u8EYjgCGdZLZDJC
 8QfBSVo3YP3BxqSIFdA/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0sHvSvmsqsw=:gp+iqSJQeuooC0sA5/WKxl
 vBPsxmAWOgWmV/uL0eL81h6Epc141o4ktYFDl2r+XGBAchvisqWYTKWdHNMCZtEzJZnf5EQg5
 qoZ5RqRF6thcV6/okef6WxvroZup21qXvOsi8TwGZv3el16rJ4evYOqEoX0GD4TJDHoZH5sn1
 tjFOjofcX7VkojzSQuMZW+rRephTXm5qbAFHdrRlHo0Z6z2AH0Y0O0wx2BgcaGOvEP1m32w57
 aE8aH2ZL+tCMjM4s55Ym3j0auSwIrWgmBHImAsAg56NIwx88ztwx5qXEMrAz/Ms7KK41ng0H7
 wYOmQWSAwUfSVfCijC9MQD7cKvtOheSRabmiJz9Hi2buBXUfFLgdcTH1V3OLEM+TMo4Bes97q
 PSGuPelFzphQMo4O+vpXdqw3Rky1iHrLrUlU26SyJws/WAsASiKfpqVXcvFEDy256xqSCY3Lw
 okgcSOpaW0fSo3BIK5Rq8Pz/2Ia5ozZSSN83Jy2WkbfVKkTs9Qsd301LA8J2cUqWMBfWpJAvJ
 admIJ+Gy8btp5jgPE8mXtY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.21 10:55, Moriis Ku wrote:

Hi,


first of all: put all patches into one queue, so we know these things
belong together.



> From: Morris Ku <saumah@gmail.com>
> 
> Add support for SUNIX SDC PCIe multi-function card
> 
> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Cc: Morris Ku <morris_ku@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>   sunix-sdc.c | 606 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 606 insertions(+)
>   create mode 100644 sunix-sdc.c
> 
> diff --git a/sunix-sdc.c b/sunix-sdc.c
> new file mode 100644
> index 0000000..5e724a3
> --- /dev/null
> +++ b/sunix-sdc.c
> @@ -0,0 +1,606 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SUNIX SDC PCIe multi-function card core support.
> + *
> + * Copyright (C) 2021, SUNIX Co., Ltd.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/io.h>
> +#include <linux/property.h>
> +#include <linux/debugfs.h>
> +#include <linux/idr.h>
> +#include <linux/mfd/core.h>
> +#include "sunix-sdc.h"
> +
> +#define DRIVER_NAME		"sunix-sdc"
> +
> +enum cib_type {
> +	TYPE_CONFIG = 0,
> +	TYPE_UART,
> +	TYPE_DIO,
> +	TYPE_CAN
> +};

What is a "CIB" ?

> +struct cib_config {
> +	u32 mem_offset;
> +	u32 mem_size;
> +	u8 ic_brand;
> +	u8 ic_model;
> +};
> +
> +struct cib_uart {
> +	u32 io_offset;
> +	u8 io_size;
> +	u32 mem_offset;
> +	u32 mem_size;
> +	u16 tx_fifo_size;
> +	u16 rx_fifo_size;
> +	u32 significand;
> +	u8 exponent;
> +	u32 capability;
> +};
> +
> +struct cib_dio_bank {
> +	u8 number_of_io;
> +	char number_of_io_name[32];
> +	u8 capability;
> +	char capability_name[32];
> +};
> +
> +struct cib_dio {
> +	u32 mem_offset;
> +	u32 mem_size;
> +	u8 number_of_bank;
> +	u8 capability;
> +
> +	struct cib_dio_bank *banks;
> +};
> +
> +struct cib_can {
> +	u32 mem_offset;
> +	u32 mem_size;
> +	u32 significand;
> +	u8 exponent;
> +	u8 number_of_device;
> +	u8 device_type;
> +	u8 gpio_input;
> +	u8 gpio_output;
> +};
> +
> +struct cib_info {
> +	u8 number;
> +	enum cib_type type;
> +	u8 version;
> +	u8 total_length;
> +	u8 resource_cap;
> +	u8 event_type;
> +
> +	struct cib_config *config;
> +	struct cib_uart *uart;
> +	struct cib_dio *dio;
> +	struct cib_can *can;
> +};
> +
> +struct sdc_channel {
> +	struct cib_info info;
> +
> +	struct property_entry *property;
> +	struct resource *resource;
> +	struct mfd_cell *cell;
> +};
> +
> +struct sdc_board {
> +	struct sunix_sdc_platform_info *info;
> +
> +	u8 major_version;
> +	u8 minor_version;
> +	u8 available_chls;
> +	u8 total_length;
> +	char model_name[16];
> +
> +	struct sdc_channel *channels;
> +	struct device *dev;
> +	int id;
> +
> +	struct debugfs_blob_wrapper debugfs_model_name;
> +};

I think it might be better splitting this big thing apart into several
drivers for each sub device and have frontend driver(s) that does the
probing / instantiation of the individual components. Note that not
everybody has all the corresponding subsystems enabled.


> +static int sdc_board_id = 1;
> +static int sdc_uart_id = 1;
> +static int sdc_dio_id = 1;
> +static int sdc_can_id = 1;

What exactly are these global singletons for ?
Usually device specific data belongs into the device's private data,
except there's a damn good reason.

<snip>

> +static void sdc_get_dio_info(struct cib_dio *dio, void __iomem *base,
> +				u16 ptr)
> +{
> +	u32 temp;

what exactly is an "dio" ? do you mean gpio ?

<snip>

> +int sunix_sdc_probe(struct device *dev, struct sunix_sdc_platform_info *info)
> +{

Doesn't really look like some device probe function. Who calls that and
who fills this struct ?

> +	struct sdc_channel *chl;
> +	struct sdc_board *sdc;
> +	struct cib_dio *dio;
> +	struct cib_can *can;
> +	void __iomem *mem_base;
> +	u16 chl_offset_backup;
> +	u16 chl_offset;
> +	u32 temp;
> +	u8 type;
> +	int index;
> +	int ret;
> +	int i;
> +	int j;
> +
> +	if (!info || !info->b1_io || !info->b2_mem || info->irq <= 0)
> +		return -EINVAL;
> +
> +	sdc = devm_kzalloc(dev, sizeof(*sdc), GFP_KERNEL);
> +	if (!sdc)
> +		return -ENOMEM;
> +
> +	mem_base = devm_ioremap(dev, info->b2_mem->start, resource_size(info->b2_mem));
> +	if (!mem_base)
> +		return -ENOMEM;
> +
> +	sdc->info = info;
> +	sdc->dev = dev;
> +	sdc->id = sdc_board_id++;
> +
> +	temp = sdc_readl(mem_base, 0, 0);
> +	sdc->major_version = temp & GENMASK(7, 0);
> +	sdc->minor_version = (temp & GENMASK(15, 8)) >> 8;
> +	sdc->available_chls = (temp & GENMASK(23, 16)) >> 16;
> +	sdc->total_length = (temp & GENMASK(31, 24)) >> 24;
> +
> +	temp = sdc_readl(mem_base, 0, 1);
> +	chl_offset = chl_offset_backup = temp & GENMASK(15, 0);
> +
> +	j = 0;
> +	for (i = 0; i < 4; i++) {
> +		temp = sdc_readl(mem_base, 0, 2 + i);
> +		sdc->model_name[j++] = temp & GENMASK(7, 0);
> +		sdc->model_name[j++] = (temp & GENMASK(15, 8)) >> 8;
> +		sdc->model_name[j++] = (temp & GENMASK(23, 16)) >> 16;
> +		sdc->model_name[j++] = (temp & GENMASK(31, 24)) >> 24;
> +	}
> +	sdc->model_name[strlen(sdc->model_name)] = '\n';
> +
> +	sdc->channels = devm_kcalloc(dev, sdc->available_chls,
> +		sizeof(struct sdc_channel), GFP_KERNEL);
> +	if (!sdc->channels)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < sdc->available_chls; i++) {
> +		chl = &sdc->channels[i];
> +		chl_offset_backup = chl_offset;
> +
> +		temp = sdc_readl(mem_base, chl_offset, 0);
> +		chl->info.number = temp & GENMASK(7, 0);
> +		type = (temp & GENMASK(15, 8)) >> 8;
> +		switch (type) {
> +		case 0x00:
> +		case 0x01:
> +		case 0x02:
> +		case 0x03:
> +			chl->info.type = (enum cib_type)type;
> +			break;
> +		default:
> +			break;
> +		}
> +		chl->info.version = (temp & GENMASK(23, 16)) >> 16;
> +		chl->info.total_length = (temp & GENMASK(31, 24)) >> 24;
> +
> +		temp = sdc_readl(mem_base, chl_offset, 1);
> +		chl_offset = temp & GENMASK(15, 0);
> +		chl->info.resource_cap = (temp & GENMASK(23, 16)) >> 16;
> +		chl->info.event_type = (temp & GENMASK(31, 24)) >> 24;
> +
> +		switch (chl->info.type) {
> +		case TYPE_CONFIG:
> +			chl->info.config = devm_kzalloc(dev,
> +				sizeof(*chl->info.config), GFP_KERNEL);
> +			if (!chl->info.config)
> +				return -ENOMEM;
> +			sdc_get_config_info(chl->info.config, mem_base,
> +				chl_offset_backup);
> +			break;
> +
> +		case TYPE_UART:
> +			chl->info.uart = devm_kzalloc(dev,
> +				sizeof(*chl->info.uart), GFP_KERNEL);
> +			if (!chl->info.uart)
> +				return -ENOMEM;
> +			sdc_get_uart_info(chl->info.uart, mem_base,
> +				chl_offset_backup);
> +
> +			chl->property = devm_kcalloc(dev, 8,
> +				sizeof(struct property_entry), GFP_KERNEL);
> +			if (!chl->property)
> +				return -ENOMEM;
> +			index = 0;
> +			chl->property[index++] = PROPERTY_ENTRY_U32(
> +				"board_id", sdc->id);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"chl_number", chl->info.number);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"version", chl->info.version);
> +			chl->property[index++] = PROPERTY_ENTRY_U16(
> +				"tx_fifo_size", chl->info.uart->tx_fifo_size);
> +			chl->property[index++] = PROPERTY_ENTRY_U16(
> +				"rx_fifo_size", chl->info.uart->rx_fifo_size);
> +			chl->property[index++] = PROPERTY_ENTRY_U32(
> +				"significand", chl->info.uart->significand);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"exponent", chl->info.uart->exponent);
> +			chl->property[index++] = PROPERTY_ENTRY_U32(
> +				"capability", chl->info.uart->capability);
> +
> +			chl->resource = devm_kcalloc(dev, 2,
> +				sizeof(struct resource), GFP_KERNEL);
> +			if (!chl->resource)
> +				return -ENOMEM;
> +			chl->resource[0].start = info->b1_io->start +
> +				chl->info.uart->io_offset;
> +			chl->resource[0].end = chl->resource[0].start +
> +				chl->info.uart->io_size - 1;
> +			chl->resource[0].name = "8250_sdc";
> +			chl->resource[0].flags = IORESOURCE_IO;
> +			chl->resource[0].desc = IORES_DESC_NONE;
> +			chl->resource[1].start = 0;
> +			chl->resource[1].end =  0;
> +			chl->resource[1].name = "irq";
> +			chl->resource[1].flags = IORESOURCE_IRQ;
> +			chl->resource[1].desc = IORES_DESC_NONE;

Since this thing is initialized from somewhere else, why not directly 
passing in struct resource instances ?

> +			chl->cell = devm_kzalloc(dev,
> +				sizeof(struct mfd_cell), GFP_KERNEL);

MFD ? Seriously ?

> +			if (!chl->cell)
> +				return -ENOMEM;
> +			chl->cell->name = "8250_sdc";
> +			chl->cell->id = sdc_uart_id++;
> +			chl->cell->properties = chl->property;
> +			chl->cell->num_resources = 2;
> +			chl->cell->resources = chl->resource;
> +			break;
> +
> +		case TYPE_DIO:
> +			chl->info.dio = devm_kzalloc(dev,
> +				sizeof(*chl->info.dio), GFP_KERNEL);
> +			if (!chl->info.dio)
> +				return -ENOMEM;
> +			dio = chl->info.dio;
> +			sdc_get_dio_info(dio, mem_base, chl_offset_backup);
> +			if (dio->number_of_bank) {
> +				dio->banks =
> +					devm_kcalloc(dev, dio->number_of_bank,
> +					sizeof(*dio->banks), GFP_KERNEL);
> +				if (!dio->banks)
> +					return -ENOMEM;
> +
> +				sdc_get_dio_banks_info(dio, mem_base,
> +					chl_offset_backup);
> +			}
> +
> +			chl->property = devm_kcalloc(dev, 5 + dio->number_of_bank * 2,
> +				sizeof(struct property_entry), GFP_KERNEL);
> +			if (!chl->property)
> +				return -ENOMEM;
> +			index = 0;
> +			chl->property[index++] = PROPERTY_ENTRY_U32(
> +				"board_id", sdc->id);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"chl_number", chl->info.number);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"version", chl->info.version);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"number_of_bank", dio->number_of_bank);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"capability", dio->capability);
> +			for (j = 0; j < dio->number_of_bank; j++) {
> +				snprintf(dio->banks[j].number_of_io_name,
> +					sizeof(dio->banks[j].number_of_io_name),
> +					"b%d_number_of_io", j);
> +				chl->property[index++] = PROPERTY_ENTRY_U8(
> +				dio->banks[j].number_of_io_name, dio->banks[j].number_of_io);
> +				snprintf(dio->banks[j].capability_name,
> +					sizeof(dio->banks[j].capability_name),
> +					"b%d_capability", j);
> +				chl->property[index++] = PROPERTY_ENTRY_U8(
> +				dio->banks[j].capability_name, dio->banks[j].capability);
> +			}
> +
> +			chl->resource = devm_kcalloc(dev, 4,
> +				sizeof(struct resource), GFP_KERNEL);
> +			if (!chl->resource)
> +				return -ENOMEM;
> +			chl->resource[0].start = info->b2_mem->start +
> +				chl->info.dio->mem_offset;
> +			chl->resource[0].end = chl->resource[0].start +
> +				chl->info.dio->mem_size - 1;
> +			chl->resource[0].name = "gpio_sdc";
> +			chl->resource[0].flags = IORESOURCE_MEM;
> +			chl->resource[0].desc = IORES_DESC_NONE;
> +			chl->resource[1].start = 0;
> +			chl->resource[1].end =  0;
> +			chl->resource[1].name = "irq";
> +			chl->resource[1].flags = IORESOURCE_IRQ;
> +			chl->resource[1].desc = IORES_DESC_NONE;
> +			chl->resource[2].start = info->b0_mem->start;
> +			chl->resource[2].end = chl->resource[2].start + 32 - 1;
> +			chl->resource[2].name = "sdc_irq_vector";
> +			chl->resource[2].flags = IORESOURCE_MEM;
> +			chl->resource[2].desc = IORES_DESC_NONE;
> +			chl->resource[3].start = info->b0_mem->start + 32 +
> +				(chl->info.number * 4);
> +			chl->resource[3].end = chl->resource[3].start + 4 - 1;
> +			chl->resource[3].name = "gpio_sdc_event_header";
> +			chl->resource[3].flags = IORESOURCE_MEM;
> +			chl->resource[3].desc = IORES_DESC_NONE;
> +
> +			chl->cell = devm_kzalloc(dev,
> +				sizeof(struct mfd_cell), GFP_KERNEL);
> +			if (!chl->cell)
> +				return -ENOMEM;
> +			chl->cell->name = "gpio_sdc";
> +			chl->cell->id = sdc_dio_id++;
> +			chl->cell->properties = chl->property;
> +			chl->cell->num_resources = 4;
> +			chl->cell->resources = chl->resource;
> +			break;
> +
> +		case TYPE_CAN:
> +			chl->info.can = devm_kzalloc(dev,
> +				sizeof(*chl->info.can), GFP_KERNEL);
> +			if (!chl->info.can)
> +				return -ENOMEM;
> +			can = chl->info.can;
> +			sdc_get_can_info(can, mem_base,	chl_offset_backup);
> +
> +			if (can->number_of_device != 1 && can->device_type != 0x03)
> +				break;
> +
> +			chl->property = devm_kcalloc(dev, 7,
> +				sizeof(struct property_entry), GFP_KERNEL);
> +			if (!chl->property)
> +				return -ENOMEM;
> +			index = 0;
> +			chl->property[index++] = PROPERTY_ENTRY_U32(
> +				"board_id", sdc->id);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"chl_number", chl->info.number);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"version", chl->info.version);
> +			chl->property[index++] = PROPERTY_ENTRY_U32(
> +				"significand", can->significand);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"exponent", can->exponent);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"gpio_input", can->gpio_input);
> +			chl->property[index++] = PROPERTY_ENTRY_U8(
> +				"gpio_output", can->gpio_output);
> +
> +			chl->resource = devm_kcalloc(dev, 2,
> +				sizeof(struct resource), GFP_KERNEL);
> +			if (!chl->resource)
> +				return -ENOMEM;
> +			chl->resource[0].start = info->b2_mem->start +
> +				chl->info.can->mem_offset;
> +			chl->resource[0].end = chl->resource[0].start +
> +				chl->info.can->mem_size - 1;
> +			chl->resource[0].name = "sx2010_can";
> +			chl->resource[0].flags = IORESOURCE_MEM;
> +			chl->resource[0].desc = IORES_DESC_NONE;
> +			chl->resource[1].start = 0;
> +			chl->resource[1].end =  0;
> +			chl->resource[1].name = "irq";
> +			chl->resource[1].flags = IORESOURCE_IRQ;
> +			chl->resource[1].desc = IORES_DESC_NONE;
> +
> +			chl->cell = devm_kzalloc(dev,
> +				sizeof(struct mfd_cell), GFP_KERNEL);
> +			if (!chl->cell)
> +				return -ENOMEM;
> +			chl->cell->name = "sx2010_can";
> +			chl->cell->id = sdc_can_id++;
> +			chl->cell->properties = chl->property;
> +			chl->cell->num_resources = 2;
> +			chl->cell->resources = chl->resource;
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}
> +
> +	dev_set_drvdata(dev, sdc);
> +	sdc_debugfs_add(sdc);
> +
> +	for (i = 0; i < sdc->available_chls; i++) {
> +		chl = &sdc->channels[i];
> +
> +		if (chl->cell) {
> +			ret = mfd_add_devices(dev, sdc->id, chl->cell, 1,
> +						NULL, sdc->info->irq, NULL);
> +			if (ret)
> +				goto err_remove_sdc;
> +		}
> +	}
> +
> +	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
> +	return 0;
> +
> +err_remove_sdc:
> +	sdc_debugfs_remove(sdc);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sunix_sdc_probe);

I really wonder what this functions is actually for. Doesn't seem to be
some driver probe function. Doesn't seem to create any devices.

> +void sunix_sdc_remove(struct device *dev)
> +{
> +	struct sdc_board *sdc = dev_get_drvdata(dev);
> +
> +	mfd_remove_devices(dev);
> +	sdc_debugfs_remove(sdc);
> +}
> +EXPORT_SYMBOL_GPL(sunix_sdc_remove);
> +
> +static int __init sunix_sdc_init(void)
> +{
> +	sdc_debugfs_init();
> +	return 0;
> +}
> +module_init(sunix_sdc_init);
> +
> +static void __exit sunix_sdc_exit(void)
> +{
> +	sdc_debugfs_exit();
> +}
> +module_exit(sunix_sdc_exit);
> +
> +MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
> +MODULE_DESCRIPTION("SUNIX SDC PCIe multi-function card core driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> 

Sorry, but it's totally unclear to me what this code is actually
supposed to do.

Please submit a complete queue that does something actually useful and
give some more explainations.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
