Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14E939926A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFBSVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:21:00 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:7866
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229758AbhFBSU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:20:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKmAn+E2vVdxLtDuRVyNWe2lQTaDQsDHb/FrmrseYJNb1t7F+JAlrh2pzzQzdvOQfgOtGFuk25MxVCqSZO05HBKfoVhbqec64cA3Y8ZVCj+i8oJNyid90iYy/tgKdZw41eTXlktzHxgmayzcBIZZkSBmq0vdJvW/5QNMX76Q1SFpTOlsQezhJzBLL35dCwWjE7BC9W05RxcuSPV3bO1x4AG5e7DUPgLU6woUPcJwQ//kpNdemgAh8QOcPLYwtprWaBv80U3QUS3f/FfAsk8BUUM1hT0WtVgvEcl7+gtDTZGfF/i0Sj7P1ZltQsTW4NVU6LLz8AvML6Hv3WbcStqW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FGpZTPjEb9FCUJaJlCmOwSOOntKM2EOA1VBpM8zOX4=;
 b=gQqCC9VSPzwzNZ37pcTJlhaVciv6l3JKCylF0oJ5x/Q4yQ4mnvKyq6joPJTxIrhGQhfrhpiWr6SedioJ94EWKsHuCh1nnS/FkU+HLeXvsxGwil908B7fsUVJDsR69E0Cpjs5wY4qGYmrq7Qq6xP63GsBMwAs14EDTG4OWRXU+hwUxkrYrFQE5vLEopj49GsGbHU9t9XvKVIAv/3zTt1Z5WaVGzOFxUPGph5R5VPQPfMA7e8jbxrGbwBgAkVB22Wx8wjydM35KhsPXXdLRsEpvGHaOgyDk5xLEXM/+IbGKK3+ZXTB3qpihwWup8dENRR32TOMhqAV3VO/8wVY0chrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FGpZTPjEb9FCUJaJlCmOwSOOntKM2EOA1VBpM8zOX4=;
 b=TBDE82SR7xOVjuxwlbZe+qhLEtpiOEAToP0kE5LtepXeX2FiQ6+NeKiBXZH17chRC+mUFOocjLtDWbUZJbvG7Zl4CeVyMljTfjj1FCHvXNU6irpR4P2pF1bcFh4ZlU+izW5jZNCozq4tIHzIzhOJnSDPJrwWLXvcuJyR7Y+6/yc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Wed, 2 Jun 2021 18:19:10 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 18:19:10 +0000
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <dfb6b319-97ad-4c16-67ae-de4ce4ef415b@amd.com>
Date:   Wed, 2 Jun 2021 13:19:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN4PR0701CA0047.namprd07.prod.outlook.com
 (2603:10b6:803:2d::20) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN4PR0701CA0047.namprd07.prod.outlook.com (2603:10b6:803:2d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Wed, 2 Jun 2021 18:19:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f21f7bb-78c0-4de0-7403-08d925f2eaad
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB012344BFC0F743A9CF1EF80BEC3D9@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cx+f5XtyaHK1BSr/uXDjXJCUAa9Zvf6x9Oy7owMUNMCvG0YvmkRbYAI+W+Adk8rhO0nVjelAakJMvWhkhJSobb8EhSEy5QvQ50ch4DoNtdVleRXlDhK5hOr//72t7I9BK6CXn2aqhjk+VA7efKXzVuBKJU2VHCIts6OrkIMvb2F/FaY9mOm4Roz1RHsPDITcl4NZnc0LS4oMTA2LoUbds7LpwcP+I3AWsIcXV1vL+d2F8YmHswGnji5AUUZRHZDWTZviSTn9q4pKt+/TGLugxw7rQtYmDQf1u07Yqvw9556Wfdu24g0NzGk0IlxKbiqvBTGi11IToSMstptbvVB2v0C9jFMD8+kUHzcsTk+kpRTlSCdcJA7VXWklv5r3XOdRKwnt9y7o5NYmPCAcz9n9ZKSCXK944otn6/mpejP4rrwH5rV3G/AZLo48zT6NFwJi0o5qZi/lyg9IZJZyE0RTpRCpRv4FRCfOLXxA7QXYVxsmj4pVissIiAorzsz12ychIxsHm2bpLBMhjhdtbX8ePK6GU1QJ4E28UxTesjSnI8jgMFDsUHT48v7ZOa3EuWVJuOvKyRFd95ScLXm+cWxSqMDh7VkOeR4W6tDAbHUq6ToBcDv2N+B1B6Min+VukS2Ra4r4La9dM0bdiCSCEizu7Dlp7KdaI8LxqIjOlbxlNI/64bFDzqp6vWK8dphEEbzGTX0+6kZywwDDxcR+FVLVgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(16526019)(186003)(478600001)(8676002)(36756003)(26005)(6486002)(6512007)(316002)(53546011)(2616005)(6506007)(956004)(2906002)(86362001)(66556008)(31686004)(5660300002)(7416002)(66476007)(4326008)(31696002)(110136005)(66946007)(54906003)(8936002)(38100700002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VlZ3YWFsOStndW0wZnpJbnduWGdXVXdkMTVoTE40dUg3RGlDVTcxamF4VW1a?=
 =?utf-8?B?dE92bm1SWEppYytHUlNpMGt0VUd1cVRUVlpsbFpGVmN4V0NFTUo5SWJFWnJj?=
 =?utf-8?B?amJxQXROaEJuRFhFSktvdTJDQjJ2ZWhGV1JCTFNWU2kxQ1ViaklVZDBpdmlU?=
 =?utf-8?B?M0N1QTJNN2Y0czFiQ01wUC9ocWZVOHRGYkx0bTFxNm1PR0FNUnQ1UGh3VDdR?=
 =?utf-8?B?cjIxNkdKcld0aHZPN3VuamFXSmxGeCtESnFtY0xWd2k3R3hxL05xMU9qbm94?=
 =?utf-8?B?T0VuSnpyRDNqK3hPTnlFekZMUnNsRkRKd1dmVUtmRWpUSmJsaFYrRTJKV0VR?=
 =?utf-8?B?RUt2T0RlTno5SVB0a1RwZ0IrUHR4dmdPemI0T0JNVUlwZkZhYzRUUUtrODNY?=
 =?utf-8?B?V2VneXZwbi9TOWZ2THV4aUYwWXl5V3ZxcjJHZnNVYnNnVm5uN29IZlJWVzI1?=
 =?utf-8?B?RllTYWtVQVpBZW1sZHp5RDJMbTIzaGt1T21JbVBiRDNUQ2dZYzZOSDJ5Mnd1?=
 =?utf-8?B?MUF0RXZiSG1WaDJEODNlL3lMSjcyRWhMbDFaN0VVRDZmakRoMkQrZDcwMW9Q?=
 =?utf-8?B?dlRvMFg0TlF2aFl2Z3l1c21vYi9xRlRpdHFlRTlydzVmNkwwNW9SMFhNV2V2?=
 =?utf-8?B?TWh6QytWZDdhQm1ud0thUUFKVjVFckk2U2pWb0o4NWQ3eC8rRkFpRnJaeGlp?=
 =?utf-8?B?WllzWlg0MUhYVmdMZENzWnl2RG5CUnU3UldHVFl5QlpLd0c0ZjcvanlTRW5a?=
 =?utf-8?B?QTNnQnlRRVo4dVBMZHU3ZGlTb2E5dmk3Sm8yT3ZUQmloTXJBQTVteWF4YzJK?=
 =?utf-8?B?VlQwZ0ZheWpYbDhuNkxSb0lkMlB0dEZzeU1OWElEb095NUY0MXFqYlFIQnZL?=
 =?utf-8?B?WFlRZ01mZnZiV0krQmt1WmwwL2ZvZGZVMkorK0IvNVMySUhHZ2dtS3lxVGky?=
 =?utf-8?B?d2JIRk84cGJLL0Z1alhxeXVBb3lUbFUrcWxqK3pwck4vL0cyUTQyQlh1QmJW?=
 =?utf-8?B?eDhsaXpmVEtSRWFLdG9UNHJ5dytuLzh6MUJOc1MydlB0TUZTaEdlNGtZb2hX?=
 =?utf-8?B?aEZEUEs0VFdHdmJtK0hKays1Y1FDSnRpSUw3TEwvRkRmdzNmRWFJUjdEeUJa?=
 =?utf-8?B?L2t5TG1jb3luMjhObGhjNHdvMlQ0cG4vY20rejlKdGNLUVFoMmtsdmY1U3Bu?=
 =?utf-8?B?Rm15NlJLcDBuRmlqM0JJcXREbUxic3NmWjRjdk9zeXFlbDR5LzUxbU83UmVX?=
 =?utf-8?B?d1E2SGM3akhRSlZRRkV0WEV4bTZsZHNrb0t5Y2syUkhTMHFjL3pWYkl6V2FN?=
 =?utf-8?B?T3QwdFo5OWRZb2tZVGs5eS9YMjh1UXNvRTUvbGJHa2pwLzRuaDFENk50U0tN?=
 =?utf-8?B?NWtkWEd2RThuZ3Q0cXhNRjZnNXdiSXlHTHUyVVBoYXQzdnFNNjlxMldGakxF?=
 =?utf-8?B?cmxkMUwwQ3p2a3FGTFNEMzVVNHE0cXVhT0V5ZjQzaXdZU0tiRnpnNStwRkpy?=
 =?utf-8?B?dDNYOG5VbUFoeWpXY0RoZzBmS0g0QW1KTGNtcGFFUkVCN3R5K3VhSW15WXB1?=
 =?utf-8?B?S0JzS0pFQitCT3pPdWNySW9rcExOUTcvelZKZW1SSXhrWk1QbzlxZEhFb2NC?=
 =?utf-8?B?WHRBc3lic3dVM201bHk1Qll0YTVQMlBiWkF1SStycDlveHJwWkNmK0xidjN2?=
 =?utf-8?B?TnFrMnVzc1EzbDl0bkhuUkUyMnppc25vclgrMDUxOU1ITzdJekdvclR2ZFJ3?=
 =?utf-8?Q?GAVvm0DkItJGo5ppM2mX0qBvZCtJI34maBSwo6G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f21f7bb-78c0-4de0-7403-08d925f2eaad
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 18:19:10.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAnGfUcYza9u3rREEazRgProFrtStUubU09q99CjL3n/u816XTExuodmJPuYY8md92LVI8eFtFB6iDUzZo6/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 4:14 PM, Kuppuswamy Sathyanarayanan wrote:
> Add a generic way to check if we run with an encrypted guest,
> without requiring x86 specific ifdefs. This can then be used in
> non architecture specific code. 
> 
> protected_guest_has() is used to check for protected guest
> feature flags.
> 
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> Changes since RFC v2-fix-v1:
>  * Changed the title from "tdx: Introduce generic protected_guest
>    abstraction" to "x86: Introduce generic protected guest"
>  * Removed usage of ARCH_HAS_PROTECTED_GUEST and directly called TDX
>    and AMD specific xx_protected_guest_has() variants from
>    linux/protected_guest.h.
>  * Added support for amd_protected_guest_has() helper function.
>  * Removed redundant is_tdx_guest() check in tdx_protected_guest_has()
>    function.
>  * Fixed commit log to reflect the latest changes.

...

>  
> +bool amd_protected_guest_has(unsigned long flag)
> +{
> +	switch (flag) {
> +	case VM_MEM_ENCRYPT:
> +	case VM_MEM_ENCRYPT_ACTIVE:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(amd_protected_guest_has);

This certainly doesn't capture all of the situations where true would need
to be returned. For example, SEV, but not SEV-ES, requires that string I/O
be unrolled, etc.

Thanks,
Tom

