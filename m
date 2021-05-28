Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B12394343
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhE1NNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:13:12 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:47738 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236098AbhE1NNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:13:11 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SDA4jE018541;
        Fri, 28 May 2021 06:10:15 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-0064b401.pphosted.com with ESMTP id 38tqu5refu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 06:10:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VURfAj/gAXSdP7X1TH3mBOH9O08tAQMZgUuBEBHOFHrK9v8fUHEV7DRmk3i4ZNYxg5duZ2laOXrr1H3RFSmzx0cOGicNmbAtTXg3NMoMpbAR/G3pFhdDoa1TvQIH0iSLqhrCFMUHgNC5dngTBBkYP8OMhNo3kmTyA/bzszLztUHCpnlGu6q+2uTr4lDzCyOm7N/xxqkyYlrK/yZRaKRbqN++nttogO+yBKTa1h3hKxhk1yOXrnAqQ+EzYjail3XnmGokevNKm588Ap03/3pDFMlmQ42yuG0eC2xFzb5LrlS4GeE+pCV+eFIBfuwvoU637eDu3yoNbjG+7X4s9IgIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZmk5TU1WeIynz54OYqUNFnTD32yY3bgDrytAJPhYTw=;
 b=k7TpsSuvLq+/r8pwsr/PGOb2zDJ7SkJjoVu+TpHjHytHQcBO9COsAvd7bgvWpIiOhyLMQaei6M4xFI18IOntprzKHKEqIlxBOmT8FznIE0ytO94Awj2Ef0qNZxNreTikojRPYbnX1cw/i6TsMR48YMxKuZbNNb8MKQTJqlXhyTk6ytVY4+OB6A352Sz409ZCpVxCbRmV5SgGNx80Lg+D4QaSG70XA+UkzIXK31hC83prvsXR6JoI1CeiXTQhepYvhVJ0LBvacpGSAaytP1bRo4rSP8Sz2saFtkuzHb7iiIJHJLTmF3LMNgRZ9qA45YiZvteQJk/+pX9Vcz7io/mptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZmk5TU1WeIynz54OYqUNFnTD32yY3bgDrytAJPhYTw=;
 b=ple00PjVIjjr+6qAyqNhtWqxsnOHhrxhHFdT4E0YtRrN7h2bfjNV//QdtXbfgrT6bIkazUE5m7bpcZdATj7niSJDFFOWnImAxc8Pq4zjvBgY5uoh/edFlUswJU4U1rFEbXvU/E6P5BkA4mZyCx6Lp8L0KO4giRd/jGmtyKPrA2o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2677.namprd11.prod.outlook.com (2603:10b6:a02:cd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 13:10:13 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 13:10:13 +0000
