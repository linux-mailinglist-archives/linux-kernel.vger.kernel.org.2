Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C793B68C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhF1TCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:02:19 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:38075
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233101AbhF1TCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg6Zd7UQMywTJ1RPVg6RW1aLDfpguZrO31kbRWCvrrRipRPp+tRW71KRuPuh2gJdaVVknWycmHc3hYugw4cPrkYb+thdDChed9zX4MngsYt3VAulHMQa2uMbVVoqCRY6PLSrCoQoTzOES9Z2MERQnWGyzOwXpjJU+02wRvSMMGpEoaNXDW1AftwWxTB/eiktMCFvxnILLuYbxKLHe0c0dm4HGA00rCiT8rOEqurmncY2yFCSE9nVOiirRQF2Qb2xVIeFlULCGF+cirkakC66PTXtkFEGbK2IbuESg3/7cZquDhh+YzGA7PhAMpfPJP8TgVkfr66BWo+E4yVLtnKOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpEezo7kt4hnEAbrtC+0WU+Ifeei2Upwg6juGtcjgv4=;
 b=MU2wLgNJGQ1tvLVk8Z9QKeq2JqWW7V04cH9Fn6FuK3tIXmDqaa5EdsO24q8RL7qi3JVfKFAVOmJTeitO8N1UkQtd6NX/imLaiiZoD3A+hLdCugcao/VZYbMIlJ4J11jhEBppxy17gx2m06YL22Tx0kagrsrVXWBg9ZHn+9G0Bl/ZvSSNMHpOeXtwA9yXPoK8yg+D6mTev3TEMQAiW7cUZ7tkb0hFFKeZ7VgYldwWkZ6JDhcApNMQQUfB/Ma2Q1ggjOE4ImdiJ8pNiDxOpZX+7so+b2LgePonLlhNpXYghEMHrMZ3sKO5EceiLRYaSyqKqbCmCP93LIRbAr86SVT3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpEezo7kt4hnEAbrtC+0WU+Ifeei2Upwg6juGtcjgv4=;
 b=oC3SznD9CIrreJ6WDzRuXWQyACvHF9jteTmHRLhdFEnGkvIbsovAOkdYtZRpeKhIJi41kt2gvMEzWag/HklxRF2QAf3oKtf2lbxWM/M1RyvX+WASpTWzdWOQCBre4RRSARwYx0fnnKohT/3+Mjdjmp58gh5IW93hVjX6ddEt7Jc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1257.namprd12.prod.outlook.com (2603:10b6:3:74::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Mon, 28 Jun 2021 18:59:50 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686%12]) with mapi id 15.20.4264.026; Mon, 28 Jun
 2021 18:59:50 +0000
