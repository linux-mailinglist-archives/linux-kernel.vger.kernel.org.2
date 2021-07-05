Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262BC3BBE7B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhGEOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:55:28 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:14972 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230504AbhGEOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:55:27 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165ElruN025347;
        Mon, 5 Jul 2021 14:52:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0064b401.pphosted.com with ESMTP id 39kyka85cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 14:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS0pP7l1s+ZvrkgqrHMQ13fO2Ppa4s/nri1pK5EFGswbInhv2bu4njqLksD7KFnSxGVq0OLe0Vyb2LU0sGBXffY4NqDSBdykdxid4fXCCznoxudY6b/KPR5oKG/zlPZFs3cphFzEAzg79+Tu/jseTH46vkWeN8c3NWbvDrKknf8gtQXjKhvuO9hQznQfSZycLtlu5jeW1wEVyqAJauDILSTQ4TIvwIsm2eio4WRzpZS0D2F4Dn5aoynh7AFBWkcmERkgEUTy2A4sA5DUCPrE4p9qtg2++JroEeN44hivHcfHMjDS04SEKE5hu/hJmIrhOMKmGMptNZqz58sqynOWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfSxz9/wyMS7GyWbZcN2o621C2pBNci3c0dTiugA6h0=;
 b=d0HHGZU0blns8ki16xawYpnIPpGxTdIbLJ2YKJnNSf2lbxAr/LY7+ek0M20Vp1nULMCiIyMeOnXV/YnzACZEcgjGdnoIo0eVwAGtKxgMMA2k9/c3RSEeYymq0NsJLBTDS4uIloNC6+qv//V5OJ4DLYakRozmJy3Sj/3YEnFi7WYZX46kNV5jrKBh2XWcHvEnyu4fJYvuN4WltKpUKS6J8V17doWszDwCdQaFTWw5zNsGO/jSVZ3mqVSOIKFT3fNoO2xw7d5UnIrs72xZgZeHI1xwtxoqI9m33QpVU0e5re1GCMekw1UuUoc1LGy5AllEOXbgfDd25AopcjzDLVSfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfSxz9/wyMS7GyWbZcN2o621C2pBNci3c0dTiugA6h0=;
 b=SUasgrgARzLUHVToveERTjlXvyeNdVN/qI20MvU/obB7dNvMwUYx/qX5vZkcoRsq0Nf8+LMbPZ/T4mmEkt4vxOpa8lomkcyuxW8PvAGOcVWW2+EMJeuqxqENoSHOLOaMWSb6rflCB3HPcVQ/CjjclZoM4OGbYzrP5psBkraMFY8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB4201.namprd11.prod.outlook.com (2603:10b6:5:200::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Mon, 5 Jul 2021 14:52:42 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19%6]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 14:52:42 +0000
Subject: Re: [RFC][PATCH 1/4] locking/mutex: Use try_cmpxchg()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <20210630153516.832731403@infradead.org>
 <20210630154114.834438545@infradead.org>
 <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
 <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <320cf54f-719c-8aa5-17af-455a53db4478@windriver.com>
