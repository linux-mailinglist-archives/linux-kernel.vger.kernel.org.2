Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313A94112D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhITKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:25:46 -0400
Received: from mail-vi1eur05on2124.outbound.protection.outlook.com ([40.107.21.124]:2657
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230495AbhITKZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYz2qfeTVbdtQfUTLrK7NQgwhNZ3gSX2F4BkERgeQGEhZTEeT5oQQG19Am9A7uUzzI3dmZoddMxEhRcGp9dIUv7CWUtxFPSyikM6ep5Ta1V1mXSbCnjv/kGTZ0c2acHDMOOeMd2i/QGottjvGMLwBQcPuTTw93stOG2/dpl2nUaJJi5XR3nreKUQs1rNcWFnvKcuG6QDCovX95Jv58Oh/uud5k1ih5e3KKt0eSoEaLheuuMlIzFYeMWpji5yxfIYfUQMSqqVemd3gzqW5t/qJyEdlSVfHRJkqWYfqWr4axW/tWRexi8olXhtuS33MpluzSIXxxc2FthIHvfLal+T7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zeANjEmCiToTkN+Mu+jLJxU2LAg2oy/PHMWWaZ4zjjs=;
 b=ai6sHiJSTyH/cXtuIE3vxrFmHAD0Q8QWn6c7X9DXglLfsWSGKferwdeB00aRh+vSQhsp+iMua1Qh4n/PV/ClLIbSSoEJWBy6sFD5wqsTYB3PGr+A9XoW9kD54AuGGcmMTdZhUlduDOAED9N3KvyGd8HjFwU9YlBtOBKkrqSzcqbyanUjgyp5+DpZ6wrkD9a91u00opBUvA0UViEBQIWYMWtDyAIU/RccCk0YXrrdGgQ9YG3X3B5CPLbj9GjHRVKE5yZKwh1wkD+TpVnn3WARmaBLb/sjemhlhkeYpUpdfuKoKI5lcmwRYBGM4P2NZN9Lsr2UE5YZk+KZWUAypqO7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeANjEmCiToTkN+Mu+jLJxU2LAg2oy/PHMWWaZ4zjjs=;
 b=x+mPTA4H5kr7ucrPANV5ok7LnWuYcpIMrNyN5A2xhnFbfc7q+Xuu4+HR6C/J/DbZAUoSri+C7qZFCC19qqq/dLuTXAu6iUB8qhTDsHMo8AoH7B36luqw1kaS2XC5LrS9QQBfHb1dvhYt6Ri+5MPsLPlENzD8rLuIL6ddvDJmA/Q=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AS8P190MB1271.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 10:24:15 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%8]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 10:24:15 +0000
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
 <vrcxh2zgsnl841.fsf@plvision.eu>
 <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
