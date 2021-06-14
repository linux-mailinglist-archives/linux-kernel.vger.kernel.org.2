Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD13A6215
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhFNKzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:55:32 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42536 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhFNKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:48:19 -0400
Received: by mail-wr1-f52.google.com with SMTP id c5so13996741wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8d/+A3nrsnLJMgR/AIVYK9SWox/OsVV6RfKVCOtelGA=;
        b=RZ4RiiLQhy0zOTYNVjuHga3qM0UGB6CNFpcu61gCFgtGKxmVQf1HR8N9tTEMGHIXx8
         zkvLalvqidxCcNwtrk7n/c63E7saX5t2wMsOxreXm2M81o0HK6SjZuzE0OxLjvkXskBJ
         zWXXFyIvw+wX+xp15Gx3Z8xZZOuAYgdv4mwpsHRm0pfTYdqXtyh3GcIm1bj47taUb5YO
         qyBtFzR1lW5R9a1gOybKje62SpkbVGPxggciRHW9MX8MFINsvHPvKmRVAamxxGtU/Ww/
         hD5GCl/ohMah/6Rhi508JURocnRQHwY8VQRhKfCh2LI43CJVZxxjFTfVvq880zAozZ+j
         FMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8d/+A3nrsnLJMgR/AIVYK9SWox/OsVV6RfKVCOtelGA=;
        b=JtzS9Y7o7g5baGJrHz0s2GyT3Q0r1SZ0kr4/TNtuNbRBEeaVQ1kjjzZKYGovWzLWse
         M2KHlTUArubT08ngqAZPsNXUkQpZznDlKXiqn0aOaCygnvvIHkgaH4Cwx6/H6TdFdNT+
         CtvwwGFpG4+i7k77KCSqJK0hKiFA50czMFa3hdXkc68ULLg3SPIAJ6DLZ4iUuOarssl7
         6R/JiN1I+ivBDWrEYu7sv/zzcDiNp3CGB/lFxEwhaPZirCaguRWtZmt+MPRju04kpoB8
         vP7cE8O8TC2E9YDthNT7helwnkHZNwgGaC2DUN+6Oz5BtOz1QzkLb7yLgtJvg9kGJ6qj
         I6YQ==
X-Gm-Message-State: AOAM532tJNCCS+1gTl4y11w9D0tAHvTP8O4DRDL28uVP1l+j7HgSg2FK
        WgPk5JQhamRRh0XldJR2EIOg8Q==
X-Google-Smtp-Source: ABdhPJyLXiN6JycbTN1svrMiyzlNZjRab04Oc3sN833/qLym10qO7qGkP2CV4Pc2qBxhpZWFnhb5qw==
X-Received: by 2002:adf:a195:: with SMTP id u21mr17680126wru.367.1623667501217;
        Mon, 14 Jun 2021 03:45:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r18sm15843544wro.62.2021.06.14.03.45.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jun 2021 03:45:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