Date:   Mon, 5 Jul 2021 22:52:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Mon, 5 Jul 2021 14:52:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd08e231-6104-4074-d43f-08d93fc48a8f
X-MS-TrafficTypeDiagnostic: DM6PR11MB4201:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4201B55C025E18CB0124BBA6E41C9@DM6PR11MB4201.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YzkcgrczaeTVWYPxJLtAEAdchmzi4NJO4LBapCCYfBO2o+3GTG7rdmHXC+kURhOV3DQIoLEZSaC/OF5PrdoWOGVd/Y6IxH8nQHhbxV6uR3EYt9T0R7r5dd/uDZNYgJpErCjxYpkM4JJBQ9w0eS7x3dvEJdWpiHxyhBGRTVbw8TMOfqK6KQ0Ge4lg/F/DLmRSNxdqHw/3qkBysAS3IlJh036fsPTFQABi4FY85RMbZiSlBgqofyPhcADKdEWXB3Jou5LjpLMhApzono63AUrHTxYQFWqqUlO/UDHdegIsANpAiu5vpa7CzpcE9XIC+G5kC/8Brj/IFyNwdWw9s6frbepAs5DTvzU4Wi1BN1Zp0AO81CpdQSnry1374Hdd5I29yGWeDCVJ/DXYe4HR7pyW+WhvWHrXO8GDIsBVnZnjD2eTV/dvQsBfZ5rAJm/jkfjFMhUs9StZGATE2+UdriNPsy+BKxxi54rWiO09VGZSf0VjiISxNyrZfAD0mCzSOy6aaoPOEac4qDWPc6eBl59gBjDgQgioCe85SG6cHxX7R2cDWw7ROo58scIss1d1VFTWWvn8Be837XdxYOKoaTaz64PiusTbLd8syYB6uTjM95VzjzJWvfecTLh5dBlRsXzaM5YrLhNiasjpM9lihGE8cYFV72pzh0O2DyzbORz1Hd6TiGdGNOol6TkACVUPq8jREh9+4X6DIN7Xj7edJiBP6eD2ShkJXtwHesRy9iR1kedt/421QT1EItdP9ZPnuhR1efijerE7JVpv42mPLv9tULiraCxl3LaOl8vUOBY5P8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39850400004)(396003)(366004)(346002)(36756003)(16526019)(6916009)(26005)(8676002)(66476007)(2616005)(53546011)(66556008)(956004)(478600001)(66946007)(8936002)(83380400001)(186003)(38100700002)(38350700002)(6486002)(4326008)(2906002)(16576012)(316002)(52116002)(6666004)(31696002)(5660300002)(86362001)(31686004)(6706004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNvR2JTYWdja0owVmhodmxTM3JjMjhpeVdQY3lRVE9penBVMktDK3VrQkZp?=
 =?utf-8?B?OUdyNnUvZGRoZjR0UDdYdVFHbjFZd2ZoMkp6RGxlU3gzZHBjRUVZeGpWQTlR?=
 =?utf-8?B?WnBwaWJxYklDN2d6cVdTYW5tenlUV2RBN1lYaFZVcitUYlVFWmx4bUYwR0RC?=
 =?utf-8?B?dTNCMFFLRm1vdmtTUlg2eDNhZUM2TWF0ODNxT3BKTGxka1lRWmNnaUIzUWxK?=
 =?utf-8?B?REthMTNJTlRnOGNyVnJMcFVnR0wxWlpMbFNUN0pqb2hlVHdnMFd5ekM1THB5?=
 =?utf-8?B?aVpyUE5iTXRUWUdaOWt0L2ZRQUpxRHhFejVma1JEbkJJMGIzdWNpZkZZdXBq?=
 =?utf-8?B?bHhFTjlBZ2ljc3RvdDIzSmhjMmRsRURENjhGQWk0cXBGUzNDd3J1eUNZTFAy?=
 =?utf-8?B?RW0zVnc5WHp5bnVPd3h1OURaektYcWREQ0t4OWlTMmNZaE05WWlaakgyNzlE?=
 =?utf-8?B?bFJkWWN2aHRxZmFvc3ZsVitSTGhiUDZ6QnN4QnZaZnExRlhrOSs1cmlpUWhi?=
 =?utf-8?B?bUg3ZTBCYSsrbWpJN2VSeVZ2eDVBbzZYdVY1WXJ1UVoybW9DUGZPdnlGcUxr?=
 =?utf-8?B?ODNXTEI0QkYxZVpTY3BpakRMZXZGVTUwNklUTHpHQ0pFdnJjRzFLOUJHWWlD?=
 =?utf-8?B?b3J2YzZ2bUxNVnprMDF2bVFlb2RtS3JEbW8rai9iMkg1dVB4NmRIUWdNRzJQ?=
 =?utf-8?B?MW5zS3g5cHNHdFQ1MnhEUExHdzdJRnFKUU4yLzQyT3d4QVQ2VjRjSmsxemFw?=
 =?utf-8?B?WVBYSEJ4QXo4TGM3L3FOOE1CWXRXNmJhS2JpLzY3aHNMSE1HY0pJbzEzUDRj?=
 =?utf-8?B?MDBjd0RQTVYwam1IYVBPdnFRRkdNTnN2a080Y2cwUW9nelloZDZuM2xIRHZE?=
 =?utf-8?B?UXl0ODJtZjk2U3JoZlJIS1hRN0VRSzlqR0lFam9uQTZENm9KZTVtelE4TjNN?=
 =?utf-8?B?ZkxuRlcxMStnazFMRTZPNktkeTYrZEZ2b3AvTm9UdUxOTDRFVWVZWlNFZlpE?=
 =?utf-8?B?RU13N1FBVXB4NHpPMk9iM1ZkRUd3NTJMUG5YWTZoRmR3RzZWamxIMWpjUFp2?=
 =?utf-8?B?TC9td2FySm92MW9LNTZoWkNIWkZuU0x6Wi9La1BHRkx6L1lIeFBHenF0QkpD?=
 =?utf-8?B?ODBpVUo4MHhpSCtKbTlKMXVPcHNueE1GV2pPelE3NXVZdnVXR3YvTmlSTXRR?=
 =?utf-8?B?SVpIMnVESU5sQW5yWVhwZkhOczBtNHk3dEtZQUJQbGdJanNYT2tDZkc0YTRz?=
 =?utf-8?B?eDhQK2VCRTBOS3dtSGt2MEFRK0V5ZG83c3MzUXhJWnBaSzlCNUVJY21PWmti?=
 =?utf-8?B?Qi9mOE5IcUJrSkRzRHhYQ2szclcxbUhXZ01qNWhLRzFwNEVtamsrQlBiZmM4?=
 =?utf-8?B?bVprVGRUL0hYa0NjQ1k3UHpHYmlWSzZMQTNWaVRyRm5Dc0N5SGJlamxWc0ZU?=
 =?utf-8?B?bmVYRGRhN2lQZCttU0U3aTVTUk5GSk5sSnBVcDRSaDdHTGFHa1dRNUF2VU9w?=
 =?utf-8?B?U2ZDVG5La2tjUllmWGFWUGVNalhmU2p2di93Vlp0U1p4UHhXVGZYVkRZb1Zm?=
 =?utf-8?B?NTVjbENocEdVTVA4bTRHd2lMT29UdjNxM2dKTjFHVythSDNvMHhaVXRoZVAv?=
 =?utf-8?B?QmtCeTN4dEFFRlFJWEp4aEd6YVhRcEN6THo5Q1l0QjdQeWNFUU9vSGxYZkIz?=
 =?utf-8?B?MmpJTXdWcmRmY0RicGdRRTJ3U0E3emFYWlljNkJIN1h6bTFZUFNycWtSc2g3?=
 =?utf-8?Q?3HZhAfTakoZ0EaGyucYGs8unro8Rl0IY+Bu9DBG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd08e231-6104-4074-d43f-08d93fc48a8f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 14:52:42.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCyc3JeBKiua46z9WKwX8Ncx648QwYR4CTeZydZ10mfAhxD75b26vOJObf75rzmWincTJx4HXP34Vv+lT49Dtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4201
X-Proofpoint-GUID: l6ER9bM3d-KI-FGYX_RWGyd-bqyba_ZR
X-Proofpoint-ORIG-GUID: l6ER9bM3d-KI-FGYX_RWGyd-bqyba_ZR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_08:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=997
 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/21 10:00 PM, Peter Zijlstra wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Mon, Jul 05, 2021 at 07:59:12PM +0800, Xu, Yanfei wrote:
>>
>>
>> On 6/30/21 11:35 PM, Peter Zijlstra wrote:
>>> For simpler and better code.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
>>> ---
>>>    kernel/locking/mutex.c |   27 ++++++---------------------
>>>    1 file changed, 6 insertions(+), 21 deletions(-)
>>
>> Hi Peter,
>>
>> I read the mutex codes today, and find there seems something wrong for the
>> patch. Should we consider the race condition as blow?
>>
>>  From 4035f50c96e17cbe3febab768b64da5c000e5b76 Mon Sep 17 00:00:00 2001
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>> Date: Mon, 5 Jul 2021 17:56:58 +0800
>> Subject: [PATCH] locking/mutex: fix the endless loop when racing against
>>   mutex.owner
>>
>> if a race condition happened on mutex.owner after we fetch its value,
>> atomic_long_try_cmpxchg_acquire/release invoked on &mutex.owner will
>> return false. Then we need to reassign the temporary variable which
>> saves mutex.owner value if in loop, or it will lead an endless loop.
> 
> No, when try_cmpxchg() fails it will update oldp. This is the reason old
> is now a pointer too.

Got it. Thanks!

Yanfei
> 