Date:   Mon, 20 Sep 2021 13:24:14 +0300
Message-ID: <vrcxh2pmt3bl4h.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM5P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::23) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan (217.20.186.93) by AM5P194CA0013.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 10:24:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf944561-c897-47b4-2a6d-08d97c20cbd9
X-MS-TrafficTypeDiagnostic: AS8P190MB1271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8P190MB1271D24D9CA374517FDE47DC95A09@AS8P190MB1271.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFdzSDKUnZBceS5StQSNRcEZNIW/5EXK1020RoNRwM+nkPrU4ap6XqQu1yKk35TqmZZNT9XeLxLVqb77lCQnTS8zDcjNA9n9Mk79AmgcySdLQSfr1yD4alV0CydDkxUAYiheAdMhiqJ5FkArcMIKmpjnDCevMc00SEWJ7fr+sOxPOy94MBDO37chQMf81A+Mt/O+0XOaf5Kd9iRwGouW2XN0qV2BtQp6t/iNNYCEnVo7Hag+aalooG8yvZJhwisriXgeKybjiWNKgVWB/5LtA3lPxWK439ev2rsKLkHnpyLmo/7ZoH2TsymGlLQgBtG1l12ayAYfT23JiekeBnLWBQtF9BVNcbNDQYahe37HBQEZGwDBSCkgtmqkZsTexU2EfwqUaCfj9Mb6+GUNHvYnwsYfxDOPJcaJR5bafQkTdZkhVZXnO0LoejBvBWomDfwsbZjwsB/oMCCpZjqAPzBLvbJafTjIFvNM9IpWxvUyc9Rc5V61r0TYNvqHYAy+D222ngoBjBlbCQZ0V4nIevkmFVy0v3T/lnomcSZehP2U3AujyD7a6aTZlagfdHGMbJF4tY0B/KpHiqXnQvDTH6c0HT0kjQLCT6Y1F6p1HG8PMnMXZUTSieoUaklKh3gZw3iWHCSUM7GNzQl/Q3Va+jCmmTS/3+fktkskQXrMvl7YJ10LHOD9rndR34Ydx6DiNp7ENV3wtuG+xYDwaDafJRrDr2EYIKdBrppvx4bWTXCeb9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(376002)(136003)(346002)(26005)(2616005)(53546011)(66476007)(66946007)(478600001)(66556008)(38350700002)(316002)(956004)(54906003)(86362001)(8936002)(6486002)(6496006)(83380400001)(36756003)(2906002)(52116002)(8676002)(5660300002)(4326008)(38100700002)(44832011)(6916009)(186003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNuEqRteIFmCh57iSldha2CwlafWNRpnSzfDJrqU5Mz9HtFBbFoRM43YVZQP?=
 =?us-ascii?Q?91J6Y08kCEowe0D7VIQ2u2bM2T+Ol8d0lI9y9t8dpD/VUTc6mXhE9IR3ns/E?=
 =?us-ascii?Q?xpABnxcci2YH+wolUY5YMfjwU2LQ1rQzZcmsL1oLlXJR9dMlEdS6sqDeMmYv?=
 =?us-ascii?Q?KnoaAiqyXVLoKkAq4ZyZsGMN4Ta3vIcc63YyU8SAACjb1l2C6Davvm68gLOV?=
 =?us-ascii?Q?VIQXpn1ZOLcP6VaJ3ERD20/ov6xS+VozbkVHL/G4TTqo8ywxxg6NetcDigkE?=
 =?us-ascii?Q?AMjvgklTQtxSJPhWaohk3FTXZahzxz6OFa0Op/5pVp/xuZdLPzp6Z3i3ETtU?=
 =?us-ascii?Q?42CawvaItCnMshh/PXlBIGLE+45+rGBwQhTLkP1IIWnZHG6o3b0Cu+DU4wTl?=
 =?us-ascii?Q?w8lX50DWpc/iq4K1aRvi6iSGZ5GmldDkkLJXMQV7nYlSqLlwAI/moX2aaY5z?=
 =?us-ascii?Q?dqTcAcCzyMSjh62XxSr617l9YLPCGYOf7u8Z7vnjcC7CpBLH2DgaGJ90OYDp?=
 =?us-ascii?Q?gDfNyOmDMnoz0oZjZQLhxSbvgoRqtZj8uCkmB/4uhJhN+Ohm8fukmzKiFrZh?=
 =?us-ascii?Q?ep8j2Qh/J5zfFBIgFAjTER8oCs/OtqtFI+VmntQimkKVgXyiMCzIgX5klE9j?=
 =?us-ascii?Q?nOpjknl0NPUli6jY44XWrwwHiyrmaHwz7emc+vyrmrDMt7GfT6ycA7swoMUR?=
 =?us-ascii?Q?7JOb4CmEesoLBaNp2Q8CnBV2QVTiOlGw3oteiN9y9Wqf0RLF47n6B+Z/OJoo?=
 =?us-ascii?Q?Cfz81V+/jOUjo6HUdLv8i7lJXbXbXCSZrf3fsXH9JGq86Bl987X83DKpYrdK?=
 =?us-ascii?Q?eCSQNvv19RLPHjmCGUQLx7+j/xPbVVj/Mk7yRI+UiR1kIDXM3a//08UsU0lA?=
 =?us-ascii?Q?BvJfqfEiTBQByreOR4xyhmE/2Z+kWzUyWMNo9ZZzl+hJYLs2x0HSzjMGVtpA?=
 =?us-ascii?Q?wpUjZyTyrlsl8mgmShiTCwRhrsTzzLk/oLlJQiOgJ4jDWjFzUQ4IFG3cBAu+?=
 =?us-ascii?Q?ufPD1GW/j5ByrHL8NT5kmScJG/V7BCN3e42JMB1b7w3faXH4/4r4NOmSKhkm?=
 =?us-ascii?Q?Z5cURvZ1SEd/7FmE/gcL6FftxO980cOtGJfJsNt6XE+4OO4JElCIoi3KUXti?=
 =?us-ascii?Q?aAOmTqtmxtqoec0XkMcS/XF9tGTQPnNgIqJnN8+HiU0zK2/OiIi9BVFRlPoQ?=
 =?us-ascii?Q?asykG6xzOl5EpOVlSJWxdkFSR8jNbUXZBjBU2nE+zqudVtfzvMC2ir9nTbG+?=
 =?us-ascii?Q?nq3nxOF/Ddmgy/8e1iQj/CFwlmjqdOP2GsZvK+BdHGM4TyA9wYqHY+Vcb3u6?=
 =?us-ascii?Q?Eu3j+OZ8oBn6i+3htgwIAkk0?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf944561-c897-47b4-2a6d-08d97c20cbd9
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 10:24:15.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kYn9rHhcIGAvOp0FwSkpUFwvW44NFOGpZzS7PurXWPso7xKY6Fm5v8FqlBClob0pYM/z9ci1gS25zhXvwmbzsUxc4EfVFKzPBC0CXYnkVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1271
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> Hi Vadym,
>
>
> On 08/09/2021 10:38, Vadym Kochan wrote:
>> 
>> Hi Srini,
>> 
>> Sorry for such delay in replies, I am still confused how to
>> implement it properly, let me please explain the issues
>> which I faced with:
>
>> 
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>> 
>>> On 16/06/2021 13:33, Vadym Kochan wrote:
>>>>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>>>>> index bca671ff4e54..648373ced6d4 100644
>>>>>> --- a/drivers/nvmem/core.c
>>>>>> +++ b/drivers/nvmem/core.c
>>>>>> @@ -39,6 +39,7 @@ struct nvmem_device {
>>>>>>     	nvmem_reg_read_t	reg_read;
>>>>>>     	nvmem_reg_write_t	reg_write;
>>>>>>     	struct gpio_desc	*wp_gpio;
>>>>>> +	struct nvmem_parser_data *parser_data;
>>>>> This should be renamed to nvmem_cell_info_parser or something on those lines
>>>>> to avoid any misunderstanding on what exactly this parser is about.
>>>>>
>>>>> May be can totally avoid this by using parser name only during register.
>>>>>
>>>> I added this to keep parsed cells particulary for this nvmem in case
>>>> same parser is used for several nvmem's and mostly because of using also
>>>> cell lookup info. I will try to also answer your below question why do I need
>>>> lookups ?
>>>>
>>>> I use of_get_mac_address() func to fetch mac-address from nvmem cell.
>>>> Eventually this func calls of_get_mac_addr_nvmem() which (as I understand it
>>>> correctly) can find cells via DT by parsing "nvmem-cell-names" or via cell lookup
>>>> info of platform_device. I use the 2nd option with the following sample
>>>> solution:
>>>>
>>>> 	## DT ##
>>>> 	eeprom_at24: at24@56 {
>>>> 		compatible = "atmel,24c32";
>>>> 		nvmem-cell-parser-name = "onie-tlv-cells";
>>>> 		reg = <0x56>;
>>>> 	};
>>>>
>>>> 	onie_tlv_parser: onie-tlv-cells {
>>>> 		compatible = "nvmem-cell-parser";
>>>> 		status = "okay";
>>>>
>>>> ---> add ability here to map cell con_id to cell_name ?
>>>>
>>>> 	};
>>>>
>>>> 	some_dev_node {
>>>> 		compatible = "xxx";
>>>> 		base-mac-provider = <&onie_tlv_parser>;
>>>
>>> Real nvmem provider is eeprom_at24, why do you use onie_tlv_parse as
>>> your mac provider?
>>> If you use eeprom_at24 then of_get_mac_address() should get mac-address
>>> directly from cell info.
>> 
>> 1) This DT node is a trick to register it as a platform_device because of:
>> 
>> static int of_get_mac_addr_nvmem(struct device_node *np, u8 *addr)
>> {
>>          struct platform_device *pdev = of_find_device_by_node(np);
>>          struct nvmem_cell *cell;
>>          const void *mac;
>>          size_t len;
>>          int ret;
>>   
>>          /* Try lookup by device first, there might be a nvmem_cell_lookup
>>           * associated with a given device.
>>           */
>>          if (pdev) {
>>                  ret = nvmem_get_mac_address(&pdev->dev, addr);
>>                  put_device(&pdev->dev);
>>                  return ret;
>>          }
>>   
>>          cell = of_nvmem_cell_get(np, "mac-address");
>>          if (IS_ERR(cell))
>>                  return PTR_ERR(cell);
>>   
>>          ...
>> }
>> 
>> I tried to use at24_eeprom as ref in DTS file, but this device is not a
>> platform device but a nvmem bus device, so it fails on:
>> 
>>          ...
>> 
>>          struct platform_device *pdev = of_find_device_by_node(np);
>> 
>>          ...
>> 
>>          /* Try lookup by device first, there might be a nvmem_cell_lookup
>>           * associated with a given device.
>>           */
>>          if (pdev) {
>>                  ret = nvmem_get_mac_address(&pdev->dev, addr);
>>                  put_device(&pdev->dev);
>>                  return ret;
>>          }
>> 
>>          ...
>> 
>> Probably this might be fixed by lookup nvmem device too ?
>
> Honestly, this approach is a total hack to get it working.
>
> This is what Am thinking which should look like:
>
> ## DT ##
> eeprom_at24: at24@56 {
> 	compatible = "atmel,24c32";
> 	/* Some way to identify that this is a TLV data */
> 	nvmem-cell-parser-name = "onie-tlv-cells";
> 	reg = <0x56>;
>
> 	mac_address: mac-address {
> 		/* THIS REG is updated once TLV is parsed */
> 		reg = <0 0x6>
> 	};

I assume these cell nodes should be marked with some property that they
should be evaluated later, so the cell will be not read
in case it was not parsed because it may
exist in nvmem device optionally.

Or, treat cells with length "0" in a special way and allow to update
cell info later.

> };
>
> some_dev_node {
> 	compatible = "xxx";
> 	nvmem-cells = <&mac_address>;
> 	nvmem-cell-names = "mac-address";
> };
>
> == CODE ==
> ret = of_get_mac_address(dev->of_node, base_mac);
> ==========
>
>
> If you notice the mac_address node reg is 0.
> This node "reg" property should be updated ( using of_update_property()) 
> by nvmem-provider driver while tlv parsing and by matching the node name 
> with tlv name.
>

I assume parser driver can just invoke add_cell_table (with may be
by adding 'bool update' field to the cell_info struct) and core.c will just
update existing cells parsed from OF.

> That way rest of the code will work as usual.
>
> If this work for you then we can ask Rob if he foresee any issues in 
> this approach. I already see similar usage in reserved-memory case.
>
>
> --srini
>
>> 
>> 2) Regarding cell lookups registration, I had to use it because
>> of_nvmem_cell_get() will not find parser cells via OF.
>> 
>>>
>>>
>>>> 		status = "okay";
>>>> 	};
>>>> 	########
>>>>
>>>> 	== CODE ==
>>>> 	base_mac_np = of_parse_phandle(np, "base-mac-provider", 0);
>>>> 	ret = of_get_mac_address(base_mac_np, base_mac);
>>>> 	==========
>>>>
>>>>
>>>> And it works with this implementation because onie-tlv-cells is
>>>> registered as platform_device which name is the same as parser's name.
>>>> So the really tricky part for me is to make this cells lookup work.
>>>
>>> cell lookups are more of intended for board files, adding them in this
>>> case is really not correct.  The whole purpose of this driver is to
>>> parse the tlv cell infos into nvmem cell info.
>>>
>>>
>>> --srini
>>>
>>>
>>>>
>>>> Of course would be great if you can point a way/idea to get rid the need of
>>>> lookups.
>>>>
>> 


Regards,
Vadym Kochan
