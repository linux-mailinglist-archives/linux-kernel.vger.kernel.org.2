Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1521C4115D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhITNbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:31:15 -0400
Received: from mail-am6eur05on2118.outbound.protection.outlook.com ([40.107.22.118]:45537
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231931AbhITNbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz45y0FF9GtfLZlLVvOb5S1QkWkpCjo2qqBzOhvKVGQVqrwh3ffDLhRPxMa++94itUw3xikDmCHch4xEt/OCIRG+yexuPe+wSNU8ZQVgJTsxPV/VixbmK7QCdoCxzYrNbkZ10367Kz6JJs/ksaIyOBVo16R+nKjIhwzsZJXja6tS7FEqO4cF0B9StrxKqVM03rVKnRQ/8dXbkxy4iUhT4M3k0EKgmaBGj+Nhl9D40w7SLksjpOSH+Hs4vVLiioO9M+/LP6j8zsAu8oXX5yAjsnyUPZiV78ksUqBE6F8c8NKtEKvnt2TOnxB1xp+csUKXF0RvSABPhpgRDovTj09ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Bp4ruTuR5dgs2sa7x0Ywn2DrALtui9vztVPuzPtH0kY=;
 b=TtazDemhshLZnglYifXfKuQ7W7GKZuSkiaVpGdMK55EBPTmIsY5slyc3CXuahp+vtpc8AltXPsnvirkUAUkYoVM4tTaq5Vs2a+tIR40bdWV65k9kcLCJc/RLf59om4iUr7167eKRfOHUJPohVTu4FxD3oPZfpSzqbbAX1eLXhM0ubIz8ihLXoZp2VOkSRKWj8suFp8BrpobKZETu4Vwb38W13XpuGQ2yZp8Mgv33jDeMHlhhGRo4OXe4mSwNoUGqZZPFqUQgbQNHZD5fFxEiKSH9eokvSnmdvyHew5j0mjZ/bgIdfBqHGDlgTqJFgBQ4rOyAEkht4b4TgHqX40Hg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp4ruTuR5dgs2sa7x0Ywn2DrALtui9vztVPuzPtH0kY=;
 b=s9i2xJ1/BH5LYk83WKI7hf+ummp80UCFXTWlrsVgp61DHDDTQZQrRFGTRE8lwT+iM0loAKtr/p6YH9sUgA8hZlXCtPRDgn8t3OOtbwMDjHt5IFrxDzthQBFPc896AoM2PWD4WIhoQmR7NMLvkVZJa5jRFOwxq76uhvmRHi7WYhs=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AM5P190MB0324.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:23::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 13:29:44 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%8]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 13:29:44 +0000
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
 <vrcxh2zgsnl841.fsf@plvision.eu>
 <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
 <vrcxh2pmt3bl4h.fsf@plvision.eu>
 <0e471789-fe29-b747-5153-75c9b4616c7f@linaro.org>
 <vrcxh2o88nbias.fsf@plvision.eu>
 <1da03714-8f23-1004-e89a-891e4599e04a@linaro.org>
 <vrcxh2mto7bfcb.fsf@plvision.eu>
 <1e146349-9fef-972b-9084-577f02d5168b@linaro.org>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <1e146349-9fef-972b-9084-577f02d5168b@linaro.org>
