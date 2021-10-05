Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3955A422E98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhJERAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:00:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5494 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233961AbhJERAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:00:45 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Gs5bL029416;
        Tue, 5 Oct 2021 16:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kmqRtGRi5bfFy49TkYw2HkfDdBNO0rH5fwa9wt80ITY=;
 b=A9U/oTfeL4VbqdPsT+kg4RC3R6lGflVinb8BLQJz4esa4YM+Es0LrcEFYrUBOilJXEQt
 nOqFO0UDEQinqOKq+boyj84latw51KfrprL+W2BTIgQjxkTB/VGVY4bsvNr7VywEraJ3
 eJkUskuAV2g2RYTt4AJUUucvNYF9YclRydpga6XaGsIDEXKobxQepewseovfHDuK1ZHZ
 TGOOLzIKsnwzFp+KBcqofhrTaW+BddfFVxQSrnSi82EEsLKwiBIEsfxVhuhI17LKNurM
 GuFgjQPS6BsimO1bMGr6iiI939uyheHDk53Hk6I2ZqGAc/r2YD+etViGqv67FimRdNln mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42ksaf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 16:58:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195GoKZj124105;
        Tue, 5 Oct 2021 16:58:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 3bev8x1a30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 16:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLT09gcpiz38MJGkLAUfI2YtV98T2buqkAOShWzs60Fx5vvSEldYO5IBZ513fiCpMCdm4ey4H+tBXesoFJAD6n37yQSL+rDOpWfG+wnLquITyIzWsDw7CSWtd3m3onU7Fa2UFr/ODCPHNIGvOHw/LLv9dwLo8atE8h5WsUNIsF2Jcp6PeYucR/0sTEfv5Kdh6vDr4cOQyvT+hqAArKFTczXIvCbtoYHJHcptSpKy+DC2RI/rTxZDFDE0vsbfrmE3WaCWfAyHLP59Iv4SdGRZcOtXevx1duhi8hbga3Kk6Scdv2y0fBJ4jiUgxlNSSPtlCub3b+Y08EYyYRBLV1639w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmqRtGRi5bfFy49TkYw2HkfDdBNO0rH5fwa9wt80ITY=;
 b=b3x35bBmWHAekeWVagceRJ68dXjGCHmHcTzp3qqWiYG97EKILDnp4bstgVL1ijTb94w5gEKETOPKMoiboB2LntxFMevG3ordU/j6p2bchM7sQjuM6J0SozeNsdtochVvUxakSiJ51B7gel0sJxT+TfO8vDKS0rDdRLkhjyd7bWWm7+8B6y9AEu0OE4UjpTvRh6NPUD2hwKohSXAJjzzXvfFSKcANXh/yrWdezbnngJeZvj5datETubO9Pe1+aLk6nt3+vCfeo8cT+cmFWASZFQlp05AMx7z4unexIJ6+o4v5oepLBjV7bq6nJDAUqah0pAQMIb7QJdK/zi3GvEgdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmqRtGRi5bfFy49TkYw2HkfDdBNO0rH5fwa9wt80ITY=;
 b=SvAJZ7oRnFwZx6dIK9/m7wdcSint7IwRDxiqKNvV/u64/537ElWiQeekP88ciooyczOU7+uYgf+UE6UQk8rMlxA/CVH0XMY3OZO9tYVMjXRdJb37XyVf1d+b3iR4ujmWSx/BA/ihfOtf4t3VOdW5hWBTg6XQZXvvPsYmx6bzLsA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3638.namprd10.prod.outlook.com (2603:10b6:a03:125::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 16:58:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 16:58:13 +0000
Subject: Re: [PATCH v3 1/5] hugetlb: add demote hugetlb page sysfs interfaces
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-2-mike.kravetz@oracle.com>
 <04e66e73b17c367d3f4b2b40e0cd7e17@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <baa16521-baea-ef6d-f7d9-5ff99d3d0027@oracle.com>
Date:   Tue, 5 Oct 2021 09:58:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <04e66e73b17c367d3f4b2b40e0cd7e17@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend Transport; Tue, 5 Oct 2021 16:58:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8d6bfba-7bc9-49d7-00b8-08d988215141
X-MS-TrafficTypeDiagnostic: BYAPR10MB3638:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3638B5543C90D22D42969138E2AF9@BYAPR10MB3638.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWImLxhl8pbrJEJhTIcpRG60Tu0wRwVsYoImjJDhTt9NtUhxvLgIddqpS8FP/hhObY3w+24tdmMGfi/UCFPaMbXoyBuanEHEVqqbybzniZ4hLUeAzuli5L2RMNPKTYts3vZWemEvDKT2uArYcfmohhvtHKRBCPnN8qKuD0jbfbEHAvK3HF8YNhn0IgQ5JuQljtkhfj0l82ovZC1XzQLsNz9yf+J0mm4HaNH68ri52A9meZyS6veJlHAephUS6bbORk0nRUEiM5gpCJM0cpNjnbFWrd4e4C6GRghRPgyXsRl0/AZ7vcuOhU4sLCKvfLF6QQARmFZpMXzh6pucMGPxNLE2SU5zYL9AMU1CFHCOI4jy/k3iqCrLNQVKuClJ8f0QOJmwH5Qs+kUo7OEs3mCRUF8h/bapW443B3L4+ZDAc+5xhnUNf03Xkp+GXnFMHDtvg63G4jKN4U6PeyMFEmEWiBsXOTjQmtEwheYWDpOgtNF73wCJ0WP6cyCzZQ5gWxr/zkkbX5xB7fWcKpv2SMU6rRzymOsIb2WsTT8Dab68tQsaZbODMDdSLejQ8IgBnk/CrhsYxGJVjikWses0ZiZU92pyt78LWzDoUnqjTGjAwRVkp3ZlKrfK8Rle5x2yD5rgL1hRXsyumuc/34m14a738jT1Xt0rQ8hJEYp9Xh8G6IBbBtutLe6w/4wKNIBrdhNN13hZCFPkQDIYM1QgXCCZ9WCx+OP+LaF39pxpwRC1m0d4MEeONFnR3YdmurhtHhuKBXEQ/PsOhcgKDI0zDPJzEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(66476007)(66556008)(6666004)(66946007)(5660300002)(44832011)(86362001)(508600001)(53546011)(26005)(2616005)(7416002)(956004)(186003)(83380400001)(38350700002)(36756003)(2906002)(52116002)(38100700002)(6916009)(4326008)(6486002)(31686004)(54906003)(16576012)(8676002)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm9ZT2g2WHJJbDZ6UFZrUGFGWHR4S3dINktQRWZ3R205UFhMRHpMdTRGaHNQ?=
 =?utf-8?B?QmZrZ2NMaXQ1aS9CaUF6cElENDQ3MTlaN0dsY1BLcXYvY2xabWRUZW1jSkMz?=
 =?utf-8?B?NGh2TEZrZy9PdkI5dnRacCtHYitHVnhQb0xQeGk3UTFCem1pTjFxemcxT3NM?=
 =?utf-8?B?RTlQZ09lV0ZmZ1ZOSjA1NlVRQW8wUDlCU3VxNkY4d0ZJemM4dldjWTlMbW9o?=
 =?utf-8?B?VjVvenJRSEFuVXI0RjFXS205SkVTMnFXcVYweDF0ck16SC9QR0JoYm1NQTdY?=
 =?utf-8?B?NE5GcHJOdzBSZ2p4d25iMXdOdzQ5N3pOOUQ0TzVmbmVxTDNtSlp1VlRnVmRH?=
 =?utf-8?B?Tko5N3pNVHdCM1BYcGtoRDY2a3FlenJBRCs2Qk5Pd2tzLzY4OTRrbkFHc2V4?=
 =?utf-8?B?RkJKSDAvc1lMcUJUMDRjUkpYcVRCYnBUYTBZUzMvaDcvZjFMSmQ2VWhVWEtZ?=
 =?utf-8?B?eDMyOGE1N0NlaTlWNmoyanBGNG5BMW01NlEvNXZtRHNrSlAxR3JueVVCdnB0?=
 =?utf-8?B?ZStPQkV5RFVIdExObXl6cTV2NzY5QmtxOGNiZW9nQkYyU1NPckNtejhRVEd5?=
 =?utf-8?B?L3laM051WTVXQi9DdW5icXluNStydnBrdC9xWGowc0JZMVZlWDBJVDNhZW9s?=
 =?utf-8?B?ODZzN2ROMDNSanJlTGh6R2VPZnBtbkplUngzWWFsQWlXTDVjN1VISm1KUllz?=
 =?utf-8?B?VjB6YndHN2hIRnJlMHBsQ3pUVmowL1VtZnJXaUh1K0VsQzBkOXk3S05ydDJn?=
 =?utf-8?B?N3JtVzVUWmVHK3hDVUUxRmNKalBmb3BsUW1YQlVycmlnTUtidzliWUJuZ085?=
 =?utf-8?B?WU02UFdUaC9kOTBiY25zd21pWmo4VWg4YkJqZDY5VnFjRStmNjFvYXZnbXU5?=
 =?utf-8?B?TzQrWE1vL25HWk8vTVpLc0RBZUQyaTFXcnNsazk0UGt1aHkySVJuWEFCM05D?=
 =?utf-8?B?bmYwWGd1YjlQbTlUWi9qS09tWDJwbHRsL0lOaGZ6TTQ3N09jZ1ZUSm9LYi9k?=
 =?utf-8?B?a2hlTTgwclRUT2dQNzQrcmdBbnZYVGJoaXp4OGRXcVIybDFPZldyZzNNNUkz?=
 =?utf-8?B?ckVFN3I4c2R2T3owTWVEcTBHZ0NTVDhudzlDc0ZtYnFiTmtySzRMY25wUDJG?=
 =?utf-8?B?YVY4THhDYzFDYitBcWtDQWpIR3QxWHhqRkwzZjdKUnZOTXNjNHY1ajIyOTZJ?=
 =?utf-8?B?TXZQZzEvVWZuU0EwYktQOUhEek5jMStaSG1Zc1N5VDc3ZmFTK2tKQ1JHSHU3?=
 =?utf-8?B?Z3Z1S2pMVk1Jd0lnd2tyZW1QSUhWbzI2aEJXTlgrWXUwSjlsRlcxZXIwWUx3?=
 =?utf-8?B?V3IrM2hTemVra1MzU05TK3ZvM1FGdy8vSlNVL1VUR0xJNnovVFZBcG5Wb1RZ?=
 =?utf-8?B?WXI5QjgvZW1mb0IxZThpcmdRTjVFNGNJdlJ4eUhEMjRhL2VTL3hlanhWdXJ1?=
 =?utf-8?B?MW8yYVIvSFRxSWZxWWt1MVRjSWFlVWJnNUJJYkhxVHBhTklkMXduL2t6djlU?=
 =?utf-8?B?QTB1ZFFiNldocGh4UFh5WjhtUUR4alJ6dmpkSElyL2lVV2pVNC84V1N4Mzkw?=
 =?utf-8?B?dDNmczZ6aHhyaWp4YnM4by9Vbm5NSVVJVUdNUGdCaWpGWUhVWGJYamNpRDZN?=
 =?utf-8?B?cGpyNi9ZZGpLRE5kUWV3Y25TdkJyNEdSbER2NWJYRVliZ3BoRlNTaG5lRGRQ?=
 =?utf-8?B?TG5mTG9EQkpYMS9vUmhsUjlHdG04SnlFcTMramNTYVc5T1BIN2ExNXFISG1Y?=
 =?utf-8?Q?1o2+SvOgiOXXXCf/fn1+z2k3oK3zo+W95e4h0VY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d6bfba-7bc9-49d7-00b8-08d988215141
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 16:58:13.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0XzTQFu1mfMIsP0B3vSm3qSM0Yl9zuWG1XXS+mebPraG0cNT63SscqwJFJVZfDl9TPKTbsWlTuwutduqeehsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3638
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050101
X-Proofpoint-GUID: 1Qw-cOvKEpDuSI18MbEVg-0UYOanfWm0
X-Proofpoint-ORIG-GUID: 1Qw-cOvKEpDuSI18MbEVg-0UYOanfWm0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 1:23 AM, Oscar Salvador wrote:
> On 2021-10-01 19:52, Mike Kravetz wrote:
>> +static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>> +    __must_hold(&hugetlb_lock)
>> +{
>> +    int rc = 0;
>> +
>> +    lockdep_assert_held(&hugetlb_lock);
>> +
>> +    /* We should never get here if no demote order */
>> +    if (!h->demote_order)
>> +        return rc;
> 
> Probably add a warning here? If we should never reach this but we do, then
> something got screwed along the way and we might want to know.
> 

Sure.  I thought about just dropping this check.  However, getting here
with !h->demote_order implies there was an issue in the setup of sysfs
files.  That is not directly in the 'call path', so a check is helpful.

I will add a warning.

>> +static ssize_t demote_store(struct kobject *kobj,
>> +           struct kobj_attribute *attr, const char *buf, size_t len)
>> +{
>> +    unsigned long nr_demote;
>> +    unsigned long nr_available;
>> +    nodemask_t nodes_allowed, *n_mask;
>> +    struct hstate *h;
>> +    int err;
>> +    int nid;
>> +
>> +    err = kstrtoul(buf, 10, &nr_demote);
>> +    if (err)
>> +        return err;
>> +    h = kobj_to_hstate(kobj, &nid);
>> +
>> +    /* Synchronize with other sysfs operations modifying huge pages */
>> +    mutex_lock(&h->resize_lock);
>> +
>> +    spin_lock_irq(&hugetlb_lock);
>> +    if (nid != NUMA_NO_NODE) {
>> +        init_nodemask_of_node(&nodes_allowed, nid);
>> +        n_mask = &nodes_allowed;
>> +    } else {
>> +        n_mask = &node_states[N_MEMORY];
>> +    }
> 
> Cannot the n_mask dance be outside the locks? That does not need to be protected, right?
> 

Yes it can.   I will move outside.

>> +
>> +    while (nr_demote) {
>> +        /*
>> +         * Check for available pages to demote each time thorough the
>> +         * loop as demote_pool_huge_page will drop hugetlb_lock.
>> +         *
>> +         * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
>> +         * but will when full demote functionality is added in a later
>> +         * patch.
>> +         */
>> +        if (nid != NUMA_NO_NODE)
>> +            nr_available = h->free_huge_pages_node[nid];
>> +        else
>> +            nr_available = h->free_huge_pages;
>> +        nr_available -= h->resv_huge_pages;
>> +        if (!nr_available)
>> +            break;
>> +
>> +        if (!demote_pool_huge_page(h, n_mask))
>> +            break;
> 
> Is it possible that when demote_pool_huge_page() drops the lock,
> h->resv_huge_pages change? Or that can only happen under h->resize_lock?
> 

Yes, it can change.  That is why the calculations are done each time
through the loop with the lock held.

Should we be worried about compiler optimizations that may not read the
value each time through the loop?

>> +
>> +        nr_demote--;
>> +    }
>> +
>> +    spin_unlock_irq(&hugetlb_lock);
>> +    mutex_unlock(&h->resize_lock);
>> +
>> +    return len;
>> +}
>> +HSTATE_ATTR_WO(demote);
>> +
>> +static ssize_t demote_size_show(struct kobject *kobj,
>> +                    struct kobj_attribute *attr, char *buf)
>> +{
>> +    struct hstate *h;
>> +    unsigned long demote_size;
>> +    int nid;
>> +
>> +    h = kobj_to_hstate(kobj, &nid);
>> +    demote_size = h->demote_order;
> 
> This has already been pointed out.
> 

Yes.

>> +
>> +    return sysfs_emit(buf, "%lukB\n",
>> +            (unsigned long)(PAGE_SIZE << h->demote_order) / SZ_1K);
>> +}
>> +
>> +static ssize_t demote_size_store(struct kobject *kobj,
>> +                    struct kobj_attribute *attr,
>> +                    const char *buf, size_t count)
>> +{
>> +    struct hstate *h, *t_hstate;
>> +    unsigned long demote_size;
>> +    unsigned int demote_order;
>> +    int nid;
> 
> This is just a nit-pick, but what is t_hstate? demote_hstate might be more descriptive.
> 

temporary_hstate.  I agree that demote_hstate would be more descriptive.

>> +
>> +    demote_size = (unsigned long)memparse(buf, NULL);
>> +
>> +    t_hstate = size_to_hstate(demote_size);
>> +    if (!t_hstate)
>> +        return -EINVAL;
>> +    demote_order = t_hstate->order;
>> +
>> +    /* demote order must be smaller hstate order */
> 
> "must be smaller than"
> 

Will change.

Thanks for the suggestions!
-- 
Mike Kravetz
