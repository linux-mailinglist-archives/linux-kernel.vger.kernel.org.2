Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60363EDA89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhHPQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:08:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29000 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhHPQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:08:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GG6dX8024357;
        Mon, 16 Aug 2021 16:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UWWX+YgoPY0YNjKZ/x1Fzevn1gFiVhgwy+6ObgOSDO8=;
 b=Z4FopuOMm2jw/bg8I18vBhztidCdZfBQt2VskWYnXmFV058uqtjvmt0QZG9awZFCTVJy
 abv25Dej3+0ahPMzcdyquezVlFUtuQp3RuAHuE3Lk/L9WiF5AbuJKrndKyJBghPaKcil
 qrT3rXzDEipJ+eMMSguGtYwo6ybbHBGNmXt/QI2VvCGX/OZOuD9Ov1kcAhqZ/en6biHN
 6pbX4JVmM3Tsf+NC/B7AfMpChccWHmkPoa4X1r6M6VDZiEgntuTyz5SQN/DhWN6O25U6
 WUc6Z/HycsbxP6vUsYbnfb8gKZRqM+Hr5WlMBjJG9aNMO5EpbbMfzAoijcdKeRNLQxBJ JQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UWWX+YgoPY0YNjKZ/x1Fzevn1gFiVhgwy+6ObgOSDO8=;
 b=BSpWHyNtvNMUVWC2fZMEBBIbYb86W2E/tmg2t+4lM9I1Hc4jXhiQPum2HGzANHMy0SKy
 z1S5dg2iKXxhILL/kORmlxxeaS5sRSoHLi0te/j7qvr3MToWiM3G1OtFFlUcMl5LYEUK
 htpj2lHKEu6Dsx3s7xqCXpIM6MpE8qlql+HZGTABwLpJYVKVaZPFaXI3Q1On38RL8hAE
 6XUH7BeJeeiEMrjFSUWpq0DQCxRxdqQv6ZQWP1aZxIj2q+VexFr8IKCuvppvEC/fprF1
 GQB6VbAELUXXoq5RNzyiQNg3ehIkDdmaCOo9dAyHwp9WK4g2nJoAuIOQILzDnDXF2njI fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af83026gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 16:07:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GG6nDC004489;
        Mon, 16 Aug 2021 16:07:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3ae5n5xha5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 16:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G41o00aLhi3aMv5+McDyYpCi0POXn5BVpiSVpEFcjRHWOqWf/+kjhZJ2vJiM5lgEcKLSrOHtz3dVo3NYWJX88D0Px6B/Sc4dUcZPyISxpOM8vHT6xC9UOl1kWbfXILCn2h7OroeWvhk5NWgGqpkbQzYV/FijxmJGQ0Xi2mb7iIaHoOzxWLg9KkREyTU+YCmOELnprOwn8qVKKJbUwstnYn1dBTQ5uy/gTc4z8mLjy7ueEgXlqh1d8flMe7gWemaBX2FoEFabpzSEPlh/PV0TaIrvQhATJwzPtxbcB9Uu1B6i9KJYihB6YmjWJzOis9U0avuV0XYzevSgh+vubkVl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWWX+YgoPY0YNjKZ/x1Fzevn1gFiVhgwy+6ObgOSDO8=;
 b=Q38iOKVkdBBpktMCLF0nMJGHt1C5KztxKy5jbZ+F1EHEJuFD4vdGlvkNQIh0oJiab88m+FG1PBGf5t3MGgjEGaGe8+b8ZJz7qrrUbhUZuPI7zXkYyurNW+95GHlw+QfvP8gFbRckfBaypVW5KrMbXWgb+YmFZbGWtSDQL+XTsGN0niwEohNQQPp+ahBXlnhhztb7gQbn00Wrm/A2ldopBEVeJGB48YB+HA7HOpU1yTGizKsy1bvcBki2TazXRCnLgT+1nHnBTbbpcCX1NgH6DElaPhv8Jc3yPcfEqsJSXWN9SIZr7i1B6NFP0mqdsIDiH7ItWXSXO04oaDN0nutePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWWX+YgoPY0YNjKZ/x1Fzevn1gFiVhgwy+6ObgOSDO8=;
 b=J+WSohx6Jra4BU6GzIMuAZHLhkhf/3oZxJpHl1TLnkwcbCPQ+lj5RhcRqyacLVFf52udOkedi5CI1k7KaPjqNLJIa3Trmt3TETj3SSp/BPTpp9CsqLDEiphzznCTF9ahHOrZOaKezS+zR5hIMTiYYro6TcgLXKZkXaqys/ce6is=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN0PR10MB4949.namprd10.prod.outlook.com (2603:10b6:408:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 16:06:52 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::b049:95da:3548:61f8]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::b049:95da:3548:61f8%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 16:06:52 +0000
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
 <YRpo4EAJSkY7hI7Q@casper.infradead.org>
 <40bad572-501d-e4cf-80e3-9a8daa98dc7e@redhat.com>
 <YRp169xvwB3j0rpD@casper.infradead.org>
 <3ce1f52f-d84d-49ba-c027-058266e16d81@redhat.com>
 <YRp4+EmohNoxzv2x@casper.infradead.org>
 <e6a31927-8f93-22af-2d5a-9d80578e9317@redhat.com>
 <YRqLc2W1P77tiSqj@casper.infradead.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <25d15c74-40e2-8ec3-5232-ab945f653580@oracle.com>
