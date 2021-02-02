Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9D30CE23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhBBVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:42:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36902 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBBVmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:42:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112LTadb174624;
        Tue, 2 Feb 2021 21:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2npQ4xOVjhaxbnFAsbJkWyEW1I2i3KEzIUcOYLKLtbw=;
 b=pKLoxznO3XDZvwjO1ZxDyWmgqGuMzOHtI2Fwsy8apu4QMc73ftsFJeo+vD91GazpILH4
 xQi0F5B8zv2IeIp9M1NMklSRhYhSvoT12v0RzeV04i4QvS0zl9ApiEhkKC8uRuGpzif7
 onqf2Ny56Xr8bv/D5uxKbo5H1xXrZ9Zexdf322lUHV7xtGtI0dDGCg3Lj9hO5FOLTnod
 69iuxvRaHwlxS1xNo9liy+ut2YaPrevf8AmF7xJ0VD4lhdKRSIn2crhTusDZwjwW6709
 ftS/7DyTPrK5a81dM2ZVCcNuMR/5TpY+vz4FzHa9aonPrf6ArGIrsoXHRY1+2WqXOGJC pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36dn4wjw5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 21:41:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112LUChx017498;
        Tue, 2 Feb 2021 21:39:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 36dh7s6ypq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 21:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiR0ZcfzKc3F1ivu4lxleM43Cu05Si928iaUWxnbq1UDF8l22Lj0S8/z+qs1akyANcTLwySZWxyia7nwOiJUGrQeoGSDIcrXNmSN//IPsZRNuf6+wkju11jDHEoCIkk/eyY1oFJiExdfp6DNlFh+IMpZH94oY8qAokW4rRCcos++IQsOR1xXEFzQT5jU8cGCQHBzx+bgNpP4WpxI2tu4A1eLu7u0R+DoYWLJdTr/7GpNOHtuj4yW/squzIhIxTR6hwCfqzfGln5U//G9k0vCYCDQ8PdwERcJeTTugWviOzkzlaKFzdmtXSP3qo0QxaOVLyw6fzXsq+1IDCAbFeO2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2npQ4xOVjhaxbnFAsbJkWyEW1I2i3KEzIUcOYLKLtbw=;
 b=PthPqROGolU9xnmVs9Y+dlrnwzH8/m2SxwiBWetiu2QqgVtjZWNIk8f5hjm06adnYc4nC56yi7Pht6plVMrzR5PAoo0pwGTZHqM7r86IIoaj94jkVdDlNkSxRFhT+2nzeTvdu8XPfBpcg73YrBT0CU4XUG0DFxbGEMFJ+EXEc1sZjf0vUxS8+BBm2aiCHtjSofLVUji1s+gbz8VF3Kb3RL5of3vck0nzF4VMryXpQaPJRcbBt1z8bwUEeU/8jAa/yKWhBxRoL0LPlmFP6YAN2dBX6eVtoRfPjf28WWsh+S7yJpelALmrUFDDQ64Redvmz7J6W7TQK+5gN+LUT1db0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2npQ4xOVjhaxbnFAsbJkWyEW1I2i3KEzIUcOYLKLtbw=;
 b=vHdDgE8a2/S0Dc6PSFSxmwa+lpE9vdwLk8nNAW52h8skxZAV0ewkszpmOtWGeBam7b6Ng/mQw6HtpBdM3/sBPEb0BHythX/faLAXleMS9SAGFsViX/7MxQsRek1u3L/MCkfcpGGTH4C04rQLyS6EF+2ilHPud3c/zb7W1McLZrA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2350.namprd10.prod.outlook.com (2603:10b6:301:2f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 2 Feb
 2021 21:38:45 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 21:38:45 +0000
Subject: Re: [PATCH] userfaultfd: hugetlbfs: only compile UFFD helpers if
 config enabled
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210202203127.3596707-1-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <767ce999-eb25-09e0-6d2b-ef0ff104d2f9@oracle.com>
Date:   Tue, 2 Feb 2021 13:38:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210202203127.3596707-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 21:38:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b91fb15-147c-44c5-719b-08d8c7c2eab4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2350:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2350E9B3B2AEF39AD6380023E2B59@MWHPR1001MB2350.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YR7Kg1JDPuYrVEW2tBIWa/T90KG9MLi3TGtE9Y87XY4GqIUHJ1r/K8O1Oydt50uraKplFsaAR9V+6kmPn0aruMX4VtBBUrAkjz6kkG8h5gNItFNhHJytWuuIaDO/2VvQUaln8xrrIBXDfWt9LUtfsO21jfKjAiLijm6c/nlMfxttiIa+zJIOqIQp7K/vtOuCAYLt+zi0wbDfiRvF2hXxiEUcRS10ivvFngjWmc0SYysaSKeV2s6cKKjVEQ0dnRq7AyltJmZjJDGEDPouDqyxpmmMfcYukBCQywQivKgq3DK2Ya3PE/gKE0QWNy5d/2bvBBRy2T1G38DFQS67xHKO6sfoKvyVhynfKSMtHdmfnTeoAXJu0ZldXqlOKceXRL7imL80vSHNOARaGFtqQH64p6wEEtDoG9VUpwVJ+tGTxyj1UBPm8VksELX1LLdZBHK9lLz3rfh7BdKmRXc1wQ6vjd8NCEP3LGwsTz2TpNTwFNmzt0XgO2bWqA4zeWs86xAzoHuTPdc3WyBrvpBUhvgBrOZV9ozLml/66Ebs71HcZK3o0Mtiz4Chf2w2gN/PY3+9jNhBAxI5lML5mFe04GpCsLciiZdBbrWmZ4B6pHs7R0KYjtUFKVg1ApIG8rTD7hri7OUghIoJNPpO2yjcW3rzcZvxbK+H8Ddi1v8CmtUy4eU5890+ThCnfGO7qRZlWrvR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(366004)(110136005)(52116002)(966005)(8676002)(16576012)(4326008)(2616005)(66556008)(66476007)(66946007)(478600001)(8936002)(956004)(86362001)(16526019)(31686004)(36756003)(53546011)(31696002)(2906002)(5660300002)(6486002)(316002)(186003)(44832011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eDdaVHhvMlJDdC9qK0J4VVd0b0VBMjlUYTRiQWJ5WTVKbXZJNXdLMmJxTStt?=
 =?utf-8?B?OHZ4eGlTb1dlWW1FbVFKUFlNeFlscEtJTmpyS2poL05CUmM5Mm8vV3E0TGtp?=
 =?utf-8?B?a1dZc2ltN3I3Tlk0SXk1UHh1bHF1OVlMVnNlcHZvc0l5SG1sMjc3cDhPbFY2?=
 =?utf-8?B?V3V0anVaOXJmWDM0cnZTNFp5M0FQVHZiZUJ5MU8vRlFYT2tka25velVjSXB3?=
 =?utf-8?B?RFNjaG1idlJHVWZSemNxVnIxbDkvdEVFUkhwVkhsS1VwQm54R2xjOW1EaDE0?=
 =?utf-8?B?WFJWeTdTTFBzeVJ5cW81emd6MVgvdDhRNThPdG5HaXArUm5qYUpHd2pKWWtX?=
 =?utf-8?B?NmIrRUVuWlVjWWhKM3pNUFNRZ3V1cmRxZ200dDZqdXlZQU84NDRwZVVzZ2ZM?=
 =?utf-8?B?UG50dGVCeTZhaFdIS2FpQmJVelp5bmxJbmNFSVJaQUtCeUtjeWhjN2ZyTWg5?=
 =?utf-8?B?WXplQWgwMmVrdDQvN3pkYkRuRkt6UUpiSXA4Z1hWdkdWOFJyNlFDb0VNR2F1?=
 =?utf-8?B?Mjg0ejJySnJ0eEN0MytuQ3cyb3plV2tGdlJHT1lVY05ud0lpRllSYzRaT2No?=
 =?utf-8?B?K3g1b1BUYW5XTmpnMjBvbVFvKzdhdlB3bUxqSldqTURKcmo5OWFKTjZFSXIy?=
 =?utf-8?B?eHVOWmRDaXBZZVU0YW54czQxMURreGRDTTJ2MEpkSjBLeXVjZTVYV2FCZi9i?=
 =?utf-8?B?TEh4bzQrOUpaZjBhY0o0WEQ4SFN4QS83ODFEbHdXYlVTaFlwcUI3QlBwRFpD?=
 =?utf-8?B?MzZMazBQSHhYd3RoNVNIUUxqSUFYcFFCVndIVlJLRytsb01mY0hwcEhJQXlo?=
 =?utf-8?B?T2FxRE5sRjJFamwzbWJrYTJ1ZncyUUFwbUNxUXpvOThNVmNrNnYyNmQvaGRn?=
 =?utf-8?B?NFNySkVZem1ibDMrWHg0TGI3RFdFdXBVVHJXdTJEUTJ4VHdONWJFY1VwMmY3?=
 =?utf-8?B?US9IS1hhYkxWdUtLNzZ0ZEtpRWZDUnVoUXlSRVdKOThvYTgrb0p1cVQraGtW?=
 =?utf-8?B?OElueUNPNWU5MlZQSWdoZmpldVNrc3JValB4SEgxYndFR3pJS0RZT0JpVC9w?=
 =?utf-8?B?TXFCa1krK3NQc21iL2RSb204cXRIWjA5RXVJZkpveGFzOWNnNitOZUg1SWxl?=
 =?utf-8?B?ZGNHaVhXL0h1dkNvVEN4V09rV1hXUlpMU0taUXJhRjdOcitiTm0zT2FHK3B4?=
 =?utf-8?B?MGd0dncvN2g1NHpVbzNFNzRuUHR2Y08xZzEvMUt5Sml3c1FER2VHaWppdUM4?=
 =?utf-8?B?VTByV2N2cmluQmQ3VTNhcWF6WmZhaTcrbWtzY2w2Y081YkJqT0hUZ3pkRFZi?=
 =?utf-8?B?a0JhWjMyTTl5czNNMnFUcW1ZZGtCY01mckMycVk2VXhhTXpjYnQvQWtsUlJk?=
 =?utf-8?B?emw5NmhrY0ZNWnNhY2owSFlvNll0M2lqWEV0ZTVHWklsNy9HWlYzU2FDUTZz?=
 =?utf-8?B?dlF4SDFSVFd6ZnlqS0lYRFVNOTVwZzFubjVFSE5jZDM1OHNiUmFTOFBiNVhR?=
 =?utf-8?B?Y2EzTXVYdmRlK2Z2Z1ZSU3hpV0RwcFdSeG8rUlM5Z3BxZ2JTbVJJTkNCZlZv?=
 =?utf-8?B?b0pTNzBQbFlMaWZ5czdvazhWVW8yQmVQVDRINTlVcWJPQStXTkg1azJ2OXYy?=
 =?utf-8?B?QnVqQ2FURW91NThrMUF6Qjd3S3dGd2JOZDhEVGppazVOSWNiTTVxT09PUzFj?=
 =?utf-8?B?RW1BT0p3N1RZTGV2c1BBRldwSU4rMElGVnFudWpINDRMSExkb2lLUUliOVZs?=
 =?utf-8?Q?C7AgC+DqnTROozXT+IOIreL1qMMprfjIBLtUkhd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b91fb15-147c-44c5-719b-08d8c7c2eab4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 21:38:45.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UnQwvyCgRa7Szudy7ke+ee/dLG3dtczlg0RjFJ5aZWqNjdqSXfQ9EX0EQnUgt91GdJfLoE/xe7lZBbV5DZuNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2350
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020138
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 12:31 PM, Axel Rasmussen wrote:
> For background, mm/userfaultfd.c provides a general mcopy_atomic
> implementation. But some types of memory (e.g., hugetlb and shmem) need
> a slightly different implementation, so they provide their own helpers
> for this. In other words, userfaultfd is the only caller of this
> function.
> 
> This patch achieves two things:
> 
> 1. Don't spend time compiling code which will end up never being
> referenced anyway (a small build time optimization).
> 
> 2. In future patches (e.g. [1]), we plan to extend the signature of
> these helpers with UFFD-specific state (e.g., enums or structs defined
> conditionally in userfaultfd_k.h). Once this happens, this patch will be
> needed to avoid build errors (or, we'd need to define more UFFD-only
> stuff unconditionally, which seems messier to me).
> 
> Peter Xu suggested this be sent as a standalone patch, in the mailing
> list discussion for [1].
> 
> [1] https://patchwork.kernel.org/project/linux-mm/list/?series=424091
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/hugetlb.h | 4 ++++
>  mm/hugetlb.c            | 2 ++
>  2 files changed, 6 insertions(+)

When you move this back into the "userfaultfd: add minor fault handling"
series, feel free to add:

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks,
-- 
Mike Kravetz
