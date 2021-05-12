Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF20937EECE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443122AbhELWQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:16:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391845AbhELVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 17:33:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CLP3lp050059;
        Wed, 12 May 2021 21:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KSfsP069ZsUu2lWImUlK3s1lpEdSkW9cBHgHD+VeDIc=;
 b=aw2LIXKcsc2gWZ+785G4enbNPv5Idtwrj81M53peLkwQK+nKyq40usM3vLaJy6jYrmZ3
 gA04tppSopgtmJtsM6eu384wBlcsMbiBxs97TX+PGdzZ2nkcR0H2g951d79i3XF/vWqm
 OYGb+SxMNHxJH05nW8BlNnM/u7eyW0o2Ki0cvrLuwf4ob8bUR+zgqU84J3DPDLSxBuXI
 0aPz9lEIwNE4dovIKituyLHbjbO2iZjnp3P7GHEEgzimEUK22xDxZeWXlGawPaBWC9mi
 e1/DX+KIYreAjdPbLOGpMrlxl5gLLNL8saKPz5S9Vj09DvqgONoEn9kuLGzRuaZfgZbx aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38gpnug1p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 21:31:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CLQiqi152280;
        Wed, 12 May 2021 21:31:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 38gpp99gff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 21:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiZ+82GfpWzMZvFMeEQhjxawznq4CLM3uqrMO8NmezcC8SvGNc+MEeFIyFH1HYTGM8UEkkXNF1q7tTsNKTvP/VWZyC8nI/LdtYEb19bAdDHTrY1wYbW36rOc98o2BI6Q3I5YoaqmN8eb79maJlufo1B4rfATYU8XA/QOIx4ss0p1639OZBxY12q/xmAsulGaZHG6rsuEWEip1fwTghN/5QV/OGoApmkYdI/qFUPPJGBWQkGLZcPcSt+ZWGgiNWrPoNFG2fsmYmlLUOWf2RKvhYjRuDKusDkeyojcMrQZD+TaeHdiYIBORtfNFZjrFpKcazbmjJg47r9ltNxGRgFu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSfsP069ZsUu2lWImUlK3s1lpEdSkW9cBHgHD+VeDIc=;
 b=g1nZWR4Athtbt/xGEjfy2GGLR62gZF7oFJGee0Qk9Vxp6kgjIA+gOwUVhhcqk99UbPJtNGfe9a1kT1TbNK+3z4qVQHqMmac/7oxyjw15+g3eR+2nAQ6fWVpbh4sJxCAg4ImSoq1gu9xboYsI8nn+mcM+I+ib6INAGXyfhF8ZTnL7FbVM5h9dkK3QQ7vDBlU8jRr83kJt+nykJnnkC+hn3Vpk8LCxLkIxuPyZ7U9rlRYdP5QaX4qvdQYnDkRN0nozGzWsDazx2F2EQrN6+RzmFUeK9XhQCkIVg9eea350phIQbouYimzYQpFC6hMxHIOi0BJWcvU4EN47bOMHuF9Ubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSfsP069ZsUu2lWImUlK3s1lpEdSkW9cBHgHD+VeDIc=;
 b=XUXSk0tXl3VfXwBNwdK1/9RBNe7EMRwMfmQ6lKycOBtkT+8t2K7fx+T4DltGHP4zUIdJwS42wCy9x1rgJ32ulC1J6gV8XtRerqad6zI0+bhuHD5xckSk+2dkUivHUGbh5e64GiDcSYDYSz0JPa/+n0LkBOcnJJ65XL7sDg6g8dM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 21:31:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 21:31:40 +0000
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Peter Xu <peterx@redhat.com>, Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <e134d74d-c218-a01d-a315-82b909c84051@oracle.com>
 <20210512065813.89270-1-almasrymina@google.com>
 <CAJHvVch0ZMapPVEc0Ge5V4KDgNDNhECbqwDi0y9XxsxFXQZ-gg@mail.gmail.com>
 <c455d241-11f6-95a6-eb29-0ddd94eedbd7@oracle.com>
 <CAHS8izM8G948ziJToaNKgqaMQ9_CB+anksGQQHSbTY1a+yGSjg@mail.gmail.com>
 <YJw3MH2kTftwvlGa@t490s>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6a4678a2-c6d1-cf27-cd69-1b49349a3271@oracle.com>