Date:   Mon, 16 Aug 2021 10:06:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YRqLc2W1P77tiSqj@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.154.191.154] (138.3.200.26) by SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Mon, 16 Aug 2021 16:06:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2e3926e-6b8d-47f3-21e9-08d960cfdc67
X-MS-TrafficTypeDiagnostic: BN0PR10MB4949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB49492C6906995B03BA0081F986FD9@BN0PR10MB4949.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epNUBQ+yyh7d9nJMrrmgal7KvADe4+RKY568ZYyRYVHwFrkB8QZI7+vwRhkIXuZXDhYciTeqIpMfCjvnJWcV406Ase9s47rReev6Fz1egZZo+gnlF5zt4Jk9dvdQH5XhmoyluRsNiOoF5KvW9+QQcW9J/N/fcBkYK1JTX52rRYKpF7fYFh5nRYkLgrOW1bktyz6PEc446Ubii5crmzoVOnOyjyaEqUCG2GP73n1dEgG8wBeflLrlI+1zzLZEHsbb9jm+Ptl6J4kTuF+ymFiJhrG6CII/ELMvnvaGlShn52KqMql/2bjlFu6FvpeT19wrn0FKOSW7Mk8SMZhXRa3JmzQKBQ6pZmZIOOZB8u/z163C/AgXJ1PbGJczUtCbm0pJEH74EZL7smgWrPIgmW64BY3cIg1vmX/2s5BsGHOJZaGtCjRzmUpwAK9R31/EXVfxQhN+t+o44nUYeHgsDZfDcjzhuN4ZjIWMwOs3zW7AQ+4td/xyB3esKKO588HChN3a5fu2ej8lBQgHGbbfn6TV0iJHc8ftais61gZi45Sq7t8D+JyahH52NqGvwgkPF42te6DjAVNUJC4q8RTThEk153pvRd6VnBK2NOsuqxcWQQiWBIejt+86aiZcgON30LrNDsGnH9L70IOZtDnZBDrRlt+pVbOU1YeDgNggZ6R2zIOc2Xj0oR/AXbwhNgXKKNDTRv/m7fyRohdgYJdDUEJ5/rkNe/ACeZ3SLTmhsXMAJWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(186003)(36756003)(6666004)(38100700002)(4326008)(8936002)(8676002)(53546011)(86362001)(44832011)(54906003)(66476007)(2616005)(66556008)(478600001)(16576012)(66946007)(31696002)(316002)(2906002)(110136005)(26005)(31686004)(5660300002)(6486002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU02bzdDZVlnalZidmc5WUh4SVk5K0ViVUlXY0c3UXAwNjVTVjhKUWRQaFo4?=
 =?utf-8?B?QjRrQkxhd1N6UnNWZUhpYlhPUk1KRnd4bDdqZVdzTUxFSEhuVzdwNHJocFVX?=
 =?utf-8?B?VEVoQjc0b1J1WUNEQ3ZJWFFFalQzc1JhT090bDN5VXpBbXFoVXJpeHZHNW8v?=
 =?utf-8?B?MU5JRWlzR2FKUlRoMkk3elRLS2FCbENYSHJzdTJkTytDaEY0WExBUW9sN0Nq?=
 =?utf-8?B?WjRubi9RK2l0MzN4Z0NXanVnZEdDVEt6d1pXazNTb0k4R0FjaCswb1R2MndV?=
 =?utf-8?B?YjhBRUxqdk81eEQ4d3BHZVJOUjZuWnNEL2ZKdnM2OUR2VTlDRmlQNUFJaGov?=
 =?utf-8?B?dkxpeU9qKzh5SkgvZ0tJSXVrNWVSYUxiVUpqbm9scUE1ODM5akZlZXFELzE5?=
 =?utf-8?B?MDBaTkROVlMrRHpCejVpU1BmOEVOYkFQYnk0QTRKa200VEtON2hpclVod3dT?=
 =?utf-8?B?anpEbmphSy9xRm1hamtiVDZROTR2aXV6RnU1UE1NL3RKUkZvQUtWVHdMOGt2?=
 =?utf-8?B?K1BCN0RxYUZocElOMFZXRVgvOEVJeTVEVFR0cjg3NzJYUGF0Z3Jmb05UeDZ1?=
 =?utf-8?B?ZTZMQTE0a2Ixb09yVm82UTZaOEJyN095OXRxVlpnMWZ5UHA3NStvajdGZmNW?=
 =?utf-8?B?YWovUDJPSTBQNTErT1lDb1lRSG1CWEdUZXNzeUxIbjVtcTd3ZURsL05wOTQ4?=
 =?utf-8?B?cmZQb2dINzEzUkE2YVpsc253N3hkcjIrL3MvdnFVYWt5TVByR0JuSUZWQ3pH?=
 =?utf-8?B?MHRJa0sxV0VYMVBPNTFXYjk1aldDN29pemVVOGlML1FpTjU0bXg2emxseVhM?=
 =?utf-8?B?R2V5YXgxT0cvbmllSEEvUGt2SVFXaVArNmJPTDFDR2RSVitZMktrTENjMVVk?=
 =?utf-8?B?MEFOd3ZUQVFnblJpa3d0T2s1amNuUzNsa01xRmtZT0p3N1VtRzJyTy8vY0Qy?=
 =?utf-8?B?VE8xOWZpWTdOSWxoUUwrT1ZITC9qQ2RPNThVb1A2enFlZnZOdE1hUkZ5a01W?=
 =?utf-8?B?ak1lRndYMDd4TmNlNHN6aU5WK1FGYnZQM1RuTWtoRlUrZml4VlhPTjBBdFBY?=
 =?utf-8?B?OTluOXR5RXZMeTlXRGpiTFp3STV3NjZFSkRXcHVGaGM0RjZyL1NOK09xR3pn?=
 =?utf-8?B?citBQmR1dkU4Z09NalljeUdocUlNU0hRb1RaWmtjNy83U2RHUDY0dlZDYzE3?=
 =?utf-8?B?dWt4b1VUYXNGbGtPR2RQLzhrUVdPbm9hSlR4Ujdjd0tuVEJxUEdCZWRzOHBi?=
 =?utf-8?B?Q1RVaHhYSnVSbkkwcHNaeUtBTjZwSnRLOU9IcDNxbVFwTC90VEJUbjVxQk5v?=
 =?utf-8?B?aC9JMitzOEtFcnpmK3JxdmNjdW15MUY0bENFN0M4ZDZ3bll0dnRZTjBVK2VV?=
 =?utf-8?B?Y01vN2NhNDFpUDRZOVBjd25yZnVBVFlhK1RReTd1WXpvZUVsa2VldjZoclE1?=
 =?utf-8?B?QUF6ZW43SlphQUZNMnF4UzBPRUNLZjZXaWJIUmVZZG9wMWk2VFF2ZE11Z1pl?=
 =?utf-8?B?Q2xBd3NmbmovRitEM0R6S1Z5czRWbmJKM1F2N1c5UzFXRkVTNWVZSWNmUXV3?=
 =?utf-8?B?YnhvSmFRUmkxVHo5enlWaEl4aUIxM0JqYngwTDY0dUkxOVFSTmVQcUdhd3I4?=
 =?utf-8?B?dk80bVcxQjF5b3RNckNnTEltbHpZVkI4blZ4Rm1TVGpERjdxdlVyNWhrNDZx?=
 =?utf-8?B?K1ZUV1V1UzYxMXdtdHphc0lwc1FoUTNkby8vNlRLWGxXSFg1WXVBSDFjcUNp?=
 =?utf-8?Q?/JriBB9VORxXzuc45VoRS2ADZ7YHmJ61XdGF+3n?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e3926e-6b8d-47f3-21e9-08d960cfdc67
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 16:06:52.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnwqtJ9D4rhRY19fsv6Kx+YcKEX6uT1Wy0+k3GUgIVmMfmTOu/pFnQ7UE8xPwZxKMeR59nV2ikWGCimON8RudQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4949
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=755 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160102
X-Proofpoint-ORIG-GUID: 1ZC-e22oYRkFx2-Q_EwFlXLEvD6GIoJB
X-Proofpoint-GUID: 1ZC-e22oYRkFx2-Q_EwFlXLEvD6GIoJB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 9:59 AM, Matthew Wilcox wrote:
> On Mon, Aug 16, 2021 at 05:01:44PM +0200, David Hildenbrand wrote:
>> On 16.08.21 16:40, Matthew Wilcox wrote:
>>> On Mon, Aug 16, 2021 at 04:33:09PM +0200, David Hildenbrand wrote:
>>>>>> I did not follow why we have to play games with MAP_PRIVATE, and having
>>>>>> private anonymous pages shared between processes that don't COW, introducing
>>>>>> new syscalls etc.
>>>>>
>>>>> It's not about SHMEM, it's about file-backed pages on regular
>>>>> filesystems.  I don't want to have XFS, ext4 and btrfs all with their
>>>>> own implementations of ARCH_WANT_HUGE_PMD_SHARE.
>>>>
>>>> Let me ask this way: why do we have to play such games with MAP_PRIVATE?
>>>
>>> : Mappings within this address range behave as if they were shared
>>> : between threads, so a write to a MAP_PRIVATE mapping will create a
>>> : page which is shared between all the sharers.
>>>
>>> If so, that's a misunderstanding, because there are no games being played.
>>> What Khalid's saying there is that because the page tables are already
>>> shared for that range of address space, the COW of a MAP_PRIVATE will
>>> create a new page, but that page will be shared between all the sharers.
>>> The second write to a MAP_PRIVATE page (by any of the sharers) will not
>>> create a COW situation.  Just like if all the sharers were threads of
>>> the same process.
>>>
>>
>> It actually seems to be just like I understood it. We'll have multiple
>> processes share anonymous pages writable, even though they are not using
>> shared memory.
>>
>> IMHO, sharing page tables to optimize for something kernel-internal (page
>> table consumption) should be completely transparent to user space. Just like
>> ARCH_WANT_HUGE_PMD_SHARE currently is unless I am missing something
>> important.
>>
>> The VM_MAYSHARE check in want_pmd_share()->vma_shareable() makes me assume
>> that we really only optimize for MAP_SHARED right now, never for
>> MAP_PRIVATE.
> 
> It's definitely *not* about being transparent to userspace.  It's about
> giving userspace new functionality where multiple processes can choose
> to share a portion of their address space with each other.  What any
> process changes in that range changes, every sharing process sees.
> mmap(), munmap(), mprotect(), mremap(), everything.
> 

Exactly and to further elaborate, once a process calls mshare() to declare its intent to share PTEs for a range of 
address and another process accepts that sharing by calling mshare() itself, the two (or more) processes have agreed to 
share PTEs for that entire address range. A MAP_PRIVATE mapping in this address range goes against the original intent 
of sharing and what we are saying is the original intent of sharing takes precedence in case of this conflict.

--
Khalid
