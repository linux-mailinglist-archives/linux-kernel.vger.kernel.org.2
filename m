Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F381641CD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346751AbhI2U3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:29:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24488 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345611AbhI2U3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:29:50 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TKIQIn002873;
        Wed, 29 Sep 2021 20:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PChCaPG1yQY+1n6om9tVDtAuyTJNHfYEoW9AdC2am8M=;
 b=BSWZ9v3lMRRi0XueHAszXw/IP6Yy6JkSBo3bFVBQJ+nhSw29gkH3ItApyooq19JGawDY
 ptHEUYdgUk+kHuyn0/AC+uz6qg/wsSiOUZ5uRveeV7my5y+18bvXQ0qvxbyHDuAIoptF
 sK3lTVbz9B1flRIRU+kdiH8cFBzMce3/3kZWwYnPR/8DBmx043/dn+cFQNyDuDYpkQqr
 MnHjdssIEzbTE0sfrYwNcCUpmOZLwxpTUSelgVk+dfoaB/rv3Rlg8hd6NmbdzTXhqkQ8
 tuRQ6SzXnzh8W5Pgqipi/vOXEeZ/Usv7WHoLDodHBRgej77Zs8uvCbAwp6d6v1cnOJUV /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6cxtv4-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 20:27:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TJp6jD061854;
        Wed, 29 Sep 2021 19:54:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 3bc4k9twa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 19:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DClOWU7ud8SNMFlEvz/UEzkm7m1BpxQGHH6p6iAVFyjr9TVCEw+QjTNYKVQjDON8dZqPPRyEi10kKYYgcI5ZhHmVVkM1BP/TeQWXs+Ij1TsNjZtLWGYhGAil/FHthcJO6XqIHtk2iRmya469iElXE+mbgIOsHr2DCqnkWK6B6/uMD29ihBkDl40/7nUyqp8YuUOK3hY8bX1PYz0OtMRWoVTMG7IMWNpCNictbluTHb4ieKKgukPDWL2h630FvM8bXr+ojrrArKCOZbvJiJ0gu2/8FfDLQJ5td5dhvHQ6MQ1Fi2allfQt642VnMbtJ14WYrNuFPkf7mREdERiVajBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PChCaPG1yQY+1n6om9tVDtAuyTJNHfYEoW9AdC2am8M=;
 b=LWaZjfjuNP3z5IHLTXSj+TBQ7dzANZTq24dE92Ycs1ke1r+CiG0IwzTMKsZNmiI6HurqwyewbVKjUi1iSs1rbM2LGrGWihyZNDrGAsDhYsGs6CVR1+npAS90bKgSItYXR4xHJfCzDjc3VOxmPUnbA0i/qAkfbnrb/unwUevTpVX674+U5dPCvs5BDnW5RUXtV1/J5QKXhq7MWGVQF/UrxO6n8ORm/Mk6TIePn8XwS/nZkeY0PwYbKollwJU3Q3mLto/pBRVSf615oUj8obci1O6EFUKLk84o7lQ86jWnxaNNNOy3cL7vM8UyiB2KI4cKQVeLGPFbXog+EbUJiC6+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PChCaPG1yQY+1n6om9tVDtAuyTJNHfYEoW9AdC2am8M=;
 b=h/VCo7BUUdWYLG5CMVlNWZ1hdBDTlEEwJwk8nQz0ZJiMX2cC3NbnJ4D2MSFRZMfz6U1vsK2cOtqCUfoPXHy5IXexuL9U+UHOW7uGkdu0tCNLZltqjJHyErIRsn/O0tJeFN1WzfQA9Ei27fgC2DY4ZL6lH9+OKlqHrKFAAbIitcY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3733.namprd10.prod.outlook.com (2603:10b6:a03:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 19:54:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 19:54:54 +0000
Subject: Re: [PATCH v2 4/4] hugetlb: add hugetlb demote page support
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-5-mike.kravetz@oracle.com>
 <9f469308-3c1c-dd9e-2c47-fcbd26b197df@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <934f429d-e056-7142-4be6-e00d22a4e389@oracle.com>
Date:   Wed, 29 Sep 2021 12:54:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <9f469308-3c1c-dd9e-2c47-fcbd26b197df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0069.namprd21.prod.outlook.com
 (2603:10b6:300:db::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR21CA0069.namprd21.prod.outlook.com (2603:10b6:300:db::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.1 via Frontend Transport; Wed, 29 Sep 2021 19:54:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83bb8515-34d5-4d24-a951-08d98383015d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3733:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3733D19C7B03B98B199E4A5BE2A99@BYAPR10MB3733.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePR3b1D9NCj9eEm+FH4TYcFofyDdoQW+R/bjFWtEi+tCsFg6uW6bZQcST7R8NPuexfUzE7nVWViLR+M7J3BI3V+gIn0d4fvsCuYgTTxVWYCyAVWB2cZC2JaEDGjA2+5DJupO/m+5ZdXgMO5pcD18LyvEKbSzptmrYEKQREJFf09YpCjvFzTmn5Ozet4l21vxeLDawXfkiyE3A514t3gPDIOVSMD67UhzCWem8w/PH6Z/KyXLtB4NRgN8iPIVdl3F7F0BbQRJomrFod7OZCTa8RO5qSd8zyZr/NeqiJMX8Tlc06SI22swg3CMqthTqmeyIbIAM5r0SOA/bU6Q84tY5EMs2DSOpF2lgNjhQ1obZhvjmskaCIE2fDd9zxsTTCl8/31a7gppAjvDwMVIpbTOiLCySpwgCKbMYAVMhZYbUQtlr3u+DdNnhDZy3kLvLgWCdVYP3XFYnS1ysJzzZKfX6M2vH0twq4+LzGZdM+Y5GE80VHoBuk0M6u8GmmzEm/TWGE8Qtkzm91jlsGbWnBA5UTRIbPbJJfJCYb/bfqacogx2ofGp62V9aRpl3YabccptypQtnWLHLHKUOkPEeDxX5IM3zVriZaBn1Sr9o1u821woxM0GeL/kbdoj+EARHIY6vfp3QV1ckjEcIIc+Yr3rBazcDybv5c59LDPnaGb+RPMMnTT51p64TM8HRUxczRoT1ujz1zZZKQXFZ80nZQGIVG7Z6YPpJDbsQV8K1RlUOMU4GoSjCU+duNZUcn3PbZJmTBAH8JOhxBjSUkJW2+8/8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(4326008)(31686004)(83380400001)(2616005)(66946007)(38350700002)(7416002)(66556008)(38100700002)(66476007)(508600001)(31696002)(956004)(53546011)(52116002)(8676002)(86362001)(5660300002)(2906002)(26005)(4744005)(186003)(36756003)(8936002)(54906003)(6486002)(16576012)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlpuZmFjMFE5bU51eXFHelo1NVNnZTQyZXpKMllpcnUreXFIM3Z4YmdWZGZO?=
 =?utf-8?B?OFNkK0h0bWMreWh5OHZBa1lxUzZCWXo4dlYwQW9hZGNBa3pGL1pGYmpiWk1z?=
 =?utf-8?B?eStwTFVTd0VLa3FCcTZoemhYYXozRE5GM0YxUVppeGxoZWQwSGVlY0RISVNR?=
 =?utf-8?B?YUtFUDdwWmFzaFA1cHdRd0d3S0dYRG5KcnUrWHEyZ3lGOFEyTU1rc1dFcDFU?=
 =?utf-8?B?MEpCVUhTWEFpVUJrUVhpS0pkQ3pENGo3UXFPM2czc2wrSnA1OEYvSTZkRCs2?=
 =?utf-8?B?cEMzQXBKUWZnM3U5VU11QXkyMHpvZGNGSEJDNyszdHJ1anVUblNSSDVmSFhm?=
 =?utf-8?B?MXRQa3ByWUl6RmJtblpKWnVBaUc1T3FLbTE5NmZMWXhLY1VSSEQwQ3J2Nml3?=
 =?utf-8?B?UVVPVVh6WGkyU0x4eWFUNWxNdFZnMDB4UHEyMGp6NVZFNmlJUDVPK053bGNC?=
 =?utf-8?B?ZXZMTXZxRVl4SGhUa1dlQVdkRVlKZVRJVmNHUnJGL2VUN21GTjlocWlrT3ZY?=
 =?utf-8?B?UEpmemJIeUVOVHBkUDBKWm9xalRIbzFWSFc0MWZFVGVBRUNtaHBWblV3VUg3?=
 =?utf-8?B?NUhMZmJyRW1PTDNNYmR6UURqYkRURVVjSUk3VTMrTHJ2K3NwZkN4S1FtZWFP?=
 =?utf-8?B?b1d0NkFKYWp2ZW9KT2RWVHJuaUNUdEc1bHYzWjluS3dOa1hyekpYcGc0WTR4?=
 =?utf-8?B?VTFwbHl6U0h2bnBCYzhBKzJMb3loNXNYeFFzWHRiaWNkUFZlUGdnMUtnWUtj?=
 =?utf-8?B?ZldseHBBNEQwd1dxZUdCemdjZUxXR1ZKQ2xkcGFTcWJTbXB2UEtEWnArRXVr?=
 =?utf-8?B?Y2Nid05vOWVXVER5bEs0cjZTQ1BLVHJwcE03cDZROS9UdWdxTm1HYXlCNjNl?=
 =?utf-8?B?RDMvRVN2UkF1TEd1RW9jSE5ET2h0YU5nZGxWZ2kxY29tS2JjeUtmazRSenpK?=
 =?utf-8?B?VDVhaExDVmVYazBRUzkrTkhXRVFDNUNsbzc2MmRPdkJ4eG53b2FhZnR2bFUw?=
 =?utf-8?B?K3hVakF0RWp5empYYlVBcDRGZ0tXK2ZFMmgyS2QxaXdxK083SUpFamxTcEVS?=
 =?utf-8?B?OG53UUNLaDJ2R0FCVXI5UXRIZ3lPd0xKUFNOdDh6eUNmMTc3VkdaVHFsUEx4?=
 =?utf-8?B?SmtNeGd2b0FYK3I3WjM4b2lCWHlTMERZemZBdjEyUmp3emdrQU12V3d2aURU?=
 =?utf-8?B?VE4wSXlwUVl3SGNab1ZWbEQ5T3ZOTFRhaHd6ZnY4WjVIUXpESVIvTFN0cWJQ?=
 =?utf-8?B?SlFyMVY0SWJrV3dMZDc5dUlwMUt3b3VJUDlLRnBwekhIS0JYMFMyZmZnMklH?=
 =?utf-8?B?ZVNseUR1ZEhCcW1TQmpkU3BtZ3FHWlIyZGJKS01oNllqWVlHSGg0U1BHQTds?=
 =?utf-8?B?VDVQN21QZmJpN1V3OHV0UUVmWWF1SEV5L21CNGNZMW1DRC9vcGdxemI3NDJN?=
 =?utf-8?B?dVBqc05oS0xGT3RoVlNlcVk1UzhRcXpDa0MvQTVGQWRTYUxlTmtwSDl3VkM1?=
 =?utf-8?B?TFlFczdlSUYvbHQvMUJONkNPd3kzMFg3Z1ZKRm8wWUx3Q0FFTGZlV0R6ZUY3?=
 =?utf-8?B?UC80VTNacGNkakE1OURkYmxtZ0tnc1NFV0lVWjlHbEN5VGhNT0JIV0phQWwr?=
 =?utf-8?B?M2NtRndmVlZ0VEMwZkQxT3NtcW5mMXNoVDBUQWxNVVBUZmU1bjZhSGsvWEdK?=
 =?utf-8?B?c1NKVWNXbGl4eFZLQytDUE05SGdVakVlWEZqY3VJVm9EZFl6UlBhK1lhVWMv?=
 =?utf-8?Q?w5HbLzVUZoUPcknF3L2ZQUOTHQWEqLYBacX5tcB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bb8515-34d5-4d24-a951-08d98383015d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 19:54:53.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9u/N9H3P7EXVbGum4DLcDEqDvtGMbXcyvRHaz8Nf0oCckvECQerinan++9BsgI6FECQLydra1S4odYk7uT4aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3733
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290116
X-Proofpoint-GUID: FjZZAD0Aq4R_7CsF1gUp0RK7shbsG_d4
X-Proofpoint-ORIG-GUID: FjZZAD0Aq4R_7CsF1gUp0RK7shbsG_d4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 2:44 AM, David Hildenbrand wrote:
> On 23.09.21 19:53, Mike Kravetz wrote:
>> +
>> +    if (alloc_huge_page_vmemmap(h, page)) {
>> +        /* Allocation of vmemmmap failed, we can not demote page */
>> +        spin_lock_irq(&hugetlb_lock);
>> +        set_page_refcounted(page);
>> +        add_hugetlb_page(h, page, false);
> 
> I dislike using 0/1 as return values as it will just hide the actual issue.
> 
> This here would be -ENOMEM, right?
> 

I will pass along the return value from alloc_huge_page_vmemmap().  You
are right, -ENOMEM is the only non-zero value.

Thanks,
-- 
Mike Kravetz
