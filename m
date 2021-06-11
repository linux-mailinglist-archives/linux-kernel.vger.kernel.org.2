Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B573A4447
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhFKOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:45:56 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:1761
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231489AbhFKOpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:45:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcR9imQ0ACccSijnYw3n5rvzHILz1HWVZwjelhp6tzqn9+6hkx8fuRyNKKryAM/SUWVDgYYIqLJxUYvjQteamnjws3yIKH+PZ6GQTcft88xpdk7jTr6tTwKgItL7x4IDmA8nmIoIFDMrZXJbfQoLM+mJ6IW3cH5dTYiuRPWq1S2fUImCaqcu+3dFEO9tMsFVn3cQWM686/Ec4bjkYW6B7eG5IKuGIStOSMVHyVgchQU4Lwjs5MdnmuqC4Sl+ouPrIlSRojT2DeKZmhQLYClCOzfS+l8bXnHEPZrnoExM6bWJ7b/teY1z/0Vwzy/CpJW7MAHfv3gc2FXs9BQzJy8gEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Bbwko33dhR4G+8PnOn4qIY+WIb7ZfGXJeh9/ayjG0=;
 b=KrjKIzk10JJQIxw8W1ZPsv+pjPH+mEZK3RVLDjFkFePvptdZYfQbcOnZ+OW16PNoM7JXoERZ9/8GY1I8sgDtvJn+9m7e6beAbQqR8GtewKNIvmhOnvU88m+FmOq3in5EWIXqh9CvJ/SB/GF/EjnEN+fkyqWx18Qhn1DsOySp7wRbaeqYkvKWD88wZkMsnBRzssfdvPBb9aiCY39nKi2EskCqAPWWVAhdrBvJclchPaTqllM9c6+cvbz1T+MjO+sbT/SysOa1ykFpzJ39VNPAchkGmYsMzVHnDHoY7EKXDekaMyY6Qik9BEa78AB9ldKC8qouTRr81dW7V7J9dq4xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Bbwko33dhR4G+8PnOn4qIY+WIb7ZfGXJeh9/ayjG0=;
 b=RwVT7z5AT+AmKhX22f4AwPnpTCtFqrtV2T0pDjNOMh2HohTqJwnnCL27WkaJwbw0IwezIu9bY1h04avwm9sx6VUPAiz/UXRkZDiSW/V6lf1V83A5Eh+fDU+VhYJukBIEG7zzSQRBUhsaWxpZ4jobnkJGd2QFkjtSdOhJI2SafH0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.29; Fri, 11 Jun 2021 14:43:54 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4195.032; Fri, 11 Jun
 2021 14:43:54 +0000
