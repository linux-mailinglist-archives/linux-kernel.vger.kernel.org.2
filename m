Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54CC35A5AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhDISXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:23:08 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:42209
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234307AbhDISXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go29SnfwFzf9m20yhpWuJYffuo1D0gOtXPbVyF+xJo+lhsTqEQRUSzpQfMYy1ey418Ly7x049cs9hyTYrd4oJ7nVOrw6bh19m5P+eCJ/wTRJIxQxHiqTTxRpIo4Ah2XaFS8zOXd5yugjuk1cwHkrRbdfH54B7HYsJUBY5VmeZYxy/2qfTfMJDcQGMg+EREcq4sX/tLQ2A9Kp9Kj7TKBZLHSKqvu0TdYyu2XfPfBWx2Bp3MCb6D1m8sI6n2856Kh66YyS+yvkqyxqwPOMv/4sQc24CDGnB0z5N7Xf1VseZvWJBudAMWlBm9oc8pFyRrSLltG34sfW7+TdGFOFtc6Z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZLGU13U8xxaHxJ5s7iTrVGbgYC1MKe2XvMY/y9w6sA=;
 b=U3HIsfA59Kt0lNn3LUSsSO7fHNcMfk5ewFq9NEuJcZcuHkzWwS/wwDxg00X4ihDr8o9aP2gBvZ0pZFYGlZKA5egf92m4XTPyHnosep/CzL9Sfbji7dg7KgdJ5rlun+s6J7TXBUeTnC7nhZdV+qeA+VG3UDMxvB0oUQpKzo/p0J91wkTbnV1wn1S84iiV2dUmdHe4qpE8YJO1TRxG8F1cjNLj5WGJqRLtvjxLbv8tsBh/Xxxy+yvIpi+FaeOW3J5egkAQT0qGkWfvroFVqiM08KNEuEvjLm5I9/jyL72R9Th3+honGmVJY8nwy7tbvkK1M2s1jeVSCro49kk+cA1auA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZLGU13U8xxaHxJ5s7iTrVGbgYC1MKe2XvMY/y9w6sA=;
 b=MBa+U7n047eYcFMyYjiAM49oqJduT1in+oM1XMxDvyZ1UuXjnWRnVqhevA4E3m4Pm1/W2ZDwYt67dIrCCnAYBSKzE5OoqdRVm2yJRQ+JL6QhvnmeLBBB83L84r5VF8MdqPSocxdo3yinYMKKSl8H2CXC4UtZRrWpbXrGPWPPJZU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB1722.namprd12.prod.outlook.com (2603:10b6:3:107::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Fri, 9 Apr 2021 18:22:52 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 18:22:52 +0000
Subject: Re: [PATCH 1/5] x86/cpufeatures: Define feature bits to support
 mitigation of PSF
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210406155004.230790-2-rsaripal@amd.com> <20210409174134.GH15567@zn.tnic>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <cc5476c9-fe4e-6b4c-d323-37b90237b32b@amd.com>
Date:   Fri, 9 Apr 2021 13:22:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210409174134.GH15567@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.231] (165.204.78.25) by SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 18:22:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2969b0a-5dfd-4944-a1ca-08d8fb847ce6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17221BDC38E51C6F0DDAD3359B739@DM5PR12MB1722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zt0g9Zp/c9BALn+GhKVwAq10nlkeEhh+ORhF5tTH6N/5ec0uYXUQkBdUxgx3hQYBEbu+lBr99Xn8Ate5Mw8On0HZBFtbbKBqxSE2d69tkc6/egAipTmlcJcCcyE0f8gVWnOqT+GGiK8RUNSaC9OgjbpytGLdFXC4NvNKHjsEz/qqb9I8geE67Eld2icMZMUDNkydKsqojCato+fpK+bUW9jVeSWLWvM/8e0uLAlEdEj7M5BrhMk67Q03SlqRLGWLCWyTlk5Qb1SBD4LFTO8Z6prmofYWP9L3FbNd4IGUA9IzfpNcvwObpRDy3mE5ZyJBJO/PjN6D+L8ZPNKThUtI2JsXbpidZr00vPVqBZPioh58QDgNmQld1udDQnmMb8Z6wEnYtf0Ghsr9o1KhDL/AfBt96RencU8xDFQ77leHeLAPq6hj0OOWe37dpOkuxs/oBDszunzbOR6Z1gYYWgPZXyONlS9Y52xwK8TM09eu7RxLpVaBKk+CeQuhp3wLm0dcerVeWDUFTNyzp7cX4YDTMMkgxIggz1z1c3JxFqGQnG/IfOhdbBqLrHC7IRH+zbj7P/QurPu6L+v74Llmvz1B+R6xcHp0DtQS+A+tOk8ei9Dxmmoiw1hCSCTG0KjiMD7du2VqipM/cacem4JrnfAy0+SHLPipTYYbGAfgAtVLlQ9ygU3ENMhN1WxihmSVP1R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(6486002)(36756003)(5660300002)(26005)(956004)(6916009)(2616005)(4326008)(31696002)(31686004)(316002)(38100700001)(2906002)(53546011)(83380400001)(16576012)(478600001)(8936002)(66946007)(8676002)(66476007)(16526019)(186003)(54906003)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bjRSRkNKZnk3cVd0OW5tMCtTSzdOaWNaakFtWVRXMk1EQ1BwS2ZNdno2SDNO?=
 =?utf-8?B?OEtHSDJ2TzlnSlh1WkljZUNpTVhOQVlJRnBXaDJ5RXVwSDd0VitWMmQ1b08r?=
 =?utf-8?B?RXhtK3hQd1pod0piUmxOSFBoRThRZ2thdjdSUWVUY1htRmk0UThpYk0wb2FJ?=
 =?utf-8?B?TUNaUnl4STVHUDVFeDRNbkxsbU5ZYk96eFordyszanFLZlhIenN6ZW9OWjMy?=
 =?utf-8?B?dE05b2FxeDBQeUIrT1oxTWpZemswVExNZG0zMUcwWUpVMjZSK2E3aFlKWGQ0?=
 =?utf-8?B?TTBSWkxBbGVmd1MyS2dGMS9VMjA5dnNJU0MwWk43NFgwZnovcmJYVEQ0bE5I?=
 =?utf-8?B?T09nV0V5TUtleHNkS3FjU0ZXMnFiS3A0R1ZIakpCOXV3RVdOWW9LeG1LbGxO?=
 =?utf-8?B?NEU2TkhCOElFUmtsTFZWY2YzdVRDQ1FWdnBiSk5VOXVkQVN3cU9waVoyVHZn?=
 =?utf-8?B?Nmt1NzVMTGVDekVMaDFIbVNNbndVOTA4dDJqa2F6b0l6dWtPVzNxS2lSbmlJ?=
 =?utf-8?B?UXVKeUUrVWNqa2c2UDFkUWNERkNvb3pCdkxHMlNzdzE2d21DOUNDKzRsUjkr?=
 =?utf-8?B?VUc5QXA0NTQ2dG1NZVl2U0hDQzZLTVFFRzVnTmsyNG9DL3ZtY01mWHpkYkVC?=
 =?utf-8?B?ZnMxa2hKaVRYMFA2S1R1bEFHN21FdDh6WUVVWTk4ckYvazdLR3g0c3RBWnFB?=
 =?utf-8?B?c0lBNTJ2b05EOVNHM2wxZ1pUUk1NM0QwZVdHSHljeHRzWjdjRkFSLzJONHBO?=
 =?utf-8?B?M2Z0dnJuSmpERVdOeW5qSmRzbXVZN21DbExRWWgycjNaaWRybkJBNjNHUVd5?=
 =?utf-8?B?WXhrMUxtTjN2SEgzanpPLzVjY0hMZXZ4dVd2Nm9XdHRVQXltNGloU1ZqRy9k?=
 =?utf-8?B?ZEVWZENzNmU0aTRMbVlyV1lHcW5ERitCOG9UTmRUVEZ1VXZRWVpBdlp5Ynh0?=
 =?utf-8?B?TGlUVytKanY1SW1yZ21XRGFaVjFXSVZwU3g4ZjA3RjZTWDFXeDhNekx2OG1R?=
 =?utf-8?B?SDVlOVVIdGlYeVcrMWNqTzllSWRTUGhrbzdEQWhYUkg1MHRtbXdueGRuZEVx?=
 =?utf-8?B?VzRkTzhQU0IvTmROK2owYUpHcVVPR3p0bVpOUmRvQjdEZEdFZlhPbXJ4ZHJv?=
 =?utf-8?B?RWZzQVJyOWpzZ1JaTkRWM1M3ZEZyY2lXRjlvM1ZzelVsQm1qenNjRG9mbDd6?=
 =?utf-8?B?UUF1bk9BbEJqSFdYYXNjR0xBdDdZOVhmVENDL3ROdmd5SUtsc0dQWTVQbm9C?=
 =?utf-8?B?VEtKNTZacmUzYTRvRlVBaWVRa25tMFBDRTJvcjRSZFFETEtoUlVWeTdWa1RL?=
 =?utf-8?B?OHNreTBDZHhHUk9aN1pGa2t5R3BaRHkvb1R3ZjJHT3VDTVF6MSsvdjdjM2Zh?=
 =?utf-8?B?QTAxRWRhS2hwOWlxRk84R1BkbHlRQmYvelNRd1pYU3gzcW44ekJjRlRKRi9G?=
 =?utf-8?B?N0V4UmZqall3RnlVZTNDYVhjenBiYXh6cmxINUZUMFVCNWlJNUtLckM5UjNk?=
 =?utf-8?B?N3J6U3FYVDlUdXY5T0ZzQlIxUnJseE5tckl6NXd1ODF0TUYya1NSKzc3ZWp2?=
 =?utf-8?B?T2dpNUpjdERRWUp6UGhScHoyYVdvby9yaFdNTkw3UGg5WS9yYU8vVEQ0cGRV?=
 =?utf-8?B?SlJZVFhzVkJTVkxrdDNpejdLcHFEdnE4MlIwN1lCaUNGSlA2TlBEQnBoUXpR?=
 =?utf-8?B?TmxOczFIRm5EUnZUSStLVkRJZmhIZGcveE00bFZJenduaVI5bjJpd1h5SHdx?=
 =?utf-8?Q?DuMSBn1+FliPSWAWwYKzK3efKFoGyZF0g+5v4EM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2969b0a-5dfd-4944-a1ca-08d8fb847ce6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 18:22:52.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6cvymHiUMGN0qT9XdXIspghHeFBLpu7TdLcgJsaQlYu/Lflww4xyakcpouAH3FeEM5dcWBdiM62YxOP0TAwgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2021 12:41 PM, Borislav Petkov wrote:
