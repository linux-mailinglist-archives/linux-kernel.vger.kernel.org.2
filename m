Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602854167D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhIWWKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:10:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45056 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232145AbhIWWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:09:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NLYL7Y005808;
        Thu, 23 Sep 2021 22:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J+Yll8uW5Oe5Cd3g9s8y7BOy7Gjak9C8PGLji0reSZs=;
 b=medY5x3vSd8ioN8rnhUwOWkXDwnCv3nKaUC0X8WLkIqgcciwOtxSOgK4wrBpNqhhSXt+
 Ju6IqK55FoNDRpppzIqWg1OBsNPnXINmdcirvC1FxmQLgtlUN7Z0Wj0I2m9rYt93UGUB
 AUHXsdZNre0uyo/ahIunLDYXHyltZ2e5CbvcDXcaXwwNC3SbklJqDiPptgKnL2k8jaLg
 EWwx2CyzKx8xbvc6D+IqZLTn/cvvN73KFy3MiBcacNHwty3zBa2PwPIYDCTx+7dHLJdY
 JRKw1DACRQD/LD40Y835WbC3Vb/RTK4SuO3AjJYN3ti3TWfbBHbhUm4SxnPW07DRDFDv HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b91m384qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 22:08:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NLxdDV141784;
        Thu, 23 Sep 2021 22:08:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3b91n28xwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 22:08:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq6Gvry87PqYWzD6QFP3pvjB8JG//BeXRDnHxROii02TqllAjT1H1wEv2mM/a1AQw0rTUX41OJLqkL8uTPgRwRIIVv2vaY3iUVuGfvpvLEEWyMhrpZukXghMv+/pSFVROFouSsqK6ykDxxp9nzHapZOgANpzlQWGm8Fl4Wz36qTeVxB0Kmt0uQ+JhYbBT+t7II55EOChZQ/2nge14pyC20YfOv+DOXsIiK40trEfXs2v8pdQZkhGYkDsSAVjGaPIm/Ef5ZJovQc4vcFtHEL9kW2VLwUnURlj6mQUIQMWtfctlP1zGFYbv814VJ4SQs2YoluZL+rDSKgBBKPtWUNjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J+Yll8uW5Oe5Cd3g9s8y7BOy7Gjak9C8PGLji0reSZs=;
 b=IZ5RMGn5aSAeXuNTQYX1UjNN/yyGRip/H3C37C4kd7TOFz/PrlsOC0khoHbj0MQgciDMfSuUihMe9LjfQZ1pM7I50bVfuZeay7SXS8A14Txw0Cg/ubB6Wsu07+eTB2trVm9e2yrUxw2+DJdOTQqnTgSQjfGX+iJuY1PCr/1AnG2ldxF7q5RKzR6kv6gTFjkNx8vX45gBch3AduDoimctKBvBVjpWNdsV+ig/cma2GrCBRiNG4GXflP92NrK1mA/eoKBO3MsC8HjvRliGQxopKXG0qV6twbY+/eCkrmLI8HIWSrXUxM6tdVlVg9HnTSgksUN7t/DiOZ7Qsd7GPk1G+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+Yll8uW5Oe5Cd3g9s8y7BOy7Gjak9C8PGLji0reSZs=;
 b=LR8m4uKM3KCs8SZcZlf9MyBCUtEH4MXpj5RtP2iZnVHEGK02x6Wag6X7hzmz0yHX8Gm09b9Wg6Aj5D7uJw+hGS/ez1AJ/Mc8vgF3DF4xy7vZP4+LvgwPXs3gMh+LN5Ixlxvoayj4sh04IQXugSWMoEueqFwhydlXr+AlAJ8tS+c=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 22:08:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 22:08:08 +0000
Subject: Re: [PATCH v2 1/4] hugetlb: add demote hugetlb page sysfs interfaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-2-mike.kravetz@oracle.com>
 <20210923142426.8930bd1cfcabc782a2152c18@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fc27f1a8-6a53-e7a6-ec6c-e0c185912c1f@oracle.com>
