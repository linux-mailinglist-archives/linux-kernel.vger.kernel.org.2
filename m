Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4B446746
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhKEQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:50:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24684 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232930AbhKEQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:50:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5GBk5T005980;
        Fri, 5 Nov 2021 16:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=saQbmYMbmkAGmu09f5nAXHZ2hsAQR5gEY7UWTJGRmKw=;
 b=wfWYCpTunLGaPHvnPgjxmEitjhedMkHMa5boUnYKz7JpzskyvlEtdqRrFtCnM2aaiZkk
 LctWlaH/euGeNEZICCu72iaTR3Wb8dA2tl3OmRIAnu8/ofJ+X6f0Gfhp84MXMc8f3mVZ
 AmXcMHfesXM27tPr+LIF8W1h8lQXGkWC5Y+U6k695l/scSq97gMhJoX/3pQ35LWljYYz
 6SyflmBKATAJmoec9yw7KDa0zGF2PhCbDyKzLs6jsjmFb/lqwJvptcFrbATDY6Q120cz
 kwy1ZZW87UnDl6E+5St+GxrhpcPMEUdFP/i8fFS6e1SgVAMqnSZfjvky2uxdTCpE33O3 Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7q3a3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 16:47:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5GfBuu124550;
        Fri, 5 Nov 2021 16:47:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3c4t5d7bpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 16:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIDhDQmmZC/j1hwyVCJ3mXXhNFTcZbL0KNeUq1aaoPATAsjpHSmA4WMC8WzlH2Pd6Lh9XQrqr1MRvTJykGlDYMnvWNx+5KUa4i8mjW874TXjAkTcFZgK7wbq6y946VSGk5wj74le3Xq82CMJn/mlusS0r9cbEtn1vU8dVf/Lh84kunUBdl8F9G2NBEGxk5xXVYLYRTKYE4je0MeCxHeads31ber4A5Yb5z3JAHbiVj62BT9NpHP0sSyq/axJgC5xSbsi/JJ6CST2KmDV3UlGk1yIxcEEO3eLnwoG1xIClJHrP6a5arS/e8dlxhfGD3+Xzu6plaDRPXtgsCrfDkqPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saQbmYMbmkAGmu09f5nAXHZ2hsAQR5gEY7UWTJGRmKw=;
 b=AX54XeYJ4TVjbhgG9Paobf19NSVv5ebtSqfmsRXToc4j39HMOQQOc+12H7+uI1mCufLwzyRbAAaEV2c5mo7NPy1MRjiHttkD7PEn5+5dabntNO/i1lE43pnIEGMuhkjyzYiUaSigF3ilIOYTudYhnbbhEICk3Rg1rdlQgs7sUOJuxIdAK+CVmBEkXcPHDRHcQYPJ7WeKA/5Q9L8Nr9Hpznm6TzvYACShR/cCVtSa96SXAZE6IVMbYzukZ5BjOvas5oKF0SMwAtcLBioXLx4bRzgqGmA0gMDuIb2iAfESxJqO3R5C5kQ5CAQ81y0Bfw7xytHgREXc5C4FuyXyLLolBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saQbmYMbmkAGmu09f5nAXHZ2hsAQR5gEY7UWTJGRmKw=;
 b=d9l93ts5ljLsxhowmOCsn86l4wbO0S23K+7nys+qMl/a1TNuALrglOVG7x5w0io6oM92oRSbPvLUwJQNJ2XdWOvqS8J083JphkEXa/Ak0X1grmU3cIHZ8IwFHH0VHbrUXZhfJlgJAH15gsV7XY5LnfnyZ9kifMRfudA0Uawspq8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3906.namprd10.prod.outlook.com (2603:10b6:a03:1f7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 16:47:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%7]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 16:47:34 +0000
