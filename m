Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1223D43AF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhJZJ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:56:32 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:35738 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235098AbhJZJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:56:23 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q9Pxsi019439;
        Tue, 26 Oct 2021 02:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=KOoo+F/LFadXsS6MsiirNjyfdOVyC75YFf5jGqeNHBs=;
 b=I6rF3dNVn1x+Q3AF2E5h7LjleCrmK/ou759yezijNGS2BcMsyTdhTiyFKndqV1F6EBnU
 aY4WgZNeMh1kOklYMFzGfvyEceW8avBLt8HGD0TWycuPSVjltmt/A3Y36h48d1exLOdk
 PzvB78Wk7WTYzF+65ohy3jELs+cUzRbmBngHkD2yEQ2r/QzniBOPB6GHf+gVFpTf97+v
 uYCLM5kDBU+wWcPeZPTAGCq5Uu2Z8T0Y5iRygrhTc8yQvIFMvlBB/lo3IhNYY5U6FJVW
 Q6lR3d4jnsXIQApLMRD80HFhlfphvjWeKHrUNL0waU20gFZsONt0AZobappN/w9MzL+g xw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bx4uwgcje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 02:53:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlXYXQyvT4SNJeMlvUFiuMb7NiUYhlNLDWJEwgu90jcWx6e/fqJ/WBKJrHw2EKpM0f9HY3d4kj4nyP2PBh8dW3U6JVjQoZICWYGsrI9W0kCqruukwjZg+VQsfQJGUMLyz/HIfdR9LQDddi+mU2n43VGjeI8zV4YmGfawFNNb1R5QZkKqmT1B5PqHZl9CoUq//Acjgr6uQGhjssp9kHHxQWHYtbDfp2nmhBlmXiPWZisnQgTvgP2MSa88cFeEcRcARhEY29ruxMbXngl6UNmJUwDvh9dclyHXCDwyEerRbX3VTYlr5tUEu2wECmNbY4OrzVV4gJrVZimPGa98olpprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOoo+F/LFadXsS6MsiirNjyfdOVyC75YFf5jGqeNHBs=;
 b=Rn/rZ3Fe3J5BGXKRAqlIpy4mv1wDwKOEWKUSuVqy+8u7bO6tsv+HPgFKiZPRuTELwkKW/FeiihL6TPPOZ9OhT5JxqB27CxzP7vpF00fJkP7l2KoEwy2BZK5dyMtZoM4wGZHiPGyp+sD/TBHV6od2/l87NXhJhBPtVb9pnLJcq3ZwwaWCNU+H5FS3XPjXQlsWk3PZFWcTBIWC1zaATimTq364PxUSHqSeCQYRvuuZxkntePxGFXkGCyJrqy0sMoaElXd0KAr8ro41De6uZpn1N2mZpuinhxAb62a+NIG4PBhO2UkrFAbFo4nLRMF4GXgu32kDGQXYUCDVuRusruk5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 26 Oct
 2021 09:53:33 +0000
Received: from PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c]) by PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:53:33 +0000
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
 <YXfDdmrCynZk/QW8@shell.armlinux.org.uk>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
Date:   Tue, 26 Oct 2021 17:53:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YXfDdmrCynZk/QW8@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0215.apcprd02.prod.outlook.com
 (2603:1096:201:20::27) To PH7PR11MB5819.namprd11.prod.outlook.com
 (2603:10b6:510:13b::9)
