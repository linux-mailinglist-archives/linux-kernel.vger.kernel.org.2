Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E904A35E946
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348686AbhDMWxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:53:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhDMWxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:53:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DMicH8120883;
        Tue, 13 Apr 2021 22:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/q98wGjVQpqx5q3bQ0/wkBk35cRDh3GommmhG1Czp3k=;
 b=avTSyS4WqS9GaNtNwFp6r0+6iqQ7lJmxP1PMOgxqwXJVkMtsF1QEHnbkWWR4osJoIoFT
 KfPSoRfm9P8JE9oy4D9hwAi3LkZKy5356+GO7rg4TDLc/MtAdtoTimtzHkch5avHL6FB
 gA23fG9bd/vwds8rO8vtasXlrhXyn9/iV/asuTUa9NOW9eXRWbcYwk0sBn/B6nhfqCCB
 QSsVnzg60mQhyUWJgr7MdzKBx+p5+z/GDcSRl02z4Q6Dz6O+sjmKAR1gdaLYNIchB0/0
 l2AODp1Bzx9FSBBhxuAI5119GDiE9J5VhU8I3yLsK8z/4rpt65enF0Oo9d8t7r3IcAGX Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37u3ymgmkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 22:53:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DMjgW5142786;
        Tue, 13 Apr 2021 22:53:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 37unx0dh6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 22:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWNdx6TZRnJdJ+6yFVa5uuc23VZIiRhHCz/Iv/fQ19scShOkDcyZj+NOazE5W0LKT1o1bxa+pehgnwTYHYmNt2jR1te7zOYHEIitbXBaVrpvb7Hb51krgUXI0qjE/Tj03aqQx8kh1XEfgslvkK9P7PPeE9TzPWmOBK0PVzxTR+uc2I23+rV0M61cLSM/ZTJ/vCF/f6nxMM6gYAEkkglXKqd6xejf2Qr9cGszMS82hS4//YUQegwt9447AZUjpgpHxM/z66s4ZpJ8V3t/SwbZiXkO4owwpStbPP1XzCNXZGY5wYL5YuAJr6ut3NORxLItq0OhRQropgkbfMyHcg74jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q98wGjVQpqx5q3bQ0/wkBk35cRDh3GommmhG1Czp3k=;
 b=KoPDbt2uRAFKSZMe6b5QNPl3KX+lmtCzbMrBCy+jOdV16NLFvsFsN4zcdEp2skD5ZQWvty8NRt1MEtaQQMNVEUOYav4gUeEI8yLBd/H30IUTyNfHVk3/OetQ5EB7Lz3bYWFTgjtcneAkwf8nZJgRe8/KU9WTzKYzp0mRcd7oL2TdhvtYlYDpm8goamFXZGUk2Cz+S398PgYMY+kYaYE152GGLxZTyorpiyD9SlSybzwCBHi5g7Y2gEynzVXFj0zeueREm0+TZmh3wn6FVMZZWBKaba5adnhI3WWu4F0q1mdiI/KITutcU2vnhlY18eWz4dg9BxVYNS4/7kTkUeJQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q98wGjVQpqx5q3bQ0/wkBk35cRDh3GommmhG1Czp3k=;
 b=uIWVSvbwQwcmR9lStiTt1RIXU2a3PNHLqbploYgDd3AgwmwNT5r+GQC6mEZzxcUXoN+FQdDvQm0IFRZWdGtUrxYU7DdoNER4HyWcK1rTMLi6aA4wPrnkps2GaYvBbAnqnPnWb/YwhyNQcyKlWEouh3C1RQotxRUoXPKh9W41oss=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 22:53:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:53:02 +0000
