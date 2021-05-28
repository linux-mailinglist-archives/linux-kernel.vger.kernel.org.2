Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859D2393BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhE1Cyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 22:54:51 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:35986 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234877AbhE1Cyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 22:54:50 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14S2qhja005828;
        Thu, 27 May 2021 19:52:43 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0064b401.pphosted.com with ESMTP id 38tqu5r0ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 19:52:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+ZoR8Yhz59Ye0uXzqedkpCi9sQ62Un3THuSoORl8XxZfbg7uTqor9mkYKi9y9lgjwMj/8a1T+9PLwKiL+4TorJnryVSiJ1DkmkJDUgOgd8IZf/P94IM/symBfzn7YAxWxuYzZThS8V404GIzQ5ghQoClnnvFfzyUplUfvVclqgBCQSmAu+0Wi7V1l8JIlM8Ox4EtDp96rHjQi+wodf1Wc3DdL5dG7b/84cMk1y888ek5KmgxOH7JOw5XDYxptTsGhxW8PhHmk/ixCtO/uNTNE3AL0Owhm0C3qG3oUjUiLOYMod3BO+hlNm2Ywqfx6A4DsAp1uH8eB9TGxlZRHTIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ytiDu2dJZ6t4o0iylAexH6n6LT2ycp2Yzt+qlE4fwo=;
 b=K/Q64DA6tDeslHXBodZLhz4Yhx+PpZS9XNUnAgoHSXc/8IxZ7/cQaoRkcqzLWCn4L3gJoDDEEd2TKLY4xY27EOvyZjiotbyOPUlUfqjN8PexZDuYZOSQzJj7/g1XTpMqbEy3ySp0JxsVXudVUhnjv6iscHgGz0u9e4MYBRcgFtNz5cAKxsGOY/srO5HfIZ5SuiAwc43xuWo65i9DMh3fDO7d6vE6CZNOiQc1j4Fkp3lAOvaPzZrZ8vwI4T/EqzLOR+JKMGPA3q4Xtxdkzvpa08UslNZnM9N9kBFUKjgk41VYiaVzGIRAkAck3XSakjxPJoY8meNnHhMh6A0n/A8k4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ytiDu2dJZ6t4o0iylAexH6n6LT2ycp2Yzt+qlE4fwo=;
 b=kG07zcIH2KrHjkoOCB2ZrvwQWBBvQ51Ksw5RlgtdCZChcpXAEYOoANEfab3H+wPU25C9Uzu06QmCKcDHLlRzEG2XPLhxDHemZbIrWHyVTSuXE+ieWkOdZs75hof8rgV55rfxgaYiUxyRhG50wGcv8xt0I6hXNk+7HMHELH02xL8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3622.namprd11.prod.outlook.com (2603:10b6:a03:fe::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 28 May
 2021 02:52:39 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4173.020; Fri, 28 May 2021
 02:52:39 +0000
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
 <a7ad5c03-025a-4cf8-e4b1-2d150bfe3066@windriver.com>
 <20210520090024.GB30436@shell.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <f2be5610-9a2c-f4cc-510c-b8fae22f67dd@windriver.com>
Date:   Fri, 28 May 2021 10:52:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210520090024.GB30436@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 02:52:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c8e752-026d-4bd2-5b8c-08d92183a7a2
X-MS-TrafficTypeDiagnostic: BYAPR11MB3622:
X-Microsoft-Antispam-PRVS: <BYAPR11MB36223F3CBE6C87E311450F3AE4229@BYAPR11MB3622.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HJTmm3ZWaqjQNoYujvh5YtOjbzUPPugCQeScjmMannGxzXH2IBSLRrtHLHi589PVkWJZy1b0Zu4PDKBQGw5Fkyv8IPtgBR0Vnxhh+PqcYccfSFm/VDQeLgwkKhZwPruS4dOAcX2E/zEoaW2LY9Ds3DRTfnWOaNnCynYBGfZ/IMXxnKRDrFSGmJMESsIBVx0VCF7QrC90Rip1qP5Rhlz7FQNuiVs0qI9x/1ph95g7Ksxq/OEQXrLBubHFKKvuRPbr2TIwyPRcL7s4yt5ZKVQa9bE81iw0g1M4KJ1DBJ4b9GEaBPWIG1eMHJ+FJ4CqKmDgnbwSTBFNZnE9Wjn1iAVQHrsRGdU9gjR92rYmXYCS0FdLwpEPqoTAsPrUmM/XV81wq99/St+MmI1VTa4u4ilE3huiUurhZhH5fpj+S2KckIMV/jau4ZnjK1j2qWGUO7aT8S+be9iEgCKb7eOCCZkxttAbsiXsv38lib3EuKHES9JBGpXC06Uuh4U1M3YVYt0QzRLEG5lSATlsonreLMXNtLyTnaztH/6JWdN9FgAZT/rHDxbmBPhVFeRQtdKMQDPqwB0w4iuNj3YfidCg7uGBGtUU/pSG29U0ZSBUzEhVVmAszMN07XQjQ916CA7iaYhG0X1nbHqDB16d+tk+lSN9HfFYMW2MAEqFHjjj+gzOo5Ui/oV51IzAx0VffTW96xa2nHvs4Z1GfEm6l/1tbXGtUCyqXMtGUlDeRi0xeGPTLg3rp/jVHM5bpQW9JKnBUDA4TkMdMYDx4aLCCzVFI0yzSvrA9ZQ699QX4ZQKE0P1kEJG0AKSGp6/KkGkEs72hlnpCd8lZpX+4mRgkCxeq56ggWKOK6+dnIrse+JQ4yeZMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(478600001)(316002)(66946007)(83380400001)(66476007)(86362001)(6486002)(66556008)(8676002)(966005)(16576012)(956004)(5660300002)(31686004)(31696002)(2906002)(6706004)(26005)(38100700002)(186003)(6916009)(2616005)(4326008)(53546011)(36756003)(8936002)(6666004)(38350700002)(52116002)(16526019)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cEFhQThCMmNaZEhFRXhIOUtwcytNamhDZ2V5a1VUUmxnakV2MCtMU2dvKzlG?=
 =?utf-8?B?TTNHOWU4VWdzb29abFZJQWw1TGtlTW5DUVdjd2hpaXM4Q2doc1MzcGY4U2V5?=
 =?utf-8?B?Q2NaQkx3UnRIZ1RoVEFtN3liS3F3OXQvTDNaRkFlMklJb09VTXVrYXN4L05D?=
 =?utf-8?B?UEVyM3BOVzhBTnVwTjZrUDJUdHdQYk9XQThCaE9YbXZIZXVSYzFwaTltLzFE?=
 =?utf-8?B?MFdHYWRzUTZSb0pDUytUd0V0dXRhWkpOby9DemU0Tmx2T2tEWjhURTRJQmJD?=
 =?utf-8?B?V2toSG9hc0RGUGp1bWFhdmJxVC8zdlNvSUJqL2RRY2dvdEErbTFJTkhIdzJr?=
 =?utf-8?B?SStQbnhTQnRKQUF1bDk3R1dOYUhEcVFoclhCTFh0ZWhqWElMN2tKclllNGhL?=
 =?utf-8?B?Vml5OU1GUzNQZjRHMnMwWndFeTBoSkRxMTExeHVXR1FFQVpLS29FUnVLZ01N?=
 =?utf-8?B?d0w0aTlNZVZYL3lYNUFGVTB1UEwrbnpiOWJhN3hwYkdueE9MTXVtbGF6Qnpp?=
 =?utf-8?B?TVhla2s4cXd0ZFJKRlMxMXpHRGhoUktHNkdlQm12aCtSVk50SThqQkRLcGYw?=
 =?utf-8?B?VWV3NWROYjRGbi95aXpYRUtRM0szUThDZFlibmtCNFpIbk0vMy9vYnpxY2xX?=
 =?utf-8?B?U0RXWTZWQmNMQ0prT0dEN3BhOXp6cXJUWWx0REZkNTkyWUxoNldCeDl2d0Vi?=
 =?utf-8?B?YU50ZHpuZVFIYXZFV2h4clM0SHVqcncwaW8wTXBFYTFBWVZlcGgxRUZxWHNl?=
 =?utf-8?B?MGRFOVJNQUZTa1hZekVlSllTSmVTWXZPandENm5lN0l1cm5oQVFYbVplTVJN?=
 =?utf-8?B?cWd4QVRHcmttT0FDOGVPVXM0bmYwVDNkaElIbVBVbXRqaFM2NzZXWmZuVWdj?=
 =?utf-8?B?bWJSK0hYMUdJK0Y4WFNUeGhUSzNxdmU1UVVVKzJEREFBaTNLdnNzNEJFTkFN?=
 =?utf-8?B?Zm5RU0wrVUx6QTdKVkVpMmxWM0cwSlVkNkhUTzEwVnc3TU5DaWI2QXNGYm9s?=
 =?utf-8?B?ck5qK2UxTEVacWpkVWFJbDZ2enlEVXMweHh1NVBwZk9xeFVpRW5zK1Y3aUVs?=
 =?utf-8?B?V3NoNWhtanR1Qy9DRUV2TVFwT1pqT0dsR0gzcTRuUTk1OCtjVzFSeVZTMG5z?=
 =?utf-8?B?bzJFVTNLbE9PbUJ1Rm1aODhBZ1ZwalVDaXBTWW4zcnBvamY0bXVEbG5CNUFK?=
 =?utf-8?B?QjRjNWI0MU0vOVRJaDNuMThad3RLNkZiVmNjVGNaUkpPSDI0NUh1bm12blFj?=
 =?utf-8?B?aTU0TTNVNkdkb20zcXhGU0dHYzBvVHFtZmM4UnFGTTYrZnBCV01vM3EwTU1N?=
 =?utf-8?B?Qmd3eS9QNnhlVnF2ckxWelpKOEk5OGMzRUgwMjRudVJJWjFZZFB5SHYxSEY3?=
 =?utf-8?B?ZTZobVFJZ1R0Q0luNmRZVWM5NFJLV0tnUStOZ1BRZ1grRm1qU091VjU0Nk1O?=
 =?utf-8?B?VXVnWmppWG94WnErdDlPWjI5azJTVjJQYVdCR2FYejd4Rm1OZlF3cjB1Qk1X?=
 =?utf-8?B?dEl1UjFQMWd2M3FGRUY2ZDE0Y1BUZXd3UFBkQ25sV3QwZnUrMEswK1lzbEFv?=
 =?utf-8?B?RlNoVGQ2WUVBSUxzUlFMUlJuSFBackUza3NpK0gyZTc1eDAweUo3anMzNHVp?=
 =?utf-8?B?VTVjbnRGaEV0UWhQR0lIMExMNWNjaVhtUldVUjZZR0RPY1VtSHpGaklxSjdZ?=
 =?utf-8?B?bEVoOFEwb05LZ1ZtY244UWpHU3VzTmY2ekp5NTdGeStHdVdSbTcrNTFWQjU4?=
 =?utf-8?Q?JBxoaO15bD5ywuxz8bXfdKpcwWUB2iQ0T/Tslox?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c8e752-026d-4bd2-5b8c-08d92183a7a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 02:52:38.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk5+ucU3J6WVYxrVahzfFE4UsgWTO61xOXvvmr3AwNC1g39r7LPU+3imnXkeZ/LL1qHI1F7e+ZsFsVZHQK2+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3622
X-Proofpoint-ORIG-GUID: QBEZKS4QUT4iLASZUCTQh3v2jf--AKCy
X-Proofpoint-GUID: QBEZKS4QUT4iLASZUCTQh3v2jf--AKCy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_02:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=909 clxscore=1015 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 5:00 PM, Russell King (Oracle) wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Wed, May 19, 2021 at 12:41:10PM +0800, Xu, Yanfei wrote:
>> On 5/18/21 8:15 PM, Russell King (Oracle) wrote:
>>> -static unsigned long __initdata vmalloc_min =
>>> -       VMALLOC_END - (240 << 20) - VMALLOC_OFFSET;
>>> +static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
>>>
>>>    /*
>>>     * vmalloc=size forces the vmalloc area to be exactly 'size'
>>> @@ -1169,7 +1168,8 @@ void __init adjust_lowmem_bounds(void)
>>>            * and may itself be outside the valid range for which phys_addr_t
>>>            * and therefore __pa() is defined.
>>>            */
>>> -       vmalloc_limit = (u64)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
>>> +       vmalloc_limit = (u64)vmalloc_start -
>>> +                       (PAGE_OFFSET + PHYS_OFFSET + VMALLOC_OFFSET);
>>>
>> Here is bug, it should be
>>
>>         vmalloc_limit = (u64)vmalloc_start -
>>                         (PAGE_OFFSET + VMALLOC_OFFSET) + PHYS_OFFSET;
> 
> Yes, you're absolutely right, thanks for catching that!
> 

Hi Russell,

Will you send v2? (or I missed something.)

Thanks,
Yanfei

> --
> RMK's Patch system: https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches/__;!!AjveYdw8EvQ!M3h7vuBembpLOcv9xTj5vzxlU0dxXMOa1lDX4yN6u4l-TwnuZ3-ldjYom-7ZQYpsVYc$
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
