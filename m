Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642E8314135
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhBHVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:04:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57752 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhBHTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:53:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118JoGjj142315;
        Mon, 8 Feb 2021 19:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OHxqPVEsfmokMbR1eGMJWIA21cM8dSeWNRHTulnj2uw=;
 b=R9QF2xXttjRB8Qfahqc+qhSZDNuISTVfoJ0ETGZXp6tbTXFHZaBeGlbxTKgG2U0t3IwX
 CLM1TgMVYXAiV8ZDWIFnoFXjiwadgiiJu6kaGnvt0bGpXaBd+s7Z84+xWVSaOFicE8gM
 q9QscJ262Sye1C9O9yixbxLb+bo5wtGKZKGTEEGGZEfvgaUnHyiupeFJ1eseScn5MQvq
 01gXkH1i2Fg4PzRPUwE0LGIUSsY2r72BrcE9Ra6e6pHp4xP5J6BnZuZjC2jBMoRkwe/h
 TSSre+L3bUiouGdaJQmzjt74n2W6m4HKMYzBykWbtSC1MAYN+tWWpNXel3vWtDySvLNP ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36hgmada52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 19:52:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118JoZip045357;
        Mon, 8 Feb 2021 19:52:53 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by userp3020.oracle.com with ESMTP id 36j4vqbpeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 19:52:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zke1aJg8bcSAtIIQwWOskovHgbgTraYSbdzaf9l07cDOgIq+IHQzpSht5NYb/CJBBirJKrbEFVerIcCKkd5TFE0vi4u7yqbXmT7hUD6Xcsuotm2QlDMhhL8TEYgfP1zTXIqgakkzsfZ3v3ROYbmDB6kUds07ARt/oRCTuFzJsj5b8zkr/wuFJ6GdWprv240ocfbB+n8RDg96IBzYWVrG5Q/6CvF2www4i3kB3mOoNWWcimMCm6E57aBWwKkRs0TmrGb8p2nyg0TF1WUYcQxNoU+GfMxYizYO/dx9ssJ+VoY1qn9eRtu51T/FbpwStoAzP6h5PboegnFakNpmyLnrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHxqPVEsfmokMbR1eGMJWIA21cM8dSeWNRHTulnj2uw=;
 b=Qzv7kVh0DxDRNFrmZ00H5VUIysINEOUD76x5jqTgflz7b074lbNgsVrt5a60aO2+Xf4VMpWSd90xInxXb868kz4IXtw7WXekJDi2niYxERhZ9p6U/jrA7pGw/vS1jWCKEIK7W546at28g4lOivy52vf9o7wl23+fTedvWRCtu+n3SVlhicXMoD8qX3zGSIN2BZppfxoicYgNxm02Vq4bjF2yvG3EsRHcu0/Tzmi2tMPe4bB8gQCjFznMER72UYL6IZTQaDyoaPp1MG4iMv1leNJDLZow04iesUAO9IBxxUBKU/NRE9Cq/+Z2vdAx8YKISw+saTcTdRGRTbDt7WkCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHxqPVEsfmokMbR1eGMJWIA21cM8dSeWNRHTulnj2uw=;
 b=Tq5MN0Ms30OGMVI0L3x5K6LpA6MNQ24lLANovn3QRjqoa9zc0WeuukI588xg4OxRfWiytsARXy5n1JDZ4+6C3TNVmsczTXl+0tz8GQpKHYH57Agmrh4zPNAM4giy1c3mziljNH0ALP4A6NTboTbqUhVdGwUUYV3lWasbsqNsPy0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 19:52:51 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 19:52:51 +0000
