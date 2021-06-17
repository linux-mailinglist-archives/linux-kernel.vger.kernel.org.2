Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB23ABDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhFQUuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:50:01 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:56417
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231759AbhFQUt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkoEJF8N01815hsx1iCIh6Yr1VUeZrnsN4jzr5+12DYePa5YQFuXC5OA85mGS/56TN4srBJRvzi4Cg8daY3tWzpuVj0BEuOnQxKbW7vbrvZw9jqeMKzR8ox9KWqSwGgB2KXX2S+v/QBAZZCCiADB23hQniehEf1wOTJHmHSF2nYsSuwCW5ooVpXZiyVmIPetkv14pkXwCGBVD1yW6GDeTotrFB2sF/ouMAVm8DW2EfgT0sq5FTUwwvwXWiakdutjuuTWyQU908Is/2Gf/3HiaqgxWFO3yKAtVP0JRMxFKoeC+QoJGdsUnNM63Flfd3LPym3AEEVq+MJdi9Wt1+Fq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKE/R89VLczaBdwu+c3hPbHfGIlnoSaPzBfOBjdHmQ0=;
 b=dpkMM7V65cij+ogr8V/GG2KRHPtsdRQnWuvxyfx0wafKHmVbULGMC3xX3EOr62VmKdeK33Bn7icNo0vbLTrqX2FSHSqtTlSluUZMPZra8RhXKYTI5DFbv/rCMnzG+kaPSeU7B3t/0AfXPwOl8n0GQErJfFbzhsKCSpnbJN2/S88L4n182u2UFIR4xpx2VlsC0NfYJnvbnshSE38fNqKASvL25y8JamW+brIfc4IL+bfEjdV7whakp0KEGpbuiPdry3W9aa+jJmPy/3YYRC9urZQeVRiBeHBHioHSdTBr3PEyplIhfvR5wVZCCuqmAMokua4waOAAdwMz5VftvhWbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKE/R89VLczaBdwu+c3hPbHfGIlnoSaPzBfOBjdHmQ0=;
 b=zlyzyHrBMAijfEWahsOYlSNzgT/s8vAM+qcIHUTawJ/kuMsRPjXGY9bfp0reuSiCbGI22zubK21a1qSEcFDYBKOm1pgQK0tOTVIsk/l7TPLVe3QpFW3gnLNs58DwPlNTpecT5I0PO3/qdEAhvhPCvMIhgql5AovD1plzR/Vuy08=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15; Thu, 17 Jun 2021 20:47:48 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::158f:c9d0:60ea:438c]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::158f:c9d0:60ea:438c%7]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 20:47:48 +0000
