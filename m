Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0325331AE14
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBMVNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 16:13:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59716 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBMVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 16:13:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DLC6s5022232;
        Sat, 13 Feb 2021 21:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QQfKoPSJGaWTVmRUJzJ4NHIxyedmUS/3nKj5LpN5F/Y=;
 b=Jb9VKl0P7VVzE1pGKNKljfe2SAWnATU09MGd2fpVDHMkV0fipwz7lAO1UIujOThtYZ8r
 Lagfw0yISKAp3ORZTOecIer913eE1O73ZtjMcMYBEIsvBttnqx6X3vPq80Oc5aZKUOgr
 SyAZi+5pW5O3Pst2VTIFXV3ouht7JhpXLJgk64i8Qbs2qV8ugP9kxBlUxJWasTbJuGgi
 FKL/5YA9mfUymWEhkLhM178t+YluUiqSpuqNKdCZ+TAEHHL5GASCD1c3BNe2mZ6n/IiV
 nGTRdFALk81ujs+WfO6eU80G5TsiuvWrIYmHZz40hkkILOISDvm+w1SYVmUAr9naTNAa 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36p49b16kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 21:12:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DLA5pi177147;
        Sat, 13 Feb 2021 21:12:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 36p6k02hy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 21:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPrIpI9LvHbb292Ni7fx2qVvzd96Gm5F1gEGK9SjAOLvsl2uJH05R2AOjMm256FO8BpvftMpWOQ429Fg2kQ1VZmBW5NMHrG+CrLK1zpWN4k4mp6FUDquBzWuRO932aSQOxAGRB/U1eYi3225y5+EjsKjeMey+mnTOEyNgZqJq7jDobbqbjsGQ3bWPc+mSdRNritiVXC/6AJVDaa52/vwxetSrFjIkcRwgFrQJXoawSNlUCgp+nutpjjZPLnWvXke4xw2vmA2DoS4JavHafooYxFM5hevDZZ2/qnL/NQA9u4Yjzgo3DTbI3NBbtHeBn7fkclZHqZ1UmfW++Z+dH8Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQfKoPSJGaWTVmRUJzJ4NHIxyedmUS/3nKj5LpN5F/Y=;
 b=W0qAMtThsQJRypUsjIJrTTpA33yQmdEyJxwwMD7Ewc4EWWFRFTAVnwO6+4nRPhh0e1UqjEEh1+38hXxD0QRf7J9jJtQWRp1zg9spQ9q4jWWVBDAFB9XT6+GyquI8YT/KwzKyKFxXoiXbCchUQYKSCQ2903y6EZtcdo1tB+rlP2mNRnfu+qJk3M5HSkr4LQSBpCpWb3mq+JiWd+jrFHVZh9rL4asRxmoA05OnWszYuF1k2xJZ1eBqeFnLFNfWxje02B+E5f4CStlXes81b3rCsxBwYuf9YScz5thGpxvAw8IEHHieNOKM9tXk45AxcQtBfLStnf+YV1bt0W8GzNwpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQfKoPSJGaWTVmRUJzJ4NHIxyedmUS/3nKj5LpN5F/Y=;
 b=ZiT/cNec8OEfTbIZzTgs73/yHu1nMMXo7vcuueQjtpwZgYuSdvpHn07zTlQZ/AB6/5yZvpN1PL9/YiJ5JcOSikPW58+UUC4YtEbkEVn/K2b1nCFQX8i91q+/5eBqMr3ZzOGXi7XI8VacPthmkpF61KdbMkw5H09RrQHSBE1aumU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1966.namprd10.prod.outlook.com (2603:10b6:300:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sat, 13 Feb
 2021 21:12:28 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Sat, 13 Feb 2021
 21:12:28 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
 <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
 <20210127000730.GB4605@ziepe.ca>
 <f1fc1543-72fa-44f2-50fc-0220abfdc484@oracle.com>
 <20210127021023.GC4605@ziepe.ca>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0b75d477-c041-7830-5d28-bdf0a3530ee9@oracle.com>
Date:   Sat, 13 Feb 2021 13:12:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210127021023.GC4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:303:b7::26) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0111.namprd03.prod.outlook.com (2603:10b6:303:b7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Sat, 13 Feb 2021 21:12:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eba89cae-2a5a-4932-7c81-08d8d0641178
X-MS-TrafficTypeDiagnostic: MWHPR10MB1966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1966C382FFA76AFC163E0389E28A9@MWHPR10MB1966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bAueU5JuwYUKr3P6Zl4XQICvHJsNmoCjeFYZgLVQWyWcwKDEkkyDqYcIwyWkasjnL7xeXinHUvGdusPi7kLiZ1Yp1BG4px/4GuPLfdVz3/4FwlNAUNa6tnk8d21bA51F4HhIV4wXUVnFqEmnMM67b5apPTziQs4FJWtr5XrqHy0DaPFOlpDXb4GdwSSL+7jVwHyNepZai+UijTMpxD5jKwJl5IWxkvzDZDvST8hWkbcWgMLc1k6PExlKNmUtKufbJRpXni61spmDvrAhvFmBoFTdapSrpe9Lx5RPoGnMST+NGMiet6gxVa5sagvXM1Y4ST1VfdzkZf0Kv9OjKLhT6nFWutsRALPzgpvamQZsdSjX7LG60P6cdFAYTadhsR21sOttmZsObLXBiK0+6BzfAAMrFxXGN1Fg8Wg0jGJBYi3OMQ84CuGJImSwwjOH7/GtE3FohtILQaeF9JIuQONSVoqh+pyBxBiqPzWJTIWMK37Oe9C1uHhdault8eAL/EO45C+I5WSNLDSdZ6yuu6d68fRsGom7Wj5E9O7SruajudSUVKCqsW7HNJz4PL9YHZ2w8p8/shPspVbyHAXBOBvThH2PVxcQrmqSMYMbkzfO9d36HQknC6TmgM/Sf0DW33fESRyNTW/h5/foJe4F1MJfBsFWAnI6tNZZghkY6rOoQpFuyA3LZDLy5SwTBGIMX73
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(366004)(346002)(396003)(44832011)(8676002)(956004)(52116002)(2906002)(6486002)(8936002)(66946007)(966005)(66556008)(5660300002)(2616005)(66476007)(83380400001)(53546011)(36756003)(4326008)(54906003)(31686004)(16576012)(26005)(16526019)(31696002)(478600001)(186003)(6916009)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bVhNUkxCUlNxaCtkcDNpMndHdnBPbXNRei9rdjVSd1hEcnZpZlZwenJSQ3Uz?=
 =?utf-8?B?M2p2WEZady9MZFQzeXJlNnQzYUl2d0YwL2J3UU5McDQ3V2d0RGs1Z3JOOVBU?=
 =?utf-8?B?bkJoQkE4WWRHVGh0NnB5QWZlbnJNWlkxTUpzUFJwRjltTWF4R05JaGpwdS9a?=
 =?utf-8?B?NnZsaE8vKysybTd6NEJHdHpqZmxSc3k5c0RVdEVzS2tHSkduTEZEMW9JZmdU?=
 =?utf-8?B?bFdtRUVzTW9mSXpRaHBaK1FydWVvcDBDT2VweDVrcEx1S2Nac04yd1E1a2FY?=
 =?utf-8?B?aytOVytoMGpOaFVUbjhOZXlTUUhGb3l1azRaczlhRmxRWmJERWc0aXMrdEd6?=
 =?utf-8?B?ZXhQUk9mYXlLSW1JUCtrVHd4M1ZUUlJiT2p5Q0R6R3c3anF0enlFWXd3dktI?=
 =?utf-8?B?T2MwYzJCTEZPNjVrR1BGUzdRUTBVeHJjMXV5YjQ3K0thVkw0Z1FnWUVTZzR3?=
 =?utf-8?B?a3RLVmdHYmNwWmJyTXh3alZUTVgvQStqbVpJVjI1TDVMUy9sRkhDU1p3bWhS?=
 =?utf-8?B?eTA2dGYrWUpkTStrSi9kU2V0SDBlOXFlMzRsTHpFM3hwRUVZVVA0bkxmNURj?=
 =?utf-8?B?Z251QjVRZHZ0djVzeDBPaXNHSnVHZEtwLzZreXFMaUhFRVdHaUU2czh3LzFx?=
 =?utf-8?B?TmJ3RHZFUWJFeTZzSW5ZQUloL0p3TldvQ1A2ZEUzd3VTNFdpbTVzUU1vdEFV?=
 =?utf-8?B?bUZteFRzK2E0WVNJb1pFRWl2c0RPU0ptRHMyZlF0TGZBWEEwZXBTWFBtcGxI?=
 =?utf-8?B?T0Z2Y1FiSm1LQ2xYQ3Rzb0lrT3Rldnd4emhUcXgxS1VMc3BwSDBaczJFQ0JN?=
 =?utf-8?B?R242b0dCRXAzajlab1JEMGsvU2Z2MWQybTFDd0tDU2pWVCt3Z0kzMlJFRjhl?=
 =?utf-8?B?SnRtR091czBVR2Y3Sm9NZVh0V29ua3ZtcGZYZThkc2FTRkRQM1IzR1lzYUtQ?=
 =?utf-8?B?V0IzQnhBYVhBVTBaUWVoc2xPU2o4bEtEWlNUUmdJWFBjdzl2Y3Y4cGJTRmhp?=
 =?utf-8?B?QWhxWnJUSjdBdHh6dHcyMndlbzE3N09RcXlGcmhIVEpsZzdmMUZhZ1Bxdkp3?=
 =?utf-8?B?Y21jWWFoRE45WmxGa2k1ZEQwT0VObTFZck5XeVdoMUY0TjVucGtjOUVvVzR0?=
 =?utf-8?B?UVM5YkRrKzVFK2o5SWlpUWRRM3JSVkMxK2FnbDhlTElPOXJGNlpaamRHaE9z?=
 =?utf-8?B?Nkg2RGcwSUVnbVQ2SWY5amJ2STlGQU5MZE13dXl0K1ZVZ1Q0aFlMTVRiMkgr?=
 =?utf-8?B?UVh5OUtqc2IzLzNBUkc3d3NuOWFNYnA0VTlabXZZMjFzY2pHOEFkemRTL09y?=
 =?utf-8?B?SE9JeEY2TS9BMk9QbE02M3RwY20vMkM5QVZOL2dxcjNmdUttYkFROThMWEd4?=
 =?utf-8?B?cDc1M3dWNGlWaDgrL1R1Qlk3eHRZZmEwcm1DYlEzd1NWYmNhVCtvcmJ1NkFJ?=
 =?utf-8?B?dnlST00yRFZSSm9rM2t1OGl1alU0cjJneUpEbzVSbnpzYldpTDk1RUhqMjUy?=
 =?utf-8?B?RXIvTHhiRjZLczEwVkg2VEdrcW1Zbi91azBWUmJFck5uMXJzVS9YczlHdThH?=
 =?utf-8?B?a1hhcFA5cC9KR0tQRFdMSGFiSWh3dVc1MnVldGhJTVMyZGFuK1Mrb3dEUEVp?=
 =?utf-8?B?NGFHNC9JdFU2c1lzTUV2S3NYWXY2bzZkTWlIL3lCbXVHcW4wUVcxZDQvWHNy?=
 =?utf-8?B?bC9rRFg1YjFZTUtxMUVGNzlWL2VCRHVqNUlZY0FMWnM3UUxLbHB2MWR6YnpU?=
 =?utf-8?Q?XWVAkPM/YQo3fuZTglxRMJ3ADeuK/eWdUUlY1RA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba89cae-2a5a-4932-7c81-08d8d0641178
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 21:12:28.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTrx5k4wA3MTIpclnVJ+6SJv1/95SQkuoue0k6RVoJArYC+4SWgQzGQljFVTP4Qpa0SQDWVLhNmuDJs5XuyK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1966
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130197
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130197
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 6:10 PM, Jason Gunthorpe wrote:
> On Tue, Jan 26, 2021 at 05:58:53PM -0800, Mike Kravetz wrote:
> 
>> As pointed out by Joao, you can also see the differences in pfn_to_page
>> for CONFIG_SPARSE_VMEMMAP and CONFIG_SPARSEMEM.  The only time we might
>> have issues is with CONFIG_SPARSEMEM.  I would bet CONFIG_SPARSE_VMEMMAP
>> is far more common.
> 
> I think it is fine to have a different pfn_to_page, it should just be
> illegal to combine pages into a compound if their tail pages are not
> linear in the map.
> 
> Matt's folio work might present an option to audit the whole mm for
> this pattern and provide some folio_next_tail_page() accessor that
> does the fast thing - but I question the value of such a project for a
> 2008 era PPC platform with 16GB pages (seriously?) that may be using
> VMEMMAP today anyhow??
> 
> Maybe others know of more modern use cases
> 
> Jason

When discussing v2 of this patch, Zi confirmed that this issue exists today.
See,
https://lore.kernel.org/linux-mm/3d2acb33-57e2-060d-616f-cce872c77307@oracle.com

I will fix up that unexpected discovery in the hugetlb code.  But, not sure
what approach we want to take elsewhere, such as the GUP code.
-- 
Mike Kravetz
