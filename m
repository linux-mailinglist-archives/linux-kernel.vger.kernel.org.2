Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EEA367233
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbhDUSEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:04:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58900 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbhDUSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:04:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LHsuHh183353;
        Wed, 21 Apr 2021 18:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7pNaxh4XFfJflZ6YAH649v/eBvcCBfPACLqIwg0LCTw=;
 b=AHHXoCFzAqMHAUFrRg+Xw5XGoqCC2q/3K1glZy1HLH8dnuSkPLjqWB/QbqRIkmsOrejn
 G6O/x0K2d8SanlyjVG9gNHlS0xSWvud5PRBjGWtODis9c+aUVuiuO5GH43/juiPOTdv+
 Ea7Jg4nuRBEp1vkplyrDJJWIBqbNRarA3Zkm/mRK/IslnOKVcgnlMnAZzoaamFjAFCEC
 E5FBrhqkh4m8Mwp6e/XmQAmXVDXbIIm8Z9tBfSfIXxvufSehzZzBHmr9jgiRHonVlKp2
 j0pfMVdp78VnrzZY1IRufJhLvUOYa60pXI2InZk43TtpiVXlpAL7aIx1PBcRxJhjSxaA Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37yqmnk4n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 18:03:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LHsrKX118620;
        Wed, 21 Apr 2021 18:03:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3809m0ymbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 18:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJQCReZJ0bpHkjlVseoYePOb34laXLvfVfUw+2oX5a1KBbkMGzDWCGBFYTHOpcBODAfPXzXxu9cVGZXXpONgA0ytD3gaPotsQTfPTo+3evfr7g4YzhvPd+IIMI53C4NrxvaebLCMyprN4o/WYFKlDhvhKKs55in6Gap9icjguJIg88m7j0HgFMT/odZ2bWQ7XDKJGugl1YeT7JD73OeR19me4dyJ3dE70Zn5MHQN8Zq4T/Xll2Nmogjljd688m9yIlfyBp+UTUeb1NhX6fNmmZo7EpSjLPc/KDITV+VnST7NoPZPy6lEHPmz3IUA2OZGRr2Wf1xbH+19vFxS9J77Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pNaxh4XFfJflZ6YAH649v/eBvcCBfPACLqIwg0LCTw=;
 b=QKjMkhDjWU9ohCaD65bQVBGua9ALqTCSZl7OQ2DA7pE9lku2gryG1DQyknRaASoZsj0Jx8FkEW/bbtPdHggOuaE99OIW0732M84/m1T0fLqF0zpjlSsHmIqbFsvh1y1Mh4wJFqXMmfQlef0zdgpHxm0o29bTxLpm8ZbEWnGFkjMAZ0webv/sx6aEgd1R4skOTklOKjN9C3XTedsNR9G7HHH2Urrl17JuLDARGZQ5fCnurJ0tzc8ozTjceiTeNdWmqin1tuO/hqD6gNVoNxvl2Xwu7eLNGA/1kHSKi05w1gt1QCoSRa2CAsJm+GEcEgxooQ1b0R1aT05UMDsFVlkBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pNaxh4XFfJflZ6YAH649v/eBvcCBfPACLqIwg0LCTw=;
 b=UShHLWlIicA8OpURu0XWPGrYMQtO3DK5zdkcSNCVZCKfDRbDc9mubJGuDhvoP4AtyM2ilMszyzTp68KDVuAI6hykCNv+yCO8G0Tn97VUDg2dJQhDVGPZPGdQ/lv6/OQ3cbep2X4XktbCDicvLOElG9xptO6M7n0XS83lEXarTVM=
