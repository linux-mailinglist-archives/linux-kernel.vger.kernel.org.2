Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766AE34BF69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhC1VmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 17:42:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1Vll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 17:41:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12SLdvqM014710;
        Sun, 28 Mar 2021 21:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=slw+JkCZ++NbZyzFUp+/Hsj2Yot4fjvtKN90AD5p2wo=;
 b=uZKhYJNMJOrGlx6IEKy95aHWKvopL71/KS23+ZI6hmFWkzO7D9q4wTwnVfDi0YsVBo0a
 +Qz776Yq2402Uvpmbho3BzCSCCnx8qDlgbwkOBDYI+up8pyjG0U4D968DNQKZiOZXwwd
 afFWmUAhWBCqF6aHCe3jWHXc0xqKXID8SbbOVKDB0XQeeCMu/eF3h8U5KvrpvRTApilQ
 c+spAesHm7e73gF0Qvy83nyw1S4Jvbt0fAE52vPdAWfEcCI5pVKvzrEJTsDlz49B+QmH
 D1Zjcdz2hfUPKUlIV3z6WL6rUq9DCPoQxi90GlogV5gkl0o6eccGieLo2Gn1ApY6TFSA Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37hvnm1uyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Mar 2021 21:40:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12SLPM7C078076;
        Sun, 28 Mar 2021 21:40:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 37jemv07xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Mar 2021 21:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8dicePUrLWUQUjGLs9vPpFKGwo74ZIxmMar5bxiNZwHsn58XPz/oyhnFT7MZmz5EXGRRjhVByFX5WomWRotgS9Jd5ywpgg1gqf/oGJJsuX6NS3jOGmvTwMdRVG6/CZRYC6qGTuPPFCx/dnKwCUIg5lW4zZrOMHxfOhEQkBrwqMN3I/NmHWR+BSaIEIAIMADJpikNXfBgOYBm4reHXC/I1V8v1yC1wiVW6spZQ5i337njzR4rdaKtxoJrEFe3N1TYL5F01OSfBvZKg+j7ajTeDcOLvcbRs+VYeoYgpVkH6oRunOnFrzho76j6Z0KogKPymRLDZgXv+pfcYT7VyP0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slw+JkCZ++NbZyzFUp+/Hsj2Yot4fjvtKN90AD5p2wo=;
 b=lhkci1YmLdgDUEUADi14o/zeyqJLqkTreUTen111dGCYVhDb03PwW9P7oedv5GTYw0BlUElLDdyullpG6NRWSNpZJ9Xr1KMM5Dm/ZJci6pcBu34CTisekEaQw56vN4dJTAS6hGnDFojAl3ICbwOY0Q69RfW13UsYl6zv5hRKbHHIH+vKUcej882jz0DjNq1wkyCnuR5Gtx72sPEnbNQ2zT2DQCyoW7C+RhkJr1z+k3Z6/QlzHOF7Y+o+gI+bg9b7VZq3PGTW4ukIXz//1r7/UC6S2Fxbsp3mTlZ2PZ77TNsLVjjZkeV2vT4a54LdMmSeI0ONjg13JNNa6Plzf5CgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slw+JkCZ++NbZyzFUp+/Hsj2Yot4fjvtKN90AD5p2wo=;
 b=cF9bqI6jU73SpiH9JaC/Ak5ckC1IiylYwdR9xAHXdmh2L320r2Rwogh1kyy9tNlAFutm4eZdvvnQxl65E3bcYF7FcaSwousFddgmlYAZvUHdmb7W55bpsTQFShmu6iysBuqOZ0OAkJFeSQ3htpmwsDInumIoofvpT6XzPV2Qs2I=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Sun, 28 Mar
 2021 21:40:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Sun, 28 Mar 2021
 21:40:38 +0000