Subject: Re: [PATCH RFC] hugetlb_cgroup: fix unbalanced css_put for shared
 mappings
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     almasrymina@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210123093111.60785-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <32100d84-8a26-2f8f-303f-52182ce72f52@oracle.com>
Date:   Mon, 8 Feb 2021 11:52:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210123093111.60785-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:300:c0::32) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR08CA0058.namprd08.prod.outlook.com (2603:10b6:300:c0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Mon, 8 Feb 2021 19:52:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25336fd0-f929-41b5-1410-08d8cc6b1deb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:
X-Microsoft-Antispam-PRVS: <MWHPR10MB16957D0C6A4F589104B6DB91E28F9@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTylvm89uybzrRiJUrEdTIQD5TaxqDepabi8IbizXgQSL9UMalww/49/KUaNQ497r6piGPAzlwOZnbImF1wOVCsq+Wd0RGjvjLUg3k8Vmyj2dxkplX7VYYwii2h4QQMd6gqiAK5axIMOHAuMICaCxr717nMNFMZjsBH72Up5/sDgw3QGpwagVi1qqpEDb7RmhKdwHW7kJCiPrbRYAbFeFy2703VDHCOFEprNNl2ijIZnswAKZW8oQs642HPuFchL/807dMHOGwaGdgDmlpisa5H28pxZOLGJF7jP9PyCYxe5vvAZsc+fVF2S+J4sgGVbh1psiV+ui2mB4D82kqoWJ6E+GqYhy29hK/Lp8EHN/ZSM8/RcdLJ0BbgeeMbTqwhglga+XWn6Wl0YFS0Ie4555ovG43FmRsOP7VMAJT4aTKhDSVXuu1S5WwDhodplUWzNJGn43lC4W8MoZepndtnvOtdK8BI0ZfYK2X/ty7rgL7PQ7VXFhimyxWkH7q7PQx2TDFq7hrOCeYn15dxRk7NYaZPOSolQUQ8Hn1D57B0p102R5KlLK3ZnhjPYW+jr1aTChZsN2DosPpbgaB36AqXAduLr8/QeivT1s1leLo2jZDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(186003)(6486002)(16526019)(8936002)(26005)(478600001)(5660300002)(53546011)(2906002)(66556008)(8676002)(66476007)(66946007)(2616005)(31696002)(52116002)(86362001)(316002)(4326008)(36756003)(83380400001)(44832011)(956004)(31686004)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHRUckVCOTBqL0pqTHpHNUg1djBSZnRGa2RqTDZrYXl2NGk1NE5JVXQ4dWU5?=
 =?utf-8?B?MDRwMm9jVkVja0twT3lTekc3UmZia3VUZGlSMjE5Rm5RSmlEbERObnJJend3?=
 =?utf-8?B?blN2T2ZBQUo1NmphN3Z3UUx0OGw2NEVuQVRFaUhIU2NBSkVzY3lFU1ZjU2Uz?=
 =?utf-8?B?WXFUZDYzUElHTFhYOHU2SS9LaThWWHlsWURmVGdkL2hVTVc4YlFxNW5Lamt3?=
 =?utf-8?B?dDhoUlVzMGFnZm1IVXpVMFkwZ3FwTFF5VEpBQm54OTR5NkVoK0VTR21rRFZN?=
 =?utf-8?B?NkswU1Q4WVgrYUJTSjY4RXdMeHU1am1nczZVRkthSkVkbStJWEVXZHYrSThv?=
 =?utf-8?B?ZEtUYXpwbGZISXNReHpiV0lPZ3FJeERyMDh0VTdoWDBvWThsV1RWbVRvY1pN?=
 =?utf-8?B?ZyszOXlCTTNTQ01HZ0FtdGtldHphRDJGRmhkczZqU3dVbFhsY0dJaFNjUE1H?=
 =?utf-8?B?cWgxUXlNc0w5eDYzRDEzbzFRZEI0UVNVdVNtbUNBK0tkNE9WUEg2U3dLWGFj?=
 =?utf-8?B?WDVScWJ0SE4zUzBZUCt5d1BqZTJySmluOEQySnI4Qy9CT3pWRC9CclZYNEpH?=
 =?utf-8?B?c0NtbW5scWZpL0I0ZEtHcWlvb1pCekhseE12N0YzY3JFbks1Kzk2ZUE0UjFK?=
 =?utf-8?B?UFRZeXA4bGxPcUdINUhZVG1vay9nUlA1U0UxYWVXWFlUdHFkUDZBYXpmcjVr?=
 =?utf-8?B?b3AyL0JCbEYydDlmSEZ5UWM5VXQwV3hicS9PUnlxTSt3TnhGSTR3YmJHa0RM?=
 =?utf-8?B?MjQxQjJ1R2E5REo4RllGUXRsd0hXQWt5SzFLYkhNQUhJTyt6d1YvaXJHS3FS?=
 =?utf-8?B?b0YzSG5DZU5kRlY4VVUwTnhKZUlWUDUvVlVRSnpCdmFmQlA4eldyVW1qcU03?=
 =?utf-8?B?ZW03Ymh0YWx0S3VJZDlpTndaLzFyc0lJWGNZWDJSR1kwOG9KS0ZKbFRUdE10?=
 =?utf-8?B?OHhoTEt3V2c1ejRkWWhpNjhMQ3RzNHFVR2djRXg1YXhPb3Y2UVJqdGF0dktx?=
 =?utf-8?B?V3pPL1k2eFN5aC9tNVpuQlEzd2NpRjVHS0hISXcxdUhhd095Q05MVHZUbkdy?=
 =?utf-8?B?V0xqOEx1Tm5zRWZvSGhHSWNMbU5XeE1TODVpTGtaQnozYW5nU0tGa3NVOEs5?=
 =?utf-8?B?dGhZdXdUT0tUNUttallJT1J6M1hCcVRxLzBGYnVKNStpZk5jSG95NW53VElz?=
 =?utf-8?B?aVQ1N3FXb1dwRWx6dWY3OFg5aVpEWklHTmpaWFlCaU0xQmhxTWxuMmNlR0h3?=
 =?utf-8?B?clhmWUM3S01BSzJENTNqZUVqMGRkY3lPRTR0VGlVcGtTVGJYdjNjcFk2OWdV?=
 =?utf-8?B?U1ZCNStZZUZVU2ZQd094cjREck9lYUpsdHZRL3BOQVllQ1VJc0lRVGg2WlZj?=
 =?utf-8?B?anU3NVVoTE9LYm90ek9xQ3NsbjJsRnFBd1N6YmhEVE9MM0Z2MVZRaWpTeWxY?=
 =?utf-8?B?emhndGpUT2lYUThsSXVpTGYxdS84ZmxzNVZuWlR4bTVMVDJkeDNQcHNuREti?=
 =?utf-8?B?Y1U3b2VGbEpwbHVDQTVaZDJEL2ZzalFrV3JIYjl5ZitSNVVDTDVlNllhc3B6?=
 =?utf-8?B?eEhBNU5PV3VSSmVYaDlBU0RQUGQyTEtPaDVJQS91M3hNamx5MlRxQ1lIMmk4?=
 =?utf-8?B?R0c3ZVJtNENDS0cvT2JuQWNMOTRVaGZMeW5jcXJObEZHNEdzdlZNWmpSNTJL?=
 =?utf-8?B?Yk5KMkxKRW1NVmdDd2tUSURFR3luWld0anRNbitZdEZMMWxpbVNhbTJIRFFC?=
 =?utf-8?Q?2cnGlTjSRUHm/hYYCnulfaGVa0rqwZJQXIbdxjq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25336fd0-f929-41b5-1410-08d8cc6b1deb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 19:52:51.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hbRO6+lua1jbCkDQkrr3021nYo7s0w7QFOIiNfjdy+YBQqS1DeNVIaXJQSAWPmEASccMiE0ZC3CNBO+TdzlpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/21 1:31 AM, Miaohe Lin wrote:
> The current implementation of hugetlb_cgroup for shared mappings could have
> different behavior. Consider the following two scenarios:
> 
> 1.Assume initial css reference count of hugetlb_cgroup is 1:
>   1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
> count is 2 associated with 1 file_region.
>   1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
> count is 3 associated with 2 file_region.
>   1.3 coalesce_file_region will coalesce these two file_regions into one.
> So css reference count is 3 associated with 1 file_region now.
> 
> 2.Assume initial css reference count of hugetlb_cgroup is 1 again:
>   2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
> count is 2 associated with 1 file_region.
> 
> Therefore, we might have one file_region while holding one or more css
> reference counts. This inconsistency could lead to unbalanced css_put().
> If we do css_put one by one (i.g. hole punch case), scenario 2 would put
> one more css reference. If we do css_put all together (i.g. truncate case),
> scenario 1 will leak one css reference.

Sorry for the delay in replying.  This is tricky code and I needed some quiet
time to study it.

I agree that the issue described exists.  Can you describe what a user would
see in the above imbalance scenarios?  What happens if we do one too many
css_put calls?  What happens if we leak the reference and do not do the
required number of css_puts?

The code changes look correct.

I just wish this code was not so complicated.  I think the private mapping
case could be simplified to only take a single css_ref per reserve map.
However, for shared mappings we need to track each individual reservation
which adds the complexity.  I can not think of a better way to do things.

Please update commit message with an explanation of what users might see
because of this issue and resubmit as a patch.

Thanks,
-- 
Mike Kravetz

> 
> In order to fix this, we have to make sure that one file_region may hold
> and must hold one css reference. So in coalesce_file_region case, we should
> release one css reference before coalescence. Also only put css reference
> when the entire file_region is removed.
> 
> Fixes: 075a61d07a8e ("hugetlb_cgroup: add accounting for shared mappings")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: stable@kernel.org
> ---
>  include/linux/hugetlb_cgroup.h |  6 ++++--
>  mm/hugetlb.c                   | 18 ++++++++++++++----
>  mm/hugetlb_cgroup.c            | 10 ++++++++--
>  3 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 2ad6e92f124a..7610efcd96bd 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -138,7 +138,8 @@ extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
>  
>  extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  						struct file_region *rg,
> -						unsigned long nr_pages);
> +						unsigned long nr_pages,
> +						bool region_del);
>  
>  extern void hugetlb_cgroup_file_init(void) __init;
>  extern void hugetlb_cgroup_migrate(struct page *oldhpage,
> @@ -147,7 +148,8 @@ extern void hugetlb_cgroup_migrate(struct page *oldhpage,
>  #else
>  static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  						       struct file_region *rg,
> -						       unsigned long nr_pages)
> +						       unsigned long nr_pages,
> +						       bool region_del)
>  {
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a6bad1f686c5..777bc0e45bf3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -298,6 +298,14 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
>  #endif
>  }
>  
> +static void put_uncharge_info(struct file_region *rg)
> +{
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	if (rg->css)
> +		css_put(rg->css);
> +#endif
> +}
> +
>  static bool has_same_uncharge_info(struct file_region *rg,
>  				   struct file_region *org)
>  {
> @@ -321,6 +329,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  		prg->to = rg->to;
>  
>  		list_del(&rg->link);
> +		put_uncharge_info(rg);
>  		kfree(rg);
>  
>  		rg = prg;
> @@ -332,6 +341,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  		nrg->from = rg->from;
>  
>  		list_del(&rg->link);
> +		put_uncharge_info(rg);
>  		kfree(rg);
>  	}
>  }
> @@ -664,7 +674,7 @@ static long region_del(struct resv_map *resv, long f, long t)
>  
>  			del += t - f;
>  			hugetlb_cgroup_uncharge_file_region(
> -				resv, rg, t - f);
> +				resv, rg, t - f, false);
>  
>  			/* New entry for end of split region */
>  			nrg->from = t;
> @@ -685,7 +695,7 @@ static long region_del(struct resv_map *resv, long f, long t)
>  		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
>  			del += rg->to - rg->from;
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
> -							    rg->to - rg->from);
> +							    rg->to - rg->from, true);
>  			list_del(&rg->link);
>  			kfree(rg);
>  			continue;
> @@ -693,13 +703,13 @@ static long region_del(struct resv_map *resv, long f, long t)
>  
>  		if (f <= rg->from) {	/* Trim beginning of region */
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
> -							    t - rg->from);
> +							    t - rg->from, false);
>  
>  			del += t - rg->from;
>  			rg->from = t;
>  		} else {		/* Trim end of region */
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
> -							    rg->to - f);
> +							    rg->to - f, false);
>  
>  			del += rg->to - f;
>  			rg->to = f;
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 9182848dda3e..8909e075d441 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -391,7 +391,8 @@ void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
>  
>  void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  					 struct file_region *rg,
> -					 unsigned long nr_pages)
> +					 unsigned long nr_pages,
> +					 bool region_del)
>  {
>  	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
>  		return;
> @@ -400,7 +401,12 @@ void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  	    !resv->reservation_counter) {
>  		page_counter_uncharge(rg->reservation_counter,
>  				      nr_pages * resv->pages_per_hpage);
> -		css_put(rg->css);
> +		/*
> +		 * Only do css_put(rg->css) when we delete the entire region
> +		 * because one file_region only holds one rg->css reference.
> +		 */
> +		if (region_del)
> +			css_put(rg->css);
>  	}
>  }
>  
> 
