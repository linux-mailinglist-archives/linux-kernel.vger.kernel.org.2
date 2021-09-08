Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC137403714
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348127AbhIHJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:40:06 -0400
Received: from mail-eopbgr140132.outbound.protection.outlook.com ([40.107.14.132]:55268
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234842AbhIHJkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:40:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4Z5hxGg1xxH5FQB0Lt4Lp3jXz3eESe+Ikrf2J1E7010B4tTUu4dgITfqoEBBnpxD6Ybg/zlW/S1pwWE+MEPOCorTHiP75VkKk6HvEGi0AWseKSZI61FKHLUvVQljaTlnuczKOinPdonGtoC4dxYBa0rTNszC7qwE+12E5IdT/VDJaiD5K3UJ5QjRNNmW4MTnyOcd6Ej5r3OhhvBeK06UECrxq6brgbK6+vHx2tmlzc1p/IwfqOdRR7EcsRrKQ6dCoNXsbZ9TvmxTm+Vvu7tEyw1wsHNm6q7YKK8BN1i5Hz9V5OP6VxKz3AI3yEnLu7NIu75IcKrfc9pTV8INXEU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lazvFEY7r9kkDRMkznNNPHYCvffoWvdRqcp9Sj83Lm0=;
 b=nuvk+hP/UUJRT0OUPD47YtsiKVbPWn3dyv/5LxU4OM6xwTWUGF6W/JxFyzHFuzxmg17CujIzO1tMB5oVzRfdIFT8gnrL6iu/74PPPBXBx0xLq9TvJ2oTOP1GZxZVjpw0neK6P8XtqqQstoM0AML3TtmfTPagTXYrkvnzypjOYOABkOLxH80fpl3t5pj7rw2s4dPZyM1+i9vZvh2K4VQ1gsR+FRj82WIKakd2F190OQI0jmIAkrZSccMQks9kwKkqerZtoTcxx59tXQeHkWK6R8ycoj1i/GGdnMCBXDOW+yWZOb1W6oxmV27fOiesJ3ezJiYyHfbRwRKP+nflBd/AIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lazvFEY7r9kkDRMkznNNPHYCvffoWvdRqcp9Sj83Lm0=;
 b=LvG9K7DxFfP3RhS/63MBnAuRkH2UhYI7sEWVTTdn6qM6zNmmbzBAQjL9rT5ysfJmXEmoU7gFTlQZgb7EAko8VaTt3LwpYhfsEJLR747MG8ZW1FmBe/tOztJlp4RGTKEhx+M75rSbgT2QVQ6U6Gz1NBUra0e40v3a+Y3M0H6eTlc=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AS8P190MB1094.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 09:38:55 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%9]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 09:38:55 +0000
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
Date:   Wed, 08 Sep 2021 12:38:54 +0300
Message-ID: <vrcxh2zgsnl841.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::23) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan (217.20.186.93) by AM8P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 09:38:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8cb3033-fb8f-41ae-086a-08d972ac79de
X-MS-TrafficTypeDiagnostic: AS8P190MB1094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8P190MB10941FCDC28CA60CED3A4FE495D49@AS8P190MB1094.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNXfmFYch4lb9hLQEqKB1etmUbdAD6u1QXtTZAGYmfHNQ0IVq58vBdoDLeA5nVAzl88OkBpR+tprLZ0l1h5wQD+fZDaePBJ7g4s1AgYV79OoU55U6eMzD2aG6XZa0kCihHulAjQSeM9Q46vST//4wEwnEt08c9aQkhQX4OkRYHeRG12vA20DGOr7fHP+3WIzvfw1jZhAKN3bORZ7HXoewOvbPuj0kilk3FiV8Xdfx2DhC6X8qZ4gOZa5N0fJvhWwAdgfIh0YY11WvnAsp37hvhomDN7FgygczZc5vSmBcZVuYtrm6gez9r62Wa4B6MuAXREiWf/9WuIltRYH/+UHPNbduxJ0XxC8dWCHbJpMhhkQg22RZ+ZlzAAd/LGpsijeuUNmfVRbWdF/1fgisrD0oM+7YWY6J/oioXn3AmFNBlc5o0RfSd6dhbJ+ln/Dcp0tEFvoY6tekNCX1PwsWcsT4DXa4eF0FA/twodAGrrVdLzgzv7v57AAw+H3lb4t3b4T6c77i4l2e2JBbiIazoLXZCm3j6jxMaEohVfE63NyokOf0QXKPpTCI+X5gun7bmNXfHurobaQTHxl1y+5eYgWI3cOzfQf8+envD4XUNGdKqRp/b/zbK6UQQtbLZ4dULjrnJ0tJwugvnEeSuF17/KOTSnH2rwmzCNXGpTYC2xmc4nB1fFW6hoKwnxiPIQeUfOD98v7UyDXIpA2N6tM54Ies240g78NJ+m5cwIh9kstkhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(39830400003)(376002)(136003)(346002)(53546011)(6496006)(956004)(36756003)(66556008)(316002)(38350700002)(38100700002)(6916009)(44832011)(4326008)(5660300002)(54906003)(6486002)(66476007)(52116002)(66946007)(26005)(8676002)(86362001)(2616005)(186003)(8936002)(2906002)(478600001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gOZRdtF1FvumtcerwlERiuahrBbj5v5CdojuU+oOLTTv5WGaGszvkmr8ufLg?=
 =?us-ascii?Q?amlAdwt4yKPHtCkj8FBg61zV/dE5V+/OSg8QwYvL0/yfrxKPPGnoGeZpsWcy?=
 =?us-ascii?Q?JXDVvE8dLRglJBcdFzVxX9PAwz6sJWYFIR4p8eaSJNwbBswVsmMZRrvT93Nk?=
 =?us-ascii?Q?9aXbL47MidZD7fwm8fUBC3wmRhJnscfXX26YMcuF8MEfj1thrlhn7MucbyGA?=
 =?us-ascii?Q?7sUb6zcIWAfu39lY5/SHWZ3RcpL+LXtdvum/ZltRVE/pCYUjhnH2HKgDZHGu?=
 =?us-ascii?Q?qMPMNhGqBDInbhmHi3AqiqEFPDz6F3FH3iE2WMiKu1eJpymKgOPIKrMjDEpp?=
 =?us-ascii?Q?d19AR49/TCOVOpmKqTVcAUP7Ni/0SdOu5xmLDR6mnewCnrHG1fgGKWCuW9hg?=
 =?us-ascii?Q?Pgo/idALiPLXiTAji2Q4oq+TcjowlIcy8QjZGELLYxV18a4VGUSw3cgHVnvz?=
 =?us-ascii?Q?rAKjl6zpYKhl36mtDHkf/2Hg7co9V+NsoVyJpYpTVRiOI3YOSXqiyMxktjzl?=
 =?us-ascii?Q?V57kkFEcvFjaZSyUQn76zFehhnmzK8FkL4NrYrN7T4vJm4sdHwZQjjGE1X/r?=
 =?us-ascii?Q?FV9hLRIm6kYXUuDfIDrAEkyLv7Koz4UNaFYjET/aCadGH1kqe2vbDsOb+mhw?=
 =?us-ascii?Q?K1+qkmyD6xqFSlKQrdcWriMLdlqTVirtZ2oLwXvsinwreYlkS5SsLEVTsh9z?=
 =?us-ascii?Q?a4U7I90b1YbGBm3RolHBl1nKlLzUYx7bdw0YksDUqJJ0/IoZuDApCWZ4Gyaj?=
 =?us-ascii?Q?Da3E9xx1vpww/lyVg1rsuT2XSF/DYTKjLcvOUwmRFPvZNqwb3s42X6dPIdtJ?=
 =?us-ascii?Q?4Cx0luVp125JDLLap9vmTGzqw0bL6yWVPrhhHogWBi5YG5zg/wtrThM+R8AC?=
 =?us-ascii?Q?2qDFnEHVcoElCJXiQruCC7WIyH5DyJpeQf9w2K7eOV5H4DBH3krsEHu7CxDP?=
 =?us-ascii?Q?pxfYoT0EMlH+lCogCS87XToM3wnH+tWPT6+sLAtmikJPAe7dfrSnqWMLlMoV?=
 =?us-ascii?Q?VNMiegpO7tM0EDGjx3xabEahgVxAeftwxV7oBq+h2vvU6aAwyfjiWkxoD4lo?=
 =?us-ascii?Q?+JSejUOEhKe77sq/EhCOZYAfaO3Zj2cfOw5PKHXz8gckJrBkJkPmosom/0cT?=
 =?us-ascii?Q?rPjZu03jgK113B8Z2kQ3uIw20AMV5GCExqUvBDShWUW49mj8v1bkTxu5vXsf?=
 =?us-ascii?Q?zLvtw3C+0235xqIOvMLzzjfr+n9fIxHqFjF1XLrGYTPmxrqOnIf0MB/bGfKA?=
 =?us-ascii?Q?5Swz56D1Vlg9JHn9qGjdC+Lq6DLW7l8lgmfd7vRI+uKLcjKXFZhIYZHcv3VB?=
 =?us-ascii?Q?5U2yYiIFhRUUlqeTwbnyAjS2?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cb3033-fb8f-41ae-086a-08d972ac79de
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 09:38:55.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brRR9fC1n65lHwYyYrz8j7FsJ/05VHsdsQzngpjR72HN9k+yoYn3ouVIfUXOQ84Pxe6GgnCrRFiMle5EKvSJYq5LS75bW5qfTHFJhvP/03g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srini,