Subject: Re: [v6 0/1] Introduce support for PSF control.
To:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     bsd@redhat.com
References: <20210517220059.6452-1-rsaripal@amd.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <7b952b4c-de69-080b-477c-44d2f973fea6@amd.com>
Date:   Thu, 17 Jun 2021 15:47:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210517220059.6452-1-rsaripal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN6PR05CA0018.namprd05.prod.outlook.com (2603:10b6:805:de::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 20:47:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85757150-be4f-4e31-5f58-08d931d12aa9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4138C4796EAFA9C0FD7297B09B0E9@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6QhaeX5dz0sI8dNgmr5wMkrFIcXxmsf4FpsK5dBY5cwB1LBvjETvwyRir3nWU8RQQHQ8DZ44+c128QijY/P5S8uPA07oajUcbWjBI3oYpTDyhLKgHZVpmHjDS3O3Xr4NmEWZ4l/Fw86Lv/sDSu+z8FkABQAj2v6w35AlQXbMSTklKckJbiSvJFHc73fsH4KB6F2GCqnRf1nLtkgqg8bzJK7AU+o1Cn3nFYlWzranfVzM4Tg2qpwJBKuYCECXzPqTq9RXw2kDoDS2Ix37DtV0/xV51yEfUld9Du0GyPu+smodylg2Eo1cBlxjhejOpB8aB69CiD0Oji2iB8yFAEfjCiifJqQZhcuYw8oOeD03RmaJBxSHDjj9cELDNnC3gZ2fGxbELMApG51P+XyVpTzAn9lfMmY5MRvNpmBXdnxx4v9TAAPMB24tn3qkFUc1Yb5i7TXLkmyTAnyOvSiV1S/uN0CCK/MPtPOewPKIJxZ3NwjvMAlvcbyPZAXPe8JT1WOBDA8hc+dU5H2qMAKWOZ9NUBykKFJ0A4v1an31dL1DRWNLVd+cyzAdukLn5W8+RStGPKQiYhqj77pA662YDbjzWxn44x7PwLwznxfnOa5R2f3fvbhdyav7owr1ybx6d+yWA8OHjN1tnZ+WqpW39zqIuPHWBfC0DYbojIqRi5NVWespk3une83ct09AsAa6n/30398hNACk26Lbb2Rse+0fNBFpfbgrPTq7WuR3afWyJNenU6pSB91DOrL2dKXR4vhLgl79xeKHFECG9WQ1fbxF/kxD223fL/IZNBphOQR1tvbJBgAIAP00KR5IjCL5r/w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(83380400001)(8676002)(2616005)(478600001)(36756003)(956004)(966005)(38100700002)(186003)(4326008)(31696002)(53546011)(16526019)(66476007)(66556008)(6486002)(31686004)(16576012)(66946007)(316002)(8936002)(5660300002)(2906002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGo5YlNRZTBTSjIxQkdHd2tBQzFWWmpBai9mMUZFZGJtUENGclF4YmdjQVIv?=
 =?utf-8?B?b0FpNlYxMFozYjNwS2JlVTY0ck0rWjQ1bU04OThqRWFDTFBjM1lwYVVEczVx?=
 =?utf-8?B?ZHJUY01IMGpoZFdZSlZZb1k4bTNzZWtmVUJ5MnpLbnpJUkdvU0FSNWRVYnkz?=
 =?utf-8?B?cSsxWDNmdldQTkYwa3N6M0NzUzM2V3Q2UlhFd1dyb3pTN25oWWpZa3lIS3Q2?=
 =?utf-8?B?V2hLekhrOXlKalBmamdRdWRDbXVpcWNHc3NzYTJMREJQZ2dQOHFOQzJYbzZu?=
 =?utf-8?B?UDZCSytxenhWUm5rSWx4bkRhUmJDd2wzU0FkMWtUT1NpVkZmN2lhOHRyZ1Vw?=
 =?utf-8?B?UmwwSDN0bWoxRFlGc3phbVFLZVptZ0g5cWd1RC9aeGh1Q0NZak1jTWxhTm5W?=
 =?utf-8?B?YUxTSGh3ZTNxQmJySVJlRDdSZGkydVZpbVJ0eHl2amZGcHhXOCtUUEdTd215?=
 =?utf-8?B?RmZ6WnE5bVI0bFBZbjhnbXFFaWt3bXdZRjdzYU0yVkJmandtRC9lNW1OYmhk?=
 =?utf-8?B?VkgyUkxEc3QvdEpxaVVaWUNFVStwUnBMUEJCS09VSG9YcVBIam5qVE5POGIy?=
 =?utf-8?B?TGhsRW1jeXp5K0tmSjN0cGlnYytDYkVzSDY2a2c5SCtXT1d1cU5lY2trQnho?=
 =?utf-8?B?MDhjWXNNamFXaTUzK2UzdDZtNHpQS05qVlhzN3pTcnhvVmJyNjI4Q2JBTUJu?=
 =?utf-8?B?Sm4xV3I4cmI4dGo2U1N0Ni9vSDBvaXVFYkRoQVFQYkY1UjVZb1JYKzdqYVov?=
 =?utf-8?B?REZwc1FlTXVwdXU0SElRc1BYRDN2RnRlTFp3a3hzUzZubWdoZDUwbDNHYVND?=
 =?utf-8?B?MDBJblhVYmJoTU9TcXRxY3lIM082Vm53ZUNxVU9yUFNTeFRKdDNxNWRVZWw5?=
 =?utf-8?B?bTVIQnFwMWRwU29PK2xPR0J0S29Oc2UwUTlieDFqc0hDekVOSUZac0s2b0pV?=
 =?utf-8?B?a3N3YmNueWZlR0s3ejJaQmZKZFFBSjZjUWJ5NE1xN25VOERXUnBha0ZOUXBF?=
 =?utf-8?B?TDM5eHkzYi9nbk1Odm5UT1cvV0Z6dWNPTm10dkdQNzZrb0pLdmIxdWh4ZUtU?=
 =?utf-8?B?OS9vV21tUXd3RmZvUm9Tc3hMSUEzdGpRaElhU09uQTRFQ3JoMnRQNGlBWTNY?=
 =?utf-8?B?emFUMXZMcys2TkdKMjh5N084Q2t6RnM3VFl3NlQ4bFROZzdxYlp2M2IweG4r?=
 =?utf-8?B?QmpvOXlHVFdQOXQvOExsS1dhWjN4TzFYRjBsdWVxZzdiYkVCN2xxc0xWdm10?=
 =?utf-8?B?aDd1YXBsY3FQcjBLeG9BVmRUejBEREZsZkllQkVSSkNJK3ZZQ3ZqTHcrdUgw?=
 =?utf-8?B?Z2poOGFGRHlsTklyd2QwMEZOTE1lWWlYWWYvbSs1ZGtmQ3RRV0ZaSktxWDVw?=
 =?utf-8?B?QTFmcXNXNzFKRDltWm9JWGJPYSt4SSt5aDhxY2JYa0p3RU1yNjRLY2x2Zmd4?=
 =?utf-8?B?T1VPbzd4cVR5dzhDa0M3VmVOTThGSTVIelorR0o1QWJTRFhpOVQyRTZmaWN1?=
 =?utf-8?B?aFpTUzM2VjRhdkZwejcxMy9GbDVyQTZtMDFZZWxZcFBNOE55QVNWK1ZTMUxL?=
 =?utf-8?B?QkRNZTA5eE9xVU16ckhFV0dBNWxLS2FTYTZCOVdSczJwckpEbjNtZUZaTzI4?=
 =?utf-8?B?UWw3cTMyRm9ISENPVjlFbWhLQUpCL2JWSUMxNjFGSllKdG9VL3NVT1hZekNL?=
 =?utf-8?B?U1lBZlhnT1MyNnBTaHZuV3h3ZkUybG41bllvSXA3S1lPSHBOVlhPWFhaeERl?=
 =?utf-8?Q?OewaalRtD5twGBhQC6T7GTUQURtWZoCnWm9azxY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85757150-be4f-4e31-5f58-08d931d12aa9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 20:47:48.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jzc3BVhFZ09kKwUH4gcrjIy/PdS/Krg2IjiqX3aU9wrwqgJJHIZYi3Fke1YHT1Me9Jh9wfscRK7Bf1YVws/5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2021 5:00 PM, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> 
> Predictive Store Forwarding:
> AMD Zen3 processors feature a new technology called
> Predictive Store Forwarding (PSF).
> 
> https://www.amd.com/system/files/documents/security-analysis-predictive-store-forwarding.pdf
> 
> PSF is a hardware-based micro-architectural optimization designed
> to improve the performance of code execution by predicting address
> dependencies between loads and stores.
> 
> How PSF works:
> 
> It is very common for a CPU to execute a load instruction to an address
> that was recently written by a store. Modern CPUs implement a technique
> known as Store-To-Load-Forwarding (STLF) to improve performance in such
> cases. With STLF, data from the store is forwarded directly to the load
> without having to wait for it to be written to memory. In a typical CPU,
> STLF occurs after the address of both the load and store are calculated
> and determined to match.
> 
> PSF expands on this by speculating on the relationship between loads and
> stores without waiting for the address calculation to complete. With PSF,
> the CPU learns over time the relationship between loads and stores.
> If STLF typically occurs between a particular store and load, the CPU will
> remember this.
> 
> In typical code, PSF provides a performance benefit by speculating on
> the load result and allowing later instructions to begin execution
> sooner than they otherwise would be able to.
> 
> Causes of Incorrect PSF:
> 
> Incorrect PSF predictions can occur due to two reasons.
> 
> First, it is possible that the store/load pair had a dependency for a
> while but later stops having a dependency.  This can occur if the address
> of either the store or load changes during the execution of the program.
> 
> The second source of incorrect PSF predictions can occur if there is an
> alias in the PSF predictor structure.  The PSF predictor tracks
> store-load pairs based on portions of their RIP. It is possible that a
> store-load pair which does have a dependency may alias in the predictor
> with another store-load pair which does not.
> 
> This can result in incorrect speculation when the second store/load pair
> is executed.
> 
> Security Analysis:
> 
> Previous research has shown that when CPUs speculate on non-architectural
> paths it can lead to the potential of side channel attacks.
> In particular, programs that implement isolation, also known as
> ‘sandboxing’, entirely in software may need to be concerned with incorrect
> CPU speculation as they can occur due to bad PSF predictions.
> 
> Because PSF speculation is limited to the current program context,
> the impact of bad PSF speculation is very similar to that of
> Speculative Store Bypass (Spectre v4)
> 
> Predictive Store Forwarding controls:
> There are two hardware control bits which influence the PSF feature:
> - MSR 48h bit 2 – Speculative Store Bypass (SSBD)
> - MSR 48h bit 7 – Predictive Store Forwarding Disable (PSFD)
> 
> The PSF feature is disabled if either of these bits are set.  These bits
> are controllable on a per-thread basis in an SMT system. By default, both
> SSBD and PSFD are 0 meaning that the speculation features are enabled.
> 
> While the SSBD bit disables PSF and speculative store bypass, PSFD only
> disables PSF.
> 
> PSFD may be desirable for software which is concerned with the
> speculative behavior of PSF but desires a smaller performance impact than
> setting SSBD.
> 
> Support for PSFD is indicated in CPUID Fn8000_0008 EBX[28].
> All processors that support PSF will also support PSFD.
> 
> ChangeLogs:
>     V6->V5:
>     	  Moved PSF control code to arch/x86/kernel/cpu/bugs.c
>     	      PSF mitigation is similar to spec_control_bypass mitigation.
>     	  PSF mitigation has only ON and OFF controls.
>     	  Kernel parameter changed to predictive_store_fwd_disable.
>     V5->V4:
>           Replaced rdmsrl and wrmsrl for setting SPEC_CTRL_PSFD with 
>              a single call to msr_set_bit.
>           Removed temporary variable to read and write the MSR
>     V4->V3:
>      	  Write to MSR_IA32_SPEC_CTRL properly
>      	     Read MSR, modify PSFD bit based on kernel parameter and
>      	     write back to MSR.
>      	     
> 	     Changes made in psf_cmdline() and check_bugs().
>     V3->V2:
>           Set the X86_FEATURE_SPEC_CTRL_MSR cap in boot cpu caps.
>           Fix kernel documentation for the kernel parameter.
>           Rename PSF to a control instead of mitigation.
> 
>     V1->V2:
>         - Smashed multiple commits into one commit.
>         - Rename PSF to a control instead of mitigation.
> 
>     V1:
>         - Initial patchset.
>         - Kernel parameter controls enable and disable of PSF.
> 
> 
> 

Gentle ping. Any more concerns or feedback with this patch series?.
Thanks,
RK
> 
> Ramakrishna Saripalli (1):
>   x86/bugs: Implement mitigation for Predictive Store Forwarding
> 
>  .../admin-guide/kernel-parameters.txt         |  5 +
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/msr-index.h              |  2 +
>  arch/x86/include/asm/nospec-branch.h          |  6 ++
>  arch/x86/kernel/cpu/bugs.c                    | 94 +++++++++++++++++++
>  5 files changed, 108 insertions(+)
> 
> 
> base-commit: 0e16f466004d7f04296b9676a712a32a12367d1f
> 
