Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843F138CDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbhEUSpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhEUSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:45:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F211C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:44:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d11so21961796wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8Z/QXHnUfTkXQhNoayjp7WtOt3kAL1EVir5n540m8E=;
        b=UDYNF1331XPzsY7GSP0dE2lpiY6kPJq5qmHwJqFgHsF7bcC/og12pEi7gt1PdLqvhc
         SK1IEV0vMHj1AEqqrPhcvfbkgyXGn/l02UYFAqa+3Xznl0FYMe7jPrtkspQoaZ/OIDn4
         YXJwz6cNnandUu9EgnICKeUCykKhF/6qaPXBk5CdnE1jbeY8DLV+mz/xBLuXYuNCHkYp
         +nqmUDaUc6tUAibpwpEQ/c6GRqxn2JCZYa+AVgMZ1R2e9rMTff+6z2ImU9nkCtkYPXIP
         67z4P7vlVNcMO7F5PJLna5knS8UqSs5wGGN5OHpLAOpwFx2mj4yPg4ECkEexc66qlovg
         i3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8Z/QXHnUfTkXQhNoayjp7WtOt3kAL1EVir5n540m8E=;
        b=nXWq3s+DFF9BJ2/nrt01/EkAYmHyvwXfGNCb2sNjEHQK6D80365Yf5lUxVhUpNyVSV
         w5NWVRnZ52AZoNPsD+BkRx6jzxm8IHdP/oglIjAYBKggXYP/b2iW0JL7siugD7whXYae
         KpkxlNcoinBphbR0zKdbecZwWcwI8aPVOezjJWGWByMu9hRluzIuknzO0jOBcRBRG5Vj
         4LQ9SOsPioFSqwoaBWW8HjPDwZqFxp23Div9Yl4W3QMIE1ogsf18jRU1xT2yUfQRP8FG
         MHyqCz3elgOLQYLK90+JIdDOMxHga2FDrGHPvhN0r+jUVd+AB15UdlNIGoKqjoIrV9NS
         PpQg==
X-Gm-Message-State: AOAM5308XRZg+n4vWozCNAfFHOufYdBzQPC8k8hj1OuUr30Vqi62hdfb
        278cmvI42aH4OJEk24zCJ8A=
X-Google-Smtp-Source: ABdhPJw5GA6Y4j8OrBibNusB6OKvB0t2xnxqApbNwFIj0Ga4VHVXnZTuenloVD9/UvohC3uA4iUfCA==
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr10867623wrf.32.1621622646995;
        Fri, 21 May 2021 11:44:06 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:3901:4092:a56:60d4? (p200300ea8f384600390140920a5660d4.dip0.t-ipconnect.de. [2003:ea:8f38:4600:3901:4092:a56:60d4])
        by smtp.googlemail.com with ESMTPSA id n10sm2865953wrw.37.2021.05.21.11.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 11:44:06 -0700 (PDT)
Subject: Re: [PATCH v2] eeprom: ee1004: Let device core handle attribute
 eeprom
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
 <082be5db-46ef-6ddd-c33f-b30d5037a3f5@gmail.com>
Message-ID: <bfcc85e9-4f05-b407-6568-e605afc831e4@gmail.com>
Date:   Fri, 21 May 2021 20:43:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <082be5db-46ef-6ddd-c33f-b30d5037a3f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg added his Reviewed-by to v1, so you may disregard v2.

On 20.05.2021 21:25, Heiner Kallweit wrote:
> Instead of creating/removing the attribute ourselves, just declare the
> attribute and let the device core handle it. This allows to simplify
> the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - open-code the proposed BIN_ATTRIBUTES_GROUPS macro
> I leave it to you which version you prefer.
> ---
>  drivers/misc/eeprom/ee1004.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
> index 252e15ba6..d61acdaba 100644
> --- a/drivers/misc/eeprom/ee1004.c
> +++ b/drivers/misc/eeprom/ee1004.c
> @@ -89,7 +89,7 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
>  	return status;
>  }
>  
> -static ssize_t ee1004_read(struct file *filp, struct kobject *kobj,
> +static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
>  			   struct bin_attribute *bin_attr,
>  			   char *buf, loff_t off, size_t count)
>  {
> @@ -160,15 +160,19 @@ static ssize_t ee1004_read(struct file *filp, struct kobject *kobj,
>  	return requested;
>  }
>  
> -static const struct bin_attribute eeprom_attr = {
> -	.attr = {
> -		.name = "eeprom",
> -		.mode = 0444,
> -	},
> -	.size = EE1004_EEPROM_SIZE,
> -	.read = ee1004_read,
> +static BIN_ATTR_RO(eeprom, EE1004_EEPROM_SIZE);
> +
> +static struct bin_attribute *ee1004_attrs[] = {
> +	&bin_attr_eeprom,
> +	NULL
> +};
> +
> +static const struct attribute_group ee1004_group = {
> +	.bin_attrs = ee1004_attrs,
>  };
>  
> +__ATTRIBUTE_GROUPS(ee1004);
> +
>  static int ee1004_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -222,11 +226,6 @@ static int ee1004_probe(struct i2c_client *client,
>  		ee1004_current_page);
>  	mutex_unlock(&ee1004_bus_lock);
>  
> -	/* Create the sysfs eeprom file */
> -	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
> -	if (err)
> -		goto err_clients_lock;
> -
>  	dev_info(&client->dev,
>  		 "%u byte EE1004-compliant SPD EEPROM, read-only\n",
>  		 EE1004_EEPROM_SIZE);
> @@ -237,8 +236,6 @@ static int ee1004_probe(struct i2c_client *client,
>  
>  	return 0;
>  
> - err_clients_lock:
> -	mutex_lock(&ee1004_bus_lock);
>   err_clients:
>  	if (--ee1004_dev_count == 0) {
>  		for (cnr--; cnr >= 0; cnr--) {
> @@ -255,8 +252,6 @@ static int ee1004_remove(struct i2c_client *client)
>  {
>  	int i;
>  
> -	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
> -
>  	/* Remove page select clients if this is the last device */
>  	mutex_lock(&ee1004_bus_lock);
>  	if (--ee1004_dev_count == 0) {
> @@ -275,6 +270,7 @@ static int ee1004_remove(struct i2c_client *client)
>  static struct i2c_driver ee1004_driver = {
>  	.driver = {
>  		.name = "ee1004",
> +		.dev_groups = ee1004_groups,
>  	},
>  	.probe = ee1004_probe,
>  	.remove = ee1004_remove,
> 

