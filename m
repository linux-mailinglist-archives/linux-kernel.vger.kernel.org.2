Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3741B1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhI1ONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:13:08 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:49635
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240962AbhI1ONH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:13:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxRVWhAYXyxEwdbl1qYlmwTKLzZnPs4K8RWfdZT8GwQd97LjxkYyy9B6ajM1jn333TGa/LjiP9Bkjz3RWkN+WzXHekSeIACDkDFeTtEtoYShoFqYj0MYLPhvv/whBeO81/i4y92HO7kY5TPEptGbzxBzl6jMm/Ip3wzv1PLp/KR8zZFqwUQ520FTHXtGRLs4zv8h+V51Qair2T+HcT6MbpgOgj0UEM2Tg1a/dnEf5gb3gxY0RLIemmcxlx1XYYoZtDJo/C0x/oyotErVueSL//S0KRCRH5VHmCcLAQp5SeYLzD4sr7cHVP91MsS8AggdL64Vaddr6XziRkyh58J28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nUlTxQaU6DK+Gwd3Bbvphk+C/ZYxUsrq7op+yIi0h8U=;
 b=UcfSBcqdNVzWVZ5s0yn4495QUVvbN4qbgWjQ9HhUsPtk9y75E6o5pqsKNP+DbcccXHvpr6tF5P5fjVGEhJjMWNJMOYKNBwHj/Fhxo39CVblQcHQkMlQ7ASYBdZmHmY4QCevoQOQ0HODElHBVZtLs/RkdQU8mn60mk7cf6uKT7TD5VtbjQ5C+1VFO3S0kwxRr4fHOs57UlJL8x5SSsA8dCTH4mrELaJ43GQPohde8Yg80NzkucpLAdVVBQ2ULJwMWKAljDZO2ctah8xeO90roKAuyQYhuAM0hh+J1vLnvz8APVwxxQxkaJpdDQf52D/dfz2bjn/9uzbikrRWJjz7f3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUlTxQaU6DK+Gwd3Bbvphk+C/ZYxUsrq7op+yIi0h8U=;
 b=nipSeEI01JccaPWaQUZJUE2Ts+Bekynper4v5TQAPvsl2kBQ1K3E53sHx5pf59tE8s0OHMaDU36M8iovBD5qMVrQCq1MmMf5xR8Gk4WMgG5wTtVG5shMn/HPkj0BYnAjVI4jKd9Evd53hOAAkUC31zak73+GhNXdmulgCMoak20=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AS8P190MB1079.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 28 Sep
 2021 14:11:25 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 14:11:25 +0000
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
 <vrcxh2lf3rbcjc.fsf@plvision.eu>
 <169d3f36-4297-32a3-3d23-824989625b26@linaro.org>
 <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
 <vrcxh2y27ia23n.fsf@plvision.eu>
 <56fb5c64-4142-03ef-2ea8-fc586fd239e1@linaro.org>
 <vrcxh2tui4akta.fsf@plvision.eu>
 <cbff6b53-d751-0a44-c3de-d31c26ed3d5c@linaro.org>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        John Thomson <john@johnthomson.fastmail.com.au>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <cbff6b53-d751-0a44-c3de-d31c26ed3d5c@linaro.org>
