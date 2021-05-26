Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB17392278
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhEZWD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:03:59 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:16674
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234359AbhEZWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO2w0Tb7xivfcb/Gzq9gYwvA9uOxdPUfYmF6Aere6t2uNEdydWLsMpD44hlbzPVtk2LkVeqN1vWbuHHGxT0rHRwnJKqRicHCXHvcFt9xSgXR5dVBqNB7U6zZ2qIkUgDGveZIryNNpjlzOTiKVtYpU3cFbI8FE2t7lQnKZjoLMWx5AZeYzF0r9X6viDROlPYbLfYmb1AC0T6BgD61wZ7P3qO/MNdrRDNBPyq+zKyY+5leHHjXuQQEBcUnVQd6wlT7DtDVRfxvyGPwXfou9K7TX8gy31zk+HvNzDNLdgtsTZYaCvGgkteGzpZj+KM1VDMWhrIHD1P25+bga7FPXuohGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcf3PemvPwY4aZFXah68IbA5gVIEDhHsJMr4JBQ4l0U=;
 b=dSsaMF/fwBTUlq3E4Pcmr79q6OWvu3yWdPaJZnI86mJQgRt6CFe/F+AROfDV+nWKgwVTPy5vosDdeopT+rwRrwMzXT1LM7njTDz9PB3dgvFXPHwtfUKLxR1TGL4oOFMOxOoa8KX18V+1444cdjXCR5ahh/1l6l2NaoYfRxvWJE2NujW49NbjzBwxg+MyEtheYaDHr7fkQPvbaplpgBDneXybDp4tsyKQnteG4kCLwabP1L1C9onWAdX6sEaz7O9Y2Bi+mnNaehgJSP6Xmx4KVvxrfJMBKjZM2h1GYA0yN7+cAxQoeWxyBCoDXYb/tGYG8ZGmL1VZhlMQg4R/vKFR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcf3PemvPwY4aZFXah68IbA5gVIEDhHsJMr4JBQ4l0U=;
 b=SlsXx7dZg0vXBcLnW3Wo1gGdQNikaAaYNDpAvLtq302/p/TDMuUVeJYuVJb7Fy8VBPjbASFhZ2bdiRC+4Wdal+VFv/NWYfEQ40u4LDCM8HjTqUQRNUc/vcZHTdRXjeBwVK7305NBdIRk6oN5TdPZJfoL50AVCJgqdOyQlfeGcaw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Wed, 26 May 2021 22:02:23 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4150.027; Wed, 26 May
 2021 22:02:23 +0000
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <777db866-4c3d-d849-94cf-b4248c6ac2aa@amd.com>
Date:   Wed, 26 May 2021 17:02:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <a53cd108-8758-e153-7ae6-c508fce02003@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:805:66::26) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:805:66::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 22:02:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e1ea1b4-9a7b-4c55-6527-08d92091f082
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43554A7D3E8DF5AD157F6963EC249@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNzm1ls5LxnocVL54F1dRp2SSwnxT1LodQPdeCFCUaADU1C0VUvqsUeVGYbeaEIaLw2caHXD1bRxMIK4OhNNPf0TPLdWVjl5wdROZFIBxB1PrrS1WJ3C2wVj2Dm/NyMWTMNSy+l4NYKFZYAMU2TTe0MFdV0KHAk9OuZCUvvRFC31f9kaD7/w5+t7X1sxMvAKtAguJpP08N+zIy3e542V5/n3bbc+dn8fkP/KChvQ4Wz9aISKI9Ucfst0jpE0RzjbTd2IQvzHFE8Dj+Sn9B+emtUhhnmGiAxm1TSm0vUFcEWBcV+ze1hMBCDAol8BPj1J2Z4nWXEt9QEV8bs0XfwsowdkqkQib3BfpV6oqaaatUJDX2xbjPWNIzMVLWmc0flhR0qIFeBT9kEd2fNQHb8yhCj/DVesDl0QOSeJC5qvM9HdeVJIh4Wa0bvB/oyxe1Gz+jQLTFZMf/fidYF07Ynb2rViCkNDQmdahYlfuDmyS96CFjNVc/1fvCzAOA42+FAmSZJ56FjJ7WHC9ccKIuyqSII5ja3ojMGfBp9RjtuAhnnYRNb0foCep13uZIG1ZWmTSdotEDcAAgGTKY71hmDrQGKb9Jyp88MtaUDWFEw44N5WmI4joYH50Ma2USzDZ5A5Gyfw0qJKCbnEU3bE2CVG2GRxC8uBxXiRZ4Bbio0GPAQyX4c81P6UhhrlPF81GykW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(478600001)(53546011)(956004)(2616005)(4326008)(8936002)(66476007)(16576012)(316002)(66946007)(5660300002)(38100700002)(16526019)(186003)(26005)(54906003)(31686004)(86362001)(83380400001)(6486002)(31696002)(7416002)(8676002)(2906002)(66556008)(110136005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aTA3a3hHbHB1Y2JCb1JzbG5aMXRIcFJHR1JrQmFncnMwQk9Wei9teE40V0w2?=
 =?utf-8?B?Nm9sakRXSFg2UGJ3eC91d2k0WjB6bmlPR1NHSmhaTGM4MWNwM2hWU0lRK3lD?=
 =?utf-8?B?N3FaTkdVSlF6K082RyswSndidDc4ZEJtOXV2QmVTckIyeS85NlJzbkczUDJS?=
 =?utf-8?B?WFJoZ1dkTEZqQjYrSEpiOWpSVE15QjFjdDRUNG1mczI2bVJkNEdSNHNXOU9R?=
 =?utf-8?B?c2xqbW1jNm5NclNDM3pDQ3NBYnZIcUkzeWJDYnY1L2k5UmRPYm0rd25qS1RT?=
 =?utf-8?B?U1BkL1dZN0M2VWRETENmekc2WG5XRUZ5Z3pGNWJPSWZuM0tLOVdqRkwxN2RS?=
 =?utf-8?B?QTRCVzB1K3diTVp4bGY4aFQrdmpNYUI3Y2p2UGNTamxlLzgrKy80VTlVYlgr?=
 =?utf-8?B?amFGd0xSUmNESzZJVzdhdzAwVFYyQnZKaTU4MnBtamVuQWlHa080bU9Yc2RB?=
 =?utf-8?B?akQ3MjgrVlRkaHQrOTFtYXY2Y3c3ZHpNTHg4Q1pyTDA1UjJJUnNoQ0NpaUlk?=
 =?utf-8?B?QTM0dzJ0WEFCNTJ0TEFwUVF3bytOQlk5UTJLdnY5TDd3VkpjaDVsWnVhRmJC?=
 =?utf-8?B?TFcwdHQ4SExsMWZTNitZdlJVbExmR3dkM3Z5Zm9Eb29yS2FORUNZSTI0T09X?=
 =?utf-8?B?RTVmV2d0TjRaRkVnL1Y4bytxNERCUW0wVER1M3VNM1ZBblcyQ1lER1JtQ09z?=
 =?utf-8?B?dnNZUWF0bWl6NjJ1ZFdwNWdoOGRkRlF1RFdNVmJYNzR3L0ozOENPK0tyZmhx?=
 =?utf-8?B?QmpxZURtTCt1SDlvbkpIbzBNbWxsaEdrYkRDR1Uxc0w5bHkyM2xURmdNN2ta?=
 =?utf-8?B?OFpSdnZMdVdkenZLMDF6NHVMV1BsamU1cE0xNFVXdjhqY2VhZUROa0dzcFBV?=
 =?utf-8?B?T2hTUlBnRHQ5N1R1MEVrbE80bkU3MWFsVDJMdmN4U0ZtV0Q2M1lWQnlxWUxt?=
 =?utf-8?B?V2x1QUptSUp1M3FIWmt0cUJqdHRBYVc1SnpsNUFUcVpqeEVuNFh2NXpoRGxR?=
 =?utf-8?B?Vm9hM3hzdUl2bFF6T2N2bTdLbXhtZWZBWlpjaUpvczE4M1JpekVTZDhuTVBl?=
 =?utf-8?B?TmdDc3MyK2RVZGZ4cEJIWU5Ib1o5K2I3QVlyN29GcU9LbUxEelJNSzdRVWJX?=
 =?utf-8?B?NVdEMkNJcDhmM2FnWVI4aHRGRVZhZ0pJc3VLNzRsOWc4MnRHMGJBU05yRk84?=
 =?utf-8?B?dEZCOW9CMmRqVWRKMWRDazdMQnZHYk1KYjdoM1pkaWpFSDlSWFNpVTRxSjBj?=
 =?utf-8?B?bXlhb0xkQUdKU0RNUCtHREJqNEF0cjUzTmV2a3QzdkwyTXVZMGtsMzNWd3hk?=
 =?utf-8?B?bHJ6MzkrTFdRUVVpMWNFSDM1WDNISjZrY1BJUStRUjBiT3pFcnNZZGd1WmdK?=
 =?utf-8?B?WUlVekM2aDNXV3pNUWgrM2VmTjYrTDdCVGhLaHJDMUZrMUpvaTZaRi8za1pa?=
 =?utf-8?B?ZU5PU1FkZjd3eFZVWnNQTTBKWk95S1BUQVdldmhXT3N1eTVza0RiSGdUMzRV?=
 =?utf-8?B?YTk2U29ROHR0VDJ0WmtjTkRkOEphZC9KanB1akZlVzBZaHBmcWFjdUR5alhU?=
 =?utf-8?B?d2ViWEZXK21URjlKUkxiMHpPZzdsNjF4bVJ2VmxyNSs4bVpBRHU2UWVhUWZP?=
 =?utf-8?B?dG0rMG1VRWowV0pZSEt1RkIyOTFFbEJxalV2NEF4cFN3d0VsRlZabXFldDA2?=
 =?utf-8?B?Mi9WejRmSGFRNDZsL2NOMUcwNU9Ma2RiUHZSckxoN2tTMzRUTW1mZW5oV2Z2?=
 =?utf-8?Q?5mzmyYiPyS1RzcrLco+3thjn9xj62rh0fd6lnFY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1ea1b4-9a7b-4c55-6527-08d92091f082
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 22:02:22.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgpQ0Gmv/S+BrQzPthb7SZVAIdVZfs406EXZ1HnMv14zHjklGsPoCS/BM5bnMKOOcXCgzqDZPLRAWKx1Hegalw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/21 4:37 PM, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 5/21/21 9:19 AM, Tom Lendacky wrote:
>> In arch/x86/mm/mem_encrypt.c, sme_early_init() (should have renamed that
>> when SEV support was added), we do:
>>     if (sev_active())
>>         swiotlb_force = SWIOTLB_FORCE;
>>
>> TDX should be able to do a similar thing without having to touch
>> arch/x86/kernel/pci-swiotlb.c.
>>
>> That would remove any confusion over SME being part of a
>> protected_guest_has() call.
> 
> You mean sme_active() check in arch/x86/kernel/pci-swiotlb.c is redundant?

No, the sme_active() check is required to make sure that SWIOTLB is
available under SME. Encrypted DMA is supported under SME if the device
supports 64-bit DMA. But if the device doesn't support 64-bit DMA and the
IOMMU is not active, then DMA will be bounced through SWIOTLB.

As compared to SEV, where all DMA has to be bounced through SWIOTLB or
unencrypted memory. For that, swiotlb_force is used.

Thanks,
Tom

> 
>  41 int __init pci_swiotlb_detect_4gb(void)
>  42 {
>  43         /* don't initialize swiotlb if iommu=off (no_iommu=1) */
>  44         if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
>  45                 swiotlb = 1;
>  46
>  47         /*
>  48          * If SME is active then swiotlb will be set to 1 so that bounce
>  49          * buffers are allocated and used for devices that do not support
>  50          * the addressing range required for the encryption mask.
>  51          */
>  52         if (sme_active() || is_tdx_guest())
>  53                 swiotlb = 1;
> 
> 
