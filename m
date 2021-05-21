Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F738CFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhEUVPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:15:41 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:2977
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229503AbhEUVPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:15:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu+pBuKGpLDCazDCiIJaZpuUVlrGTlb86OiRkoyxL9KQeWJUsplTcBAL/MIoVchM5IbRdWHi+z+f9VCAoxTgLBtH2KHmRi3aCehsJfKFVbSlnF/JFQf42PHODZermTiDIIeAXlBBmS5D1mSQlwdL+nq3VeNAKgz2a1mKFHdVSipU0K1SoF8QAObKBxFLo3DOnNM0FGMTAKPNchDv3u4dYP1SsIBI1bdCV0xQQwWn0wPqhvWGd0Ndr/HaK4JZ14hb3CQZ17zu62lbmULRA+CB08A3FxRhgGytNBIOlZBOjRGzud/YX4SQ6Gavxunqc3HZiPHxmDPjSO44O4yKBmUD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijb5PZnhL1rFmbjrBfREoTKypDxz4dK7lEP/abL/lZQ=;
 b=dB7FbtcvSraHU+zflEDgixIqo3n8+y/rDBqejtQILJVcugH066wgozgf8NEy7zuGmrqQ8oYfl55I216D5M49qyDEFFGWMV6DQwRooqDM7E1KZ5Lhlj1VNkc8clpFtsbFWfFmtlO7eycN17/ea98SB40LwDN94+SoFEmxP9c3LnEQapPaXutsHpCLV/HgJ+9qxqYKoUyzYphWkCRPICv7PlW2BUX9n38BvAsa233LyqLKSQQBx43FntkC9RSPEv2fO/rUo2xoluRqI8J0SEC/WGFxR/zc5jpZa6bbMbWyww/kw0GHWv8oqJ8ep/tdyMXbXPMVRGCHgZWcPnF+7KCeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijb5PZnhL1rFmbjrBfREoTKypDxz4dK7lEP/abL/lZQ=;
 b=MuVKA9mZ47REwE1mHpGPscbTyigd2jXROv5yTCH0T812NTPQiLQx4tUiGaWSF1Wvz4jeK3aXxk725jXUnn0Ok+JDcE6g/EwiYnGDpU5Jj0Za4zNJ+QpH162GFxPZVcOz9su6IjVv1XtXPsSOC6c3Zk0pNn3yudJtgNmt5FObvG8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Fri, 21 May 2021 21:14:14 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4150.026; Fri, 21 May
 2021 21:14:14 +0000
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
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
References: <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com> <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic> <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
Date:   Fri, 21 May 2021 16:14:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YKgA1od/SqycWWds@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN7PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:806:121::22) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN7PR04CA0077.namprd04.prod.outlook.com (2603:10b6:806:121::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 21:14:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ae5109-2a03-4d93-1bff-08d91c9d6292
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34689D6F8D808E753DAEDEF3EC299@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ce6ysswv2h5jCJaDJiPGHosoEkdu00UN1oM8goHiG0yBWJ1fv+V/Q8eUWQEzh9+NcU9PP4AdcHNWNh+l9SWALf/HEB78UVvpChDWnfyrTdW3Kbe7PWiPsTJQKcXvXw6gbt2JW+R/qi7+pKe4R74BuKsyaC8KwO5Yea0trsdlrjqOojt3mjhTJ1BcqXOgFS2J4x6gUZJxlARHGtAmUDdYfcagSOD0rop+KuOWY5LCSngxkYIrt3ptDcY5XrKc4gpKHETXd/wBLTtvnquG7+GryQjEW1u8wj2BHm5Uw5Gtb4p3QaI7xP0XU1upBZr1cGI8jwVcSzYhWtvzKx1sFrSWy+82jR5kPsn/jGYylbTKKkZQgNRNFE734otWPlemxkVXMnq/6BJiXYu1GdExtzecPEX09SCinWWQYK84A0Qc4Q/sc3QRNt4MF5hqNLm09ZlvRTKLHbzTmVc5E7EjprxSUpRHv0mEjIcWJruhq8NlcCEMDbq0oZdIHq1f9ivb60DU4WY//X0RZQvkZScgVU6j7oMbOOnb6tLPRlL/3fJL5oh2k2bPLUM7fr/n/AWXl2zDt37v1wcp3C4l3VDrsz/vobD4vbqIz4e1RddM/TdiCLrBozIPmspYqDGxHchHzR1g+MbLbLcITWNDwXykEgx/7lmPUKHevpZVk0zhQDotfeU/RGC41dHReIhG3NHhGuH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(6486002)(36756003)(83380400001)(478600001)(8936002)(8676002)(16526019)(186003)(5660300002)(2616005)(31696002)(316002)(956004)(31686004)(38100700002)(4326008)(66556008)(6506007)(86362001)(2906002)(53546011)(7416002)(26005)(6512007)(54906003)(66476007)(66946007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUlGbjJuaUFOS1I1RUJTSXFxSkR2Uk5CTlpodmJRejNvZmJQamQ5REV0K2lK?=
 =?utf-8?B?bCt0azU3YXd0TVA1NUg4SWw1dlNqT3c5ajZ6clVNWkQ0UlduKzFxTkwzY2Yz?=
 =?utf-8?B?NnFldU82V0F1dThCaWtJZ0dFemhCWG9GWFQvUlBxUnREMFZvWUJtWHdCcHlK?=
 =?utf-8?B?WEFqQ2RMUlAwODhmT28rK0NQckg5MEZoSFgrVFVqTEtsamFDWXhEVGtmT2VQ?=
 =?utf-8?B?NTJGRlNxVmZwcFl4dFJnMEJGd0IwSXR2VDlKSkp5SUk3cjQ4Sm1pVUJWaUhL?=
 =?utf-8?B?NGlUVFhRcW9DYitBb2xIR3EzYXBCN0puQitibllUdkpxQ2tURHQwZFRwVkU5?=
 =?utf-8?B?Ri9mOEVnNzdVQ1EyLzgxOGxaUFJHMTcxdWF4dVJjWStWLzFhSkh6c3RXUC9L?=
 =?utf-8?B?NUdNVjRFQXhXeURvTXcvbFQwMHhGS0NZNlJWaTUvTmpFeXlJajJBR3ZGS2tw?=
 =?utf-8?B?V1BGNnl3b1FOcDJTWHhMaTlXNVloeHAwUEpvWG1ST3gxOUtGV0dONFdERHlC?=
 =?utf-8?B?NjBVdzhkTHFob0NVYzJZYlp1ek9hTnVWWTgzL0N1UjRybFhtN21HN0tPVlFr?=
 =?utf-8?B?aVVQM1VuSzlKYVNXVktTQ2dQRXF5OGFZcmtLQTNOMFlyMHcxTUhKbnlTOVMy?=
 =?utf-8?B?YUZ3dFRWVERzV05pRFl6SytqS1ZrM3lVOXFwU2RrM3BlUWRkMmswdUc1cUpi?=
 =?utf-8?B?cWc0SWF3SzJUYnBUN1FOMklUTVVUWm9DRzJoc01kNWpqV25nNjJrck9IN1FM?=
 =?utf-8?B?UDIwN3RTQlM3RmpmeFFaa2NCWHF1Wit5QisxakF6enJGbFBuNEJTTFErQ3lM?=
 =?utf-8?B?bG92ZTFXdnFUYkY5bVNzNDZNRXZsZDE0ejZVM3pDTFVKTXF5RHpDNGVwQ0ZQ?=
 =?utf-8?B?TnNwc2MrY2xheVBUZFMzeDI4V1hoSkxLbFMzd3Vuc1BCanJPWTN5azYvNXBE?=
 =?utf-8?B?WmN2cEZCeDlZeWRubllHRmxuVDVWRDBHU3JnRTlYTWpYeUlUblEzYVIzbm9R?=
 =?utf-8?B?dXE2M2duTnpUZzRnTnFpa0tSZTdBZjhKckpVR0ZMVDV5QTU1b29nREtrUkli?=
 =?utf-8?B?UVo0VGNmMEJVVUpaUC9CaklySmJCakNTaE1uRmF4SUdrVVBnUG4rMmNOT1JU?=
 =?utf-8?B?S0MxQWxBVmRiT2hIUE45ZkFFNXdMSXI1dzVCWU9CSXRhSzJ6WEhsMkFad1NR?=
 =?utf-8?B?UkhDUi95VGRFZEpEdnNFR2ZvdlJjZ3FrTisrMmh1cUswRjFXM0xiYlVlQWhC?=
 =?utf-8?B?eTNGOXRNOUp3ZVpmSzd2TEN0b3RNSXdhQ05OWFlOc05ZNVZWczdwUGV3Tm1t?=
 =?utf-8?B?cW9jUjNreTZDUlNtZUJNdk1mOTRxV1RJSHplNDlsRlZlelJ0eVJMbHlPMjVs?=
 =?utf-8?B?S3EwRE1GY1YvdXV6TVZEZVFJY1RtMWdvNk9XSnNXMEpjWTdBVTJIbHRjNW4w?=
 =?utf-8?B?Y2dHTXJWMzZQQk9rR3FsQ2YyZlVjZWFQQ1AycFJId0hMdzd6ZWFhTUJRSGFP?=
 =?utf-8?B?OGk5N2EwOHplN2VWYVQ5Ui9vQWw1S3E3Z0hzemcwckNRNENSSUlBWDhsWkI1?=
 =?utf-8?B?ZGprS1p2amlyb3FMam5JQlVpR2xHT2tNWG1XTzY3OEc4QnZpVjhGbWViZDd4?=
 =?utf-8?B?Q1l4MWw3STdZemp2VjVWbDNjVHU2bjBha3Q0QWJQcE1jSGt1OXJJTkJHWUFz?=
 =?utf-8?B?aXhjakhKNUUwUFlFK0piWW14eTF0MkpaeHFzUXc4RmlpeDRaNFZnN1JUSGxa?=
 =?utf-8?Q?OLLpSqef5/HYq4pUHNffstGZRDGW+2iOE5bQUI2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae5109-2a03-4d93-1bff-08d91c9d6292
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 21:14:14.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG+7LcJ/Iua5XSFRufi4Y0mSyEwe2Z8b73ceocQAdt12oU9DtQI2Ts3yecTbsSRVJODJjsZu6QmrW1+Pa+i5UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 1:49 PM, Borislav Petkov wrote:
> On Fri, May 21, 2021 at 11:19:15AM -0500, Tom Lendacky wrote:
>> In arch/x86/mm/mem_encrypt.c, sme_early_init() (should have renamed that
>> when SEV support was added), we do:
>> 	if (sev_active())
>> 		swiotlb_force = SWIOTLB_FORCE;
>>
>> TDX should be able to do a similar thing without having to touch
>> arch/x86/kernel/pci-swiotlb.c.
>>
>> That would remove any confusion over SME being part of a
>> protected_guest_has() call.
> 
> Even better.
> 
>> I kinda like the separate function, though.
> 
> Only if you clean it up and get rid of the inverted logic and drop that
> silly switch-case.
> 
>> Except mem_encrypt_active() covers both SME and SEV, so
>> protected_guest_has() would be confusing.
> 
> I don't understand - the AMD-specific function amd_protected_guest_has()
> would return sme_me_mask just like mem_encrypt_active() does and we can
> get rid of latter.
> 
> Or do you have a problem with the name protected_guest_has() containing
> "guest" while we're talking about SME here?

The latter.

> 
> If so, feel free to suggest a better one - the name does not have to
> have "guest" in it.

Let me see if I can come up with something that will make sense.

Thanks,
Tom

> 
> Thx.
> 
> 
