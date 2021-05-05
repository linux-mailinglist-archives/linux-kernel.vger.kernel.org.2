Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E175373374
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhEEBMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:12:16 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:3146
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231408AbhEEBMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:12:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkeQsWhE+g3KeWMfvFSSPppoQTTKwIdChsBGuzK11mXkqI89ZjAMt4bFdfWxBbfW7bQ/ABcMRp98457OuNScfPJAcx7bbTtgWYSsFlaSnHhfLmEAGoAslrRi9N9WEaltea8buVnaouLzoxmcM3Szas55QmFNhl/UAnhOJgMo63lOhuQD32kRoZh/R1lhmOvH8wYZLUn7Ph1X60tqeUOsBcKS4qYdohu9aN/QNJdM0OTutkuW6XFvZHfSwyjukfk5V/PdMzfoB2p4Ir0JGDQqiO6JoZ6FXZmrHoywL8c9yH6aKPngswuCCWCUO8okyKrphXqCC31O4NCCHEFZwTghMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WzY7RSSABUBuuqhLcVFBJRPdiTnc+C0Ilz5NKAeLsA=;
 b=F70rK+9Bt0G1MmF9aBJyFnWXvkl6DoVHGXSLtqRIYRPsAD3B4lznwFzNLJhjrZNeEoKNXwjvhUDD50CQDdl3LjT4BPcgnF5czw121qYc5Rc/Hzcw7YLgga9eoPA9KnKVVBRojTYOKRC25Tb0VIBd/8SXorZEMCuCpfVphB9pLaLYhs/PTH6f+H695Eoon7NvviS7LRSBUa/9i0476sBxr5uW+UxASH/MCRxQThA0vYSgh/CDWCwRfq/nAQhc2vOiCjp43zKWnoNiw/vM4eyBnbFrNHvlv5yuhgdE25vml2cVbXuE//JyGr2v12IR45E6A0O4/zLSgQMkjN5Oy27Bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WzY7RSSABUBuuqhLcVFBJRPdiTnc+C0Ilz5NKAeLsA=;
 b=qeBAJBQnayxsGURezv/GKPmTIwk6sHNyuHPo/a/mja3EJ5UQ87J41THK1e2o/5ckmpNdzPy4wv6jtGkR6CnycOzOqsvAdjcKJAtV4r+LVlEogKGX8fgdmNa802WBv2KjaTtAZajb/UFC95qF9OuFVXbmcZqpSBEnGPZr0h3YoYc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Wed, 5 May 2021 01:11:08 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 01:11:08 +0000
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Pawan Gupta <writetopawan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
 <20210505001154.rmibherzitm2yaga@devbox.home>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <03c5cd2b-ae83-1d7e-0761-81055d281b78@amd.com>
