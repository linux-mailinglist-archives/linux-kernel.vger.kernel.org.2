Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6163405ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhIIQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:27:21 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:34444 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234735AbhIIQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:27:20 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189CeTmh019926;
        Thu, 9 Sep 2021 09:26:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=to : from :
 subject : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=PPS06212021;
 bh=CNLp0uz2KK0pOFZZDxvwUINZCjTizLVFbeWpZC94I8A=;
 b=ZySz5WOKcu2yP7IkEZrBEd3FY5Qk5IBpP/Os3BC2TswrZIbuLNXE/7yUcL+u4QfE8kgo
 tZ7BjShiOPEGfEzcYW8Ozad63xJIbu/GqqLG0avCx7+gFgkjM/miPIIvRab3D2LRcjOu
 uZWv3+n2QDV3zJ1gwD+h1cS7MEHtgz1KgEN6Yc6sjVrOUi5cfuLiqvT8SnEfKuhqB7d4
 3DJRBO9814W/DzB7wxq15ckIzMtGV8L7Ykct8HpRPNtHyotkIY1fFxSyW6pHNdY99YKt
 Mua9Kza73HnHj8RK0vNHw3d2wpr5aAmkDh1eSJyuF54cM01kd7OwKFsXHs0c0yiQAKxd 5A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-0064b401.pphosted.com with ESMTP id 3ay6sbrmuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 09:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0RKI+UfSs3S3G8CGH0uiJBWXH0CKORqk5nxz5qbvXKoakQmCDFATatVJevWLOUsmk+lNWyKku/kLdEFVr6C9BN07lJbZBHbXOVsioFGdpnKNCkLDK9Hdq9/kPG+XYwLUz95TUdUpZA2h1+73eisB111CZ3fv6PJHolwEBCPlAxSbwCtyB0BoMQmrzIuqkwt2HY9/6UZFYUiuopMxShhldfu63s0pNuezi1L7sjADR75s1KrPrbGBcw0i0b9C25sUGoCmoy2niFax3uP7pkgeZrrRtL3F8ov/PYXcEPocmxNgF7WAFFW2AFcSfY8vVLL/DosO7giGFc/cgC0r7xCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CNLp0uz2KK0pOFZZDxvwUINZCjTizLVFbeWpZC94I8A=;
 b=Rg8EzvSQ7883uOTSb1ynu7nU+9AOc3mAwcpp7fjY6+dQzWhW4j9Ad/U56t7Vk/6rMgWU8IvjclXPEKJw6IIYE6zDrIq83pCY3bucjnCDW5ZPlNJNado1VrOePaIyjX/3xFV44xcg1z2nj0FhMw+5ccRrciM6pnmjSN+E14Y97wpAZpZ5y4y+EL96JlaTeHcG2TIbSeHyrIRkGQPuzWfZ/6iGV6/jlSDx89InpCN0DI5PVCPi0H9ER8Z1mVsa/leB6xooJYp478DjaK58FMJ549iS6qOl7tlRDEzo/o+M0kWdjzHT0QYX6xN7WGLWXmxbmSVW/DMbong1DUBhBMcfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by SJ0PR11MB5086.namprd11.prod.outlook.com (2603:10b6:a03:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 16:26:08 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c5b3:68f5:53ae:d6cd]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c5b3:68f5:53ae:d6cd%7]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 16:26:08 +0000
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: question about isolcpus and nohz_full
Message-ID: <b39eca5b-98e4-6b9e-c65b-63aad84d8caf@windriver.com>
Date:   Thu, 9 Sep 2021 10:26:04 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::27) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
Received: from [192.168.2.13] (70.64.73.216) by BL1P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 16:26:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 940247cf-1707-49d7-9380-08d973ae8779
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5086:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB50862B64F1916EEF530BBB13F6D59@SJ0PR11MB5086.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ok3P1haU7GrXZKEiSJYykh2do05UQAfaHMar88oLA9oNv5pArh2vwTdQXaNGXsdJcbQE6ke07x61CQYlN0VC9ZXzTMXs7Wz18q8qZNs3Jhi0bologTT++aYPdM/6SUgEn8CBojy9Ntdz4R8H+S7scnPtEkq+VT+5pwNlb4MjeocdLd8nA0prBXtag29N+Wp83f5D220TUprzOQOQcoshGl4GTcZpOhdP/7xIsLdi/aFPhCWYBBwrPs4MaGi/dfNfS1FjC08Tv8NN9Gfk/jPjhBZJUMtyAc9LOHXRNsIGs4y2IVaf2AdIpF7Wg28dSz98ixNTJSy33tPRuNdH74kGCZVBrsgE3hR9XOTxnmPpjEZQ2Xspxttdoe+f2Q2lVdxHL79FKUgGBcq6l8yJpZ+s7GbnFOpZHhtx2BSLGhQeM92ONtlrUmMGR7LlzLsJH/w5sTA6YLeUADTWcDawP+Y1tKiM9bB6pBhAmbI4YiNujBcFiJN2xNUG0Lw0VCT8Oc3IEMRs6j345NPXuu3uaIu6jggRElHu4PDfI18LHcnPK2S1oHntJD0j/gkmkiTvtxziQjzjWkXT8t21WkQsG+cwxCSUoHljzuB6MQfOTXt81jmQJjb6EOaBFouAbX8sFumi8ITm2RTReiJBQOPbLpfTRdUba70TojR9ZZEDI512CEtfy2iBHrOmq+Mdgmz9au4dOh5AwPKXX7+RrgQRFP08zcHg9ceEEcyqaFF/J1+Z6MxWtoWCbhnL2lzHJo7aE975oU5IBJ0dpkx+ntdTaHJk4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(2906002)(66476007)(44832011)(16576012)(6486002)(8936002)(316002)(8676002)(2616005)(66556008)(31696002)(83380400001)(6666004)(26005)(110136005)(86362001)(52116002)(956004)(186003)(478600001)(5660300002)(38100700002)(38350700002)(31686004)(66946007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZZR0FuMEh6OENSYWxzcEt6RHNRMjRNZHNNMFBaVVdwTGcrSEtTcTZtTGRE?=
 =?utf-8?B?QnJNSk1OcURKL3hab3M3R01SZ0Z2NTNjMTR0Vm9memxaWkRHQlFkRkxnUU5W?=
 =?utf-8?B?dytMS1M5ZG1wNXVZbFR4dk9hOTFHQk1weGNLRStiRUZYYXlwQTBpMzVzdUR0?=
 =?utf-8?B?RXRkcGMxUlUyTVhkSTM4SE90b29BSDRSUG1valZRTUttS2JpRlpyZGZ1TTgz?=
 =?utf-8?B?RmZITzRpSjlkTUNSR2NacExWVjRVTThBdHZPTzZWNlUrM1VOZEdjN1dMaWRJ?=
 =?utf-8?B?MEJ4aUh2UmdSNUUrclJUSGswTndod3lScVVNQWxzV0Mxc0dveGhNSlVRWjIz?=
 =?utf-8?B?WnM1WTg0SzJOK2VIR1V0V0RWelZDR1phYkZOVXRhMk03YU5xMGNGeFBiZ2RC?=
 =?utf-8?B?aVQyZkF1UmlMOStLOTNscVBybDIycTJpVSs3OThicFk1OEpRdHFCcHQ5S2Zz?=
 =?utf-8?B?TUxCU2VqcmpHV0ZUK05rSjNBSnZjN1FkMEUzQUMxYVlwbXNlVkpxcVpGZ1NK?=
 =?utf-8?B?Zm84aklhekdJOUhKMFVhZDVNSEJUam92aHdWM2E0ZmJLNFJSZm83OUpRQ0Fx?=
 =?utf-8?B?cCtKRW51d2NlNGQxVlI1UHdaMmhDN082QzF6RUV3ait2NS8wU25RTXpScHJz?=
 =?utf-8?B?Mll0LzJFR1d4VjZOQlhKMTRwS21Jb2ZXeDcyNzZRUlR1S2FweDZuQnZ6c3hi?=
 =?utf-8?B?NC84V0VLOHZDUXRxZlVaMWkyMnR2TGxFTWJObXF0TjVSeExZZFovelowK1RK?=
 =?utf-8?B?ckpJOWVxckd0aS9Gd1czRDFNUkllM2VXUzhIbmlhQlQ3aWpJbURGY1pwTnZr?=
 =?utf-8?B?elJBckJpRjVxNFJxWkJLR2wvMGUvT3YxSE9CaVpvMUNJY1V0b2IzNjE0ZUNQ?=
 =?utf-8?B?NTRlQVIyTWo5SEErZ0hEc3VlcFJiSGtHZE43UHQyWDZZWUJiNmIvY2syRytI?=
 =?utf-8?B?SW1CMnRRKzhGdlZob1EvYkJ6dUdjU2dwdHBPSHJPVzFUZHYrbWxwNkx6WVBY?=
 =?utf-8?B?cUNDTFBsZ1llN0tvYzdpL0J5REppS1NOc1p2WXNRczJaTkt1NDhkSHU3K25F?=
 =?utf-8?B?VjdYYlJoNE1OWU9KYVFteTdDQXEyb1k3eURKbmI5cmwvdGt5SWltTS81ckxW?=
 =?utf-8?B?WHVyWWVwRTd2V1V3UlppeUhaeW9YaTVTeDMrZUVZaDJqK0hGWUdoV2h1V01S?=
 =?utf-8?B?THV6N0hwY0J2d1ZRWFB4KytZSE9oNXhqbmo0eFZpQTRkemhnUW83aFI3d0tu?=
 =?utf-8?B?RlBhdVRFaW1QbWpEbmRMWVIwU2lwdjUyaXNHSEdka3Q1ZGxFMWdEcmFIN3F0?=
 =?utf-8?B?cTl3cEV0UGFKZWdOQmN1YTM5Z2ZNcGJEWEZVVmpESmlKWG9rOE9uWUp0Mytu?=
 =?utf-8?B?aG9pd2g1T2xnR05MTWdkOW5hSG5iUWJjWnpOK3FqMHJWbCs0TFMxanF1ZGJI?=
 =?utf-8?B?d2RnaUpydEtYSCt0YWVpYzFpNUx0UlRxM1JCeEU1SEMwcnRWMlllUnhGKzBO?=
 =?utf-8?B?aVZWMUpBK2prdUtzQ21xeVorUVN5SkJUUmxvdkFyWjNlanRqTW9lUmNlUk0r?=
 =?utf-8?B?eXBIdzF2bjdhQzJCWHBScUJXbnhIa2c4L2pqRzhna0ZkU3IwMG5RMUJsQ1pl?=
 =?utf-8?B?UUtQbit5ZEgzV2JON3U4cmFtYVhMd3NwejJwY0xwNGt0NU5BMGtvd01QY09C?=
 =?utf-8?B?azNjUlgrdCtSQlJra2dYcWQ4eUI2bVk5SGR2T3RWWlM2dk9KU2Y5bENJVytq?=
 =?utf-8?Q?DJqDpF03f5bTMnHVc08bewRuXpb/vnsgZl1hVwz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940247cf-1707-49d7-9380-08d973ae8779
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:26:08.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYKQnKhscuFOCcuC7/NxeMQVCzqSRrmxDvFVngqDxuH7X3ivGkbbnOn25ND2fW7m3EsIhCUkdbR4LSWWiLpd9DyDZK2IxXPPduL5+/ZIzfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
X-Proofpoint-ORIG-GUID: XCuD-pywaPqyaEpmBvEBa4bAEkBVdJoh
X-Proofpoint-GUID: XCuD-pywaPqyaEpmBvEBa4bAEkBVdJoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-09_06,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=876 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 suspectscore=0 clxscore=1031 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm finally getting around to moving to a newer kernel, and I'm running 
into a warning "Housekeeping: nohz_full= must match isolcpus=".

In my environment I had a number of "fully-isolated" CPUs with both 
"isolcpus" and "nohz_full", then a number of less-isolated CPUs that had 
"nohz_full" enabled but not "isolcpus", then the housekeeping CPUs.  It 
appears this is no longer supported via the boot args.  (The 
"less-isolated CPUs were used for applications that expected the usual 
load balancing from the scheduler but didn't want to be interrupted by 
timer ticks.)

1) The kernel-parameters documentation for "isolcpus=" doesn't say 
anything about needing to match "nohz_full", nor does the documentation 
for "nohz_full" mention that it needs to align with "isolcpus".  Maybe 
this would be a good thing to add?

2) Is it allowed to specify  "nohz_full" for some CPUs at boot time 
without specifying any isolcpus?  If so, what happens if I later isolate 
a subset of those CPUs using "cpuset.sched_load_balance" in cgroups?  Is 
that allowed when the equivalent boot args are not?

Thanks,

Chris

