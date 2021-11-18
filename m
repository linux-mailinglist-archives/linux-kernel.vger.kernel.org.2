Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E684564BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhKRVGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:06:12 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:18560
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233949AbhKRVGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:06:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk20c2d3RtM965VIPEx1PX5Lu2SMJte+L4BAsqpMJtVGMrHLhLAdjhP+MUwiQNMy1LN0YVPQezbJvvCGfJR/RGtjNtW2iHUTOmiFUpqJU6o+182DXoBoJRP3DF5tT/lAKZWAqojefzMkHoOylkWfYZVvoeOF3DXd9R2vZ0ji5OoYbGSiCW84Dz+RhQHL77H+8KSxtKYu9r44n/d2ztf/RXTl5d4HenCZmKAUz8CKEMxARPkie784M5C/hY2qzWNOV2SHRSkpxpVoIy2YcAWlV8E5lhZd55LWPs0gnjmrzJPhC7a0N4mn/eTJsQS4A6+JVCNY1OoUsilJ3ntxa11VnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehv3vxWSuYNRMsgYCVA12YBrW31JvZJV0tvytvKlb0Q=;
 b=YDu3iNJRzL7jm+Lr1pzt0WHnt8AUp1c1GRwbp1nDebJHeoCUwOOQrysU0JQVAQ3avjEq3DFk7dkqFI9BQi1E0j0AsVEKvhiN47/lim2I6kg8VrDP+OeU/4/TLzSZgXMhTl2I6mgWXMXd1hW3VqUp3XAgFYDC9F2K55OhNV00CsqdhTFeMouJgNSNAIFw+mz4udIY5QEz5JwV0x6Nny0dABCBCGsbpsM4q3d6uvvQxFQO+mh9TBlbW/xveXjnoKk1QX9ZDz1UFbfTmgMutaCxsYQIbs2eI6usGemAkOFGBvNvioaMUBEMUpa7rd7QPl4Z5bVWAwV+mzOLnfjoNGgIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehv3vxWSuYNRMsgYCVA12YBrW31JvZJV0tvytvKlb0Q=;
 b=Qg7y7ERUgsvoEpQDcxvZb9rGFXPdM56OJWIsZhiiE919G2Uu0rHi2YBlRxayrcH1a/mmvzRY8vfqHrg3d/UVOn9PxnmGCbDTk6f9X186erVnsjkSgewoE3hYRqYQyS8NusNi2Jm8yWJv4LWuS42kvoaDrbuzVIDUuXFmEqCHL70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3043.namprd12.prod.outlook.com (2603:10b6:408:65::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 21:02:59 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 21:02:58 +0000
Subject: Re: [PATCH v2 11/13] perf tools: improve IBS error handling
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-12-eranian@google.com>
 <689f7b71-32b8-ba0e-22ff-c2248662b1e1@amd.com>
 <CABPqkBQNpFUGm0Eu3KtPwex1r7G5C0yp-F+fsjiS+2KJ0uuRqQ@mail.gmail.com>
From:   Kim Phillips <kim.phillips@amd.com>
Organization: AMD
Message-ID: <659eb6eb-3a46-f9b4-730b-026c28a50b31@amd.com>
Date:   Thu, 18 Nov 2021 15:02:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CABPqkBQNpFUGm0Eu3KtPwex1r7G5C0yp-F+fsjiS+2KJ0uuRqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0013.prod.exchangelabs.com
 (2603:10b6:207:18::26) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [IPv6:2603:8080:1540:87c:fedf:2f0f:c0e6:d56d] (2603:8080:1540:87c:fedf:2f0f:c0e6:d56d) by BL0PR0102CA0013.prod.exchangelabs.com (2603:10b6:207:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:02:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0092f980-7ae0-44ce-50da-08d9aad6ccd2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3043:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3043BD970007AF45044B0E46879B9@BN8PR12MB3043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP2mlT321i5s0Av2WbN5zY6obZ7+rCCMF4atVjmdTeg0svYlWsEIS0mNoszJqQAJudmDSRWYvdo29i5ahCEEn33a4ZGOxKYPMzf3fqkJDOnfr7LC6o2sbvTRnYeiV01erwXZPSX7FRGdS3Vmq1IOpwZSywls/ZbmFGSFLwlWT85CoNgoNEB88FvKDWMlOvU5EqhFMW52Nmmn63QCddCHQ9aKJZ0D8apsRbqQE8xj0cjQJm7wwiyaHZJiyJff3hvJe3h87NOt28pogXNEKR0q5FK3Zf+9mrPpmxXRY+yeSxOu9CxIbp2lwnDht8S8niGhRRIgNHwUe3o6T3iBe10LFWCXoBZMv13mjDXXzvmUtpUxj+ssWNJ1CCERvYjjdG4ZyBIQT9LeYva/3OsKo2OxstT+x4VeTS1d/vp2IEj4TDf/6dG1CEHc+QhmElqCxF5m1v96XFNHHqHriC5WaFCjMZ4tGLY4tdAk4BWXXIsr5LwicpnY2lkU6pJiIClfRXW+2H3DrWR0lrDgQ0ksPiGpUcwn65kjT3TMKKE6sdYA3mIrqt/nBPfYqtwLLZH0hUvuJZBGT9GYvtA2LTfvLw5XZbadeM1DdqAu8uuiTyoo0rP6V1JihGedHGo58LB6NBovrFM1Apcedr1GNeczl6KQnhvfylUTAGv6YiHTy0Sk+L5x69bJozretAHb0pPSRr0+9SPiT/k6pLoTGc6aicmNYhJYF50NxMXU6yQTJSddvBPDCk719HWdjIql9q/s9Fyi/SjnPAze8i8OHEQBM7Y9do977p82OrvUV+LLsPqLGTOrIm7+VbHj09VO5unBOIRI4aqAQY33NIko+Qlvxh/oRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(83380400001)(36916002)(6486002)(8676002)(31686004)(2906002)(36756003)(53546011)(44832011)(2616005)(38100700002)(86362001)(6916009)(4326008)(66556008)(66476007)(31696002)(508600001)(966005)(66946007)(186003)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JFNGpkTWFDbnBDWGZsdUFlblVlaTVFYWdWQjJFUzVnUnJKeHFuSWh1NDNm?=
 =?utf-8?B?ME1LZ2wyQ0hmcy9yaGhnWEhMdklqS0dGMWo0TGpsVEQ2SnZuTWZOWThWYjVs?=
 =?utf-8?B?SDExaVVUNHdYVEI4ckRYcUVsc0pub2pMODJCZHRkcXdxYjlya0tRWnRHcnRZ?=
 =?utf-8?B?SEx0aTZhQXFlV2VHYjV4OGIxeWZzd2lnbEwwZElWc2pqS3FRM1R2eDROVnhn?=
 =?utf-8?B?MTZjQ3QyQ0dhVlZDMkNyVXEzREg2cWN2cUdCMmhkZU0wOW9WNHkwM1U5SEpv?=
 =?utf-8?B?ZHUxTlJyYXdEY2RrK0V5NTBFa093ZGhaRFFSMnhTQTFaOXJ3eDBnSWpLQXYx?=
 =?utf-8?B?SXRBbkhkVCtzdUpHdmZodGpxS0VLbVBXcGx1cHBtVzZtTithaWtyaWd0NHRr?=
 =?utf-8?B?dGVNeGFTRGFoS2crS0FxbzJ1VFo5cDIzc3c0dWhnci9Nbm5xUHlZN0Y1VFo1?=
 =?utf-8?B?dkUxRVl6ejJYSlJkQ2M1em1EUTdRZUYxVnBMdHJWMkh4bVU2TnhLYTdvK3Zj?=
 =?utf-8?B?ZGE2cEJuZjlhcTlnTlJFZ2xoS0habVhnYmFWL1gvY1FkUlJmRHhZRmd2eG5y?=
 =?utf-8?B?UHhsbzlPWGh1cVg3NTFsMVlSeGxOcGgxYXh5a2dOZzR5WkNHdnJRT051c1FN?=
 =?utf-8?B?dzJRdEVSUTAxZG5EY0VpbDF2aXNaeS9Vekozdmh4VTUzNmlaZlFERit3SWFD?=
 =?utf-8?B?WWc3R1BrSko2SFpwdG1oS1dRa09obDAwWFAvTEZoV0Npd3ZiK3RjY1lmTDd6?=
 =?utf-8?B?ZmVwUHpFVW5Vbm5PQTN1RGRmendIZ2JVSVRjem96SFRCL29xNU1SaEdVVFlW?=
 =?utf-8?B?YmU3ZTBMaXl3Sm5LSFlxRksyRWoxb0t5bC9xNUlmRWtTZmZxNTNxbXlDM1VF?=
 =?utf-8?B?L2RNRVh2dmM5c2tZTVVaT2ZFczVxdlhrRWJSNkNRWTJFWWx1NDZlQ3pwMUh4?=
 =?utf-8?B?SXJ4akJwdG9Jb2wvckMvREo3c0NjbmZKck1aZ1Q3QmR2WitBYXdLMzVaemNL?=
 =?utf-8?B?NzZydGV4bWJQaUZnY0pyL0VyTmh0b0xZS3JZOHRLbksxaHdxQ1Z5UmEzckhS?=
 =?utf-8?B?NEhQazU2M2lwb1U0WFE2bXF5RlB4ZVRTS0hUNjZLakZNY3dvUjU4UGdOOHNj?=
 =?utf-8?B?WFNKOEk2MVpsdlNuMzcyZFNsMWtUY3ZGM2ZTaVkvdXFrcUY2R0NweU95S29v?=
 =?utf-8?B?M3ZIM2RQSHY5R0FHUStwN21XSGlOT01KNkp3TWwxRHcvek84cmEwd2RUbi9L?=
 =?utf-8?B?N0VjN0FCNGhjRTNCZ0ZYbDBvMzRkcWwrYWg1bmdoY3MzbFZHbXUxeHlIQUxR?=
 =?utf-8?B?aGpBbjl5MXJMekZ1TitDUTRQQkNSMW10Z2R1YjVNbGN2MnZDYlYzdlF0QWpZ?=
 =?utf-8?B?bmJyRnhVNzlEcGpvcWFVOHFUOVM1VE53NllpRytGRHdnR29NSi9VSHpnZDhQ?=
 =?utf-8?B?eTY0R09hQkZEWHpQWEl0VVRhVFYvRXE4ODcyZEZ1RDFxS3VHN08ra09Mc1Zy?=
 =?utf-8?B?bmJsVk15dXpNNUYxNm1uWTZUTFBqTUYrWGVseXhHdGZSdURRZlY3MmZDMGVx?=
 =?utf-8?B?NVZJbUpuUFppNTZWMUxndDY5amlKcS84VXNMQ1YyKzBOdm1ibGxYYzM2R2hF?=
 =?utf-8?B?c284cjltZVB4ZkloSkxJRmZMYmpKRmFScUFtenppSnJPdCtkR09NNGZleUpW?=
 =?utf-8?B?YXlGZW5VNlZzWGVxVUhteWgrRU9WWXBIRDR1eEdzeS9IYjRCS0NHd3Z6SEtC?=
 =?utf-8?B?YlRZSFk2WTljOWFwRlZBQkdVQWhaSGRqaTZTMjZCQlNiR3FuVEVML1Myd3dl?=
 =?utf-8?B?aytncHMvL1hkTEFMQTFmMVFvY3pmTUE0OXk5dnJqMlBaV052SU90VTVDY0NX?=
 =?utf-8?B?TENScjU5MWV1cmNJNUNHRXkxVnNHZ0dybVREMUNta25JdU1hYW1NbGtqUlNq?=
 =?utf-8?B?ZkZqWWw3dk9jWUJEbVQ0RURvNlRINzRjbmdYbUdOeHNreExvRWZ0U0gvUWNW?=
 =?utf-8?B?YWFLRHd5UHVFSE5aalU1R0F4c1RWRVdlbGp1bnZxeHA2WHAzeHZVNjd3bjIr?=
 =?utf-8?B?SUVlYXF0SSt2OVk3SkliTnZKSk5YQlYxL0pmeDJwd215M2V5aitVVjdrN0gy?=
 =?utf-8?B?ZVM0bFBaYitsYnQ4MWVDOTBBTlJMbEwxM1lyRWtDWkJqN0Q4NHFtTHZUZk5B?=
 =?utf-8?B?SG0wRm95ODVwR3FRdE8ydTdGVlIvdkh4bms5SnhqTGhwSkVNbWZScDdyOG5O?=
 =?utf-8?Q?oV0wstb3qmhRcLmK94zV/bGeTPZl+a5xGMROsvLT3g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0092f980-7ae0-44ce-50da-08d9aad6ccd2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:02:58.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PG4RcHvrSCDoQMUZk1FooRBh9R/ywZCWQt3u9LIqywcz1VlC40vZD76e15C257LnA0L5TqILcFu6r0zeohMDFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 3:15 AM, Stephane Eranian wrote:
> Kim,
> 
> On Tue, Nov 16, 2021 at 8:46 AM Kim Phillips <kim.phillips@amd.com> wrote:
>>
>> On 11/11/21 2:44 AM, Stephane Eranian wrote:
>>> From: Kim Phillips <kim.phillips@amd.com>
>>>
>>> This patch improves the error message returned on failed perf_event_open() on
>>> AMD when using IBS.
>>>
>>> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
>>> ---
>>
>> Hi, AFAICT this v2 == v1, i.e., this patch doesn't address the comments
>> raised in v1:
>>
>> https://lore.kernel.org/lkml/aa40b532-0e95-76c0-6c9c-a91d45bf3468@amd.com/
>>
>> Arnaldo, orthogonal to this series, it'd be great if you could apply
>> these two patches:
>>
>> https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#mc4c9c582e3816ab31af6d0187e6803de1a98ac84
>>
> I don't understand why this patch is related to the IBS error
> handling. Patch 11/13 does not modify the evsel__env() function.

Without it, after applying patch 2/2 of that series and executing
the commands in 2/2's description will cause perf to sigsegv.

> I have included your change in the new version of the patch.
> Thanks.

You mean this one?:

>> Then, Stephane, you could drop this patch and in your next
>> version, patch 12/13 of this series would be replaced with
>> what's at the end of this email:
>>
>> https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#m885ead1f280445357c91cce53c01217913bd017b

If so, great, but patch 1/2 in the two-series set mentioned above
will need to be carried along with this series, unless acme
applies those two directly.

Thanks,

Kim