Date:   Mon, 14 Jun 2021 11:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210608190327.22071-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2021 20:03, Vadym Kochan wrote:
> Current implementation does not allow to register cells for already
> registered nvmem device and requires that this should be done before. But
> there might a driver which needs to parse the nvmem device and after
> register a cells table.
> 
> Introduce nvmem_parser API which allows to register cells parser which
> is called during nvmem device registration. During this stage the parser
> can read the nvmem device and register the cells table.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2:
>      1) Added nvmem_parser_data so parser implementation
>         should fill it with cells table and lookups which
>         will be registered by core.c after cells_parse was
>         succeed.
> 
>      2) Removed cells_remove callback from nvmem_parser_config which
>         is not needed because cells table & lookups are
>         registered/unregistered automatically by core.
> 
>      3) Use new device property to read cells parser name during nvmem
>         registration. Removed of_node usage.
> 
>      4) parser's module refcount is incremented/decremented on each parser
>         bind/unbind to nvmem device.
> 
>   drivers/nvmem/core.c           | 178 +++++++++++++++++++++++++++++++++
>   include/linux/nvmem-provider.h |  31 ++++++
>   2 files changed, 209 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index bca671ff4e54..648373ced6d4 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -39,6 +39,7 @@ struct nvmem_device {
>   	nvmem_reg_read_t	reg_read;
>   	nvmem_reg_write_t	reg_write;
>   	struct gpio_desc	*wp_gpio;
> +	struct nvmem_parser_data *parser_data;

This should be renamed to nvmem_cell_info_parser or something on those 
lines to avoid any misunderstanding on what exactly this parser is about.

May be can totally avoid this by using parser name only during register.

>   	void *priv;
>   };
>   
> @@ -57,6 +58,13 @@ struct nvmem_cell {
>   	struct list_head	node;
>   };
>   
> +struct nvmem_parser {
> +	struct list_head	head;
> +	nvmem_parse_t		cells_parse;
> +	const char		*name;
> +	struct module		*owner;
> +};
> +
>   static DEFINE_MUTEX(nvmem_mutex);
>   static DEFINE_IDA(nvmem_ida);
>   
> @@ -66,6 +74,9 @@ static LIST_HEAD(nvmem_cell_tables);
>   static DEFINE_MUTEX(nvmem_lookup_mutex);
>   static LIST_HEAD(nvmem_lookup_list);
>   
> +static DEFINE_MUTEX(nvmem_parser_mutex);
> +static LIST_HEAD(nvmem_parser_list);
> +
>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>   
>   static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> @@ -418,6 +429,118 @@ static struct bus_type nvmem_bus_type = {
>   	.name		= "nvmem",
>   };
>   
> +static struct nvmem_parser *__nvmem_parser_get(const char *name)
> +{
> +	struct nvmem_parser *tmp, *parser = NULL;
> +
> +	list_for_each_entry(tmp, &nvmem_parser_list, head) {
> +		if (strcmp(name, tmp->name) == 0) {
> +			parser = tmp;
> +			break;
> +		}
> +	}
> +
> +	if (!parser)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	if (!try_module_get(parser->owner)) {
> +		pr_err("could not increase module refcount for parser %s\n",
> +		       parser->name);
> +		return ERR_PTR(-EINVAL);
> +
> +	}
> +
> +	return parser;
> +}
> +
> +static void nvmem_parser_put(const struct nvmem_parser *parser)
> +{
> +	module_put(parser->owner);
> +}
> +
> +static int nvmem_parser_bind(struct nvmem_device *nvmem, const char *name)
> +{
Do we really need parser bind/unbind mechanisms for what we are trying 
to do here.

It's just simply parsing cell info during nvmem register, do we really 
care if parser is there or not after that?

code can be probably made much simpler by just doing this in nvmem_register

parser_get()
parse_get_cell_info()
parser_put()

AFAIU, that is all we need.

> +	struct nvmem_parser_data *data;
> +	struct nvmem_parser *parser;
> +	int err;
> +
> +	mutex_lock(&nvmem_parser_mutex);
> +
> +	parser = __nvmem_parser_get(name);
> +	err = PTR_ERR_OR_ZERO(parser);
> +	if (!err) { > +		data = kzalloc(sizeof(*data), GFP_KERNEL);
> +		if (data) {
> +			data->parser = parser;
> +			nvmem->parser_data = data;
> +		} else {
> +			nvmem_parser_put(parser);
> +			err = -ENOMEM;
> +		}
> +	}
> +
> +	mutex_unlock(&nvmem_parser_mutex);
> +
> +	return err;
> +}
> +
> +static void nvmem_parser_unbind(const struct nvmem_device *nvmem)
> +{
> +	struct nvmem_parser_data *data = nvmem->parser_data;
> +
> +	if (data->table.cells) {
> +		nvmem_del_cell_table(&data->table);
> +		kfree(data->table.cells);
who has allocated memory for this, its confusing for this to be freed in 
core.
> +	}
> +	if (data->lookup) { > +		nvmem_del_cell_lookups(data->lookup, data->nlookups);
> +		kfree(data->lookup);
> +	}
> +
> +	nvmem_parser_put(data->parser);
> +}
> +
> +static void nvmem_parser_data_register(struct nvmem_device *nvmem,
> +				       struct nvmem_parser_data *data)
> +{
> +	if (data->table.cells) {
> +		if (!data->table.nvmem_name)
> +			data->table.nvmem_name = nvmem_dev_name(nvmem);
> +
> +		nvmem_add_cell_table(&data->table);
> +	}
> +
> +	if (data->lookup) {
Why do we need lookups?
the cells are already associated with provider. lookups are normally 
used for associating devices with nvmemcell more for old non-dt machine 
code.

you can remove this.
> +		struct nvmem_cell_lookup *lookup = &data->lookup[0];
> +		int i = 0;
> +
> +		for (i = 0; i < data->nlookups; i++, lookup++) {
> +			if (!lookup->nvmem_name)
> +				lookup->nvmem_name = nvmem_dev_name(nvmem);
> +
> +			if (!lookup->dev_id)
> +				lookup->dev_id = data->parser->name;
> +		}
> +
> +		nvmem_add_cell_lookups(data->lookup, data->nlookups);
> +	}
> +}
> +

--srini
