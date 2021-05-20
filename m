Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2038B9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 00:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhETWtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 18:49:04 -0400
Received: from mail-mw2nam08on2055.outbound.protection.outlook.com ([40.107.101.55]:1689
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231871AbhETWtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 18:49:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgTcxqMPIEYVZkp0+vrmGuDgrIsvlvmyZsftuzaGRI95Rv7Dy/dvFWcXACTgq7SzWj9nCsstvuoQNoGNCnakB/RFBe2MDaU9wsP6Ab2MBxHw/SQw0LdBL3i32pML0x9TMms09GJ+K/tvRg0pYJS4AY2L7VB9YJagU/wlBB2uJDRmPaQlI3UnQLUgy1gjCgnfmBbg8pBtrdY0vbt05cFfQ8kO4Kd/XUMuHwJHaBQEYeIRDbnyRn2ity3Kwgew5v166SDArKhhSaSD2J5G9qmHwq4cXl4yYLbJw4pDVceMi2iX8VLZaWCU4aHOCmGahPkjX9nC2FX5lkKSGu4UZDs/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucIaFFJwh5azBQTxfuB9kJsGY43NsGq16q65zwNCHvE=;
 b=KIHlHOPYYpWbxWZ9k68ttTj0rPgwisJ3t56GqWFRJQ5SYsxOkDabhfqZat2PTy7pG7b0rajnG6AZ1TAerAkKh5y6x1b2EI+2/69rNmOjccFTbhiNYbSHsh4dup1f/td+VYcodzx0JrWG47uEQVmiR2Nck2+7Y0cEYoK4qVrjwbe8MelpkmorD+pwfI8xtiuQeNCUceLwK1Seu6yMAONY8iYdA/69NfaabIX8l3NP7UV53qX4DEX3cBXARTM8/LBD94U5JpcEX7OlpvzzrxLzfam13iayCCjpd/kBcVL1xNaDZYPloEKR3v3MsmcX7uzp+6vMxpgSG2r+sveYiLEeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucIaFFJwh5azBQTxfuB9kJsGY43NsGq16q65zwNCHvE=;
 b=VtKqlvKgzvJ+82x2KcICGxCdEWJGYLMk9w+gCHbcGIhZAuZoLffi+iYHMyCF60veSKDgBuDw8JKNWWZP3nlVl8zEBSn3XCca/2Hc3fSweEpi86UREM6rELri0uY8YtmbxcZNsJONnWKr7tpYsZ4Y1r5IJYTOmO8o7CL5EeCfWcA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 22:47:39 +0000
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::2833:2120:ed9f:c3e4]) by DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::2833:2120:ed9f:c3e4%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 22:47:39 +0000
Subject: Re: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
To:     Borislav Petkov <bp@alien8.de>
Cc:     David Bartley <andareed@gmail.com>, linux-kernel@vger.kernel.org,
        linux-x86_64@vger.kernel.org
References: <20210520174130.94954-1-andareed@gmail.com>
 <b6be3a80-df49-70ec-a3dc-e621b1e1a8c2@amd.com> <YKbmmNKiwDQ7wRl7@zn.tnic>
