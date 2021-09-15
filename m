Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534FC40CF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhIOWkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:40:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27892 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbhIOWkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:40:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FLYLLP022288;
        Wed, 15 Sep 2021 22:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WUAXmnmizt8rLL5jKJ4GHzwiUJ3FQBzhRerJWU+/aGc=;
 b=IXwwyV/rxwtVQbX/JrWwBbbzHW0u0v+Lmkpg/3mj9GgmSpxmon7lA7DkKDv521VFzcoj
 XjCKXCX4I3romoQPARHd8qRx0pZ6HcQ+LTBmrM8W+NY6jP0TjfvQsqoO6NuS4WVw6SAo
 FuA4IEPTvVF4Orykgg8P0vxFNVoipgFnBxiU+l986lp9/DR8xCnQFZ2AnjzG8NgCx+Rp
 uTPjh52kW5fvb7K6XHsTgNEGr73n3TelX3Hy5/OGZP5Vqn/USnJX4pDhMNFZtAJo6Fje
 7wf/cNT6Y/wqBROprtpmK9xnAKoTNPlVtIRsGkVieRaVYt89G/PxfsytWRG+0IE0uO84 4A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WUAXmnmizt8rLL5jKJ4GHzwiUJ3FQBzhRerJWU+/aGc=;
 b=qp9dIF4yvCaXesXZQjEba4ERrqX8F5jYjicHfSNiYTob/Q2PZXvZ6KNfrg2jk0PWd7ch
 3i9LcstvQSuXQ9vp7/bgy4bzh/JXcF/45Vl4pZKFOCqrEYpidH6Y12xJyC1+nYwyjy6N
 1ZSNcIyTbPdJ3VHRVH1IwRgXCPbSzVWXTATGn3wrrpl+JPaEetA6kwa10x8+ql/9p86U
 QCXBd8uZsJINEcwmSAv84+Je6NNiecoCidxNLmoDx5WOejXwkrwMBZmCV3/nNRAcO56I
 o+MoJQLK4s91hyu6VkdzmCLG2EjclJYHSilAY+bS4RtVw8X3n7T8CfGpAkNLqs6YLO4g OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8tekys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 22:38:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FMVDJH102293;
        Wed, 15 Sep 2021 22:38:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 3b0hjxbevh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 22:38:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBbELlkB8UQ5Kgobz5RmLZJCt5wtpe/IPh+RdMPuUzui+osHunwNT+8pipjFXOmb3qbsIKt2QmZj7LPrZMlZDseHWWcB+GWhZCNDYvY9sW+ErhBa36PiE0RuchC3kbugq9e7PHSc5779z/vYYTKgvaIXpNKOdXL6mSTI4X/vRe8nwR/P7QwG+Wu0uunhUfENNL+dGG/rgK/ALtclO8/6Rdh8+JQSt9Ht5UOF2BUv2uoZnnYVSniDAcYGwMz8ZvuTuxy1qHOexxtyIrkS9lttDwHM64KMHa/xTFbAxk0YkXschr7zFAWfagBYQnIGd5fdBmf8jgqtdFub9CTyO1UlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WUAXmnmizt8rLL5jKJ4GHzwiUJ3FQBzhRerJWU+/aGc=;
 b=dYSTFrBzRJvwMsTrPoEnzBMzU0KpJybibA+JESOpnDI4zHBaf0qMy45Tpe5TeVGWj4h+Zh8DXGvAOHOosXtWcAqPJs8cwjHdcI/qzeOpu/TfgyuXX4NmVIEPsJz8gJ72Go/mn1ChKasQQLXh6eAMX2FC8apOLcHkMftEzCKKWnfXAMD4OEF//pFCKCboYL9PomawlHKamU9VGFhV2USSsz+Mp+mBS70GB2R9K9yon4LKgUBmD80d8URaOUOMMWzZfWRN0FwEWGgUcTHbI6gX9+ATzVFGZQu00wxx6VxgTk0WsexHttMt/X4sg5Z5QTVyKBNEwhQYn9j+G7nX/CsQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUAXmnmizt8rLL5jKJ4GHzwiUJ3FQBzhRerJWU+/aGc=;
 b=bulp9YLVZgdeSu2Ouq+mb8UQKAEtxpKp34U1w3oaDGKCAp29UeyUi0Su3RuW8/nMnIauDybW4Ty/Sa5IY0sCB/7vw/Ww/dfHpSP1z4NF+9dahwTW+dcaXLnw9/F43kf6fTGBTOABHwlsCRY6STaU746KmvfK/fLGb3CjQCusHO0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3352.namprd10.prod.outlook.com (2603:10b6:a03:159::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 22:38:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 22:38:35 +0000
Subject: Re: [PATCH v4] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     zhenguo yao <yaozhenguo1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210909141655.87821-1-yaozhenguo1@gmail.com>
 <20210914205001.7ccc7ef3dd76a9ec551b370e@linux-foundation.org>
 <CA+WzARmsPT46ck17-96cJVWE-=QEK8QobRFnCnEcNxsd42zNTw@mail.gmail.com>
 <c55f0be5-f68d-1a33-a9e4-5890a2887a15@oracle.com>
Message-ID: <cea19799-e516-4983-7e00-11f9542f05f4@oracle.com>
Date:   Wed, 15 Sep 2021 15:38:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <c55f0be5-f68d-1a33-a9e4-5890a2887a15@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17 via Frontend Transport; Wed, 15 Sep 2021 22:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 208bc3bc-a12d-4ebd-0fc7-08d978998d96
X-MS-TrafficTypeDiagnostic: BYAPR10MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR10MB335232267F499FECD552A533E2DB9@BYAPR10MB3352.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF8+z5ZGn3Rf6DL72Z+xSMkkiBXx+gLe218/FtIKJ4N4Q26RuaH0AsN8DUiXWdxnn85IpUPP1MalPGgyYTf8Ncc1UeUDuRHzqy6xz4q3gfQj+bank8Ktq4sQ0X8rxLJgs6m49HTU733ZLWYhEwbd1xbrlzntJ0J/s7pGPidjS98d8i50O8yVLrLyEe/gTNgcpl90wurqG3LGN+orRfy8oagjLtI0T3UFuAISrcPc5TCmpkOIf2MuNwx1FIwDeD7ihsTTCQ0deDeo9xNKLyx3Pn0PrRcMoXXWlEUBPjKjjDj85LKKi7bRZxq46ep/Ezxk+eXCWzyoMVrHLp/IbgxBk2dzJmZOJytO7lsqprz5dEHhw49aHJY/WczssP9RUy2tGWjmwpQBFYfqH+N+9hi622VUpETKU8nmSUveMe2Q7PRgdxtkzNgZXJ4HCH+Rcn60QeTXV3aXc1ALM6fK83W8Bz6A26AOWAJStg+rZkKVvRhHdcG0VSefAHJB/3Udun3FxxEOYoctD24DjP81gtXgH9xj0lb9/PXekAJqbf0xu8vCx8CuYv/np0Q+PV2lCe77s3rcEzvDZtnuGu6DILpoTXRcYk29opzSdkVde0Ze/STjjBU5E8UEfnWY8X11FbIU/Zyzom6SZxA5ancfOGGoeDWBgtO4TJQFHddpNDxm8yYWpRmZxb60Wbr89PEVj5inCpJ6zd5gKsHmR2o8R6j0PR8ufxERzvJ8OhmuNWRo62cGGy5CgsisFSg8acOTeDMwopZvN3vwg5WVPDGBVIV1AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(36756003)(31686004)(38100700002)(956004)(38350700002)(2616005)(31696002)(86362001)(316002)(8676002)(6486002)(16576012)(8936002)(4326008)(54906003)(508600001)(52116002)(110136005)(26005)(186003)(53546011)(5660300002)(66556008)(66476007)(66946007)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNZbWdqTkNISGkwMmZYMmRxT0NiNkpKOGk1KzEwaGw5RUl2NXBHZTBtNlhD?=
 =?utf-8?B?QW5BYUkyWW12OUFQL0dCcFRHOUVDNG5LbUZnaVZPS1ByVE5odklmWE1VNk0w?=
 =?utf-8?B?TEJadk5kTWNVOWhYd1JDZ0YxYXJ4eDcwRFpTY3d6YlVEMjByeFBNaDZRNUVa?=
 =?utf-8?B?NkdRcFlpakMyc29hSFNtdkdBRjc1cVRweWszRldZZjZBb2wxN0dwU3RyQkdD?=
 =?utf-8?B?V0szYmpjTHB4SXJlbmpLbnNzdEZCVjVKUllMMjZuRkNyakoyTW51dERqd2NI?=
 =?utf-8?B?dG5vcUNqbFBUVkgwYXBRYVNZY3lsc1F4N2V0MXBxUENodk11RUVrYzVvSVFy?=
 =?utf-8?B?OUZYYXZnYnVjeUlFV0ZQZm5mRm5Lc205dk13SmdldEVHajQrdTQyM2FwUkpZ?=
 =?utf-8?B?K2M1OGwzWXhTZ29CUEVIVFBnZUJVaVZGcm5vV1ZmK1JmOXNZNFd6UWtlQ0JZ?=
 =?utf-8?B?eTk0YjE1ZnBUOGFFRHpLbVYyOUp6T09CaEgvZ3RCbkVpZHQ3MWhBZmxTS2Vm?=
 =?utf-8?B?dU9OaTk3b1A1NWd1U2JPZnpzMSsyMzBvd0owWGlaKzRsVXRDRTJ0TEh2T1U3?=
 =?utf-8?B?VDhNejJkdzRrTXdPcmlmditlQTVxNWRjNytGaXdCUWdneW95TWFCaFh5Smsw?=
 =?utf-8?B?YlB1UVVCRE1EMWpNNm9aMHptcis5OUJPZ1AzVEI4cjFLekdoNmNmSGluSkkx?=
 =?utf-8?B?Wm9hZVVnSXJ5NGJSMWx6TVpqTmVCMHFqcFBKWFNhRjJMdmtUK0JSanZGODVu?=
 =?utf-8?B?NzB2M01UQjdTWVdTWFdFdmF4dXJRbUs0L2tvTEVuVmNNczVONUtzU1RYVU5h?=
 =?utf-8?B?aDBzNFRrdHd3a2JJZHRtUSs5MnpBdVRMMTk1b2FrWGUrZ2ErOEhaL1JXY1Rj?=
 =?utf-8?B?N0hUem5CUDBBZ2dUTWhCM21CU3NraUEzU2dIUWlIbzdtN1lLNHJ5Qjhpcy9N?=
 =?utf-8?B?b3FJd3NubXlXbTRoVDc1VFZvK0lVRTJTUmtZeXFNYzdYUDVjSlZ4dDJUNmp4?=
 =?utf-8?B?NWJkK0tlWGdjdTYwQlY1dUFBTzU2dC9ocjlMcnpTTEdGeFRSVkhkVzFiSVRu?=
 =?utf-8?B?UHhZRmcxbXljbVZTOGduVFFnZ205N0hPa0lZVFBEU0lBa0tSZUlNTEVjME5C?=
 =?utf-8?B?R0xHazBZcUdqUnV0QTgxcG80cHFIYk5lWlA5LzRLYWRJaklKU0hCYk8vOXVt?=
 =?utf-8?B?ZGdhUzBnblAycDlYd0VNVHZFbktrT2Z4NWJ4S2xNRTIwUUJnRjFyYlh1dStI?=
 =?utf-8?B?TXdJc1Q5QTVJZGxIZC9GWlFxLytDb3UrMDhsY2VoR1JhU3pLSWRJcmpocjhC?=
 =?utf-8?B?VENWS3VRZExBQmNTSzM1Z3MvS0tZdGVVbzNEWVdsU1hiU0N5and6eWE3bzJU?=
 =?utf-8?B?N1MrRCtVU2xWYTd6WUh2Nmd1dDhScEUrQ2VxT2ZWQ3ZOZWhCeEhROVppZmht?=
 =?utf-8?B?YVJDL24vbmQwTjIvN1B6RXhMVVFHcmRoOWE5cVhIckZ0cDV2RU1OTk83aEM4?=
 =?utf-8?B?NyswdU1VOFRNWGQxL29pWFZhZWxhdGdyUHhqbTdsTTFpV0VMN21jUEpHeVpQ?=
 =?utf-8?B?b0ZYRHBqVlB1WVNGdVpBa1NhZlAxSk83S3BMb21wS1dHZk9kTVdORVYzN2Z2?=
 =?utf-8?B?OWpac1JEbW4ySHBFV2dOSldDNDlSUndyR1Q1Y2huM3dtUUREMnY1eEdSWVZa?=
 =?utf-8?B?MFpiYlZ0WWJVSC9XeU5pcjJQM2x3WmJ2cTZVelJ4KzE0WmV3RlFpbm1KbXlk?=
 =?utf-8?Q?y5rJcBm6ToG1pFxH/76j6xr+21yNst2cpzNkqe6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208bc3bc-a12d-4ebd-0fc7-08d978998d96
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 22:38:35.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xcanp1jXCnHERwII3NG5St0ApF71gcj7huN91/sKCbgaBMqOy9H324t1BAiD8cMxj9ge7+oLauJiVcgpIZgn+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3352
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150128
X-Proofpoint-GUID: BNAjAEOvg4YUanf95RTi76tJAmXNuDMl
X-Proofpoint-ORIG-GUID: BNAjAEOvg4YUanf95RTi76tJAmXNuDMl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 3:03 PM, Mike Kravetz wrote:
> On 9/15/21 6:11 AM, zhenguo yao wrote:
>> Andrew Morton <akpm@linux-foundation.org> 于2021年9月15日周三 上午11:50写道：
>>>
>>> On Thu,  9 Sep 2021 22:16:55 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:
>>>
>>>> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>>>> +{
>>>> +     unsigned long i;
>>>> +     char buf[32];
>>>> +
>>>> +     for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
>>>> +             if (hstate_is_gigantic(h)) {
>>>> +                     struct huge_bootmem_page *m;
>>>> +                     void *addr;
>>>> +
>>>> +                     addr = memblock_alloc_try_nid_raw(
>>>> +                                     huge_page_size(h), huge_page_size(h),
>>>> +                                     0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>>>> +                     if (!addr)
>>>> +                             break;
>>>> +                     m = addr;
>>>> +                     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>>>
>>> We try very hard to avoid adding BUG calls.  Is there any way in which
>>> this code can emit a WARNing then permit the kernel to keep operating?
>>>
>> Maybe we can rewrite it as below:
>>                         if (WARN(!IS_ALIGNED(virt_to_phys(m),
>> huge_page_size(h)),
>>                                 "HugeTLB: page addr:%p is not aligned\n", m))
>>                                 break;
>> @Mike,  Do you think it's OK?
> 
> Sorry, I have not yet reviewed the latest version of this patch.
> Quick thought on this question.
> 
> The required alignment passed to memblock_alloc_try_nid_raw() is
> huge_page_size(h).  Therefore, we know the virtual address m is
> huge_page_size(h) aligned.  The BUG is just checking to make sure
> the physical address associated with the virtual address is aligned
> the same.  I really do not see how this could not be the case.
> In fact, the memblock allocator finds a physical address with the
> required alignment and then returns phys_to_virt(alloc).
> Someone please correct me if I am wrong.  Otherwise, we can drop
> the BUG.
> Adding Mike Rapport on Cc:
> 
> This allocation code and the associated BUG was copied from
> __alloc_bootmem_huge_page().  The BUG was added 12 years ago before
> the memblock allocator existed and we were using the bootmem allocator.
> If there is no need for a BUG in hugetlb_hstate_alloc_pages_onenode,
> there is no need for one in __alloc_bootmem_huge_page.

One additional thought.

Architectures can provide their own version of alloc_bootmem_huge_page.
powerpc is the only architecture doing so today.  If an architecture
does provide their own version of alloc_bootmem_huge_page, I do not
think we should/can use hugetlb_hstate_alloc_pages_onenode to allocate
node specific gigantic huge pages.

I think we need to disable this feature for such architectures,
-OR-
provide some method to do architecture specific node allocations of
gigantic pages.
-- 
Mike Kravetz
