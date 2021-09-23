Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D39416361
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbhIWQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:34:04 -0400
Received: from mail-bn8nam08on2069.outbound.protection.outlook.com ([40.107.100.69]:11617
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233964AbhIWQeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/SgX3gd5bG8xfMbhmZXXXYIgamb4bGdDYuuiDFAsbMqH4RpRn1lcxTOygTJA/ur3FIClck2e2CeHj4AKT3DArJ55cKeroK2EX6Oogzjye7pFDRKNSX7sfV+kLZNPtGdrOPs2MssJXuTRZz01BRQpvofalUia36jwf1code8KwuXcVUbZnxdzdzakjiSYWdTKb8FaBO3RntyVhiUxtUxnBs9usyiMvPpvJxde2P6AfrUDf69dC6tAvxYahi9MdF4WcIuMLrwKVvVruC3a+zxI+MMppCgks665iTovfr87aFAVjpbFJbEv1CttiTAqG8ULzCLW/ZLRUmg7zOlKcN6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6HwDk+SIy2/k0lhoaeaOBcJizbojs0uykNs8xSFda08=;
 b=gIsbs6Btb26hO2I3hQpkTwFZpAH6ajp9eWcKpnwBE6pUJjn5hRjBTMiLo7RfJETYQ7RsRMPKs17EodRTWT23+Qdz6bmj9hq5OLNJOtJ9rmhgSWlMaypttF6x3IeXd8/iGa3oOqq3l+xhicqeuW1GE4zMan1ZSNZdwInuvOdqYHHmjKU8wByjxJPkt/Uh+Ni+QZ2gmXyGfNULBISFyIzrmIACcIFa1mEmQfKp1C4WwrqmyijDSwdEa2FTGf+3ZAhF353MqgJ3+j63Gpc/QrRHdQVe0K1I/EOyxNq1euY9vr33MZRpIMm9orDdD2b9ei/F7X8yWKWSzDXhJoxts1rAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HwDk+SIy2/k0lhoaeaOBcJizbojs0uykNs8xSFda08=;
 b=PR0kH99hYPCrs66Uc5XZjINxROgzfZnJE4RYF4+bgUoGyE+pEkbFyK1gFgxDMTuaW3Nzw+8bTnXkGZ29BHYSxmD3IZo8jibk6HyKF7hBMong+kyRzbGSzleJDUiOq+kziEC5CoeRbeI3BVQ5WOs5LyZmdiwb8iENGO8+q/XwJJI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 16:32:29 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 16:32:29 +0000
Subject: Re: [PATCH v6 05/10] x86/tdx: Handle port I/O
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210922225239.3501262-6-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c2fa7839-49d5-3e1c-97c4-c1b77e11ef93@amd.com>
Date:   Thu, 23 Sep 2021 11:32:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210922225239.3501262-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN7PR04CA0118.namprd04.prod.outlook.com (2603:10b6:806:122::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Thu, 23 Sep 2021 16:32:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b0408f-b37f-4310-77b3-08d97eafbc42
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5149A5FBA48DD951D5DFFDD8ECA39@DM4PR12MB5149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Be3OdciKXl6c4xXq3yiUmaXmtcgmIlTEeRecq+BXt2F30VdfUV6uHAwV5tcyrZ4fVTwqkObzRiL+DbfTqNCQl5cHLUJkfG2rC3H+Lx1EcXwyzG6KOkND6SeVpJAvBg0wOquY2K22rLsk6V6iXbzN/Ij6hHvZR+Il9GM3hD1E0raIaR9uI9MGIep0g6QfiWeeeYiolgQIRkdSvZK0XvN3yCH0tJOTQ/ZeVdRFmStgz7aV0szOxzWxgViiAxcutFknNCWJ8DnjssjEYVNcfcI//Z4T0fjQOlTwmRuVGoZQxUayD+qFXyv/91Z+nxRPkSGTTU937jWuyziVTxHx7IIARA9TkCj92+1tj7s4l15vmsg6YB0dquS9BNa4ZkfmI7RTWTqewvoTQQXKVGt22jDzPBUpdJK9d2CCrwyx/QxPX6XQKrTUGDQXYyQFIkwY+AfNuuQd5uRr9YSaLnRDPrTcOLQG0lPsCUdvVTsQIy8zGY6halUvXfKTjbmfoUjrs7h7IEPuUABU5dgZWRHfFebsTSGUQTmpLwmzawj7MLdCRMMh+GqpM2uAP33nK8IguDGLJYptZVBuGV6NsdLPQYRAQwlZeKqfCG0xRUgL1dtSbMGGncTn/vYpSnjbUP6HX1KJO9xtg7cYG8My8QBqIJch+VAzfDoqq4SXlLJJex/x/u0u1yuuJeeEqxxFu5TbSBcp0pVMz/D/0nYmcrgudTntF3Whmp5kSFuluoZVHzfyNWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(66476007)(5660300002)(4326008)(7416002)(8936002)(316002)(53546011)(16576012)(54906003)(110136005)(31686004)(86362001)(956004)(508600001)(186003)(36756003)(2616005)(38100700002)(31696002)(8676002)(26005)(83380400001)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkdQQlp1NUtWRmVyTkN1bGV5TWdFdEpzS3BKSkRGcTd0K1RXYmRmQWhkRFNO?=
 =?utf-8?B?aTZpTnZ4NDVSQVhpMFVKamhwTnFiV3BnL3lPWTVCaFVKOENpUXplTDVMYjRF?=
 =?utf-8?B?aW5EVTA0MnNMbHRwNVVrNW5XM09qV1Fkc1pUSmxaMDA5M281VEE1TUpyYmx3?=
 =?utf-8?B?blh2YkZoYmpucVkra3RBSUNrMCtzWDEvejUrMmJ6eWVqSTlGd09kR1lVMUZs?=
 =?utf-8?B?OGphd2tjcmlpQWZQQ1RYNHRTbkNyUFU5RGxNelZBWEVKZmh0M1J6QlZPdzZN?=
 =?utf-8?B?dytrMGxqMU40ZUMyVWVwYUtxOCtnbGZ2dFpSRTcrRjYvOVVTRzRQWXp1NUtY?=
 =?utf-8?B?VlREZnd0NzkxZGZPM1MwWHg5SXJGeEVQMHVHRk1LYzJKQVVSKyswNkRnZnVW?=
 =?utf-8?B?aTJLMEV4TU1yZGJrUElRN2o2UFRJbHBNeTM5bkJTWVJIN3EvdFlya0xESDd3?=
 =?utf-8?B?TXNBZ0tpTElQY3N0eTdLRXlUUVhNRG9zUk9tU1BJM1BPcnFVeEZXc3g2NWtH?=
 =?utf-8?B?S2h3Wnh3NUZuQ0QydllCc2xTM1NLNnF3REFNcnpzOTZxSkN2emNsWm1rLytv?=
 =?utf-8?B?QVNSa09PQWZ2ZVhDN3hUV3VobFBOVCtYK0g4czhqYmdPdjI4WkhGTlRraDdx?=
 =?utf-8?B?eDJRQWxQaVg0SUxtTHVzQktiNXNpNVMrQThDK0hqUnkrTll5ZzFkQXBPK0ZX?=
 =?utf-8?B?RW11Kzd6cUs0dUwySlVobWhqN2c5U0lEd0xic1RGTDRDdUptRXdubkU3Tk9x?=
 =?utf-8?B?R1kvRTNqQXVpdVpabmlLcXMvMmdrdlNFZXJJZGFXK3hlMFFEUzB5dXpqMzV2?=
 =?utf-8?B?WUc1ZTQyM0NiaXdkbXV4YVNnYnRxSWZ0UWRQSm5iWEpiZ2d0cFhhNWRxSm5C?=
 =?utf-8?B?dXpodERPUStjZGtZU0h3L0JtVWFaUFZlMkZRQ1IwSzlIVlNoWUZGdXM0YjhF?=
 =?utf-8?B?TDZndjgyUnpLTUYwV2tydEJuSE9tZjhuVEt4NDExRWlTempXY2toZ2ZHeE9W?=
 =?utf-8?B?NExHWEY1Vm5KcUpSTlV3aDFHbXlQTHFzUU5HamZVbVdobFZBY0RISzB3Ti9s?=
 =?utf-8?B?RlNqeGRLWFRJa1ZxeEFuVWVYOG5kV2VtMERhMWJUTyswNmFEbWFTeDc3RVVx?=
 =?utf-8?B?UHN3d2Nxa2pNN0lZQkFxZjE2SUtueC9iS0NCdElSVGZlWWhxTmJDSUtvaUJy?=
 =?utf-8?B?cEtRcnNicHNkb1ZGNi9HQk56cFljek9XVVZNby95bU1HWHovRDE3c0xaazRT?=
 =?utf-8?B?czQ1S25LTmNBRkdRbWhXVnYxQXQ2NUlyTHJDNWE3UHFQWjF3M0owME1TemZv?=
 =?utf-8?B?VFlQZWxHakN4dmJGRkp0elJzamhrWThRUzBTWHN2eXZCU2xBSmhrcUNUc2xL?=
 =?utf-8?B?dGpyQkNUWkxyUUEvV2tiaWRYYnJLY25WaDNSWVA3QTdHVU5hT1lkTHhzbC8z?=
 =?utf-8?B?dXUvREF5by9CT3o2OHBNZlFqb25oTEVpUXJ3Mmw1RjJ5RjVBMlNjZXhLTlVt?=
 =?utf-8?B?dktEZTduLzRGQUJucExDZlNWbFdNd2NkSlBLL2dSRXZic2Z1ZkRVTGUvY1h4?=
 =?utf-8?B?WmUzZit3TW5Dd2ZuYnE2UG4rU1RjZ0RXbThqa2hVS1RtSWltUGMvRCtublRj?=
 =?utf-8?B?bjg4NVN5elhQN3gwY3FjdHpweUNKeldNdjVvQnh3ajlQaVFPZ1kwRTYyMys0?=
 =?utf-8?B?WGdSTGpwSSsreVBERjRqU0ozdXA1RlQrWlJjUjY5UHJpTjlLb1ptWnFUUXBF?=
 =?utf-8?Q?/ZM8WcADem16itrEtBTX3mR7K67SyWgeCWguKyC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b0408f-b37f-4310-77b3-08d97eafbc42
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 16:32:29.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lofLyNBF0fKF93owTxrZEqtVZBZ819IywHYWwNyHe70uXMW48GWXcaaK2nM08Trsims63XQ80n80VB3OIplXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 5:52 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> TDX hypervisors cannot emulate instructions directly. This includes
> port IO which is normally emulated in the hypervisor. All port IO
> instructions inside TDX trigger the #VE exception in the guest and
> would be normally emulated there.
> 
> Also string I/O is not supported in TDX guest. So, unroll the string
> I/O operation into a loop operating on one element at a time. This
> method is similar to AMD SEV, so just extend the support for TDX guest
> platform.
> 
> Add a new confidential guest flag CC_ATTR_GUEST_UNROLL_STRING_IO to
> add string unroll support in asm/io.h
> 
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
> Changes since v5:
>   * Changed prot_guest_has() to cc_platform_has().
> 
> Changes since v4:
>   * Changed order of variable declaration in tdx_handle_io().
>   * Changed tdg_* prefix with tdx_*.
> 
> Changes since v3:
>   * Included PATTR_GUEST_UNROLL_STRING_IO protected guest flag
>     addition change in this patch.
>   * Rebased on top of Tom Lendacks protected guest change.
> 
> Changes since v2:
>   * None
> 
> Changes since v1:
>   * Fixed comments for tdg_handle_io().
>   * Used _tdx_hypercall() instead of __tdx_hypercall() in tdg_handle_io().
> 
>   arch/x86/include/asm/io.h   |  7 +++++--
>   arch/x86/kernel/cpu/intel.c |  1 +
>   arch/x86/kernel/tdx.c       | 35 +++++++++++++++++++++++++++++++++++
>   include/linux/cc_platform.h | 11 +++++++++++
>   4 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index fa6aa43e5dc3..67e0c4a0a0f4 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -40,6 +40,7 @@
>   
>   #include <linux/string.h>
>   #include <linux/compiler.h>
> +#include <linux/cc_platform.h>
>   #include <asm/page.h>
>   #include <asm/tdx.h>
>   #include <asm/early_ioremap.h>
> @@ -310,7 +311,8 @@ static inline unsigned type in##bwl##_p(int port)			\
>   									\
>   static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>   {									\
> -	if (sev_key_active()) {						\ > +	if (sev_key_active() ||						\
> +	    cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\

Would it make sense to make sev_key_active() and sev_enable_key generic 
and just re-use those instead of adding CC_ATTR_GUEST_UNROLL_STRING_IO and 
having multiple conditions here?

You can set the key in the TDX init routine just like SEV does.

Thanks,
Tom

