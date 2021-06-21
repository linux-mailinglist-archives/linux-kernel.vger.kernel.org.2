Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8079F3AF89D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 00:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhFUWjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 18:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhFUWjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 18:39:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F37C061574;
        Mon, 21 Jun 2021 15:37:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e22so17808272wrc.1;
        Mon, 21 Jun 2021 15:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GD/DgAs0LBcRPf92Bu3f3Hvck0WeokFUp2YgSU/5KTo=;
        b=mQHkD8Fcg0ErH+q79l3MoD1GSvgSInruB1kxlleTY5rZ8sx8vR1H9IfT+ntMWgr5ZZ
         Po55tMN5CyThLPdipG/5bkVlQqy/3fQtZcYkO4PQqmbh3H6XtkNA3iq3oTOmY0Kb3vPr
         +nwKeOIPStmESBhY1bll9/GlnfUM7QiiPZofJHbzjBOL5OMddQfJ8T8ZXHgpzfLGeQV/
         dFEV4HBmivqElsrIoJfkafjcJoNCu4lKFtl3rOhto8wkfwEBrzKlmdnUoRgVr+Y3l2BC
         uhG0galyUASeVzqAioVpHlWKYOHtI8y15Dh70t2fvhSY4XQb+LaM+RFVfm/XXVEgs8qi
         JYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GD/DgAs0LBcRPf92Bu3f3Hvck0WeokFUp2YgSU/5KTo=;
        b=bQMnal8G6hGoe/JMBMK4lp6hd/qiEPd5tGQlKV7tfubtCqcHjQVg5TaxwKm44Gm0d/
         Mpsk8ae1L6ILNNogAbLpFdZP3YGxspBqQwET3EMsBvQA7pQ1eagxezuVba51WcyYeTal
         niv1c4ARyCpYK6+duhYrtsZ0clhiFgoWeC0SmOMBA7ror7cdaznYY5+FYToN3tnTjQ/X
         p2qfBG2ghMKbqAfgTrRICxWF/dpBO+xbGWBtwvezq6zhzsQLOSLVaL4flK9QjgLb9jbg
         l0Pxh+vz2AKxqEPX1ykLidknsoNTfcyYH3HdCwgQKkIEXvryWAfcg690Z5qQiklFmtYm
         iNog==
X-Gm-Message-State: AOAM530pXufNabuzbqWtjGQo1pgUW4O4MCfidR6Yh3P+8lTSNc2ZF+ak
        PchvEm+YSCwL1R667VwhaoY=
X-Google-Smtp-Source: ABdhPJz51JzPUciloR/ROzGa7XzIKIvL9495CeIUC0bL0jnpv2DpXGP91QDOJkLA0XHo2n+5gzatKQ==
X-Received: by 2002:adf:f94c:: with SMTP id q12mr795576wrr.417.1624315035746;
        Mon, 21 Jun 2021 15:37:15 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.116])
        by smtp.gmail.com with ESMTPSA id f13sm19475624wrt.86.2021.06.21.15.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 15:37:15 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] platform/x86: intel_skl_int3472: Use ACPI GPIO
 resource directly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
 <20210618125516.53510-4-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <a9493e7a-5cde-085a-145b-56d246dd0bcc@gmail.com>
Date:   Mon, 21 Jun 2021 23:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618125516.53510-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 13:55, Andy Shevchenko wrote:
> When we call acpi_gpio_get_io_resource(), the output will be
> the pointer to the ACPI GPIO resource. Use it directly instead of
> dereferencing the generic resource.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


This is much better, thanks.


Reviewed-by: Daniel Scally <djrscally@gmail.com>

Tested-by: Daniel Scally <djrscally@gmail.com>