MIME-Version: 1.0
Received: from [128.224.162.199] (60.247.85.82) by HK2PR02CA0215.apcprd02.prod.outlook.com (2603:1096:201:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Tue, 26 Oct 2021 09:53:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70f92710-5847-4448-bb93-08d9986678a0
X-MS-TrafficTypeDiagnostic: PH0PR11MB4854:
X-Microsoft-Antispam-PRVS: <PH0PR11MB4854226A4B5D3C63802298A4F0849@PH0PR11MB4854.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRzGQTwt6dLsPyRNWkTHWkXdUFaeZGhXYLkkQQ6Nz5rSbrAESyDDq7ZRsG9DWalZuvTQTUoj3jpWbs6ESEFYVuNIk6CAF7sAJ6E3YAuEwcdqJgCejscpX+t8zRuIdWhQNWpZfgSvZoop7uWMRV5usL/cpXx0lVPHsQ4Zi9lqy5RXrkaEt29Q4tNa2dNvKocesHnAyvedAxxio8y56ofczgJP893f6Ge/V6or2Gfb2KNu6xbJHcOGIQQVeUNYEB8yER6IGBdROFvDsVInw12+OF5Q8DswyB7QKv1PcVXOOXRQq4f0I+sMHweBXcqlqwuiAbqoNdKJ/ofrlS3yLtX2++jA5JEs9bbWxvNE0XWLaTqDyHIMDSzvUXljGVr5FXyvuzfKKs7sXiQ7ilVxbF2/xAWGYvQbUBK1rvUA9GMSkx3DZ8INwc1LwehzcKGNXgARN8/wDxslNwOUYPROwx4lhhqO7Ome3u6y7tvXroQ3BjZ+C20iGOX4/w4YdTz5l2AKvVKDzlrDvuOCvRQ91TYSOFD9Y9cfv0fNPlknQ1RRUMCq22u1cNPl01gwZZbP3Eq/HXYoka1RnAWfMaQyoA4b5oti87m+GNyn2Iw9K3h/3/SjcN6k4qDQcbhOdlRacYEbJBiJcxvh+6jlD0EjTE11vzpCFtwciTf6FNR7Lbpq+zJtTL9AkwZVeg/hSd4TJjpdFyuHstGj2g91z+EccA/ZykkI/b8S2m3Pp6uZ3b+qQPq1Rcd+ci+Ooo6k6DPyAcRs0L2836jkPtVV2wapmTHRSd9zixhNE83KtG84TMdejeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(5660300002)(4326008)(44832011)(26005)(2906002)(6706004)(956004)(31686004)(83380400001)(2616005)(38100700002)(38350700002)(53546011)(52116002)(16576012)(31696002)(316002)(8936002)(54906003)(8676002)(110136005)(186003)(66946007)(66556008)(66476007)(36756003)(508600001)(6486002)(86362001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGFjUGdsVWY1bnhtSWZEWTU5RjlEOFVlS2RvZmM0ODhsQXpwZC81MDM2Unli?=
 =?utf-8?B?MjVJajdSTWR3TW8rdC85cmZyU1UvanUzNGhaRVliblp4ZU11SHBRbWNRUmRS?=
 =?utf-8?B?cm8xcWtpNkp1R1BuRmJEVzFWQU1oYkh1WlJOU3NnS1VuV3k5UWx1OGNjMGJj?=
 =?utf-8?B?RFJ4SE9UcmowNGdXMHpFR3Y5SEhmQjV6S2RKZ05UczJIK1owUGdIcnZDWERQ?=
 =?utf-8?B?RzBjc3AzL3dkTHdBeEhkL213bFdYR3BCSVBOSzNDRjVrbDFQakVGS01BdC9k?=
 =?utf-8?B?Rm9YQ0lmcHl5WE5TUUlFbzIwanVFWmEwaUxaQXpWbG5hMFJBdU9RQXlmNlJW?=
 =?utf-8?B?ZGlOTWV0Qk8va1E4V3VXYTVYQVpnTW5vTzZRbG81VlRUdWF1L0RWZmxKVzNt?=
 =?utf-8?B?YUkrVTRyYlZ4cG14bWF1ZWpoMXovTmJKMkE2ZjQ2Q0ozUWtmWlVHMWJodEo1?=
 =?utf-8?B?Sk1Lbmg5Y1hhZHBSQVp3Smk0T1VtZ1VxUDcwTFFCeE43ZnoxSU9RYTNEZXg2?=
 =?utf-8?B?V2xhSTVYQ3hqM1YrT0JGMmw2Y2Z6UVJFWVNOQUp0NU9IdTZTWjIwUENudkZB?=
 =?utf-8?B?dmpMcWVQa0p0bjNFdk1mSjlRR3ppbDNuVGlZTGRCYmVad0tOM3hBcStCeld3?=
 =?utf-8?B?WDU0YmgrWUM2K3U1UUZWWllGQTBBZERyaDVTdGJyd29BaGZRdU05YzJqWXlw?=
 =?utf-8?B?dmN0RC9zNWs4NDV6VDNjNUE2eXMvMldQVjlxSld6U1poMFA1ZHZnT0Z6dXd1?=
 =?utf-8?B?MDBUd0d2b1BWZmk2ZVpaWERVaDNZcG5VaTFJSEhKQ05RZ01rc3JCUmlBSVRR?=
 =?utf-8?B?UzlqZGZNd09LUjFXU1FNc28vbzZod1djZnRtdjhLd2V3WVpPNEpIbTI0d1cr?=
 =?utf-8?B?enBoWUc1UDFxKzhCc2pKVjUwNU5kQVk2ZUYxWENDalFHQ0RQOWZ1SzIzb1ZG?=
 =?utf-8?B?YjA2L3JoNmN3ODl6VnRCS01PU3ZRditHR3dDaTVOdWxTQ3JHQlM1a3diSGxh?=
 =?utf-8?B?UWdyT0tFMkRzTjNZTjFRS3VabXZsNEw5Zmx4aDZocVovRlNrYXEwYnV5OGlL?=
 =?utf-8?B?ZVJzVHlMTHdLTklrOTVTVHphNERlNTQ4OUcrc01qcHBRY2VHRnk4aXppWG9q?=
 =?utf-8?B?UWNWaWl1WUdoQ2lDZi9NNXBOUmJPaE5aZ0Q0RlY5b1pITC9GaEFraDFwcHcv?=
 =?utf-8?B?QWp0a1FjOGMyQTFCZzQ3UTlUZmdEOGVhVUpiUDM5YVUweUUyU29OaUhVUmV2?=
 =?utf-8?B?d2xpaUVGODFpcHVGS0dESWI4UWl4UzVGQ3J3SWdVMXg4WnI5ZWV5MWV2WVhE?=
 =?utf-8?B?QTR4UU1Zb3owK0pBa3F4NnB2WFpvMmFMMWRtZVg5eGdrYkZic0FiSTlKS2RN?=
 =?utf-8?B?Z0d1elJPbER6RXM0ZVllazJidWxLUVE5NUF1RXczVExOYlFyanZVeDIrOURR?=
 =?utf-8?B?OGNXb2lRYkVlMTNCblNqOTVlSlhITThObHpTVis3WkdkQTFHZkFzMEJEYTI4?=
 =?utf-8?B?YjBpeDZVL0xsak1oUmI3SWg3NGFqVU5DNXMrU21acDlNNVdjQmp4N0gwaFF4?=
 =?utf-8?B?QnhaVXh5eUFSc0NrVjJtQVFCTnc3SkdWcVlsTFl4RlA4MjJDM2lwMnhLU20r?=
 =?utf-8?B?U0xHN1BjRG9jbWFiTVBTQmJEKzcvWDErSFJhQTJmbXZDdlZYRWIzeVU3YlVN?=
 =?utf-8?B?c3dxenZJMGkxS0dzK3ZhU2JKR2hoUW80alpCYUZLTjBxTmxqRlAzRVRzRHk2?=
 =?utf-8?B?d05ETU5wb0dvRlhXL3FYOER4bGhxNEhuRHVpcGZzNlJiVW45b0o1R2YxOEJZ?=
 =?utf-8?B?WXk3allzRUo1ZFBQeXNCQUxueE9CRWRta2FTTWVDYkhYWWFnbUluUmdTL0Zy?=
 =?utf-8?B?V1VjZ1NWTng1RGk3WjNnWlBGYWU3YWZ4UlMrNnNNUmEzc1FVOWhYS0V3UGZ3?=
 =?utf-8?B?NE1VaGVmSnRxL25iNUFTdnJLaWFmRWRBaUNHNm5zbjhkSVNCSy8rZFRFalRs?=
 =?utf-8?B?WDdyRXAzREpZNDNaclVkWnU5MUpBclpOMXVoRXZCN1JKSUF1OElxVnpwVEU4?=
 =?utf-8?B?UlgwSDBHZkxyOFcvUSttRTVKRXdpVTVRSXVzTUxSd0w3VW1yNkdKa3VVemtn?=
 =?utf-8?B?SCtnK2lyR3pMZ3p6N2xnVzEzcEhhZVpYT0hYMEloOHNmY1A4VFZEVDFHSFJy?=
 =?utf-8?B?NDhDOEZOa1dtL0RaR0VmMlRVM0RSZXZKNUJKSi9EekxyYWRHbDNUNHB3T09r?=
 =?utf-8?B?dEo2YXRSSnQ1WTE0YVVHZHFUMU5BPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f92710-5847-4448-bb93-08d9986678a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 09:53:32.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6oVFlOZHETtw8hWSzA51XyvTIftuwqh10OglSgk34h18+OI3ovzfjoEEO3UMx5w7owCzVWnhojyV1hMqkPB4TZJeqEaLokgu1RPuxuNQ3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-Proofpoint-ORIG-GUID: O6X9vc1W6ytwWYBxLz8PSPZVkNvG4ZKV
X-Proofpoint-GUID: O6X9vc1W6ytwWYBxLz8PSPZVkNvG4ZKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=777 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry for the inconvenience.

On 10/26/21 4:59 PM, Russell King (Oracle) wrote:
> On Sun, Oct 24, 2021 at 11:44:31PM +0200, Linus Walleij wrote:
>> On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
>>
>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>>
>>> Not only the early fixmap range, but also the fixmap range should be
>>> checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
>>> some systems which contain up to 16 CPUs will crash.
>>>
>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> Looks reasonable to me.
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Please submit this patch into Russell's patch tracker.
> 
> ... and has totally broken what looks like _all_ ARM kernel builds. 
This patch is intended to trigger build error when it check the value of
__end_of_fixmap_region is equal or larger than 256.
In fact, it breaks the ARM kernel builds which NR_CPUS is equal or more 
than 16. If CONFIG_DEBUG_HIGHMEM is enabled, all ARM builds which 
NR_CPUS is more than 8 will fail.
It
> can not have been tested. 
I tested this patch with allyesconfig instead of some configs in 
arch/arm/configs/. In allyesconfig, NR_CPUS is 4, so it not trigger 
build error. Then I changed it to 8 to verify my patch.
Maybe it's uncovered a previously unknown
> problem, 
Yes, at my side, axm5516 with CONFIG_DEBUG_HIGHMEM always falls into 
crash. Other ARM platform which contains more than 8 CPUs may encounter
the same issue.
but causing such a wide-range regression is disappointing.
Sorry for not consider this thoroughly.

Thanks,
Quanyang
> I'm going to revert this commit.
> 