Authentication-Results: ah.jp.nec.com; dkim=none (message not signed)
 header.d=none;ah.jp.nec.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3493.namprd10.prod.outlook.com (2603:10b6:a03:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 18:03:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 18:03:26 +0000
Subject: Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
 <20210421083315.GA7552@hori.linux.bs1.fc.nec.co.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <57892496-a391-2eb9-eda0-1db9f3b98902@oracle.com>
Date:   Wed, 21 Apr 2021 11:03:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210421083315.GA7552@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0059.namprd21.prod.outlook.com
 (2603:10b6:300:db::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR21CA0059.namprd21.prod.outlook.com (2603:10b6:300:db::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.7 via Frontend Transport; Wed, 21 Apr 2021 18:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c8d6149-20cc-4dd5-de7a-08d904efc2e4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3493:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3493BA83C3864F7518F08372E2479@BYAPR10MB3493.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qn8ptwB55THif1DU/4O0rcAxTcdO4NFHNrsNsBQ1CZqQas4OV+QrhMwHRgmSmdIhBIEsjD3NwycuXo+Jf+kFTGENSxjF+8LB851TN7asg+ALypJGzffdWOOe+gZfrbX0A93aKyHQSZvz/sBE0/XaL7TXFwAJGvmeh1GJvHUanLl6ZixwMnRFpwT4KA+ngLvEingiZSNanBC6JVmV6uNz9j1oK+njsSVOr0mFMblQaacd1oOPt8zMZ6SqrquvtEfPbPJoXj7Pt5M+LF5SNxqS/NMZ94ccI9RUbAZjnihu7Q3H/8FToc9+yVYgVoa34sA04s8/sJXVnHfMoK+aMEcFWf7N0FLdW8IHPnbihWR/zHqhhbXH0yKmbBZrvw3FmFpwBtMhPZoLpc0q0031mUMBhcscK5fAn23Tp0Zzw7NV0uQQrMWG2DTVbT+LwY7TeYkfeiYwk1TDGceCCV+wZR2Vt0PZfiRxfvyjEDihzvTIm5LRQ1JEAMusPn9VrhgILLWD043LW0gdgMYE8E4DD35egOgp66yDelmwcKTpYWDRlgGGsIlwOAhWuK6NuUpSPhvqKShkJzgy/CI1p2GJGi2bCRpXGCXASqVVzDBO0T8vCZtZ6AnHPYxf8tficYKtAKJvryKPk4+KYr4N+xmu5jglpSHhIjvgqr8neCzpn2oANXe3oz+wxNDP0cYmpr1dfYhAkIr+zKKeKid3Us9HwTrlsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(396003)(346002)(956004)(186003)(2616005)(44832011)(83380400001)(26005)(16526019)(38100700002)(110136005)(16576012)(316002)(8676002)(31686004)(36756003)(8936002)(53546011)(52116002)(54906003)(6486002)(4326008)(2906002)(66946007)(66556008)(478600001)(86362001)(38350700002)(31696002)(5660300002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TGZGU0ROenlvb0w2THFiUVVwVkpEd0w1QURYTWUvT1kxUktteTJFYmhSNHVU?=
 =?utf-8?B?MVU3RGI5VUp5eGF0NkdybGRhL2NJRkdIQ2ZPdjBvV08zTFJ2MHhKdGNXdlA1?=
 =?utf-8?B?bU9DQmdJOWN5cU1DYmlScVFOeitRWGhBbmhQdkp1a3F3YVIydzlBTGlsYSta?=
 =?utf-8?B?V0xiYTkzTmFWYnU3ZUZrREVWUFYvNC81akM1TmdpY3R3NzN4TitoUmR1Tm9X?=
 =?utf-8?B?QXgwYUdLcC9sdFpVb1J5TEdMb3o0bmlBeEMyQkU0S1YzNFJ1QVFDVHJvZUxD?=
 =?utf-8?B?Vkg3dnFTdWk4QWx3Tld4Sm9DcWhNRExjYzhmK0hIZ1h6WENMNVBHSjYxVkYw?=
 =?utf-8?B?UFFiM2JSemNZdmMwajlNNThLTTN0NkZpT1hSeitjVDUzeXlySWFWQXFkTHQ2?=
 =?utf-8?B?Zjg4MnRsN0F5cUlXUGRzemxhQXowV1ZEeDk3dWoydmRVZVcyODI4VTZIenZI?=
 =?utf-8?B?S3pkTS9rN1FJTE1rNXY2QjI1amowTVZCOTlpeDRiRG1zVG0vdXcyR1duSkM1?=
 =?utf-8?B?dWhLdWEzWENLSXdQZUJaRkRkVEE3RlBnNDNRYUh1UGQra3ZXYzJDNEYxbVV1?=
 =?utf-8?B?bC95VDFRcEk2bDRhSG5DK1B5ZURMdnFpZVhtT09BL2pldnVZNnVaQU1ia2VR?=
 =?utf-8?B?YS81RytCbDZEQWRYZjY4Y2gvTXdhWFVUZjRXenJFSmYrUEFhaGRtdDU4dm8x?=
 =?utf-8?B?VDEyQWkxKzdQdkVWWTNQYVN3VitodXhVQkw4SlhpZmNIQzNJUDJKSGxVWUNW?=
 =?utf-8?B?K0dRaTBmYkRBRmQyd3lBejVjYUEzYXVBLzFhNnU3NVI0bEE0NkdIM2VaWWtR?=
 =?utf-8?B?eVZEZU1HR0dubWhiRmwwcXpXdWlzZFJIZDU4STY2WktQVU5JcG5zaXRZRXQ4?=
 =?utf-8?B?QjcwclNkTnd6em9rWjZ6Uk5WSVRsRU1pUUdhQkdUMDJyS1E5bWdQN29YTVpN?=
 =?utf-8?B?Wmh5VGN6Vnk3THVGdDFNSURuS2JHMDJhNlZyWmVxUXVrazk5Q0dubDZQQit2?=
 =?utf-8?B?NmxsRTlGNEI5SWNqN1FzVUtlbHBDUjgwN1lyQ1pqQ1o2cjM5QUhUSTMyNHZI?=
 =?utf-8?B?SFNtRzZGN0x6cm81OElmMk1vbVhxMnhUQ3FydzJuemxpRDFsMHhpS1lUMXJM?=
 =?utf-8?B?aUI4OHBid0hMei9nNTA1ZEl6bDViUU9RWUZVZG9sMUNZVVhJak9aZ0QrRE14?=
 =?utf-8?B?MWxzUUpJeWJSamIxSlpQWGpOYmxhNEVJZ1BpWThMZkplLzhwOUtlTDJUVzBQ?=
 =?utf-8?B?dUhxbjY0VU1NWkRIMzNrT1REMWdRVTFoaHpSelNMSjBFc09GNkVDRGZJZnIx?=
 =?utf-8?B?WitaY2IxZ2I2VE9KVGZDMGNTMHF4RzFMRkcvcnBUYVgzL3EwY2lWQStiMHd2?=
 =?utf-8?B?Q1JhbmxmVU1sWWpiUDNEQXloMW55OGV3YVdJNVVzSXJZMXJVNzV5SVRzVUZJ?=
 =?utf-8?B?cytmZSsxVEY2NFBKRGNNODlIVW5hMmk1dXJGc0FqL3F2Y1QxVCtFZ1ZGcXY1?=
 =?utf-8?B?NFkyZU9tK1ZvUkREdnBkcW9YOVMrTzdRK09Tall4K0pyaHlRRzVkaXNBTTll?=
 =?utf-8?B?aVl1SHhxN2lIWHJLamJ4SkJvOUJoeFYwcms5K0tkenlLODZTd1hsQ0ZsYU8x?=
 =?utf-8?B?K3c1dEU2WnZVUEZ4emJiWWhrNnREUVp4alRVcm5VVS84QjhwWjIzdzB6V1U4?=
 =?utf-8?B?RHg4VllrMXh2dnJFUk9sRW5ZeFpUaE1GbG1RZHRGaldaQVFRUzNvcjZUM0xQ?=
 =?utf-8?Q?Ow+aceOAQAq5AzD3iI1BTOCBQO8XrbipjPaMUNl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8d6149-20cc-4dd5-de7a-08d904efc2e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 18:03:26.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpVD3LT+UMF4+BSqAwbCX3K2oaQDc8WQqksdhLfeEqGfl6cBGtsEu73vEUW8+CD6UH+2S7SbU988x3bDXuf0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3493
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210125
X-Proofpoint-ORIG-GUID: Z-Gf772NPPOsu93E52yae3HfoQ_sc-t1
X-Proofpoint-GUID: Z-Gf772NPPOsu93E52yae3HfoQ_sc-t1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 1:33 AM, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Apr 21, 2021 at 10:03:34AM +0200, Michal Hocko wrote:
>> [Cc Naoya]
>>
>> On Wed 21-04-21 14:02:59, Muchun Song wrote:
>>> The possible bad scenario:
>>>
>>> CPU0:                           CPU1:
>>>
>>>                                 gather_surplus_pages()
>>>                                   page = alloc_surplus_huge_page()
>>> memory_failure_hugetlb()
>>>   get_hwpoison_page(page)
>>>     __get_hwpoison_page(page)
>>>       get_page_unless_zero(page)
>>>                                   zero = put_page_testzero(page)
>>>                                   VM_BUG_ON_PAGE(!zero, page)
>>>                                   enqueue_huge_page(h, page)
>>>   put_page(page)
>>>
>>> The refcount can possibly be increased by memory-failure or soft_offline
>>> handlers, we can trigger VM_BUG_ON_PAGE and wrongly add the page to the
>>> hugetlb pool list.
>>
>> The hwpoison side of this looks really suspicious to me. It shouldn't
>> really touch the reference count of hugetlb pages without being very
>> careful (and having hugetlb_lock held).
> 
> I have the same feeling, there is a window where a hugepage is refcounted
> during converting from buddy free pages into free hugepage, so refcount
> alone is not enough to prevent the race.  hugetlb_lock is retaken after
> alloc_surplus_huge_page returns, so simply holding hugetlb_lock in
> get_hwpoison_page() seems not work.  Is there any status bit to show that a
> hugepage is just being initialized (not in free hugepage pool or in use)?
> 

It seems we can also race with the code that makes a compound page a
hugetlb page.  The memory failure code could be called after allocating
pages from buddy and before setting compound page DTOR.  So, the memory
handling code will process it as a compound page.

Just thinking that this may not be limited to the hugetlb specific memory
failure handling?
-- 
Mike Kravetz