Subject: Re: [PATCH v7 7/7] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-8-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7d21c92a-396b-9684-803d-7c5347ed6927@oracle.com>
Date:   Tue, 13 Apr 2021 15:53:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210413104747.12177-8-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 22:53:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 200b644b-7723-47ac-1d35-08d8fecee496
X-MS-TrafficTypeDiagnostic: BYAPR10MB2456:
X-Microsoft-Antispam-PRVS: <BYAPR10MB24561E0BE0204838411E79E4E24F9@BYAPR10MB2456.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXn07xTz+mL+nPrTYQbIwEmz65oLzMwBfngjNI5hvXiKSrwgVwAMf3aO8kwt8yIjvFy8/IwtWW74vCwSlgZtUE1+AB19YFiATBra1JG0W0EtrzuZ0ZhDfouss0GKEXy+Inbk51aFqqSa7RvtqQHnPfBeM844J6lnf2I1yc3polgFExnCuXftdCfh93SEcUON6hLa4rnoszyyvGjWoN8EOdBSyUa9zWjCZ23mLNWLtVasSJD82vtTSgWUHAqfaNZGE2JkKOyMT7luB5eK/iZDkh2fMovPz56bOL6Zoem2nwTKdgZ+wg+V7qjJPDcM/cgLHr+hsRPiBXE0KXyXg23kRecs4/bt6vlZPCPxm7z3Gb5By4evzc6ukn3/FTuK10vrN9H6AMG8EvsNdtXeDm5jWuyasBs229GunklSlR3EC5JPBEWyhtPyB7tGfs+zrAFO7GC4tdAp1nyzzwURIM0bxMS14lE0hifbAnEXWWNGSRRMFHlT+JtWs2bghThzC4vIJEkFnr5a1i9GD9LvksCWZ6vJHgMfbk/qhUpj6vq73dH5I+m7IogfmZGOYqlCEudQN+ooPubprtWuQDg4Qb9bT9B+hP4dB54haQuicnHL6GiI5sdoi3ZIIZeJ2fFWJAyZFvalTa/CrWabsrlZJqs7FNRbzbmU9Cd1Xjw94R4S3XlWhcH6UQre139o8U1/ceUKKLHHFy2E+DTClJnrQISfOS6ahcqLju9hJbbNYBzEKZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(346002)(39860400002)(66556008)(66946007)(66476007)(31696002)(86362001)(31686004)(83380400001)(16526019)(186003)(44832011)(26005)(478600001)(53546011)(52116002)(2616005)(6486002)(54906003)(956004)(16576012)(8676002)(316002)(110136005)(8936002)(2906002)(38350700002)(5660300002)(38100700002)(36756003)(4744005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TEZjMkdBTzJFQzJaOGR2RmdYdlhqcmJDejArdUtTbGF1dm1kdWFVa0ZzREd0?=
 =?utf-8?B?SHcyajBkdjZPN05tUmZUZTEyQ1crQnZOTXZUR2lkSjR2SHhpcE9RRkRHMVk4?=
 =?utf-8?B?U2dJWHlBeFhJdTk5SE5hYWRRNFc5R0FBK3BIYnk0L1lhdmZhR29rcXJVUGJE?=
 =?utf-8?B?NlVITGVpMWNRSzFyc0l1YzVhRlBJY3ZvQ1NLRHEzYnVmR2s1MGlQc2pMVzJS?=
 =?utf-8?B?RURFMGxsdEgzZUFIZitCdDMzZXZmNFBSOXI4N3MvRTRDd1R1Z1pMMHB0Q095?=
 =?utf-8?B?dXJLaDcvd3dpcVNSbHZpLzc1VkZPTkpYcDZwbC95Z2YyZi9pT2RxREdhekhW?=
 =?utf-8?B?RlNYYjhpZlRRY3BRQlVLU0ZRdHY3QStYN091dXAwR1hXbXlmZ1B5TDJpQWJM?=
 =?utf-8?B?VzZnRHRLdldLWVcwNjVBYUZyWE0ydmFOZGpvVHRPNEFsRkRTQllhdmdndldF?=
 =?utf-8?B?aGRLd3BqYlp4ejZhVFJyaXRFTlFRWC96R2tsOHBRV0s2aERVam1MTHFtNWVy?=
 =?utf-8?B?TFYvNDZVdFlpTlIrUC93Z0VQSDFMZytvL1gxWm9VNDhUcHR5bnZMQmFYS0J2?=
 =?utf-8?B?MG5pYmU2UjlrV2lpbnNHM3J5NnhZVXFMOG9yQWVWZjZPV3h1ckptTEU3cGJE?=
 =?utf-8?B?dHlhbHpUMkV1aXQ4Z2htZmlNL1JndVAxdmd0MDd5T0hJcHUyZXg2amp3K1NY?=
 =?utf-8?B?OURnL3JoMWVQdGhtVnhZOGNyZXFjS3RvVmxXTUNDckZQbWsvTWh1cVRFZkxT?=
 =?utf-8?B?RGwrbThoRmZtT3FhdGtpOVlRNnpqaVdhTnIvZXdydE56S2U2OGhiS0ZPNmxF?=
 =?utf-8?B?M1ZBMEpJcjZ2Vm9aUnNHcERFcjVkc2VuYmdDc0NoOUN3bDltS1g2Q2Q4SVBM?=
 =?utf-8?B?dDkyOEhsUVY4SFNpRnZpSzMzSnlMemFMejIzRHN4TVNNeHhzSlBkMmV2UktX?=
 =?utf-8?B?SWJWaUxGdlRWL2ZLTGFodjdsNUNSL255YmxXWnpoRFVLL0J5R25GUlA4QzVR?=
 =?utf-8?B?SnN2T2NiY2NIakpyTHFVVVBLRVpkN28zY0UzT2ZkM1QvUzRJbW1RY3ZaV0pF?=
 =?utf-8?B?UzF1MUZxeHlSWEl3ZzM0UmpBaUtPelMvMGplbUlwSXR0RFpvSTUrMXBQRXJW?=
 =?utf-8?B?MmpBbnpaMVBmZHozaEpwMHg5REFrU0FoZ2Ftb0ZReG5BVU1SSXBHZ1kyOUFo?=
 =?utf-8?B?R1pwd1o4eXlzUVNlNmI2TXN4cC83TEprZmRFMHR5MnRiWjVUd1JzcVU1QnBq?=
 =?utf-8?B?elJPYXJKaDQ1czlWMCtWMU43VlQyZ1Nienh6VU1rVXhnQytqbFZSMXVSMGR4?=
 =?utf-8?B?MHVyV0Vjci95VDVFRkRUbS81d3dzeWxIOURkUkFYZHliSnBCeFJudk9JZ1Nm?=
 =?utf-8?B?a21mUG5wc1dNSloyYXlkek50eU9TUjIycFlYazZpZTZWWFV0M3Ivb1RWR0hH?=
 =?utf-8?B?QjUwK0VkUERzUTVEZnZVYTBNZDRwQitGV1NrcHQxM1RqR0UrR1c1SUR4b1B0?=
 =?utf-8?B?TWozSnBUSUkrQVZKS3JLL00yZEFIYjhtSFRkaS8zb0x2S2I1MzVOb3ozN1JG?=
 =?utf-8?B?TkZXOW1ma3hpTHdMaDBuYkhvQVgzbjZVU3hUcGZRSmp5T2FCM0xjbUFtV3RZ?=
 =?utf-8?B?MVZRQWM2NzJ6M2NocHBuVjByWXJwRis0ZC9kRUU2dCtMYkZTaHFXL2J0YmJM?=
 =?utf-8?B?b3FkdXNLZzQ4V3JLa2NueE9FN1E0YVpUQ3ZIOVlLeXZ6eXdML3JwQmJlVjV2?=
 =?utf-8?Q?onH9j4xSme02LjNbElw7RDJYliLbc/vADi3pvqb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200b644b-7723-47ac-1d35-08d8fecee496
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:53:02.6314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0D6Lfo2y++/U1GDyaZikiOxSd1mOI14Rz7CA6w0ZGtUfaEsChVEDMm+TZsCeK8KoJ9wxSG/1xIeH1027yD0Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2456
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130148
X-Proofpoint-GUID: V0oKaryN-rEleJpG5WzOcPn2Y4lkcCvt
X-Proofpoint-ORIG-GUID: V0oKaryN-rEleJpG5WzOcPn2Y4lkcCvt
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 3:47 AM, Oscar Salvador wrote:
> pfn_range_valid_contig() bails out when it finds an in-use page or a
> hugetlb page, among other things.
> We can drop the in-use page check since __alloc_contig_pages can migrate
> away those pages, and the hugetlb page check can go too since
> isolate_migratepages_range is now capable of dealing with hugetlb pages.
> Either way, those checks are racy so let the end function handle it
> when the time comes.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 6 ------
>  1 file changed, 6 deletions(-)

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
