Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91CA321F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhBVSrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:47:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34908 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhBVSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:44:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MIQA1O160898;
        Mon, 22 Feb 2021 18:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CVdGajCLMI2+3gzgx3h0ZAYJOFhSDO7t9stTQZiF0Gk=;
 b=get+Zf53yxs71cgYXuJ6iA771hbLoN+Rm2a6JCpFLh/1qhPxW4CpwN/LxsDXR9kv+am3
 u6ryB2KMedGV+etLnyWr+OXBopiEVOMV6i+qjCGFnoNRaTF/I0nIDEJgV21U+qwiJMrb
 oMDfoFFM/T9ucMrD3t8luJBq/qf88a/8QCew3OXqy/0hXoaA1kFX1WiwZFcBaO38wBs2
 tv3pnYrE6+5558cAgs5zzuiRaxxhpCBRqK9lGAwoaLc5DXr2v1Hm1aFJeqG6uFYfH466
 nYvB7P0cqL5WpPOLogNHNQy5b1h22ZKrxUXUrGwQkI+4fW3SQ3KIha6xofN7EQJc19Ni YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36tsuqvr1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 18:43:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MIeKxO186844;
        Mon, 22 Feb 2021 18:43:06 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        by aserp3030.oracle.com with ESMTP id 36v9m3me0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 18:43:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5+5ngeAlg0dix41mo+nBBTCCSVd+gOut8aEe/N42B/h0e0cLddimiyGUxxUo9gYkqHCA98drRJkUUMZIAJVWj1YxjvQvslAZzW7awWWaWnaqcAo0ReTXtU5SWnxNBFrc2q5QXP64wqOsZOQau7X/ENTmOWWaH9I+bykv9UD56nXC6vUs7LNtjcb9H6+gIUvcfj2R4nAO5GFO8R0A1c855xd/Nzw6YPxVQr6WbJmibc22kxXk1fgItbr40Jqx2Vpjjyj6cVGY1/ojxVJbT++TIyRSnAT8K7OhyzJbONYyLhUoPcBUYK9l5Vjb5+o1mDPYiR58I01/KV3vbCS1EppvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVdGajCLMI2+3gzgx3h0ZAYJOFhSDO7t9stTQZiF0Gk=;
 b=EXX6j25YB+gZGxpj9udKswbxnVDbhNXgpsOEyIbE1TQN/vM9qgNBy52Mi+8PILd3L4ft8MFSCVUmi+YMW8JT5/vddBemphBULOHDbHmyGix4eNkUJWP0XeglySLBsgP7hUY7QHjC8K+qnNCyswPxrQMZwn0oAR2frT7AHCl560L7+SUrA9VsoV7vVO+Bc7/w++tHkmeDl+YJ7hNmNgNDxMW+j4WVp0BqzU2yP/gmCCiuCejvm/5vmvAbug4jOj9PrGpW28ifoJNFYeJ63bvTxYNzogD6SGSNi5f7znFKBUariRrYTgF9Zbl4HeeAfdw1Yju4xObJT7ddYzPT4lLtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVdGajCLMI2+3gzgx3h0ZAYJOFhSDO7t9stTQZiF0Gk=;
 b=cPpvm2vj/Z8p53dw/zfHWOHwor7eHjxCway0r2NIXOJJrDZnnAnRULfFT9GOm84rezFT5Ca45rAFy28DW8RW0rDTqojqv6Q4H5+CxXx5Q/8pIp+PJbhOSZdX8i/2ypTqEvewBtulwhKHq+IFJYb6Q4GKdwNseVFd0ciuLC0cPbQ=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DS7PR10MB5343.namprd10.prod.outlook.com (2603:10b6:5:3b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 18:43:03 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 18:43:03 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
 <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
 <CAAeHK+y_SmP5yAeSM3Cp6V3WH9uj4737hDuVGA7U=xA42ek3Lw@mail.gmail.com>
 <c7166cae-bf89-8bdd-5849-72b5949fc6cc@oracle.com>
 <797fae72-e3ea-c0b0-036a-9283fa7f2317@oracle.com>
 <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
 <bd7510b5-d325-b516-81a8-fbdc81a27138@oracle.com>
 <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <cb8564e8-3535-826b-2d42-b273a0d793fb@oracle.com>
Date:   Mon, 22 Feb 2021 13:42:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: SJ0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::7) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.20.187.119) by SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 18:43:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93b99620-8681-44fb-9060-08d8d761afde
X-MS-TrafficTypeDiagnostic: DS7PR10MB5343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DS7PR10MB534373C63E01D79B00D2AF47E6819@DS7PR10MB5343.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZzdN2NPj2jy8gd1pNRN/dDrFaQx9S613Lhp8gZfqcCQuI/3p3KqStnq3hoK+MaTBBhBTEATNwPRrFgcp9mOgrnbioqpoRqn9dfuo/y9y7R7MiVKEh4eituyW2swBC7IKO8VRhY1Dov1VLB6gqwkQafFx4Tk+b4pTrz6lftcIIghFu9qAvBvHdwZCaZfYzl2CSDtXx71NBxqcuwDOqnM+SmQFsqmEcq+2Uw1uKLyETCPCQbZ/3Z5FHda9hmK7eskfbZeO1Rm5B+gImy4o7o7H3AqFQa4CppDfmwMqlOek+CNIavkO8bmjwnXn4XTghGeqcL/TEj87/2nRcZGlgJHt9U0Kn/bQkMatSDN+OCTSsNHO6Uqn3ktVLJ8bRnaAkOX/9YzFQ7Id/dAwnB5zsYUbYaoZ6lTc33LlVi+BhiElC0QQsc7DL7F+J2fx5mqyCKnXA3Njp39g/QqK3g6DdlmVYckdZW0ZpPMCJgmRt2nzOs6TGNE8hck7qu6eXSa4WYUIOCJSHWIYeDLMhuaaA5XUud88Vv4uuc8u/iJaR2oxhW0JT4fyOqkbxc81Cy00ZzGSZVTqHqrIJP8PfVSfFL5l9+s7A7xnBnDCUKq2DDR5je2M/ctDLufz2GVfllTzfo4AUI8TVZ2M+H9aBkyoCes4uUxYMw2Pn63uuF0ouMTBjaV7usJ/wEK/GfzWkaDokWbm1BZGYjd0G6UnHHyHmBYhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(39860400002)(376002)(30864003)(4326008)(2906002)(7416002)(36756003)(86362001)(83380400001)(66556008)(8936002)(45080400002)(8676002)(6666004)(31686004)(2616005)(44832011)(956004)(966005)(6486002)(110136005)(316002)(54906003)(31696002)(16576012)(478600001)(16526019)(26005)(5660300002)(186003)(36916002)(66946007)(53546011)(66476007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHBCME1SR2RYeWVvQXg4VHRWajZqYTFvOWw3RDF1eGVrT2ZJYTNQbFMwZnkx?=
 =?utf-8?B?NzN6QzVmbUJJTGpPcnJwdllQc3JWdzhnRHh3TkZxQnJuVUJVNHVQdVBiS2pX?=
 =?utf-8?B?WmJjbys3L0VqZlJqVWZVSUFSOE1SYk53akhMK0pNSjA4R3VHaUN0bmhPQnhn?=
 =?utf-8?B?Qk5ZYkFHZkFxdTV6bTJaQWQyTDhzKzRpdTVSNERkSFozc29TSVNpTVJHS0ND?=
 =?utf-8?B?Y2FTaDNkSk1vMVVGTVRCd0QwZDhCcnEzUS9tTm1xWEJTVzJ6Ry91MXN0K0px?=
 =?utf-8?B?R3lXVi93R3psd2dtNEtTTHNQK3JKRnZFNmdEeGRycWZTWkQrc0xEZEhFVUxo?=
 =?utf-8?B?SFNXMlVRT3Y4S1JoclNSWE0zR2I4U3JFTXV2R1hFUlhoSi8zM3hiQTRzUmty?=
 =?utf-8?B?YkVZNXBxdFlldzJERW9JTmVqeGVETlFQdWRxay9WQjNjUGpQVmFqZm5aM1Vh?=
 =?utf-8?B?ODhvTXdTUFhXcFIvYlVKVnNkTFJNL0NlTllLVUJRTTNLT0NnaU5HOXZXc245?=
 =?utf-8?B?UWZJcVVBcTJFS0cxc0dndnpFVk1ERURPSXdBeVI3QjZianAxeHl5UlhmSzVZ?=
 =?utf-8?B?QWJoeWREV0xOdnFHYkRLOVV3bkpKeFhoMEtwS05xNVNCMkxrdnNKbUpJblpX?=
 =?utf-8?B?Rk5adWl0WTlXK29sQXZhNDJaU3A0OEhMVTlWRGxORFp5dzBabVFRK3Q1b0tF?=
 =?utf-8?B?Znc2RytmeFNYbVVQNjlXbEJCUk1hUHpRK0JFblJBZWV6RkVNS1gvQkp2NGpL?=
 =?utf-8?B?a2JxZW9HaHBNd3VVU1hqcGx5eFF0K0JtNEFWSzJIMlp2Tm4ySXI0aTVEUjN1?=
 =?utf-8?B?WGdKOThMTkZCU2dnREtyR1Z3endiNUxjNTlRU3MrU1hvRTBYelpxclp4cHdY?=
 =?utf-8?B?RkNDd0dGamlZOG1NM0cyZ2IxeG1hMk5JRTlpdkdOTkVHV0lmSXBPZ0RxZElk?=
 =?utf-8?B?UFgwM2Nxc0ZPcjB6a1U3bk5yQmVnTVdvR3VuUHdaZG1Vb1F1bjVTbmRnRnQ0?=
 =?utf-8?B?N2lxSnZUaWJGYzFUNUFLdUt0YlAwQ3BtNUM1Uk5lRTNTOTdoZnZjK3JxVndO?=
 =?utf-8?B?ZlpjMUNWakw4bFU0RVc1OVNuUUhIWURPelg5S3RNTXcwdU9QZVVPcXpoSnVD?=
 =?utf-8?B?TGpPdXRTVTNLMlJkdDBEVDVhMW4rV2RkSFI5T2UwNEhPcFUyRnovTHk5QzhE?=
 =?utf-8?B?R3B4dXFCRi8xQkgwUDlhMjRXSFUwdTFnNTFqSG16cG5DNWl4STR6V1VyT1dQ?=
 =?utf-8?B?MnQ4OG5kY282VVhXL2pPTFRlRTRiZ2FneUFLUFJjd0Vmc3A2QjNyUTdWQ0Fj?=
 =?utf-8?B?aytQeHl2aG9HQUZlbkNXVnpqN0tDRHFYUGhUOE8xWnhtYjJ4VS9OaWtJeDUz?=
 =?utf-8?B?cDJPUFZkTUNickN4ZGFHZm13T1AyQ25kTXpXczJKcCtLMTBtK3BaVWRZNHNz?=
 =?utf-8?B?RHAxWHlIaEpyT0tVZFQ5WWx1MjdIQUNJanVlVlhvVWhkMlh2MVVkNVZZVTNt?=
 =?utf-8?B?alVrd1pyR2IwYncvSitkVzluTWRMWkxUYXAzQy9HeGdKc2Y3aVdFVXNHL3VE?=
 =?utf-8?B?VkdIZ29ZOXRGdStkeFNsdm9PQm0xSmFCOENPbWZhU1liTG1KcU9BbksyNmYx?=
 =?utf-8?B?T0VkZ1VOaEU4UzVJNHRkYTU1NGkzYlNqSGhYYjVOUFRWR2hwR0cyTTl6eVcx?=
 =?utf-8?B?Y1VHeG50VXlLbVJ2aWlrT2NPdnVodnEzZXVWQzRNUXowQlllbkZEUkJxMDZ5?=
 =?utf-8?Q?0snblp1Vc/hmaYRfjtlzMih+6sgE2H/s6vcAPW7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b99620-8681-44fb-9060-08d8d761afde
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 18:43:03.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kiz8YGUgSwVJHH33Q6ocaHHdgfRgg8blRiRneDrwooas/CPMQ6NcGg1g+85R9//ImESBoTcfASWXEcA39vE+Ahr36c2k5qI43M6GNF0rmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5343
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220164
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/2021 11:13 AM, David Hildenbrand wrote:
> On 22.02.21 16:13, George Kennedy wrote:
>>
>>
>> On 2/22/2021 4:52 AM, David Hildenbrand wrote:
>>> On 20.02.21 00:04, George Kennedy wrote:
>>>>
>>>>
>>>> On 2/19/2021 11:45 AM, George Kennedy wrote:
>>>>>
>>>>>
>>>>> On 2/18/2021 7:09 PM, Andrey Konovalov wrote:
>>>>>> On Fri, Feb 19, 2021 at 1:06 AM George Kennedy
>>>>>> <george.kennedy@oracle.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/18/2021 3:55 AM, David Hildenbrand wrote:
>>>>>>>> On 17.02.21 21:56, Andrey Konovalov wrote:
>>>>>>>>> During boot, all non-reserved memblock memory is exposed to the
>>>>>>>>> buddy
>>>>>>>>> allocator. Poisoning all that memory with KASAN lengthens boot
>>>>>>>>> time,
>>>>>>>>> especially on systems with large amount of RAM. This patch makes
>>>>>>>>> page_alloc to not call kasan_free_pages() on all new memory.
>>>>>>>>>
>>>>>>>>> __free_pages_core() is used when exposing fresh memory during
>>>>>>>>> system
>>>>>>>>> boot and when onlining memory during hotplug. This patch adds 
>>>>>>>>> a new
>>>>>>>>> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok()
>>>>>>>>> through
>>>>>>>>> free_pages_prepare() from __free_pages_core().
>>>>>>>>>
>>>>>>>>> This has little impact on KASAN memory tracking.
>>>>>>>>>
>>>>>>>>> Assuming that there are no references to newly exposed pages
>>>>>>>>> before they
>>>>>>>>> are ever allocated, there won't be any intended (but buggy)
>>>>>>>>> accesses to
>>>>>>>>> that memory that KASAN would normally detect.
>>>>>>>>>
>>>>>>>>> However, with this patch, KASAN stops detecting wild and large
>>>>>>>>> out-of-bounds accesses that happen to land on a fresh memory page
>>>>>>>>> that
>>>>>>>>> was never allocated. This is taken as an acceptable trade-off.
>>>>>>>>>
>>>>>>>>> All memory allocated normally when the boot is over keeps getting
>>>>>>>>> poisoned as usual.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>>>>>>>> Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
>>>>>>>> Not sure this is the right thing to do, see
>>>>>>>>
>>>>>>>> https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com 
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Reversing the order in which memory gets allocated + used during
>>>>>>>> boot
>>>>>>>> (in a patch by me) might have revealed an invalid memory access
>>>>>>>> during
>>>>>>>> boot.
>>>>>>>>
>>>>>>>> I suspect that that issue would no longer get detected with your
>>>>>>>> patch, as the invalid memory access would simply not get detected.
>>>>>>>> Now, I cannot prove that :)
>>>>>>> Since David's patch we're having trouble with the iBFT ACPI table,
>>>>>>> which
>>>>>>> is mapped in via kmap() - see acpi_map() in "drivers/acpi/osl.c".
>>>>>>> KASAN
>>>>>>> detects that it is being used after free when ibft_init() accesses
>>>>>>> the
>>>>>>> iBFT table, but as of yet we can't find where it get's freed (we've
>>>>>>> instrumented calls to kunmap()).
>>>>>> Maybe it doesn't get freed, but what you see is a wild or a large
>>>>>> out-of-bounds access. Since KASAN marks all memory as freed 
>>>>>> during the
>>>>>> memblock->page_alloc transition, such bugs can manifest as
>>>>>> use-after-frees.
>>>>>
>>>>> It gets freed and re-used. By the time the iBFT table is accessed by
>>>>> ibft_init() the page has been over-written.
>>>>>
>>>>> Setting page flags like the following before the call to kmap()
>>>>> prevents the iBFT table page from being freed:
>>>>
>>>> Cleaned up version:
>>>>
>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>>> index 0418feb..8f0a8e7 100644
>>>> --- a/drivers/acpi/osl.c
>>>> +++ b/drivers/acpi/osl.c
>>>> @@ -287,9 +287,12 @@ static void __iomem 
>>>> *acpi_map(acpi_physical_address
>>>> pg_off, unsigned long pg_sz)
>>>>
>>>>         pfn = pg_off >> PAGE_SHIFT;
>>>>         if (should_use_kmap(pfn)) {
>>>> +        struct page *page = pfn_to_page(pfn);
>>>> +
>>>>             if (pg_sz > PAGE_SIZE)
>>>>                 return NULL;
>>>> -        return (void __iomem __force *)kmap(pfn_to_page(pfn));
>>>> +        SetPageReserved(page);
>>>> +        return (void __iomem __force *)kmap(page);
>>>>         } else
>>>>             return acpi_os_ioremap(pg_off, pg_sz);
>>>>     }
>>>> @@ -299,9 +302,12 @@ static void acpi_unmap(acpi_physical_address
>>>> pg_off, void __iomem *vaddr)
>>>>         unsigned long pfn;
>>>>
>>>>         pfn = pg_off >> PAGE_SHIFT;
>>>> -    if (should_use_kmap(pfn))
>>>> -        kunmap(pfn_to_page(pfn));
>>>> -    else
>>>> +    if (should_use_kmap(pfn)) {
>>>> +        struct page *page = pfn_to_page(pfn);
>>>> +
>>>> +        ClearPageReserved(page);
>>>> +        kunmap(page);
>>>> +    } else
>>>>             iounmap(vaddr);
>>>>     }
>>>>
>>>> David, the above works, but wondering why it is now necessary. 
>>>> kunmap()
>>>> is not hit. What other ways could a page mapped via kmap() be 
>>>> unmapped?
>>>>
>>>
>>> Let me look into the code ... I have little experience with ACPI
>>> details, so bear with me.
>>>
>>> I assume that acpi_map()/acpi_unmap() map some firmware blob that is
>>> provided via firmware/bios/... to us.
>>>
>>> should_use_kmap() tells us whether
>>> a) we have a "struct page" and should kmap() that one
>>> b) we don't have a "struct page" and should ioremap.
>>>
>>> As it is a blob, the firmware should always reserve that memory region
>>> via memblock (e.g., memblock_reserve()), such that we either
>>> 1) don't create a memmap ("struct page") at all (-> case b) )
>>> 2) if we have to create e memmap, we mark the page PG_reserved and
>>>     *never* expose it to the buddy (-> case a) )
>>>
>>>
>>> Are you telling me that in this case we might have a memmap for the HW
>>> blob that is *not* PG_reserved? In that case it most probably got
>>> exposed to the buddy where it can happily get allocated/freed.
>>>
>>> The latent BUG would be that that blob gets exposed to the system like
>>> ordinary RAM, and not reserved via memblock early during boot.
>>> Assuming that blob has a low physical address, with my patch it will
>>> get allocated/used a lot earlier - which would mean we trigger this
>>> latent BUG now more easily.
>>>
>>> There have been similar latent BUGs on ARM boards that my patch
>>> discovered where special RAM regions did not get marked as reserved
>>> via the device tree properly.
>>>
>>> Now, this is just a wild guess :) Can you dump the page when mapping
>>> (before PageReserved()) and when unmapping, to see what the state of
>>> that memmap is?
>>
>> Thank you David for the explanation and your help on this,
>>
>> dump_page() before PageReserved and before kmap() in the above patch:
>>
>> [    1.116480] ACPI: Core revision 20201113
>> [    1.117628] XXX acpi_map: about to call kmap()...
>> [    1.118561] page:ffffea0002f914c0 refcount:0 mapcount:0
>> mapping:0000000000000000 index:0x0 pfn:0xbe453
>> [    1.120381] flags: 0xfffffc0000000()
>> [    1.121116] raw: 000fffffc0000000 ffffea0002f914c8 ffffea0002f914c8
>> 0000000000000000
>> [    1.122638] raw: 0000000000000000 0000000000000000 00000000ffffffff
>> 0000000000000000
>> [    1.124146] page dumped because: acpi_map pre SetPageReserved
>>
>> I also added dump_page() before unmapping, but it is not hit. The
>> following for the same pfn now shows up I believe as a result of setting
>> PageReserved:
>>
>> [   28.098208] BUG:Bad page state in process mo dprobe pfn:be453
>> [   28.098394] page:ffffea0002f914c0 refcount:0 mapcount:0
>> mapping:0000000000000000 index:0x1 pfn:0xbe453
>> [   28.098394] flags: 0xfffffc0001000(reserved)
>> [   28.098394] raw: 000fffffc0001000 dead000000000100 dead000000000122
>> 0000000000000000
>> [   28.098394] raw: 0000000000000001 0000000000000000 00000000ffffffff
>> 0000000000000000
>> [   28.098394] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
>> [   28.098394] page_owner info is not present (never set?)
>> [   28.098394] Modules linked in:
>> [   28.098394] CPU: 2 PID: 204 Comm: modprobe Not tainted 
>> 5.11.0-3dbd5e3 #66
>> [   28.098394] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 0.0.0 02/06/2015
>> [   28.098394] Call Trace:
>> [   28.098394]  dump_stack+0xdb/0x120
>> [   28.098394]  bad_page.cold.108+0xc6/0xcb
>> [   28.098394]  check_new_page_bad+0x47/0xa0
>> [   28.098394]  get_page_from_freelist+0x30cd/0x5730
>> [   28.098394]  ? __isolate_free_page+0x4f0/0x4f0
>> [   28.098394]  ? init_object+0x7e/0x90
>> [   28.098394]  __alloc_pages_nodemask+0x2d8/0x650
>> [   28.098394]  ? write_comp_data+0x2f/0x90
>> [   28.098394]  ? __alloc_pages_slowpath.constprop.103+0x2110/0x2110
>> [   28.098394]  ? __sanitizer_cov_trace_pc+0x21/0x50
>> [   28.098394]  alloc_pages_vma+0xe2/0x560
>> [   28.098394]  do_fault+0x194/0x12c0
>> [   28.098394]  ? write_comp_data+0x2f/0x90
>> [   28.098394]  __handle_mm_fault+0x1650/0x26c0
>> [   28.098394]  ? copy_page_range+0x1350/0x1350
>> [   28.098394]  ? write_comp_data+0x2f/0x90
>> [   28.098394]  ? write_comp_data+0x2f/0x90
>> [   28.098394]  handle_mm_fault+0x1f9/0x810
>> [   28.098394]  ? write_comp_data+0x2f/0x90
>> [   28.098394]  do_user_addr_fault+0x6f7/0xca0
>> [   28.098394]  exc_page_fault+0xaf/0x1a0
>> [   28.098394]  asm_exc_page_fault+0x1e/0x30
>> [   28.098394] RIP: 0010:__clear_user+0x30/0x60
>
> I think the PAGE_FLAGS_CHECK_AT_PREP check in this instance means that 
> someone is trying to allocate that page with the PG_reserved bit set. 
> This means that the page actually was exposed to the buddy.
>
> However, when you SetPageReserved(), I don't think that PG_buddy is 
> set and the refcount is 0. That could indicate that the page is on the 
> buddy PCP list. Could be that it is getting reused a couple of times.
>
> The PFN 0xbe453 looks a little strange, though. Do we expect ACPI 
> tables close to 3 GiB ? No idea. Could it be that you are trying to 
> map a wrong table? Just a guess.
>
>>
>> What would be  the correct way to reserve the page so that the above
>> would not be hit?
>
> I would have assumed that if this is a binary blob, that someone 
> (which I think would be acpi code) reserved via memblock_reserve() 
> early during boot.
>
> E.g., see drivers/acpi/tables.c:acpi_table_upgrade()->memblock_reserve().