Date:   Mon, 20 Sep 2021 16:29:43 +0300
Message-ID: <vrcxh2lf3rbcjc.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0055.eurprd06.prod.outlook.com
 (2603:10a6:206::20) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan (217.20.186.93) by AM5PR0601CA0055.eurprd06.prod.outlook.com (2603:10a6:206::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 13:29:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a60a268e-a31a-4dde-35e5-08d97c3ab556
X-MS-TrafficTypeDiagnostic: AM5P190MB0324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5P190MB032479128CB2D80D04C0900395A09@AM5P190MB0324.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08jRo/ABZUOposo3X/jW6uBHHJ2GQWafZ9W+iirPu/eQdRzsoW7a0uiCWIuQ6qdx3M5VG/zCPl0hm+Qarwf+giF7TDU6KMCEvKHIbv5J/XikXj5evzni1BSRXOhDjp3V0VKq3wnIdbvfe+I9IlyeoLfEOCmsuLgNuD4c/ytkqeMoaIVeyajRnVq0gBRgNUhLPBE6yTOQjgbO9P3ofqq1t7tejKf8cLh5+gGdRZFn+DwsAorHZxoqpkWwIkEwumaoWZ7PQKR09rl8reoPBq6wuQKZ8lPrqMaAGeS70wNsQmj5BXrZXXRtRoftozOJert1trl81JMgl6vbEYm7aY4cxouECp1AVR66VrQfj9uk40srpe/pPkBjd7gSlwrXWwTxNH6SQ9ggL+uK+/xs71Y/AtwzbIfM7/HLK/Z31BwjI6HCQzdMJjApyuaxfJI3t2xrbaRY4CRilNxIcVfczuRrj97tql6mvIdUgKSoNqeEERi8YbFTn993KHmaPswRsQHbQlpLPQqBG41tT4A2fTjP69jDe2kDvM3o1WqmzOS2pcG6FXB1vNaYhvHgv41t5DPwJIKOsg8lCQWss0dhaamPb8LdQ4OMU7bzLvzEJsLcN5ZW9/GWJ4WVKJ2+xhOjzlQl39d4IBJLOCSm/H9OeJPfLqi9FSQ4q7PIuwH0HiAlYsS4IBA5/pVxzP1EYOuaIJdNRYdrUeEs8mrqobWKUj06cBgZo8QjOSiftG7V+fpdbpbb/bk7qv0gJABHWy08I0d9KAC68epP+nIy8Mv71ScsplEoint43vdklSkfTI/hMwgox4qu8MzRA9WPusnDMmbv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(396003)(39830400003)(44832011)(8676002)(66476007)(52116002)(66946007)(53546011)(8936002)(26005)(966005)(2906002)(83380400001)(66556008)(6496006)(6916009)(54906003)(186003)(36756003)(316002)(86362001)(2616005)(956004)(6486002)(508600001)(4326008)(5660300002)(38350700002)(38100700002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6gfMh880yPuJvL/Ahf80nqpLg8XQsI6jDs1dhmIpe5CZfSc4YKTewEcvK45?=
 =?us-ascii?Q?wbfNP/aYSVabFeHVABVUGXtgDbfuuFJaoiGVOoPD2+ZVTnJtmQdDRC4hwTIU?=
 =?us-ascii?Q?5XS5vdUaqL71E6Vb6CastD1wXTrs4Df00frFL87mA85+hpwJR/HvbkiV6pCF?=
 =?us-ascii?Q?DGBPC2t6aK9Gguc7D38gXqo6PMZrmieK/AvwtdvQP3z+mMtlxWs6ALLjvnBq?=
 =?us-ascii?Q?1LZvUlDHzE3e23ZwNYeJBL4Mmy8XEOYR0cGRlzZuHelhlkgnOLWTfDl6s6sz?=
 =?us-ascii?Q?kvLX+JhcEK6tcg/1vUMafPP/Z/p4NFKhyIwla+Ra0+wfGrLbmrmGgUJJwbng?=
 =?us-ascii?Q?g6o3Nb+kVYvSCMifgAwR02ucgLTv9ZbsDsukiSh+6LTGPx31cZQp1CWAQJWu?=
 =?us-ascii?Q?9FgF50czN85EUWGZ6ki3KvV+8z6NsGuP+LoObgAtfIxvFUCEjuVKI6O3j8Ha?=
 =?us-ascii?Q?0SkBQaJtsT06QTs755rYZvm/0cKnUByp7Izk0OZDHNenBuV255JdPzvhGWzf?=
 =?us-ascii?Q?U/0AkwZbXg1CtIvzenOt7VplMlLw+rh9a2HQMCuMLchE0jqH0Y7rm831jK2g?=
 =?us-ascii?Q?5iJ0uwu3aRjokafNDIouBltkz0UdAvMiSTmSpDmVO0emqV8elB8HEEQsqIm9?=
 =?us-ascii?Q?q5WnVbzjRTzGN1O6k1YHnXVIAyYFY2V1pRiNm8lomgJ0yy/oEiQfpY7QDc87?=
 =?us-ascii?Q?ckS/M8f9XOEi1D7fJb/zTLf0FvbPAItkdbF3GeCyq9jhOjqv2iN2VQK38SBp?=
 =?us-ascii?Q?j1HLuP4L28vXmuk61jsrZBN+ZOJZWEhr/xZeo2TkPbBCkM4qNQyuNam7g0uw?=
 =?us-ascii?Q?JAZR9wVATb+Z3X7lOzRG3hS9ZZXIsZMQj1hWccPAtnN0AehUFoYnfNGzSQWF?=
 =?us-ascii?Q?idOY/QiKiB45hZCJQvECSIEP5tWnj4kOJVVHnIoc3bQBQA+f5zNuNjJrftBY?=
 =?us-ascii?Q?EySaJFgAsldY08ERmn2TvLSuIdGM/9zaxfRyh1yxeNigvWqyBnIxd6wScyqv?=
 =?us-ascii?Q?QP1L5lN0YiizxGtSK8AIeL5YrVZm28EUqLdPnZ2BgvNjL7lvwJQOk/Ccfi7y?=
 =?us-ascii?Q?gRbqQ3P1XYJksiKsf1ytZSus+51K19Re4XxBv/hHwBk0bU6ZgIapE6UEEaVB?=
 =?us-ascii?Q?67xCYEWOYpCN8KMONkJB/D75gQFAivhmkvQ/mgtG3BYKCYxkGMdTc3VFlm+M?=
 =?us-ascii?Q?paCobzTEibeBSkVZ7EIHk0OBdL9RTzxyRcT0/knRTFXYWZ+uqaEmvFrmAkS0?=
 =?us-ascii?Q?Tw/DZTII+CN6KOybiVcDaeJQ+Yg+fYXzGGmQhs4H3Nhs4rWacSSaBnCn3iJV?=
 =?us-ascii?Q?B0QeDkWUZBxKsBHl74hDJebf?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a60a268e-a31a-4dde-35e5-08d97c3ab556
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 13:29:44.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeM3ae5rZwqpsCdqA5Du/teX9SKjAzu1MLzDPFkMta8gdLRFfUUtS8pP2uAQT38Uyg2NfNntpRjk6Mo9YMzk0xg8nz7ZPVH6Dbq3aJuGG4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P190MB0324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 20/09/2021 13:29, Vadym Kochan wrote:
>> 
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>> 
>>> On 20/09/2021 12:25, Vadym Kochan wrote:
>>>>>> Or, treat cells with length "0" in a special way and allow to update
>>>>>> cell info later.you can update irrespective of the length, as long as this is done
>>>>> before register.
>>>>>
>>>>>
>>>>>>> };
>>>>>>>
>>>>>>> some_dev_node {
>>>>>>> 	compatible = "xxx";
>>>>>>> 	nvmem-cells = <&mac_address>;
>>>>>>> 	nvmem-cell-names = "mac-address";
>>>>>>> };
>>>>>>>
>>>>>>> == CODE ==
>>>>>>> ret = of_get_mac_address(dev->of_node, base_mac);
>>>>>>> ==========
>>>>>>>
>>>>>>>
>>>>>>> If you notice the mac_address node reg is 0.
>>>>>>> This node "reg" property should be updated ( using of_update_property())
>>>>>>> by nvmem-provider driver while tlv parsing and by matching the node name
>>>>>>> with tlv name.
>>>>>>>
>>>>>> I assume parser driver can just invoke add_cell_table (with may be
>>>>>> by adding 'bool update' field to the cell_info struct) and core.c will just
>>>>>> update existing cells parsed from OF.
>>>>>>
>>>>> Lets keep the core code clean for now, I would expect the provider
>>>>> driver along with parser function to do update the nodes.
>>>>>
>>>>> --srini
>>>>>
>>>> core.c sequence:
>>>>
>>>> 1) after cells parsed from OF:
>>>>
>>>> 2) lookup the parser
>>>>
>>>> 3) parser->cells_parse(ctx, table)
>>>>
>>>> 3.a) update existing cells matched by name from table
>>>>
>>>> 4) parser->cells_clean(ctx, table)
>>>> /* to free cell's_info allocated by the parser driver */
>>>>
>>>> as alternative way, I think it would be more generic to
>>>> provide nvmem-provider.h API to update the existing cell info,
>>>> however it makes sense only when cells were parsed
>>>> by the cell parser, in the other situations the
>>>> cell should be well defined.
>>>>
>>>> with this approach the parser driver will be just called
>>>> via parser->cells_parse(ctx) and will call nvmem_cell_info_update()
>>>> for each parsed cells.
>>>
>>> TBH, This is an over kill.
>>>
>>> In nvmem provider driver probe you can parse the tlv data and update the
>>> dt nodes before nvmem register.
>>>
>>> rest of the code should just work as it is.
>>>
>>> --srini
>> 
>> You mean to parse TLV in the particular nvmem provider driver (for
>> example in at24 driver) ? If so, then it will not allow to parse
>> this TLV format from the other kinds of nvmem.
>
> Why not?
>

Well, I think that nvmem driver and TLV parsing should somehow be
de-coupled from each other like block devices and FS does. BUT,
in case this TLV data will be used only on at24 devices then
may be it is OK.

> Can you also tell us which other nvmem providers are you going to test 
> this on?
>

Currently I can test only on at24 devices. From the:

https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html

"
Each ONIE system must include non-volatile storage which contains vital
product data assigned by the manufacturer. The non-volatile storage
could take the form of an EEPROM, a NOR-flash sector, a NAND-flash
sector or any other non-volatile storage medium.
"

I am not aware about other nvmem devices which are used for existing
ONIE supported boards.

> As long as you represent this parsing function as some library function, 
> I do not see any issue.
> If any exported symbol is available for this then any nvmem provider 
> could use it.
>
> --srini
>
>
>> 
>>>
>>>
>>>>
>> 

