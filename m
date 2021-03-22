Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFCE344C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhCVRDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:03:24 -0400
Received: from mail-eopbgr50138.outbound.protection.outlook.com ([40.107.5.138]:25767
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230186AbhCVRDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEamDxtB/T4MUpOnAljrlOaiZNku2p37NtUE3DG0kaaA0rtoz3VMmZY9oDk0vo12EZJVzjMs/JFqO9DCk0pIEHuQZHvVuN1TWUVoJAiO0qdaryc+gw+NtkKv+8fygSlCVhjxEgf7B+NEOoMkPzdxnTXy5qoXNaBfD0pwWCwUuLO2SlPXDza+2OrzFrBPFf2V6Nt0SHcTosU32c4nUysByIRqPSEH7AjBnxuGnp2zzGWOo3yMQTYSH533l3ML4TjrvgghKNOUq3Wy1wUcXfluceCMnLEoDderg3432wJgEfh/VCeSKObMKh/fdZGASQbFKSPE5a1OKHv5xiUkMgqvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uuupar8H9NZhYTEciMAmBGdbqg25bF3WhB8kjW4GbI=;
 b=e8f6nJgamHYn9xt3sZUkf16w43CeVUTkRuxXh+GYEpl1kxJuPn4XT8z68KWO9zc/MruD72387ZEF8LDoZXEMsgadcfKJGIuil9q9kQ8JzBvfiudTty1N+/jKigPV2xpI5bhS6G/27boBnNtDdmavcPtEvIx5h3AdU6T5bRzjIsZERgoA7R1xbQ87TmY55Y0ekvYeSJJSPDN1aGn0bIAivpvoO1qqFu5WuonmqDaIM5ksgEEz9XGs8AcJXfsjK41L5+0Fgism8R7y0/6C0mx5NTAFfmQ7wYphYI9oIQxPw/3AdBmc5/ffR8h7M6qjGb+108FhDYPIzQ0R8Ka6gkxV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uuupar8H9NZhYTEciMAmBGdbqg25bF3WhB8kjW4GbI=;
 b=GV0KVqZpf3OwTAPxqq8dvi79MkZDwtgYHXexARB6fD/UQvXyBFOssKmdX7Z2Pl8LBJOiicXCEk1fTp2KHt7D2L/UN8Q2tmuwkmVG7nvCY1WR1RrePIFN2DFUWBOr1tZLZuc1I0mJsU/x+3ElGb5gBJTUCtCZBL7++ccwama/2So=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM8PR07MB7393.eurprd07.prod.outlook.com (2603:10a6:20b:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10; Mon, 22 Mar
 2021 17:03:06 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3977.019; Mon, 22 Mar 2021
 17:03:06 +0000
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Qais Yousef <qais.yousef@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
 <20210322163248.id7qplbk6och6kuw@e107158-lin>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <504d72ec-70a6-7e50-dbbb-16d693ce6150@nokia.com>
Date:   Mon, 22 Mar 2021 18:02:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210322163248.id7qplbk6och6kuw@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.166]
X-ClientProxiedBy: AM0PR10CA0103.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::20) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.166) by AM0PR10CA0103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 17:03:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb92f6ca-c4e3-4ef2-f993-08d8ed545cb8
X-MS-TrafficTypeDiagnostic: AM8PR07MB7393:
X-Microsoft-Antispam-PRVS: <AM8PR07MB7393C7EC039822476D3B0EED88659@AM8PR07MB7393.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BhhBWLh/56bSSA/+jtCEzbAiJw4pUVyN1L9sUi9AOU0cTtkDPIlj8msr9/6m0riYe7SBgRwc2IB5qzjkpE850t1xhHVfqpnOQwunng5DxDYit+qQn5yIzbkrh0bzUcBR9DL5RdqFk3yp+W9rKzFwz57w60pPtX0ZVvAgmbBr4owUSMwcrSalo9Mm5zeJvJvNqmqVYlU6hOhOvQCHxY4SB0SWmczWWa9IaSoZEgIenPmLkin+/lD6lWX73uKl24uh8CIB8F9mliimPDaL4ty9mq1lnnQtP5ZZUr0+Y+qUpdWu/Cy7kL2ZZRBQ5jRBy2CoI+VvDiQ4t7JLwJM2uhhS1A4MNitl74wDoa/bJsmR2nVtfR4hn5/c0xx5WI3JXWTE4s/LZDcMvSMFA3+yhrpAw35YPZ7k/48TmUIbV0ei2xBoUBxpMkU2l3puIcysns0VJo38vYJMOS2NAphK9MGJuTy3KJZWCotvdPpZHKNxTBQQQAZ7eUEyrbpDItqTKGShOT44m5QJPsYR9YXihqTu+TxWYDMJZSSwtN/ccD7245drUw+lTQW8uRlqgeahdPp96X/vyIi8tZsswMi38y0xXcqaQmi71W9jiHhX9lScAT9mz6W8XEKDcn2j1eKqOOja+K5uKew0UnGyDStKW7mPsA0Ob/nY6KCHzQZP7aM2TGktK8Eiza/PFiQRXtassnUasqAof+cwXNvGcVGOcr0zuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(2906002)(26005)(66476007)(4326008)(6512007)(66556008)(66946007)(8676002)(31686004)(6666004)(54906003)(44832011)(31696002)(8936002)(5660300002)(83380400001)(86362001)(4744005)(478600001)(36756003)(6486002)(6506007)(53546011)(16526019)(52116002)(316002)(38100700001)(956004)(2616005)(186003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eTNHVzVtQmlyZTdMZ3d2RE5nbmZOUUZ4VDhZeGdqb1I0emRPaW9Ma1gwSmhx?=
 =?utf-8?B?Qzhqb3FLZ093dkhzKzB4T3oySmRRMnk2SEdRcDVoS1VMV051N2FtRHgzWUlF?=
 =?utf-8?B?V3VkSDRYWjJLQWY4SThKakJJMzZCQkQybW9iS2lMQUZndEJQdHlkeVFQL2pr?=
 =?utf-8?B?TU1SU21oZjJwNjN2NVp3VUl3R1Fjb3Q2d01ZbXRJUUFNcWphVnZQTHIwU0Zs?=
 =?utf-8?B?Kyswem9mOVdRYkdTMzJEUFM4RENNeGhIWDB6VHR3WnJaemQxU1JaK2hYN1Vq?=
 =?utf-8?B?ZVFSN0NTYmZhRnBoM0FhSXlwYUF3dmRhNjFPdUN4UXJQanRmZ01nQ1VFeVRL?=
 =?utf-8?B?VkNJdUVxR1ZqQTc1eUM0VjNDcGlpVHV3eDNYSHYvT3V1b1dHckJqa1REbk1V?=
 =?utf-8?B?OC95T0FnWnAzSi9ZVG1TSmJVRWtleWtMTndzRUZ3ODFjY1FBNXAxVk5vK0hj?=
 =?utf-8?B?MXl3ZWQ4SmtlOEc2YnpMVVpOODRkQmpBL01uTWZra0VjakRraG14SEJtY1ZX?=
 =?utf-8?B?a2hJOTlRdTNJVkVRUEJrditjN3hINlNiNThXMHpSekVaVGxZZFBsbHRhWjl5?=
 =?utf-8?B?Q2R4cGFjTlFKNi9JMFlrald2NERxUnJROG1KTk90Mm5WWGlrRkpoZVAvbjZT?=
 =?utf-8?B?T09hcXVSSHBmMDYvYmhtdDJuUWtkS3UxbzBpYjFkNGoweFAzU2dUSEE0UUd2?=
 =?utf-8?B?VmJOTml1ZEZaS0VaMXNnZ3dDdzBwNzdYQTViU3g0OUZqcEw2bERRUEVXbGlL?=
 =?utf-8?B?RFFGb1NOUm9XdjFjSkNtc1dPbndvZXlGbUZ5SWJaSWVMWDB5MUNkVjYvRVdL?=
 =?utf-8?B?ZHlqeStpeWlRZ21YOUVVQ0JsaXdNNXVTc1pMbG10MVovQ1d3SzhRQnFMN3ZU?=
 =?utf-8?B?Zy9xb0hoQlEyV0tPYk45bWtxN0szNWRWaEFOVzV5enNFT1FqVHJwSmtmNUtO?=
 =?utf-8?B?dlBQN0s2M3hqcFkxYXEvRVhVRjc2MGt1d0o5N2EyTFVUenowT3dVSmlUMVdD?=
 =?utf-8?B?MURZdHNpSmhTeHE4Z3kveTU0V0pRVXg3U0hsanNqNmFmbGx3YWU4NC9uUk9l?=
 =?utf-8?B?dXZHOHZyWVJGNHE0ZmFjbWVxSUVLb3FBNmFFQ0F1VWloYlE5ZGUvMzZ2bEV4?=
 =?utf-8?B?cHM0RXlGSDgrTDhxUGFzSjM5aXZGRkcvTHNYcXpoL1VNTDQyaHhtenNwVEFa?=
 =?utf-8?B?ZktkTjZpSWNHcUU5OXFnQXBjV3Y2VVZjSjV1bVJtYkd2Wmx6a21PQVFVN1lN?=
 =?utf-8?B?UUxBTWVTZUFDanB4SnRlazhQWnNzUmg0MDZsS1RlTmVLT0dtc0lacU5uTDJn?=
 =?utf-8?B?YjcwMURzcnl5SkJnRm0ya0VPa3dJWEcvY2J6RzFGL2V1T0ZtSUkrajk3UlNv?=
 =?utf-8?B?SEZ5bnYwdW5Ua1pHbWdIcXduekxmSE9aM0czUUhRTUw0bTlrYS84VmN0T042?=
 =?utf-8?B?blc0L3B2bDd0cUExR0RUVW1jd3dJMmlyQzV0OVYrWHVhUHFtVXJ1TXpDYUwx?=
 =?utf-8?B?bExsWURoWEVib3JzZ0EvbFVZdlc1b1I5QWNZUXNOVTMxNXRjbnhWK0x2M0ZN?=
 =?utf-8?B?NC81Q0dFNkJ5TDhsRVdkbkY1Z3kxUWZyQ1huRWF6TkwzQWtwaU1hbkxGQXhp?=
 =?utf-8?B?RzJaeldBRWJ1SUJMRkJGZWp2c01tWEowZWNHVzVjSUQ5LzFXU1ZidXpoN2w4?=
 =?utf-8?B?Q00zaGd0Vi94cGs4Uk54VGRGL2JMakp0c2tsSWxldUE2WURxZUJHMmc1NDRH?=
 =?utf-8?Q?ujYkrqNC9iLUZaWKYvtoMlsb5iY+JN8g4nSkTqb?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb92f6ca-c4e3-4ef2-f993-08d8ed545cb8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:03:06.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTup+1VLW9h/mYzZvWvIo6dRQuHUWVznFKDrK6KZnAZV/SwDTN+I/LyRQgaPOrGgIRgiY5nDpgRQLvop4O0AFVJHLdFYnd83WhOdMqUiVjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7393
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 22/03/2021 17:32, Qais Yousef wrote:
> Yes you're right. I was a bit optimistic on CONFIG_DYNAMIC_FTRACE will imply
> CONFIG_ARM_MODULE_PLTS is enabled too.
> 
> It only has an impact on reducing ifdefery when calling
> 
> 	ftrace_call_replace_mod(rec->arch.mod, ...)
> 
> Should be easy to wrap rec->arch.mod with its own accessor that will return
> NULL if !CONFIG_ARM_MODULE_PLTS or just ifdef the functions.
> 
> Up to Alexander to pick what he prefers :-)

well, I of course prefer v7 as-is, because this review is running longer than two
years and I actually hope these patches to be finally merged at some point.
But you are welcome to optimize them with follow up patches :)

-- 
Best regards,
Alexander Sverdlin.
