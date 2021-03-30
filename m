Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AFC34E2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhC3IM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhC3IMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:12:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F8C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:12:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v4so15266081wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q6jUtF49m1lwLTy6Ltj1wBuTWx+lTaPHrUguksj2XxI=;
        b=Emm9hTrHWsOZ88d2dsp4nI4vvjqUtHUVsbzwd8+j7uSidxUxX9ik+F/jlGX2BOLc53
         +XjRQvxsaLOUjMIaEK2DzeQEz6GL1QHIYcrxCWGum40fP+VL/gESIkOrmIVLR/6zWZzf
         o4dVRXdlHsf9w31jy0/dJr5BgnOcgrwF5oCGNvubFvmk9pK/YuuuSHwiQB+35kDgcxDP
         sQvHtv87PTURfc4jmNdvtf2c1qxbtCk3fH0lOARys3+wADaRzTvjY1RYKVg1xifuywWS
         k5vPqIlFEYVSyh9GJQlxSRHqNwAxamEFbZQkClga4FftSMa0oyE6ei4Sm+Hoe8MVLOWz
         T6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q6jUtF49m1lwLTy6Ltj1wBuTWx+lTaPHrUguksj2XxI=;
        b=Grh+8IwQixpNgVeU8ceJHAsPftUim9lIgNwP1bK7A/+7my0HYaTdfDbb4G3GPfZttU
         ehWwXLc62W9703OSn2comEmYLS45VmbbbPGxIsXhulATygGjjT2lXd15EBtuMIDuL/K8
         6my8KaDy7C4g5ZYzv+57YLvY1pQpgnpBOq9mIAOO1a9qQGF/1ipCzN6D2179FpIgNnUZ
         m6ubqJoveFTAmxSWFZYP0fF2pNQvbPAiRwSOlq6im2ZQVJz8UnElIwQsvQCEF9KxptY0
         37awtt+oGs/0+FnRPN3JVj9FnlSHmwm7vehGs2CQrgSPLv9tfPXbifsJZoHf3e/nTHMY
         tmXQ==
X-Gm-Message-State: AOAM531l7+ovbSq32AnH61w4QhbOexJMUDAbH9BCuQ2tnON7iNfwNyUs
        HI35hG3ax1yy0ex+V5eLbVNw1g==
X-Google-Smtp-Source: ABdhPJyIXO1n8ldSQlz5Bco7CQ774AWvYcPKV7/1cbq+CNMCRR0/m7cFEnCwCuJ4UZPNszINsNaV5A==
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr29997716wrt.390.1617091934289;
        Tue, 30 Mar 2021 01:12:14 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id g11sm33221716wrw.89.2021.03.30.01.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:12:13 -0700 (PDT)
Date:   Tue, 30 Mar 2021 09:12:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Driver for SUNIX PCI(e) I/O expansion board
Message-ID: <20210330081212.GH2916463@dell>
References: <20210330065818.4464-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210330065818.4464-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021, Moriis Ku wrote:

> From: Morris <saumah@gmail.com>

Full names please.

> The board provide UART, DIO and CAN functions.

This commit message is not adequate for a 12k line patch.

> Signed-off-by: Morris <saumah@gmail.com>
> ---
>  drivers/mfd/bus.c          | 1524 +++++++++++++++
>  drivers/mfd/dio.c          |  529 +++++
>  drivers/mfd/dio_pack.c     | 3126 +++++++++++++++++++++++++++++
>  drivers/mfd/list.c         |   99 +
>  drivers/mfd/mem.c          |   37 +
>  drivers/mfd/sdc_define.h   |  668 +++++++
>  drivers/mfd/sdc_function.h |   96 +
>  drivers/mfd/sdc_include.h  |  108 +
>  drivers/mfd/spi.c          |  420 ++++
>  drivers/mfd/spi_pack.c     | 1506 ++++++++++++++
>  drivers/mfd/uart.c         | 3796 ++++++++++++++++++++++++++++++++++++
>  11 files changed, 11909 insertions(+)
>  create mode 100644 drivers/mfd/bus.c
>  create mode 100644 drivers/mfd/dio.c
>  create mode 100644 drivers/mfd/dio_pack.c
>  create mode 100644 drivers/mfd/list.c
>  create mode 100644 drivers/mfd/mem.c
>  create mode 100644 drivers/mfd/sdc_define.h
>  create mode 100644 drivers/mfd/sdc_function.h
>  create mode 100644 drivers/mfd/sdc_include.h
>  create mode 100644 drivers/mfd/spi.c
>  create mode 100644 drivers/mfd/spi_pack.c
>  create mode 100644 drivers/mfd/uart.c