Sorry for such delay in replies, I am still confused how to
implement it properly, let me please explain the issues
which I faced with:

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 16/06/2021 13:33, Vadym Kochan wrote:
>>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>>> index bca671ff4e54..648373ced6d4 100644
>>>> --- a/drivers/nvmem/core.c
>>>> +++ b/drivers/nvmem/core.c
>>>> @@ -39,6 +39,7 @@ struct nvmem_device {
>>>>    	nvmem_reg_read_t	reg_read;
>>>>    	nvmem_reg_write_t	reg_write;
>>>>    	struct gpio_desc	*wp_gpio;
>>>> +	struct nvmem_parser_data *parser_data;
>>> This should be renamed to nvmem_cell_info_parser or something on those lines
>>> to avoid any misunderstanding on what exactly this parser is about.
>>>
>>> May be can totally avoid this by using parser name only during register.
>>>
>> I added this to keep parsed cells particulary for this nvmem in case
>> same parser is used for several nvmem's and mostly because of using also
>> cell lookup info. I will try to also answer your below question why do I need
>> lookups ?
>> 
>> I use of_get_mac_address() func to fetch mac-address from nvmem cell.
>> Eventually this func calls of_get_mac_addr_nvmem() which (as I understand it
>> correctly) can find cells via DT by parsing "nvmem-cell-names" or via cell lookup
>> info of platform_device. I use the 2nd option with the following sample
>> solution:
>> 
>> 	## DT ##
>> 	eeprom_at24: at24@56 {
>> 		compatible = "atmel,24c32";
>> 		nvmem-cell-parser-name = "onie-tlv-cells";
>> 		reg = <0x56>;
>> 	};
>> 
>> 	onie_tlv_parser: onie-tlv-cells {
>> 		compatible = "nvmem-cell-parser";
>> 		status = "okay";
>> 
>> ---> add ability here to map cell con_id to cell_name ?
>> 
>> 	};
>> 
>> 	some_dev_node {
>> 		compatible = "xxx";
>> 		base-mac-provider = <&onie_tlv_parser>;
>
> Real nvmem provider is eeprom_at24, why do you use onie_tlv_parse as 
> your mac provider?
> If you use eeprom_at24 then of_get_mac_address() should get mac-address 
> directly from cell info.

1) This DT node is a trick to register it as a platform_device because of:

static int of_get_mac_addr_nvmem(struct device_node *np, u8 *addr)
{
        struct platform_device *pdev = of_find_device_by_node(np);
        struct nvmem_cell *cell;
        const void *mac;
        size_t len;
        int ret;
 
        /* Try lookup by device first, there might be a nvmem_cell_lookup
         * associated with a given device.
         */
        if (pdev) {
                ret = nvmem_get_mac_address(&pdev->dev, addr);
                put_device(&pdev->dev);
                return ret;
        }
 
        cell = of_nvmem_cell_get(np, "mac-address");
        if (IS_ERR(cell))
                return PTR_ERR(cell);
 
        ...
}

I tried to use at24_eeprom as ref in DTS file, but this device is not a
platform device but a nvmem bus device, so it fails on:

        ...

        struct platform_device *pdev = of_find_device_by_node(np);

        ...

        /* Try lookup by device first, there might be a nvmem_cell_lookup
         * associated with a given device.
         */
        if (pdev) {
                ret = nvmem_get_mac_address(&pdev->dev, addr);
                put_device(&pdev->dev);
                return ret;
        }

        ...

Probably this might be fixed by lookup nvmem device too ?

2) Regarding cell lookups registration, I had to use it because
of_nvmem_cell_get() will not find parser cells via OF.

>
>
>> 		status = "okay";
>> 	};
>> 	########
>> 
>> 	== CODE ==
>> 	base_mac_np = of_parse_phandle(np, "base-mac-provider", 0);
>> 	ret = of_get_mac_address(base_mac_np, base_mac);
>> 	==========
>> 
>> 
>> And it works with this implementation because onie-tlv-cells is
>> registered as platform_device which name is the same as parser's name.
>> So the really tricky part for me is to make this cells lookup work.
>
> cell lookups are more of intended for board files, adding them in this 
> case is really not correct.  The whole purpose of this driver is to 
> parse the tlv cell infos into nvmem cell info.
>
>
> --srini
>
>
>> 
>> Of course would be great if you can point a way/idea to get rid the need of
>> lookups.
>> 

