Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C806C38CADA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhEUQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:20:46 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:34049
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230060AbhEUQUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqOawVIWhPjovHTCBlcgOI0z1CRKjaWHVHJQlZelyYYMCHf6fy5rtrCukiWAYR6NU+ggB6fTbSb4euUyHu1lTUEe17uV4VkkCdguGDHmA/fLYUmk5U+ifHNuEZECmb51oMvfX3ePKnhePzYzCWjxO1cZESeBoYB7jgcjE+iXyVaI3M/n+k3YPQCVmzYHEjr/8L4nU7JCvZYaECek/W6OSVvtVz4AiYXOwsumZmquYkPfxvR1wHLPGYiqU+bnJgIsCsv7qFMMUEfNNftCVlZvexJhXJhnnNweyPzwE7Dj+GtbEQS1Jxv0vKjJx7/S8RL6VPw+XtjCnTjLq8+498jQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpuPdtiRxhZZeJEPqLHyuXJd4UkTKmFbP5CXJDuvx9I=;
 b=l9zpGVz04p/r8wwb8eGxs3SRfiFQKwChqlrwVxWc5URlZnCW1nlWSx1KsIwtmHjD+dQCKzTIyPGqBRkGLVh6CvtIccfvdSLzOdY9gER2XT+VwdhDeL9AtN/Za5ulYtCg0TWu4raPnVXDb6BVe8t/aMDEzINQnB7k4bR6dwohQsiM8YD3gMnItT5h7lzdrATBWByW7BkYJ63lhOdXeQeSUHcaqeDgmeI84SCZNzlG+xOBeYF60UtH+yPa2KZLTRmeeNYVUswePSGR3XR83ylveIxWwd0F547vBja4Kt8Ud3KFMdQlDTGdnCl/cbrD9O8d5sXsoTCn/5ya4WbwrIhYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpuPdtiRxhZZeJEPqLHyuXJd4UkTKmFbP5CXJDuvx9I=;
 b=xZ99t0nNpnv4SV9ei8jxCYCiMJqJA5+uvn8q6Nx1ZVipk/37Ia8ZT866V11eiCIQN6zb18YEVbikFbLmvXYEP/qy/F6TwWt33ap5BucVZZjz6IuZPcyBXrEebNu6Lf8nh7Os6/UahXIjT+KslN5vL2V8H1lDlwKLQwVJ6EYln+M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23; Fri, 21 May 2021 16:19:18 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4150.026; Fri, 21 May
 2021 16:19:18 +0000
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Borislav Petkov <bp@alien8.de>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
 <YKfPLlulaqwypNkO@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