Date:   Thu, 23 Sep 2021 15:08:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210923142426.8930bd1cfcabc782a2152c18@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:300:115::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR11CA0043.namprd11.prod.outlook.com (2603:10b6:300:115::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 22:08:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f0ae716-58c5-41be-a0a7-08d97ede9feb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2663B993F7D8DE74D421D524E2A39@BYAPR10MB2663.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CidbQIyDCTo8OHiw4pg/AJOCf9C7jaVZsemyrdVzGNo//nUzqfOA0jxWBTg4CejBiWo060Ewcj/LmRh2cVGWn1jlHWtJQAhTb6RL7s8FpyPtz4chDTRUHh79NBd/PLy7wwdY6OSNudZ/JsfL834L6d8AoHedVhp2LNZHM14zuhXvzAKxZZdc3RxSzrLs0y0pHTSucqvqOpWZo9MfezNUdjPvfQ7xzZzsBA/KAaRPapE8Xw34vS0xE8ZpSUkjDuBUxxXNy40ylFWatYvqNrbYTO9RuQI0t/Z1hfLCEK9r3ZKnqOMHgvvz1szkCc6Tgx2D3d7JAM5UBaZxQj9PTAcNVDYADbHR8L9uFuRhYTCHmCiPfq3M5ZsgTwhQY6K3QmRpcuDQzyAzInpbtCD/8dEhylFfi2SpFhLd8qSe4YDsRlpo3wXHXgymE1cYWLkEfbdrcAcnRDlMXVVaQnw1hxTL5QmUA1VOWkvqg/aUG/fc9LXMdtWsd4gHJU9Nxdx/ujh48e2ILmfK5kzFBJBo7CCFZDpB3QWyIt6jAOrSPGNpM1TChx/0CpszivLMhIU2C5ISotFQIg85vy+XtkxIHqCjlWiZ1e5WK5fFKULYbR0p05G39bWFlfdvRTDVHJo8fhwBdupn6fCp2CMdywK1R7rSiFhoOV4hvifFb9+cdFuqmch6+4snu+ANqNXyCsAsnh2oWxajkaGrXYvnwQeaO6mjn+l0xdXa57k2e6yOx0eJVfHHezEGxMRfMMRty7vsz/EACp9Z5Ay2Hez2yypPIK02iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(5660300002)(44832011)(2906002)(508600001)(4326008)(316002)(16576012)(6486002)(2616005)(8936002)(38350700002)(38100700002)(52116002)(86362001)(31696002)(54906003)(53546011)(83380400001)(186003)(66476007)(6916009)(31686004)(66556008)(8676002)(7416002)(26005)(956004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFtdUVsNTJyZExrbGFuZVRsUzdIc1gxSi9mdE1mRXdmTDJ4YjQxUUdKWkRY?=
 =?utf-8?B?WUxhbFNVVVZ0QnIvTEZ2cHhXWVlOR25JZXorSzFXaWp3YVovbkQwYnJVdzl6?=
 =?utf-8?B?U0xGQjA5cTgwTzJQS1dTNnNCSEIveW52Q3FOU0k1NUhQQ1k4WmFJK3RtSk1H?=
 =?utf-8?B?YlFpb1ZpNnAzRng0SnhsbXAzMFBTa3ZEbjF3eHh1cmUxSDBhZzVhaUhPc0pV?=
 =?utf-8?B?bUY4NTB4RG1ud1ZLbUtjZStlbkw2Q2ZmSEVyMnJ5TFAxeWpqMkx5NktOdnVD?=
 =?utf-8?B?RllmUnMySGdJczFQZ0Jsa0tRWDBFMHNWZzZpVTlzU1hlenlUSFRPOWJUR3BT?=
 =?utf-8?B?VzBsek5rRXVXNFU5bU95bitxb2JtS0l0aGRHU0NSK2RINlZEUmVTYStOT0l4?=
 =?utf-8?B?QVl0UWxDbXdsbFJsUStJa0xlSTlZWmNqTFhpZHlJR2xaVHhQL3kvNkhyUG56?=
 =?utf-8?B?Y2ZZNkRLc2tOcjVRclBGa0svUU1kZWdlTXNoalptQkJWUnA3WlVHSDVRaGY5?=
 =?utf-8?B?OFpXaGNGZkc1U3l4aWxKTXovbGkwMUlCUUk2bmVZRng3RCtpQXVHUmVDenV1?=
 =?utf-8?B?d3M0Q0JMNlZoV3V4SWtTZlg0ZHFPcXZwSDJOOEJDMmFuMERjMDNzNTZGUWt3?=
 =?utf-8?B?SjZhTEo3NC92N3NpRVBCTURkMFhaVDNhWEJuRVVCeVZZN0U5cEd3cVJ1WnVR?=
 =?utf-8?B?M2Z3d1Vra0RtdEdta01vNFR3WFk5Z21vZjMxRDFnMUx6bFRreUFUUDZpbEps?=
 =?utf-8?B?OGx5dWtlb0liYVc3b0NITWxjcTIzNTE1TGRKeGlnZEI4TTB4ekNlYjQ3eDlm?=
 =?utf-8?B?TWpndUdibTBLVDAwUTFHd2paN2I5d3oyOTIra3lYakJ4aDd6NVdnMm5VTkhT?=
 =?utf-8?B?d3hCRk9yRlY3djRpZ1p5UWJLcXQyZk5JMGxPcU9HWHA3Mk9OWHVuYXgvL0ox?=
 =?utf-8?B?cFpFVXAyTmxzNUYvSEh2RnErM0NFa3RLRXJsYzhHUE15QkRCV3dJU1VZZ01v?=
 =?utf-8?B?T0ZZc041MUlWeHNQUTdaTXkvR25UTFJOOFFwY0k4c3VqeERUMWNOQU4rdk8y?=
 =?utf-8?B?a0pxYkszMXpYMTcvVHlSdlJmRDFZbU9lVUNxSkxPZmdoaHZXRDlrckNCeE5N?=
 =?utf-8?B?VHRqQXh1ZXNlYW95ZmpkR2hRRXNWRFV5TGRxaHEyc3loYVNTV2FNcTNFejBr?=
 =?utf-8?B?bzByM09VV3V4cWFtOWM4eWM5ZHQwQXR5R0U5TVp6MWQrTTc3U2RGcklNU21q?=
 =?utf-8?B?UUdsRWRobGxMekRWajhIOC9FcW95V1RQRHNOMDB5MmtUdWxiSXIwRnByY3dE?=
 =?utf-8?B?NGVTUHZUYVpXaVd6Nzg4RUEzNENYcmkwNmxHak00ZXBQelVHMjRXWncxYkMz?=
 =?utf-8?B?TUg0N2NjS243QWdaUHNHNFJVQkNtOXEwOUlxQWtOYkVrdnozaUIvNUsxZER4?=
 =?utf-8?B?ZlA2djlsTjBydnlxN1U4VEE4N2Q1NzJsZVBRZWdnQkV6SSsvQjR2R0ZHclk4?=
 =?utf-8?B?RTh5MGVhNG1GMkFKelg2MW1SQVROc1lxekxINktGZ2VJVDI0OEJwR2o1MHV3?=
 =?utf-8?B?UlByWFREcStDVkFXeExQbzR6eE9ZRmp3ZWdLaEhVb0NTWU5ZWkZkNTBDMTJQ?=
 =?utf-8?B?RkVKR0syQmNwL0t0SGNTV1VaZFNJMWZRZk8xOERjTFRkU001VUNUdGxtWFB2?=
 =?utf-8?B?bklmaUdOSTgrb1NYa2R4d1B4a05ZTFBUc3lHZ2tTSXpDN0poMjVjbXkwS0Uz?=
 =?utf-8?Q?Wy9p8dzo19OhiWxlahAWAIQJ6ojl71J2m7D77fx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0ae716-58c5-41be-a0a7-08d97ede9feb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 22:08:08.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBVjniNHrou/i79zmny8Zqhh8lCY3JDbsXW6SHlzQtFfe0aBrayVQ5F2ytsj5Af1ZVeP5S4CIFjdwuWclpmdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2663
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230000
 definitions=main-2109230128
X-Proofpoint-ORIG-GUID: t14OQGncLn7-1c8oGMlNHi9CbkHvcziy
X-Proofpoint-GUID: t14OQGncLn7-1c8oGMlNHi9CbkHvcziy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 2:24 PM, Andrew Morton wrote:
> On Thu, 23 Sep 2021 10:53:44 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> Two new sysfs files are added to demote hugtlb pages.  These files are
>> both per-hugetlb page size and per node.  Files are:
>>   demote_size - The size in Kb that pages are demoted to. (read-write)
>>   demote - The number of huge pages to demote. (write-only)
>>
>> By default, demote_size is the next smallest huge page size.  Valid huge
>> page sizes less than huge page size may be written to this file.  When
>> huge pages are demoted, they are demoted to this size.
>>
>> Writing a value to demote will result in an attempt to demote that
>> number of hugetlb pages to an appropriate number of demote_size pages.
>>
>> NOTE: Demote interfaces are only provided for huge page sizes if there
>> is a smaller target demote huge page size.  For example, on x86 1GB huge
>> pages will have demote interfaces.  2MB huge pages will not have demote
>> interfaces.
>>
>> This patch does not provide full demote functionality.  It only provides
>> the sysfs interfaces.
>>
>> It also provides documentation for the new interfaces.
>>
>> ...
>>
>> +static ssize_t demote_store(struct kobject *kobj,
>> +	       struct kobj_attribute *attr, const char *buf, size_t len)
>> +{
>> +	unsigned long nr_demote;
>> +	unsigned long nr_available;
>> +	nodemask_t nodes_allowed, *n_mask;
>> +	struct hstate *h;
>> +	int err;
>> +	int nid;
>> +
>> +	err = kstrtoul(buf, 10, &nr_demote);
>> +	if (err)
>> +		return err;
>> +	h = kobj_to_hstate(kobj, &nid);
>> +
>> +	/* Synchronize with other sysfs operations modifying huge pages */
>> +	mutex_lock(&h->resize_lock);
>> +
>> +	spin_lock_irq(&hugetlb_lock);
>> +	if (nid != NUMA_NO_NODE) {
>> +		nr_available = h->free_huge_pages_node[nid];
>> +		init_nodemask_of_node(&nodes_allowed, nid);
>> +		n_mask = &nodes_allowed;
>> +	} else {
>> +		nr_available = h->free_huge_pages;
>> +		n_mask = &node_states[N_MEMORY];
>> +	}
>> +	nr_available -= h->resv_huge_pages;
>> +	if (nr_available <= 0)
>> +		goto out;
>> +	nr_demote = min(nr_available, nr_demote);
>> +
>> +	while (nr_demote) {
>> +		if (!demote_pool_huge_page(h, n_mask))
>> +			break;
>> +
>> +		/*
>> +		 * We may have dropped the lock in the routines to
>> +		 * demote/free a page.  Recompute nr_demote as counts could
>> +		 * have changed and we want to make sure we do not demote
>> +		 * a reserved huge page.
>> +		 */
> 
> This comment doesn't become true until patch #4, and is a bit confusing
> in patch #1.  Also, saying "the lock" is far less helpful than saying
> "hugetlb_lock"!

Right.  That is the result of slicing and dicing working code to create
individual patches.  Sorry.  I will correct.

The comment is also not 100% accurate.  demote_pool_huge_page will
always drop hugetlb_lock except in the quick error case which is not
really interesting.  This helps answer your next question.

> 
> 
>> +		nr_demote--;
>> +		if (nid != NUMA_NO_NODE)
>> +			nr_available = h->free_huge_pages_node[nid];
>> +		else
>> +			nr_available = h->free_huge_pages;
>> +		nr_available -= h->resv_huge_pages;
>> +		if (nr_available <= 0)
>> +			nr_demote = 0;
>> +		else
>> +			nr_demote = min(nr_available, nr_demote);
>> +	}
>> +
>> +out:
>> +	spin_unlock_irq(&hugetlb_lock);
> 
> How long can we spend with IRQs disabled here (after patch #4!)?

Not very long.  We will drop the lock on page demote.  This is because
we need to potentially allocate vmemmap pages.  We will actually go
through quite a few acquire/drop lock cycles for each demoted page.
Something like:
	dequeue page to be demoted
	drop lock
	potentially allocate vmemmap pages
	for each page of demoted size
		prep page
		acquire lock
		enqueue page to new pool
		drop lock
	reacquire lock

This is 'no worse' than the lock cycling that happens with existing pool
adjustment mechanisms such as "echo > nr_hugepages".

The updated comment will point out that there is little need to worry
about lock hold/irq disable time.
-- 
Mike Kravetz

>> +	mutex_unlock(&h->resize_lock);
>> +
>> +	return len;
>> +}
>> +HSTATE_ATTR_WO(demote);
>> +
> 
