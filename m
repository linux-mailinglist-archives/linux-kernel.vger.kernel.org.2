Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2744B437FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 23:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhJVVHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 17:07:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11746 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234214AbhJVVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 17:07:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ML2uRl001769;
        Fri, 22 Oct 2021 21:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3gokYIx3d+tCrjuacuD7lu76AK/scCZp9Rw1Nv0+0O4=;
 b=CgQEHW5uhoaRFm6dlBeHyiuZ4uj2B3R47WG4uSnCPDT0ScX9e1gtujm/PhohBI/71FLq
 RUmQux8XFmLr7Ixr3AEr8oNjIkmehDerBzqW6CYZYb3YRtV5hBeW1U8UsSODMFFcT9gD
 jhtJ6eM9Hl/LL/fn/Mvvy38ycTGhxyEYrqwYSLP0m2YnkzBeRxNqSJZyquORUjG5EUaC
 vN14q5o+oerx1p2m5H09q109PqITXhfluQHq9qx1ug0mXo32aKrqCZJfHimZZmJZwOsC
 u6EWSeJGdfKT1HWqs+UtfbazrLL6EYvWYPUlD9HqZGk/hqSm+f9zAHFoa/YPxvBSkf1E PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bunf9ca18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 21:04:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MKxksa136553;
        Fri, 22 Oct 2021 21:04:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3br8gyhhtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 21:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU8uaaQp1eJBi/SAPPgM+EEh0i/3ce5iB/C9lH3Xwk0nVyPglIOFUFBm0kFuA2Pzz0k2Tza8FzXar1WSGP9+r8NfHObfawTPv41mdXEqnEnw7drJAc++q1zTuy2ARTzDaCy+lFKKu1ZVpCGg/6ipw4TIP0GfYZVny4oyX+MU6X6QXwniSi8g+WhzB15gcavIGHZTjYgK9fzpXZoYMEfYJxlrNyKAhaqz9VXZXIVrwoY6Ud09AHPhkhRe4K8GjvsMLxs7IjECa6EZS6fsKpA/UwKGJlXtbwvEv5cIY0oCzbFD3N8+U0t0Y0AI/t+Dv4cmAnsaaEm6kOrYBuhwRspPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gokYIx3d+tCrjuacuD7lu76AK/scCZp9Rw1Nv0+0O4=;
 b=jCazNfCPZZnEnaC8fQCrI8ccouvKyIauXZ5WBITgKS6SBmSVNCHGRGVu3TZg89OKJYD9NgaU8jvLgtkCL2HqN9bXf/y+txHBP8vdXwdoVezNRldki3ffLaD43Pb3fJLWqQq6wIDk3tE8hRz8oxDMmgyFBc/GJqv6KSgBizkMatQczwOn/dOdIhbVfgmHzTgPi7rjYnuJ527/U666iFUjTIyyB1FxNJm7efhATf6oL/i3z1PJ9eVqs+lev4u2dV1FHKYk5/PEJxNMSc6K7aN1IgXfACupmFOZzioeIP1WcBMpe+iA2pocSBXId2lMa21k6NLEZTbGNIXXASjTT8o08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gokYIx3d+tCrjuacuD7lu76AK/scCZp9Rw1Nv0+0O4=;
 b=DZbQrO3VF0xk5dHGBspTAzRdSr1Y17lV3g7aPkaPDtBSIEMCKSSpj6/QyOi3YwAEFx7+AmRqXaS1E8IpDYfC8/0RrDpX4M06A8dQW1CRi1trcsnVl/PoPMRA59WNuxOJ7Jm3pamZ4AdNRaGr9jqPycMcrBgrT+ZRXg/6gY2MNXs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2598.namprd10.prod.outlook.com (2603:10b6:a02:b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 21:04:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 21:04:25 +0000
Subject: Re: [PATCH 3/4] hugetlb: Remove redundant validation in
 has_same_uncharge_info()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
 <97fc68d3f8d34f63c204645e10d7a718997e50b7.1634797639.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <db6aaee8-f020-c93b-1c96-de9fcdc57e2d@oracle.com>
Date:   Fri, 22 Oct 2021 14:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <97fc68d3f8d34f63c204645e10d7a718997e50b7.1634797639.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 21:04:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9954d5-72c4-414d-81ed-08d9959f8740
X-MS-TrafficTypeDiagnostic: BYAPR10MB2598:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2598DF54DEBE614BBB8017FAE2809@BYAPR10MB2598.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7IZqdzcoaIP7iobyVQwE3AKtMrgVHTiAQ070Mb8vmUbwDGSOhrwkWhXgvNsbobKQjlPjrRi9V/fCshkbLMR5+sb5qEBE8Fery2Tyde32k9BdwIYJA+Ewh49K/aLVqhdGIPm5OdGNdpFZ7qcz3r+IiMQPqB4IBf4F/UDcRjSkk7Uyrdmtuh0Tj6t5uI3TjtYz8PhzUpLrg6GiGhPg7OkiZ+D0CNIq49CO1jTlEs52LkXyYcbuP7+J3vFFGmU5GNKzJhW2uv6EtflS6/z6Vax3G5ntgaJRNO+aDlihUtlKoHFmXiE9OciLJOOG+90AdcPzYxca0xx5335V1tocq7Xw8DSeNJHgaa7gkWyGeyAIjA1sffSytgVnsXCWsi4t8ap2iqJcqaqECNxMNQ4ylHxvYtbZwK0W3wwsr0swEOgYVMZH0rpOkV+j/R9qELxaOw0oV9zDWJGO514MWlHxT/51zJ6Q617lNUWdfBQTtf+xEuo1xSVzP3FvhqKffcGORRgmPQ9xATmnL2/Eu6W/0nQfjwqGtK1sQEnOjNqPIkNVDUTZdmgLpRV1Y1YRb9dcFlhzQOfBVlbyBZAFi50Q2aPLNFdtXdlXrKS60ud4gIdQ3YEUu5IDY18Mn4X1aiAJYgi9yr1u/3/Z3kh2lVyMoI3/cnNUqvdwIJAg3b2LXrdfp+xxFc7xxEZ39Dolyksfc3xmWeedI3P4D8NnYLqwIBeB7prP/cMEipPZq7JovJsQBB+omxxgEtVDu/UHJCobCmTxKaM2r4pxXJpb/pcdrNHsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(4326008)(31686004)(26005)(956004)(16576012)(2616005)(316002)(31696002)(186003)(53546011)(36756003)(86362001)(2906002)(5660300002)(508600001)(8676002)(52116002)(8936002)(83380400001)(4744005)(66946007)(44832011)(6486002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFjOGQ2RzFzeUN1cWdBSzQ5TWY5ZXpOdE1QWmUzMWNaZ25Gc1A2SUpncHhP?=
 =?utf-8?B?TmRDT2tDTmtzRTF1TTg5Yi9jYUpFUVQvUjhZQW9meE1BbWhPbFVDTFJWbHhv?=
 =?utf-8?B?Q3R4c3ExTUlNN2szcm1sY1E2Ymx6V1BxbkUvSnFwdGtQbUtrTGZaeFpvcTFk?=
 =?utf-8?B?UW1qSmRaYUc0a0x1TDM1MHlKWnB2Y2ZuVzJoenY3NUhrWklmSWNnWkJJQW16?=
 =?utf-8?B?dnpJazMwWG9TakFMblZraG5JaGtiaCtBNkw1NmY1cDVkVjBsWVhLTUdaS0RZ?=
 =?utf-8?B?dGxYd3FmOUNzYk1GVUJYdWx1eGhVVW14ZkJFY2FaRjZFS0NXV1k2UDJuNnJY?=
 =?utf-8?B?UXdHY0ZDOTYwZjA4UHpaWWgwRnJKci9RS2lHeGNBc1Jyb1R0UENiSTd3Mm41?=
 =?utf-8?B?ekE3cDllc1k5RDZBUEJvdTRGaFhnSzV2VU1jb2djVEtabnRGcmgwT3VNaER4?=
 =?utf-8?B?UWY5aCtPbm1xc1R6SVlrZk1VMnMrVnZvRTBRQkh6di9Ma0lnMk9qM3R1V3JW?=
 =?utf-8?B?Qis3VWFqQThrWHI5Z1dKckpaWEN1WVhLQ3FObjhCbzBzZk5tcHZNQUNYL2lx?=
 =?utf-8?B?YnhraWp4bVVnQVdXcUJmYVNYR0VFOVpXVGxiL3A0S0FTMFNlVFNpVVptcnF4?=
 =?utf-8?B?aE00NFVkZmErV0RYNHVWZ3BBOEdSWGg4bElma0NnVnpJaXcvNzYyNmQ4VlZJ?=
 =?utf-8?B?a0I0NTgrYmRFYnNnc1hqQ1I3VEw0VlNFeSsrR283cWpxMnpySEdaOFFGTTFr?=
 =?utf-8?B?VlVxd2lmMy90QzBRMkUzZGhQYWovLzNQTmFXeWloZm1qUk1XRVVnZFR2OFA1?=
 =?utf-8?B?ZEFLTGtVc0pJS09aNjhURXQ1TUNkdkRackRiL3lBSHlBUXhNU2Jha0hsWE5i?=
 =?utf-8?B?dTNKSm51NUFLaEdaWHEzcVhhaVAvU0k1Zk1PRzRVeEFhb1JnK3NMK29JREth?=
 =?utf-8?B?a25yUWR3TmlDSitLSFAzK1VpZzdKQjRpZXNZYUdUazE1eVhYVy9rTkxMRjVw?=
 =?utf-8?B?UWwyWFZjN3RHVzZTeUMydHNobDkwOFRMSmxtdzNFMnpNaTJKeW9WakltbFlN?=
 =?utf-8?B?YUxyV0YzM3BJaUozY1poQ2x3a1Q1ZEZEZXRmb0dXQVZCdUl1RVFzQU1hRlZM?=
 =?utf-8?B?U0E2c3VpaEhld3Vmb2ZRWVVwa1VILzQrMVdGNkJ6THRDNDdlbTRGcHRiMlRh?=
 =?utf-8?B?bExXbmVkaUR2VzZLS3Z0R09kSWtDM0FjSXVtOGlCZXBnZ1B2N1JvWUt0NFFj?=
 =?utf-8?B?eldZYmRYWEJXbXU5ZWFXYW1sQW4xZHd4anplSXRMS2piV3p0N2Zxc1VFa3RT?=
 =?utf-8?B?dG0zbkRUcExsTksyK0V1a0hNMys4cGRMd0dUZDV4cndsMitSWGRsSnM3bTJH?=
 =?utf-8?B?K1JsVS91L1dWMDMzTzJzQ3NLakdlbWtYa3FvRGg3OFFiZVJFanlYYjNsZjkr?=
 =?utf-8?B?QnVXZlhXOGFvb1pnNVBqSVA3NG83c0xySTIwVEw3aFdZcForUVUyZ3FtSGN6?=
 =?utf-8?B?SGRzOUZHcWhQVTVsWk1XTy9yNm81OVllcnNLQWZ6dHhsUHpCRXZBZDhBWU9G?=
 =?utf-8?B?Q2ZKUkZkWlR2eUpjWmd6OWZjeGRsM2IxQ05Pc2c5SXVPSmNXRUpQWWNuVkUr?=
 =?utf-8?B?REZiU1cxTllXM2RjeE44TXVZWjAwaUVxZkhWZWZkQzNUdzZxQlgrREJnWEcx?=
 =?utf-8?B?QlhGZW9YKzhVdFNtU1JEY25QcGI4VTVhYWpSUDJCN25vaG5LbmlQL3NIdnFl?=
 =?utf-8?B?YUdUQU5seG0vWHA3YVJoaTdJN21WZVY5NURHU2tQYUdyZzc3TkJsTEJKczlW?=
 =?utf-8?B?ci9KVktGSzlIQ0llUVNpUzFqS1RIditvRENMbk1CTnRwbnFGK2hONkQ0Mkpk?=
 =?utf-8?B?TlNvb1JHQ3RJOUxpWGZYSnFVUGZhV0dzbktxSzZWc3Vkb0xFV1NjZUNrME5i?=
 =?utf-8?Q?+umr5b01/vvFIHI7CE06Kdr5xPR4x02U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9954d5-72c4-414d-81ed-08d9959f8740
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 21:04:25.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mike.kravetz@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2598
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220118
X-Proofpoint-GUID: TXO3GnVPDwif-O105SMqbSXKbTc3hXiv
X-Proofpoint-ORIG-GUID: TXO3GnVPDwif-O105SMqbSXKbTc3hXiv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 11:31 PM, Baolin Wang wrote:
> The callers of has_same_uncharge_info() has accessed the original file_region
> and new file_region, and they are impossible to be NULL now. So we can remove
> the file_region validation in has_same_uncharge_info() to simplify the code.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8902b07..5922629 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -333,8 +333,7 @@ static bool has_same_uncharge_info(struct file_region *rg,
>  				   struct file_region *org)
>  {
>  #ifdef CONFIG_CGROUP_HUGETLB
> -	return rg && org &&
> -	       rg->reservation_counter == org->reservation_counter &&
> +	return rg->reservation_counter == org->reservation_counter &&
>  	       rg->css == org->css;
>  
>  #else
> 
