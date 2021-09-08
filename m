Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3A403737
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348350AbhIHJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:46:14 -0400
Received: from mail-eopbgr40117.outbound.protection.outlook.com ([40.107.4.117]:2021
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245528AbhIHJqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdvZvDr3K9vC93bbknYJJDaozhLLxouXbF7EFOiPjBC2j1GKwLOKb9D9W/wGYjxxfY69gSlSFxm4QgFVRl1PM0yu2IfEmpMgC74v05t8xloTUH9HibCAEvW9k8QsuottHD/9rXiuunD0D6jNhLekQq0k22vphiHvgrZaa6RL31aCfnW9vyoo0otyTECqfxHzjBhyB9TmM1hKaeDY3cmDKdUgXdG1OTN1KT/Q70vEV3MYNADZIKpNoLvY/Da+8C27qeEyRP71WPvMIxE9UNCDpSv19mau/m9BTKu3YTqZEXcVqHK6e7CfZ31hpRFMGRKZSVMxJUM3sSuTqQ+DL/dwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=b2ALrfDTjdJuwXbC35Kt0tv9Hnc4qgQYYoFnO/5mqcQ=;
 b=TgScDRsLcsVX/rysDQii0Mjwq5YTze/m81RHGXpfdSWpYHOZcvMczYKXXr7bHDBW7Rb5Tau6QaYlFqq6XlNPNphyM/ys/nNK2B8XeMEYvdw4A+dIImTJBUmRW02fhGpi9ul9mG8rmcFdrHXIFNWAOe6B7sYvRD6Ynhmbk3S1FdsCycWefQSs+ra8pc/dMCf1X5urng0vJGzm6GY7I/biY3ZB4uc4YYJGyzYTCazTrvOY6We55v32nhJYnd1vMP8GLqnBtth7qrRT4jpFKZ+7wZlhO0bpAB271Th5qEjWZA92Cm5UwQ3lFm4y8EmlqHYSovnTUZitW3iPjqNIOdjyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2ALrfDTjdJuwXbC35Kt0tv9Hnc4qgQYYoFnO/5mqcQ=;
 b=bekTxEaem97+chfkIgIh9CmrNsNJ+LoIXBJdU4Gu57p4+X2+UlD9n9xGhAhiaeJFFU4nb/SYGRs5rykYRKa/M3SYTqIdZGA58HuUTRoOo+yVEdBXLT/Y1fH92qijdBBVQxMzbaz5DVha/E2ZAFuQkiq0IpoOwiej8N1cuta7z18=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AM5P190MB0354.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Wed, 8 Sep
 2021 09:45:01 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%9]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 09:45:01 +0000
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
Date:   Wed, 08 Sep 2021 12:44:59 +0300
Message-ID: <vrcxh2y287l7tw.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan (217.20.186.93) by AM0PR01CA0104.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 09:45:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9be303-e922-4571-b845-08d972ad53c2
X-MS-TrafficTypeDiagnostic: AM5P190MB0354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5P190MB0354E12B67BB2744F8A66D4D95D49@AM5P190MB0354.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ns+k5O0tdfyICuwmQmn/+fxQnn5D6pyoYRVOqLJVpGx9FMwfVe3WM3PTGxHu+2yMNnuoJaJj30xdvfoSjcStx1/Wb4CPM1oRWA033IFfO/ugT9wZ95Alz1ShrXe2st4q23nhxNXHjrxPp9R3qSMWR6BDd1fQ6vC/S3NYaEHHDTqWtNSrFFNnJyPunUSG09xdaN/N0w+jMrDQjgXV7YP7n+86V/5XBUSsMdsMPm7OGZ107kr9Bd2J+dfoBZ791S01XzOdgR8L1NujUAWJ9wBM7kBAK7D/iaChH619+P8eHEhwrQAi8wFokLlNlRZugN7eS3xR66ICN+3OIcYpzBdSk+vZekfY/PAV58rGqfWDBkFsiwIza5Qr+t2xQfQJZSqR2UjPTEOyoAYC68iC+NDy6kPGcQnEuq6vE/zPiIhkMLw3BNVb9n8sLS+aAHY6j2GeCy3a7eTD5kyD2I72qqSGDQp+7lUx6Rml+vxvWhkEz7jOd2N9NvmqCneP4YsyEQDUECpWRVN2lhpk6PWAUjV19UvgAuFabjOo7zERRdsQqEeTc+x1nkE49IrKL9W3cYkuarpML8J1TksbXW5zNpVdnjPA1HyEbShHni/pA1w41FwIQiPHPPGnadyUMtl7y4P11i+qEI/kjI0uPMNdNOzxyLV3kfP2/egM1CdDxtoGNPMLB2AxGokHUvigGCRl16wLJ6DKqs3Q8NM5FxNBfWQZVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(39830400003)(346002)(376002)(136003)(44832011)(36756003)(38100700002)(52116002)(86362001)(66476007)(66556008)(5660300002)(66946007)(8676002)(83380400001)(8936002)(38350700002)(2616005)(956004)(478600001)(54906003)(6916009)(53546011)(6486002)(316002)(6496006)(26005)(2906002)(4326008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZIxEx0A+4/QDy2UZfOWN1myvpp1erQBfzE/k26dGqneQWn6hPkgoCZS3mweB?=
 =?us-ascii?Q?871f7hQ6YPNYjBQe4XXM9+IrZrXnlVI1ZczHbp8OfW8FwK2C1WDq4TrRlxP3?=
 =?us-ascii?Q?52fK0wsd/1inMGLDTo9nz8mcka0BDAtxBlmVpI+JlHch4As/HyPUBXKIBF67?=
 =?us-ascii?Q?k8bBfd84RpLd4rFfp04oP3Q5FVgpIiRVo4RVTqTLkI5s8tcTT1eF+CjHOaW8?=
 =?us-ascii?Q?5w3DtlLmbKtQoBFxdXjRzHR4IP7ehnu1AmQA+lL9B2dVg1jUU1Cd/0ubwoq6?=
 =?us-ascii?Q?4Yt7pdMaW1zLgbMG9AwaQ4r4xivKNlaMYtBAap3cT/1FSNvPv1m3yCC3yL5f?=
 =?us-ascii?Q?p/8kjy7kaUoiimEkmrP0LKKm0dVxPuicpS3oTWVD5hHpneSoAAjpq6sFKV00?=
 =?us-ascii?Q?GIJ/JG0spUBzXT0h/c+zxMNWyxFubOnKWVcBU1O2+m4xhzNPVOuDq40p0bVI?=
 =?us-ascii?Q?soiafEl2wtbgfDDYXFjgm/Ier7F2Uj3VK0RtY3ug0o7r8MvysE/ESkS15aS1?=
 =?us-ascii?Q?4lTUd9e5NbtYzweHyQGU/J/kHBOzSvpXfxroarUeWZqYeUsl2KwMj+Z+4BHv?=
 =?us-ascii?Q?mZYkjnOli5KZ74+JEiHyJCWAwi4EWpsWvaK5/62NI1a5Ob0/Sp0J8u3YjUw5?=
 =?us-ascii?Q?H+LiC1eGx59AvSSdXNaHdesxIfXEAJWrhnzqGP0ef6bVjlxHfjB3GyqoFbSQ?=
 =?us-ascii?Q?vWKDp9JvqVk3QtXDQBk8WMa8YMQzg+gr+XsX5AZNjU6GrKPW4f4KtvoyJEcN?=
 =?us-ascii?Q?rXg9OopOoayGwfR+M7wvrkIwPF9DPkJLCOUG/h7aHnGpfzGr/X8gtkGgPJDu?=
 =?us-ascii?Q?+HNE3f7ZjgCIjjjNf6lT4eqeq9YzbV70epFVIBP0awsRmZTh1UcWNSdcaYNf?=
 =?us-ascii?Q?iP9wUvBxzjmyQT3OGHbSD2K+JIQ/YClLRtQT2apIaipz3O5qEvEVhQrKN+Ci?=
 =?us-ascii?Q?gxJLBNAH/mGMKk6H+hQSabw/8DCjjHh3Ft67EwCy9U53OXqKnueJ2epLFOAU?=
 =?us-ascii?Q?/X2WPaICUogI1qvid/E8iPTV8pBVJ4V3o1TICkNw94ft7pVhgUiw7+bMaioE?=
 =?us-ascii?Q?bsNE9YuCbkaMkY3jFx1wwDW8oedsYNIEHSk+wERvvImjSrbqlQ0sph0/VikO?=
 =?us-ascii?Q?ZBYbx+QbS2VczbE/WRN90nQxhZlqy2iMog64TbpnbW2wSOqXt6mUhBo5qrlC?=
 =?us-ascii?Q?5kIc1w/ikXZ2HVx54Xba/K8bNqiV1R5RhJCA94mMgn1cLbkQEdINE3B+V0xZ?=
 =?us-ascii?Q?ejW84Rxu9DoAyVzQIbJBLpJGz8zmAtU2+TZHHzHlR3wGMe4tl70b52h2dTyi?=
 =?us-ascii?Q?+xEK1n5BgjeDMp1/buzhW5I9?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9be303-e922-4571-b845-08d972ad53c2
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 09:45:01.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jFKwXNaZ3YgnJW1hsGDQk9SdEI8bqBLa1EusuX/+igbe4eOXWMjrIaY1M1JhwdP3VgiNRjkwMewnV2kRhE5GTu05owUw+iAZOgSNakYDxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P190MB0354
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 08/06/2021 20:03, Vadym Kochan wrote:
>> Current implementation does not allow to register cells for already
>> registered nvmem device and requires that this should be done before. But
>> there might a driver which needs to parse the nvmem device and after
>> register a cells table.
>> 
>> Introduce nvmem_parser API which allows to register cells parser which
>> is called during nvmem device registration. During this stage the parser
>> can read the nvmem device and register the cells table.
>> 
>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>> ---
>> v2:
>>      1) Added nvmem_parser_data so parser implementation
>>         should fill it with cells table and lookups which
>>         will be registered by core.c after cells_parse was
>>         succeed.
>> 
>>      2) Removed cells_remove callback from nvmem_parser_config which
>>         is not needed because cells table & lookups are
>>         registered/unregistered automatically by core.
>> 
>>      3) Use new device property to read cells parser name during nvmem
>>         registration. Removed of_node usage.
>> 
>>      4) parser's module refcount is incremented/decremented on each parser
>>         bind/unbind to nvmem device.
>> 
>>   drivers/nvmem/core.c           | 178 +++++++++++++++++++++++++++++++++
>>   include/linux/nvmem-provider.h |  31 ++++++
>>   2 files changed, 209 insertions(+)
>> 
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index bca671ff4e54..648373ced6d4 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -39,6 +39,7 @@ struct nvmem_device {
>>   	nvmem_reg_read_t	reg_read;
>>   	nvmem_reg_write_t	reg_write;
>>   	struct gpio_desc	*wp_gpio;
>> +	struct nvmem_parser_data *parser_data;
>
> This should be renamed to nvmem_cell_info_parser or something on those 
> lines to avoid any misunderstanding on what exactly this parser is about.
>
> May be can totally avoid this by using parser name only during register.
>
>>   	void *priv;
>>   };
>>   
>> @@ -57,6 +58,13 @@ struct nvmem_cell {
>>   	struct list_head	node;
>>   };
>>   
>> +struct nvmem_parser {
>> +	struct list_head	head;
>> +	nvmem_parse_t		cells_parse;
>> +	const char		*name;
>> +	struct module		*owner;
>> +};
>> +
>>   static DEFINE_MUTEX(nvmem_mutex);
>>   static DEFINE_IDA(nvmem_ida);
>>   
>> @@ -66,6 +74,9 @@ static LIST_HEAD(nvmem_cell_tables);
>>   static DEFINE_MUTEX(nvmem_lookup_mutex);
>>   static LIST_HEAD(nvmem_lookup_list);
>>   
>> +static DEFINE_MUTEX(nvmem_parser_mutex);
>> +static LIST_HEAD(nvmem_parser_list);
>> +
>>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>>   
>>   static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
>> @@ -418,6 +429,118 @@ static struct bus_type nvmem_bus_type = {
>>   	.name		= "nvmem",
>>   };
>>   
>> +static struct nvmem_parser *__nvmem_parser_get(const char *name)
>> +{
>> +	struct nvmem_parser *tmp, *parser = NULL;
>> +
>> +	list_for_each_entry(tmp, &nvmem_parser_list, head) {
>> +		if (strcmp(name, tmp->name) == 0) {
>> +			parser = tmp;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!parser)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	if (!try_module_get(parser->owner)) {
>> +		pr_err("could not increase module refcount for parser %s\n",
>> +		       parser->name);
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	}
>> +
>> +	return parser;
>> +}
>> +
>> +static void nvmem_parser_put(const struct nvmem_parser *parser)
>> +{
>> +	module_put(parser->owner);
>> +}
>> +
>> +static int nvmem_parser_bind(struct nvmem_device *nvmem, const char *name)
>> +{
> Do we really need parser bind/unbind mechanisms for what we are trying 
> to do here.
>
> It's just simply parsing cell info during nvmem register, do we really 
> care if parser is there or not after that?
>
> code can be probably made much simpler by just doing this in nvmem_register
>
> parser_get()
> parse_get_cell_info()
> parser_put()
>
> AFAIU, that is all we need.
>

bind/unbind is just for connecting parser instance with a nvmem device,
but the real reason is because of need of these cell lookups info,
and then freeing them.

If it would be possible to lookup parser's cell without these lookups
(I tried to explain the issue with this in other reply in this series)
then yes, just adding cell info would be enough.

>> +	struct nvmem_parser_data *data;
>> +	struct nvmem_parser *parser;
>> +	int err;
>> +
>> +	mutex_lock(&nvmem_parser_mutex);
>> +
>> +	parser = __nvmem_parser_get(name);
>> +	err = PTR_ERR_OR_ZERO(parser);
>> +	if (!err) { > +		data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +		if (data) {
>> +			data->parser = parser;
>> +			nvmem->parser_data = data;
>> +		} else {
>> +			nvmem_parser_put(parser);
>> +			err = -ENOMEM;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&nvmem_parser_mutex);
>> +
>> +	return err;
>> +}
>> +
>> +static void nvmem_parser_unbind(const struct nvmem_device *nvmem)
>> +{
>> +	struct nvmem_parser_data *data = nvmem->parser_data;
>> +
>> +	if (data->table.cells) {
>> +		nvmem_del_cell_table(&data->table);
>> +		kfree(data->table.cells);
> who has allocated memory for this, its confusing for this to be freed in 
> core.
>> +	}
>> +	if (data->lookup) { > +		nvmem_del_cell_lookups(data->lookup, data->nlookups);
>> +		kfree(data->lookup);
>> +	}
>> +
>> +	nvmem_parser_put(data->parser);
>> +}
>> +
>> +static void nvmem_parser_data_register(struct nvmem_device *nvmem,
>> +				       struct nvmem_parser_data *data)
>> +{
>> +	if (data->table.cells) {
>> +		if (!data->table.nvmem_name)
>> +			data->table.nvmem_name = nvmem_dev_name(nvmem);
>> +
>> +		nvmem_add_cell_table(&data->table);
>> +	}
>> +
>> +	if (data->lookup) {
> Why do we need lookups?
> the cells are already associated with provider. lookups are normally 
> used for associating devices with nvmemcell more for old non-dt machine 
> code.
>
> you can remove this.
>> +		struct nvmem_cell_lookup *lookup = &data->lookup[0];
>> +		int i = 0;
>> +
>> +		for (i = 0; i < data->nlookups; i++, lookup++) {
>> +			if (!lookup->nvmem_name)
>> +				lookup->nvmem_name = nvmem_dev_name(nvmem);
>> +
>> +			if (!lookup->dev_id)
>> +				lookup->dev_id = data->parser->name;
>> +		}
>> +
>> +		nvmem_add_cell_lookups(data->lookup, data->nlookups);
>> +	}
>> +}
>> +
>
> --srini

