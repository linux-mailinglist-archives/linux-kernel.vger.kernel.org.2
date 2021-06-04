Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA0839C326
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFDWDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:03:24 -0400
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:26032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbhFDWDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:03:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIcxtz1/YfrGujAP+Un+Y5jz+eXxIIjzJ35v2+q+cilgNUVbGlqos0+GI6upwmpxT7JHUHZAlCaOe0SrI6o14nvTRQnMxSvJphesa06AgSerov9jXHQ2qq2eWYRgyN+MmBIBM4nXx145dp28mMPQI2agMXR58wkpb4RLdYdBykEHSIA9H0gBsL6Xm1Fp1A/TZo3HQCvTyt9xmaGRgntvInXCeLO9b0Kkvj/Yp5xUi/mrq1EgiMIAjlbyNvOfwJekYthaSl21h60QB5YvvIKET75fBZwpafzXrFOsJH6k00AYgUajV5qbNKXGw1CgvqtKWN0G9igcv8Ze9Dxi75WBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fdAGPRo14R4A4XNIcCvcPXFeeUf6C5N2f4p7AbhCNs=;
 b=W9r85PGvkuqEsmwc2bIpxHtxK3sa9MKyb2PUaxPHqgWQiozs4+dy9IyPQXPKoliRr+b0LcxA2VJh1DWpD9cTJatsM7dBsk79Az7hWyYrjL7W1WEDtIouWooMeeCQDgGPCajFDyUI8lpWut0SpQj2KerMkir2vbPL0PfmlfygYg54MaMBNq7+SAELnDUsvJkanjvrlrJKpfFX7l4st6B1k/xQaZkkguMC8rtZisOtn2u/uJbIO4DJCOCuGd+oHQdQP+V2Z0PYmTUAf8cQ73M5pvkpuc8eMREVg6/3iGL5nDcna2gWJuybG+uim4wwM6r+O2QkCCCVQIWMERD2sVNmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fdAGPRo14R4A4XNIcCvcPXFeeUf6C5N2f4p7AbhCNs=;
 b=jnMaarTsL4EhbpOBdglpdr40I/es+BSiRKuwnOzG9gG5DiGYLu2mOuiQ/49m7TmqOavQYra4SSqHgfA3bjVC/CaSqKXRRQJKn2ZDGWO1xvQoIkJCkag0FrxzJOqKCTYfbjAxNE7ODhjdJkX1y9itbQBonDbXeTKi9YiJDG31B3k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Fri, 4 Jun 2021 22:01:33 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 22:01:33 +0000
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstractionn
To:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic> <YLkcUts9dWDkDKpY@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com>
Date:   Fri, 4 Jun 2021 17:01:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YLkcUts9dWDkDKpY@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN7PR04CA0055.namprd04.prod.outlook.com (2603:10b6:806:120::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 22:01:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 342f43f3-2eb5-4005-d9d9-08d927a450ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3180:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3180467C71B668E6F7B95F5FEC3B9@DM6PR12MB3180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSmcFczBdiuoBRqiV487GXqhvoKnGznOS9i1wuVSDBWScRFeOKUpP4CxBin2VkBMAKPElnVvFtvwrI58DnomnGu0kvlg/zz74flwHDeDBTWZy0PqJ1GfllsmpL7HAS2iS3we7nQBBncniPzlWn5D8emE4NHyzazwrQ5yxhF4O0Z5DL24YYS5QLa0I+QqCPwZ+0SzBB/X0UBfIpTfw/JJXjZ0W3g88gGm0LhHyR0V/pSVTQUY3+8YAU1zRGxKg8pWhYQpeNUdprjxTdNcOJ3xSK+YPCiZJU8GGZkDwZF+KKOA4VyspNIPta6OHSM+waeuQluaBw56ZI0pdz9JXeq7Vmh9YCibUI89TtMjM6AZGRUSsUaNP4rIece6u69UuDA7RYy/etCrw4aia/OQ6HNLCIDuy2sYIBA98PvGxcJyZMDog59h2mKptmXuPNHiuN4fFm62ZBZK/oO2YAkspDVygUqRjorUXI4xusgVdY5JmFjutBhaKDAmpngYIxmr+7Fd7GoicH2h7Lld6GrbFiNA5SUF0iyNTsvdrB0+mDmj5sKw/ZabyXngJKdQO7S6LJE2h4A7WeOKwOhDkw0FIt70S8hf5V/8CAZzQ5XE3f4Bted1T9Ue9BOLk8VwqIp5Wmzsz85sCJwuZqCkRq/qEc6lZQnr3ISUO4Fjh7AO/uojz1Fa5wuDkCIhZSyOLPnUrYRBBYodwtRpJm8fgHca5/Iqeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(66556008)(66476007)(66946007)(5660300002)(956004)(86362001)(31696002)(4326008)(2616005)(6486002)(7416002)(36756003)(2906002)(8676002)(6512007)(8936002)(478600001)(38100700002)(26005)(186003)(54906003)(16526019)(31686004)(316002)(6506007)(53546011)(110136005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bzVYN3hVeTg3bitBQlg2ZlVrTVNzYXloTy9CNEt1Y0lQWnJ6VG12YkhIVlor?=
 =?utf-8?B?M0ZVYjB6S09xYmlTVFhURGlIa2IyZStLVy9JUzIyczRTSmJwNVoxN1J5T21m?=
 =?utf-8?B?WkxKb2lIOU5yRjRUdDIzMzBNdTJMSXg4aVZRWGNkMlBvR1l2NldDNXpUZjYr?=
 =?utf-8?B?NE43S3BYOFJkV25CZDBuQ3Z3QllNZUVVTXlqbE84ZWtwZTVvV0RhSmc3QUwr?=
 =?utf-8?B?L3VpU051NUVNaXA2U0ZjUFdIK1lBRGNGUlczUThDclZ0THhEK2h5cmJudjdm?=
 =?utf-8?B?dktldmtUUEZIejlkbjVXY2NTZ0ZacmdZaStsc2E0YXVxcHBPWldBMm1rYng2?=
 =?utf-8?B?eWN3RU92enBxWngxK3QxS2hJbXEvVFE4bDdCcUVVQitDM3NBV2h6N2ZNL1RU?=
 =?utf-8?B?VWp2aWFxK0FmK3pQTVVmdU9ubGpVc3JPQVI0WmF5dGlhUUt0SWR5TlkyblUr?=
 =?utf-8?B?NDRQeEk0RXlZVExia25Za1lWQUllZUo3RlJjdmpMOXZtTGRzc2pBOENQMFlF?=
 =?utf-8?B?ZnhFR0sxQ3QvL3FibGd2RDZ4K3ZzdSthdkw5YWtaeTcwZEdZWENkampNZ00w?=
 =?utf-8?B?QmFKcDZXdE1ZVWY0R05kQ1Axdk42ejJPb2NhZENwazY4QnZ0bXhmVjM4UkNE?=
 =?utf-8?B?UDBiUHNrOGx5bzgvcTVuYXBYNXJ6MDlHQVg0dUZFTThNb0N0cHgyU1htSzdF?=
 =?utf-8?B?WjR5bytJVXRGZ21ydUdWZTU0UXpKQ3pCUytWZGNXTEJ6Tk9mMFFzUVRremdl?=
 =?utf-8?B?RExWbXpNelZpNUU4eUg4T1VLZHZXTXdhcW5jY2ZCN0R2NnZPcmZZM3NLbS92?=
 =?utf-8?B?ZzFKNEVSdjRVbXk5UVdJYVJwRzYrdjRKb0MrMkE4MnFHbWt2NGFqZy9HZ0FH?=
 =?utf-8?B?eGc0QU02QWYrNDNuT1lmTWNtTmE4eFRYb3YrOVJZWEdjWmt0VkdPRVBLRUg3?=
 =?utf-8?B?Nko1Z1hScUd0SjFRNC9uWnNKQUN5UUdRbzNFOGxORDZCdTlZZmVYOXpZQ3U3?=
 =?utf-8?B?UU4xOTlER2ZodUpzSlhaallBWUJkc1JhK1RhTW1HTnMveTFseWYzRmdiVzUw?=
 =?utf-8?B?UU11aXQzcGNwaFhERzVlRTFYcHF5WEFIYThvMFQ5NmhUbitDcC9UR3lkV3BP?=
 =?utf-8?B?bzFYd2ZuSVY1Uk1yY09NaW53MWVUZTAxMlQ5R2k5dEpqQ250c1pyK0JZZ2tG?=
 =?utf-8?B?SVh1UE5Gb3Ryd0x2VzBVK3c4M0doMTcvSXFuZ2VsQXR4SEV0MlhZcG4xZzVW?=
 =?utf-8?B?Q2pnRENYMUVIWFZ4eERzMVJXTzlkZTBFc2pDbHZVc2lwcEtUMjFWN1RjbStO?=
 =?utf-8?B?NWFRdXV2VFd1c0YrZDhPcFVpMmM0eGpzdnZNR3duZ3grTHcxMm9obVYrZk91?=
 =?utf-8?B?SzJPSFF1bk5NRXdkWW90VjFSdUNiRUV4aG0wVzJFTVRxN1g0cTBaYTdpN0hD?=
 =?utf-8?B?RmpITVo5RE9zTTdaU3ppMDF6emtTREE0Q2ZoUjQ4QUtaWTh5SlpNMWttaENi?=
 =?utf-8?B?WHhNTjZMV09ZSSsrRzQwbDZ6VkNpNEVnNWtKSE1VQTZlcEtaMWRwVWJKR3cw?=
 =?utf-8?B?SE1CSFBsVDErUERkbU5WRFlFb3FHRkF4OXFoRnRqODdwUVFZK081TSsvd09O?=
 =?utf-8?B?T1oxQlBuTDlBNkhKenNDaW1IR2kyNWJ1V2R4dnNwVE5QMG9nQ3ByNzNRRWtP?=
 =?utf-8?B?VGpldlRPMTVBS1FpcTRaMXRGSzhaVVhZSDZLcHIxVzNXOG8xNzJxZ0VkRm16?=
 =?utf-8?Q?vA/jVjs2HjKzwZw/t1SOVeDJrZ0kRTeoTJhZeXg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342f43f3-2eb5-4005-d9d9-08d927a450ef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 22:01:33.6761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TIaL9kqmMwQX/ceGnWNifpe8Mem0iRQIvBVXp6PTpCg/Ks60tcGwnUUNhw8kqaHTqfBhSmU1T8xfxg7AYc7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 1:15 PM, Borislav Petkov wrote:
> From f1e9f051c86b09fe660f49b0307bc7c6cec5e6f4 Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bp@suse.de>
> Date: Thu, 3 Jun 2021 20:03:31 +0200
> Subject: Convert sme_active()
> 
>  	 */
> -	if (sme_active())
> +	if (protected_guest_has(VM_HOST_MEM_ENCRYPT))
>  		swiotlb = 1;

I still feel this is confusing. SME is a host/bare-metal technology, so
calling protected_guest_has() seems odd and using VM_HOST_MEM_ENCRYPT,
where I assume VM is short for virtual machine, also seems odd.

How about just protected_os_has()? Then you could have
- HOST_MEM_ENCRYPT  for host memory encryption
- GUEST_MEM_ENCRYPT for guest memory encryption
- MEM_ENCRYPT       for either host or guest memory encryption.

The first is analogous to sme_active(), the second to sev_active() and the
third to mem_encrypt_active(). Just my opinion, though...

>  
>  	return swiotlb;
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 01a224fdb897..3aa2658ced52 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1409,6 +1409,11 @@ bool sev_protected_guest_has(unsigned long flag)
>  	case VM_MEM_ENCRYPT:
>  	case VM_MEM_ENCRYPT_ACTIVE:
>  		return true;
> +	case VM_HOST_MEM_ENCRYPT:
> +		return sme_me_mask && !sev_active();
> +	default:
> +		WARN_ON_ONCE(1);
> +		return false;

I don't think you want a WARN_ON_ONCE() here. The code will be written to
work with either SEV or TDX, so we shouldn't warn on a check for a TDX
supported feature when running on AMD (or vice-versa).

Thanks,
Tom

