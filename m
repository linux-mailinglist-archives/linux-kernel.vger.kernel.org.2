Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0426A3344F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhCJRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:18:15 -0500
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:9606
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231319AbhCJRR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:17:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brvaVshMlgcAEmIKVtDW54eVa1Hokjh32yHxdi4mJbpUMRIdHco4AC1RJdWgmiq7/5nIGF5SoErN2q+rLd5+ECOxfiDVz5FovYTP8K6Rho5UgzXPsy7DzFy/dxhw7cK2ctD8OIllo8STiWf7Tnfqqb70rtr8pYx1Y/W9OAiVR5ycYNN+rgWYZh+6z6X43+GDnQCXFqT5axpFFV++o9nkGSacck1D8E4P3bqW5N8X9EhQI08yBspoM1TqJG/09jrNT7IG4oQaLwApvTKRj5ODNo+W11o3RMJJ2XMv+d2bYfylxzOais5gdwxGK5rouUe6PT0m+Z+HLbRFBUf9D0f/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCu8Gu3BhoEseHyefsTOIO8fu7tQ/pvJYksY+x9Mscw=;
 b=hmIiN418E0sMrRA4IpIz0EX06CO119tAg/R8TLKxasdWc4e9mTc/9R+PFyPpGssZDb3fTID2815xVBA8KHQEZLTy59TzPVmvLEEBWkhlvFauiLDtidGQqXWq7QOy+UPRWk5NYYxZ3yr66hVoSfd0wjd4QU3ZoQdOBbkqWp9mHz1H7Ku2fgXhmC8OjN4kk2etRqfqHnsUb0+2dSwujlaDfJUhvrcIqn47zn/8rIeNoTvPW8xhc3ewJtKbneNl/PHuwG57YNY6+wVLGYCetRYmwK2Rb8YZ0QKx3Irhg/w165D/bUCxrmlez4qVOZLNvHJKTlHcdn7jbe7k2Pwo4ug4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCu8Gu3BhoEseHyefsTOIO8fu7tQ/pvJYksY+x9Mscw=;
 b=PmrzATtqnjc3YgTU1VfvvESGUyNIF65HD/i15Zhg8MQeEDpdG423B+yNBHMoMzEnGMbFKIdToIZbfkVyf8Vjhr/XT5ww9heVK2RK3Dz5T5cFdv7ekqYouKDpHfHo+QLX8tJEBBLc3QA36FqigDDTEuV6WLyYdpqmoWMkOjH5bWk=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB5556.eurprd07.prod.outlook.com (2603:10a6:208:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14; Wed, 10 Mar
 2021 17:17:56 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 17:17:56 +0000
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
Date:   Wed, 10 Mar 2021 18:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.166]
X-ClientProxiedBy: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.166) by AM4PR07CA0033.eurprd07.prod.outlook.com (2603:10a6:205:1::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend Transport; Wed, 10 Mar 2021 17:17:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2409bf1a-8889-49e3-3b6b-08d8e3e87238
X-MS-TrafficTypeDiagnostic: AM0PR07MB5556:
X-Microsoft-Antispam-PRVS: <AM0PR07MB5556776AED3F7C5CDFD7D9A688919@AM0PR07MB5556.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbwR5qxZWwBH8qhy7uaytig0iqqhgDeerJ+/9DGTGvMV+fDzqM0UUVc2C9PbuYJJ4Do4GSkw5YiePHPuxYOYm1tH4VNq0gZUHtzdWi7fCkDD91yhfpgwXApVRo/GnHyFcwEM2bLr/5E8zEI/rX35AzIRJHzg3HJCHuGgkFMcZ8eiV0DFdCD7IypcncNuOnhTF/8Sv0ytlCEz0fwGrOW2mS73hhUfAyvGMYup7g3+g9+03cMwHpq5+L2xYbAAH36n0NwvxtNYP3U/18SYTXtltnnnGJN87tcI5TwAcJe+u8Tu1qiaegAh867N6gEbO/IDumro+CiEwiDu6fWPJ/3DykJmas7FdnLEmOUt5aA7l5WP3EBhmryBUzAd6J/dnXOMXIWh3NqYiDUjoLoROZmvOXZ/dulMLKbqp+kUr2+gkYoeE9lPsWcVxGVUJzKJ42qAVp4fN5Wc6ASqcLzEyhMNv+eEtsnuizj2owgSpB4/IUqHByAOF4hJYZaSzod1H9pUMOmsYNIWQXvEyPF8TuqBafkr7BpIaKgdMGc0OPE7SehpBU62K6X9odJuw2RollETeCZBNoWzVs7qEOJ7TSSAsdZvIpIB9rwhfMgPGnKPgAEaq5nqsZbzGis3Q9IPYWCVIJLg1o1FjoVZkHtE4Z3rNcY5aGM5dLPLOmjIvYWfv1E3T1BvAOJ8dvSHvImC/f/u5fiFGwEZ8CCfkAUJ/W6C42bij+8OIvPWX0uoPXh3Mmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(5660300002)(2616005)(86362001)(31686004)(4326008)(6506007)(966005)(52116002)(956004)(36756003)(186003)(2906002)(16526019)(26005)(66946007)(6512007)(44832011)(8936002)(4744005)(31696002)(8676002)(110136005)(316002)(66476007)(66556008)(6486002)(54906003)(478600001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aXQzTEtkVlY2VHQ3QTB0RmdEejg2ZHl1elhHUmwyWWZIeDFpbjlEYmNXWGFj?=
 =?utf-8?B?V0Y2aVkzMC82ayttRjc2bzZNWGplUVlVMlRkOTRpTWZvc1pQWVBRczNpYkho?=
 =?utf-8?B?ZkQraE5YSHM5TWZFcEg2UVZPZi9IUCtvcDhjazlhSUtOdFc3cndiYWpGYWV0?=
 =?utf-8?B?Z3dzcFgwZkplZENQa2J6T0pIa21UajdGWW5QeTh5WDFHRXRLUmF6TG9vb3Qw?=
 =?utf-8?B?SlZwdjNWd3NURVROekpwRVpVcGRPZEttVEp2bVA5WTR3NFR5eldkZnZJdi9T?=
 =?utf-8?B?bGlNWkR6OFhucUlMcTFONE1uNnNjWmRhVVoxYzgzNmlJY0RNOEhpazdXblcr?=
 =?utf-8?B?UjJlend0Q0todzhaL2pjL3BMei8zbTRsaGdqNGdtNWJrT2ZHQmxDQTR0c3RW?=
 =?utf-8?B?a2ZWR1lsTnhDdVNQK3dMb3ZOeCtUTDh3MkY4Ym9RQk1vR1RQSDIxOWVQQ0ZI?=
 =?utf-8?B?aGlEUC9KNFRxQktzdTZmSkZBV0JlREovQ0NibDRlVE01YUFuUGZVa2ZNTG1k?=
 =?utf-8?B?aWlvVTZ3SERWcVdXUjlYbkpWejB1bVBONk5oWk4rZUpJYmVrVEpoUWhMQ042?=
 =?utf-8?B?ZXpCNmN1OXF0TkdPUEJJT3JzWStaMXIycDVDaC9rL3M5WDV4QmpWTUxGY0Vw?=
 =?utf-8?B?OEZWa0plTXNXQWhMM2h6bjBBSlRCdHVKMFBTOE9aNHByalh5RVVyMGduSmxG?=
 =?utf-8?B?amJyV0lwZHB6dGxjRUpodCtIUmRlZjJKd0dMeVFaZkdlRUZFUXdLazZHaCt2?=
 =?utf-8?B?YTRVMlpITSsyeW9rQ3BCSk84OEVIWTVnM3paeDNQakpFY2R6eWtJSE5VajBo?=
 =?utf-8?B?UitJUkFTVVFPY3BiUFhUdjFvVHAySzlHSDl3aEhQazEvZ1ZkV09FSFVpQXBp?=
 =?utf-8?B?cmliR1JmZlUyZ2kwdWpMOWthVHVSaFR5SGV4Q1pxdFZHd2puOUlwRUN5ZVpk?=
 =?utf-8?B?ZkNISkVzbXJCOGhxakpTT09NeXc4YzRqbzlGd2loYWJHd0k3NmFUTnRHVmJn?=
 =?utf-8?B?VmlTeG80RThneHBTVytmSTJCNGRCZjFnR2N5RGhIaWF0YmlMejMwcDJMYTd0?=
 =?utf-8?B?YUp2RnhCSWw4aUR1bXpTZUd6empuRUZKdUtoWXZqMzNkRTVwWU9nT3RhTmM2?=
 =?utf-8?B?MGRiR05sclJtSUROVENkZWErM0pSWldEbis1OGo5Z00xZ3hzMU5ERGc5b1NS?=
 =?utf-8?B?VGw4UXd1WU1MTE0yT0g0Y3lJWkhqYm45bU5NUnRHdTIrU1M0eWNLVElEYkx4?=
 =?utf-8?B?dFRtOGpnZmU2b0wrNFZVMWRLZlJVOHhoTGcydTk4NCtmZ29zSGQ4MGxCcC9O?=
 =?utf-8?B?enRYVVFPL3B3UDRNVmsvMEdsNFdNTmQ1VWRYNEU0UjNsdHEvQ2xtZ3VwSHFB?=
 =?utf-8?B?RkNTWS9GaUh1YlB0NEJJNW1XaDJMckFCRzJ6T042dXlHdFRIZGhENm5nRGtn?=
 =?utf-8?B?SDRTQk5BMTlxV3ZvU2ViR1BtQXVPRnZYUzBVZnRTejJzZWdjR0RPTW8za25w?=
 =?utf-8?B?YWlBVmk5TzA3ZWN2ZHBET2NPMlJ4M0lJV0dYdXJIY2pZai9Ka1J6c1JqeG1M?=
 =?utf-8?B?YllveFh4OWtLNUlFZmJlY250dW5uVFVJc2tDNVB5b3FnS0RNQklJYnBJQkFQ?=
 =?utf-8?B?WGs4WmNKaGFtT2NMajVpbCtyaFl5Qms0elRnUUt3cGlma1pYV2I4R09qVS9m?=
 =?utf-8?B?VHdDL2dDdjJUTDFsWUFpN29hSkd5ekRIc0hkb0p5aGM3M3U4aXU3NWU1VC9y?=
 =?utf-8?Q?OiqeFIuiHbAYl+s2aVGHJ3ur8UHXBKY5rAcJQl3?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2409bf1a-8889-49e3-3b6b-08d8e3e87238
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 17:17:56.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 921Df4TQvoJMMR2nmUEFlWwBG7HEN8U7MNSB6t1n5zXpI8C96e+PmJKFPGQSzK974gdM+TY+Msjy2tkN6m+lZ/vXc0Bvxtwz/wjLqRtwFZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 10/03/2021 17:14, Florian Fainelli wrote:
>>>>> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
>>> I still can't reproduce on 5.12-rc2.
>>>
>>> I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
>>> loading the module? I tried starting ftrace, but maybe there's a particular
>>> combination required?
>> You need to load a BIG module, so big that it has no place in the modules area
>> any more and goes to vmalloc area.
> You absolutely need a very big module maybe more than one. When I tested
> this, I could use the two proprietary modules (*sigh*) that I needed to
> exercise against and loading one but not the other was not enough to
> make the second module loading spill into vmalloc space.

Here is what I use instead of these real world "proprietary" modules (which of course
were the real trigger for the patch):

https://www.spinics.net/lists/arm-kernel/msg878599.html

-- 
Best regards,
Alexander Sverdlin.
