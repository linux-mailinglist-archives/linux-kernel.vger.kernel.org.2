Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A612634DE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhC3CTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:19:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhC3CT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:19:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U2ACS0071890;
        Tue, 30 Mar 2021 02:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6rIBSCTFldq0aErNmhecRDdgwwGrysvUa65M9dgnhHM=;
 b=KVhcDvfBG+33qFkWBTmLD9+BIpIb9oA1StediG2/JddvOxBwO0ID+JSkHaE1hKnEr1la
 suSY0pvOROkPq2X0lzG335Io/XS/CDnK+I+kPelwWIGI8O6QVb+n93a3F6rDkIYwOSZa
 APCwKo9HTM2JnJHG8t5VTN6RLRgEFKmHmNElGomBMsq85Cu/SonVmz6E1NgOm1W0Or2w
 C6YuX66qo7+uc+DwYkLZfcHgzvR8flSlViGPiUKFd5bWeW2M+cdfGJcFT2cxIRnSjers
 X6XQcWNYLYsc2QtaxhDg2cbP5CHs9XcHbfBc9iVn+DIv5OTbaUxlwY0PrPUs7g0eKA6e 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37hvnm5f51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 02:18:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U2AX6a006047;
        Tue, 30 Mar 2021 02:18:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 37jefrh75x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 02:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUmywRbmOssS5lZWP70Zmgk9Uw8wWnojdRGPI98MtCuSumpcA0TBwCq638LgUyKxUAB6FGzD0MVdcQKkEgpKvgRajUtFffTMT1g24fn1zpKMiwx+jJHYslZymCLuTDPw9cD7EtBl2LQOwYVwrucYj4I1ZO+LMZlVyS7zL0WPaoSDpjezHs6ss8us7JeSmWA9hIc5ZjvYQswMfo6w3stjSOOQnxvwMTnCmsGGqOG5yeZdE0+Ld+au0n6SRXpwNZxhc+Zgv6AhHYCl/IS1xYF/jXKYyS9p9JuHFHYAQrYHBpUyRsMRWXqgvgo/phRIx93EIJ1K73iYXCIrnc6U20fGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rIBSCTFldq0aErNmhecRDdgwwGrysvUa65M9dgnhHM=;
 b=jhVEIhQ5fecan5Ax47N5wshs1IzzD6ZPaKJDFMgfS3CK7lBvMGdeTJyuwGJgAejvhFj5MLXCz2PS9I+bg5HbEFfQPV1CfF7LnUhh7Cxe6c/KwGM5d7JBLX0NBAPnJnD2zifZEDfFRNiAoD6W4V5cJ5IeGeoc1n0ZolzVPgZGh2ic+LUzvNiXhGPQicGUZNlnSu/7jR8yUPr2wPvsT+5IQFuSj6XcvhRWuiGVRsvKAHrm2iJUi3cbPB6oX+BgNUUTUmlWXMRVd/+u9jZQWL41JUKvs5sWKPaAzlbKZ8fVQl9vInrIhMQuYx2MDtlmLa6EuMhYlpHtsjxTNBBkYSBEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rIBSCTFldq0aErNmhecRDdgwwGrysvUa65M9dgnhHM=;
 b=YmIJCdiyy/nUELclyOs8We7y/E2j1bJZLIalFM/VV0IU/mwzAwwAPmbwAuxMlGB2sKgYXs4QcMFVDW9kSmyWGPp9/82O3ev5jA4AcN207eITHem689HIBrTwGeXc3m/e5GWOahWydr5c8h0fe73A9/xHzW5PvrrN+TcbleUy/Ow=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2502.namprd10.prod.outlook.com (2603:10b6:a02:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 02:18:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 02:18:29 +0000
Subject: Re: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        linmiaohe <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com>
 <3de3a89983894cb79a0f25cf17e838f1@hisilicon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8af9088a-8baf-9ea9-8e01-a163652aa53a@oracle.com>
Date:   Mon, 29 Mar 2021 19:18:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <3de3a89983894cb79a0f25cf17e838f1@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Tue, 30 Mar 2021 02:18:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27e7b1a-6ea0-4a2b-23be-08d8f3221b77
X-MS-TrafficTypeDiagnostic: BYAPR10MB2502:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2502F5DF98A3A5071C984725E27D9@BYAPR10MB2502.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rw07XjpvNmilBDOAy3CRYcw7akzBPCGO77Lz36RdgFNUvjzkXxnWxfo381vS++RsH/nV1xgJR018ICsyH3XRJFiCYZmNQ4p26SsWftVibuDI0T/HC0c3MGyeRF5GwVGKC/RgpRC4AfsuIgcyJo4EkLRAnoUj/qMhgBjryVkIyESIoma/dFfyLKJjeJffyvTG438AiJDCwuqPDOmYwqHiWvu+JwvMtClH/VfHKnQiWDpNJT7+ygzSTNbiTtM8yHRINxQfUP1thCNBuT5cGSucTb72RDlT2xp6lORcvSdDT5Y4l8bRV4BM7q4pW2UXRE3LA1yJ2+//YPRIXF4PDp9PSJGdRkvH7/jt4pyfOEosLO3jcVEpDjP1NYwqp/wMW+tR5bUK2ctdf0zARTGu+NHPo/ncGoBXKQCKfsjXSuXou7shZB2vQDoNfWrpRjDv8s79o3ugHL0IX1Wobi4anO9Z1K+lk+p+NKRWiE03c+FTZl9XWH4pFqwK1wlqmRLUsIENZ//sejPHT/1eFAsl6KwLIx4B2HG+cdvQDV9KfylAB8EZFlS4HasndyBkDCCjDh9Oc1qeibSwl+psAW842RONk0XFS3XcTOEBIfuGCEs7fKZsXfnalM987OCYVRg4rasLxsU3/OupfjB+ZrntkurYtWxb5j6gFeOTOHfPy2encJabHiR414u4E6Ny8ET2q8V0fssqZTVQvqIooR53dsAv94d2FbLLJmEg971Sibs54mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(39860400002)(346002)(26005)(186003)(66946007)(956004)(478600001)(66476007)(66556008)(4326008)(16526019)(6486002)(7416002)(2616005)(8676002)(52116002)(5660300002)(110136005)(83380400001)(53546011)(36756003)(86362001)(38100700001)(44832011)(54906003)(2906002)(31686004)(16576012)(6666004)(31696002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bkJCV0VYcmpXaTVPMVFielY2MGN3NXB1TzlOalNDcXNjWjFYY2ZtS09YSk92?=
 =?utf-8?B?Q0VTQ2Z1TEZFVGtlRUNjU2ExTFZRRXdUcXZ2eTE2S1FqS01tV0Y5QW1jbXJO?=
 =?utf-8?B?dTNmaXhUQnVXMjNCQmtXQ0NmSVA4eU9iZnJxSnZ3MGVoL3NWWFRSQW5nYm5C?=
 =?utf-8?B?OG9OV2o2SkN3bFlSV25rVzlGRDl3cjNkWE8zZ21oUWNOcURjTUxZNXh5Y1Bq?=
 =?utf-8?B?cFV1RldZOHFMUnhVMGkyZXVNVVJVSk9WTkt6eUp0aG00YWt5TzFsRGZUek5a?=
 =?utf-8?B?N1dlR013UWFmYm9VSk4rcG1rVWJtMWg0YkpMZW4rUjQ0c3Y4UTJkK3BmMnFB?=
 =?utf-8?B?cmwvbzdlUHRpVUdCa2xVd21TTnlsbWF6RHBaVXRrWjBDbzJRSmZPb1Nqak5p?=
 =?utf-8?B?djVEZFJOZjN2NW9oUjRhV3JlUzB5WVB2Uyt0Z0ZNOEY0V2RnM1ZIQVJkOE1G?=
 =?utf-8?B?RXdqcWtzRTI3bXNBK2w4U3N4a1hUeVdLTUU0RVB1MUN0UEVYc2d4N0JWaXBj?=
 =?utf-8?B?dmF3aStnSTVNVVZ6elVvYlkwL0oxdlFjREZ1eXdPN0VTTXNLTmN1NmZDQWFx?=
 =?utf-8?B?cDhvT3ErWGpjN3pWckx2N2c3WFM0eDdGMG1yYWNKdU9ucUVqM1FTNGhlVnky?=
 =?utf-8?B?aWU3bEJybWhLNzFIc1UyYy9DSzd3Rm5aMGU0UmxJUkpudVcyeWpNaEY3VG9G?=
 =?utf-8?B?eXBpLy9TTGc5R2tlVkllUWZHYmFTNldLSTdlbisyUGZXN25XOEROcFRkZWk2?=
 =?utf-8?B?dlptN2xlZ2d4b1JlYXlncUFOUUxxRU02eFczcUZYb25YdThEeVNjd055VjZa?=
 =?utf-8?B?YTY5ajBHbkNZeDFHVDdMd094dnZYV0grNmhQM0ZWUFBVdVNqQ1hxc0NvWVdm?=
 =?utf-8?B?bjRvSkNFUWlRRlZXOEt0VjlIYVhjbmdYS0U0b0lnV25uaHMxNWN3d2phQXpy?=
 =?utf-8?B?UVNyMWZPZjRZK25DT0N5bFRESTNDVXI2ZEF2S1JtSjB2QW5SS0lVM2d2aUh4?=
 =?utf-8?B?T3pFdGc2NDJpbDNzUXFvTlIzK2lISjJjU0o4WEVQQXdvRVN2NVNwYWxCTGhQ?=
 =?utf-8?B?NEdVMWx2MDdKWXpDTGVOYXJaVjRPZHV5eGJmeFROVFVPZkhmTUNPWlFaU1Q0?=
 =?utf-8?B?OGNXd09CN0tYZXIvQWdWOGhQUUFhSnM3VjNVOThXS1V2azgyMkpWUFlqVW9Z?=
 =?utf-8?B?dDZkVmFzeWdLMTY2RmFaZG4wWjJyQXdqenMxcHJGL0tLSWJOS3NVTjcyb2dN?=
 =?utf-8?B?RlBndU90ZFduMzNlNnBKazhWWTJJWjZ5bmxrUmlWN2F6b0xkZWdjOTV3clJ6?=
 =?utf-8?B?eXlvb2x6QTg4SEVyTWkvTkxPNnVpVEtHUzBJdGdBSDBMbWRwUk5CT1NnWnR2?=
 =?utf-8?B?YUEvOWIxTTcyYmJqQk44V1RieGFBRW5lY240RWl2NEJraHFBYzM5amlMNEFh?=
 =?utf-8?B?OUJTN2xNNkxvd2FkME1ENnhxbDhENTJPdjRBSkt5WGZobDA5SFpLZHozQ0VM?=
 =?utf-8?B?QURNL242blZvanZIOTVEanN0U0N4dFRsdzl5YkZiZXVEcFJhVSs1SktDWUc4?=
 =?utf-8?B?bG1BWmZBRkRPZzhkZXZ3ZmlIY0hXSm5xN1lKOTEwbm9ZRnFIQzA3MkU2VDlZ?=
 =?utf-8?B?Q0NmdTVYazYxUlFYOHJaUFhHNTM3cTRVWXFITlR2ZkpkZUJMWUpIemt1Ymk2?=
 =?utf-8?B?ZnBqL3djZWtoY2VOdE9rSGo2QXkxTE5iNnFxQ01YWHk4dkY2MEZNVlhrY0dj?=
 =?utf-8?Q?M2sNhOwp1XH1hWeDuKdJvZg3iVFdrHkTkiUYuzs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27e7b1a-6ea0-4a2b-23be-08d8f3221b77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 02:18:29.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EM5iUf7+NTFr52mZkj+W5I3doK6ZZzVYBcqPjfQxj5a1GU49oA5fhqrr4X7y3sD1/m8JK7og6RcqVifdY91Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2502
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300014
X-Proofpoint-GUID: K03St7d4DyBZ5ZC2hxBM6VVr9lnzCAbq
X-Proofpoint-ORIG-GUID: K03St7d4DyBZ5ZC2hxBM6VVr9lnzCAbq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 6:20 PM, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Mike Kravetz [mailto:mike.kravetz@oracle.com]
>> Sent: Tuesday, March 30, 2021 12:24 PM
>> To: linux-mm@kvack.org; linux-kernel@vger.kernel.org
>> Cc: Roman Gushchin <guro@fb.com>; Michal Hocko <mhocko@suse.com>; Shakeel Butt
>> <shakeelb@google.com>; Oscar Salvador <osalvador@suse.de>; David Hildenbrand
>> <david@redhat.com>; Muchun Song <songmuchun@bytedance.com>; David Rientjes
>> <rientjes@google.com>; linmiaohe <linmiaohe@huawei.com>; Peter Zijlstra
>> <peterz@infradead.org>; Matthew Wilcox <willy@infradead.org>; HORIGUCHI NAOYA
>> <naoya.horiguchi@nec.com>; Aneesh Kumar K . V <aneesh.kumar@linux.ibm.com>;
>> Waiman Long <longman@redhat.com>; Peter Xu <peterx@redhat.com>; Mina Almasry
>> <almasrymina@google.com>; Hillf Danton <hdanton@sina.com>; Joonsoo Kim
>> <iamjoonsoo.kim@lge.com>; Song Bao Hua (Barry Song)
>> <song.bao.hua@hisilicon.com>; Will Deacon <will@kernel.org>; Andrew Morton
>> <akpm@linux-foundation.org>; Mike Kravetz <mike.kravetz@oracle.com>
>> Subject: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
>>
>> Ideally, cma_release could be called from any context.  However, that is
>> not possible because a mutex is used to protect the per-area bitmap.
>> Change the bitmap to an irq safe spinlock.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> It seems mutex_lock is locking some areas with bitmap operations which
> should be safe to atomic context.
> 
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

Thanks Barry,

Not sure if you saw questions from Michal in previous series?
There was some concern from Joonsoo in the past about lock hold time due
to bitmap scans.  You may have some insight into the typical size of CMA
areas on arm64.  I believe the calls to set up the areas specify one bit
per page.
-- 
Mike Kravetz
