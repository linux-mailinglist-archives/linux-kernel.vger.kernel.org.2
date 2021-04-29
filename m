Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43F236EBC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbhD2OCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:02:03 -0400
Received: from mail-dm3nam07on2074.outbound.protection.outlook.com ([40.107.95.74]:59041
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234147AbhD2OCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6OkOxf4sbIbOR6IKqxTZzKT0Z71IS5W7yZcljlpOnHvhFc3UaDFUbH+TVJjhAhqvqiFCCRWN+nzSALzMhZGvxav9IcMMN+H0wKg+IbTcDNX6qiZRmMbEM7HxRZk9Cj75If5Z+fRJgvBFripcPT6wvQhi+xIpoNuOzA6WWLO4DdKJjEaBkNZI2h1T2ygbDLIUW8FP3SPrrQUU4t4ogcEonXqysQIQHYhlb1dwlu2tbJjGSaHZnWxiw5tGugj6TpzN2uWA+V5/RV5GU4Hg0VAXDg0/fo4TmL7u4sMvc3gOh3yCPJ9H3C76hrVIYxMVc2T3197wsn5F4mp5GKO4BcPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKTtQbonuAtYQh5YB2qsrLtzNIycJhSlWnj9/AcmeuU=;
 b=e/bQG5yF2LaVVz+PebwoQNyHIfGA6ixWXbVlMcCKcIhfifWminAuh/v1N267HQRKx4JTOL4qtNZh8MrR8Wespa0j52TLH+BuvXwXQ72pT4AYnLIX0A2rGootkGrIDkH0O35qVPejsPuTalxw6fHCEBdBZcaWeDKm/ypU2Puc2UDyZEMZLsB7cvI9B4KZNyU84t06CScU35BxT2hbJ5uCewDAh1+7idqExV6MinixP2b6Z9x84tq3aNqaJ0x6wjBb2uhjOVSw70odsgwB7di53tvisGRsf6huw/lsHRhwYXezN+1A3TR0SwwTUBhJQMzzcJSd167EJp/lM/soHxMzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKTtQbonuAtYQh5YB2qsrLtzNIycJhSlWnj9/AcmeuU=;
 b=y2udc1YFlqKORpXz1CBO6bdoVuSCviOemF3dl96BwHPL0tIoyJRI21geuYrRf1aoo9n5DH3D/TIa3X/QjRbFWgaNeBD01lauF+U5kvd3Dezy9h4EDN+++CrEOPGrTtNUmSw0PU5RfvbbPRhhCAa5EklK6fGDk+yrNEJ2bkWWy+8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Thu, 29 Apr 2021 14:01:12 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 14:01:12 +0000
Subject: Re: [v3 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Reiji Watanabe <reijiw@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210428160349.158774-1-rsaripal@amd.com>
 <20210428160349.158774-2-rsaripal@amd.com>
 <CAAeT=FyqjYqcUBRtvCiHv5sUN34kdi7kTfbfUfHZ6jR0tve+Og@mail.gmail.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <84eddb82-7626-c1e0-78b3-a92b5039e011@amd.com>
Date:   Thu, 29 Apr 2021 09:01:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAAeT=FyqjYqcUBRtvCiHv5sUN34kdi7kTfbfUfHZ6jR0tve+Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN7PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:806:122::10) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.9.26] (165.204.77.11) by SN7PR04CA0095.namprd04.prod.outlook.com (2603:10b6:806:122::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.31 via Frontend Transport; Thu, 29 Apr 2021 14:01:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5160bb47-c2e5-47ab-5807-08d90b173ef0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4139:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4139F4D79E5DBE0EA8FAADDF9B5F9@DM6PR12MB4139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rClveXTj0AZIsR0USWxbK/m2TW7szVqZ1HhEY/lkGIYHSah9BsAQIKrbjfM6MkkXjwFls1u+0hpOTAsIWmjcaObNBgElVlMENMFK1iaXwrRQLZVAIz5SgYw8uv8POAYKV5bNWOTtO1ihV4RnhiwY+IfkwDkrDba0437BJ0pFDOlznX9RC4CiMe5oxpPOqxvGyXaPVB5JnTASDiaMqh41Di5kXSquikLBA6jTl2jBBIBKWSyWNNgMOswpx1TQ+CJ7JuE74D7D+MH10sUxzBktvyGkmDIfYLJP9eVVBXzE4BMj4Rff3+SBdeCDBCQ2G9/gdwCXalohp7IX6ZDnNL+Ea5IaugFixQ7+qbmNBkwf3B7w3yHziCWyt4P5Sp94jO+TCtjSESvSOr7nXKqX8i/1Kfh4pKwvwUqYy4nk+D1eX3xV3ahiVH7RAyKwUjy9/0b1vYipyT69gs/9y1pfNrdXne+tefZTe2IG91zaRjsHrjynhJbHfGWKXGS+92zS0H3Z3jOTQhTuWkWCNJH26J0O/YCUHnOp9UnZTysAEfW8KuSKkHgbL7z2AZQEFI9Mk92wcRUOClXJ92e9EYiiMApGpMjxXNXLeIJ0Zrv2ccc4MzMC+AdO6nXXr3oFCMQB6EzOsa/8HNoSpbAzo6mtmoVFYHxQqesgjWBQJ0P+4lJ5VoiDY5suuer96YBoKEaVlG9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(66946007)(16576012)(186003)(8936002)(16526019)(4326008)(478600001)(316002)(26005)(66556008)(31686004)(956004)(2616005)(36756003)(66476007)(6486002)(83380400001)(38100700002)(31696002)(5660300002)(53546011)(6916009)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1hERkF0UHBOVUpxb0VNZnpyZHl5eU5GNllkUDRxWEcxNlkyZ1pKa2F2TmRk?=
 =?utf-8?B?SGtmOHU5d2pQU09SNVN3bmVOSTFZcEE3V1dPY1YvaWZKR1BFcjUxL0YreXdW?=
 =?utf-8?B?K2dsdWN6NEtwUDNJM3hKend0K094Uzc0U3ZPUzRadys0NitqdlloU1N6dEd5?=
 =?utf-8?B?a2ZwQlBXWmZ1TURZRTlWekdSTWs2OFRTM0pWTUFtYm5uRmdHbGtKK2hVY243?=
 =?utf-8?B?aUZLdnBaT2haTHppN2QxQm0xMGRoSEFiWnN2NEtINExHam1uam4xTEhGL0RY?=
 =?utf-8?B?VXV3Q1pSUzFqUXhsK0Zzb3JKaFFXRTlVVWI5SUtsR0drSW5xR0FiRmMwQTBO?=
 =?utf-8?B?cGl4dk1hYmRSRW9vL2xjc1ZpY09uUHE4V0RnS3FMNWI5cGpaMzhibE53cjRM?=
 =?utf-8?B?TXdFK3RJTW1OczZ0NE9nSE9Ja1FlV2xXNGd5M0U4dWNSZWpZTjVkS0ZsN1FR?=
 =?utf-8?B?K2ZnWVU5OUdVc05tNW04YlVjWnhlR29yMEhCbUY1ZU9GTXRPd0IyK0wvVGtC?=
 =?utf-8?B?MHlydVU5Q3RnRWducGFFSUhNTGRlVlVEU3hkYnBJUFc1UHRKcUYxU2lqZW5V?=
 =?utf-8?B?V3hyQzNZeW1mWDNJRVhMNnBzZSs1YmF2ZU1TRUJ4VTl3bG1NcjhtQkY0T2Nr?=
 =?utf-8?B?QnAzWmJtRk0zNFNoaVV2M0xlaVEyUHBOT0lhZjE2TFRQK0ZEYVBOZ05aOEdE?=
 =?utf-8?B?TXlwZ3hVdGJjQUlPWkVhbDRuV0lEejFWV21hMnBEaDAxTGNZeG9lN2xBN28z?=
 =?utf-8?B?Q3hSL0xtWEFuWVFRMjJjRG8yS2ZIeHA3bHpzM2VtOEVnSDUwYW9xYmpQOHdt?=
 =?utf-8?B?RkhVTWJaazUzYmExTDJZaEVQOEpZZE5UQ012dHc4VlVNZXY0c0RxdHJYdU8v?=
 =?utf-8?B?S2dTSjJMVzBzczh2eVQ2dDEvZlRFM0Y5c2RBRFlMSE5oNjNGc1cwMGdSUC85?=
 =?utf-8?B?TXJvcmpZb1RUQndtcUhTd1k4MkFZV2hnZnFWYkdNTVhVL0tjOWFIaHgrOG8z?=
 =?utf-8?B?ZzJ6Q0xuQUJkOGY2YnFUN2wvNWdxMG9DWTkrclVSODF0VGxEUTVvL1lUWVRm?=
 =?utf-8?B?RWUvaDlXaElmLzF6TEJhUVVseXlReUIyS0U2Vm9oYUpmQ0xPcEpqakNyVHJh?=
 =?utf-8?B?Vm0zamsxTTY2eEorWXNjbWh5WnVxMGRSLzBtQTBMYzRtRlQyL2hrVHJXTEwz?=
 =?utf-8?B?VDlQdkJlUm92Q3VjckJxcEJOWlVJN0Nja3lGQzlTZXU3YWhpVEcwbldsZjB5?=
 =?utf-8?B?OEczNk5CT0lQcjdkNlhuRE9yTlovaWdpMHgwMTlrc2VmNXExR2pXZDlrTlBW?=
 =?utf-8?B?amFRaWxSYkY5YXpMcVNUbTBka2Z6ZlUyWWpPS2NNT0NHYmwvOG56SStOSHl4?=
 =?utf-8?B?OHJKQlI1SlBROU03WEpReTJkdnNYc1lBT2JubkFMeUUrUS9DbVExT3lDTjl4?=
 =?utf-8?B?aXJvZ093aUZVS3h4N2tsYkY4bUtoUzgzbEt4QlZTZHhGVUlZdXFrUmdGMDZZ?=
 =?utf-8?B?K2F0Z3orZWp1bVRTUGRyY1ZNVUtuRTdrcWkrKzQvK0lnMG1QSktyUE5OK2gw?=
 =?utf-8?B?ZktBN1pWbWhaSGxnVmZyTUZDUEVqa2h5T05NazJpZXk2b25LeUttM3NhSkJH?=
 =?utf-8?B?dHJoWnUybW04MHppMGpySFN3OUtVN1VWWHhDSjVidHkvVG1ZWlhEeWpkVnJL?=
 =?utf-8?B?VUNpQWFMN0oyQ1B1YmJETFZUN1RjR21udVJWY2ZQSHVqSEhCZks0eXVycTFu?=
 =?utf-8?Q?dkO3XnuP5qCOiaQRTMGXs28uaRP82n/WYGcbBiQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5160bb47-c2e5-47ab-5807-08d90b173ef0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:01:11.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg5aVEjm5FK7uq8VW4CjAm0CTpLKyyplrD7uGtCbysoqA+UXH/Qg7AKJawPY8bBPvzKmFTLkog2oVpve6QShQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/2021 12:38 AM, Reiji Watanabe wrote:
>> +       if (!strcmp(str, "off")) {
>> +               set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>> +               x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
>> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> 
> My previous suggestion about updating MSR_IA32_SPEC_CTRL meant
> something like:
> 
>     rdmsrl(MSR_IA32_SPEC_CTRL, current);
>     wrmsrl(MSR_IA32_SPEC_CTRL, current | SPEC_CTRL_PSFD);
> 
> And this is to keep the behavior of code below check_bugs().
> (Or do you intentionally change it due to some reason ?)
> BTW, x86_spec_ctrl_base, which is updated in psf_cmdline(),
> would be overwritten by check_bugs() anyway as follows.
> ---

Since psf_cmdline() directly writes to the MSR itself (and it only does this)
if the feature is available (per CPUID), check_bugs() should be ok.

My patch for now does not depend on the value of x86_spec_ctrl_base after psf_cmdline()
finishes execution.

> void __init check_bugs(void)
> {
>         <...>
>         /*
>          * Read the SPEC_CTRL MSR to account for reserved bits which may
>          * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>          * init code as it is not enumerated and depends on the family.
>          */
>         if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>                 rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>         <...>
> ---
> 
>> +               setup_clear_cpu_cap(X86_FEATURE_PSFD);
> 
> Does X86_FEATURE_PSFD need to be cleared for the 'off' case ?
> Do you want to remove "psfd" from /proc/cpuinfo
> when PSFD is enabled ? (not when PSFD is disabled ?)
> 
> 
No, it should not be cleared, I agree.
But I did test with KVM (with my patch that is not here) and I do not see
issues (meaning user space guest in QEMU is seeing PSF CPUID guest capability)

I see no reason to clear this feature and I will submit a new patch with this and other changes.

> Thanks,
> Reiji
> 
