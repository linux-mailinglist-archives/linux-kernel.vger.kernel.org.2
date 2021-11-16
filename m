Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC3453806
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhKPQtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:49:39 -0500
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:3104
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234638AbhKPQti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:49:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEN4zDVquybZA+QtxKaudED5Gvo/sVunpMmt8r5pOKffDJJX74zEW+g40mdxTJGvEpzvopF5m7QCx6smF2q8ssHIhVsfUutXfre4iMfvdunHFHM8JNq6Foz5P5ug+/KzqzakSV1uQVh2z+L7Eqa/ACikGz+fn6C1YVpEtTPagUt+2tilLj2e2y8NY6kNX4vh2+QAKk6yzl64nuHQJ31GqpzcDSAsOqQR4HTND1GZLYB2Sv42ZAu3kjCxS1vbhRBTSXF/cuFnp0+FvmskG5Or/I4MDWaz0LI3vJedrAj2Y4UgTcjniBG15zMeCVRBZs8mbdI4QsgnvVFL5RStIJDSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYn5LlKy24RCX6iwfqgJFDGYGpcDrCyB0lnL5D/oSLE=;
 b=PC8/CbddUVlgn/gAIH5oJfQH8WKVZbJ1j3CNH81sE8JH5p4iIjXqstNXud5vpWgvZgDvHgn2oOnvdZAmUOyt6yDGcoG5JFTqxxfJmetP9Jl0uOLt5Pt5ZiYtxqcgfoga82YhaQvUB5cLxMt4ohooqnFALI60ooPL+MUTOwjyBlZyRgJIrlZ35dXK6YCvF5hoVYSpHvcYxQfIe31pOqypXbw+7dCL42F4K/ES2UHiwcFevSzYaQ/WMnRqlnVahCEi7eN2HFANEbULc1wdqjeWU6VnTtzX5ztJkwwlkPVR9lkjKBEzn3gI7c/jkbzb6TNrdm7A3z6u65G+INMd06R/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYn5LlKy24RCX6iwfqgJFDGYGpcDrCyB0lnL5D/oSLE=;
 b=AJvmqbd8vxPapoG7P0WmQ/FXLp17W6fPUDrZYHFaTGRwGW1SsYmH5TVnl/a+3VzDNDGh7OH1IzVjcIts6+wubfLYV/c5lgjC4zmtFEUrFeNW2dorA9v2dnaiPZ+mtm56OtM7IKAfPRECT8PsHU/AlFOA35SuELYHWI6tkq9oZas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR12MB1843.namprd12.prod.outlook.com (2603:10b6:404:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 16:46:33 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 16:46:33 +0000
Message-ID: <689f7b71-32b8-ba0e-22ff-c2248662b1e1@amd.com>
Date:   Tue, 16 Nov 2021 10:46:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 11/13] perf tools: improve IBS error handling
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-12-eranian@google.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20211111084415.663951-12-eranian@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:207:3c::37) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by BL0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:207:3c::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 16 Nov 2021 16:46:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3642512-dac4-4373-39b5-08d9a920a5bc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1843:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1843277A90D0A3B30187FAFE87999@BN6PR12MB1843.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lczT4DnZvEf2uqWym6PTVt9vUzL8yqOu/l4mengbPfLS6jl4dEBDafKn1gtSDj6GB3huWYkFtx37d/phBZVoaGGAFvWikCoaOlTHKMQO+5HQ743cBYqajXf9xTexBjDU67pAjvPme/e4uGEqYbAEPaBUAmHrVfpFgd+1NwHhwYOed53UOAlM8Angsay6wEqFc8YHlCzYKiZJqAahDgpLODRtpRzNbdLkdPjYy7qBUW3b6VOPR5EuVdexErkCA+CHBhAVbtmAnjF+qOAsgo/SINyotPScgIckX/GDYfbbS7eMfcV12pTIZt4Elb1NMLCtj+9/A+ylekH8cxbwp1/bBWqii6EI8koMbniVKFt0DAzHeW/kLmwxA7B+5y8Z98e/mI1b28STt/cYcC/MfV6ZANoLmFSnARPf3TMDxRYFHsIj2gnIMPMZpc2IxciyMyyJnxUn2TYfHGP5RhT0tLlIx7/9/TIMRP+chXS0Y7M6/Hg+TTGSuKN9FxJkk2wSVQmMgps2RMiZI+Hyg2tCXqpDF/yU+zYxvrvOhf5ArB0+cGW5xPqwld0xJVnWyThwbT8mEpMsPfbQTbUc4C4O+hOAFZQmKo5+D0CX4wEof1HiOzQ1CsntkDdrYHOnW7X5w4xetcNtERIfJdrg2OvR4gb15YWljyPxG07QNpD69C8wGOXoSCPUx7S4reawAItfrmMzCUDn2Dc1sv5rJMqsBi3T+FFXIRQSmAGmQ0r7yIyREN2kDlTxt8JmQkv6oBsofe2wfOqoTMvWDCAxKfl7LAO1dJ5wocXPg8JVIhphhWleDugKF1sbI/2wSP/DiwCPJ1zXuW/iUUvVfO2RJtXmaPh5W8yVpzWsbr5TIOliDWj4drKmihnYmtdQKdyggvDnV4Hc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4326008)(86362001)(53546011)(31686004)(6486002)(36756003)(8936002)(8676002)(16576012)(4744005)(26005)(2906002)(44832011)(66946007)(83380400001)(316002)(508600001)(186003)(66476007)(66556008)(2616005)(31696002)(956004)(38100700002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVQwYmVyUEdBT3g5angrNkV6MUMxZGJva3kzaWVJZlQ4a0pmQWloRG81RHVB?=
 =?utf-8?B?L0dlUjZldGFmOHhDajJaVFU2VEc1T3VxcVFGWkMxU3NEV0Z5Rk1hUFlhM25n?=
 =?utf-8?B?VkpKWm1jUURodFNwRzdtRlQ0aXZ5R0dTNU5MQTJvRXRlbmtPWHBnN2MzR1Y5?=
 =?utf-8?B?eDRHR2xvZkpFdjhReWtnV2lNSHFwMU4yYk1BRCtLL3RzTWxsak5saW9DaE82?=
 =?utf-8?B?M2h4dXJQbXpHMkxoS0xhRlB5RTdGenRFK3ZyUGkvSEx5alBqcFJGSjVqUDV5?=
 =?utf-8?B?bVhMMEoxc2tIQW80c3F6emovYkloVDdnVGp6NXhFMXFpWXNmYWNWOGxvQTc0?=
 =?utf-8?B?aXhUL0tKVnQ0d1RWSWlKV2taKzRCVHdTSjg3RVp0M2E2c0s0YXorRTJMZGp0?=
 =?utf-8?B?eG9RZm8vL0dZZExjWWRtbDRIQndNNTNub0NWWCtyMTFXeHA1amJwRkZ2QlpY?=
 =?utf-8?B?a2hubDFHRzArWjN2WDFTeVhxSXd4WERCd0RteThlRlV1Tms0VmV2VmovUkMr?=
 =?utf-8?B?cEN2TUtQWWN5a3ozcnh5UmNBeDNLR0o5ZDQvUFQ1M3l6L3JNei8xbEFkZzA5?=
 =?utf-8?B?eU1leW1lSUliL2NKbzZsY3hueURlVnVjeXNLRTRIZVQxS2lMVjltbFhYaWxa?=
 =?utf-8?B?MkJIaGRhV2dOZFhtazlBT1pzK3ZtV3BxVWI3RHJKOW0vNDA2WDNRNm9tYXdv?=
 =?utf-8?B?QnpnK09NVVlzbHNCN25obTBnSmd2b2FaWHdiNE5LWTE1ZjVkVUxaamxwT29C?=
 =?utf-8?B?R0RxUCtNUG4rczN5dmNKVEQrY1pMaXJja2RuTzVkbENQbEJaMDBTWUtLRkFT?=
 =?utf-8?B?WGhFeEdUYWk3VUNwWklWMXIzUm5vMC81Y1daYkxRMkpQeVZkKzVaK3M3SGxQ?=
 =?utf-8?B?dmVOZ2I5dWRGMGpzL1lrd0ZVNm1tdFhJQS9Fd3BURlJXVk1YQkkza3A0bEdy?=
 =?utf-8?B?TXl5YkRBSmFtMUl5Ung0M2MrYlZxL2dHbE11MlJXR3JJc210d2NaZ0hoQkxm?=
 =?utf-8?B?UC9sd1BjWVdGaHBnUW40Q1UwMWt2QjM1NEF0ZzNQOFZaUmFCbFlnSDJNald5?=
 =?utf-8?B?SmM1ZS9SVGVmb0MvZmdLVVNHYlVrSitiNit2b3p0akxRR25oOGxWZVQyTzIz?=
 =?utf-8?B?Q1oyWEF6eTRyZzlOS1M4cTdKVlZMNWxPUkI1b01wM0krM21sZWh0eFlVQUlv?=
 =?utf-8?B?VDR2b2w1bFRicUZMRlZid3M4SE0rNEZoZ0htL3hEZGxTL3hUTkNaeEhTMFZK?=
 =?utf-8?B?cmRhcWxkTXIyOUZHMkFHdnRXNElrbnZJRUthdlk2a2lyS3FTSnU5emcxTSti?=
 =?utf-8?B?ek9DMWZJSm9vWUVmQXBxY043V0NXWFJmTkRJUG44V2o2cHU3MVg1bTBzdDRu?=
 =?utf-8?B?SkRZSjlBUXhkb3Y5dVlYc3A0dHpPS1dsZ0poaWpDK1lNcHdsdUxJLzZLVmVw?=
 =?utf-8?B?aVJOcUhFdEJ5R3JaM2s0YldtT1dPTzNoNE5OOGtqc3JVb0lPSkZPK3ZsclZ1?=
 =?utf-8?B?MEZRbFhGdk1TSXJTUmVqSFViZG9xVldUTVRJM21JMnlVK2ZVd0Z3dldONmNV?=
 =?utf-8?B?YjE4NGx5UklFMzE4T2hLdjRlbE83Skc2UC8ydVUzdFN2bGRwcFZvUmF1OUtm?=
 =?utf-8?B?VGo5L0gwN2lGTmRUL21FMUxpUUxXdStFZDlmT0FWSWdOckVIbHkrMjViUFJG?=
 =?utf-8?B?YVIwOERIOVZ0Wk9hb3RWYjV4TFlFNmpsNWxCQ2MrblFIdytLU2ExYWFMbUpw?=
 =?utf-8?B?MHJ6VW9KODFmTHh2YW0wZERMTFhjWFYxWG5rYmt6MnNRYk1jZGhhS3FWZ09z?=
 =?utf-8?B?TFhxSGoxT3NaU09UQzVtbVJ3b3BsaXVBUXBocVpHbDhtWGpYdzgxbDNpL21D?=
 =?utf-8?B?RFB5K3RvOUF4Y1JudmovQTc1czJkUU1XQUdpZ0NlMVp5Vk5zUGFINGltaUd1?=
 =?utf-8?B?TE4xT3NSaGs2c2ZtNTY3clpreFFQU1lndEV4WGdUelVrZ0VTdVc2NHBEOXVD?=
 =?utf-8?B?aWE4dll2RnZ4Q2JwMVpTc0VxbS9kU2NPYzhneDg5WnZ4U2VWcTNaRkRrL2x5?=
 =?utf-8?B?NURIcERHb3RIYnNOTVVpWXA1dUJWRzlDVDQxSGtqMEdnRTMxTDlWbHRsdFZQ?=
 =?utf-8?B?bWV0cnpHOG9JTjVTRm1FWlJRZlhtemRlVENhVEEvTlQ0bGM1a0RLWExKOUpD?=
 =?utf-8?Q?J2ergbZjEc0uo2Puh12eyho=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3642512-dac4-4373-39b5-08d9a920a5bc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 16:46:33.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5UP/+lbia0pM4vA7JwdbRsxxUmtcfXXt4q7ykbmRyc26tR02MSVjbe4JxwruzG74lUOK9GgIMstFGR/1jHL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 2:44 AM, Stephane Eranian wrote:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> This patch improves the error message returned on failed perf_event_open() on
> AMD when using IBS.
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---

Hi, AFAICT this v2 == v1, i.e., this patch doesn't address the comments
raised in v1:

https://lore.kernel.org/lkml/aa40b532-0e95-76c0-6c9c-a91d45bf3468@amd.com/

Arnaldo, orthogonal to this series, it'd be great if you could apply
these two patches:

https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#mc4c9c582e3816ab31af6d0187e6803de1a98ac84

Then, Stephane, you could drop this patch and in your next
version, patch 12/13 of this series would be replaced with
what's at the end of this email:

https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#m885ead1f280445357c91cce53c01217913bd017b

Thanks,

Kim