Subject: Re: [PATCH v2 1/6] ARM: change vmalloc_min to be unsigned long
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1lmZSl-0005Sa-On@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <ee3e7cca-1dc8-2696-cbbd-9e1238e762f3@windriver.com>
Date:   Fri, 28 May 2021 21:10:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1lmZSl-0005Sa-On@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR04CA0063.apcprd04.prod.outlook.com (2603:1096:202:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 13:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e1cf056-5f91-4eff-b9f5-08d921d9edf0
X-MS-TrafficTypeDiagnostic: BYAPR11MB2677:
X-Microsoft-Antispam-PRVS: <BYAPR11MB26776AB2E0E373DF960CDDB0E4229@BYAPR11MB2677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzCLUFnF8u5ayMjtGYz39Z/CIGhSnn5vp3lJX9EEVbFWHBm/U7y/gJ3hBIMWXivYqkz9lCSBPMOguaUt1qj8l1r+Z5vvJ2s43w23VHbKGye/Y2qEdBsSOM+lLQgthlx17R7T1hL+K3GuG9cPqCyBmj+Med/qQcAGAJIeRlP2H4KEPg2nNkbjssdHFSVa54gBPREVo/FbIAMGuIoC2p18jV+yfwn+bEm+Kov8Pi8KEQ4GLkVkMqW19tCQSpC53HH/DE7Su9pf6jcwXwnPOOxgn1NNLRFq3P6KIqVWRslWXNJKWYyWb1ONPolJ76Md59huk5kgDxhpoT02BKeOcrT9+AxuPHiIzU9TDPwfssq0WwHf07anCbNkEh2C/Kseyy1zVNh/4i/mrtLGlsFOPUemyfszEo64pWvAo+tOyeuLSHuxr72Xq/lj0GK277+T0guA9Jgzf99K/wM8mzuVuU5KaU94yzEm5J7ZyNYqFMHAeqkkxLT/A7d8vZ98C88NY34Nswps2Dq96cnfF32aMtfwMaRdD4RJIp7NvEHvnlPjFcugzoqPif/Rb6kdHRpMibwtSaHhXHgTdmN+NW6uIebVSedfObvVITxQzUxPH/wTVkhGw+v1LtC6VjOKnNFRMVttlRUaW6wdTvrSQtvoz2gT5Lx09YurFaGkgELsvt3/pLFCgQn7X1bGRnuiSS29/ZedadPvCMebOhd8uuvQiCEdBsx/k6pyXnXXughC41g8yyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39840400004)(136003)(346002)(396003)(31696002)(38100700002)(38350700002)(52116002)(5660300002)(26005)(53546011)(66476007)(4326008)(2906002)(66556008)(8676002)(478600001)(36756003)(186003)(16526019)(86362001)(6706004)(31686004)(4744005)(316002)(6666004)(16576012)(66946007)(956004)(2616005)(6486002)(8936002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VXUrbGRxSUY2aVRoWmRMQWtnTnJ1ZmtROTYwZmVpUTZPM3RUdC9kNFVpWXJO?=
 =?utf-8?B?OUFnUGFoZHRMR3MvL041RmVEaitCL1pLeDRlN0J5OW9TZnlYQ1cydTJqVVJL?=
 =?utf-8?B?UnFlbTJsNmtGVWEwQnZOTnNsemZ5N29FT1Q1eDZhdEQxNHV1dVpXOFN0S0Nz?=
 =?utf-8?B?RUFhY0JyUU1xZDdvTW9XK3oxUmpydThzMnBDbkhyeDZQenhPUEh6R05PTFJO?=
 =?utf-8?B?dERWbWVjQzBTWi9LelozalRBQlRNU0ZPOXhNaXBJbjFqNWFqaU5Yc042T0dJ?=
 =?utf-8?B?QVRmWmIwa2tja2ZydEVtemU3MEpsR2NKc0J5WFJHUnp2a3lvck9DNkhxWm16?=
 =?utf-8?B?RXZiOGhqYnl2ek5qakRzdU5iUmp0L1IrVUFsZGhrTW9ENjdFbkkvSFB3OGhU?=
 =?utf-8?B?RVpjaDVzdCtjUnVYalN6cmR3NnFRVUNYY0duOUZjR2hYalVoZ0RxUGZMQk0r?=
 =?utf-8?B?dDdIU1FPRW5UNmN3L2szV0NkQzQrVFM0R0RCOFQvczVPekRqY3dmTjlueXFD?=
 =?utf-8?B?aVIwRStZcTdSRThYWUhJTG9kMVZXNE9FWHVWeU4zS3RGN2thR3ZyM2ZBaWtH?=
 =?utf-8?B?VUNyU3MwdUhIS0VMSmx1QkQ3WkQzczNxbW5jNjgrK3kwcHJlSzl3TjU4aEtQ?=
 =?utf-8?B?eFROSWdvWEtTZ1pVSERJZ3VKU3BqdnZMRm1QNjQ0L2lBRm1rSVJkNDR1SnVs?=
 =?utf-8?B?SXZRYk1pSWxWY2duMVFMVTJTaDF3Y1ZBSFBQNmJUbXRtY0lCVjZCZXhtU0lW?=
 =?utf-8?B?YzdvS29kOVlmalJwS1htdEJObEhGb3hpOGdZd2FOZ0J1V3VOT0ZudDRDNldV?=
 =?utf-8?B?LzJQNGNDdlFGSUIvV2xpUWRGY0F0OHArYUlRTStYQXNsbStLRjdEWmZtSTBT?=
 =?utf-8?B?WVhBZ1FISzYwclJpbkdwcFFUL1ZldmJyc2tvZVdQVHp3UTZOMHhtanc5WTQ4?=
 =?utf-8?B?d05rQlRBNXZubHMvL3hqR1F3Y1hkQ1ZNQ2xLOENwWFdmSXpoS2ZucWREWjEw?=
 =?utf-8?B?SzBRT2lxcU41NVAwUEpvSE9nVEtzUjdyaWs5OXl4TjFSa0djWVBTcllNbHR3?=
 =?utf-8?B?YWZlWGc0Um1SQlNqUEFlU3NEckoza0lZZkV6VDlGVWNoRENmNlRXWkVONFFm?=
 =?utf-8?B?cFpFTGF3RWNWeklhclFVQzZpcVJQVXphc3JnNUFrQzFKU1c0L1dXMmtXNXc5?=
 =?utf-8?B?eHJ3Qjl5NDlZVXQ4aGdzbWVvS1hhV3RyQkt0TWNpaGlnS0c1aEUzK25tRW5i?=
 =?utf-8?B?TTdWSWp5QkZxQlZMdGpHTXpQVzlySkVUZXZOQkpEMUdJNmplMThKVkpyOFRR?=
 =?utf-8?B?aVJDZWl4SGZaLzNxV1hvL1dKdHM4Ui9ZN244RmJ1aDk2N3U5ZitWUWJ2TTZ0?=
 =?utf-8?B?ak82QmZvNzY2THJsdzZRWkNXRU55bG9mbnRSaDhSRXgvbEtkWjVwaCs2UGVs?=
 =?utf-8?B?dnNNU0h3bmNydXo0S3BOeGRJV2dWSVUzVjU4V0tpR2FGUVFQRXl5NkFZWXVW?=
 =?utf-8?B?UXhqR2dxc2NXMGZUa0VlYTZPWWlFc2pnaUswUGpIVHBpdzN0dTNEZERVT0Rv?=
 =?utf-8?B?KysrY0taY3hUY01DdVNmcWdYVitJemt6SDNBZXRWQjdtRm9RRFR4bXBXekFJ?=
 =?utf-8?B?RDlUZzZ1NnEvQW1Fc0JHYUZzUXNxYTk3VzJnNFhRdWtOblBNbFNwUTF3V3JJ?=
 =?utf-8?B?RVNmcnNQS0xiK3BxeTBVdUdyVE9wVWFSQjUwQ3BsK08wOVQ0cnU3SXlPSHBa?=
 =?utf-8?Q?IjU2B1YoGf06ycKqfSDRp3M1jmKjDLK8mUz/ea8?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1cf056-5f91-4eff-b9f5-08d921d9edf0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:10:13.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5hPOBoqYej5GXGRlj0Rycce/+wSxC1owRGJvigR/jEaZJ+NlTJwTuHGFumjtZWhixYAJy5Gj/Qwc8OK8jfELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2677
X-Proofpoint-ORIG-GUID: bzbMHX1gBBoESznFLu5a8_fjqvbEfOf1
X-Proofpoint-GUID: bzbMHX1gBBoESznFLu5a8_fjqvbEfOf1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 6:11 PM, Russell King (Oracle) wrote:
> vmalloc_min is currently a void pointer, but everywhere its used
> contains a cast - either to a void pointer when setting or back to
> an integer type when being used. Eliminate these casts by changing
> its type to unsigned long.
> 
> Reviewed-by: Linus Walleij<linus.walleij@linaro.org>
> Signed-off-by: Russell King (Oracle)<rmk+kernel@armlinux.org.uk>

Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>

Regards,
Yanfei
