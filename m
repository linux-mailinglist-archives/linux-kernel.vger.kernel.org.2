Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77339432E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhE1NHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:07:42 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:26870 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235473AbhE1NHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:37 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SD4L4F013976;
        Fri, 28 May 2021 06:05:34 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 38thst8p3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 06:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La1QgWePdsuY/ZXPpGIEComJGQIdpvqkxg7YWzGYU+qqWwu5+f+sRXkAX0b/+l2CJivzx/D4DcDxxYj4uPBzhz/0v9Ozqw7CSOlh4WWBcotpF46i3iwkxlX9FecfRoaY0ddsUwWaqmeFdZtSZ1Ve+K2Vw/TYihDn8LO8NN3fX0t8TxqtyI2FdCQ1VE7aBE4JthrTqyP6bdDIQIWIMGpt0bCur1x4Q5D1BIaP+vBQFilOwQoX+HKy3ddG2QBUbqJVld0tz19YJa+Hiysubc/2YPkt5GhbSLl4AXRS94TKWU8z9bf5g9fyfeLHqWM5I0uU8U6fZ5QRPdt3oBhyIqQQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXt/ZVTlezXr6oaicND4GMDYXPCU81EpQJbwJ1qSj98=;
 b=ncWcKPMv60K0aVrdSEPuR5mop5UcEnrwbl27Q6/ohbeyZqmAq2hsQz2glbPnjQ2q9OzPKb3H3XvuxmT+fH/TV8kREjgh5M3k8xYtwkB/1FtDTwy4Wy4IFISxfyObvtZLBfjwKxoHzjaozCz63sYxdu1aio6I2/ur6YVoobSamkKofTA+RFDL0aaqkP9nm6khlqo9bBR/QTao7nHf5GfnsMFnhKM4J5Di81FKP8FBsp/z9ZxobbVc/Az+w1l2++qjR87PS/B9xGGMqnKxhvmaCgyaH/bKrfKg+hCxtSYiuudces/pJ8iUgNaa4LKTQ3xAby/L8iuYDhuhIta/7AtlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXt/ZVTlezXr6oaicND4GMDYXPCU81EpQJbwJ1qSj98=;
 b=N5+z5U8ApMUfnqES2kUsUog5pHNYU/BRsMPvzKXZhmV+yMmyeuuA7t8A0ZkTaE7xzFqvoKND1i3Nqj+GaW/LZi/m8k1lbYz57OMFI+HObdBB79TgBmOc8toKuWgEZpdfgoR/B+QgT6qkJ7Q2ShOgKpTleqaRdf8GHDmeSTuPa1w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4274.namprd11.prod.outlook.com (2603:10b6:a03:1c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 28 May
 2021 13:05:31 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 13:05:31 +0000
Subject: Re: [PATCH v2 3/6] ARM: change vmalloc_min to vmalloc_start
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1lmZSw-0005TI-0s@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <fb5021ff-e39a-537b-fe94-52b6e31eacee@windriver.com>
Date:   Fri, 28 May 2021 21:05:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1lmZSw-0005TI-0s@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR04CA0073.apcprd04.prod.outlook.com (2603:1096:202:15::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 13:05:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd640389-2e02-4297-946c-08d921d94554
X-MS-TrafficTypeDiagnostic: BY5PR11MB4274:
X-Microsoft-Antispam-PRVS: <BY5PR11MB42742C957961750818E204EAE4229@BY5PR11MB4274.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8bcLP/APoiVQrwicDABP3twug1kuEHThtG8B+axtXu6sKFe5R3i+tXFz3BzmP5bWswTZqc15vV5SEB+QwM51oFGiCCgnLqTjdt4noJ54aDaGYgToGMU/lZU7pm78EIHtj5ktFfCiVVSzM1I4H2sla9h/1s5QsoE5r5dFWhXYrEOjvFcXr2D2o/3gVjCugSljMD4LW3Bb79kHwbYO4+WEEENYASnhQQ2+3OcbvxqZDPJtLpJNFh7M3InM3NECqJfW05b4mupEn/miX7YtfsG8wBaTJOPj/qC5+UmqB37459jQZX4hOTRBa8vmlCitsWPnt1600shxoGepVT1E/La1WzL4cJCpMXz9J2+KU3rmfvRuiF4XCIFJ6lNp9i31/fT1y/xkphGghINUgBuoA3BRvdsXo+XLCZWnDqDsWRDBVNIMwbKB3Z9HEtIs2rHUmElk3MrCTgxM8PKR0EQ2ZuOUsMfY+AbsUHtM2GZA5AHOMXv48iZTolEQTCJoWTXGVgJ+ljH4P+SAq4bgv2K7VtFxsHI7r1eE/dOdknATWOm23UvaPsNEc22YPaY+ZV9YzjMWP/fh+u7+Vuh3T/+cUbGJTBpSZ5+RwF408VV23Sjzi9/P62FqIiF+MgpDWp5HnqszgCzhF8/LUC0gxoRb4wlxj2ztEN76T32IqNTctRihdMjENIa8aYxsjsWhNgofz5vOS5ojIOzYJpGc8c/+zqBl9UeBTQqLht0CQuplVmSDCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39840400004)(38100700002)(38350700002)(4326008)(186003)(86362001)(31686004)(16526019)(36756003)(66946007)(31696002)(478600001)(8936002)(5660300002)(6706004)(16576012)(53546011)(66556008)(6486002)(2616005)(316002)(956004)(26005)(66476007)(4744005)(6666004)(2906002)(52116002)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RXRSZ1pvYVNLcFVPU3I1M3psQ1ZWeFZGK040bkxsT1VBRjJaVXNSQ1BUK3gy?=
 =?utf-8?B?WDhFb2lyenV6OS9hVXYwT24rbURPY2hvMVVVOGZLcEdQWXQxLzdEcTFkdER2?=
 =?utf-8?B?Yk83RFJxZzA3N24wVDNkK3hXbUdBb0RzUWViQkw0Zk5wRTMza3JyY1oxb3Mw?=
 =?utf-8?B?MjNrUXo4Sk5iOGJNR2dmWmViSDdtZFlDdTRKWWVDMVZMV2t4bStsc2lLeDRH?=
 =?utf-8?B?d05FZWxORVRua0dwVjg5UmJCVGcvZUhrUlpkUzd6UkcxNnhlZnhqcU9rMnFL?=
 =?utf-8?B?MXRseld6SlBCSUNUNW1Mb1Qvb0xEbkxTYzRKVnRtM2IvOHNsNjNpMXhmd2hp?=
 =?utf-8?B?cEhHb1hwbFhCYk1DWVUzYjdneFBhNjQ4WUpvMzluSi9DbnlNMlNlVFhocWMr?=
 =?utf-8?B?QVpSa2E1UkE3RCtLbWlSeGVoRnc3VGNIN2RuazYyR0JnQ1dISTV4MDB1M1l1?=
 =?utf-8?B?OTNVWGVzenRDYlpVZVJUSEdVRlNTMFMySDlaNEU2MjFYZ2RqejYycHgwVS91?=
 =?utf-8?B?WFVwang0Z1BKS0lzaXp4cUllY0lyMVFNY21lcFFkM0R5OUl0aWZidkZwRTlS?=
 =?utf-8?B?ajBUV2tGcVpMZDJMNTNkYWhDWEtjbXlTTGtvcG1CY0Q4YjRvdk9naysyK1pH?=
 =?utf-8?B?bDl4b3lYVlNxc3FqWUJBNmtGMy9vVS9kbE1QMEI2OW9WUXdBODRBTndzZkZu?=
 =?utf-8?B?cW1OcXlEYUVQdlpWWHdQVjFlWEl5WDR4bzllS1BzNDhGeXE0clM3ZXZxZ2tk?=
 =?utf-8?B?dWFTL3I1TTZRWDJFTEZGL01qTWR2VjcrclJvWFBpaHJMRGxxYlE1NGczYjkr?=
 =?utf-8?B?QWF6dm9ybWVDeFBVOTh3VmZTbjR6Myt4TmVxYXhkUjFCampkamRySkdRWmtF?=
 =?utf-8?B?ZGMrMFhDOTFQRFZvMUJxN09tSXBnc2RuamtNMXRZNlBzR0F3cEhKYW02YmlE?=
 =?utf-8?B?Qk5nSFkzcXVsVGVpRnpMVlBZY1lZdXhXMm8vZHFxT3k0MGZZVjR5OEZyVG84?=
 =?utf-8?B?aW95QitIaEJGa0J3VDIyaHVrN0g4ejZOVW5CWmREbUE0U0hCb0VnRDdRK3pO?=
 =?utf-8?B?dGpLSXRsWVp1bC9hcjZBaTRkaWQ1QTArc3Q0UU5DdllURVBkMEZodnJqaXNt?=
 =?utf-8?B?SDJneEl5TE1yOE5TamNJVG1kUzFYbi9qZWRjWXNNeHdMZHR5cE9yWWEvWWdk?=
 =?utf-8?B?WnE0Qkh2c1pYa2RwblZ0dGcyQkxManJtYkt5QlZydldFWEc4SGx1Tm54cTBM?=
 =?utf-8?B?Ym5GOFcrcHJiTEJYRSs3NFZMZkRiTVNkL0ljV3lQcTZNUWMzbEJMK0NXYXE2?=
 =?utf-8?B?blJTd2pGUGVUYUw2eFAveVdRQ2owWDJtWDltSTFyWkZvclR0dEJVUjgxU0d5?=
 =?utf-8?B?Z3FrdEhNYjJmSzNuQk5iQ2NSTWFya215elZKa0hlaW5xZUh1Si9ONG1CdUpP?=
 =?utf-8?B?aGpvcG1FYTFVMmRYeTVsTG1qTHhKbEV1c0FKS2lUMEsyS0tVY2FLTWFrZldB?=
 =?utf-8?B?elQvUkJsQnBxSUJIcGFvSTNBa2Z6dEl0UnhzYXRCcHFPOEdua2ZndTNXVjFY?=
 =?utf-8?B?SXNwU0NnSnVvbFNORTM3Zkt6akZrdDN4TFFsWi81MndJVkdhckIxMDJoZnIz?=
 =?utf-8?B?aDR6ZHpxNmt4bjUxSlVzSmlDMUMxNWZjVCtnY1hBZUVZRm84V2Y0UUtqclFO?=
 =?utf-8?B?YzR0N3FrLzJQSjhpVDExNEo1VkZaZXJneEUxQS84RGlFWThhTUw4clAxYlEz?=
 =?utf-8?Q?WMCaL934wP89XICfOXHhJemOkC8sATiXsQxRIg+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd640389-2e02-4297-946c-08d921d94554
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:05:30.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOIsGevFn2j8ZDThK5WHv0Oz8TvUY2THpJQTIPZJ/ydVKgYArwuXL/aPj0M0MIILogF3nyrCzPYPz+qOQKe6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4274
X-Proofpoint-ORIG-GUID: bec3wEdkWdriRTYIO3ynOVVp7IRRrDr2
X-Proofpoint-GUID: bec3wEdkWdriRTYIO3ynOVVp7IRRrDr2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=887
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 6:11 PM, Russell King (Oracle) wrote:
> Change the current vmalloc_min, which is supposed to be the lowest
> address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
> which does not include VMALLOC_OFFSET.
> 
> Signed-off-by: Russell King (Oracle)<rmk+kernel@armlinux.org.uk>

Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>

Thanks!


Regards,
Yanfei