Date:   Tue, 4 May 2021 20:11:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210505001154.rmibherzitm2yaga@devbox.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [69.215.231.172]
X-ClientProxiedBy: SN6PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:805:ca::48) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (69.215.231.172) by SN6PR16CA0071.namprd16.prod.outlook.com (2603:10b6:805:ca::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 01:11:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250a1d94-c488-4c43-3065-08d90f62a9ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3916:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3916CB83941D7C67F9895A459B599@DM6PR12MB3916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIJEih5VU+RKuNedo4s40u55QnQ7xXidCdaWiYiu1yGnfjBmcKYfuWMquRfOGoPs3eOwUomrHxFNXgvGujGk9Skg9/pKqgu21f7jRzc5BMMaZmVts3z0aw+QoIJuBsk74pLWr9g9m9XKIfnyIg/uxQv8rRKQIoNXvuz3WhhwyZg0YwrAnaEVqkj/5lAm6+FjBb90BHdSIqLy+/kbnFRY8mrTb5BGDsM5nE+8SkDXgFDuU5V5tTt/TZxtEI96MiuIcH976bTohyGEv6n8RGm28JqbRCjeh5aVJTgQYtnbRqf0O7XBfX4iS/3UirAkfeKZoV+8F/SNl7nlrEG0jHVHVm84CSI17raHmKhxMpbISbyIAzFvlxRBCmQMLKHJ0hxN8jVtJ9/FtcDLSh9larHD26AhE7pClRdUt0JTo7WXJRngrVVDfZLj6sT9Ifd4Xjzq1f1Gp/uenUhwuPS66SjFEWPXQZQVT3o9tiyVHQVO9zK5MlEfa/bpq6vtW/P7AxW1DB18FUH0gbULgDLbNmZ37su0HKB2kvvsmtY5mU8x/A30C1mqm7hnTFFMuml5iP6M/O7kf8P89w8eGKAa4pt0ALPX7j8eNSs98b84fwNatVakcHTObBRnCDGP32ZVmStENkZG2pFBolckc8xlaXar3Lx+8TKoDNNS3pvXSfoLDN5JmlN8Seeo8wiofdsQUeqs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(83380400001)(31696002)(6486002)(6916009)(16576012)(2616005)(8676002)(66946007)(36756003)(956004)(2906002)(38100700002)(478600001)(16526019)(4326008)(5660300002)(53546011)(31686004)(8936002)(26005)(66556008)(66476007)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFZ4ZmNwQW85VENtWGdYdGQrQ2VPUUpVRHYyQkVkT2hyMjQ3VklDenVlQWk0?=
 =?utf-8?B?bFNpd1BlTWUvUWhsRXczRGZYTGFmY2ZMcTBWSVBBcy9CMXo1Wkpqc0dXQVFQ?=
 =?utf-8?B?ZkF5KzJZaVI4c3VCTmw1TWc4OVlFZEpRNjNSYnVMVGM5MWljTUh5eVJveEYx?=
 =?utf-8?B?NXdlclVLbjhpUnRkNklJSFRWR0hON0RyWE5rWFkyUHFtTDlhMnZRZUJMOGlS?=
 =?utf-8?B?bkRsR0NlMDRRYmprMUxzSWRyaGErSTdZd05ud1NWRVN2bFY1NkhuNXE5S2Nt?=
 =?utf-8?B?WDdaYXM0dUpFZUphRE5uc1BIMjlacUxONzRRWXhLejZPT3RtYnhRa0RId1lR?=
 =?utf-8?B?TndSa0tDMFhIaTEvVnVOR21hamZvL3BpakFjMnQydGZ3eS8weHR3c3lQTEMw?=
 =?utf-8?B?a08rb2JNdlpkWXlaVnVlM2ltRzYvajNnamJ2WCsxalFIclF4MHdDRlQrZTB4?=
 =?utf-8?B?aStua0p0U0Y1UmVJdTVqeFZNMjFJMEFnNm9laGRobk8wVGNKTEVseEh5MkYw?=
 =?utf-8?B?UkdtWjVCNFZpOFdKSkJYeGVoU1Q2RUVjOXlUOHFHZzAxU2pyYy9VS2EyQTRP?=
 =?utf-8?B?d053dTZqNGs5YzVTbXdRVm9sR0xnYkFpQm55WDl6LzRKYVJ3UzljeEN2ZXkx?=
 =?utf-8?B?S3pKZHVqV2lkVUpIZjJ0QVZtcmlrMVhjVnRUSjF1czhudTR5enhKRFI3eDJU?=
 =?utf-8?B?UmpCbFRxSlVkK0t1bitMbUE0QVk2RVRZVURka0ovOEJpbTFtNGRIVWhHTTBj?=
 =?utf-8?B?RXhYSG0zTFJyUlZDVStSVGZ3VHJWM1ljWFJnN0h3VWNiRTlLcnpzQmMzeGx3?=
 =?utf-8?B?dDFkS1hXLzZMei9lbnVvRUk0MURJdFU4K2dGSFhqaW1BRm9SUjRhTHlCcE1q?=
 =?utf-8?B?S3NFWktYamFzRzAyb3U2SHpOYkhtaFk0TkNlY01CRjBiL1U3M0NpYTFJMVFK?=
 =?utf-8?B?djd4SjdNN3p6b1dLaHVybU53dmlKTWRVSGlzQ3ZabHZlamZtMUt2QkVrZVlv?=
 =?utf-8?B?dWpVbHlLNXZNRHF5blNBbmF1OU12M091ZFBNaURhaEJOb05HdFRJQTZHa010?=
 =?utf-8?B?UW5LK2V5OGdldnRZYUp5b25UVmlIckE2VEE0ODE4b2pNRVZxRzF1M21lZ0FL?=
 =?utf-8?B?b0lONXd0OG1oUThsQzVVaDdaN1AxRVozUW91SUNQandQeUt3VGhQOUltMGdD?=
 =?utf-8?B?aFpKSC9ySFp0RE5VMVpvUk5xZitXdGhIODhQSkl1VE4wS29MZjIxa0lsT3Ax?=
 =?utf-8?B?Q1hmK09KblpZVW9HV3RFMk1hY2RvTW5paFVwM21qRXpGZVQxVU5pS1E2T2lS?=
 =?utf-8?B?UUI0VUM2dTBHRjdCN01ybTFVMWtMdDFIVktDNEg5UjcybGRBV2U0NCswYmFK?=
 =?utf-8?B?SmhwaFBWOEcvL05xa1lJaEpPU3JKMTZiVUFwRFp5b1FRbUV5UWlNYjZKRkxQ?=
 =?utf-8?B?VDRqUXk5bjZKenpMZTFVeTRqNitzazEyZzlzelJmckRQNnFKNDhyNHBEaHdt?=
 =?utf-8?B?QkxHWVdOa0NabDJRL2lGWWdUTG0vcDAvMEcxeHptZ3hiMy9UclhnSUV6cmIx?=
 =?utf-8?B?TmNpZStsQnZUS0JIQkpVMFlZM1c4SWprMmRQWUJMY25GZ1pvL3lHRWlwSnVv?=
 =?utf-8?B?Q2pCNGtGWENXVG0vUTQvamZGVlFyeitSb1FKdTVKQWNxem1aa2FXVUdHRElM?=
 =?utf-8?B?R1RhalRSeVpVRzg0M2pGeUc0Q1IybzJtQjNzb2R2eDlkSWswclBLai9lcTdM?=
 =?utf-8?Q?oiCV1cKyPW0HqZYpOTdMfjMBsE5PJW8ofeKBe/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a1d94-c488-4c43-3065-08d90f62a9ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 01:11:08.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87QkYn0JZ6PdwuSsNfADzlATcqeRy/9yj7nLOBwzjlXnLKpKWbGrQTpKwjgGRJceQDVb3UGNTnF5Ncas26XPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2021 7:11 PM, Pawan Gupta wrote:
> On 30.04.2021 08:17, Ramakrishna Saripalli wrote:
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1170,3 +1170,26 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>>         break;
>>     }
>> }
>> +
>> +static int __init psf_cmdline(char *str)
>> +{
>> +    u64 tmp = 0;
>> +
>> +    if (!boot_cpu_has(X86_FEATURE_PSFD))
>> +        return 0;
>> +
>> +    if (!str)
>> +        return -EINVAL;
>> +
>> +    if (!strcmp(str, "off")) {
>> +        set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>> +        rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>> +        tmp |= SPEC_CTRL_PSFD;
>> +        x86_spec_ctrl_base |= tmp;
> 
> I don't think there is a need to update x86_spec_ctrl_base here.
> check_bugs() already reads the MSR_IA32_SPEC_CTRL and updates
> x86_spec_ctrl_base.

Pawan, you are correct. I added the update to x86_spec_ctrl_base to ensure that the bits 
in x86_spec_ctrl_base are consistent with the actual bits in the MSR after this change

>> +        wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +early_param("predict_store_fwd", psf_cmdline);
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index d41b70fe4918..536136e0daa3 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
>>
>> void __init check_bugs(void)
>> {
>> +    u64 tmp = 0;
>> +
>>     identify_boot_cpu();
>>
>>     /*
>> @@ -97,7 +99,9 @@ void __init check_bugs(void)
>>      * init code as it is not enumerated and depends on the family.
>>      */
>>     if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>> -        rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +        rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>> +
>> +    x86_spec_ctrl_base |= tmp;
> 
> This change also doesn't seem to be necessary, psf_cmdline() updates the
> MSR( i.e. sets PSFD).  Here read from the MSR will still update
> x86_spec_ctrl_base to the correct value. Am I missing something?

Yes you are correct because psf_cmdline executes before check_bugs() and does update
the MSR. 


> 
> Thanks,
> Pawan