> ---
> v2: new patch
>  .../intel_skl_int3472_clk_and_regulator.c     |  7 ++---
>  .../intel-int3472/intel_skl_int3472_common.h  |  2 +-
>  .../intel_skl_int3472_discrete.c              | 28 +++++++++----------
>  3 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
> index ceee860e2c07..49ea1e86c193 100644
> --- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
> @@ -131,10 +131,10 @@ int skl_int3472_register_clock(struct int3472_discrete_device *int3472)
>  }
>  
>  int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
> -				   struct acpi_resource *ares)
> +				   struct acpi_resource_gpio *agpio)
>  {
> -	char *path = ares->data.gpio.resource_source.string_ptr;
>  	const struct int3472_sensor_config *sensor_config;
> +	char *path = agpio->resource_source.string_ptr;
>  	struct regulator_consumer_supply supply_map;
>  	struct regulator_init_data init_data = { };
>  	struct regulator_config cfg = { };
> @@ -168,8 +168,7 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
>  						int3472->regulator.supply_name,
>  						&int3472_gpio_regulator_ops);
>  
> -	int3472->regulator.gpio = acpi_get_and_request_gpiod(path,
> -							     ares->data.gpio.pin_table[0],
> +	int3472->regulator.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
>  							     "int3472,regulator");
>  	if (IS_ERR(int3472->regulator.gpio)) {
>  		dev_err(int3472->dev, "Failed to get regulator GPIO line\n");
> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
> index 6fdf78584219..765e01ec1604 100644
> --- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
> @@ -113,6 +113,6 @@ union acpi_object *skl_int3472_get_acpi_buffer(struct acpi_device *adev,
>  int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb);
>  int skl_int3472_register_clock(struct int3472_discrete_device *int3472);
>  int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
> -				   struct acpi_resource *ares);
> +				   struct acpi_resource_gpio *agpio);
>  
>  #endif
> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> index 48a00a1f4fb6..fd681d2a73fe 100644
> --- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
> @@ -103,11 +103,11 @@ skl_int3472_get_sensor_module_config(struct int3472_discrete_device *int3472)
>  }
>  
>  static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
> -					  struct acpi_resource *ares,
> +					  struct acpi_resource_gpio *agpio,
>  					  const char *func, u32 polarity)
>  {
> -	char *path = ares->data.gpio.resource_source.string_ptr;
>  	const struct int3472_sensor_config *sensor_config;
> +	char *path = agpio->resource_source.string_ptr;
>  	struct gpiod_lookup *table_entry;
>  	struct acpi_device *adev;
>  	acpi_handle handle;
> @@ -145,7 +145,7 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
>  
>  	table_entry = &int3472->gpios.table[int3472->n_sensor_gpios];
>  	table_entry->key = acpi_dev_name(adev);
> -	table_entry->chip_hwnum = ares->data.gpio.pin_table[0];
> +	table_entry->chip_hwnum = agpio->pin_table[0];
>  	table_entry->con_id = func;
>  	table_entry->idx = 0;
>  	table_entry->flags = polarity;
> @@ -156,23 +156,22 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
>  }
>  
>  static int skl_int3472_map_gpio_to_clk(struct int3472_discrete_device *int3472,
> -				       struct acpi_resource *ares, u8 type)
> +				       struct acpi_resource_gpio *agpio, u8 type)
>  {
> -	char *path = ares->data.gpio.resource_source.string_ptr;
> +	char *path = agpio->resource_source.string_ptr;
> +	u16 pin = agpio->pin_table[0];
>  	struct gpio_desc *gpio;
>  
>  	switch (type) {
>  	case INT3472_GPIO_TYPE_CLK_ENABLE:
> -		gpio = acpi_get_and_request_gpiod(path, ares->data.gpio.pin_table[0],
> -						  "int3472,clk-enable");
> +		gpio = acpi_get_and_request_gpiod(path, pin, "int3472,clk-enable");
>  		if (IS_ERR(gpio))
>  			return (PTR_ERR(gpio));
>  
>  		int3472->clock.ena_gpio = gpio;
>  		break;
>  	case INT3472_GPIO_TYPE_PRIVACY_LED:
> -		gpio = acpi_get_and_request_gpiod(path, ares->data.gpio.pin_table[0],
> -						  "int3472,privacy-led");
> +		gpio = acpi_get_and_request_gpiod(path, pin, "int3472,privacy-led");
>  		if (IS_ERR(gpio))
>  			return (PTR_ERR(gpio));
>  
> @@ -242,7 +241,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  
>  	if (!obj) {
>  		dev_warn(int3472->dev, "No _DSM entry for GPIO pin %u\n",
> -			 ares->data.gpio.pin_table[0]);
> +			 agpio->pin_table[0]);
>  		return 1;
>  	}
>  
> @@ -250,15 +249,14 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  
>  	switch (type) {
>  	case INT3472_GPIO_TYPE_RESET:
> -		ret = skl_int3472_map_gpio_to_sensor(int3472, ares, "reset",
> +		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "reset",
>  						     GPIO_ACTIVE_LOW);
>  		if (ret)
>  			err_msg = "Failed to map reset pin to sensor\n";
>  
>  		break;
>  	case INT3472_GPIO_TYPE_POWERDOWN:
> -		ret = skl_int3472_map_gpio_to_sensor(int3472, ares,
> -						     "powerdown",
> +		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "powerdown",
>  						     GPIO_ACTIVE_LOW);
>  		if (ret)
>  			err_msg = "Failed to map powerdown pin to sensor\n";
> @@ -266,13 +264,13 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  		break;
>  	case INT3472_GPIO_TYPE_CLK_ENABLE:
>  	case INT3472_GPIO_TYPE_PRIVACY_LED:
> -		ret = skl_int3472_map_gpio_to_clk(int3472, ares, type);
> +		ret = skl_int3472_map_gpio_to_clk(int3472, agpio, type);
>  		if (ret)
>  			err_msg = "Failed to map GPIO to clock\n";
>  
>  		break;
>  	case INT3472_GPIO_TYPE_POWER_ENABLE:
> -		ret = skl_int3472_register_regulator(int3472, ares);
> +		ret = skl_int3472_register_regulator(int3472, agpio);
>  		if (ret)
>  			err_msg = "Failed to map regulator to sensor\n";
>  