I'm just going to conduct a high-level pass on this presently.

> diff --git a/drivers/mfd/bus.c b/drivers/mfd/bus.c
> new file mode 100644
> index 000000000000..7820072e918f
> --- /dev/null
> +++ b/drivers/mfd/bus.c
> @@ -0,0 +1,1524 @@

Missing SPDXs.

> +/*
> + *	Driver for SUNIX PCI(e) expansion board

Omit the leading ' 's please.

> + *	Based on drivers/tty/serial/8250/8250_pci.c
> + *	by Linus Torvalds, Theodore Ts'o.
> + *
> + *	This program is free software; you can redistribute it and/or modify
> + *	it under the terms of the GNU General Public License as published by
> + *	the Free Software Foundation; either version 2 of the License.

Omit this.  It's replaced by the SPDX.
> + */
> +
> +

No double line spacing.

> +#include "sdc_include.h"
> +
> +
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))

This will never be in the 2.6 kernel.  Please omit all of these.

> +static  struct pci_device_id	sunix_pci_board_id[] = 
> +{
> +	{0x1fd4, 0x2000, 0x1fd4, 0x0001, 0, 0, 123},
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, sunix_pci_board_id);
> +#else
> +typedef struct
> +{
> +	unsigned short vendor;
> +	unsigned short device;
> +	unsigned short subvendor;
> +	unsigned short subdevice;
> +	unsigned short driver_data;
> +	unsigned short part_number;
> +} sunix_pciInfo;
> +
> +static sunix_pciInfo sunix_pci_board_id[] = 
> +{
> +	{0x1fd4, 0x2000, 0x1fd4, 0x0001, 123},
> +	{0}
> +};
> +#endif
> +
> +
> +struct sunix_sdc_board			sunix_sdc_board_table[SUNIX_SDC_BOARD_MAX];
> +struct sunix_sdc_uart_channel	sunix_sdc_uart_table[SUNIX_SDC_UART_MAX + 1];
> +struct sunix_sdc_dio_channel	sunix_sdc_dio_table[SUNIX_SDC_DIO_MAX];
> +struct sunix_sdc_spi_channel	sunix_sdc_spi_table[SUNIX_SDC_SPI_MAX];

No forward declarations.  Please reorder the code instead.

> +struct kmem_cache *				sunix_sdc_dio_pack_cache;
> +struct kmem_cache *				sunix_sdc_spi_pack_cache;
> +
> +unsigned int					sunix_sdc_board_amount;
> +unsigned int					sunix_sdc_uart_amount;
> +unsigned int					sunix_sdc_dio_amount;
> +unsigned int					sunix_sdc_spi_amount;

Avoid global variables like the plague.

