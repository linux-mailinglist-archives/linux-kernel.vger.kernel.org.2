Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D24392296
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhEZWPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:15:42 -0400
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com ([40.107.243.45]:15264
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229624AbhEZWPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:15:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii9GGsaSG29XJWJMBk5mRgQ+nMstK4qw1+XVdhWRixZBSr5Y1UjTLBWC7vlKlpEWUmjVoUeOLTHTB8QLCSKEQZpPSkautClFPDAxmKLrcg5fumYF1v0m8tqqIahl0XrChMpeEJmM2MsPxn6GqrnQfgvRJ90mJpeJkeuIRa5g6Qs0GYzfCFMMDfdiNFVENzeMaO7p0FMDtSdW7z42dsw9zHuwaMs7aQeJTQHXcUbskuFd6LSgjwvlf/+rd9iFUf0St+EGYeBtgeMdc9oVxj2RFEmVs9AeT1Gvd7el9DXjjFGo+n3Swfix4A7Mn+u5bos4iWqtBrFNuzEJQnDlfMkjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COoZqe04DG0IFmTvfuDLCKX2n11cyHy/iUYnguO/kjE=;
 b=ElevLRuonxNgXmQ+IRRV2Sx6LYqHHAR0sWS1rE43Jgna3gGUQ6+CyrO0jhG6oIwnrgmPD2+qif1Hkq12Fi6vAwaDU32hE04RJNrfnateqaN+FSqlfmo7lB+3QdfDG3MVqFTgRcrTA5eELdbYQHEYgbEwdDwcIyOHa7Oz8ynTJpsKEp9M2VqFqtK4U7LKltzvfoKwWVHLUCLRM2CndlqCmFpalcUbU+dG2I52Dpf+huTceMMmiNzKt6Qaq9J3zYq598JonHSiqe5b95wMmOSE4dRTahvuGATpjo9k8mXZ0iZu08YwUZYdWUxzqq3qdtx+jm44K0Js+fIX8AOo0C8skw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COoZqe04DG0IFmTvfuDLCKX2n11cyHy/iUYnguO/kjE=;
 b=k+i/TM4dDcYVU4mYLmti9a2MW6321FI2WyH2NYo84JkP15S7Dlg/Ez45WEP5gP6U8pdLpP38URvf88Lk10kiMOghqSQC0C7+Jut9ouxHCyKhjs71/kNkYQCGh83UCOgJEuX9YUqs0yTVEaYIm45wumXIZbaQvd+JW8A+vmgDvPg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Wed, 26 May 2021 22:14:07 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4150.027; Wed, 26 May
 2021 22:14:07 +0000
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com> <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic> <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <a53cd108-8758-e153-7ae6-c508fce02003@linux.intel.com>
 <777db866-4c3d-d849-94cf-b4248c6ac2aa@amd.com>
Message-ID: <de96fb04-b8a4-02b4-be51-0e1c49976f22@amd.com>
Date:   Wed, 26 May 2021 17:14:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <777db866-4c3d-d849-94cf-b4248c6ac2aa@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN2PR01CA0020.prod.exchangelabs.com (2603:10b6:804:2::30)
 To DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN2PR01CA0020.prod.exchangelabs.com (2603:10b6:804:2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 22:14:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d956fe4a-4be0-437a-a8e9-08d920939464
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4297FAC2E2504C23062A2007EC249@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBfQjUzkbUrRcoO/knfJhnbmNM7+HfXpcKuKcmoGfa9Ip/O1MxREwkEKJ/5MsrELnA5usP5ZMVsiqYCJo4GGH9DT/1LvcGoLydnX+baENHI7gpxXWpbkCy0Z0DNvgEKMsni3gErIWDaFWv7FFO1GQ2JJqohlHo795z3M8PIwOE/jKCMX1j/HTeJmGvOJqutheyH7BhznE5pFEy9G2i+bLtW8SklmO6YNjSS5VdJqHLRFDlrib5CWW4gS/mdgNHTwPA/96LFBcQ+poDvCGNTGej9rnAVU/3paSpofR/6qe/0jlYLRYdCu0MEt9j3wrG6pX+hMz5L7P8tHix2sWR+uyYjuBi3sR6r0UHZmTk68NEA2WdHMHab9jVgFr4zYORCrr+p00PLSBjihSmC329mywBxRJECDKuFECTW07oAWF56+QwBMBfeXMfDCPjMAIMum273Edg2j8m6eykI/T+wJ7OIj1V4q5xedg1E4fL+SStNi8m+Pjf3ZmaEmxGEAivASK+EC/YvVdA7FTRefRq44KLiW1pAEOn9OP6Oxkc6R6oQaeCaGCPSu2GFE5X3HFqwNJJLcqnnRL3nl3iCo32cYU5OhI2LVjQxORyFQNIIditteca1VGEUPqlxIRiqjiu0gPkvDk1Q1X5E2nVRBjJUpESR/hiIF38/0g6IGvn7VuSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39850400004)(376002)(8676002)(956004)(36756003)(26005)(66556008)(8936002)(16576012)(2616005)(186003)(7416002)(66946007)(66476007)(16526019)(478600001)(6486002)(31696002)(54906003)(53546011)(2906002)(86362001)(110136005)(83380400001)(31686004)(5660300002)(38100700002)(4326008)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b1VSN3MzRElqcFhHTnhyNXovaFNsNXl4am5od09kNUZEOThKUTBVMGlwYW55?=
 =?utf-8?B?WHI4dDJmY0lZaVMrZzJKd2pWTWhsZ24vT2JjMTRtSnFzNTFWRjRIMkdpTHRM?=
 =?utf-8?B?UWhYTG80eHVTb2JaSUNSODVYUXpPRWZzOGZpWDcyOVRHNlZTcHllQWw4Smxv?=
 =?utf-8?B?ei9NRzR5bDh5a0VZeVZRNGc2SXRJb2E4ODZrU2hlUktBTy9vSTZBQW1OVkdu?=
 =?utf-8?B?ZlhXOVUzaHRTVVlILzNVQjBIeW82UlR5SHkzWEx5bzhUOHNPNTJkRlhWTkMx?=
 =?utf-8?B?UEl4UEhjZHJVenJlR0xxU1dXWmlPZzhBMXpKbWFHVU5TQTRLTUlzQVlSMXlY?=
 =?utf-8?B?U09CUjdzTTZiSEtyOWxzWW5KOSthT0p0bDFiTVZYUWw0MlV1dGdEMHJXQk01?=
 =?utf-8?B?YU0rZExCSER2bXZxMzIxVXZkVTR6blh3RkNOWVl4Qi9EQ1dMK3NkbUt0N1Vw?=
 =?utf-8?B?SytrQ2t3cnBWQmlSdEZOMXllbGU2QXZmQjJzWDdTbjNWM3lWa0twUWFjTG02?=
 =?utf-8?B?dHhLS2xUeE5YQVdxS3N0V3gxT2M5L1pCZDE4Zm5BbjJsV1RrajlkY24yQ1Rn?=
 =?utf-8?B?YXE5VFZMRTlaNEFscWEyTjJxUkd2dVNQUUM2c1g4ZWZvUzVsMWV0cmFyUkQw?=
 =?utf-8?B?TzNQUklXUjRPck5rQjBna2U2aW5wbGNHUHJlQkhrSDM1Y3lOWFFBMlFubG9X?=
 =?utf-8?B?WTFFNk9ybmR4cEJLQ3BiUTc3SFBPcXV2WlN0SUoxT0FvaDlLVHlScGsxbG9r?=
 =?utf-8?B?RFN3MzF5UDFLdytJRGNxNkpCM2lwa2dHc3R5b1l1ODYxZTUxREFtR3NiNjJT?=
 =?utf-8?B?UlBYLytoVGJtcGVrMzNlK0VjS3M1cXZiQXpDbFFnZ1lBT05UV1Z2SERDTlBI?=
 =?utf-8?B?NXdhNDB6T2VnaHZjUmxjZXYrU2lrQm45SGJ5d09JZTk0dVZ1ZE4rSmo5bVEr?=
 =?utf-8?B?NHNiNlFEeWdQTW9YbHNjZXh3STJsOEQrOEFFb1FKbjhtdm1ydlhtRFRmMGZH?=
 =?utf-8?B?Yk9WYlMyVDlUZ1h5Y1dmSXdHNDZ0VzlySDRRM0F1WDFxWlBrdUdUNEFzMld3?=
 =?utf-8?B?U011S2kzUndUZnl2d2Z1UkM5V2w5dUh2YjJLaUFRREtZcTVCdjZyU3ZQa21O?=
 =?utf-8?B?b21ndURldFFuVWhIei9TdVhyR01rQ0gxT2gxQy92bVN6QW5HOE5DQlNVN09w?=
 =?utf-8?B?cTVaMkF1WFRWSDNWMGRvQmhpaG9QWm1GWEl2b2pQNm9oZnIybGVUZFAzUi9E?=
 =?utf-8?B?MjlYZkNiRnlpRHRramt5Qkg2dno4Tkh4UHZaN0h3Z2Q1VHc1ak9iTlg5ZXRO?=
 =?utf-8?B?d1RwMDFTOERUY0ZYbkNRbEZ6WWJFYUtIL1lEZEk3N28zcHMwekdqZSt4RW9L?=
 =?utf-8?B?Y20vajVJYXh5TnZ4K2p3QndkVW1YWW1LQjlVZXJmaU13VytuenJiWWZDbmxn?=
 =?utf-8?B?dkpuMDRRaGEzeFBBODh1VHgzQlZoaHk4WSt5VHFUU1VCNWEvNFREMkxOajF6?=
 =?utf-8?B?MDliUjhTYkppQWxHa1NyeXdvRXVwbXo5dGtmdzhCMzQ2VHI2OE5IcnhFQTkw?=
 =?utf-8?B?UEREdzJxamFpS1hEVlYyWEprQkdYQ0dpVHVsNWxLZkU4R1NXUEZPcFRDMzhw?=
 =?utf-8?B?cWZvNmdXaVdTcmxMbnl6REZvem5yWUdJTk4zcWUwQTdrQmpiajZsMEhPcDl4?=
 =?utf-8?B?N3pabXF3VDZyaWlLVHk0R2F3Y2pkdEo2QWVNWjV4UGk5Mm5iUkU0a2xyVE95?=
 =?utf-8?Q?qIlXtjrbVto5AxPT6uUEZ2rE/BY32s4FAcBv7zM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d956fe4a-4be0-437a-a8e9-08d920939464
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 22:14:07.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TanfuZb4zrVFxFROr9RY7rFDRsYTIIzxKAR+vJQ0DjV5K6oWoeEJ44WOcA9D8texb2U3Ompr2zLQzkzQxPLJSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 5:02 PM, Tom Lendacky wrote:
> On 5/26/21 4:37 PM, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 5/21/21 9:19 AM, Tom Lendacky wrote:
>>> In arch/x86/mm/mem_encrypt.c, sme_early_init() (should have renamed that
>>> when SEV support was added), we do:
>>>     if (sev_active())
>>>         swiotlb_force = SWIOTLB_FORCE;
>>>
>>> TDX should be able to do a similar thing without having to touch
>>> arch/x86/kernel/pci-swiotlb.c.
>>>
>>> That would remove any confusion over SME being part of a
>>> protected_guest_has() call.
>>
>> You mean sme_active() check in arch/x86/kernel/pci-swiotlb.c is redundant?
> 
> No, the sme_active() check is required to make sure that SWIOTLB is
> available under SME. Encrypted DMA is supported under SME if the device
> supports 64-bit DMA. But if the device doesn't support 64-bit DMA and the
> IOMMU is not active, then DMA will be bounced through SWIOTLB.
> 
> As compared to SEV, where all DMA has to be bounced through SWIOTLB or
> unencrypted memory. For that, swiotlb_force is used.

I should probably add that SME is memory encryption support for
host/hypervisor/bare-metal, while SEV is memory encryption support for
virtualization.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>>  41 int __init pci_swiotlb_detect_4gb(void)
>>  42 {
>>  43         /* don't initialize swiotlb if iommu=off (no_iommu=1) */
>>  44         if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
>>  45                 swiotlb = 1;
>>  46
>>  47         /*
>>  48          * If SME is active then swiotlb will be set to 1 so that bounce
>>  49          * buffers are allocated and used for devices that do not support
>>  50          * the addressing range required for the encryption mask.
>>  51          */
>>  52         if (sme_active() || is_tdx_guest())
>>  53                 swiotlb = 1;
>>
>>
