Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FA30AF7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhBASgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:36:40 -0500
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:10624
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232913AbhBASf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp89xVTkDrbeoMnm8pxDxG2B7oIVuY8plO4S45sECN9wDPOv+e7gyu/x0g+FYKCMvf8lNpB0BRAFhcVEr0+VZXRyho9t3/4LrBVRRv1oG5Qdedote/C4GJXMEZn/nUHlqLlf3o8gc4skUB7Y7mmS8WJONqfQePUUBcmQC3psH0FFAp4VA3xnRBwyG4595nfc2WysRHjkMNi718earR8uhdJmGzSLmdAZSrrc6H1X2VgSiH2z86V6WSUQIoP02qAfV3aRLxt4tEmUntI1YSiRgA6N5lsBcWDvlKegYKMyZMUKfcdNm7c0JE//n4GpOB+Izj2jSEQe6TxcB6DNEjI4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXnQ3Ruqb4M9pwXYIOMD6tR7k0KaTbjTUKLtiujUW5g=;
 b=hNRR65u9TldUS3eq4hb1b3r/YH89DU+sW2DByLmyvwWSCuAATrinMK+q/UqNX1rygrFtTCUpaGX86kl+9f+fwfhTfJ8dH0SDI1nVQFLf9UzRN23R56ZTQCbydfszuUjcAx2bahvlNNJCOmg7B5tEjlQ2BJ8RA+oQuG0mAcId6LlLduA9izc7nSIHa9zf4CSF9tqa8UgWuW/fuObOyte3IzLYEcGZLz0W6BoEee6dXXpBYUgmj/wiJMILUr0GW79MqlEUNdx7z+Lsn1y7XcOj8ysTaR5mv7NOSxPy/9w4Z/k9TyntxMDpAR4+zWOaqWeUlANitm5a8ILSCT7PUAsM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXnQ3Ruqb4M9pwXYIOMD6tR7k0KaTbjTUKLtiujUW5g=;
 b=nj2NT5YjziqU8ghpeVxTD/uGU4NG/59RiNlRZ3Y+5F4Kg+ScRp6VXh0ELuHmUooWyTkkBjWt9gjwspbUJstJcbqzWc8qYK+2rLp/D30Vlv9mBoNqybuhnkaOLHxCoGQ4s2dZScEHE8ArD14GIRQA40hy2Iz1ZGigTdjDT0lbQ5c=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Mon, 1 Feb 2021 18:34:33 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b8aa:f23e:fcad:23ee]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b8aa:f23e:fcad:23ee%8]) with mapi id 15.20.3805.025; Mon, 1 Feb 2021
 18:34:33 +0000
