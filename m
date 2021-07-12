Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8B3C623F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhGLRzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:55:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64068 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbhGLRzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:55:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CHh0Bs016460;
        Mon, 12 Jul 2021 17:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=o61VIBEDwIBKPkxUlzIW2ldEMZo6Lovl9k8ben8emMo=;
 b=Zk04KqQ3/1z154u79DTxzm55W6F7N1Ml98NPCVz30wPbD1ZP1EJnz18oyt6D5aepQKTT
 N7t1dLgfW0wAJIWIKM7S3RDaSU8SeQPQzfIn09hndBshA2n3ZSInkReSVTVLWJt5KVY1
 LCVBr7WgXDRQTW9tzYt7Mux8LxrFTky4ZIFe8lIX5NtnaEZEbz8PkCFWI67blIlNcwj7
 gtvFuaEU4pnWt1PnsR9h1vdzSSXFrvEzE9k1JfbbAc8JB5T3jEgFzC7Aesvyo0jTAN/5
 9c5OsUP55AdUHh15Uw2m9bqN29O2D0AzwtUZeF9W1hcbSonEyq08Z9VDLOHyGL00LbZ7 dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb0gb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 17:52:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CHepNb161306;
        Mon, 12 Jul 2021 17:52:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 39qycsf54w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 17:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E06nqXgKGxbWgkrfqqSa/3MRDVdoraxsJ3slbeCgxPrVq86cVSbAB+BPgjmNF5qhg5d+HxQCQPeOkqr3Z3oRLpReWTc7Di3k0ahhFDRaRKLhNMheI9zj5UFh6ZboFUzXIj6PQKKUXobIL1ghZd0ClGcar5G+gDwS0zqEORms1hc14WDuWJJYKzCJGAW6lMbdTdd2fGmufAEP1eZ0XTCnkVQ/zrkn2yLx8sx2JJwdORyywnMj8S3D1uH2R7TXwWGoT5JdBtBWV5m79871BTBmKo1oC28h+oTyTepEey7XgGKUytj0fJK88UGh9qelZlkkFU0FwsYViOim9cAXAyMCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o61VIBEDwIBKPkxUlzIW2ldEMZo6Lovl9k8ben8emMo=;
 b=Ng+NIwiVB/rm1Go09p18vMA/i5JV237LmLlB6VWSNVSChvMsR3oX+PWESdGBSHPKq56oPTAm9Kq62mFueYZxWNYAbylzwc05/VvKgLxEf2gGBAKMgKLooMOFjGZLO+UYLi3D0aGg9A84inC21wTtvlg05mOuhSBSpySYP1G4smRgpkfgh5Xc72apbBG/dz4dkJ4n+1qMyxjk1rJX7bCgcrUH+bn3FrdsexuipV7BQAjGoxX/JLcJ+xen7bO1Z+sm7tRzWswydErTm5OQl9MmlZltmriwZLK+tDUgeNUkFxLRSq9LvVvmEH/mSgmHnErt47xuw4YC5QhNBOjYSIB7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o61VIBEDwIBKPkxUlzIW2ldEMZo6Lovl9k8ben8emMo=;
 b=EK8P3CDDPlRbbebXJ5IbZ+7HRa0tuP7Pt462dTc0MYlH6V89evjkhmU7KZsUHtep1MKH5KGoDPY4Tx57IhNLRasJUwxbKUxEpuq+4sy3wyuc0YNBuVlaISwEWxZ+qdk31mkO/DQgOdtzDnNzpkgE1WP5qAs5Oa3A9XM5z3RcwsI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4276.namprd10.prod.outlook.com (2603:10b6:a03:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Mon, 12 Jul
 2021 17:52:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 17:52:08 +0000
Subject: Re: [PATCH] mm: Make copy_huge_page() always available
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210712153207.39302-1-willy@infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9877bef9-b2e8-6a8c-4d68-7df7f3fb71eb@oracle.com>
Date:   Mon, 12 Jul 2021 10:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210712153207.39302-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:303:b9::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Mon, 12 Jul 2021 17:52:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 497332c5-14c8-44e8-dae7-08d9455dc4d0
X-MS-TrafficTypeDiagnostic: BY5PR10MB4276:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4276D000CA7B46A55AD37336E2159@BY5PR10MB4276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwMaihtjy0CzBlHbyqeMWLbR5VAUlAfw0aNlUQCpkQGAN3rVayxJs2/i4qWLAvGCRzTDgVpoDr2/hx/FZJYiNmnNdt/AWw5jMGENG7AU0caGMMlNXxWGItAFbGk5Xnpm4bdcDaz17YjA11CNtgeQzYMTMd59IOVnFOVkd3NxdTbFR+MHkDAcJa6a4VHPBjssNfRDE/XL/jTX06J5jVUGtsYoKcU/pXsdEiz50Jqk/80Nv7LVvmaDuv83pM10+/TILbho1hz7x8+JegG+wkYpb4o9/0fkv5icvmObADmHgw8t2ZiEDO5biyGMvVGaRSETDJniWprye9IfP4RRPbNgUjEdivccL5CZ2KsA1u9Z2bCXn+4q6UQ9DC8fPwqg6r44FREIPeDo/ns+VIA+m4+Fx4Dd6Kh6kgjibIcG5yYYhtxZV1Brs1QCWTNRYEvoEjNLeaeQtuEP0spuKjRMtEkVqIOouLRS5+6VwbbxgPZOzI8mb+MNGb7jnPe2o8eqLlHdHzQOP2x4bGiuaAWS8Im1921FmdAt1b7+wxskLpkvqxLtWVpMYomy/KUoSwUztZMIH1oWPfHCnibAVTS49O7lBodTzhF+nyuGtQUmdjunuFvAzQusqG+77YyGpnJ7G015P1NjjYKlbUIwMFzZmaZT+CcnLCImdii4C3qffRHPs/9i/O1RI5pLQRyiPUw/UPC8QTqc/f6pjFq3YTb9O9OXc2+o15phP8gsM75mJ8P16rg9KrtfgYibuUuXzXc3xFl61bIptcnuULeGrMkBOzNB430rrG7ocy8eab5cbQdzJBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(110136005)(54906003)(316002)(6486002)(66946007)(66556008)(16576012)(83380400001)(66476007)(5660300002)(86362001)(52116002)(44832011)(38100700002)(2616005)(4326008)(31696002)(956004)(26005)(8676002)(38350700002)(36756003)(8936002)(53546011)(31686004)(4744005)(186003)(2906002)(478600001)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdjRXpud3FFK2NIUmgzakU5UGk1Z3NUYVNnKzN3Um1RQ1hmdm1tSEtiSUsy?=
 =?utf-8?B?T2hUQzBJNEZGTSt5U3BqaTZvT3gxQzU2dDZxQzZEL1VFZ2QxdVZBRWx0dzhj?=
 =?utf-8?B?aXhtVTJ0OFpFUmhhQytSLzRCYTVqeUVxNnExL2tNSmhUVXhLNzZSN3ZrSzda?=
 =?utf-8?B?enZBNzdsTG50RU5NdTZPaVpXalhkNFZzYWgvMVo3UHVEeW1pVndyem5ZR3hk?=
 =?utf-8?B?VzlIUWk3NFR0STNiZGkxNldTcE1MRHBTUnpxOWVpcEs5SEFBTE5xSjJkNXlZ?=
 =?utf-8?B?SWlQVFZKdzBsbVpsTzdIYzVDZGRRUER5eDdob0ZqLzFHcUUzb0pJUmsvYkx4?=
 =?utf-8?B?dWJPNW5sWnF2OEwyZHhueEt3c3ZnaUdZVVJKQTRuYUl1Vkd5SW8rcThGejFX?=
 =?utf-8?B?RFRORmwvYmNCYUF4amtoZ2o4KzBnczRIRTk3QTJiSGJhU2pPS25iU1QramNU?=
 =?utf-8?B?N2FURzNrcjBBOHlPRFR5K2pWZ1JxdGNSYnk5Mlh3TTkvZUxTN3ZuYkF4ZFRJ?=
 =?utf-8?B?MEhiZk8zOW9kOGVhM2JjdGxqbHRrNU80ZlVKSVpqS29mNUFsd1RKVXgzeFli?=
 =?utf-8?B?UEx5RlVQM0M5U2psUXBQNTdSeFVTS3pyT3QzU1NKTVZrMjBYblFUZ2pOMkZQ?=
 =?utf-8?B?U0lvRFJhb3U2Q2dFV2luYjhFcmhsNGIrV3JBTHlVTytrc2lqOVRIbmhJRFBC?=
 =?utf-8?B?YzdzZjIvb2Q4Q1dTenhqTkdmMTE0UUVodUtnZEZlYmN6TXhnOVFwZTJhS1Vq?=
 =?utf-8?B?eG0vcWNpOERqV0YvSGR4QW1tV1AzZzhIRmJvNTlSS29ESXRNb0xWd1BLUXRo?=
 =?utf-8?B?d1p2d3dmM25GcXQ0TGVmUVd6eHArcXVOZUxRcjRsaytyUjA2cldYVUs1Vk14?=
 =?utf-8?B?MGNYc3NQOGlma1BBWnAxbHd6bjMvSm01VHRyN253RFhNTjFGRStxSE4wL3k5?=
 =?utf-8?B?NUswK3FuT1Z3YlduT2ZucDJOZzNFeFViTWE1emVNZ1BnQ29VNEdMd0RPdmZX?=
 =?utf-8?B?MGI5OFlHY2R1alFlOHd2eEZtZm1GNDdTbHU4UXljNXFNbFBLeGw5eVpVVFJJ?=
 =?utf-8?B?MVYrUjB0eUlmTWtyUGdWWW5qYXh1cE9UUUY0endYamVrb2VWbUx0OTMyN2tM?=
 =?utf-8?B?V1Q3NVFualJaZ3prSjVGTHpnUkxhNnJKMHFFY0pGeGpGZUVrTURDbE5wZUlk?=
 =?utf-8?B?blBibnFwRkY1Y1RoRGZsTCtHZlVpbXQ2aHp6dGZrcEY3SEhRZndTaDY2UzRU?=
 =?utf-8?B?OTNmdzVBUTBzekZwNXA0QkFjdHY1c3poMDA3MnRGUUVVN0VRNURrd09JTUNO?=
 =?utf-8?B?MjBMcHpGcmRPZjllVFVOMCtHZ2hpRGJsRVZIL2VMbytyS3ozT1c5ZTJJUVdw?=
 =?utf-8?B?cDdVV09uS2NFRmhZTkxqZmh6alhxN1J4UmFPa1NlNmhZZFFsckFYMm95Vk91?=
 =?utf-8?B?NUNxODVPRUQvL0srYVBGRnV6S3RkQjNTcktEMXVxWkZMaFlKTnVXZTJxUGRB?=
 =?utf-8?B?Rzl2RHN4SzJxUFQvdGFZVVFzaXgyMXRJaUVPSkxwTVdQS1plSTdjZk8xV0Zr?=
 =?utf-8?B?T3dKQUhQajdDM0xranZWejNra2czNkJUZVZ4RjBkVmEzVHNBbW1SMUNWbUJ3?=
 =?utf-8?B?Risxa1dzRHV3eUVZdDR3b3pILzFEQTB3MUlOUUcxU2lhTS9NcXdWeVJJNU43?=
 =?utf-8?B?WWFPR212b3k0YVJlbCtUMTFUODFLZ3R1ZnRJODlPdU9mU0tUdHBDMlBmL09l?=
 =?utf-8?Q?VC6YxZBi0hW+Sue6+jZ65h0tGP/vErvD/Xkg1IE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497332c5-14c8-44e8-dae7-08d9455dc4d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 17:52:08.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA/s/D0BZoDLKTzh1EtrYTmGw66URhSUD+q2NdpcAID2Rok9E6htI4k/LaYp7+Xa4F6JYPAToxDcCPbS59qlcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4276
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120128
X-Proofpoint-ORIG-GUID: Q3Xf2kw_llL-KaaDseVjIfA__oDN5xvd
X-Proofpoint-GUID: Q3Xf2kw_llL-KaaDseVjIfA__oDN5xvd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/21 8:32 AM, Matthew Wilcox (Oracle) wrote:
> Rewrite copy_huge_page() and move it into mm/util.c so it's always
> available.  Fixes an exposure of uninitialised memory on configurations
> with HUGETLB and UFFD enabled and MIGRATION disabled.
> 
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/migrate.h |  5 -----
>  include/linux/mm.h      |  1 +
>  mm/migrate.c            | 48 -----------------------------------------
>  mm/util.c               | 10 +++++++++
>  4 files changed, 11 insertions(+), 53 deletions(-)

Thanks Matthew,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
