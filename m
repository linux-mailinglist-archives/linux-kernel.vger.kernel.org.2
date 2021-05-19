Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B960388651
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhESFEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:04:50 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:24150 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhESFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:04:48 -0400
X-Greylist: delayed 1408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 01:04:48 EDT
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J4dUaw028338;
        Tue, 18 May 2021 21:39:30 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0064b401.pphosted.com with ESMTP id 38mctd88rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 21:39:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTG+bir/Qyx7YUBrabUQcJtB35CoYo4rjXvlaixA0tu+J2mfyOK7NEnFScoU0ozerL6ygeXDNN+U1e0I6bH4zTWSYAQBmk0KndWiAQL8NsNmfiKDkld1/fwHhY+QPv+oPztoGu21anRuNn9TBYP6g+SlhsDFHPCH7UfX+3gvPfHSEDDg9wpzZSMbbtRtxewsDfGlbhSZK654i2OFJNg64KuihOJVMdaOe8yuusxTu0X0qxQmdf5EdQOa6llImTFFa6fpfhqIO4IxTh/Ff0sS8Wy+QC+qJ4urAbjEZndNGwVMwCy0vyKykfR6Zg/m0nMHhscyO8fHSP6noKwPKTnNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aBjv6rI0Q+u8uQlddzYcLOsX6W7vscfmK6O3depR2U=;
 b=f/oaJE6GlP+U7/sekqG8nQkxdfkoCIrxyYLrrObHT5UJ7uCqnr4EBu7IWQFUYU6dG1t70Cp5PFK8WpJsVMexkojidK6TiZOASwYGBjL8nEhaD0o2n/U0O+t6dXOIHWtDxNkF2A2MTV24ar5s8ch2I6zbRGjhfMEPUFv9uPFBtJapVRFWZJhM3gj8Lfd1Ve7hkq/OiRjhCfNC2Buhum0cuDTJlMHwOTfYhrC84w8SpRdxGFJSNoYG+8viMEO62z00iU1c3+0Gv5aWEVQpWWuC7/0YE8TUcDbaJp92u3x/JHeV/84yhQ5pgLFUf0OyV+LanMg6G4Nd90mAyRVdxI61Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aBjv6rI0Q+u8uQlddzYcLOsX6W7vscfmK6O3depR2U=;
 b=Er3MggTNCdR56sPm2uz2+T/KefUWstAnRgCGJxgXLsthB24DVfNqqGvf+QkRDyW9Y6DgZWrYm1GPhvP1OF0CRu0Y8P/tGEwe6GC+zmoSmeCkmeGiZ8QIjrN6PWluxLGVpqyLKfrRb/pLQMPOKSuj2aW8MTqvud2+KE5VN+vm7lQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4103.namprd11.prod.outlook.com (2603:10b6:a03:18c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 04:39:27 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 04:39:27 +0000
Subject: Re: [PATCH] arm: make the size of vmalloc in cmdline and meminfo
 uniform
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518111254.3820480-1-yanfei.xu@windriver.com>
 <20210518112932.GV12395@shell.armlinux.org.uk>
 <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <63618f13-07cf-6867-bcb1-7a725e6f3ef4@windriver.com>
Date:   Wed, 19 May 2021 12:39:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0012.apcprd06.prod.outlook.com (2603:1096:202:2e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 19 May 2021 04:39:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ec39e1-9ffa-489c-fcb5-08d91a80156c
X-MS-TrafficTypeDiagnostic: BY5PR11MB4103:
X-Microsoft-Antispam-PRVS: <BY5PR11MB410342E52DCDA1E76812A2C8E42B9@BY5PR11MB4103.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+6FRXWI5lCu2iDsKRpAa2VHB9kcrtsEg7KEbdmlmeDBN5BCFkGt+dzA+dsFwHhZwfinXhKidgOs+LUpyR5RoO/ib0qwf5Bbzk4dsWKbO0/i66jlAaVhkY5vq6jGC0zeVK87SDU0aauEqsmQPIQ+qxM2GNyOthzG4XcPPY09a5MOL6HTEMPM/hDkZb4zbmaMvKpcgXOsKst0fdpiMca0YIviO3XI9NDhPkGGfM9pFSQEEKytCYHz7onHUhYt+hqQ3HPtqdHMHz9WTBh3eybuNbNbupMOgveyVsk5GX67U9RDvy2c90yDWHX3/775lhibKGtXn0wiY6v6NCyc+qsbTLQmTbu6p6jmzWA0yr95LjO0YbpgE/Qz/1DZ4RjXejcxo7nXP+Mx9XEpiiKMvO5fCVhkg0DybfyzY9mF2dv6P0l/wWRWgZewU2plX8hilnq5C12ROW8zpCttRMN6HEnIYBZOiqvjm9B+++9Aae66edNC5HFEaKECfYkn1L2bAecO8YiFpbcxLmvV8cylToLoQ+IiiKJiOaFPG3qfPB/pZvguBcW4sxuoLzR2cZ7m04U3MdOcD6yVV1LssI1sxHxu5bMVrIO6AExA+vvOC61CP1liJ4WkYH/Ix1IRnDKgGuafMr0ang2rquURqshWmPQT1vbtEBEXbFU0kHEiHGhpF4UBpk2xloh4F3JHoicDYbTh6eCWBC+L7vPjtBVDt+jKMMpmgM2kkW35gjHIHgSLGszjQkoT05FISjLHfrjCFHjgJPu5HqkYbBY/F6xp3wo0B2zkGZjQITsUj6j6lT8qA/oxoSOrPOgZwLKDz4NS/iKHWcqdlnRU8Rm9KiCGIkzWXueBtFHPHCwXkyYkR2mflak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(366004)(346002)(396003)(83380400001)(38350700002)(38100700002)(53546011)(6666004)(26005)(6706004)(6486002)(6916009)(966005)(66476007)(478600001)(4326008)(52116002)(5660300002)(66556008)(66946007)(16576012)(2616005)(86362001)(8936002)(186003)(16526019)(8676002)(36756003)(956004)(2906002)(316002)(31696002)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VXJLcG92U1MvR0RDejZsRkRvb1FDT1RHMTBGOTJLOHNBcHppOE1uc1VCOE90?=
 =?utf-8?B?ZGswNTF1T3JQRHgwM3A2S0xaeU52cUdwOEw5UVVCbHdGbHl3VzMva1J1VXEv?=
 =?utf-8?B?cmVYbnFYY2c5cW5TVytwN2JxeS8wQkZhVmZpWVpiTTRKMm94bFBGMERqUmdq?=
 =?utf-8?B?Mm9yVDUrUWYrZVRUbHRKbHd1bEdSTGhuVmp4dFpBazJ4Y3g0NWdqZ3NWVGFQ?=
 =?utf-8?B?VVFQYkJCSnJzRERoTTEvWmVPNlpqSldZemhPVktuSkcyd1BTTzgrbTdhY0JN?=
 =?utf-8?B?NEtqTStKY3VyNmlQSVl0Rm05ZTQrVXFaWGFITFVLS1FqR3lqeU54MVVaVVpz?=
 =?utf-8?B?RVFsWkxHaUtVby9OZFdDV2wySmhHQ3h3cWVwTHpLMnV1ejZtUTQ3V2ZSUFNx?=
 =?utf-8?B?Uk0raEJGdnpjMmwyUjROaENRUG5ObmljdjNYVll6YnRJOUxrSFZuUDlqclB4?=
 =?utf-8?B?RlVyWUtFSzhRcWhoQ1pOcFJ1MzdTamh1Y3Y2TG9JVFRDZTlHSGtSa0c3N1RK?=
 =?utf-8?B?bW9sVGdVTG1xLytrYUQ3czdKRm80aTNYdmszSGtmOTJ6R0twblZuNDhnaTJ4?=
 =?utf-8?B?cU5tRWdSWU1IZ0k1aTJXSWQ2TnVkam1uQjlQSm1hWE9MdXR2SFhjcStGdW5y?=
 =?utf-8?B?OVNZTkdDOHpWWXZkL0pVYUdCUmcyWGNLK0Jpc0Y3UDd2cmt5RXN6bVJrVWU4?=
 =?utf-8?B?NnU0U0VQVU00ZzNYZVU0eWptZkxleUJKUWo5bkllemZuSytrbXJsT3NBaFJr?=
 =?utf-8?B?REYzbGlUNCs5aW8zUStWem04Qm5JTXczT0Fxa0JyTHc0UWVCQlNlejVaQmRx?=
 =?utf-8?B?OU5NWWZHekFqUTJKVXZ0TFJodUJKVXJLL1NzcWwvbDJLSGxlOEVOMWNYUGNv?=
 =?utf-8?B?SXo3UlZLSm1KOWxCR20xdm1jYTVZamZRWFFXNEhOb3graXZRZk5LcG9LRjl1?=
 =?utf-8?B?VnErWE91cHR4T0lmT1ZQcTlPYk4yNG1pUUpKZE1FeDdMVEs1Zm9iZFZOR2FM?=
 =?utf-8?B?TlpaUVVOR1J0OTQvUHp0bEhIMFNNVHl3Yi9Gc1dzNjV2RlIvWjBlMGpGNTFj?=
 =?utf-8?B?SXUrL283V0pXMnpycTB2NjQ2Z0ZXMlNOMUR5ZFU1MmQ5bEtSWXZ2RWcrWTlG?=
 =?utf-8?B?Zng2M2ZUOTRWb3V1TEFKWFZrNTU3YnBlYUFTSW83Z2Z4TXhvR09ZQkM5ZmZ3?=
 =?utf-8?B?dXQrUUl5anZkdDNGLzF4K2JTODdOVEpUVTBFUy9GRkt0cWV3WDJIS0Vac0d5?=
 =?utf-8?B?VjJTZUYxSEtQTFVNM1R6ZWZ3NHc1cWdVbVlua0R3c0x1N3VXWGxLZm5mZXdM?=
 =?utf-8?B?VUpxa0tnZHczUFVZbWVrdDhDMjFMYnZTc1hBY2tUcCtrRW90aGZGOUozdXVI?=
 =?utf-8?B?c2lGL1hIN2FyelRMWXVta0Zua2RLa1VpVGwyQzhpb1dFYnBoTWtHUUJnOXFu?=
 =?utf-8?B?M2tObE8xVnhuNTdFWVlPRXBFK094d0VkWHhwdFZjNzhsL0preE5nd01QRUQ0?=
 =?utf-8?B?SHVZZ1ozeU9YZGR6US9LQlk3M3VjWURPUEhDZnY4b2xZLzNqZ21PT3MwMFdR?=
 =?utf-8?B?TGlNcnJ4WktuOUh1U25hVUxZdFhERCthNjNEbmdEMEZmUFV4VkRFRHZrVGF5?=
 =?utf-8?B?RG1SYnl6ZFpsVGlZYjV1VHpWK0psRkxlN2V3K29uY2doOTFpK2t2bDlNSjJD?=
 =?utf-8?B?YzQxbVpaaHNwcVFja0JOOVJMUHl5cnQyTzh1akswOTk5K2Fjb0NrZTYxTkpC?=
 =?utf-8?Q?cwiptLxpItG20y+RGHU/UYTRInb80KZgw7OvOuN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ec39e1-9ffa-489c-fcb5-08d91a80156c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 04:39:26.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6CulLU5+es+0arRFPc1uVCxeFjlZn6VC8ORiQ4crIdIcx2GGs+Y/YB86MVQFXPREAhfxm1h58IMsY8kP8CsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4103
X-Proofpoint-GUID: -xA0ncXFsakokrhuo1S1HFOjOOJp5O1i
X-Proofpoint-ORIG-GUID: -xA0ncXFsakokrhuo1S1HFOjOOJp5O1i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_01:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105190033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/21 8:06 PM, Russell King (Oracle) wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Tue, May 18, 2021 at 12:29:32PM +0100, Russell King (Oracle) wrote:
>> On Tue, May 18, 2021 at 07:12:54PM +0800, Yanfei Xu wrote:
>>> The value of "vmalloc=" set in cmdline is always 8M more than the value
>>> of "VmallocTotal" in meminfo. When use the "vmalloc=" parameter, user
>>> expect to get the size what they input, and no need to consider the 8M
>>> "hole" hided in codes. This commit make real vmalloc size equal to value
>>> of "vmalloc=" in cmdline.
>>>
>>> Also, the commit will reduce the size of vmalloc printed in boot message
>>> by 8M when the size set in cmdline is irrational.
>>
>> Hi,
>>
>> I think I'd like to do several cleanups with this:
>>
>> 1. change vmalloc_min to be an unsigned long.
>> 2. exclude VMALLOC_OFFSET from vmalloc_min, moving it into
>>     adjust_lowmem_bounds where vmalloc_min is used.
>> 3. rename vmalloc_min to be vmalloc_start
>> 4. enforce vmalloc_start to be a multiple of 2MiB
>> 5. in early_vmalloc(), calculate vmalloc_max as:
>>        VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET)
>>     and use that to set the upper bound of vmalloc_reserve (which is
>>     something your patch doesn't do, which I think is a bug.
>>
>> Thoughts?
> 
> I've slightly modified the above idea, and will shortly follow up with
> some patches to show the idea a bit better...
> 

Thanks for making it better!

Regards,
Yanfei
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