Subject: Re: [PATCH] x86/sev-es: Do not unroll string I/O for SEV-ES guests
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
References: <3de04b5b638546ac75d42ba52307fe1a922173d3.1612203987.git.thomas.lendacky@amd.com>
Message-ID: <76141611-c8a5-312c-24f8-b47720836054@amd.com>
Date:   Mon, 1 Feb 2021 12:34:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3de04b5b638546ac75d42ba52307fe1a922173d3.1612203987.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN7PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:806:123::6) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN7PR04CA0271.namprd04.prod.outlook.com (2603:10b6:806:123::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 18:34:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35e7b3bc-41bf-4861-50a0-08d8c6e0053c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:
X-Microsoft-Antispam-PRVS: <DM6PR12MB289031B58907EFEEAACBCD48ECB69@DM6PR12MB2890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6el1Urig1TFb6gJVE0TiMnn4GKYLU7eAxskRAJNDRBbV1oxRXtnBtqmaN69aIITdiUoHx9GNDR6Jded6lytqQPYwgPNllQ9M77j7cUVZO0VNYkN72pYcdjmKriDfT1MllexwIADQPrIgxZ4n+TavgjJhlMv+yi4A/N+46UXfQSRQh97V/R+G3o//plCbTNGj5WIvd7WwJsqmOLxxCOpdMi3uvvVE2K+4HyD6WDBNuCFg93cWONUz3zSswSKEkL/+P62BFFINKxgvnY+9xE4uYbhP5csKhve/caTW08XYmIhz0LsYI0WpY7P0ZfczqsQcxf9NgkD6M30aTlg23tlEpli5SEUORqd+2P8r5tukzHBoTTulG2EOpTb7lTlsRvEOYxsjHkJEpM//8lp2FvwoeHijyNna87sRJwU1uZaED3S+JKUPxfYK4rMQncxrL3rU5dBb71cDR1SUxXrFNaVZeq2FvxDXaoTSmVcxF8HQvG+B1KIEmmn0DvZyf/vZnrmX4H3hK0ikVsgQll5Buf0Sjf11FbOz//L3ECMt44R1IA4XQt/4iBKhZCAlnvgc3bfhedHoHGREHvP3fKjcQRaKgNwMDQHp1XCqj+kiZauuos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(54906003)(2616005)(6486002)(5660300002)(7416002)(8676002)(6512007)(478600001)(16526019)(86362001)(31686004)(31696002)(4326008)(26005)(6506007)(53546011)(36756003)(956004)(186003)(52116002)(66476007)(66556008)(83380400001)(66946007)(2906002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q2hSeDFHNHgzRnFKdVR4YlVRWWlHekdyMmJIUmxPUzlhdjk5TnAvdllzUnFh?=
 =?utf-8?B?dytsb1JIbjFtOEJ6cVNtdFBDYWcrejZnSUY3aFZocmxEZ0Rhd0NPeVQ2Q1V4?=
 =?utf-8?B?QUNxeEtEY3NGWGdVaVVLVzRXN2Q1S254UE13M0dJZHpNVC9BMjExVkE4aFVH?=
 =?utf-8?B?V095empsKzg4cDhCdEJzOFloOGpHb09jRnljbzFnQ3k3R0t4c0VaUjdKRlM3?=
 =?utf-8?B?Nkllcm5LSmFCWEdWVE5aM3ROdzM3WlN5czR4V0kza25EdzZxemw2U2J2VjJT?=
 =?utf-8?B?WmJyNldyMFpVcUVFcThnOFVwSW5TNk9GTjA4bWRKN1lOV1FlamtjbEZKQ3dY?=
 =?utf-8?B?ekxmRkhvdTNIRHA5SUVGaXYwWDVCS21MZ0tGczBlUkZ5bzlkVlVsY2I3VEJz?=
 =?utf-8?B?TDVjekdCQjhXckpZTFFRRzVOOW03UUNoaldPUlN4TWZvUUxHZ21PZXU1dGNm?=
 =?utf-8?B?N1hMS2NwYW5pMEE1RGMvUVJtL3AyTzFJOXBZN2FlVlFaa21KQ2R1eDJTRW12?=
 =?utf-8?B?WUVFWndRbFZwOUtkQlFFaVdxNlczQ1BNb0RhZGxyaHVlcENPNERyT2gzZHB6?=
 =?utf-8?B?VDNLSk1xNGk1ams3eVlvRzdMVENDQjVad05XTSt3MncvY243MlljZWZsckFr?=
 =?utf-8?B?L1RpY1lEa1NTOHZOVEdoS3pqWWNUSm9DODFXam5Zc1pCcExUTElwMUxDR0lv?=
 =?utf-8?B?MXlmZ1Vod1BJak5yY2ordTk2QnlYSmhheHVuWmFOeVFzQjBUNndaa0ZqR0xE?=
 =?utf-8?B?cS9vbnUzc3B4UW5RdHBndW5mczkyQmR4ekMwazN6dk5NT1ZqWndGK0dPbWZN?=
 =?utf-8?B?NmEvSHRaRmozR1BVU2ZGaU5mK3VuYmFhUzZHTnozaGtzbnZsM3NkdGVCYi8z?=
 =?utf-8?B?WUhpNE5kVlZNTllsK2N0a2xmU1NJOENmem81YzlDN0ppbmg4aURlM2VSSWR2?=
 =?utf-8?B?VmYrOVF2b0o2aVlDdCtJZmRrUmFNY3E5cW9HejJ1Rk1TN09vbFY1aUlLOHFm?=
 =?utf-8?B?MUF2VndKV1UrY2pYUTB5SHNRYWRYL2xocWxrd3VmOTFKWndDM3BXU3FTZms5?=
 =?utf-8?B?UGZkK2RpWVFWbSs5ODYzM003RUhxYnJ3L0oxblQzaDV5dUwxZ3V2QTlKZDc4?=
 =?utf-8?B?MTZOQzhwamlJSkdrN0pmVzFVbFRBZmJMY2pKTjZuY3pNZWNUT0RSVXR2enU5?=
 =?utf-8?B?NmVqWkNWdk1qNFFvZW1RbXZPVitBMEpIbjZMUmRsNVhXNkt3em80d3VxNjBh?=
 =?utf-8?B?cCtKcDdiM2xHeWp4VW1qL1grZjhSNjJnbWJZRzBHd0NmOW8yNDJVVFpQNE5t?=
 =?utf-8?B?OE1HbTNyY2NIYUI3SjdETHBzb2U4UmNaWFVRRUpxQzArZnRJamxteHVmWUVT?=
 =?utf-8?B?TXhFZTloSFJ0MTVRbXV5VGpYSGZFb1NTOGEwSmdaV3hBNTZpQmtib1UyZ0JC?=
 =?utf-8?Q?tpE0eqCv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e7b3bc-41bf-4861-50a0-08d8c6e0053c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 18:34:33.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsfu7iYh0O5hz2S6B2FvZrt4kmnyTQ0l+DGh4KdZj91ZMTGZ6c2NN++q5Vs5brpeBUgTYxCBDVNjnFk16VhLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 12:26 PM, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Under the GHCB specification, SEV-ES guests can support string I/O. The
> current #VC handler contains this support, so remove the need to unroll
> kernel string I/O operations. This will reduce the number of #VC
> exceptions generated as well as the number VMEXITS for the guest.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/x86/mm/mem_encrypt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index c79e5736ab2b..d55ea77e1ca8 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -474,9 +474,10 @@ void __init mem_encrypt_init(void)
>   	swiotlb_update_mem_attributes();
>   
>   	/*
> -	 * With SEV, we need to unroll the rep string I/O instructions.
> +	 * With SEV, we need to unroll the rep string I/O instructions,
> +	 * but SEV-ES supports them through the #VC handler.
>   	 */
> -	if (sev_active())
> +	if (sev_active() && !sev_es_active())
>   		static_branch_enable(&sev_enable_key);

This brings up a question. The name implies that this is a general SEV 
related key. However, it's currently only used for the string I/O 
operations. If further usage of this key is added in the future, then this 
would probably need to be split into two keys, the sev_enable_key and an 
sev_unroll_io_key.

Is it worth documenting that in the comment? Or should the key be renamed now?

Thanks,
Tom

>   
>   	print_mem_encrypt_feature_info();
> 
> base-commit: a7e0bdf1b07ea6169930ec42b0bdb17e1c1e3bb0
> 
