Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB69A36F52C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhD3Ewo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:52:44 -0400
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:24448
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhD3Ewm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:52:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfEM1Eh4A4/PRMLYJMqr/7uSKezwn/7KpvUd3XXFmbMnZIkDEOQSyRh8HPN0wqc5T//SDKlGvjTFflEjXWyzpVhCKf7wPekk4rwAri9JfPLjbp9PjkgRarOYF+/BStcJ2zDBs75dJaZVghYknQa8/z7sg1oinCJ/tjBxV5m493b1hWM0XhMJuJpbjLLs9wS3nkYjHQIOZL5C881NlQDQEbL71DuIM9iiO6IDz3d5g8SCyZtUOGPv+0NC20ul0da2NRfp78WMuZfOFao+rWak+30JyXcSkHszlgmNmz+0h3rA6w8NhJu6yeTHQnL6GgSxyF9vBI7pn0nTDJU0rgxM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlTmPf7sKpA3y1pBX5dgHdmbEVqArx57ptyTedJERLM=;
 b=Dq35HE9GLWvfLOfFFBVkLdZkbBaLiXUCCvGO/QvsMpIgS9eLCkD3t4iukiK9Ycl35eRdcuIniyiCNpTGEZ37H51xJQiO6wf6oyzTzmzSiOZsH9vQ1gNYbdx8tD9k+VTZK9hBEOVPu5na4Eu2+p/J3k/inbVAxvnzoyOS0fzGQxvjgMrp7JDdOYvzAXFlC/1fEoEcYCOmyo0kQoj06ElViyefhmjEsQiHvrVQE0EG3PbxE5VcvEYD0mqGlJ88lxZYxDj/xvltYMLXL4kEsucxnpE5sXz5lmwRneQVpB29x0v0dA7JzNPFOi4+IVs2iCwKZYm9q+WcloJeTtRDeiOyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlTmPf7sKpA3y1pBX5dgHdmbEVqArx57ptyTedJERLM=;
 b=SA1qENUCky7PxYPXkNzv7V37qrfqWPH9yGDrYIeadM062iyebL3FYnLdwb1FiPuHkVJbgeDFIJsv8WGotsc+/PpVFkqmfhbFimd0eLsKMqwUs2FajUVPkCaym9f7QbwTe1gnXRdMX2ER9hJsGZex924Wdl/YIw7O7ziR/xxt6bg=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:51:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:51:52 +0000
Subject: Re: [PATCH 15/16] soc: imx: gpcv2: support reset defer probe
To:     Lucas Stach <l.stach@pengutronix.de>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-16-peng.fan@oss.nxp.com>
 <34b4d1f0a278de7d730f88fd6480acfe5dfae276.camel@pengutronix.de>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <ea6bcab5-e31f-87a4-0de1-05c53c53df3a@oss.nxp.com>
