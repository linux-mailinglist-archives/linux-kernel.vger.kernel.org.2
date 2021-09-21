Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20F0413240
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhIULGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:06:08 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:49320 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhIULGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:06:07 -0400
X-Greylist: delayed 2369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 07:06:07 EDT
Received: from [167.98.27.226] (helo=[10.35.5.170])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1mScxX-0002QA-8i; Tue, 21 Sep 2021 11:25:07 +0100
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <28072b8e-2c32-e67d-19d3-026913c0bc7f@codethink.co.uk>
Date:   Tue, 21 Sep 2021 11:25:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 06:33, Alexandre Ghiti wrote:
> The SiFive Unmatched board uses the da9063 PMIC for reset: add a restart
> notifier that will execute a small i2c sequence allowing to reset the
> board.
> 
> The original implementation comes from Marcus Comstedt and Anders Montonen
> (https://forums.sifive.com/t/reboot-command/4721/28).
> 
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>

I've got a couple of comments here, mainly is this the right place
and has anyone other than you tested. I tried something similar on
my Unmatched and it just turned the board off.

> ---
>   drivers/mfd/da9063-core.c       | 25 +++++++++++++++++++++++++
>   include/linux/mfd/da9063/core.h |  3 +++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index df407c3afce3..c87b8d611f20 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -20,6 +20,7 @@
>   #include <linux/mutex.h>
>   #include <linux/mfd/core.h>
>   #include <linux/regmap.h>
> +#include <linux/reboot.h>
>   
>   #include <linux/mfd/da9063/core.h>
>   #include <linux/mfd/da9063/registers.h>
> @@ -158,6 +159,18 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
>   	return ret;
>   }
>   
> +static int da9063_restart_notify(struct notifier_block *this,
> +				 unsigned long mode, void *cmd)
> +{
> +	struct da9063 *da9063 = container_of(this, struct da9063, restart_handler);
> +
> +	regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> +	regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> +	regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> +
> +	return NOTIFY_DONE;
> +}
> +

Firstly, do you also need to force the AUTOBOOT (bit 3, CONTROL_C)
to ensure the PMIC does restart.

>   int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>   {
>   	int ret;
> @@ -197,6 +210,18 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>   		}
>   	}
>   
> +	da9063->restart_handler.notifier_call = da9063_restart_notify;
> +	da9063->restart_handler.priority = 128;
> +	ret = register_restart_handler(&da9063->restart_handler);
> +	if (ret) {
> +		dev_err(da9063->dev, "Failed to register restart handler\n");
> +		return ret;
> +	}
> +
> +	devm_add_action(da9063->dev,
> +			(void (*)(void *))unregister_restart_handler,
> +			&da9063->restart_handler);

there's devm_register_reboot_notifier()


> +
>   	return ret;
>   }
>   
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index fa7a43f02f27..1b20c498e340 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -85,6 +85,9 @@ struct da9063 {
>   	int		chip_irq;
>   	unsigned int	irq_base;
>   	struct regmap_irq_chip_data *regmap_irq;
> +
> +	/* Restart */
> +	struct notifier_block restart_handler;
>   };
>   
>   int da9063_device_init(struct da9063 *da9063, unsigned int irq);

Note, the watchdog driver for the DA9063 also has a restart method
although it also does not set the AUTOBOOT bit either.

The best thing is to enable the watchdog driver, the SiFive release
does not have either the core DA9063 or the watchdog driver for it
enabled.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
