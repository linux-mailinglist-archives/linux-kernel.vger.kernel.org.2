Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2736544D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhDTIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:39:46 -0400
Received: from mail-eopbgr760082.outbound.protection.outlook.com ([40.107.76.82]:57154
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231145AbhDTIjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOLaZ/pynw7Y5aCasGwQkaZzIMJH9DfzJm6krphpMKSki61Fx/uwZEC9bM4ErCupYtz6W0Tm4gFmo6MMy+soBpzfedgYy+K3Gbr3o2mBZerEbXi68hQ0iR8806NdAJ87jZunEdD3R5CoeDlkk2hAmdSUk1UyGF6CGM3/4AxvkSQssPTCnHnV/is4/3CHKoQ1UcV3fvTYmUiTdcPvffz+iTk0N5R4pldOjdsMgv+7toeRypwnyuhNyk/Z4Qop1njssaXkvcCZii4Fe03gfqpw14YG14ccQLv1WUnrCkLM39ft0eNjylYK9k2c8iBfqPM5JgZF6PqsUTcu8H4o/mMj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqLKDXwbbIK71cyAcY+6gcgEavl/QMix/ulMYFIZCeI=;
 b=hrE939yjHFaKYk5rXOOKX/N4V+e8qAtTMkicfrzWdMkQqZmpNgxKeUefTZ3ZiWeT/U/PE6Ssa4KrPVtvffbe4igbJbm7t29Byw6jQjFHy4TTyv+0dkRSCTAWWFVLirqBNWrjYK3cRhDxQczJTpP83xxf2zR260tE834xkpAifXYtNgwqw46rAnOPQbZIb6RYY7UHrv9uXvt/gL9OAX7NXkzx7W4jfu0HrDfoyO4j2C/GYeCHjktOAVOyLoQRtv8qEWkcBpfMEopEDTOmU/QOu/8KP9oy3Jt0Bp2Slk6Lt2kaaUpq9XyCgbFFeZY6EwSfMYR2tXTEVMU+B07ZWwciSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqLKDXwbbIK71cyAcY+6gcgEavl/QMix/ulMYFIZCeI=;
 b=XYrGR8YGnz9sTSn5IWvLeqdoRAQrAAXnyjzcGyc8SrcSX1xsJkfnfecYynIlPJyDcqynwnqh1kJ9QD2TSiNIlG5i6MfP5XNL16n3yS34VgBLkjoWV/Qch9WaNbmEscMndgLcWMYiB3Wo2qvtUqrLSBM79hua5ZqNXkQ5LOZaX+c=
Authentication-Results: bugs.launchpad.net; dkim=none (message not signed)
 header.d=none;bugs.launchpad.net; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 08:39:06 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:39:06 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To:     David Coe <david.coe@live.co.uk>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Alex Hung <1917203@bugs.launchpad.net>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <9d5fa4ff-9666-6475-7f61-2b45cbd83456@amd.com>
Date:   Tue, 20 Apr 2021 15:38:54 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.140.250]
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.132.84] (165.204.140.250) by SG2PR02CA0112.apcprd02.prod.outlook.com (2603:1096:4:92::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 08:39:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdeb0d31-b267-4ddd-0bcf-08d903d7c262
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981AB6B61034E4D4854629AF3489@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H0gBpQKj8H6wre1ee+RlgUK/1qO78xfJyA0mB2B/Gn4ZckCoK9sdF0mTkaJAvwLqi8rg2zhGQPyJhsAYpo+4Q2Y9piMglVNDup72DMDHQc5LkzVyeIJPkQl6+EYfKOowkYBATkRNx8TksrkKfCpZVB0xasawab0HsFn37s08BwrkuAe7WsOluy+Zt1CmPaLPVRYRkV5UzQLWXMA9LPgnzRJtgRwJfmEQNvQdCpsFudi24d72Q+M4IhdFjSD7NZuX39mqoQ2+KXJ5RZ9q/FEK7Z6yrl0DsaRypgEGRAI8uhCQE/LXx88RQpwTySy9NZnotaHCKO7eU17nbAdHcaIe/o0XoAqx1tm4jiLDqB0AVjXvMEV727LTMtBvL8TFuokRtCGALmaaScw+2IdyqahpzfOeTxkqvkBGFUKlqH6A7lGbGtsAB511KcP0uhwPVWF2/5UoooobBd73hkHmiYVxyXEetQQxYZlqSr0mXL127/wwynCSdI1ysQo7a+yRNIwd2lDutA06+0We9Dbbq3jfQcqRaL2Ec49i2FgIDxHdM54rMdYhrDUzXI/8X1F4c3dNSDqKtwvECP37kbhjqJhMWdHDfwwettWEP4lRSZdWiqv4rot/zUtirLSsfZmj2WTZ5VuziYNm13UcNu5+0Hprr0YHl4xH2jkSnAIWJ2UxeqQp7GUKgWouUvt3+lmftduwBAKp5IUa7TSlN+I+T5s+6OL4wmgscgVSgM/qiXuKdM+m8uc+lfOdkACdyPFgV9i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(38100700002)(316002)(5660300002)(38350700002)(16526019)(186003)(34580700001)(2616005)(4326008)(66556008)(66946007)(52116002)(8936002)(31696002)(16576012)(54906003)(66476007)(7416002)(956004)(83380400001)(36756003)(86362001)(31686004)(53546011)(6666004)(478600001)(8676002)(2906002)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y25IbzdpdENlQXhBZGN4UTBwYkU0QVV2Tms1d0d6WWF3R1BBZ2srWTlmSEI3?=
 =?utf-8?B?R1ZSM0tGQlloTjdHV05vUUtkQm1ldDF6RWY0K1Z2TVJ0b1ZiT3ZuUS9KY1No?=
 =?utf-8?B?ZElkOENvODQ3enZ4MW9XYXhiKzdWVlRTQnhIUXFLS0NQRC9tSFE0TnllVzVw?=
 =?utf-8?B?RjhhUUc5OUVpbnBGN2xvTjNQMGVDb29sK1pNcXhNRXRHQ05WVDc0ckZlMjVs?=
 =?utf-8?B?WEJ3cnZNTDJqaUsrMkp2MWJFcGdLTGt6OU8rM0ZWSjEzL2N2Q2RlZnpTQTl5?=
 =?utf-8?B?bG1iWTNRK0s0T2NkTXBwYVpSSEd1VUU2OVhEYmVHK1R5V3dsQVdROFptUmxL?=
 =?utf-8?B?cXhHdVo4UWVFcXBEYlBBdHFBc1VYbEJRS2ZUQlVDdkwxeTFhR2w3REgyeXM4?=
 =?utf-8?B?bnZYRHBwRGN2Lzc3MWJGck9NcmVPSERHZzNMM0RXZklSOTNHWnUvaFhhaUpN?=
 =?utf-8?B?UlV4b0F2VkV0TGhwZXNzckE0cTEzZkRaZysyOU1qN3o1cUZZcThwYjJEalM2?=
 =?utf-8?B?NVVYNUdtdzBBVFB6R29DYVREbVdmSGd2U1dpL29NSWxtMUxQM0JtSER5Unk5?=
 =?utf-8?B?bk4yY3NGVmN1NDNOT1k0S1YyU1FTM25YMUtQQzFscTFkanRtRWUrTVdKMnN5?=
 =?utf-8?B?V29va09Nc3JBZTRkdnBMclJOMURtYWpad2VRN3VNWHY3UVNzK1BxdXBNeHVS?=
 =?utf-8?B?L1I3VTlUamloWk5CMENwUVNIczlzbkU2ZFNIRUdlTldSMXZVazlWYVE2VkZZ?=
 =?utf-8?B?SnJlQzJ3VGorL3FYTnRRUGFkSmlVaHdERGFBaEJQUElUaDByc2dsNTNLU1R0?=
 =?utf-8?B?QlZXOTB0KzV2OVFRM1cwckNKQ3Q2TGJubWlCZjlBa3hmZmdqaVI2a3N0TW9P?=
 =?utf-8?B?MUJCaUxMVU4zcFB4bnc0WmMzZ095M2t1eWFPeFdjWExFRGpFYVo1eUo2QTdx?=
 =?utf-8?B?Sm5iRk5WWEZlTkI5YjlmL1p4YmxVK1VnYWFBbXNWSzZxNkt6bWlBZGJuSmVi?=
 =?utf-8?B?TGtGbDVhWFJNOXVITi8rMUR4UlZNTW1HSndWR0hQT0dhSnNia3FGTUVYRlpT?=
 =?utf-8?B?VTV5ZU42eDE4Nk91RGUyNFhqa2MzYTlINWdFV1dicUxTUXlSQkRoSGRTaUpl?=
 =?utf-8?B?WFJtUnFZK0d0RjJFd1NqS3RIRkFETnZ2cElHdExvd3JYZmZQUzF6aGo4MXVN?=
 =?utf-8?B?NnhsK3FyM0hST1AzMDdUYTU3a0Vic3ZVRDcwZEpBMjllUHRhNHhCUXpTWlo1?=
 =?utf-8?B?L0owbE5XVU84R1ZadmtwM0ZYdXhwemZwSC8zbmJQbEpVck9oV3pzOW9KQ1ds?=
 =?utf-8?B?dzJwd0RjRnI0ZWVNRkNoMVJIbmpQeXR2RUlmeUlGeFlKNVRQM0pJdnUyS1Iz?=
 =?utf-8?B?c2tWM0FldjI1Z3MySU5yN1ZQZWZ5eWhBWTVMbkdUSVE2Qzd1dkYwMlJuM3RO?=
 =?utf-8?B?NnEzZmtRUHBxb1VmOVcvRGk2K1ZRVjBha3hpVFkxN2RiekRUa0NjamExdnRT?=
 =?utf-8?B?UDE5OGI1WjlsMGNTbkcyVWs0dGQxOUVrY2Noc2x0MVBIZTEvYmxIY3YxWnRL?=
 =?utf-8?B?Z1dtQ2lJalpVd2JrbVA3TDJVUzJwY3E0QUlSZmZSNkhSM3B6cVk2KzVjVXp5?=
 =?utf-8?B?MndSRGdNZk1CU0VHY2NwaEthNjI2M3lBa0JaRHViRFRtZlphME1SdlcvamdS?=
 =?utf-8?B?QjFnYk9zWGsxdHpRQjdmY2daQUhMRHpDa2pUUjNhemZwZklYV25ORUlQK2VC?=
 =?utf-8?Q?ViF20vIgy/mvbD1+2jSzXmv0pf58FqPe1udQvBa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeb0d31-b267-4ddd-0bcf-08d903d7c262
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:39:06.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHwGnQa/mNEdt0/R061Ul58Z3qETjCXbHQGfbthlEckQxZHSol6v/VftyWo03Jirkt3rLAS2xH3OdrSE5zVXNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David / Joerg,

On 4/10/2021 5:03 PM, David Coe wrote:
> 
> The immediately obvious difference is the with the enormous count seen on mem_dte_mis on the older Ryzen 2400G. Will do some RTFM but anyone with comments and insight?
> 
> 841,689,151,202,939       amd_iommu_0/mem_dte_mis/              (33.44%)
> 
> Otherwise, all seems to running smoothly (especially for a distribution still in β). Bravo and many thanks all!

The initial hypothesis is that the issue happens only when users specify more number of events than
the available counters, which Perf will time-multiplex the events onto the counters.

Looking at the Perf and AMD IOMMU PMU multiplexing logic, it requires:
  1. Stop the counter (i.e. set CSOURCE to zero to stop counting)
  2. Save the counter value of the current event
  3. Reload the counter value of the new event (previously saved)
  4. Start the counter (i.e. set CSOURCE to count new events)

The problem here is that when the driver writes zero to CSOURCE register in step 1, this would enable power-gating,
which prevents access to the counter and result in writing/reading value in step 2 and 3.

I have found a system that reproduced this case (w/ unusually large number of count), and debug the issue further.
As a hack, I have tried skipping step 1, and it seems to eliminate this issue. However, this is logically incorrect,
and might result in inaccurate data depending on the events.

Here are the options:
1. Continue to look for workaround for this issue.
2. Find a way to disable event time-multiplexing (e.g. only limit the number of counters to 8)
    if power gating is enabled on the platform.
3. Back to the original logic where we had the pre-init check of the counter vlues, which is still the safest choice
    at the moment unless

Regards,
Suravee