> On Tue, Apr 06, 2021 at 10:50:00AM -0500, Ramakrishna Saripalli wrote:
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index cc96e26d69f7..21e7f8d0d7d9 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -201,7 +201,7 @@
>>  #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
>>  #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
>>  #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
>> -/* FREE!                                ( 7*32+10) */
>> +#define X86_FEATURE_PSFD		( 7*32+10) /* Predictive Store Forward Disable */
> 
> You don't need this one...

Boris, I added this bit so we could detect later that PSF is supported.
But since PSF is AMD specific for now, I guess I will go along with your suggestions.
> 
>>  #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
>>  #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
>>  #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
>> @@ -309,6 +309,7 @@
>>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
>> +#define X86_FEATURE_AMD_PSFD		(13*32+28) /* "" Predictive Store Forward Disable */
> 
> ... when you have this one. And this one is AMD-specific so you can just
> as well call it X86_FEATURE_PSFD and remove the "".
Ok
> 
>>  
>>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
>> @@ -428,5 +429,6 @@
>>  #define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
>>  #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
>>  #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
>> +#define X86_BUG_PSF			X86_BUG(25) /* CPU is affected by Predictive Store Forwarding attack */
> 
> And I think you don't need this one either if we do a "light" controls
> thing but lemme look at the rest first.
> 
Ok.
> Thx.
> 