> +
> +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 18))
> +static irqreturn_t sunix_interrupt(int irq, void *dev_id)
> +#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
> +static irqreturn_t sunix_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +#else
> +static void sunix_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +#endif
> +{
> +	struct sunix_sdc_board *sb = NULL;
> +	struct sunix_sdc_uart_channel *uart_chl = NULL;
> +	struct sunix_sdc_dio_channel *dio_chl = NULL;
> +	struct sunix_sdc_spi_channel *spi_chl = NULL;
> +	int i, j, k;
> +	int status = 0;
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
> +	int handled = IRQ_NONE;
> +#endif
> +	unsigned int vector[8];
> +	unsigned int event_header;
> +	unsigned char chl_num;
> +
> +
> +	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
> +	{

Please read and understand the Coding Style document.

  Documentation/process/coding-style.rst

> +		if (dev_id == &(sunix_sdc_board_table[i]))
> +		{
> +			sb = dev_id;
> +			break;
> +		}
> +	}
> +
> +	if (i == SUNIX_SDC_BOARD_MAX)
> +		status = 1;

No magic numbers.  Please define them.

> +
> +	if (!sb)
> +		status = 1;
> +
> +	if (sb->board_enum <= 0)
> +		status = 1;
> +
> +	if (status != 0)
> +	{
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
> +		return handled;
> +#else
> +		return;
> +#endif
> +	}
> +
> +	vector[0] = mem_rx32(sb->bar0_membase, 0, 0);
> +	vector[1] = mem_rx32(sb->bar0_membase, 0, 1);
> +	vector[2] = mem_rx32(sb->bar0_membase, 0, 2);
> +	vector[3] = mem_rx32(sb->bar0_membase, 0, 3);
> +	vector[4] = mem_rx32(sb->bar0_membase, 0, 4);
> +	vector[5] = mem_rx32(sb->bar0_membase, 0, 5);
> +	vector[6] = mem_rx32(sb->bar0_membase, 0, 6);
> +	vector[7] = mem_rx32(sb->bar0_membase, 0, 7);

Loop?

> +	for (i = 0; i < 8; i++)
> +	{
> +		if (vector[i] & 0xffffffff)
> +		{
> +			for (j = 0; j < 32; j++)
> +			{
> +				if (vector[i] & (0x00000001 << j))
> +				{
> +					chl_num = (i * 8) + j;

You're going to need to comment all of this.

> +					event_header = mem_rx32(sb->bar0_membase, 0, 8 + chl_num);
> +
> +					for (k = 0; k < SUNIX_SDC_UART_MAX + 1; k++)
> +					{
> +						uart_chl = &sunix_sdc_uart_table[k];
> +
> +						// uart

Coding style: No C++ comments.

> +						if ((uart_chl->port.iobase != 0) && 

Wayyyyy to many indentations.  Please reorganise the code.

> +							(uart_chl->port.bus_number == sb->bus_number) &&
> +							(uart_chl->port.dev_number == sb->dev_number) &&
> +							(uart_chl->port.cib_info.num == chl_num) &&
> +							(uart_chl->port.cib_info.type == 0x01))
> +						{
> +							//printk("SUNIX: bus_num:%d, dev_num:%d, chl_num:%d, event:x%08x, ttySDC%d has interrupt\n", uart_chl->port.bus_number, uart_chl->port.dev_number, chl_num, event_header, uart_chl->port.line);
> +							status = sb->uart_isr(uart_chl);
> +						}
> +					}
> +
> +					for (k = 0; k < SUNIX_SDC_DIO_MAX; k++)
> +					{
> +						dio_chl = &sunix_sdc_dio_table[k];
> +
> +						// dio
> +						if ((dio_chl->info.memsize != 0) && 
> +							(dio_chl->info.bus_number == sb->bus_number) &&
> +							(dio_chl->info.dev_number == sb->dev_number) &&
> +							(dio_chl->info.cib_info.num == chl_num) &&
> +							(dio_chl->info.cib_info.type == 0x02))
> +						{
> +							//printk("SUNIX: bus_num:%d, dev_num:%d, chl_num:%d, event:x%08x, SDCDIO%d has interrupt\n", dio_chl->info.bus_number, dio_chl->info.dev_number, chl_num, event_header, dio_chl->info.line);
> +							status = sb->dio_isr(dio_chl, event_header);
> +						}
> +					}
> +
> +					for (k = 0; k < SUNIX_SDC_SPI_MAX; k++)
> +					{
> +						spi_chl = &sunix_sdc_spi_table[k];
> +
> +						// spi
> +						if ((spi_chl->info.memsize != 0) && 
> +							(spi_chl->info.bus_number == sb->bus_number) &&
> +							(spi_chl->info.dev_number == sb->dev_number) &&
> +							(spi_chl->info.cib_info.num == chl_num) &&
> +							(spi_chl->info.cib_info.type == 0x03))
> +						{
> +							//printk("SUNIX: bus_num:%d, dev_num:%d, chl_num:%d, event:x%08x, SDCSPI%d has interrupt\n", spi_chl->info.bus_number, spi_chl->info.dev_number, chl_num, event_header, spi_chl->info.line);
> +							status = sb->spi_isr(spi_chl, event_header);
> +						}
> +					}
> +				}
> +			}
> +		}
> +	}
> +
> +	if (status != 0)
> +	{
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
> +		return handled;
> +#else
> +		return;
> +#endif
> +	}
> +
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
> +	handled = IRQ_HANDLED;
> +	return handled;
> +#endif
> +}
> +
> +
> +static int snx_pci_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	return 0;

Why does this exist?

> +}
> +
> +
> +static int snx_suspend_one(struct pci_dev *pdev, pm_message_t state)
> +{
> +	return  0;
> +}
> +
> +
> +static int snx_set_port_termios(struct snx_ser_state *state)
> +{
> +}
> +
> +
> +static int snx_resume_port_termios(struct snx_ser_info *info)
> +{
> +}
> +
> +
> +static int snx_resume_port(struct sunix_sdc_uart_channel *uart_chl)
> +{
> +}
> +
> +
> +static int snx_resume_one(struct pci_dev *pdev)
> +{
> +}