Date:   Fri, 30 Apr 2021 12:51:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <34b4d1f0a278de7d730f88fd6480acfe5dfae276.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.190] (119.31.174.71) by HK2PR02CA0185.apcprd02.prod.outlook.com (2603:1096:201:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 04:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a99fc55-ab4d-4651-5b4b-08d90b93ac1c
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916F0EFBC64F4F93B229812C95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHccGokuNwEnCs8mpri5FJlOPoUew5sHnEDN9q2Yo8vBt+QeTZZm1e+uNRvdCRbFzu9tpLY5SVEBg6+JIxcW8+eHmTX5E/PwlUfbfP0MI+ivvuLGlkyBKXxL0xA+hz/nyuNtid7hm2K7bj4HbZGBnbQ85yDroESGm6kcqWHTqnbGSqr5yunUYd/tD1PJkX/lXS724YK1/Y4alX70F7ku2dBsgIFkHLH0XGej0no7ye/Fn/BYCBAYwGht/MMAi+3ooQYiYCsy3U1YdI2ontvd5SUEByRJUNQm1RAYO/k6oPVTbPb8qr2yVApIiTxWdzSXk7n13xufHUALsvsokZB2V1UwI3jy5TQCyXgmZ7wG9IJdxPQB5X2uFe6kD/JV5fRag8ArOwpK06GbAOwTlRcWe2jUx2hiFm8Y3nVnE8o4PeozArUpB7dX6uUXXZXLnfQBly4c/sYszYEjy8ZMogmfSjc38jsOT351U+/HIxfhl2ZbbIW3qnVziuLM2OiFAV/z02M+uKQ2HB2tvYik/ZZybCbsre/aABkF05E+JdHA9aA7tWk+dKrpFpwNp0mc8+68IkfgWru0JnAWNUuGY/CnBVWcvdvHvxXe3hKBlomRL1So6/RlLonFJcH5uRtsGvxZzszUcZxVfi7QMbPuFsy2+JzwkcCgCTEfAESDZVUlgKB/+JYHvvyBC0z/tBoCPr/gRLFUxb8+HU4s2Tr5OqagU6WbWO96SI/GRl9Q8pJMNNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(31696002)(31686004)(2616005)(956004)(186003)(6486002)(6666004)(16526019)(86362001)(478600001)(16576012)(52116002)(26005)(2906002)(38100700002)(38350700002)(8676002)(53546011)(7416002)(66556008)(66946007)(66476007)(83380400001)(8936002)(316002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OURIOU0vMGtrTGhTOVpyMzQ2c1RxYzZuaFhpRWQvcHRJMUpkZTFlaDhqU3Jw?=
 =?utf-8?B?OWJINDVvbGhWRDVUc1Q2SjJvdnpiRktJSnVMM0pEckZBZHg2WVlsMGZ5RTFI?=
 =?utf-8?B?TmtDVEc0NWtwaHdmbVBLMWVNcHVwdnBCU3dpRGlDT1ZDK1dFQitvYWwwR2dQ?=
 =?utf-8?B?cnlhOTQ1L0l4dFdwdGQxQjdLMFV5RWFKZ0h1c2xJYm01WExIZldheTF5Vmdo?=
 =?utf-8?B?QWNvZmdNS0EySDRrbFpPSWoxcUh5YmFvWUEwTTBnNE9RSExSbTErVzZBWS8r?=
 =?utf-8?B?RElYTzJUdUZjRW9sQjU1aDFkblQxSlhTNnBXRmh3Q2pIbGtvRitsNDBPaUFm?=
 =?utf-8?B?cDY2YmVkQTlybFlGR0Qwb0d1NFBiNFo3aW5sTmZUTmh6d2hlRFhLcHlhRnJj?=
 =?utf-8?B?WlROVXNEWFZJQ09NU3l3VmNuQkhLTzJ6QkllcTJBUzcvNlUrT1IrZHVxbWtj?=
 =?utf-8?B?WDhaQ2ZUMWhLTFdnanJyZW1qazVid2ZlVUFHNWRIR2Q2NFJ1cDVTVFVPOFFL?=
 =?utf-8?B?QkhRUjdaZURmN3k3eGRZakFlVnlLaFRoYTdURXZRVjMvRitDQ1V3L2VUdGVy?=
 =?utf-8?B?RXNmeXpXaUFiTmR1dll4VU1ZeFV1bk5iUGQyM05vUkd4Y2FEa21rYVJtbElE?=
 =?utf-8?B?SmV3SHB4ZGpFY1EvMGRLVVJORCtBVHhXYWpDWHExVURRc2U3aTRyZWR4WFhD?=
 =?utf-8?B?dUMrMDA3SVhIbXRrY09NV1puOEs5U1BKb0tNc3lGVGhQQ240WUY0SEwzWHda?=
 =?utf-8?B?T0FjYWN5OWdTTGRNVURnbGpaU2x4enlndUh1dU04RnBVNHNaeWY3cm9mcFND?=
 =?utf-8?B?VjJJWjJTbW1EZzhKZmtOd0xZbFk3b01sN2t0dnMxcjNuWlk5NHM4N2swZlpn?=
 =?utf-8?B?Z21SRWl1bFh4bWtRZVpha0VBSGNkSlZxellpMEVWL0ZnVnJyaVk4cnFtekxm?=
 =?utf-8?B?WEZEQ3hYNllTM283ZU1RYVhjTTdDOUdzbTJ6Z1pUVFc4aitrTEt0NzNTeWJl?=
 =?utf-8?B?aHNIR3NtNzhrV05zbWxDUXlhT1dVczlPZTJHT3ZoV0V1cUQzSk9SamVtWFhx?=
 =?utf-8?B?UHYyRUxzK2ZMSjBkcDd2WkNFcUR1TlFiVHlWUlBlVkYwSndWc09EcDFxVXRh?=
 =?utf-8?B?KzNOaG5zU29Qb1JlZENBYWdGRlBQeEhCaG0ycHZDaHZqdHF4YTUwbHNtNjRR?=
 =?utf-8?B?VURSUzcrUzJHNFBQOUNHdjhCZkpGTlRDdm5UaEFaVWpIc1VQQ2dQZmdsaUNj?=
 =?utf-8?B?SWhOeWVHdDl3SkNaeFZYYzdkeit1MFZiaTRvMVdvdEhjTHJUR3dkYjc1OGdG?=
 =?utf-8?B?b0t2ZnFsMTdnUHp6V0JNU1ROUVJrOFJlNWlmVlB1cnJuenkxbU41N3gyeWhJ?=
 =?utf-8?B?TjREYXVJRitEVU1GZXQweGNBQ1UyTUQxR2pZSUkvZkRaTDhpOFdwYk1PL3VD?=
 =?utf-8?B?UEFnRzNPRlZSQ1pUcWtCZlVvRExieEo0RTBrZzAvbHRXdjRRV2pDaUJQVkMx?=
 =?utf-8?B?SGkxemZsRmF0elBkbTNsVCt1N2lFeDYxQ3I0b28zT0d0akp2NWx0cTZ6OHI2?=
 =?utf-8?B?TEZjemU2Q09aNEN2NDNXOUUxMzdTTWlYb2R1aFhFT2U1VndXNjJ5T0daUUJM?=
 =?utf-8?B?d0lTcmJlT3hOYXpFZHZ3UmdteUpkYldzTU1TT3FqV1RPSEp4WjR0UlhJMEZT?=
 =?utf-8?B?ZzYvcTNERDhHRTZtZnlTRTExUEdLajVzQUlOZFF5OGUxRGhyVFQyalNsN1Bk?=
 =?utf-8?B?c2ZuNitpVThTM2c5Q3RmOXdIUklkSENjN0RkMkVLZHNMekF3UVVENWJKU2pw?=
 =?utf-8?B?YjkwWlk4UDZtQjdFNWF4QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a99fc55-ab4d-4651-5b4b-08d90b93ac1c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:51:52.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy23ggMQ7/Dba75CkOgntwoOLXqzM0Tu8j5KSK8Eqm6/U9LeC9amMXVQmLmIymEXHr7Sjp2DjqHGDCdfVU4GZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/29 22:30, Lucas Stach wrote:
> Am Donnerstag, dem 29.04.2021 um 15:30 +0800 schrieb Peng Fan (OSS):
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> When gpcv2 probe, the reset controller might not be ready, so we need
>> defer probe
> 
> I agree with Ahmad. dev_err_probe properly propagates the PROBE_DEFER
> return, so this patch should be dropped.

Sure. Drop in V2.

Thanks,
Peng.

> 
> Regards,
> Lucas
> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/gpcv2.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
>> index 072f519462a5..49dd137f6b94 100644
>> --- a/drivers/soc/imx/gpcv2.c
>> +++ b/drivers/soc/imx/gpcv2.c
>> @@ -784,9 +784,12 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>>   				     "Failed to get domain's clocks\n");
>>   
>>
>>
>>
>>   	domain->reset = devm_reset_control_array_get_optional_exclusive(domain->dev);
>> -	if (IS_ERR(domain->reset))
>> +	if (IS_ERR(domain->reset)) {
>> +		if (PTR_ERR(domain->reset) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>>   		return dev_err_probe(domain->dev, PTR_ERR(domain->reset),
>>   				     "Failed to get domain's resets\n");
>> +	}
>>   
>>
>>
>>
>>   	pm_runtime_enable(domain->dev);
>>   
>>
>>
>>
> 
> 
