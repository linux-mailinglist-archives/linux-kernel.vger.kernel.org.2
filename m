Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142B141B01C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbhI1NdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:33:02 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com ([40.107.6.129]:38865
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240964AbhI1Nc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCRrSUiKvxfw+oA7IZl6I9c2Hv4Hq9DCe1ZgltQ09/55NEnTYVNO/GDW9nzGR9r4o+rZQTzbRcyCzP/tb0zXqOOf7y19rvWo2EL1dQyejxhEacjDZOiU5mM51iLoLaSSZzZiBySk2wOctPTQ3hL6NE26knaSMjZazY/swx2pbdrvi63ZAAdFm2R5WsMgCnHGr/MPltYjBbMFJ+Jhxp/myHkf0mrIzesjAUsf+Z8N5o2i/wBjH+6qWjgplC00jZJlT82UJNkiw3+GJJp/+7Gdr0Yj3BuCImYA2WvK11FBQUabQqDF+LTOgY8M6ubE43FKNSarUgynqkY5vAVcfXPZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ePyqr0R6FPu4m70oo4Ij99//NPLBVVdaOAC05uJJ6bs=;
 b=lmHdxSZtMMJJ2dVRfdoD7nRtOqtQdmaNbcpkaIH4X7gXk3JuEX0X0k7A8d1JGhWAhHtsjmMyNRWMAMfZLCKm8VlN/a+qPzN7kpoJlSjnlWboTiqhpqKj1doxQxJH8Eqw3sdAOuQypLSChHHRhVGWbHIxyZ5bIRP5lYuv8ccPO1/HAjggJ7P14/oFxQmc/Dl+PW+PPBMtLwfxHKUazhM4QD6tW+f1YYyDjF7DncTpcdrq7YdEF5pRejxynMZn5ms/kvv8O7qrDVhk4xLzPpej/kTp0l9fa+AO4E5B/79vo1GTj2Y71ebKxnZDeFIM6DYm4MmTwm8QHHXgzkCrkYUCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePyqr0R6FPu4m70oo4Ij99//NPLBVVdaOAC05uJJ6bs=;
 b=mr9uslHGOpQpps38hRGw45+370uY2JEvXY2XTfQhSGaNPjw3NgZEX1sOUeWPk5Otzk+K36tWwlkjpfBaPZ3alZiIY7kCxyTtdX3z7Irl3eeZDcCu5Hrczc/MrDn0cbjcIloz7/ZYvJGOkU4d3tPP0B2Ga2qW8hz29xPt95hJb3I=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AS8P190MB1319.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 13:31:16 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 13:31:16 +0000
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
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        John Thomson <john@johnthomson.fastmail.com.au>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <56fb5c64-4142-03ef-2ea8-fc586fd239e1@linaro.org>
Date:   Tue, 28 Sep 2021 16:31:13 +0300
Message-ID: <vrcxh2tui4akta.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR08CA0065.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::36) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
Received: from pc60716vkochan (217.20.186.93) by HE1PR08CA0065.eurprd08.prod.outlook.com (2603:10a6:7:2a::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Tue, 28 Sep 2021 13:31:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aecf4df-5b84-4dd2-6324-08d982843f76
X-MS-TrafficTypeDiagnostic: AS8P190MB1319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8P190MB1319035109B8F90740D3805D95A89@AS8P190MB1319.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSEp9kbg7sHUQL+CT43jGI7WUqRQaoXcrU2ilsS4cC2TzzCPFNiTMF61+2IlRUccuuNn1xsu+J+0mp0bsCRlB7xI10QJdAzzytWLaaixVSqApOXOaMKyGTpxgej2t7UrFKAeAU2EnGT+TDSgx0NsrpL/zEi5rVOezN+Ghu+PnGGlCqiBr9TpKAxUa4al9T5bY1SpGyj5WQjJFhFeY4kCrjksrFid+56IvqDaeAfSf0ciqzyfBNZSwVLo+OsW3RHOYxuA1qUcZRDB7frqqZcgE5RLAQ7vHqiEEU5jIEsbBnZwqonuByU0eSy8kMr9u6RP2gl0v2/EbnZO+2utyFDyJopytB1DREQUps4e7W7Wmw6JBGq8S/dPgb1c67d5bvahRHR8t2gEp+KUtRDbGeUnn3635u2dbZNr97XEt4EUqKkAV8Nhz1VudfBHaYFjDMB/TeU82jtMKvjPNNoze/LtN0wamBnkXhzncSp1m+SzlEI79P3Xlh8fGhNQYlqTpgXjNFkBnqjdrrTNnBmdzcfYyXHGSH7tz9VP7uRRVTwfRbnqeVN2iX/YATaNQByOxf0GyFVyCEbuHT5bOsVjj56xaAiwiUyd0dZj5D1Rk4ZUPKxfzxywOW2t0MK2WCgnqjijLXhnIkBXUWik6qa7eNkFmS1R2MKueIRP8z7voY11gX3pIIZd2jwRTAIonsHA+4nPdPHFZWX8w8eYTkdXpQcPRFgpmRc9tcF+eK/bgSrwC1nDDRd9rsJCf0fjcdQ+Sy3xa995IOaZQ4yzaLexaC3iCrwCBuFlpwlyK4UR+YS/Auw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(39830400003)(346002)(366004)(396003)(38100700002)(38350700002)(83380400001)(86362001)(44832011)(26005)(956004)(2616005)(6486002)(966005)(54906003)(186003)(5660300002)(53546011)(6916009)(508600001)(6496006)(66556008)(66476007)(66946007)(2906002)(36756003)(52116002)(8936002)(316002)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q7I+f7RYhnhCSeliqIThxlPWI8ixq1Obzwkb0NUlqJLhvimBUbCY+MCi2P9w?=
 =?us-ascii?Q?92SsK2lOyP1Tin9NcxoXblP2QH+0B99KtRtDI0Zq3Ek9cqOueJuHgBPhE34+?=
 =?us-ascii?Q?LJW0g5fxMs8PZeuScmGz+ch5sCfS3G5+CRjrs5SGerXd/h41vANR3ECmyP2p?=
 =?us-ascii?Q?vBt+Wr3g3lBuyrrvWebrjRBhqWRasbAp+ljGA0fNxpub9Ni6njv7r5YSuSU2?=
 =?us-ascii?Q?I6c0DxwHacfnAdD9GtDFR7ccGrddRtSNc0DB5e2SmtAdv1znnA4Y9AFbKKO9?=
 =?us-ascii?Q?07A5lvLnjQpZHbB4ebF+v5HjSBvDMsRhdeYfdWTo/GwyrbpXoKp2LaXUsBx2?=
 =?us-ascii?Q?bx6Qdi+0Zr347x30E8VzDfelmS4zVTEp6qbNKujrfDRvmdDP7pXBT9zEb8G6?=
 =?us-ascii?Q?1/RHKYQw0/NW/ogAWQUUlrYNThbLepbtBDRn7Xw1nyPeNSMyLZgN7ekxTjFm?=
 =?us-ascii?Q?bc0sG28Ert4czQdX/QygIRMcs8t2Pk142rZG3KgLYFMJ5yuVbEVjFZaZo31P?=
 =?us-ascii?Q?Qho4DebJh4T5mrybUQZNIlbqF1lEs4FGtICZtg9ZYepW2Ns762wPjVoMu/Ha?=
 =?us-ascii?Q?bDnNVYxTlhAZcOoqZ368/aBgWzzUmRGe2mkOSGWPkLZ25c88WdTr7ZvZct8T?=
 =?us-ascii?Q?T3Av7dqJiRs2fGPoyr5pNCiUQCf7c0bEPOnCEkO6ijX0zrI0uvEHebHjOyZn?=
 =?us-ascii?Q?Xo6NsSYFwMxGW2GKqBuqcT0GiewWk7ES2GCuVCuvNg9HOVx6921u0atcEJPm?=
 =?us-ascii?Q?sen87rq4g6myeQ600iEKZirf+IawvgSxBT46q1QSfT+gl/MN9jAqNepDnUyc?=
 =?us-ascii?Q?tSUFFb76FTPLI1n7vN/wQjOzAIbu5oU/lRykD/oyhxA9P9/sgC8D0y8Q7G2X?=
 =?us-ascii?Q?c4QA9BxHtfZBM5YsTBOZUu+Nw2vPCnMj39sRknn8m1QmuEWgexvOzZDdwTUc?=
 =?us-ascii?Q?P1dOrRWftNnOY1AR04OlMeqN9ViWjR9BFjJPTHdlQvTmq3dyzx7YDemjLcvb?=
 =?us-ascii?Q?3v/Hn9W4weFnGbcUyeIpp5MAgYHa+IVhjsLdkP9tN/nNvIDCz/z3iZAVpds9?=
 =?us-ascii?Q?qpmjJjmwdA/WqEpSnBJRSwzDH2ZsShhhjjVbzU6RJHhUCLKLHz1C/Ac20v2b?=
 =?us-ascii?Q?7dKXmakrWkRM45nKW2FAfL+IdQXrTUI0pLSr/vjz6qMJCFvZ4uP7nZMo9i+n?=
 =?us-ascii?Q?U8VMN8azF3unv+YI7aeGB739YNT0pAszGAiD4UB61iCag/qU6FXFprRTzFzz?=
 =?us-ascii?Q?iDg5IhtXlzp8EvSgn8SPVIcsC1PgpS+rwq4zZU5QSq/mCweqod9n0PzS8wvN?=
 =?us-ascii?Q?QOXmhHs1H2C/vQHEwnM9kPwb?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aecf4df-5b84-4dd2-6324-08d982843f76
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 13:31:16.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovewR/8KqlxQlBeWBITGZIppZe5YAdfSdRphcCsO9Xm0yde142ZnOc6j+3aF1iibMAqKAuz3oYFd7S17B+f5OKK1x1c5C5TG+Rbx5pg6RQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 27/09/2021 08:50, Vadym Kochan wrote:
>>>>> Currently I can test only on at24 devices. From the:
>>>>>
>>>>> https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html
>>>>>
>>>>> "
>>>>> Each ONIE system must include non-volatile storage which contains vital
>>>>> product data assigned by the manufacturer. The non-volatile storage
>>>>> could take the form of an EEPROM, a NOR-flash sector, a NAND-flash
>>>>> sector or any other non-volatile storage medium.
>>>>> "
>>>>>
>>>>> I am not aware about other nvmem devices which are used for existing
>>>>> ONIE supported boards.
>>>>>
>>>>>> As long as you represent this parsing function as some library function,
>>>>>> I do not see any issue.
>>>>>> If any exported symbol is available for this then any nvmem provider
>>>>>> could use it.
>>>>>>
>>>>>> --srini
>>>>>>
>>> Hi Srinivas,
>>>
>>> Can I note here that I would like to parse
>>> TLV data from an SPI-NOR device to NVMEM cells.
>>> The same general use case (getting mac-address from OEM data).
>>>
>>> Was planning to base my work on this series, as well as
>>> https://lore.kernel.org/all/20210908100257.17833-1-qiangqing.zhang@nxp.com/
>>> (thanks for pointing that out Srinivas)
>>>
>>> Cheers,
>> What about at least to have just one call in core.c to make it a bit
>> de-coupled, like:
>
> Why do you want to decouple this? the provider driver should be very 
> well aware of the format the data layout.
>

In my understanding nvmem device should not aware about the data layout
(in case it does not rely on device's specific characteristics). Same
cells layout (TLV, etc) might exist on other nvmem devices.

> Its fine to an extent to adding parse_cells() callback in nvmem_config.
>

OK, in that case it will require small change in the core.

>> 
>> core.c
>> 
>> struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>> {
>> ...
>>           rval = nvmem_add_cells_from_table(nvmem);
>>           if (rval)
>>                   goto err_remove_cells;
>> 
>> +        rval = nvmem_parse_cells(nvmem, of);
>> +        if (rval) {
>> +        /* err handling */
>> +        }
>> +
>>           rval = nvmem_add_cells_from_of(nvmem);
>>           if (rval)
>>                   goto err_remove_cells;
>> 
>>           blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>> 
>>           return nvmem;
>> 
>> ...
>> 
>> }
>> 
>
>> somewhere in nvmem-parser.c:
>
> However this is totally over kill.
>
>> 
>> /* retreive parser name from of_node and call appropriate function to parse
>>     non-fixed cells and update via of_update */
>
> This is completely provider drivers job, nothing nvmem core should worry 
> about.
>
> If you have concern of having code duplicated then we could make some of 
> the common functions as library functions, But it still is within the 
> scope of provider drivers.
>

Do I understand correctly that this parser function should be exported
from at24.c (in case of ONIE) and not from a separate C module ? Or
it just means that if there will be more users of this parsing function
then it might be moved to separate C module ?

> --srini
>

BTW, what if such change will be declined by particular nvmem driver
maintainer ?

>> int nvmem_parse_cells(struct nvmem_device *nvmem, struct device_node *of_node)
>> {
>>      ...
>> }
>> 
>> ?
>
>
>> 
>> Regards,

