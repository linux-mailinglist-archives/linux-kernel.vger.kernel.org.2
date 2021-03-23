Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996FC346821
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhCWSwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:52:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34404 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhCWSvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:51:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIkDVG092603;
        Tue, 23 Mar 2021 18:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lq4zvyJUrXEBz/B41vdd6ec01J6/imUhnFui82Hc7Pk=;
 b=gYsmYE325Ywh62xpy/HQzYHoto5X+JIa+b3hruDb12A9dWKn41XO6ikL+R7VlbW4YMO8
 NJgiVX/8YIZKUOmAdJJb9PbMEMJC2Hp9uSYAt3f65h1VJPufs/S0pokKNbK+pN7WW6F+
 QFVuILI1ETJIugMZPJy33lKmxB2sPSyHUPP/dDY7wMbRHoElwYYQGK1RPFymF7Ov8Yww
 r8aG98b9A/6ymVOW7mHpyDTtOqBuo8gIeHzdv4qKhC9NYYW7zxk+cqKSY9ZBIBsKIHf+
 RSbql/xjsPN72WJR9SZCe2kGZdOkoarcA9ygA+MF2aLbSjcDK9A8o8QtRNChefPxlTbX WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbgc8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:51:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIilx9022684;
        Tue, 23 Mar 2021 18:51:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 37dtyxu9kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:51:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7TTdN6dqaSurZ5562Q4tu3hsa/JC7bxTr2LsVkHiwufmUUO/DFwr25vORxYbN8cA17lfCsvJT/MPg+eaX1ZGcS/L03m7Zq6/m9HQNvopcbrODhmpa52woehX8NY+L/E7ZGsDoEtc+llow8TxpI1RGBxSThBABtAYh9H8vadGFjZF7L2PspwYXmQnU8BOuErNazxBDuRcS3DPjmcsnCDgzMe1I6EUVVVgcTsddK+UmTxbx1aYzVCuTDc2ejZHFiB2U6nm/C5VEeiQncG8cH/0Dx0tZwf4UmtEskL9E/YqueCF90J4I7dMiE3mFvMnOpaAyKQNNoJ/+ZanSHRCLk7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq4zvyJUrXEBz/B41vdd6ec01J6/imUhnFui82Hc7Pk=;
 b=dj9N54IXMgcNVkElsUfPqQAgqWktPVFvdnaagxmP/G6zfUw2P3T3gXxx63cAs53gMmQ9fYo9WpLELZPItDuiynG1ViUOLkkMqsYn/SyrhlId+ia/IUMJFKYGqKo358T32PV8ifQ/KTMlInmeQfUItUBBfmqwrbxsQwhrVXzCiLAN0Temjz1KWgfzz6cWR7eCIy7fzOOKUg7/OUlpbqjzkUUm4DPzeZIXKG3UrJ3N19ArRZeuH/cGOpxE1RRJOzdHQy8lS+CE/HM1ydWJk6mFgjYMZNBEd5zs9AGEDdk5NI01z84Nn0K8IvSSdx2nBsdRk7721XIooyiCHg+4GG20Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq4zvyJUrXEBz/B41vdd6ec01J6/imUhnFui82Hc7Pk=;
 b=DBeyxi4VDhX5v+ELhBi1rX8o47jLvJBCQ0DZt5D8RmtF+MZuLfE7isiZ5LtiPA6QXONZZSyChMw22EFnn4EtAOlmdqRkJDxZ+b6Z0P1o4PhGwysNtRgikvkqfNg2GFZ4RmQnQkauA9GoMZJo8F7Gh+7cRmYKLif2FjDZbRZxnps=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 18:51:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 18:51:09 +0000
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
To:     Roman Gushchin <guro@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
 <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
 <YFjdpDwKaqwvW1I9@carbon.dhcp.thefacebook.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8a28c691-1e7c-1463-9d59-da31a2926adc@oracle.com>