Date:   Fri, 21 May 2021 11:19:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YKfPLlulaqwypNkO@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN1PR12CA0065.namprd12.prod.outlook.com
 (2603:10b6:802:20::36) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN1PR12CA0065.namprd12.prod.outlook.com (2603:10b6:802:20::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 16:19:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43cc503-b7f7-4363-1e63-08d91c742f42
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3868109E237317EE8A98161DEC299@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haovOThTGX1mdtB3QVToNiA2m+JU7HjJitekXOBWgCnZRtNV89O5i5au9pbpmJyT4Ob+fYrERh5tHpNfj7ezhykaXpn7e1yo6sfDk/uaPPa2aW2IUmc3u/LVBUVexW1b8vNe3ecTnA/wvwCEVR1RNvIHaLFAUnW7MczMmvcu+/IoA+KjOluXQl4vXgfqcSreYvRtPLzl4wx7DziyyrP9jwIwJIpkv8/4HCsmXshnB/8onujBAZOBh0B72QYEBnCsEIEuNTaJncyS91w2KhGWTdZveGWcFFFRuahM4PkSg1AjKUpD2HKajsfv798vPKexq+JeTTqD0U+9JtJyUD4X+9B+BSjYFVc9dFhEhkhYXDn5/DUHIz7Kyktp+q2yK3rb8syxA3UgZESSIJTilx8OCy14hT/9OQu2R4xGVZisEQp55TZkmK1wKG4T96YZNxPBC+78PyUDEWlDu1iA5gzdxvIfuPQagJkX/o0YI5JOydAhn/TrTuVjP6mAVKJtxYTG1h5biK5FKg1IzjtHS9u+KLf8EKJZncQa8OlNHYaBugL/PY7OjduybJH+xJ5CCQcEw2WcmahzOz6H7A9qVCf0TXJ1a1VtU9CLKjp54tMpVEL8nrskvRwD0SENASkwN8urpjz4bEiPqM+Z5jUfoGXsR83M9iVa8YUadfAHuOs3iCTLY5eoXkTqe5T3VJo/f6h3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(8936002)(8676002)(2906002)(31696002)(7416002)(186003)(66946007)(54906003)(83380400001)(26005)(66556008)(6486002)(66476007)(53546011)(6506007)(6512007)(316002)(86362001)(110136005)(38100700002)(31686004)(16526019)(956004)(2616005)(478600001)(4326008)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a084Z3FwankxR2x2d1lwNnFHSmpZRmJ1S2pKVTdrZUw2TVRhclMvcmYzc3hJ?=
 =?utf-8?B?SU15SGErcGVWTm9SSDQ5QWpPREtDMk5WTWd4WWZVbVptS2FEVGV6dGRvMklC?=
 =?utf-8?B?czlPRTBwcDI4MStGWUxXREliM3duUkRKNHdyRFg0Tm1vUFBYTnY4cFV0dVNp?=
 =?utf-8?B?NzYzUGMxVmlUMmRmTnlmSGxwS2kvaU40dGZoRnBNb3hORFNjNHg3cnhkbVdt?=
 =?utf-8?B?S0czMVh6RmRTcmZVMmIrWDk3Y0JUcVVqOGdFWE9WdnZCNS9ybkcrZXN0cnVS?=
 =?utf-8?B?d1VhSXJqSUFzVnZoTk1zTWVKd2R4TjZjUlFDcTRick5hU3ZHWVlIT3ZGM2N3?=
 =?utf-8?B?enNPOVFjUUZuYkZQaWVBWWI3R0FocTdMZXcza0huMGp4aitkYmtMaXV1aWJG?=
 =?utf-8?B?V0M3bEtvNDQvd0d2ek9TSUlUTWRld2Q2MndDUzRkWFExWHFzT1hRcDI4NFpT?=
 =?utf-8?B?RjJkeXR0LytzbFA2TWhybkM1RUhBNmZ5dG1TdHJraTBOZ2l5RGovQXZBVVJL?=
 =?utf-8?B?eVQ5SytabEJxSE9YT1g4b3BSTkdSQmdicXJrUU5ZQko5Y3d2d0NKSnRPZEpx?=
 =?utf-8?B?UEllZ280eG15VTNTT3ZsUGVFYlpEdUZ6UlFMdEcwNy8xZzljS0pybGNkSE5K?=
 =?utf-8?B?dFJsZ2hMOEZRLzBXZjF6cjZYRHJtZkxYUjBDcGx0L211ZVUyeDRrM05mSTly?=
 =?utf-8?B?OUp0ZzlQMTQ5bldhM3loYmRwMUw2ZXBUSnUzTExpVTBsL2xQQUtRQUcvcDV3?=
 =?utf-8?B?RzNvcGNjdjhOcm16VStXSU5PRWdxVGV6Zk9jeThkbVZVUXl5dHoxL3Z1QS9Y?=
 =?utf-8?B?NXkydXRPV002QWl0RTRYTjJrcTV0NmljQmxJOGQ4MXNiYlRnbSttU0loRmh6?=
 =?utf-8?B?cGxWdnQ1Z09kRTRIQzR3T1NMTGtNdys1WVBVaXIyUzBoc1JIMWhCaTVvNnVj?=
 =?utf-8?B?VW9qaldOa3NiS003UXVrOCtjamMxWVVwaUJ6VjJlbDZqenFEWjVEcmtOTi8w?=
 =?utf-8?B?ZUgwVE8yazF5alArc0VoMkRPekFFTWZPWm9tV2plTng0VTZsNzBKN3QvVFpC?=
 =?utf-8?B?UXYwdHpkMUtOVldQRmxkVDB2bERkTC9kcWFiUit5Mzh2UURZeEU5OFhXUWd1?=
 =?utf-8?B?cC9nemlqKzZPNkxMdXlrenY5S1F5cjFkKzVsTjl3NE1KRWtmeGFNMUZhTFQ0?=
 =?utf-8?B?VEhIeVFiQlN2T29vRzhoRTZDUmdUclpCdU9qOWw0ZVpuNkhSQ3hPdUg3cmov?=
 =?utf-8?B?TkV6aWFKZCtDLzd1QlVSSEswUHpUWGgxaGY2RnE3cnVWbWoxL05KcGhlTDZr?=
 =?utf-8?B?V2xhQ1pMVjFFa2VHVUlqRFc4L1BmWmNTTDFFdFd0Y0U3VkFObnpiZGFNd0l0?=
 =?utf-8?B?dXhQZmRJZ1pDbnRUUUNjYlM3VlRtVDM1eGFPSm5ZakxhUWpSZG1rdUNuQ3dk?=
 =?utf-8?B?TXA5cFVxcTN5bGIxa2ppb0JQR0FkOTFqVU45aFJaSURwaXpQK1NQNHpqZVR2?=
 =?utf-8?B?SnRnZDZmVGtDelRycS9LVTFWNnVsa0JCUTV4eVV1QkNqUVZ6dy95a2V6NXpm?=
 =?utf-8?B?a3dKNEhQMlV0dnZiQXRMYllOWnJwUi92YSt3QUh3SXUyQlVEajVVUWlkNUFj?=
 =?utf-8?B?Njl3a0JtQzdjT2diMUZITmJOMGdBcDFVc1NMZjgwZW5EdGEzRk1BSExsTDVK?=
 =?utf-8?B?bm1MdnhqWHhlNTB1TmdnelB3dUV5d09tMllXOHQ4dVp3ZlFTWUFPdUZsUWh2?=
 =?utf-8?Q?Z6ti3Ejhqt71Lye85Ki1tbKuw1TS/rYkxLfDrpE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43cc503-b7f7-4363-1e63-08d91c742f42
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 16:19:18.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEvk4aRezB2Tl4wJX6iqtHMkHnORv7ZLSJiHsJRhN96bze8jIf9P42ldqS9blxXcb0fpl9vtpB8d0mKkRQn7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 10:18 AM, Borislav Petkov wrote:
> On Thu, May 20, 2021 at 01:12:58PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> I see many variants of SEV/SME related checks in the common code path
>> between TDX and SEV/SME. Can a generic call like
>> protected_guest_has(MEMORY_ENCRYPTION) or is_protected_guest()
>> replace all these variants?
> 
> It depends...
> 
>> We will not be able to test AMD related features. So I need to confirm
>> it with AMD code maintainers/developers before making this change.
> 
> Lemme add two to Cc.
> 
> So looking at those examples, you guys are making it not very
> suspenceful for TDX - it is the same function in all. :)
> 
>> arch/x86/include/asm/io.h:313:	if (sev_key_active() || is_tdx_guest()) {			\
>> arch/x86/include/asm/io.h:329:	if (sev_key_active() || is_tdx_guest()) {			\
> 
> So I think the static key on the AMD side is not really needed and it
> could be replaced with
> 
> 	sev_active() && !sev_es_active()
> 
> i.e. SEV but but not SEV-ES. A vendor-agnostic function would do here
> probably something like:
> 
> 	protected_guest_has(ENC_UNROLL_STRING_IO)
> 
> and inside it, it would do:
> 
> 	if (AMD)
> 		amd_protected_guest_has(...)
> 	else if (Intel)
> 		intel_protected_guest_has(...)
> 	else
> 		WARN()
> 
> and both vendors would each implement that function with the respective
> low-level query functions.
> 
>> arch/x86/kernel/pci-swiotlb.c:52:	if (sme_active() || is_tdx_guest())
> 
> That can be probably
> 
> 	protected_guest_has(ENC_HOST_MEM_ENCRYPT);
> 
> as on AMD that means SME but not SEV. I guess on Intel you guys want to
> do bounce buffers in the guest? or so...

In arch/x86/mm/mem_encrypt.c, sme_early_init() (should have renamed that
when SEV support was added), we do:
	if (sev_active())
		swiotlb_force = SWIOTLB_FORCE;

TDX should be able to do a similar thing without having to touch
arch/x86/kernel/pci-swiotlb.c.

That would remove any confusion over SME being part of a
protected_guest_has() call.

> 
>> arch/x86/mm/ioremap.c:96:	if (!sev_active() && !is_tdx_guest())
> 
> So that function should simply be replaced with:
> 
>         if (!(desc->flags & IORES_MAP_ENCRYPTED)) {
> 		/* ... comment bla explaining what this is... */
> 		if ((sev_active() || is_tdx_guest()) &&
> 		    (res->desc != IORES_DESC_NONE &&
> 		     res->desc != IORES_DESC_RESERVED))
> 				desc->flags |= IORES_MAP_ENCRYPTED;
> 	}

I kinda like the separate function, though.

> 
> as to the first check I guess:
> 
> 	protected_guest_has(ENC_GUEST_ENABLED)
> 
> or so to mean, kernel is running as an encrypted guest...
> 
>> arch/x86/mm/pat/set_memory.c:1984:	if (!mem_encrypt_active() && !is_tdx_guest())
> 
> That should probably be
> 
> 	protected_guest_has(ENC_ACTIVE);
> 
> to denote the generic "I'm running some sort of memory encryption..."

Except mem_encrypt_active() covers both SME and SEV, so
protected_guest_has() would be confusing.

Thanks,
Tom

> 
> Yeah, this is all rough and should show the main idea - to have a
> vendor-agnostic accessor in such common code paths and then abstract
> away the differences in cpu/amd.c and cpu/intel.c, respectively and thus
> keep the code sane.
> 
> How does that sound?
> 
> ENC_ being an ENCryption prefix, ofc.
> 