Subject: Re: fs/hugetlbfs/inode.c:1467 hugetlb_file_setup() error: potentially
 dereferencing uninitialized 'ucounts'.
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        zhangyiru <zhangyiru3@huawei.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202111020447.1sqPrmgi-lkp@intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5a0b1b12-9ed3-530d-4b8b-69332208f580@oracle.com>
Date:   Fri, 5 Nov 2021 09:47:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <202111020447.1sqPrmgi-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Fri, 5 Nov 2021 16:47:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07de5f06-0513-4d05-063b-08d9a07bf73c
X-MS-TrafficTypeDiagnostic: BY5PR10MB3906:
X-Microsoft-Antispam-PRVS: <BY5PR10MB39069477365B1786A07B409CE28E9@BY5PR10MB3906.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:129;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I08VQeNWe36DpuHLIlmPZjCbOrvpFvn/F4KxAh9pKb0e6zpBiYJBBdTp0hb1vqTDgl0OIONAJrXdhZrFzJYJ0CsabGvg5JE1ClIVkwX3bZBvDNQZRSH4c2tArL+9OWEKZgpLGyyLGqBmFW5vpImcBEaD09yMCMIpehNxQIDK0MWiT/GZrhbgwh5SYoP/J5YZqFqSiOVyGz2+i9la6IwoawoNTqcAFt+QSnwZHUtI4p02iahxSHZCMO2i4j94y3CuMPBwR57k+ZNV6nuPKVNUpntuUiTToiAFFehU7euWz6+ik+Nh2ArUIHbB8t+t5nDNTfi23sVroAJQBReFmgK2bFNKsjT8EMQ7cy3JFQEHFIDEB5QSxio6W399yKV7s+rVS8LNnQhaIM4aRsy7+WUMkgQNqTkIq1oz8KhMIXYHA6CC7OxQlEe/4INA3jw/ouVyrzJ/m19dfyXHQKagvDPzeW7bZ20Q8hbkzDuWj18bLJ6+teGrQfrthhJFNNLWeVN78kR1vaplsVTKzMGz0PBnw/jhvUgyO1JdNxcuN29QPoXDYSg0wFS5bqa3jN+/A9L0MjwddTfCfCFODLVrrayJitVrb1K9WfOU5zwzYKyhdk8FW/2olXUgBLtuLBYnTtIBFSXu6DCvtnfgci5kFZGYzMoffQ2iqIxKDjRpOxwl58XxMRpkL/OifLDcjbPrXNFt7eJViFswYkK3U3VQS93eUcAhmFI0GfA5AEfOgWsIjDqdUZXDAmWqfWvjkXAbNcX1QRyXhqa8I7w32OxFg+ISHkd81sUNTKvkkQUM9miqdyDt2C7sfOIfzn8YB9jk5601qyRH+mFB7taawj5V01EX5pGkzLe/5LSDkImkNzLEO44=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(4326008)(83380400001)(110136005)(956004)(2616005)(86362001)(44832011)(31696002)(316002)(16576012)(6486002)(966005)(26005)(66556008)(66946007)(8676002)(38350700002)(186003)(36756003)(5660300002)(53546011)(508600001)(38100700002)(8936002)(66476007)(52116002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZLU2hxb1YzTTJyTlR4QkhGZHg3ekREY2g0RG9YUFVIQjNpN0o1QW1wUENG?=
 =?utf-8?B?UWVUdis2VHRTOGc3aDVoeWJzMmRDNVY1cGFlMXZKNVdtRXd5elkxaTRxeitZ?=
 =?utf-8?B?MnZoZ3dSMUZTMlFzMDhWazdvS2N4dXFsK0VkdDlIaStRYU5BZ003Skt2SDRX?=
 =?utf-8?B?UmVhOTlCeW5wUzR1d0JaMlAvS3FpWjExYVdmWHNjUEtXWktmcVNkVlAxdU4x?=
 =?utf-8?B?bndSazZGcnI2cFNJclVxMEU2YW9uaElCbWNXYzRUUytpeWRVRXZmdmNmZEFx?=
 =?utf-8?B?WW45V1JuYWtjVnRZeFNPU3I5UVBpRFpnTS9Lb2Jzd2FsTzU2UDgvQ0JLbnlI?=
 =?utf-8?B?cFVEVjhoZXUvdkMzaHdRYmh1UGN5a1k0MSt5SUpPbVlGY2FGaHRUayszQmlT?=
 =?utf-8?B?elh3YS9zdkM0emVsbDIzUG5kV2RVbG5MU1BLMlBxWWtwanlSQzF1L0N4Zmcw?=
 =?utf-8?B?ciszMEFkQVhGQ3lTZk9Ib0JjcWNBZVpjcmRwNDZyRHhNS2E0UkwrZzlaV09s?=
 =?utf-8?B?UzNTUUFIMTNHYnBuVDFuR3dGK09EVDRkUDNqN3dWcXl1MDMrWTRyWDJ4ZWRK?=
 =?utf-8?B?WWVEVi80TGx6RXdEZzZaenNnMmlEQVF3NkR5N0FSeTZjUngwNmMzVFZrZENG?=
 =?utf-8?B?ZTVNYjZrd0kzak42YlUyeERwa0ZNQ1N6dVBFWTk0dnRTYXRDT0w4eXd3cldF?=
 =?utf-8?B?cVlIamFMMjNXZ1JneUpETjFodUdyb1lJTTl0OVVRWkkvNXBRUCtPQlVWb2s5?=
 =?utf-8?B?S0pyZ283WFF5SkJzTjd0T2thWnNOU3RCeGIrcWtJWE5iMW15akszUXhzUGlU?=
 =?utf-8?B?bllvVjFCUFFlcVV4OXFaeEt0dmJpQVJkaE4rb3B5aWlhbEovY0tuZ08yRXB1?=
 =?utf-8?B?WjFpMkg1TGhqTnZab3hwMEY3djFRNDlHU0pZMjhkeVhIUnRuak4yenBMeTVB?=
 =?utf-8?B?TmovV1k1ckErQnc4TUZhOTA2M0dMK08zdXJxNHVNSkl5aEZ5Y0tSQXdKT1pO?=
 =?utf-8?B?M3Q0UkRMY25jd0lCQWJEem94T0huZSt3cWVYdlpzWGY1c2xjc3dWWWZzb01x?=
 =?utf-8?B?MEpQbFZmemtKKzR0NlBWRzdzblNDaDJneG43eWlmRFgwM1Y4Zm0yUXhNMjRR?=
 =?utf-8?B?VTZ5SFYyWEVBSTFQK1M1T0s5VU9DVy9QVHFWN2NEUXhIUFhNdDNvU1FNanV3?=
 =?utf-8?B?TnNiSjJIS2ZreVJFTldoU2RZaWNTL01JSTF0aEhPa05uM244OThFUHplQUVV?=
 =?utf-8?B?eDlTM2RERkhqd2NsSnhuSlNteGtnK0EzMm5KSEVPZ1hybVl0c1FSTllzMUZz?=
 =?utf-8?B?Ym9sNnJyYWJFZjFTT1U0NEozQW9QWDF1M2dyRU9uMDFvd1ZPK0JlVXNGM1pm?=
 =?utf-8?B?NWpBb1RiV3g2c216VUNyUUY2dmVJTGJyaU90SHpIaHhibkNRd3ByTjd0dER6?=
 =?utf-8?B?a28yRGNUbnMvU0hpeC9vYktlVWIvbE5ENGV0RHRBRUQ2TURaaXlFa3RXZlJM?=
 =?utf-8?B?OEdwUTNGV25OV015aWlyeTQ1cGRJZ3dZd1dydW4xblIvNnFKYjBFQUZJWncy?=
 =?utf-8?B?a1NzZ1NuclpYYk5FYVpmblVNaVFqb2tVcEVoQ3RCcTFzZ1lONXd6eWhPMlZN?=
 =?utf-8?B?UlN0TGlPZmFjZ0M5Rk4vSFBXVGlNT2dtMjhRaXZtSmtmZGdHT3dUWDAxTmtu?=
 =?utf-8?B?Q3BiZWpidlBHMzI4anl6dEZJTEZDZjJBM2hsOGNiWXJSWExydjZRY2VvTEhB?=
 =?utf-8?B?d0tKN2hyd2NEQnJBOCtXTFVyZmlhMjlBdFlWRERCVXQ5cXQ5Z25haWhlMEUw?=
 =?utf-8?B?UUxxektVVVBvVVlHSm1pL2RJc0QraklzeWhkWHJwRldBWUJzaTRrUk9MbFlq?=
 =?utf-8?B?NXpLMGJyaHExSnhyVWhzMGFDcTFXaEpKRmVIaHUyYUxzNmFjWjdjNXIxTlhJ?=
 =?utf-8?B?UkorVXBQT1FmMkhOcFc5bWl6RXMrRHNWNzd4TDMreXVzZTUzSW1LWVhHNkc4?=
 =?utf-8?B?ZDgvcG5lWmJIcnJqSk1TaWdXbHk3a3h1MFBCQUc0MHdIbkRUamk4enk3YW5E?=
 =?utf-8?B?S2hRSkVZayt4YUZpcHdySEorVXpWeU85d1k4SDE1NkhUK1JiVml6c0VTcGFZ?=
 =?utf-8?B?Q0ZpbUdHVEZhdjEzSmYyTUtDUXZMYVViZkVoYkdwcG5DQy9oVW9TclhWdXRr?=
 =?utf-8?Q?Y34c9hqErk7iBi+yuXBvEDg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07de5f06-0513-4d05-063b-08d9a07bf73c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 16:47:34.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AnEMjxyPgKROX2ncMzoAeznml96N8PBVPHJWps2XyI4GsbNmiz23wsLRCdaZfAU+ABpQWd7Jq0hBlZWACL6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3906
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10159 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050094
X-Proofpoint-GUID: 0s1nzTJAbD5tUeQKeUNYEE7hiY7R4NbJ
X-Proofpoint-ORIG-GUID: 0s1nzTJAbD5tUeQKeUNYEE7hiY7R4NbJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 6:27 AM, Dan Carpenter wrote:
> tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211101-211012/zhangyiru/mm-hugetlb-remove-mlock-ulimit-for-SHM_HUGETLB/20211009-094538
> head:   52edddc18d9541ad72912b32edd74baacc94d504
> commit: 52edddc18d9541ad72912b32edd74baacc94d504 mm,hugetlb: remove mlock ulimit for SHM_HUGETLB
> config: i386-randconfig-m021-20211101 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> fs/hugetlbfs/inode.c:1467 hugetlb_file_setup() error: potentially dereferencing uninitialized 'ucounts'.
> 
> Old smatch warnings:
> fs/hugetlbfs/inode.c:1498 hugetlb_file_setup() error: potentially dereferencing uninitialized 'ucounts'.
> 
> vim +/ucounts +1467 fs/hugetlbfs/inode.c

Thanks Dan,

There is an updated version of this patch in Andrew's tree that should
address this issue.
-- 
Mike Kravetz
