Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F131E3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBRBfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:35:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45954 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBRBfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:35:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11I1Y9RK052475;
        Thu, 18 Feb 2021 01:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OVqA+PbaFmiyjxAVRNx+Uw6lKSpqd8E68DM9sL9ZS6Q=;
 b=m8kqPqrrT/Y+J7sdraOxwaViL2SfQlt/kidSWC0x4hZov+OD1+eo2CcdfIyR/mH8FlED
 ekhQUqPwjFqMt7TeHWtnxpPf+9bIwf04OLhY6QzoASU6+QoV4Z+IqNMcgQpTmId2lcES
 VbNS/dKa55UjN9G3C/3tgxYkBz06nwvUVc0gPX5NnGmzPS7tXtTeJhfV9GXJVo9N9rae
 Xoqz3KXOk4w1vfUyGfB/zy+g/NYiEiqwJB/eaWecMJuwhRUi9wcRS8MR1/trKUYFUSL1
 +zRQzwRKIv1ZhREl/ZD67P1bJLTKek6XYXzInABwf6oQfiP8FxjSHtYGtNEcFAP/T4+C cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36pd9abtw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 01:34:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11I1VdhK147489;
        Thu, 18 Feb 2021 01:34:08 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        by userp3020.oracle.com with ESMTP id 36prhtknuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 01:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdC0Iyp8rLUT1LsV4xhRaU0lsqu8PpMmMtABEVVkCUQ1Q71oNi8qTErTWvtRSH2+RDfRCgdFGOfbrJTBi7VrfR6qkRchr3V/V1nOOJ7feNZINIzVaoh2iw0SqmD+ameaFc5dWYQcy0zIlmOcFapR+m8tgkCxrMNs0kFYk0jNZ0vKIApqKF9tm1TODICqQytadndruhv7jcTGVo7XjRGYUSWOCZBgukXlb5Ycovr7/OnFBrEzVv2h2ezSSrD9v9hqR97n5a/hCxvl5HkixYryR7SK9/aTEdLs/gJXoe7c6lYUKeuTauYZOtYOfanYU6trTeCpRcp8JU/NXDzgAGLIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVqA+PbaFmiyjxAVRNx+Uw6lKSpqd8E68DM9sL9ZS6Q=;
 b=Ae0JD4zw6rwa7S+5Z9vey+jqFXh+gaCNnZ+smblGXK9wwu7a36Kw8yA3iR2wMrn7VHc/c24+Wl3mgcDSdu4duZvtJq7CoHuQwG9iRCxd46muWiKti1IUg1e+1u59K523nquc4oO2fxa8U+dWSPPnIVSEZRByoYYz0f8DGbWwac7sNqCYKJUnHHibS1RbooKGD5gy7SgvZGyzAXhCDhs4KgnDWRleB+edAMb7YovN3yryPlqeNi3MSGiVMWMTQjBa5fwxKKKURSUbSrxGSCqXbyrTDacvVVGITGN63+uxxRNtXu+ULXbOhmKpclZzbjak/Xm9OIDjk4dT+LZQCCYW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVqA+PbaFmiyjxAVRNx+Uw6lKSpqd8E68DM9sL9ZS6Q=;
 b=YFiyL1MAD9oghA/C+nGjYSVGCdJDZ2uab4GIbdtXDBQNyac+LM+UMa6SlS98GcceFwwPbjk4aPQcIKaPj1+aYhIhfr1TysEzafqeV7SLPAGY9Od69quu+nKzgFTy0bakrkuH7irm4q2HYVOL8xwredxKi4afMUQkPjoxZ9W0v/I=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3496.namprd10.prod.outlook.com (2603:10b6:a03:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Thu, 18 Feb
 2021 01:34:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 01:34:05 +0000
Subject: Re: [PATCH v2 2/4] hugetlb/userfaultfd: Forbid huge pmd sharing when
 uffd enabled
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210217204418.54259-1-peterx@redhat.com>
 <20210217204619.54761-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bf4c509b-18d0-a575-81c2-b089f7b2f05c@oracle.com>
Date:   Wed, 17 Feb 2021 17:34:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210217204619.54761-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:302:1::43) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.2 via Frontend Transport; Thu, 18 Feb 2021 01:34:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c048bc85-57a5-4198-898f-08d8d3ad4778
X-MS-TrafficTypeDiagnostic: BYAPR10MB3496:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3496D4DDE246A5876181BCB0E2859@BYAPR10MB3496.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SV0Afgm/WEcC84x91fBz2J4ASuzY/Waa+r7CnIfD+b953+YQ2cyisRRNDNx5xCV1c0X6FSVAM5nF3px8QWPkTKh52HfhF1YbEun8VGCa7Pth1zt5/R0F7fYrCIfsboJ59y4fl6rQQoBgNIGkbkiv4TRM7+Vy0gh53x/lzG9mroHibBbj3uHmYw5nrn+AQ2hY5TOvnFezcacGeXqkXXvD59O14VNV8z810CoG3howZ5ggpo+bgEkNw3DpAOe6gOcD7uZ9j0QjFtIABsMdU1CEzwzcRicy/S5XWJZIpcsoiVCTggpaVq4/nqLIoo7L8do8HA2ot63K837cjc7WJWKBUwBYJYN5h4jqyltyFeUIJZa2kMk4HfQ7BrS8IAFX+idXpJcekV2RtK2eNLF8jVFAdse6Iq0VQEcT5qv9Oc0nNS/5jqla9MRxP4Qs9FC1df7FqFWd79RAub2nFBjjsYSmfyFkO454fQ9i9dDQd0YF+EF1ZvBS/yuyzL6Vv7MVt0zVfupKUd+SBeRUWgVeUVkVDlGFjV6EYf3utVHd8HCkDzQJwCF1bWxxU1SYvxyh5yEtRArgsqvrbsHsZXKXcVxarEyYq0L3/2DuYBqOpwwjYDhWkd8NRYvoT3YVpph7ngr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(396003)(39860400002)(36756003)(16576012)(31686004)(83380400001)(186003)(66476007)(316002)(66946007)(4326008)(66556008)(31696002)(16526019)(2906002)(8936002)(44832011)(478600001)(6486002)(52116002)(26005)(956004)(86362001)(8676002)(2616005)(54906003)(53546011)(5660300002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZW9vRXV4MU9oNGVFM2JONDVUZ1pFcmhQYk1ieVI0V2k0WW1mNW0xRnRGM3dx?=
 =?utf-8?B?V3JwTGpCaUgybnhEVXlrdzZnTXU1KzkzdFhZRTFvMm4xTHJFb2RBN3JjWFVG?=
 =?utf-8?B?OWd0dENjVDJmZ0ZuL2dyQVFYZE5ONXpyenNXNnNkdU1NMmdFTzRaOVJ5OXNw?=
 =?utf-8?B?cFhzWWpBY3NVMjBkUTR2ZWozSjJYbUtGSDMwc1lDUVF2UjdvN0RzMnRJKzUx?=
 =?utf-8?B?SVdyemZSSlliVjRjcDRDclZBb2tMSTNieU05STNlYXdGN1NnL0xKNlhXQ2Zt?=
 =?utf-8?B?TzgyS0lFdC9qc1lVb1Q0cWxoS0RsbUhlc0E3dWVDOEdBRVBZMmFDS2Y0RklE?=
 =?utf-8?B?Tmp6R0FJL2o3bUdEZVluSGNldCtGMlNFVjVqSzRhbTNXdCt4NS9KOEFWZlhL?=
 =?utf-8?B?TWVhQWMyQ3JjeDMzYkJlcTJsTStEbzJWYkJaYzI4RzlwZkJHWUp1R1hlSWI5?=
 =?utf-8?B?eFNuZjZnaGZaRzMyazhvQnVnYkIxcTJwRzJ4bENTSFA0SHNNV3pRN2xjZE55?=
 =?utf-8?B?Q1VMT1Qvb3ZHeHIvKzZBQzRKdk1KTm12aUhTOXNxZGpLYkc1M2lobXBhTFZw?=
 =?utf-8?B?UGdVblR2cVRnZjJ3ZFV4TkROeDNySmZFeXJQQitJelFKVVpRdlFHWmRRR2Fi?=
 =?utf-8?B?NVM2UkEzREdON0FFY0QxSXlYbXB4Z0duSDJWNWxPWjFEUjVXcFl2VDdwb0lI?=
 =?utf-8?B?eGNvT0IyVlBWRk9BRXVKbFlBNHZoYzNEdVdhU3pwR2FHOXVuanE2dG1tekpz?=
 =?utf-8?B?MTZNNjVjVjhvcnNHY1NaRVB0UUxaNnpJWmVMdDIrdSt1N1hIRlp5VjRmZUND?=
 =?utf-8?B?MlNVZ2lKTVhOTzMwWmkwdk56UVlxUERXTmhkRUpsNHhuWmk4TStCc0FMMTVT?=
 =?utf-8?B?ZDdEb0FvRXcvK0Q2blFVRm51M2Y2OVdZTGY4aWpsWWU1UXFPVnNacFJXb0tZ?=
 =?utf-8?B?QUhXMmJmTnowMXhWbm5NeCtOUjdlVE94YXppQ2xqNi83YXoxMFVBV2Zoc1FI?=
 =?utf-8?B?bnZmSDludlE2M1lYQnhacFBYWE9Db2tTOVY2TXVqdUxoUms1YWxHeDNoNFh2?=
 =?utf-8?B?UllXcnIrb2F5bGJBWUY3TzVEZldLSWxXejNtV20vMGFqYjFDczV2aUNIQkxl?=
 =?utf-8?B?d3V4blpKUmdIb3B4cVJaRXUxLzhJNDdVTzVSUWlNMyttcXk4VEJSSHBoUWl0?=
 =?utf-8?B?VmhPZkUxUlB0dDVKMnlFNHRTVmExY09ReGhZMnBnTTg5S1pjeThnWUVYbXpj?=
 =?utf-8?B?ek1WbzJaTmRCdFpWYUJXUlhuOFVsNCtXNy9iVnRtdEcxNEdJUElYYjFZUE9v?=
 =?utf-8?B?SW9uQU01MlkzcFNzU0xJQ3JtMFEwVkg2WnNCZHZxMnBZZWtrUGVVbUxRSkRy?=
 =?utf-8?B?THZtak1PTWY4UnF4UnQvdEVzSjlpL3cvc1dsV3ZkSE5QaEExM0xXQXhaaEdp?=
 =?utf-8?B?blRHY0x0QnZwZmxkMEo5WjM4cE5xcDFvOXlsV3hRZkFJUzltaXFmaHgzZFho?=
 =?utf-8?B?WWtmSE1Jak52NjBuZ3hKRHdCcWNHb2RDb3dTUEtTMjRHanJSdXZkT3RpS2ha?=
 =?utf-8?B?eGlsMVFjaTl6YjFtdXRudWlXaTFDdnFHSHQ3QS9tSVpjUkUxV1V2dWJ0M1My?=
 =?utf-8?B?ejJ5RjBXZEJoSUZOdDMyenk2dVkxbmQ0aHNUdTBIZmxDaVQ3QTVsQlRLTzRQ?=
 =?utf-8?B?K1ViNUdxaUNjWHorWi9CbmV5akpRMjJYMWoyTURabG1CbzVIQUNUUkxjaDQ3?=
 =?utf-8?Q?SLhrQBkceFeZSE45QcEjrCDn47YDQF9nkYMqNrY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c048bc85-57a5-4198-898f-08d8d3ad4778
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 01:34:05.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwBbILI7jy0AEeiPX52TP38CWRuKe3bHlJLM6Hzi7EpTY1YuOnbn9KPDaz6Trtcl77UJrvF5koZiP9aw77Qd+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3496
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180008
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/21 12:46 PM, Peter Xu wrote:
> Huge pmd sharing could bring problem to userfaultfd.  The thing is that
> userfaultfd is running its logic based on the special bits on page table
> entries, however the huge pmd sharing could potentially share page table
> entries for different address ranges.  That could cause issues on either:
> 
>   - When sharing huge pmd page tables for an uffd write protected range, the
>     newly mapped huge pmd range will also be write protected unexpectedly, or,
> 
>   - When we try to write protect a range of huge pmd shared range, we'll first
>     do huge_pmd_unshare() in hugetlb_change_protection(), however that also
>     means the UFFDIO_WRITEPROTECT could be silently skipped for the shared
>     region, which could lead to data loss.
> 
> Since at it, a few other things are done altogether:
> 
>   - Move want_pmd_share() from mm/hugetlb.c into linux/hugetlb.h, because
>     that's definitely something that arch code would like to use too
> 
>   - ARM64 currently directly check against CONFIG_ARCH_WANT_HUGE_PMD_SHARE when
>     trying to share huge pmd.  Switch to the want_pmd_share() helper.
> 
> Since at it, move vma_shareable() from huge_pmd_share() into want_pmd_share().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/arm64/mm/hugetlbpage.c   |  3 +--
>  include/linux/hugetlb.h       |  2 ++
>  include/linux/userfaultfd_k.h |  9 +++++++++
>  mm/hugetlb.c                  | 20 ++++++++++++++------
>  4 files changed, 26 insertions(+), 8 deletions(-)

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
