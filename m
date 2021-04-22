Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDC368738
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhDVTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:33:42 -0400
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com ([40.107.94.68]:61793
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238770AbhDVTdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:33:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0uivqi9IdjihWZdVSDXrIDMqSZYf/fMNW++meF1q4/FWGfZGvttQqO6T5I6KwdAKp9xVM0S8Yyd1gNDKrg5B/pxkdBc82IKDEbAGNjTa3y8JBfHvcTV+yCBbYTsKd3cswUio1+zCVQQFjPSLvwYh54iZ7OPkZs21+jPoTahHzHsRrCtrHI+bAj9QKxAyNV90P3MTbYEck8XnUWBOkVzWEuT7neSaUrmwieLxyi14sZw1w25JJcMjbmZhdlrQuBP7vaREWiTV3Hf76hyL6kFUo9SE2y9sO+o+RyXLVzjcqUgHloK2+3RxGUbjNHHb37iWUQ9JrAsfZDPg/xidDNneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXNUZgCumWcdj552puuJ10vZTl5ifoLKWCqKXU7c4+w=;
 b=Kc/OmohZw4jG5YydqANLkpakC1yCYZvHQ1LzWTUCD78VUa9F3U7tYpbYWNvg5s7fhUbl5Z+DOEMLhzgqTn5QBDpHqNL5tysG5+rsPd7XY+33MmCXk7oAOvgXcB+Jcose3DUd/T4MkqjJhY9ZqAlbiwZe9RfTF8NrCERy+RtLCfmwybZpMm+fCKmqm5HRwla975N35Ic0DOgHwDgsihsP0QJKlB1qDUWlqp7/qAcGDpeioqjfqXkjRlsqKNCGSDff0qf2070uFUL3HBbVDDV1e4wY2WnMsrhuiyk397zRVWNT+WrKlB7TDAiJ9+ssgGW29BLaekh2gkptVWLwBhlQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXNUZgCumWcdj552puuJ10vZTl5ifoLKWCqKXU7c4+w=;
 b=pdsXAHRYmquh5xHMFKKr2WcnLIbHnGRWXruEfTgCPNB+TkRYvIiRBGu2QNdjb8RkEKWb6mv1Qzuro6LJf4jCtxxaw8Vpv+jwOu2RhacYjs6T8VfE87z323JtMdtxZwquIAML3jjfbbEX2gHBgVs8CyfHs/+18zWHluWjwDFxMzo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Thu, 22 Apr 2021 19:32:59 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 19:32:59 +0000
Subject: Re: [v2 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210422171013.50207-1-rsaripal@amd.com>
 <20210422171013.50207-2-rsaripal@amd.com>
 <ee949efc-018c-8b70-3224-da4f24b217b6@infradead.org>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <6813af1c-6a59-47ca-ce40-939512092b09@amd.com>
Date:   Thu, 22 Apr 2021 14:32:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <ee949efc-018c-8b70-3224-da4f24b217b6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN4PR0501CA0128.namprd05.prod.outlook.com (2603:10b6:803:42::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Thu, 22 Apr 2021 19:32:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 456dabe9-e8fd-41b8-64d0-08d905c56fc3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27481253E262A73C1480AF279B469@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92acWA2y4B3h3bcsytCBB1v30GfLlQvtloLx5ty+Cs1e8JHYxTwmjXG4S91TXIOACOoJAFFNaUl6byAnngE753zX71Agp5E3Ff1Rv5lRuvruXLdY3dvU62WfrrBS4cZe2GCmK0xTzEfajVnepoFbHFPwZJONvFSQA6eK0ZimGS6tS4hOMpLS4ENNtt1OruvOEGWL7yfDMTGFzbGB5VrSmMOyzuCaVS2DB9UW4oBnbajhhgtyT/bBPAgXBk4tO/4GVmZQC3QqxDfimISy26gyTfULNl78sP7jTlBk3UwfRG5VYJFCmeTVX55KsTxQ7Xm9Wdg+cQ40XHxP37YJLvo7BujQ5eBxAkYzuvYjbWrgVxWW8XRsq6QAI58+rpc/0dFmJouAfWUcpff5IZ241ATj51mYdE3J0vVvE3U2VgpJ4lyfU/MvtGxlQgnesq19duF0N7MIv0l25dM2KOSPh3CillWXpFKUaVlmVJumleFBj1h/Ht9wUMnLNfvM71cpm1orw9GG+fN43a7lL3Vlz+Wdyx2KJPVqKiMtXlQlYvfVhGf1z6SOW5c5smcLGMIfMihuQLobQ24/4mq0A0SS76/eih/xP5Zd6rbqsfGB/cXVLiNm0NAdIqD9dPtzfKNTvXb+DeIVJqYD56yYMXiwDX/pkpPPk50FL0oHVG5s+UyMhoW7O8cc/Sr+lzd89FIR9jNH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(66556008)(4326008)(5660300002)(316002)(956004)(2616005)(110136005)(16576012)(6486002)(53546011)(31686004)(66946007)(31696002)(83380400001)(8936002)(38100700002)(26005)(16526019)(66476007)(8676002)(2906002)(478600001)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1VXbnZGaDgzNzZOWUJLWW9OVVJGWlV2YzFRRE5aRDJybmhJUUM1MmRtclpG?=
 =?utf-8?B?cWgrSkV5cVpIOXZkc3NWOWwwcjZmdzlTRnZjeVk0emNpRDZtMm0wR0syUGpv?=
 =?utf-8?B?RUcrQXozUVd3TUEyMkRwSnNPczBHTVBudGoyaUE0b1UvUmxEdEh0bGVKcUwr?=
 =?utf-8?B?UGcrRnBSWU0zdlNjS3ZpN2xlOTlBeGZxdDZsMjFvVEppb2hDR1czNHR4eTEx?=
 =?utf-8?B?dVVPMURValFheENWVWlOa2RzUjJmVXRJZ1lQZkNmWjRPMzNZdmVjdDkzMVRh?=
 =?utf-8?B?VXo5RGZ5a2xaYjdQK1JSMWtzK1A4eWUxcWFJTUZTU0QrY0xhUlZZZ1g4TU9I?=
 =?utf-8?B?YnBnSTlnQ3I4Qk5WUWZZWmlneVVLRGIwb0haSXdzNWNLei9HV3JtSmEwN2Q3?=
 =?utf-8?B?TlNZcHBPa21RQXJwZCt6WW9CRXlRNGFFSzFwb01EdTVnSzVtMWcyaUhXQVZI?=
 =?utf-8?B?Ymc3ZmFSSHA4VXB3dzlXMGpRYTZIMjA1Z2Z0VUJzM2MwTE1WRzhKZzQ5MW13?=
 =?utf-8?B?RFlLL2VwYTdRNzZnTXlobkJtN29oc21wNHdtWmFNUms0WlBadU9PMnRNd3NM?=
 =?utf-8?B?VnNtZzZGWHRnMGRsVXEwbDJqMlVMRUVoMFY0Wkw4aHdRQWpySGtlbTBQZU1z?=
 =?utf-8?B?TnBzOFM2ZFN0V2VIcDcwOTNCK21Wc0Q0V2Z4M3FQamhWUy9zUGpLM254YUFs?=
 =?utf-8?B?MEVqM2lySGhtVzV1dW80S05ZeTFTWlhoK3RNbVA5N1dhRFhPN3dtbEZIdjYy?=
 =?utf-8?B?c2U1TEw0RUdxNlQwa29yS3JoMXBIc2drcGJhMkNsQ21KaEo2Z3dtM2YvWVlR?=
 =?utf-8?B?OTFPSDVMT29NeURIYWtlbnlDbmJXVlluR0MwNklYdWE2ZVNXRkpibVczUlZx?=
 =?utf-8?B?eCtHTWFqSk9vZXFkcFpBdko4b3JwN2xIWGFoa2p3RXhyQ0FWeXM4OHRpRUxx?=
 =?utf-8?B?akNBdHl0RytLSHlnU0dYakYyRHE2MVNPYXJZYUdVc3g0bTl1S1RGVHNyL000?=
 =?utf-8?B?WmVzbEpqeTQ2RktGZElwdnZ4elBuTWpjZXlrenBidkNuUzBWTmozbVl2ekx6?=
 =?utf-8?B?aklMTCtCdHY4NmpSY0M4dENUU0tJaWJMTW55dVVtYTNiZzRVOEp6SmZtL1U5?=
 =?utf-8?B?SDB0YTBvRm9nNHpzNjZ2U3pRdHc2SmtYdXNoR09xUEFOOU1UTk9oOUY5cGRm?=
 =?utf-8?B?K3ArdXMzcE50dUlJNnFaYS9wWjNMSHZta0FvWmtHTWM5ZzdxL2c0QStQVlV6?=
 =?utf-8?B?LzN6WnF4OVlucnd5TCtFR09DanBsSHJRZHF3NjJUaUgxY3Fvc24vZnVNVEU4?=
 =?utf-8?B?ZkxCZC9IMFlYUTM3VFYwUDVXS2ZmZ3BpclpzYkZ4TFBZV011TVdZZEppV0F1?=
 =?utf-8?B?T21idlg1R05ka0ZacUZRKzRDbTVtekNtNnFSdzdIZnhUb1NYQVdvbmN6c1lu?=
 =?utf-8?B?SkJZZXhjUDY0V3d4Q2MyUFNMUzlRK0htdncvM29FSFFJaHpyNU9NUGJuUVJF?=
 =?utf-8?B?SXRLRjc5M1ZKRm5peldXT3ZteHN5TVNvNGkzaFZXK2ZiNFQ5NVlGYWFESjlK?=
 =?utf-8?B?dW5DN0tNRk1PaklMb1FRMzV3SFpiM0dud2JHRnRQQ3pyVSt4aFlwYlR6YUZG?=
 =?utf-8?B?SE5QVUE3LzRJSEVhb2VNdFAybkJNSk0zR1dQSVpJVllVaTN0eG9RWTMxdUZh?=
 =?utf-8?B?UTlaaVJIY3Bhci9iRHpnVmxabnVYdkZncStsbE81NE1vbnNKcUwzck9vdDVy?=
 =?utf-8?Q?p3VaUzQGCF++dFyBzLmmP9cBPUoeAot/2kTvKZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456dabe9-e8fd-41b8-64d0-08d905c56fc3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 19:32:59.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnppxtXD0GKkRGeDCPQe7Ps5oEMg9b25dOQp5Yo5CFZM4QFZ+Hc9pqs0JWIRdS7mpUccSbARFHmekBjb2AfaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2021 12:49 PM, Randy Dunlap wrote:
> On 4/22/21 10:10 AM, Ramakrishna Saripalli wrote:
>> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>>
>> ====================
>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/msr-index.h              |  2 ++
>>  arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
>>  4 files changed, 27 insertions(+)
> 
> as from v1:

Randy, could you clarify your comments please?. Is there something here I need to change/clarify/fix?

> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..58f6bd02385b 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3940,6 +3940,11 @@
>>  			Format: {"off"}
>>  			Disable Hardware Transactional Memory
>>  
>> +	predict_store_fwd	[X86] This option controls PSF mitigation
> 
> 	predict_store_fwd=	...
> 

OK

>> +			off - Turns on PSF mitigation.
>> +			on  - Turns off PSF mitigation.
>> +			default : on.
> 
> 			default: on.
> 

OK

>> +
>>  	preempt=	[KNL]
>>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>>  			none - Limited to cond_resched() calls
> thanks.
> 
