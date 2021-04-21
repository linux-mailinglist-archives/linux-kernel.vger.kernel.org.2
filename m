Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BAA367325
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhDUTFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:05:49 -0400
Received: from mail-eopbgr770045.outbound.protection.outlook.com ([40.107.77.45]:47069
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245439AbhDUTFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjzK+qiEsomu5UQ/uaSq7Yg6lgOfFl559cqOT/5yYtRnayrIQ6nwvTYbDCcLWjWjgtiPgVjL+YcJp29QaN2+5lUUzZTfxuSnjauAfgj6OQv/4ktsIuFA3Mhhd+q1NSKbNIrz4ayFlcYVRUew2b/cqh28O9KJFUEQps8Lr+DGnqU6jY03Lrixf/v5L57BDHAsnjnra/nuOjbNjhItmrL+EKxz7JQCLAZA9Xo/NLt+FHrX83T6W0o+QXSTUOXYX8cnlYvDGMwe/poizbjS7GWOcV+9yL2QcV1vcOwO3ziiRtvbzNrobb9Z5Zx7Sz1dLhraPJ8o3PP9XacmxqDnz5ECQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGx11qHaeR2v0mAwaqna309/MG94hrZuVBkB2iU/X5w=;
 b=kPEwrFY9JS9wArFjhOIQP0Fc6J3RqCCRVJnfH5mwYSqa73i3fpbIC5o+H8NspOvxSc1UdWeEKQnS0jNUxdFrdN0ugnAl6HIYAPkZX3zzF4Rblm31hzsvAlwrRCq72jlrkafBb0/5vK+VNQuSWq/w+C4FKs4t0vZqg2xNoLzfdBdP+TSc9/ep4VAGxQhQsS1J/hfK4/Gbi3zkeZDpZnqipN5c++ORcux3QDfRn3lxM20nwlpj0oLd1I1AjXDIVmCSG8vUULu+zp/ioFa+zc7Sv5mtKDCnz3Vx68aI8f8/YRa4GEvgx1nt0VnU+s5iNeX0H6B4/ibXB6VKJtnOO5KcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGx11qHaeR2v0mAwaqna309/MG94hrZuVBkB2iU/X5w=;
 b=KPpz3890yPSZ8qSaSwDHWCUagSZ4zI7dccetMFo91D1OFwz9n6uG5FF7jBWxFh2agrIeShDC7mkBy2/CnctWihHCnM6e0k7SdjxvQekWzBmIRsSIlff3SXnZxS31xr8TnicbSS5ZxTGWn1fKG0NOdTyaOm7TOA/2meKUSPs2I5Y=
Authentication-Results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Wed, 21 Apr 2021 19:05:04 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 19:05:04 +0000
Subject: Re: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bandan Das <bsd@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Jonathan Corbet <corbet@lwn.net>
References: <20210421090117.22315-1-rsaripal@amd.com>
 <20210421090117.22315-5-rsaripal@amd.com>
 <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org>
 <jpg4kfzfpzm.fsf@linux.bootlegged.copy> <20210421184826.GA3120@zn.tnic>
 <863ece71-463f-fc50-db13-7fd280902d6b@amd.com>
 <20210421185725.GC22401@zn.tnic>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <569cf62f-ac3e-d9be-8a59-5bb354c6cafa@amd.com>
Date:   Wed, 21 Apr 2021 14:05:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210421185725.GC22401@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN7PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:806:127::26) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN7PR04CA0231.namprd04.prod.outlook.com (2603:10b6:806:127::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 19:05:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e027e3ff-5767-473f-e28b-08d904f85ec5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4975:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4975D5F02EEBE70040B8CDD59B479@DM6PR12MB4975.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJMsWApW+9OjHPmbwe1jiQVQy8KcsYEYr0x9iicffCMA0Gwc1KmnSUA+UbYnnjqU5DBwi8tOBfHUvXbM7pUdKZkSQRqv001wdeleh/CC1U7plPA0mCX+NqZG2ad0WO9BQ6KZC7CMmjJ3ay56L8Y4Y6AqyqDO3hQIaPbRHjAtiHVidG/UaBkNtLbIEdZA4F2oSVfrnmF96vZPdHVJG/6/PGhKjp5g3XNxypjMzpMrN0SiYTIoNaWIeZEA2+smS3HMg1mKYsmk6oEtAiU6LZGsoIUzSblbsQlznlxmLxESIAb5mZKz/Kv24J1USHSPchaAuwVys/dQ2onN2hyeW0tCUq2Fm2z78nSEZV6g2hc+2zQcU0FVcgdl5XM0hU+wdldIz0EgCLAH88Unc+GOVnGdU8/y3D1P/7Hn1LOwJrQU/TtF7Dgk151fKRBQ681Sze6fuKkOwi0AXHr9iaPddyIsDvZQKZiJJyYba7U5JZBltsRSgSM17wa2TyISPIwMS7lPcVCRI+VapW9Vn2vkN2SNcKUFHn6/InBfRhCqaDUgMoL2NnFIeW+wYqPT3b+d7J5xrR+hfh0jqcRu/QpBSaRldq1NSOB3sX8bVze2p+fXAg1vIc6F4LCGMs5t6gbVN6qe93iYMOwC7sWk4IOIF2PP2JOqPS5ewCmcTZqVdcUtt5fnR0gfOWVx+uPs00GB1eHg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(6486002)(2906002)(5660300002)(4744005)(8936002)(53546011)(186003)(31686004)(31696002)(16526019)(66556008)(6916009)(478600001)(38100700002)(36756003)(8676002)(26005)(4326008)(316002)(54906003)(16576012)(2616005)(956004)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TGVaYVNWTlc0dzF4dzcwUVZIR3pRVHE5M2lVeE80K2NzMzloekZMa0h1eW1D?=
 =?utf-8?B?ZEpRa2VxaWhKeTdWNmFJNjB5bW4rWlgrbVpub1NoL3IyWTFBenduaWphRUZF?=
 =?utf-8?B?UGNqd2VoSTFJUFY3Sko1TnZWcC9QOTNQMWF6L0tQN1NnZElHRFUwVlJXc3hE?=
 =?utf-8?B?UVo0OEFMQllRdEFnajNveEtEWXczOU1Sb1VTSC9haW9NdkdHQU5pZ2tMdnYy?=
 =?utf-8?B?cHJBMytRSGxmb2ZldHc2QXZHUXl6Nk1NTFlmLzRieGZGWGhCbmJ1VnhxY3Ay?=
 =?utf-8?B?Rm5yNGFITjZneDNhajhrUWsvM1R0aTg0d090c3NYN0UrUjZBUkh1MkxYMkhm?=
 =?utf-8?B?TUd4NXFrb2hYb0dxaFdJeHVpcE5kbHJ3R1JYb3ZNck9DNmJJanlmQ2l3RVFD?=
 =?utf-8?B?NHVuMWN5N1k0MkRIWmQ1aDN4R21kWFBoM3B3UTJMZlFyWlN6YmZqaUpXS2dj?=
 =?utf-8?B?SUxtcDJKMWpkc293QWlnMWhMWDdnc3djbGVDK2pEa245UHE1ZFYwVHZFOWNQ?=
 =?utf-8?B?dm0zVFd0TUxvQjJJdzNTYitiZ3lJUU9QaXlxdHpvNFQ2alhNOUVBMG9RREdY?=
 =?utf-8?B?MjhjdUVrOEE2N2xXNnFLcEg3MTJ1eTdMeURuVnN2cGFBb1Z0ZzVpbGdUTmVO?=
 =?utf-8?B?T0cwdmswTEFoWFpOTTBtdVZXMEphN1J0djhOVWl6NXE0S0dLdnN6cjdxL1VZ?=
 =?utf-8?B?VU1QQXEzK1hLSytDdGJTbGZ0WXRJTStuY3IzbU9jRGpUaUlkbFBNMlhmUml1?=
 =?utf-8?B?Wk10bitrTWFHanJiTHFRcnlVMm9LVDVJYVhmNUJGbXNTeTltK1ZhZ2dYNEZp?=
 =?utf-8?B?anpJMkNuVEdMc0VRRGEweHUyVVltaFZ2aE82SEwxTVNtb29sOFlIN2xzVUUv?=
 =?utf-8?B?ZDFhWEpmd0JWRGwrTnZrZGtYd3NlcVZ2WDhvTElSZ0c3Tld4RElES1ZMcEs3?=
 =?utf-8?B?WmVYMytoR0g0S3d6OGpIT3hPeW42RCttTzh5ekdveGJnVmc5Y2lzaFhmeWdY?=
 =?utf-8?B?WUdtWWMzNmttc1BaL3lYUXBKKy80U2pzUmUzQ25TV0hTbEdsUDNNMjRPUkNZ?=
 =?utf-8?B?WXFQV0I0NVdET3k1L2lDWFVXVk1Fc1QwVlMwcE4zMEwxWVliQjFvOU84S2Zv?=
 =?utf-8?B?aHlDQktqTFRWcTRUbCtvZnB3NkFodFNoREJTYWlXQ3pKelpvdm9qR1B4VFJT?=
 =?utf-8?B?NytvdXlJOElQK1VuTUdPMCtBdlY4Y0xoVkcvbG4rSGo0VWY4azQzUm5mU0xa?=
 =?utf-8?B?ZkRGRWxCS1VDMmpLWVpWTGh4K2dnZm5uSUhDTUdqU3ZQNUNyd0F2dER3VTZR?=
 =?utf-8?B?MSsxMzZPVG01SzFsSGNORHFmSjRkaWZJajhKb2hobzFMaDdKY1FTYmd4R0tE?=
 =?utf-8?B?Q0ZYdTRwcnpXdUdURVo0a1U1Q3E3VVlBVnFRdEdDTlE2b1ZqSFlBakl0VDBD?=
 =?utf-8?B?ckJJYnFoQytZNkZkekhvT1BCTDZqYjljdEhyUFNTYUxheDFhNDAvQld5YUFn?=
 =?utf-8?B?MFltMmtONzdENlBSN3RGVzhNVGFsRWpiRGhVUVVEV3FRRDdZK1NhdlNkTjg3?=
 =?utf-8?B?VTAyNjJ3OEVwN0JVUWErVlphSklxWWtMM2k1UUp6cUhWcFlVbFdKck9BNE5q?=
 =?utf-8?B?WGVreTVyWkFDbllPeXMrNUNXS2lpQzRlYWp5dXpPWnRDaS9aWDRjak5RVlk3?=
 =?utf-8?B?THZhckZJeW5jaUtVS1dBSTRqM0R2U2JPbFd1QkpTRkFMTTJCRWpyZytXVmR5?=
 =?utf-8?Q?MoOEvXTXtPF12rYv7nT1M1OZ+QiICnoJWBXzLfy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e027e3ff-5767-473f-e28b-08d904f85ec5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:05:03.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t90lXqc6fWFN20bG5jZEMn+ErLjEPaW1O2hvVoZff1OmhuhYIbasWMLC3OrkH0wNRRYxW4X/HcUV74pqLLBPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2021 1:57 PM, Borislav Petkov wrote:
> On Wed, Apr 21, 2021 at 01:55:03PM -0500, Saripalli, RK wrote:
>> I separated them into separate patches because the KVM patch depends on one of the patch.
>> The corresponding QEMU patch depends on another patch.
>>
>> By separating them into 4 separate patches, my thinking was I could keep them logically separate.
> 
> Sure but they all go together through the same tree - why does that
> matter for Qemu/KVM?

Ok. I will combine all the 4 patches into one patch and resend that one patch.

Thanks,
RK
> 