Date:   Tue, 28 Sep 2021 17:11:23 +0300
Message-ID: <vrcxh2sfxoaiyc.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0081.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::22) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
Received: from pc60716vkochan (217.20.186.93) by AM6PR10CA0081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 14:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61593e97-4533-41bc-3719-08d98289db47
X-MS-TrafficTypeDiagnostic: AS8P190MB1079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8P190MB107963BA4EC16BD14FE71BED95A89@AS8P190MB1079.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ho7E7/f27aFEoXg0aEFn+wutloLme1z3AfkhLHZyagDylzKurxsKuscASo4Xq8VCAdsXVhghJi8LfyIo1DrbiotKKTHEOAe0Fb/JjY9VyhaesKV5BZcrv4WQptyzaHGOxWnWuZE0gcI7QGAKZpRbVvrNWu+q4jjrAQOPVnV+7IKELX1Bld1mJnj6t2Vl2EyBWFjTRotxRGqYsVVDfuvdGucotgR1t8sV7ICJ5HD6JVL5GhEdK2Pa+l0xO5g2uYMVRFWrcHk2k+iaakhq7X4BVifB0V1mD5t9DjDZWbPJFEIeTHGDRDOZiNSIJs6U4DA1tPLoM1ZJ5aw130RoGlxlQGWqlnq4mT60kqRkFLsuX+ZPreUPvDxHZiZ7MxrAnOjADqNlQXuJiWlrudWdwT6qxd9d1O1uBMB3ixFjuffVBQWcyKvjtrf3uZkkzE1i4maScEiHPtB/r24jdJlIbon5WjqLqXlTQtWSIb/LTI4EwEwjZ9GJL8NPil5Tp8yXdrloEsh9KN7MKhB0VPsTliD07dylBZuL4LQkutFpiI6/NcRqG9DqZngBfxhQYNVkYOjf/IeZqftXFvdFcQEZgbNgOqhxWggb7mRa9kwHpAjxq0lBYhrocTXv66A68J7/037zO2e7+bo5C7wvMxSkGvNDMNqUAv8ZoLG/9IENkdkS2wQPmtNTwt4sTVO7Z09kPNIG3bWxkfm+rXSJbSTVB3AxQxHkszsgcupw8fDHKt5EtjLazMAovDJFuyvDPxt9xEH2hdPKagldpHH73NyzsJov9w+GTT6MO91EHno6/3ydh2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(376002)(366004)(346002)(396003)(136003)(186003)(5660300002)(8676002)(26005)(36756003)(6916009)(316002)(54906003)(2906002)(52116002)(8936002)(38350700002)(86362001)(38100700002)(53546011)(508600001)(6496006)(83380400001)(966005)(66946007)(44832011)(66476007)(66556008)(2616005)(956004)(4326008)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lOJyEUB6vBjGBlaQFaSbdLrOOkcEr+9XpuwphqI0rKKFJkUi/NNl+KTwjWfs?=
 =?us-ascii?Q?5TDEtLEN0fk3HU75o8SkWXp2N4sOa/WHIfgG/HNvthA3IGEt2qoskTWFf5kI?=
 =?us-ascii?Q?mMJoow+94QBjc4zAnsCSt+QpxdS5o5OedkZoceT3fCRF0eLhigJ433OlNvov?=
 =?us-ascii?Q?aeXMoaCZUKW0xnMaB9IXWR2DgDD0If63S3cdmLRAQtnAb1a1ugnq/419nLYs?=
 =?us-ascii?Q?BvcYhN37Vj1dGngdrycLn3LBHhYV+k9K2UVsVAav+WAqYuIbdsn2MyWlrV3L?=
 =?us-ascii?Q?SnaRXB4OUpKcqG5/R3OCMh61gEwIMuBmJ5KUyhFf9K5fc9RQ16jYh+8OJrNe?=
 =?us-ascii?Q?gMx01lZdrtpz4LhY2tgKlIrWTgIXOzYA9lQ0DmDfKM3f6qxxq2bOLx9mOB6f?=
 =?us-ascii?Q?WoerfXKVyGpfn6Jsu3q+tPU5ZgXMIWEVoqZ2yjtbRYFWNqBanzz2JeRsWpuZ?=
 =?us-ascii?Q?kcZvXn25R/kWwKbTiI88XlWtH0q/Ph9OnEzloA+79i8wgsXrUT+DO5EYOAxG?=
 =?us-ascii?Q?E06foSMzNTYN0PmLe2I8J1LJosr595h7Td7m3kXywQf/s2nABFLCBBFPZe8h?=
 =?us-ascii?Q?e6QuyGydRD2Z2mCB+xWBTo6rbXCm8nHi7KGR3Y88uBAhhwHYGqfjr++q6mGO?=
 =?us-ascii?Q?DtMtA2yw7X/lnANQoST/sSFT7f7BECMkxc600oMFRCr8ZB3PAR8nc9DORhyG?=
 =?us-ascii?Q?2LffPo8QTS2JyOrLBjRLuQjfnHytYOYcCUcoJr2eCaUOZglER3cT1ilUY1xc?=
 =?us-ascii?Q?cnmrRjUHFCRUK5+cLT893lBOMHNbIyOYpjA79DyplBMsmGA0r4Hx5rjSlSM9?=
 =?us-ascii?Q?e7qnfc8cf8F+PiirGDPkOYyjDZiX/qe4YUdIkXBfnkB8k7EXILdkBu0aWwPL?=
 =?us-ascii?Q?E4SGtq7LQDQUotUNTpk6EI//4SbZjqahZotr+neMtRe37YVLeNOxYHY0NpHe?=
 =?us-ascii?Q?sR77jJr0EEcQZJ7/HyzlfDaJM61C9fNtkDNU/veiNtpB7pUri+5r64gtzb/M?=
 =?us-ascii?Q?v8lhy8V/1sd5GR7sBZQHZ02ZnN6ZXRyHOu6L+n52r5D9z+WWBxx5p7a2Vaxd?=
 =?us-ascii?Q?bu8M4THpnvFNahn/eUwIVcACsyCqIW0Z0k8vvjWpGxGRkgquW2PfH0N6062x?=
 =?us-ascii?Q?sQZDxzWgCahUSVKJosyrysNkzVZvU1bOhPr9vXUuOzhFUBcFb6WiMuenyeKu?=
 =?us-ascii?Q?2146SLPKx3BcN06Ejx15yl/NkjHxMazRMUrQIU+Gri1W3Hsk0A3gIwSxLPAW?=
 =?us-ascii?Q?URwFKVpgW7/If0leIenwpLbd4/emG+KelT95y0aQ9ilp5i4hpDrxUhtVd8/t?=
 =?us-ascii?Q?U8VPXXpah0NDWIIxRDdkcmgV?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 61593e97-4533-41bc-3719-08d98289db47
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 14:11:25.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKeYVq4fcGudCKQ6eSy9sIrHQ9+GueM5U7mB3fewAwy/bsmEURi+XHoAyEU/0e4lx2kUSQk4dnFCqJYG7Ziw+cz3kOMUEOq7YkMAUj3cmw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 28/09/2021 14:31, Vadym Kochan wrote:
>>>>> Can I note here that I would like to parse
>>>>> TLV data from an SPI-NOR device to NVMEM cells.
>>>>> The same general use case (getting mac-address from OEM data).
>>>>>
>>>>> Was planning to base my work on this series, as well as
>>>>> https://lore.kernel.org/all/20210908100257.17833-1-qiangqing.zhang@nxp.com/
>>>>> (thanks for pointing that out Srinivas)
>>>>>
>>>>> Cheers,
>>>> What about at least to have just one call in core.c to make it a bit
>>>> de-coupled, like:
>>> Why do you want to decouple this? the provider driver should be very
>>> well aware of the format the data layout.
>>>
>> In my understanding nvmem device should not aware about the data layout
>> (in case it does not rely on device's specific characteristics). Same
>> cells layout (TLV, etc) might exist on other nvmem devices.
>> 
> How would provider driver parse this without even knowing data layout?
>
>
>>> Its fine to an extent to adding parse_cells() callback in nvmem_config.
>>>
>> OK, in that case it will require small change in the core.
>> 
>>>> core.c
>>>>
>>>> struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>>> {
>>>> ...
>>>>            rval = nvmem_add_cells_from_table(nvmem);
>>>>            if (rval)
>>>>                    goto err_remove_cells;
>>>>
>>>> +        rval = nvmem_parse_cells(nvmem, of);
>>>> +        if (rval) {
>>>> +        /* err handling */
>>>> +        }
>>>> +
>>>>            rval = nvmem_add_cells_from_of(nvmem);
>>>>            if (rval)
>>>>                    goto err_remove_cells;
>>>>
>>>>            blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>>>>
>>>>            return nvmem;
>>>>
>>>> ...
>>>>
>>>> }
>>>>
>>>> somewhere in nvmem-parser.c:
>>> However this is totally over kill.
>>>
>>>> /* retreive parser name from of_node and call appropriate function to parse
>>>>      non-fixed cells and update via of_update */
>>> This is completely provider drivers job, nothing nvmem core should worry
>>> about.
>>>
>>> If you have concern of having code duplicated then we could make some of
>>> the common functions as library functions, But it still is within the
>>> scope of provider drivers.
>>>
>> Do I understand correctly that this parser function should be exported
>> from at24.c (in case of ONIE) and not from a separate C module ? Or
>> it just means that if there will be more users of this parsing function
>> then it might be moved to separate C module ?
> yes.
> For now am not really sure how many users are for such parsing function.
>
>> 
>>> --srini
>>>
>> BTW, what if such change will be declined by particular nvmem driver
>> maintainer ?
>
> You would need some changes to provider driver to be able to flag that 
> there is some kind of parsing required anyway.
>

It might be some new property in device-tree which can be used also
for the other providers.

> --srini
>> 

