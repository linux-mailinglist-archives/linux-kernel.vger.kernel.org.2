Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3B39C3E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhFDXc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:32:56 -0400
Received: from mail-sn1anam02on2041.outbound.protection.outlook.com ([40.107.96.41]:11653
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229853AbhFDXcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:32:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu4maNh7zR2YQMiBIQyk8cI9jhsyEB5Tr6nVfcUoGFjUFSCbVTjDJCLU41Jp44Jsr53Ap6gTS4zjtY+hygqIbL/0WvnxoJMagZ8R1stp5zP5fG4p7G2bGXDyNw016lhoGKDY6XRKI3GCCz1v5NS0NaJCpKSKMauwh95mf6RUMx1GQNJ270oyL/8oLK/LxMKkQMhXtLA6SEsAIyp0X30GX/rAxTERD1CNaSfn+2sUmDtuA1yStrSTJqiXENlbimCV6+q9wFhS7VzP9C07ZbSOd2kgA5JuyKssB5k9reE/Yfrg2s1HyfX0HJNvMvfYumyz2Rsx7o3xbynBSQIX9AhMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjLk8gC01dgXW2u0CA2vcLg9CKJCW8lzEHjC3r83hnE=;
 b=Y+LXXOKsj0aHVWpY5lh0k9HWVQoZUAMng3WCaz+sM089I1Cz9ct2zpWbCy6h+5oYwCsRnAFb3o3sdrEM45jn6fFOAKXeG3Lbc/2fS++ohmweQ2eIyNQuv5/VWYTWV1JyCL44FA8ajB9sqDUH9GSiPty/KYMV0CCoHRvNXW7sWQQOkOIl9EwoYF4oESkQV4qnkaS0mRyrsZ2aOgGWafTMxZgyJa6ADEO5plGiox8OrJDn11cjuS5MgS3D4oOpIXZdPxSVNpTJ8f9XA6KdoFF213AkC2wdCO0Q8hp5q49PjCkBh0rLYj5LmYTVCX2elI/J/QJcoQlf62eOf8Rq1YOyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjLk8gC01dgXW2u0CA2vcLg9CKJCW8lzEHjC3r83hnE=;
 b=2LWSqUf9CQILE43vhj7CrJ1A0ebP+jsZbIoykO2w821wbrpNQDxc/YZ5v1559r8TOutGdN6WI9mp+toO/K1X8jt6Lksk9gBewU51NsYSWqWs3gA1JIKfxlM2515ETGh9QvA4+7GPdQ6slq9hoUPh2WCJIJyZsKvD11LBnFnCGHg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Fri, 4 Jun 2021 23:31:06 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 23:31:06 +0000
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstractionn
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic> <YLkcUts9dWDkDKpY@zn.tnic>
 <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com> <YLqmGzgXo0jFRhpw@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <12bba26f-5605-fabf-53ea-f0bc1bb9db44@amd.com>
Date:   Fri, 4 Jun 2021 18:31:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YLqmGzgXo0jFRhpw@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:6e::27) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA9PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:6e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Fri, 4 Jun 2021 23:31:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b53e4b29-1d35-4957-258f-08d927b0d30b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892BB7DB4235BFA3D95551AEC3B9@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMGna8xOeuf5GGib8T+/9X1xkyxwrE/4awh8k6uTdmkP+ROm0nBP+SVzXFa6AE5RRtAG28/WzL5bImQIpwDIVNU0PY3lcfCkzeOtT7iyiB3A434B/qCK5GPm3jB5l5Nzglp6MEAMvqQZlGREX5ieEBg2+Qvj36F79JBffRh4gB6W0T9pKiGRL3vrtznQeB2RmKRxYmxt1KdngG3/ZTwjtw1dgj+14fYYSCeuJ4SsQ5TSCFtoYheNdDxPYfZLQviFidns0pSuj6fSl/k29B2BbLe9/nqbwhX0PuTbuFVZvUoOX//cDiUJXVwTpVNSe2rrWZc2J9kSSRlD0+WPB5SIvpe26cxd6KVUXlg6qVfTbhb9CxcEKpK1NSZscQPLMn7PEpBNmNSgkH+bkBYGbCTi8Ln1WaLSgWgvFqZgscq4pXPreaHuDyYpm2Grj/zChIPBFTciHJJLoYfNmQwt8/7u2dsVUBx9wxJQ3O/DGRskpJihLoClhuDmnX2YchbY0a5OUMMyl/HQFD5giDmB84+H7HICEEWi8pmux6XQsY70ZYeYPz/B/4C594RKidFNdSn13h9nmbHElVlsYQIjBighpcmLCKCl5Yn3TY06KNNmv1aExyM1TJM49pQ359xGom4VoBIsRB2CYDBvubxDWPYpl6UedFJyofr5aM5VJi4pJcb1QNeZwS4liqLzowwgJd4jP0pxpfl/nsod+ZAAvH3kNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(8676002)(6486002)(4326008)(6512007)(66946007)(8936002)(31696002)(478600001)(7416002)(36756003)(2906002)(6916009)(54906003)(316002)(26005)(16526019)(186003)(2616005)(956004)(66476007)(6506007)(66556008)(31686004)(86362001)(38100700002)(53546011)(5660300002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bzVtcjZ1VUFuMnlaeEJkVWFkUTJjT3cyK0VjOEwrUDRIbXRqSmg1ei9jeFU0?=
 =?utf-8?B?RjEvaWtGSzBVeEhSeTlGbDNtUENLMjltNW1NZC9Da0pOelJzdUg2TWZ5Z21p?=
 =?utf-8?B?OWdKWVFTdnJpb1JibEZ6NjRsaEVEQzNnU0svcUs2R3VSd3JQd0QwNDRmNk55?=
 =?utf-8?B?MmxXQ1QrMDFRcGt4YWw3WmFDU1FIUW5MTmM4TmtoMXJ5N21tT1ZvNnU3S0NU?=
 =?utf-8?B?N0c2UDlDU2VXVmNMTUhTQzZMb05YTENTV2RIUzBOc1phaGJQV0xaNXJ5WVJs?=
 =?utf-8?B?eHFxVzIzSmxlY21PQ2JoV3A3SXJPRWpwcExuS0NnZ0xFVyticFpTOVVnZnBL?=
 =?utf-8?B?cWc2SUJvaWZ5a2I2STFsUW9zejNkai9Xc1JUNzcyMi9iWXJqNWk4VTE3Y1Ew?=
 =?utf-8?B?dnVYYldSME5CdjFFVHkraFhKUzhDMnZjWSt3YmQ5Qmt2c1puTWFwQ1RLTGNh?=
 =?utf-8?B?bHFqaGx0dithOW9GU21HVnlNRVgvQ1dCTWlmQXJ5d3BxOVNLaURqb0cxbElH?=
 =?utf-8?B?d1N6bCthaE9EdW5xNTZraDFOSnRMcnpVdUNCYVF5WWFzRWtYbGNOS2I4NGZJ?=
 =?utf-8?B?SFhvME1sL0FEcVl0K3h2Y3BSMVg1aHJKY3FEcTVpT2xjOWF0UTBTZUlicEhS?=
 =?utf-8?B?dHR6OVM2Y1JtTUd2T3puaTBuRmN2L1ZzOUdGSVA1ZWExMnh2eW5HT2xVd0RH?=
 =?utf-8?B?TDR2RUxmU0p2Wllua2FmZklsTTZjMllFOUN4ZXEvekF6U21WamRiL2FzVEh1?=
 =?utf-8?B?cERuNThpSVRvL0lMY08rcmZxV3RISmtKcEJMaUZDVk0vT1NIcitvMXFxc25o?=
 =?utf-8?B?V0I3ZFZJOGtyT1MxWnJ4dFJlZ0tjZFp0dlZFNFVJc3ZJOWE0K2g2SjhxSzdm?=
 =?utf-8?B?QmhVaG5KdU5URFpaYWkzMm9IbTU4WTZpemVwekRaRVhYamdoUG5UMzNVaWNU?=
 =?utf-8?B?aHNMeWtLbFF5OENEWHdLREttQXNVUFV0OXY0V3o5Lzk2NTBBeG04V29pVFJr?=
 =?utf-8?B?aEZ6alZqQStwVVZrTEFTKytkMC9KNklNYktvNkNCL0lTZzhheUttQXRobVVx?=
 =?utf-8?B?NFpsVWx3Qmc1bEZRaFl6SVdmSVRYWFprZURIcERQM3NnNWdOZk1hc3UxRkw2?=
 =?utf-8?B?VFNqY0diSWt2cXJmbUJxbkdsMXdMWnlVMTYxeFpvQmVnK0lDNlZvTzJZdFc4?=
 =?utf-8?B?VDB4MWxEL3lDU2Q3ZzhwYm1QR05tSG53emJscERiZzA1S3phZWxBQjVoY1hz?=
 =?utf-8?B?bHlab2lPUEVMOTNaZGJJU0c2aSs4eUREQUNQLzM1ZVpvMHRTMmN6SnB2OVlX?=
 =?utf-8?B?bTZvTFdXd0tXeVY4eG1DVnp2UkZNRnRqSnpZN0M1bDNwN01ManBxRjdsZk40?=
 =?utf-8?B?bE9PRGJvMml2bXJkMFgyMGFlOEhNRWZMUXVoNFczcWhTeElpN0o1UXhCL2RW?=
 =?utf-8?B?MHZodWIvRzQxOElienNDdldVSHJyRUtOUkp1bWlXSjZGZ3hNN0ZGVkhmM0Rz?=
 =?utf-8?B?WWtpYkNKc05TMTRwT1N1YzBUSVFWN0Y3cVY1NzVYTFEvREJ2bVFxUWxoRXNX?=
 =?utf-8?B?c3EwMVp2WVZmcUt0czdGT2tWZU01MTY2SHUzUnZxUitPRDF2Zmt2bDBNMjJX?=
 =?utf-8?B?NFV3ZERicEtnb1l4MjBHZ0VBZXRKVTNpcldoT0E4K2dzKyt6empQTEtPU3Vk?=
 =?utf-8?B?a2JIamNmMWhEakdMM0poUlhQaTc1K2RzVFd3ZU0wRE9QNUdCSUxVM2RLTzZ1?=
 =?utf-8?Q?emgfsz5iuNXkfrI8h8yqPbnOKsNFllYaj7gfq4Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53e4b29-1d35-4957-258f-08d927b0d30b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 23:31:05.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O96AJP9yn2GtHypjCAhG7cVT1VjDiivCIJ9osf3LP+RK9QjUluKoXw2g0RQ9NxvcAh1gUqugNGiLhKeuGRs0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 5:15 PM, Borislav Petkov wrote:
> On Fri, Jun 04, 2021 at 05:01:31PM -0500, Tom Lendacky wrote:
>> The first is analogous to sme_active(), the second to sev_active() and the
>> third to mem_encrypt_active(). Just my opinion, though...
> 
> Yeah, or cc_has() where "cc" means "confidential computing". Or "coco"...
> 
> Yeah, no good idea yet.
> 
>> I don't think you want a WARN_ON_ONCE() here. The code will be written to
>> work with either SEV or TDX, so we shouldn't warn on a check for a TDX
>> supported feature when running on AMD (or vice-versa).
> 
> That's an AMD-specific path so it would warn only when a flag is used
> which is unknown/unused yet on AMD.

But the check can happen on Intel or AMD. We have lots of checks for
sme_active() in common code that are executed on Intel today, but they
just return false. It's the same principle, you don't want to WARN on
those, just return false. E.g.:

	/* some common code path */
	if (cc_has(XYZ))
		do_y();

If Intel has XYZ but AMD does not, you don't want to WARN, just return false.

Thanks,
Tom

> 