Subject: Re: [PATCH v1 1/7] x86/mm: Move force_dma_unencrypted() to common
 code
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
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210609215537.1956150-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <26979aed-bca0-7e0a-91af-f68da590454d@amd.com>
Date:   Fri, 11 Jun 2021 09:43:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210609215537.1956150-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:805:66::32) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:805:66::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 14:43:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e81bcce9-b9b3-43cc-a80d-08d92ce755ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-Microsoft-Antispam-PRVS: <DM6PR12MB289192FF60A99A7B815E1932EC349@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snudDhiIp/J5+SE4ivWKsHa0D+tloUPG2xPvG6FNuQC7ZkeVUHVO9Btnk9Q4DTaxEOZzUBLVdBZP/Fy0Wx2+G5NJpa4t+tDXXaHDF9lBAVedlcifeXPug2fexcNrs35PF0m2Qj/5fQqGM4YhF8S5bFB0zA50tFaVHENZOjsKiR0NcO2lAVPMm2tMtZRMDcgd4Nq8s67ikecAvGop90GDblOkUMmgcmlhP4Z4Paw8BlYZULomiwjZfOQay0oKMP+RSsMz44rPC6k6zvhD94wS0pAi5IrmuhTrbhnd8z1Mdy19kfU14xn1Tsd8F19cnbZTC8Kh6p39L+4jS+9aL9jMN/IrD/jnesZEb6Yz3VaFrV/FyFS1dkf/a2pXgr+nyiilTL245EdvAFY4jMKXhazHDRHgSaUAmc7jM4nMka6JaCZXo/K7iZgSBeDojASvUc6bb6aKPIt+mY2rK/julWIyfaNfZ2dC60Sge7TyOFwB6cmVJqDdd7B14T5yuWaC9JwbteR1o074AHEZhYJG2nra+QOvWUtCmEM9EW8eHT2Hgdh8qG93Os9FY09NHU/+gNJ0JE9Medz1Qso5l6D9i8W6KAYmBq3cK7GD6dD6Kc1W/4ZH7aQ4gTHvBQc1hkHqNcbwVZMfeTWecV6RPyd7WSxrLKFCySftIhYQp0GXkTNPDzAZPWlB8yvOjg5PDCtgWalW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(4326008)(186003)(478600001)(6512007)(31696002)(7416002)(66556008)(316002)(31686004)(66946007)(110136005)(38100700002)(86362001)(6506007)(2906002)(5660300002)(2616005)(53546011)(956004)(26005)(36756003)(6486002)(8936002)(8676002)(66476007)(16526019)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdtSCtZdWJUQjVqeno4ZisrTUdJZUZ6cjdYV09VS3lrL1lrS0VHWUVDS0l1?=
 =?utf-8?B?OCswVjJyV29tR1lvQVFPbmpwdGtkVUxOUFJoa2ZsVkdob2hacXQxbHpRZFls?=
 =?utf-8?B?eWtRNHJJUGVjQ2VjWGhnN28zOVBuYXRVMVhjTnVnK3dQaWo3dHNHMUVoYmMy?=
 =?utf-8?B?ekxNNVpiRjZlL1ZkUXMvS1FPVzlVT2kxY2VQVmhLR3lYcGN3dXVGMHVDSDlh?=
 =?utf-8?B?ay9kMjVyVDRhYkdmdVlSUDFRZlJqbDlEUEtCVFNsRnNLQWxPV3hTVUZkS01s?=
 =?utf-8?B?UzZMVmlZejBka2phK3FVSkFlS0Y3cXJ0ZUpQQksvK3lRMDJsMlFvenA1WXFB?=
 =?utf-8?B?amo2OWZqS0pSWG82L3Jhdm13a0pmaFEvSXJmVWkzWk1yT3hhZCtIVEhMZFpE?=
 =?utf-8?B?OHh4ektXRTNXejlRdVFJS0Z6czdKek90VkNGNU5KWWJHVyt5blVubjhtdGpa?=
 =?utf-8?B?aW9xL285cTFqVHUrY0REL1pMb201VzhIbDJCV3JhM3QrSWJyNUZZbmJWRHVm?=
 =?utf-8?B?SUdEVVFlWjdXUlVUK1V2dmZLdzlBODMxRjVKR1RKT29naGw1b29LcHdkN1lL?=
 =?utf-8?B?ajhsa3l4TFN3NFpLekFCbnRmU21aNmgwSUp3VEgvTVprc1ErbzVWYnJyVGRx?=
 =?utf-8?B?R1pzaU9nYVZXemlSVHdURkh0djV3eVI3R2JhaHErS0hIRW83WjkxYnUzWW5r?=
 =?utf-8?B?NWtGdDBVeWY2emVxakhkNTBqSWt5KzVMRzF3QnZZTkRrbXdMVEdYS1RuMjF2?=
 =?utf-8?B?ZU1qQ0tNdXh6WXVJWFlLKys0cGhhU1VtMy9QNC81ZWIzWHlJWHdyNXRIaWhl?=
 =?utf-8?B?SE1nY2JHVkphSllyRVBLSGx0NWhUYUxNS0tPbk50eGRmQ2NFaGVONTBualdN?=
 =?utf-8?B?K291dS9BUXhBMTNJc0lLU0VrY0ZFMHVwa3Q5K3IrbER1K1Jnd2dpNTcvSnoz?=
 =?utf-8?B?WG9XbVhPZHhjM2phd0RqN3VSSVRKeE5qK05rUEdQa05LaTRqV25NTjlsZ29w?=
 =?utf-8?B?MEY4aHQyblltT1RGRW51NVFuamJwVWdFTGZvZFFoQ0JjeHZsVmo4RFVSU0RX?=
 =?utf-8?B?eHFaQ1ZyOHZ3Nmk4S0kzYURSRjM0alVwY0RLbHdBMTAyWEtmWDQwdzJkRko4?=
 =?utf-8?B?Z0lLQ2RLSzUxeGxlYmNpR2x2VWcya25vanlUam5KWFdmUlhRdDFNWjR3SEQ4?=
 =?utf-8?B?Q0M2d1RVaWQxMHkzYWhxTzh5UDZNM0kyVldyUHhQL1ozeS81RUJDeVg1SGE5?=
 =?utf-8?B?OEsyTFlzMmpSYmd4SWFBM0diK0JxMmMvUngzdVNwTHFJUjdFSmhqdkFyZHZG?=
 =?utf-8?B?ZTlDS3Z0VFBDSGFsRG9CMk9sdmlKNkhzb1A1d0U1emJFVW5KTlNwUlh6VjR3?=
 =?utf-8?B?SjZEU3pJQm5KcHo2VWJSRkJHL1JSTHVoTkcvYTRBRElIODJzVm9KVGorUjRI?=
 =?utf-8?B?bTF0NUN2WlZDd3FtdVFaSkJabTQ4T3V2djZtcUVBNkR0SGc4Z2VrK2d6aDB2?=
 =?utf-8?B?NU9rRk1KMU00NWMwdDNLNGR0QXZjbHkzZWRJbGZxbjI1aDI2RFgveFhtRTV0?=
 =?utf-8?B?azhESWNVUjVmTzkwbHJ2VzJJbXlCMG5DeGpBUDNBOXZiVFJqRmhkRFRBaEZ1?=
 =?utf-8?B?bEIwK1lEZ0JwbzZNdjBoQjRGbk0vR0d0QWs3ZlFtMlZmVDdhbkRqRXlxb3lj?=
 =?utf-8?B?RE1xcGZjWk1ZNWZwT2pGVFh5Y1h4NEhZWFpVYU1vN1VsdG5OYnRBN21jM0NS?=
 =?utf-8?Q?B1PssMtp2WCMobRtJ6tpwkm5uXXpme0ytLxa7RH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81bcce9-b9b3-43cc-a80d-08d92ce755ce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 14:43:54.0139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnlv6sEqn/MMmWW0EFDfzSB1Hb2ilF5pvRaDdrjkYw/F8ndGfV9jIMuv+dB+dIFOwt2Vio3QPff8RwZrfNVA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 4:55 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
> new file mode 100644
> index 000000000000..4a9a4d5f36cd
> --- /dev/null
> +++ b/arch/x86/mm/mem_encrypt_common.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Memory Encryption Support Common Code
> + *
> + * Copyright (C) 2021 Intel Corporation
> + *
> + * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> + */
> +
> +#include <asm/mem_encrypt_common.h>
> +#include <linux/dma-mapping.h>
> +
> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	if (sev_active() || sme_active())
> +		return amd_force_dma_unencrypted(dev);
> +
> +	return false;

Until other stuff is added, this should probably just be:

	return amd_force_dma_unencrypted(dev);

Thanks,
Tom

> +}
> 