Date:   Wed, 12 May 2021 14:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YJw3MH2kTftwvlGa@t490s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0152.namprd04.prod.outlook.com (2603:10b6:303:85::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 21:31:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8df2eb10-8b73-4356-aa7b-08d9158d545d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4196353A20F2FEF2947A09B1E2529@BY5PR10MB4196.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7GQK6UkWO+YDr6JSQhYvZKoLWQbuU0v24AbkUzPUWtuRi8lxHfTjEYqRSurSAQzyrQtzn/QiPXBaxZh9eFBSvEE29gsqfzjCYzvi3SwRmJ1ty5zOruSbIymcsivBl9WRVXLps1YU6cACge4JEC4aMcXLKF3J4HiJntmOjESWoufErxb6Zage/94fw5RNhn2tWlnGXxC7rA8Dr9+qZ3qN12bCbqN5MbQE+giiuXVDKUk9RSrMzqlr9gP2/9+Tuk3P1/jUyAeCQhpRkUMN6T7KasN87bxoS9BOYgB++leJqgz13vfyebxSyC6zZ7HRYaWrwvW4e40OLrH2syHZpea2Q8zescEZuiCbgDuQWrizN+XbXFyTbrPpG61k1SVy9twtsJB1z+RqzIShZy3LECXRi8Ou8BbtezAUYBNC9vzCUu2eOvF+6gych7WWj5ZxfXC3h8n/5XelTmaOmS4XlXwVPWLymqTmyCFOaUZVLJaNV5JZiQVtin5N4N/LKD3owz5RDps5C8tfCpHLteabSNgBAMPekSEpwkyhRu+CxuxewYVQ4UXfHcBrHPFfqpczs4FS19exSpEc4vT+o2CQUIK9nKeIlccJnwX6Jr+hLS1zxcO1tC24k6nUl2dk6EE8UpWDh3FQyK0l/rPGdqZmdbWgE6TSLXxETp3h2ZKA0Lomr0yqnnp2ADoDK+vfV1tto3KgTg2Fg6mgw0wmso85Wfd4MaQXoB14jzjJaYO6Ej1pUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(5660300002)(2906002)(16576012)(83380400001)(54906003)(6486002)(38350700002)(38100700002)(186003)(110136005)(316002)(66556008)(66946007)(26005)(16526019)(31686004)(53546011)(44832011)(2616005)(956004)(86362001)(52116002)(478600001)(8676002)(8936002)(36756003)(31696002)(4326008)(66476007)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UHNuQWltcFhFbExIYWkyanJJZ3R6Nko1ZWxWT2hhSDgzSWsvZUJaNEJva3JQ?=
 =?utf-8?B?RFpaVm1UdnN2dlMwQklpWk03WElOQWJGUFFJUzc4TVZkU3d6MldTSFY4VXEz?=
 =?utf-8?B?WWp5bDFXejQyWDd1Qi9XOU1vRDhQUEJmWWQ0TmYwS0VhVU85R2pZamU0dlNP?=
 =?utf-8?B?bjRuc3pUREVldFBuekNsNzg4cGY3V0toeHB0eUNWeXhrS0JjS0twZGJZNElE?=
 =?utf-8?B?V29TY0pOK0tURm1CZGRyNHBUVFpNa2RsREZZSWVMM2NKU0FlWGQ2cHpZV2V5?=
 =?utf-8?B?THlwWFlHOEwzK1N1Sml6WERzSXd4aEx1ZnQwK1RFR0dMZCtGenl5Y2FSSW5M?=
 =?utf-8?B?S01HYVRROTVwOXJoZG9aRFRQdFcwYUo1ZGFIcFJhT0h0bXZTNUlVbjFtYTRS?=
 =?utf-8?B?U0ZoQnBXUVYxU2dUYWZ0Mm1XNFM2cjNIZWRkanFIYS9kbk5XbytJK1MrSkhN?=
 =?utf-8?B?T29NdXRUN3Vzbzdwbm14MVR2VStMT0hLSHNoNURsODdvSXYwWEo1dWJWQWZm?=
 =?utf-8?B?eXRVbVlDM01laVB2eUtZYnhTVE10NFpZaGZ1RzdJQ0dkSzRRcjlnWm5ZNThq?=
 =?utf-8?B?VWxybXkwOVZ1Y2Fwb2FlVUhSeDNhYU1BcXR6aTFZV0luYzJJYktJYWV6ZDg5?=
 =?utf-8?B?TTgyL0NtZTY1QWFXMGJWWldMZ2h0ZFNyVzc5bXUvNXRoSHRKTVA5MlVlQmdR?=
 =?utf-8?B?SHp3RVpyUTdlYkpNUHVtSGQyU3BTUTN1OEZnQ05KRVptQzdjRHd3MlhUbmMy?=
 =?utf-8?B?WjRoV1BsaTcwOThRTTJ4dHVNRUJva0orVFdtYTMxU0VqalIraFUrZTFYclFp?=
 =?utf-8?B?Z1VTbThNV1NYbGhmRW9VbDRyMjdveUFYNmE3aUNLZjMwVVc5bTc1eXkwQ3Nj?=
 =?utf-8?B?a2FJcjVyclljNGd6RmJycGkvNW1IcThHT3IvNXJuUGJoVFlVa3F2S003RXR6?=
 =?utf-8?B?WUxZSDJWdGNWcm9UbUxoemtqa3dobHkwQ2h5UlNURTVCelhNQVQvU2lOWXlk?=
 =?utf-8?B?cTJiK1F5UlZTRjNXZ0NwbG5rdGlUcTAwT0xhRW9HUUEyaXk3QU9RcmlPclBL?=
 =?utf-8?B?bXIvSlRlWmg4Nmt1Vmt3QSt3L3A4dFVaYXF1UUYwMFIydER2Rzk5SVlNK2xX?=
 =?utf-8?B?R0JuZmxTUlhabHpHeitwb3ZPZDFDZ01ML1dKVEUreElObWpSMGxDNi96cDVE?=
 =?utf-8?B?ZWthZWU0T3pWdVBqZlY5VFJzSG9RWk1Ya0xZS2FWOVNWNDErY3MxMVNHM01G?=
 =?utf-8?B?Y0ZkVWlodVNmNzdBd09JZ3JtSjdjVE4yR29XSEhpUjdoTEJxdW9YanBNU083?=
 =?utf-8?B?aHBCeFRxZW56ZVF4T2hFYjF6YnlIWmNxUnphR1FDajNGNFNYRDdmRkU4Rm40?=
 =?utf-8?B?UDUxYTFVcFRrMTM1Q0pnOEhpMm90dTRBNWpUUFJ2MDE0RVlXeDVKWmdjY3B6?=
 =?utf-8?B?KytIb1NLMDBUNDZHWjlmOUJwUVJDYTl0ekwrRVBCL3JxOXZvNjVLcXRTd25i?=
 =?utf-8?B?UW0rRXNOZWhvZzMyZWZBODJmaUNEOHpMaG85alp1aWtNY3luRmpRM05XQkFh?=
 =?utf-8?B?eDMzbEdxTTZGczE4bndpTVdLU0hTaHZtNFJFZzcwaXI1YStVSlNEdDhpcktB?=
 =?utf-8?B?SU03UHRZY1dMUG5DVFN5SUlmRFpWM09aZUM3dnc1SnE2UHZHUjlPMTU2eXZm?=
 =?utf-8?B?emE4U0dPS245bWN5Q0prQ0xraEZvb1BIT21yVEs2K1hjRVo0Q3Zaa3pRR3JH?=
 =?utf-8?Q?aOx+vVHvIlCMSzjsAr6JllcSybf4uSvDO4amXHG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df2eb10-8b73-4356-aa7b-08d9158d545d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 21:31:40.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xD8Gb3ta1/BccWMER8WjasyJaVasiveG+ZJ3vIXvY3cIw1tVjxDfZzqxwXtoD3YFYbFm0dkNDZJWcLVWVvnjxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120139
X-Proofpoint-ORIG-GUID: JWrHHwusr2PEf-Gvfu1J61_znPE9JHEU
X-Proofpoint-GUID: JWrHHwusr2PEf-Gvfu1J61_znPE9JHEU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 1:14 PM, Peter Xu wrote:
> On Wed, May 12, 2021 at 12:42:32PM -0700, Mina Almasry wrote:
>>>>> @@ -4868,30 +4869,39 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>>>> +       WARN_ON(*pagep);
>>>>
>>>> I don't think this warning works, because we do set *pagep, in the
>>>> copy_huge_page_from_user failure case. In that case, the following
>>>> happens:
>>>>
>>>> 1. We set *pagep, and return immediately.
>>>> 2. Our caller notices this particular error, drops mmap_lock, and then
>>>> calls us again with *pagep set.
>>>>
>>>> In this path, we're supposed to just re-use this existing *pagep
>>>> instead of allocating a second new page.
>>>>
>>>> I think this also means we need to keep the "else" case where *pagep
>>>> is set below.
>>>>
>>>
>>> +1 to Peter's comment.
>>>

Apologies to Axel (and Peter) as that comment was from Axel.

>>
>> Gah, sorry about that. I'll fix in v2.
> 
> I have a question regarding v1: how do you guarantee huge_add_to_page_cache()
> won't fail again even if checked before page alloc?  Say, what if the page
> cache got inserted after hugetlbfs_pagecache_present() (which is newly added in
> your v1) but before huge_add_to_page_cache()?

In the caller (__mcopy_atomic_hugetlb) we obtain the hugetlb fault mutex
before calling this routine.  This should prevent changes to the cache
while in the routine.

However, things get complicated in the case where copy_huge_page_from_user
fails.  In this case, we will return to the caller which will drop mmap_lock
and the hugetlb fault mutex before doing the copy.  After dropping the
mutex, someone could populate the cache.  This would result in the same
situation where two reserves are 'temporarily' consumed for the same
mapping offset.  By the time we get to the second call to
hugetlb_mcopy_atomic_pte where the previously allocated page is passed
in, it is too late.

-- 
Mike Kravetz