acpi_table_upgrade() gets called, but bails out before 
memblock_reserve() is called. Thus, it appears no pages are getting 
reserved.

     503 void __init acpi_table_upgrade(void)
     504 {
     505         void *data;
     506         size_t size;
     507         int sig, no, table_nr = 0, total_offset = 0;
     508         long offset = 0;
     509         struct acpi_table_header *table;
     510         char cpio_path[32] = "kernel/firmware/acpi/";
     511         struct cpio_data file;
     512
     513         if 
(IS_ENABLED(CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD)) {
     514                 data = __initramfs_start;
     515                 size = __initramfs_size;
     516         } else {
     517                 data = (void *)initrd_start;
     518                 size = initrd_end - initrd_start;
     519         }
     520
     521         if (data == NULL || size == 0)
     522                 return;
     523
     524         for (no = 0; no < NR_ACPI_INITRD_TABLES; no++) {
     525                 file = find_cpio_data(cpio_path, data, size, 
&offset);
     526                 if (!file.data)
     527                         break;
...
     563                 all_tables_size += table->length;
     564                 acpi_initrd_files[table_nr].data = file.data;
     565                 acpi_initrd_files[table_nr].size = file.size;
     566                 table_nr++;
     567         }
     568         if (table_nr == 0)
     569                 return;                                 <-- 
bails out here
"drivers/acpi/tables.c"

George

