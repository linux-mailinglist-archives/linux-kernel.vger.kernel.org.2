Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1396039DED5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFGOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:34:26 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:51068
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230203AbhFGOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nta1fSqlZQaVy42jlvfKP+nmNgZYp0OqTd5w8FD384tT5UeOoeEu2mXOrgeq3Gi3tbpUncMwxMSId94TCbgHcNXr0wZ8P6Qu5eS6OIEx2Ss5bp2eOE89Hi3J9myBGnq8OvzY0/bvWRUjFNbGYN3BWW07DLZVgahDun5Ha8vwQtmbtbjfmc9bSSbyN03jlN1SyLVwTwQqvuQLxM23CH+xmjVukx5u06x4jrh10zAsRAzcqO7EUTDtN8PUhB84HjKZnlQP6jgAJ/qrJrxJ5jPyKMi29b/3u0PszkY5pPa/XNGNahYnpaM4gXA2JI49F7If1nQso/UIKkfDU9JkNabWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c676288MzZrfTFL2Csnut+dS/RjvlOS4l10kw9BnWkE=;
 b=UrED01GE2DkjFcauDEdPtD4HmTAe8XS33o6g2pE94IVgolnGe+iLGK7P3M0QtfTkYmKD8OapPdvnUez/YLHJpIoyV6zy0yQ6l4ygaAzWU9bfXKop7cvRDQZczzTv9rZ3lwywZsSik4d2KsHGYrVP+YnogNcN3sajhdFD4w9zTNZoSsn3hmm5kkN8XtidabRjNVhzqfCbDa5qZcnsQBpuQOJ/4Ft/BVEvgyWlg/QzRFGJhUSPE1A3wYlF6JR0YLGtLlowB4p+NwiJ+FUtIAPgD6e/f955j2j9TU0Haj29+kIYYG4+qRB/DAQwPzS1fEy8SNIMryFp0IyqBIXKOmERCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c676288MzZrfTFL2Csnut+dS/RjvlOS4l10kw9BnWkE=;
 b=L2qHX/tHYwqEoGrVUAePqIR/F468MMFKASi5Gb8+OdmLSdBhHnovDP2FOYOtagMDK+djVR9qXg/GJEWQQMQbNJEs+5PCo02XN6lCwAyp+dH8jTnn7Q+OKG6mtQG21UNC48y0VTBHWiXK/yHjaSQ3ec+9PuqiXVIWz+YUmXFwh4M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Mon, 7 Jun 2021 14:32:31 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:32:31 +0000
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <dc064764-7736-33c7-7a32-b4dec68eb745@amd.com>
Date:   Mon, 7 Jun 2021 09:32:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA0PR12CA0024.namprd12.prod.outlook.com (2603:10b6:806:6f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Mon, 7 Jun 2021 14:32:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5976b576-fa0a-4a0c-f90f-08d929c1154f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4942F809BDDF562E886CD7ACEC389@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2obNTY5n5yNWZ6Ant54A3sAHZkajaDIkVli5p0yac8yPdW0cPax89t6lTy7hPHjw4qlBM0VIa4qZgW/UOy24Wi4244H/xXyAz5yheH1LKdSvBXyquxgDtNP2MiCee2tALZnFvJ1ThFN+91X4SEND6yb9P0WjxUlmlFzswybMdVkJdbdfxjzA/axFijik/H8pKT41S1B83DLWlbFHU/gHW4VdXWWyoqJ3vl/A5glmnapmrnBTXXjBIKVXVAsXAxzmNYfZ4YPvkkTPBRB77Ei/gpaA0rDj3ZYPf+OkynbOPnv8XyNaZM9pywvfNAkGCSpue3iHk566fn1pYGCC5b0yID117G7rjRWbCG+6uKjD5CnDbKLQD3X8J3cb2X4TlMDOW0zz46jfsHwTzwkHOTKKSWDEnAJi5Wh/ES3eUl4Zey1UHhf2gDMvuRTuyMuQvlKtVPhEMp2JVV3DrHLsNQGtPMc8I/Dvze54qDeK3TkkFfEbTQdQrwEJLLxHdjPmjwuZHl4ambX6M5t9/jqWKodiPi3vBTkcgZQetkaklh+M4tJtQRu7hWTmhC7u57oktfqh8mj3o52Wbls57oCozjKZibpimx3KOPXVGugoLe1ZgjABsr0Xu7KVZDDxviGx5/dBLzZRot3U8XaNCAMISkJ48bohdIQPfxOiueoCqQuGqa3g+4mwZza+xu5PQKZe6Sl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39850400004)(4326008)(8936002)(54906003)(7416002)(6512007)(31696002)(66476007)(66556008)(16526019)(66946007)(31686004)(86362001)(26005)(8676002)(53546011)(2616005)(478600001)(6506007)(5660300002)(2906002)(956004)(83380400001)(110136005)(316002)(186003)(38100700002)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MEc3Nm9UZXFFa05Hd2tvYUNRYkRBWG5oaTBsSDg3VDNXZEJZZ01jR09DWkFa?=
 =?utf-8?B?dFNkdWlJKzBmakpqOEJ4dlFEdWtUeTFhbExKTkFFdjFsdGxOVUhVWlZxY1kw?=
 =?utf-8?B?S0pWTGJUTDMwUEI1N1BXMVZCY0xDM29kekF5Nm50a3BIOTJXRDlhS1lpK2cr?=
 =?utf-8?B?RU9rV2NrSkRwRUlMQXVXMHl0UUpFZXJ0djMrVHBFTlorV2Z5dHlJSDFaWW9r?=
 =?utf-8?B?VVVvbmlxMlh6a2p5eGxTMVJ5R3E0SnRybXY0aExQMERmTzdYZFpESHo0R3Vi?=
 =?utf-8?B?ZW5hNE5OTStMajVYeS9tWTlhUTJiOE5qL3ZtMUdlNkgxeEFkL1RPTUlpNkcx?=
 =?utf-8?B?WStSZFQ1OTNsWmw2aW5uWHRJeDdSWUlDUXNTdGdDa3J2L2tSTDFZNFlaWGU5?=
 =?utf-8?B?SEtiVTNDK2NNZzBCQTZUVWFqN3pQQWVQTHM1VWQ4dmdSN2toVWJnaUJ1MVJT?=
 =?utf-8?B?ZlN6WnQ4Z0cwMEJvZklhSDY1K2VqN0FvYmtId0NHTjdTOXVhKzh1Tjc5Ulhi?=
 =?utf-8?B?OUhkekxxNldKdmszdGwxS0U0QUJrWHBzTmxBZXNSTjF4aG9meTZpUkt0NHQ4?=
 =?utf-8?B?cGd3cGdFVGRYVG81RmVLVzczWFdjOEx0RnIxQ3VqVjMvbGpoUmJJSjRhUjla?=
 =?utf-8?B?SWE5Mm0wSXBibm1pa0hHRmdCMUdtZW05UHZjZjlsekNra3YzdjFXVTQ4SlJq?=
 =?utf-8?B?d2RYUjNqMDBjZE1saFA4TGcyWXhaTE5PZ2Y1MWk0bUhHckYyUVNWZm5aOVpj?=
 =?utf-8?B?dzZMSFJOcldldUpRUERIR1U2eTY2YmZtdnFqbUZFRDhMTXpaM1g5MkE5M1Zy?=
 =?utf-8?B?NnVmaU81QnRKVlVidkxtZno5a3kxZDhDUWZTbkh4bWU3a2JraWQ0bW1Ia0th?=
 =?utf-8?B?SE9reHI5RzcrZDNZL1EzYVg0VVhQQ3VvN3BlbXNESGhiR1lOQ0RXVno3R1Vl?=
 =?utf-8?B?c1BBR1pBWThxUmc4M2xKaWtTTzZuZGlHMjJ5NlB5ZkV2TW0xQ1QrMEtCMEJq?=
 =?utf-8?B?L1VHMWlDNm02MGpQYldRTHdDQVN3TWtIWjBTaHNuZFY4TjFQdUxtZU93clR1?=
 =?utf-8?B?NTB1SnBtUzBUczRHdERGaUE5c3RIbEJjTzZUV1FZVGFPT2lESjNjRW9LNEFh?=
 =?utf-8?B?alZCV2xHOWgySFhSYkRZUDBiMXNwaWlSdEYrbUxhbW02a0dCRGEwTHRwd0NG?=
 =?utf-8?B?aDExZUtpQUlYTWV4RXFDdjNPY0tSVmFZQ2tSZWpDNGh5Wjc1WC9KczI2bHZT?=
 =?utf-8?B?NTJNdlJrVWtkSGpHZUc4T0Z2OWtSaEJYczd2SGhYbjNoc0FsbE1USk9aQ0h3?=
 =?utf-8?B?cnFwWEsxVnNUcEFQeWREQ2c0VTB4Q2NuN051RlVyQ2Q2NzN3N3NpcXBwR0dx?=
 =?utf-8?B?NFF3QXlqMmJqa1ROWHAxK29PMHRWdDJxbjdQaHBJZk5tYk5aOVJWTGRQK0Zn?=
 =?utf-8?B?Z3RjaXVpNXdxRHpoMzdiaUpqRTlPdzJvZllpM3pMVllsd1JUQWcrZEJXRk5z?=
 =?utf-8?B?YmMrS2dmZ0NRYWt0UCthdmhFd3BUcFFGNkpSSE9sMkg3UXNuR3J4OHUwNEsr?=
 =?utf-8?B?cGxSb203dW9mVFQxcVhTcG1PTG9BZ3N5MkdIbHlOcFhKVXJWT1VkeVVQU0RC?=
 =?utf-8?B?dU41T0NqWlMyZWF4UVdZZnpHRi8wTjYrOUgrZFNCdHpFdzg5TDBFQmQ0dUMv?=
 =?utf-8?B?dlpuaThjZFZDdlhBcnMxNjdDTGhPdHBXanJWOHB6VXJmOEhWbzgveEJDbzdr?=
 =?utf-8?Q?n1K37nuLIXpc7oAx+9DM6yZjFNP48S5Oxs/O1Aw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5976b576-fa0a-4a0c-f90f-08d929c1154f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:32:31.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WL25t45FzC0+CRCzbAS2yzSKxhyIMn+qs60cgCmodVdXaXGqygttDp0jr0Ow0eoMUhdgIk7px/xXgDkUc5X+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 9:21 PM, Kuppuswamy Sathyanarayanan wrote:
> Add CPU feature detection for Trusted Domain Extensions support.
> TDX feature adds capabilities to keep guest register state and
> memory isolated from hypervisor.
> 
> For TDX guest platforms, executing CPUID(0x21, 0) will return
> following values in EAX, EBX, ECX and EDX.
> 
> EAX:  Maximum sub-leaf number:  0
> EBX/EDX/ECX:  Vendor string:
> 
> EBX =  "Inte"
> EDX =  "lTDX"
> ECX =  "    "
> 
> So when above condition is true, set X86_FEATURE_TDX_GUEST
> feature cap bit
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

...

>  /*
>   * Manage page tables very early on.
> @@ -491,6 +492,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  
>  	kasan_early_init();
>  
> +	tdx_early_init();
> +

Just a real minor nit, but does this have to be after kasan_early_init()?
If not, keeping the SME/SEV/TDX calls "together" might read clearer. So
just moving it up before kasan_early_init() will group them.

Thanks,
Tom