These needs to be moved to Serial.

> +static int sunix_get_pci_board_conf(void)
> +{
> +}

This needs moving to PCI.

> +static int sunix_dio_channel_table_init(void)
> +{
> +}
> +
> +
> +static void sunix_dio_channel_table_deinit(void)
> +{
> +}

I don't know what DIO is in this context, but it's likely that it
needs to be moved to Pinctrl/GPIO (maybe?).

> +static int sunix_spi_channel_table_init(void)
> +{
> +}
> +
> +
> +static void sunix_spi_channel_table_deinit(void)
> +{
> +}

Move to SPI.

> +int sunix_register_irq(void)
> +{
> +	struct sunix_sdc_board *sb = NULL;
> +	int status = 0;
> +	int i;
> +
> +
> +	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
> +	{
> +		sb = &sunix_sdc_board_table[i];
> +
> +		if (sb == NULL)
> +		{
> +			status = -ENXIO;
> +			printk("SUNIX: Board table pointer error !\n");
> +			return status;
> +		}
> +
> +		if (sb->board_enum > 0)
> +		{
> +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 18))
> +			status = request_irq(sb->irq, sunix_interrupt, IRQF_SHARED, "sunix_sdc", sb);
> +#else
> +			status = request_irq(sb->irq, sunix_interrupt, SA_SHIRQ, "sunix_sdc", sb);
> +#endif
> +			if (status)
> +			{
> +				printk("SUNIX: %s board (bus_num:%d dev_num:%d), request\n", sb->model_name, sb->bus_number, sb->dev_number);
> +				printk("       IRQ %d fail, IRQ %d may be conflit with another device.\n", sb->irq, sb->irq);
> +				return status;
> +			}
> +		}
> +	}
> +
> +	return status;
> +}

This seems over-complicated just to request an IRQ.

> +static int __init sunix_sdc_init(void)
> +{
> +	int status = 0;
> +
> +
> +	sunix_sdc_board_amount = 0;
> +	sunix_sdc_uart_amount = 0;
> +	sunix_sdc_dio_amount = 0;
> +	sunix_sdc_spi_amount = 0;
> +
> +
> +	sunix_sdc_dio_pack_cache = kmem_cache_create("sunix_sdc_dio", sizeof(DIO_PACKAGE), 0, SLAB_HWCACHE_ALIGN, NULL);
> +	if (sunix_sdc_dio_pack_cache == NULL)
> +		goto step1_fail;
> +
> +	sunix_sdc_spi_pack_cache = kmem_cache_create("sunix_sdc_spi", sizeof(DIO_PACKAGE), 0, SLAB_HWCACHE_ALIGN, NULL);
> +	if (sunix_sdc_spi_pack_cache == NULL)
> +		goto step2_fail;
> +
> +	status = pci_register_driver(&snx_pci_driver);
> +	if (status != 0)
> +		goto step3_fail;
> +
> +	status = sunix_pci_board_probe();
> +	if (status != 0)	
> +		goto step4_fail;
> +
> +	status = sunix_get_pci_board_conf();
> +	if (status != 0)
> +		goto step5_fail;
> +
> +	status = sunix_assign_resource();
> +	if (status != 0)
> +		goto step5_fail;
> +
> +	status = sunix_uart_channel_table_init();
> +	if (status != 0)
> +		goto step5_fail;
> +
> +	status = sunix_dio_channel_table_init();
> +	if (status != 0)
> +		goto step5_fail;
> +
> +	status = sunix_spi_channel_table_init();
> +	if (status != 0)
> +		goto step6_fail;
> +
> +	status = sunix_register_irq();
> +	if (status != 0)
> +		goto step7_fail;
> +
> +	status = sunix_ser_register_driver();
> +	if (status != 0)
> +		goto step8_fail;
> +
> +	status = sunix_ser_register_ports();
> +	if (status != 0)
> +		goto step9_fail;
> +
> +	status = sunix_dio_register_channel();
> +	if (status != 0)
> +		goto step10_fail;
> +
> +	status = sunix_spi_register_channel();
> +	if (status != 0)
> +		goto step11_fail;
> +
> +
> +	return status;
> +
> +
> +step11_fail:
> +	sunix_dio_unregister_channel();
> +
> +step10_fail:
> +	sunix_ser_unregister_ports();
> +
> +step9_fail:
> +	sunix_ser_unregister_driver();
> +
> +step8_fail:
> +	sunix_release_irq();
> +
> +step7_fail:
> +	sunix_spi_channel_table_deinit();
> +
> +step6_fail:
> +	sunix_dio_channel_table_deinit();
> +
> +step5_fail:
> +	sunix_release_iomap();
> +
> +step4_fail:
> +	pci_unregister_driver(&snx_pci_driver);
> +
> +step3_fail:
> +	kmem_cache_destroy(sunix_sdc_spi_pack_cache);
> +
> +step2_fail:
> +	kmem_cache_destroy(sunix_sdc_dio_pack_cache);
> +
> +step1_fail:
> +
> +	return status;
> +}