From:   Wei Huang <wei.huang2@amd.com>
Message-ID: <83432971-9969-5ffc-a2a9-1f4197592ff4@amd.com>
Date:   Thu, 20 May 2021 17:47:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <YKbmmNKiwDQ7wRl7@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0801CA0023.namprd08.prod.outlook.com
 (2603:10b6:803:29::33) To DM5PR1201MB0201.namprd12.prod.outlook.com
 (2603:10b6:4:5b::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.87] (165.204.77.11) by SN4PR0801CA0023.namprd08.prod.outlook.com (2603:10b6:803:29::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 22:47:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95cb6e56-1547-435d-8cbe-08d91be14517
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-Microsoft-Antispam-PRVS: <DM6PR12MB401175615FE1072E1CF93991CF2A9@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOFuaK2tddpwTJkSt2bx7yaISw9SqYjJzYjh15BF0B9eQCC7Wc0lv2rXnEhf0SYg7saY9Z6RhHLQpShcgOxaJVa9ib2TsOHxWLg9RIXOni5KdUw2Le+2DoPUE6FQtrup2ttsWPBv8SAdjpx/pBMFZhHsaAebmcpu83/rysPyz9o0kz7c6dZJF3dlrmor8DXIBl/sErSxBqe6gKB3Z/8ODvMP6IUNTvSc/XXD41JitFUp4XQc4Sj1K7ja8kbmebnXtkjtlrOpz/KIaI2TkuNrI2MhnX4iLew/o651UN4ROfHlb6JmeEP/6PpsDv6ljIzd/YMS5ziyA3Cik9HYVullV9HNWMNm3xlcwkYceP/Z/sQSYA+VE0HDlNNyPPAA3o7u6RB6gS6Samq/9TQfx5XLyR6tZkBJOZ1a0JfBnfzbxXTk+fnHn08BdOPzp/y7V1Xs6XdV0rNpUMWfcu4Z+ho8nSW7JDHLr9dBumepaUSHRjZ3PtUkQZ+fVJq/zAr73w7uCnbwlqJS7Ymr7MlM3sgo28ooJnykIstKBEp3JoCQPCo7rbffea+IJ6Kli/iMdDtghU5ez4r1WrIGcgUULgMGzny+xxDOKNtachKitmTumUfIT4PnPSOUb7ZqPoB09jk8UYCnFqT2blXY9XI4/UzEZpdPrSQl5YvWAJHZPyu8XKZSKbc06uyq99cWLPfQ7rRiGF0nWW5oVomtp7WooLj0d8xhMxy2Cez4sdnVgzk+umc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(26005)(4326008)(16526019)(186003)(8936002)(8676002)(86362001)(31696002)(6916009)(2906002)(6486002)(36756003)(66476007)(66556008)(66946007)(5660300002)(38100700002)(38350700002)(316002)(478600001)(16576012)(4744005)(53546011)(31686004)(956004)(2616005)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YXVZYzhhTFZlQktBbkQvaHpFbzNoRU5mVG45ZTVVdytFVlROTHFYQy9pcmFS?=
 =?utf-8?B?elZWTWlLbTViemIvL3BwVllTMVEvVUc0dndOQzhmS3IvcTJiaC8yazNJMW00?=
 =?utf-8?B?bWpWU0h3enkydUFFZVFDNFNVYXBaRDExOSs0cEEyM2FGREg4c2RlelJTbzVY?=
 =?utf-8?B?VWpGT21QTnMxZEJiaGUvTno2RndleFFESmlEZlphdlJ3MUQzMG1yOGVNRTBN?=
 =?utf-8?B?TmlFcWlqZmZMUzZLMjRWV2lXLzR1VGd3Zk1YeHRJd2VncjBpVzNaUVBMdW5Y?=
 =?utf-8?B?YlJpMjdaSHUrYzluRVVOSm5WV04zVEgxTXNRVHRZcXRjN3ZhYmppaVBlc0VF?=
 =?utf-8?B?NnFjUnZua25nRGt3TkRnMFIyUHowbVY5aUhTd3VOaStpVjBYU01PUlZJRndF?=
 =?utf-8?B?ak9JUWVWOG10d0FZb0ZJbmZ0c29WK3lzOWt2bzh2eG16NHVtK0dIc2l3djNq?=
 =?utf-8?B?Z0Q0NFRwRHM1NFg3dDh2eFVCOWwvMThIT1VMbGZ1VVZsUGNQdmZBREJMWnND?=
 =?utf-8?B?OXoreHBLOU5wVFhEYTFhREV3RFdYRWR3Vmt6bGp4NFkxcCtmM1luUmg1eEV5?=
 =?utf-8?B?U0xMb3RmUHp5c3FKU2NiQ09YRWdHbjVrdkNsQTZDZ2xtd1BTOHZ3UTBJSXQy?=
 =?utf-8?B?ZkZBeDRCdWVvRmE1Z1ZHYm1hQ1VwWndoN3dRUi9hblJsaWpIeXE1dnAvUEI3?=
 =?utf-8?B?Zkp2aXdxeDZKcE9BV0tkMTN2bEpEcGMwV3M3QUZNSERDT2kybHprRGRkaXFn?=
 =?utf-8?B?Sm85V0tLWCtIU2c0VWpGd2xyZ2pJaFlHejl4U3drMVB4Z2NFNm5UeGovbVYx?=
 =?utf-8?B?NmpKcGpEMHdMalRlTzd3MnlKUXJ4Yk1CMitBMjZWNVJobm14NkFSclFLKzNz?=
 =?utf-8?B?ckV6Z2dUMzBJNThVMUtDQVR5NFgxcktqYkVLMW5NNWJYeVdndGRENlFiYXRX?=
 =?utf-8?B?cWJiMTQ3NzE5S2FqMXlJYzZGODJVdFRuUWVialRpUkRpcVdlOVhMZ0syVnpC?=
 =?utf-8?B?aXZNMnBRL3gzZXAwVUxkek5oclY1aHNXdmNSRm5HNzBqWWh5MDJTRFlHbXVB?=
 =?utf-8?B?MGxuNzArVnA4Y3N6czd4b213TEhvakY5eStqZzhneG9aY3ppYTdDc2FyUGdz?=
 =?utf-8?B?L1B2YUtRbGNvSGVMS1gxbURXTkVhSlhaTnlsOXNMOHY5WjVRTk5VK21qZ3l6?=
 =?utf-8?B?QXZZdjMyV3lLNFVEcnhxQ1FDeUt6c0wrWitubUxsTUp0ZVR6RzVwdTRGY3VL?=
 =?utf-8?B?NHkzdVJROWJSOXJnY3VuTFhrUE9yZUxLcXFSZjM1SFI4NzFta0pVeGgvQWVM?=
 =?utf-8?B?N2h4T0Z0bEJpaXhTUCtRMXcxNnljK2xuVVVCdmlCUGRPSmJsSVpObXp3ZEZ4?=
 =?utf-8?B?OFJ5NmZaK1RxaHpRZzhndDNySGh5Y1BIOGRicWdLcGh3T25QbUVUdnl1Mi9N?=
 =?utf-8?B?YXVjWk95OCs3RGFBL0RzeEpoYzRFSE5hb2ZYODRsVHROMHNSaVBzak5Ua2hn?=
 =?utf-8?B?ZXo2U202NExmZVhuanI4MWxOYXpEVDRNQ2w0N0FtaXhBL2J0MEpBWHdHSUU2?=
 =?utf-8?B?WkYvdm9tWFNzcktDWEhvcHNJSk1LaG9SVzBMYUNYWG5GZXNsMnd3Y2hnbU84?=
 =?utf-8?B?djQxazQyanAydjRlZmY5L3JpRDB0MjlYUDRGdWVNTkpaMzN0OFVkM1ZVbjhp?=
 =?utf-8?B?d3BhaWFhaHBTMm8zdGQrQlpGNzR4OUNUT29SWGZLQ1NCcFJlNlFXVUd2Y2Zs?=
 =?utf-8?Q?AEVEMW9eY9sbZ24B8QwMSV/32rIUmt5TLkmH6hl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb6e56-1547-435d-8cbe-08d91be14517
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 22:47:39.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoL+aJAOlkJMF/Cy4JXj4SKsJjCkW1SQenIUrikf2h1IinMswvUOKBTibiIThXdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 5:45 PM, Borislav Petkov wrote:
> On Thu, May 20, 2021 at 04:36:09PM -0500, Wei Huang wrote:
>> According to the specification, these IDs look correct to me. I also found
>> them on two real machines.
> 
> Wei, I'm assuming that's an ACK?

Yes, it is an ACK. They match with the values specified in PPR.

> 
>> On 5/20/21 12:41 PM, David Bartley wrote:
>>> This is required to support Zen3 APUs in k10temp.
>>>
>>> Signed-off-by: David Bartley <andareed@gmail.com>
> 
> Btw, David, for the future, pls run your patches through
> 
> ./scripts/get_maintainer.pl
> 
> so that you get a list of people and mailing lists to CC - otherwise it
> likely will get missed.
> 
> This one I managed to fish out from the lkml firehose, by chance. :-)
> 
> Thx.
> 