Subject: Re: [PATCH v3 04/11] x86: Introduce generic protected guest
 abstraction
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9e188172-772c-8a33-46c0-e1e4bbf2668d@amd.com>
Message-ID: <8d67d63b-75d2-8927-9308-b5aaba38ab92@amd.com>
Date:   Mon, 28 Jun 2021 13:59:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <9e188172-772c-8a33-46c0-e1e4bbf2668d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:6e::35) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:6e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.21 via Frontend Transport; Mon, 28 Jun 2021 18:59:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a211825-a2c4-4856-62ee-08d93a66e826
X-MS-TrafficTypeDiagnostic: DM5PR12MB1257:
X-Microsoft-Antispam-PRVS: <DM5PR12MB125765424F71AB7F03D74F53EC039@DM5PR12MB1257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2vcetQgl/VkwcQzRPacpL27MEKpd7xmJHzNQZ0C2mqu1xoHIJHn2J5RYtYqvxApkvdCcJ4d0GQfWTyjKZyumnp8gHrt3EM7bysbO0d1PEZirdX8PanZSf1ph2O7VP02xzsl/PM85dq3adNSsmN+r0mOT7YarYEur9ZrXx066OT3dWEOdyBelEjUZYZ43ZWcXsjLPRfV/CEEtOsUruEcQ0lYn1Kfnp8wdGtHfjNIsxGeUfOEhn7r4n4zpNReiwdmmDuzY7T4J+xaYyoSJRZ2nMWoKzNY+aVvF0smijh4Pc9NIgX02Gop+gC5pM9aLKRpXwmIdcXIrCuUHwCkEN7egpu8S/MbMOcGYPCstD6ANRMIIPQDgRI1ioKuXSr8z50xAbUvjQiFA80OvMeq2DwOCvfN5UCkGQNeUotEN8KxqAfZN9iGTIpaAklaZVT0yr01DXMReWq2RZleDD1dQ4WOABOEvLhYkW/gi98OYTIz/oG48HKBB6DDi4gXDN/mjQvAzBOn9RyjM00QxUR/cS7fXg1JsJd6R6GkNIgGvTpxepVv9C7HJ365b5xkYfXNrzi7ZzwJdE5DVJ6/HWWCkJaQ/4lhng/tyXACN+D98IjOUSSLvZo26pKP14M3AHIaZYkZWP0v1bzCkErETqtNoio0mNVAkMUY4n/zs3nc8fD4PEzlZIJefgJ5EFXOjEXBxK+lwtLyafnlVHgKmPp5zmZbHgYmcjh3TXbvWTKm31jRJ1tzKQ5pw535IfPaKrrWwTDUfr8H71y5ezgE07JkEY5KsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(8676002)(8936002)(2906002)(7416002)(31686004)(6486002)(6512007)(5660300002)(38100700002)(2616005)(66556008)(66476007)(66946007)(956004)(31696002)(316002)(53546011)(6506007)(54906003)(186003)(4326008)(16526019)(478600001)(26005)(86362001)(36756003)(110136005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0w2ME1Dand3eHRVNG9zcGtMdE9zWk1jeXBma0VMSXJDdzhCQ2c0b05EU0Jh?=
 =?utf-8?B?Q1lPbWRzZEN2WldYSC9McHh4N2xOeEhjVzZnU2VQdThYbnN5Nnd3WGc0ODg4?=
 =?utf-8?B?S1Vub3VycFZWR09DODI2S2syZmgzTGdTd01WTDZXTUxlWTFtUmhGNlB3Vm5X?=
 =?utf-8?B?a0NIVXF4SURqS1p1K29FSWF3aGRCMmwxeXd4NkREMk96ZEhudlNEeGhZVzVE?=
 =?utf-8?B?SlRXWGZlWTZ4K2lha2tYYzFob2ZGTk5GVkVldHZVN0VPV2lKS3hNSlA2b1pi?=
 =?utf-8?B?NVFzeDhVRTRGRWhvL09BWnlnN0ZYRTlPcHl4NDd2OUVUbmp2WHgvZitreklY?=
 =?utf-8?B?OVIza0R6eWEzcUdGT1pyM2ZYdUZuR2lJMC9LN2hFSnVlRU5TWnJXWDE4Z2kw?=
 =?utf-8?B?c09aTmsvWXp6ekU3ZkhTa3ZkQkJPRnRvYTBzczR4dmx6ZEpNWXlrdnpZZ2RN?=
 =?utf-8?B?eG5MYXlpUHE3NVBQc0R2QUZ0NjFISDZYZ2loTC9aYUJZL0NwQ1VnSTNBd2FR?=
 =?utf-8?B?dnQ3OWdsWjdua2dtdkE0d1QrVUI3cndqODRWRnNsNGlEenhjNFVFVGFnSEd1?=
 =?utf-8?B?ejZnT0JRRi9HeDVVWkQ3REg3ZWcyZEYwdkFib3hRYThxenAwcjBTRUhpYnA1?=
 =?utf-8?B?MkJ1aTNaRnFQU0Y4dlVOVWRsaWZ0QkxGVk1kc0RUNDhJMy9ZcnREN21ONUpM?=
 =?utf-8?B?Q2t6VE5qbExkV0NDT0hodlkvdnFhb1BhMHMrKzl3Z0dLQlBaN3gzUEhER2g3?=
 =?utf-8?B?cndBS05XZ0lFSU04TDN2TUNydDhoRzloRWhSanFaeS9ITGMvNlNlNnp3WTZY?=
 =?utf-8?B?RkZWUzJTalQvYWhBampnREx6RG40K0dCL2Q0N0dtQStwcjVtL1NjdXRJcGhk?=
 =?utf-8?B?NFByeE9KdWNyUDJGTW5YOUlJeC9ZaDNXTHRmZjB3NGhoVm9aV05HQUxLU3dQ?=
 =?utf-8?B?Sy96NkZWUmlBaU5McHFFcm9LQWF4OTBhU2pjOU82a1RNaUFIMmhKaWhFRWZv?=
 =?utf-8?B?OXdmNXpuVUFiMWtxdjZoSmd1cVVGamJTR3gvRTBVaWhYbmVTYmljK3FrdlY0?=
 =?utf-8?B?ZnhzdGV1RVhtWHZWVkJRdVpHb1dKbzU2M3J3WmJ3N1cxM05jRnN3YVU1UkYr?=
 =?utf-8?B?RkxuejhBVDVid2I5ZzE5OUEzS1JKdGp4WXlnKy9QSFluMEVtRzQycmI1SkF1?=
 =?utf-8?B?SVpZbDZMTkZVYUN5V2tSdk5uYWFlSkZaRzdkYWZpRlh2N3lNR3lTSC9JVnRj?=
 =?utf-8?B?OGlCdWcwNnZScHFrbWNaSzUvTWJuUzBmenZacTV4OHM3eDB5a1I1K2lhaVYz?=
 =?utf-8?B?WFZUQnljN1NIdXFEL21Wb1VrUExuMUJPTHphL2RzbmVqRDF0aC9zY2NnSzJJ?=
 =?utf-8?B?RkdqblpUYzk0TFplZ0x0ZDNrc3ZmbUQyTEN4eXJsM2l2TUhneS8weVk4NGRF?=
 =?utf-8?B?UmZheCtZMVpYN1Y2ZHcwc2gvTzFnVVYyVkhSWG5PZ0x0NUJUYUlqVVZScWJB?=
 =?utf-8?B?Q2F2TmRNQU9YUk5sdE1kMU53WE9QQ2VJS0VOL2t5a2tsclliQU5aOUV1dXpr?=
 =?utf-8?B?QmNiSXV5VXhrRmwvNmtyWkFIVkJqYjhhcEMzZVhYL1FVa0hQcDNTWWhIVGJJ?=
 =?utf-8?B?MmNBUDFpc2ZvK3RaOFREWXFWbFVSYmtvR3UxNE9Mc1Mxa2I2SjhPajlkVVRp?=
 =?utf-8?B?bFJOTVE0Y0Zabit3K0FxbEJ6eGJsWEx4cmlDd1BFUFFoeVljK0tmWnFWeFEx?=
 =?utf-8?Q?xW3VGbIp9k4sfRJdeYicQHqu6qxqzMdKksOziRU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a211825-a2c4-4856-62ee-08d93a66e826
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 18:59:50.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSCRcNrb3swRaraYIyjGXXIIIooDnjONsy99ycBjufP6AIthUDLvuTmgZE9cq5FO+GopWNYHSnrMwGJmpdC8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 12:52 PM, Tom Lendacky wrote:
> On 6/18/21 5:57 PM, Kuppuswamy Sathyanarayanan wrote:
>> +
>> +static inline bool prot_guest_has(unsigned long flag)
>> +{
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> +		return tdx_protected_guest_has(flag);
>> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +		return sev_protected_guest_has(flag);
> 
> So as I think about this, I don't think this will work if the hypervisor
> decides to change the vendor name, right?
> 
> And doesn't TDX supply "IntelTDX    " as a signature. I don't see where
> the signature is used to set the CPU vendor to X86_VENDOR_INTEL.
> 
> The current SEV checks to set sev_status, which is used by sme_active(),
> sev_active, etc.) are based on the max leaf and CPUID bits, but not a
> CPUID vendor check.
> 
> So maybe we can keep the prot_guest_has() but I think it will have to be a
> common routine, with a "switch" statement that has supporting case element
> that check for "sev_active() || static_cpu_has(X86_FEATURE_TDX_GUEST)", etc.
> 

Or keep the separate vendor routines for separation and easier testing
but, instead, they would have to key off of the support:

	if (static_cpu_has(X86_FEATURE_TDX_GUEST))
		return tdx_prot_guest_has(flag);
	else if (sme_active() || sev_active())
		return sev_prot_guest_has(flag);

Thanks,
Tom