I think you're mixing up _init with _probe.

_init should be very short and simple.

> +static void __exit sunix_sdc_exit(void)
> +{
> +	sunix_spi_unregister_channel();
> +
> +	sunix_dio_unregister_channel();
> +
> +	sunix_ser_unregister_ports();
> +
> +	sunix_ser_unregister_driver();
> +
> +	sunix_release_irq();
> +
> +	sunix_spi_channel_table_deinit();
> +
> +	sunix_dio_channel_table_deinit();
> +
> +	sunix_release_iomap();
> +
> +	pci_unregister_driver(&snx_pci_driver);
> +
> +	kmem_cache_destroy(sunix_sdc_spi_pack_cache);
> +
> +	kmem_cache_destroy(sunix_sdc_dio_pack_cache);
> +}

Use _remove instead of _exit.

> +module_init(sunix_sdc_init);
> +module_exit(sunix_sdc_exit);
> +
> +
> +MODULE_AUTHOR("SUNIX Co., Ltd.<info@sunix.com.tw>");

This is not an author.

> +MODULE_DESCRIPTION("SUNIX PCI(e) expansion board bus driver");
> +MODULE_LICENSE("GPL");

> diff --git a/drivers/mfd/dio.c b/drivers/mfd/dio.c
> new file mode 100644
> index 000000000000..216280194d1b
> --- /dev/null
> +++ b/drivers/mfd/dio.c

This needs moving to Pinctrl/GPIO.

> diff --git a/drivers/mfd/dio_pack.c b/drivers/mfd/dio_pack.c
> new file mode 100644
> index 000000000000..29e623918a45
> --- /dev/null
> +++ b/drivers/mfd/dio_pack.c

I don't even know what to make of this.

[...]

> +			InputDeltaReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 1);
> +			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 1, InputDeltaReg:x%08x\n", dio_chl->info.line, InputDeltaReg);

No unused code.

> +			InputDeltaReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
> +			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 2, InputDeltaReg:x%08x\n", dio_chl->info.line, InputDeltaReg);
> +			InputDeltaReg &= ~dio_chl->DirectionCtrlReg;
> +			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 3, InputDeltaReg:x%08x\n", dio_chl->info.line, InputDeltaReg);
> +			BankDeltaState = InputDeltaReg >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
> +			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 4, BankDeltaState:x%08x\n", dio_chl->info.line, BankDeltaState);
> +		}


> index 000000000000..4c7c1c494255
> --- /dev/null
> +++ b/drivers/mfd/spi.c

Please move to SPI.

> index 000000000000..ff49e0ae94ac
> --- /dev/null
> +++ b/drivers/mfd/spi_pack.c

Please move to SPI

> index 000000000000..bb88630fdca1
> --- /dev/null
> +++ b/drivers/mfd/uart.c

Please move to UART.

[...]

Okay ... so ... where to begin?!

Essentially, upstreaming 12k lines of non-conformant code is a no-go.

Where did you get this from?  One of the down-stream repos?

Please provide more information in the commit message.  Writing a
single line commit message for a 12k line patch is not doing it the
justice that it deserves.  We want to know it's history, where it came
from, what it does (in detail), what hardware it runs on, what your
plans are for it i.e. why you're going to the effort of upstreaming it
in the first place, etc.

I'll make no bones about it.  If you want to get these driver*S*
upstream, you are in this for the long haul.  Most of this needs
splitting up into its component parts; MFD, PCI, UART, SPI, Pinctrl,
etc, and will require a re-write at most levels.

My suggestion would be to start small.  Strip the whole thing down to
the smallest piece of 'functional' code (code that does something
useful) that you can, upstream that, then build on it incrementally.

I wish you the very best of luck.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