Date:   Tue, 23 Mar 2021 11:51:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFjdpDwKaqwvW1I9@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:301:4c::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR15CA0066.namprd15.prod.outlook.com (2603:10b6:301:4c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 18:51:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87c47938-18db-4b49-42c2-08d8ee2c9efc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44324AF8BA4DB08232C45B93E2649@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQP7DonnA3FuwDWpgCXyv+sesc10vdv8PuW1ZXpt1Jn/MO/dQEubpXxpbsT0Z6+i9otpKQBHwovSnHhyBnV2C3kNpBZ1KsBfKmQC7fAxcom7n954HYF4FBMRBY0qOEgRSxvMjkhx6jrepxP+u5FjTDWTiLXlAWocpQq8mb/ZzubqkIMFWyaOypGa8dXZfPruZ3CW3CziqmNdh/gS+BU8lzFSKFprC2Sk7oYlIElFzwwQE4NulHpXSBT8L2BQrKFQKNwmalMazwZreNNdTxuKO9nBgnnK0V9I2rj02ZZc3RGrGA7K+PUOk2xh6FLvKMuCfANMt+/muSqRC3TFN3vErWSaryvwbXu/n0ti9XBiGlEUqy/AUu4csejDfNVkicqd7QbO7PGHdnXbz074ISHO7PubQ21FVu3ayl6vnKj1mJfhPn4fEArZDQTftHO/c8g+vrcz3OYfO7epnD+i/nMEmXmyCMWnusqi4yf0ovsamU4ccBtVJlgj2QXz/UAZj496ZyyRE39F/tyMaFU7hdIhTUYPRZTJAf+PDBVWXR0NgzuxTtq+BUDNwJJwYrft9r2R865uyHfJaAPStiPoCaBqQtQQv4I+QlyU6cff4fCllfMyDccSIkwJ8/5j8RBc0zma+YkCiwJBe/ICSExFQy2HvZBPwIdMMBrolUN8wiCDursAZDjzRycMvTPDdwW5tnhlPJEPhs3wLNxkIjJFx8KFxonmXKG9bKvastgS+pW+vRLuMTTG9jVmqax0lyr3tDk3R5WflYEK31kbZ9ZrcigfAUB8rLoq3dl5bwlj5/UvPDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(36756003)(54906003)(16576012)(956004)(2616005)(186003)(15650500001)(16526019)(26005)(6486002)(316002)(2906002)(8676002)(478600001)(5660300002)(31686004)(66556008)(66946007)(86362001)(52116002)(8936002)(83380400001)(6666004)(44832011)(53546011)(966005)(7416002)(6916009)(4326008)(31696002)(66476007)(38100700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N1Y0eVJ3RXdXNzJtSFRzelFTTkdBMTBTd3l0SWk2MzBCWVM2Y0lTWlhkbjMx?=
 =?utf-8?B?M0FwU2RBd0ZOek9RT3ZMSjJsTEVNRmpnTUNOWnV3elBZUzZZZ1VLOG1hamE1?=
 =?utf-8?B?eXJqY0pRMnB4ZXE4aVYzNnpTZHBNaW1YMWpkUzQ5YmlCVnhqZFdBcmlJbDVz?=
 =?utf-8?B?ZXYzMy93ZzVmYjdzVU5CRGNvWC8rb3ozSFhYcGR3QkFGd1JMaWZUNzdEOFJZ?=
 =?utf-8?B?V1hwcloxK1BSY3g2aXp0bGZZazJZZ2ZCMVVkam9uY3dPWDMxb0h5SjJiYitH?=
 =?utf-8?B?cmlZTkVhY3dtZHNkeHd4czVJWWlzbCsydmV1d2ZDcHdCbXM5eHJwOVZYQXJS?=
 =?utf-8?B?R2FUZ1ppVnd6bmFUUWZiOGpScEZyNzUwblp2UjZ0ZGIydVFpSjF5REhrVTZr?=
 =?utf-8?B?OEJ4bTRHc1hubFhwUUlOU0hjS2lXVjg1M2ZVSVBKTW1jU0RQeXB5Wkk5MEJF?=
 =?utf-8?B?eVFFMytSOHB3Mk1IbXhhV1NDam52NnlYSHBGVlVvd20zRmt3ZWpuRTRsVTZX?=
 =?utf-8?B?b1BkTEM0eXR0aXpKYkw2OGc0RnFuUXdMK0drSUlRSm1sZVVjalNhUUVUak5s?=
 =?utf-8?B?bHU5VmdsZ2pJQXVnVXhTRm9pQUJVZTBEak9EU0tLdE5qOFB3VzVxMmtNRXF4?=
 =?utf-8?B?cWFkVCtPZTJiczZLV21QTWJ4Y2hDUEdSd1VzWTJNV1ZoMnpOQzU2S2E0Uitp?=
 =?utf-8?B?aXFPbjZzTkJZUkU4WEczVFMraTZBR3JKRmY1emduZ1c0dU1MNnZyL1dYUFo3?=
 =?utf-8?B?ZG1Kc1pWS0Y5c094L0p4Uy8yY25JbnBBNE0rTU1NSEZyZE10dENzMEErTU9q?=
 =?utf-8?B?RDNac0lNdUdoeS9CYm5oWWpkbnVSa0NnanlOQzdzWHA4aUh0aVRVV29LeWR2?=
 =?utf-8?B?UDhvYnhPME9wYnlPeGI3V2MwUlgwa3pwRVdNand1dW9Dd1AyUlVXeUN6ek4y?=
 =?utf-8?B?M24vdWt6djJYYVRYSjNDWkVNK1VpaUNoRXZEeXNGYUd6OXlNNm01L20vUk56?=
 =?utf-8?B?T1MrdzlUZEE5OXJyVldzeWVYRWZTTWQrc25SVkFobkp5bis5ajFqa1huQWRL?=
 =?utf-8?B?eXRPU0RFTUJvLzlET0FoaCtXcWUvdkpPZUx6NXI2MVVYT2RMSXcyS29ITzlR?=
 =?utf-8?B?WjAwbTlvVGRvaG9LSnUzR3BWbHpUaVFLNmZYUVdaMkFoL1l2UnVwZHdENmNJ?=
 =?utf-8?B?WlZFcmZYWjZQUWtZNDJPVWx5S1UzK014NVdzNisrbW5hNEhSNDZKb0dmNm5X?=
 =?utf-8?B?cTJLbnM2U1hrTjkyalFFOXVKelBLUDNFamRnTmdqejNYSmgvV2dFeHVZMCtu?=
 =?utf-8?B?T2ZWaWtXTWpaenlyYThXN2lYc09HOFcrRUZIQUYrdzB6TUxoQnhPUThYcGo0?=
 =?utf-8?B?UEN0L1pjenZ5VkJLQkVvVlpTUmNjcDF5cWo2c2Y2YjVDNSs5aXZZMVVCOU8z?=
 =?utf-8?B?eU5vc2NYT3d3NUtDaDJnZXRqaEtUUm1nS3BKS1czUU9PYTgwWUo5RVYySFNI?=
 =?utf-8?B?ak1rZ0FSRXpkcE1QdnBzQjZPUUF0Rk1jeWJTME9FVUpZM3RLSTJXV21RVzJk?=
 =?utf-8?B?cTMyNDBmMnJHcXFoa0d6T0h0Ung3VjZZMUJrY0w5YTJLb0RwNlJOZDMyR3p4?=
 =?utf-8?B?WVdyWURaRTZGWkJ1Y0dpT3pzNG1PRnNPbEpXWU9YdUpOUkNkaE0zNUZKL0d3?=
 =?utf-8?B?YVltTkw1dmNnUHBVOENxOHpXeHhVa1dNbC9yWjl5UGY0QnU1bmlXTWFaYXY5?=
 =?utf-8?Q?Cs/S7eZbNplIarItRSaN1m4EhnV1tTxqe1oHijT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c47938-18db-4b49-42c2-08d8ee2c9efc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 18:51:09.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLOH72FYi0QWtlRwja14AQXidKb+9yyrzs46HopNh1Rk9E4U/kKCcwnz3jlKwkGMDlVo+UCIrDfvGJ4nmYxXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230136
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 11:10 AM, Roman Gushchin wrote:
> On Mon, Mar 22, 2021 at 10:42:23AM -0700, Mike Kravetz wrote:
>> Cc: Roman, Christoph
>>
>> On 3/22/21 1:41 AM, Peter Zijlstra wrote:
>>> On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
>>>> The locks acquired in free_huge_page are irq safe.  However, in certain
>>>> circumstances the routine update_and_free_page could sleep.  Since
>>>> free_huge_page can be called from any context, it can not sleep.
>>>>
>>>> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
>>>> new routine update_and_free_page_no_sleep provides this functionality
>>>> and is only called from free_huge_page.
>>>>
>>>> Note that any 'pages' sent to the workqueue for deferred freeing have
>>>> already been removed from the hugetlb subsystem.  What is actually
>>>> deferred is returning those base pages to the low level allocator.
>>>
>>> So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
>>> should be in cma_release().
>>
>> My thinking (which could be totally wrong) is that cma_release makes no
>> claims about calling context.  From the code, it is pretty clear that it
>> can only be called from task context with no locks held.  Although,
>> there could be code incorrectly calling it today hugetlb does.  Since
>> hugetlb is the only code with this new requirement, it should do the
>> work.
>>
>> Wait!!!  That made me remember something.
>> Roman had code to create a non-blocking version of cma_release().
>> https://lore.kernel.org/linux-mm/20201022225308.2927890-1-guro@fb.com/
>>
>> There were no objections, and Christoph even thought there may be
>> problems with callers of dma_free_contiguous.
>>
>> Perhaps, we should just move forward with Roman's patches to create
>> cma_release_nowait() and avoid this workqueue stuff?
> 
> Sounds good to me. If it's the preferred path, I can rebase and resend
> those patches (they been carried for some time by Zi Yan for his 1GB THP work,
> but they are completely independent).

Thanks Roman,

Yes, this is the preferred path.  If there is a non blocking version of
cma_release, then it makes fixup of hugetlb put_page path much easier.

If you would prefer, I can rebase your patches and send with this series.
-- 
Mike Kravetz