Subject: Re: [External] [PATCH 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-6-mike.kravetz@oracle.com>
 <CAMZfGtVMMBEFQAS=ch9fJFhCk+gBGV_frXBFnJLZR2Q22U4q2g@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <31334184-01d8-a0d5-d3a3-6bfad08f2eb7@oracle.com>
Date:   Sun, 28 Mar 2021 14:40:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtVMMBEFQAS=ch9fJFhCk+gBGV_frXBFnJLZR2Q22U4q2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0072.namprd18.prod.outlook.com
 (2603:10b6:300:39::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0072.namprd18.prod.outlook.com (2603:10b6:300:39::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Sun, 28 Mar 2021 21:40:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b9a950-c1b6-4d6a-71cf-08d8f23220bb
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4574:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4574B9D528AE8F0F44C509C0E27F9@SJ0PR10MB4574.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVeYdycJnPkqg7CYjXsZBgYmQK3WEI/qouwqBsUDwM5i2wnjEwNgYG6O7B3Kg69KXttH8HIZZoqEegLneIUbbqz7piVUtu5P9Fga0eDoOBD1G0r/TDpLf8RuR+B4mRhi10l+zhwcIcYe2FkKKjI0xJVjYJmpOfTFle8MP/dGAqC8fFvTcAC6I6dhnW7oCBWXd5Uz39T4MW5LaH7UGw3StNXPisIuiYbuI1/WLIkAd6nD5sy8VncD1A/TUw/N2kRuonI6cySOIFR2F9toRdKqja4JYNEAmlKSnRknJ5pBJtw3AfIIIABmWm+mTTn99IjODnP5y4T9ibLWkRKrqPXzsZ2xG2FmNFm5dKRjsUhQR/wg3P92HffF5OIrDf3+7oxo7919LilxhSiqXr31LLADVXpp8O5Mei/teXvqWw/UBnUSta+UlgbuilYRwdf7X33j2yGgq48jgTfHZ3buIJ83h9vi16W7mLEOYmItbnuWPEsn8sypY5Ys0cBt79oPKrqruZFuULobajR9i1wQBtmf/xKiu3IqHulWuf59IHTLX00V2LRR3IrRUY4FPirMch5WMlT9mM2EjXtW4tdXMG3qUxPXykhKux8ovW3vgm5+ZB/p1GQVspPfsfr8dTH8nL3lBb9yGxC+XBLMy9vfDTVf8h5UstQ4k8wgoNJTeUlOCrbgn+MPGQOAlWfCRRP0NzywFY43cZYLuDSuXiq10S3e+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(376002)(346002)(15650500001)(8676002)(26005)(5660300002)(36756003)(83380400001)(478600001)(6486002)(16576012)(8936002)(66946007)(2906002)(316002)(4326008)(2616005)(956004)(66556008)(31686004)(38100700001)(54906003)(186003)(52116002)(6916009)(7416002)(44832011)(66476007)(86362001)(31696002)(4744005)(53546011)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Sk44cTNEdHJwWEpMSzhOQlEwM0taRFBVU0FCakprL3hSSkhrN0tyYmFQQXRU?=
 =?utf-8?B?S0h4ZDBzeTIrOVpNTTdXL1BFUmkyVHhVc0lzTDFXQW9zTTNvcjZLeENqSnBF?=
 =?utf-8?B?NkVTd1huOEFwZ29yTG5rcmZncjg3ekwyRjVJbHZQVE8wbyszSVIrS2ViRkht?=
 =?utf-8?B?N1ptQk1rTGVjZncyeHFNRG9icGQveThja3Vwdmt2WmRCWitLNWRneHVpeDBM?=
 =?utf-8?B?QUU1MXBJS1cxQVJPZnptTFhXNDlQVnRtT21rWjcwM3pGSTc0VWVHYm1sL3g1?=
 =?utf-8?B?NGZ1OURUdGtSU0Z6WXBiemF1Mjc5ZG1BMkJicGNxbkdvNTZjRkZJMkV0eHZ2?=
 =?utf-8?B?R3JGcVlrTnFuT2tqOWNEZWpCQ1M2c3NHa09xSFJCYVRFZEVDTmtneGtOdTR2?=
 =?utf-8?B?NlZteFZuNittNlhQZDk3L25ncTZFWkFQckdrMWtnR2xnN3o2dEZVVHBKclAx?=
 =?utf-8?B?bUU3TnVTWDM2bTIxRWNNcnlva0pkVzlTcVdxcjJzTGppN0VSd1ZhYmNqWjVY?=
 =?utf-8?B?dU1vQjB6UURqSlg2ZlRaV0lvRnNIaDJkUEpXWlZSUXRKMlJndG9MVTZYSWpm?=
 =?utf-8?B?WTRqeXVxQTh0aFVUcncyL0RVYSsvMmxmc1Y2ckxFbFg3RFRYcHViTUZTbXRy?=
 =?utf-8?B?eDRPRXRoeEV3aFJJcFFnRVB6Znl5RCtZYzZBMkRmTXJ0MjJENnZTR3U0ZmFO?=
 =?utf-8?B?Tkg5NDdJVHFFa0g2Q0pIWlRUSnY3U3piOUFVdXZ1VzZiaEh6dWJyN085bFc5?=
 =?utf-8?B?SW5GRXZqdUNON3JjdEZ3WmtqclNtMWVOalBIZE9saS9tWlJ5bW5aS0cxcGg1?=
 =?utf-8?B?WVdpNnI1MWg5cEhoSUtUQ3dzSmdveEI2MUo5WjU4L2IzbXBNckVxNGk5anpY?=
 =?utf-8?B?U0p1UWlpUkVZTC9tUUdiSzQ4QjB6UlpHa290RzRSWWVSRDcwc1dFdmYyUHpP?=
 =?utf-8?B?dzQrS1VvcUJ5eUhDbWxWeXA5aXlQOUpadnB1ZG5hRFlUUDV1UFU0ME9HbEY2?=
 =?utf-8?B?OWNybkg2Uit2UFFjWmdIQkFTRnU1c29ad0FWZkRZQzdyMjJpN0l1WTU1SEZv?=
 =?utf-8?B?WjQzRmNSOGszWFluQWlqUTRXZTExcXJFTG5DTjUyOVpMcnZsSGZuTElDUUl2?=
 =?utf-8?B?VldvUmdIZjFVaUQzNFpYUFVmZVRVUFQ4UDVDZEFZS01Qa0V6SlhXUEs3M0lr?=
 =?utf-8?B?cFVxb0ExVUQzRzV2NDdQcEVjdjFVQXptRzdDSUJ5MTIvUmxyZFBhdkxPcGdk?=
 =?utf-8?B?QnZGTkRiN2R4OEZMZEVRN1pVNWw1QmhLeE05cGM4YzdWTi9FdThMMlRsNDR4?=
 =?utf-8?B?TWdOelZoa29aendrb2V2UEZhM29yU3lwRkJqZ3dwd0JpcDBXQm9nd1dERFZF?=
 =?utf-8?B?Q05UaWlUTDdiOC8zSHcxbFVEQjNqZG44ZFdIV1h0Um1id2ZpMDNtMElxU2hI?=
 =?utf-8?B?VFZKajFxL2JJeWgxOTVicGRKN0V2SUZ6NHJtQjhJNlBnNzVua0JPd05QbjhU?=
 =?utf-8?B?S3owOVNocno0UUlVY0NkMkZQcFhWdWdwUVZGWWxpVy9tblVlK0VvVld6emY3?=
 =?utf-8?B?WTRSS3dHc1JTTytUL3FyYzZmQjFQdmpiYU1OSnRUZzkzcHBTY1Y5UUZZd0w4?=
 =?utf-8?B?WTQwRnpUU2JLVkhCemVHZ01NSVlRVFRPSndkak5POHhJUjd3TGZ3Y013bGZx?=
 =?utf-8?B?dG5sQWJwQ2NVRkMzdkR3cmRycjVhdE1ueXlKTStRNmgreEsxOE9uVHJCR00v?=
 =?utf-8?Q?YUAas63cKKmTcKG4NovxdrEYevD/462c4WMfG5v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b9a950-c1b6-4d6a-71cf-08d8f23220bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2021 21:40:38.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx9T65UMFaImCRoL42dtmE3nw9QFay2UZIeFAzCRf7RInERqYsYMayOgv2XcTCh3psYWe3vQj/xC07aTuh252Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=995 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103280164
X-Proofpoint-GUID: _M6mE_AAlSwKVxqev46W9yh07f6b2X87
X-Proofpoint-ORIG-GUID: _M6mE_AAlSwKVxqev46W9yh07f6b2X87
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103280164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 11:54 PM, Muchun Song wrote:
> On Thu, Mar 25, 2021 at 8:29 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> With the introduction of remove_hugetlb_page(), there is no need for
>> update_and_free_page to hold the hugetlb lock.  Change all callers to
>> drop the lock before calling.
>>
>> With additional code modifications, this will allow loops which decrease
>> the huge page pool to drop the hugetlb_lock with each page to reduce
>> long hold times.
>>
>> The ugly unlock/lock cycle in free_pool_huge_page will be removed in
>> a subsequent patch which restructures free_pool_huge_page.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Some nits below.

Thanks Muchun,

I agree with all your suggestions below, and will include modifications
in the next version.
-- 
Mike Kravetz
