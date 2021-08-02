Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC4C3DE33F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 01:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhHBXvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 19:51:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47444 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232208AbhHBXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 19:51:13 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172Noc7l015159;
        Mon, 2 Aug 2021 23:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vO5ccy4/hNJ5nKxTULlY9GvLwueafA5ebVJs9Hc8SME=;
 b=sA3LkDRDYHKiMU373/CqUQUwrsV8KU+dxexPkxYyW2la2C1ruA8xck6p/qDOceOEwG4p
 6QmcQe3bhgSGHy7985uqOOVRo5Y0YeJBnDcmArHpmwgwz+ycwLxOwVYKV5r3VpIctUTJ
 kRHngIU4saKQv40pyyNpXG1P1Yv/b2x6mZSoGlq6mnw+NPj/mqjlXONpKxmkZdAPph1J
 NA7gP7SWEW4K5VFs0peBBM13g/AswUJTT7WzhYylFIYDD00SIEHOTIx3pSPnESpMhOoC
 wxEbckABltigwKrB9LNcCTFkh8Cpdw58/53+p71CsKXBPuJTySZ90DMJLSGeF25GcNV0 ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vO5ccy4/hNJ5nKxTULlY9GvLwueafA5ebVJs9Hc8SME=;
 b=RCmAN4elceSrb6hKe5oJIa3qpHwNorY4rnOBSrxrB066Av9puotsurbLYE11IWq63H3G
 DdH30mG6NGaER4E7jizM9nFlVU39bVNdNTkRz32NcslLvp5zWjP0S4AYGUExdpZxs1v6
 dm6t5jh7sm8+0selndZjlUQQnmHWdgWycDxVhWX4hMa2/K26Qy5xAEDE/TCEPl7k0stt
 QkmXMJp/eJaIeCyFeI+GJKpfQc3UMMKAKlpMdEhQ4dyBOfY4sF4V2dxLfpsjYH6DwNQ2
 rrRcrCHlOFcNIXCV+xbCqn0KAehIZSrzfxRYjFrcvQaDtcKRywMa+andw7vWuDkFHU4X DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxh9hyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 23:50:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172NjFv7167191;
        Mon, 2 Aug 2021 23:50:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 3a5g9u0us7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 23:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz4Z/4nlekZMRcRixUzrpew+QuyVPf8W50JOqrWSa5q8L3Kbn1vtqnNpcHIFOnr7HcBLPxBz5guW/xdfg0HAD2ufZY12Ox3RwnEn4sA5Hojd5sHhkR9VW5pJ8wS0Sermcu1qPAp1g4Qs59eS9cUJmC9a1c/0mC0wdJ6rW085ZopTdYckuB/usBHspB2wq2Ovfu7SW4oY6by/EA99s9lMxdZSE1M0Gi4+00SZZB7BrYJi1deqp2HK9BJ0niigGSYEQYwWK9RBP6BnYQfGkE2Qxxi/p5keITpARCB46YWlaR+VFFUfH3ez+Xr4xYNUiIAuEZT2GGt5UiLe4LF6NbqhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO5ccy4/hNJ5nKxTULlY9GvLwueafA5ebVJs9Hc8SME=;
 b=GlRkjszrQVJ7LrcocNTowoWYfxb+HVwHkstOfq/9vZrffuiZ6bQ65KOeAmBXKlUrxftVQJ76g5SUWi4Rz0lAvxH3t4JztexpnQwvv21j/8h8WKbm/i9dqOIYuxE0FBOkJyltYzticD/4WPy/yKg8ipq8QoHcPNaQde62WTW3COnAbwjEiNRqw96biCodv4FcYWOfbKdU/xZjTEq7AXBvcZmCl2ysjBacWqqVZ4Ob6j2f7fUJLOQciQ1+Wks/vvD+Pyj+8M2eIh4P9hlJrZHsq0OZq+w74kcViI/Ahp6TrXh5Z8ptwevQtnkEoHfZ2kFhNCDXfU1fzPZGlPKuu6hcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO5ccy4/hNJ5nKxTULlY9GvLwueafA5ebVJs9Hc8SME=;
 b=QJ+eGNc7gx7NJoCwYoJ4VpW1mm5XE8zQx33d0vgD5FzZyiLZa8S1PrMw2jY8suVfOyCc/4J29uW6ygGpOch9+Wzd3Yiltx97YBXKt/U+ZK+oNXrFYzI2yq5CB+cYX67/inC6K9tfKmGb58Uj4dEt50viBeqRoXbH7HeB+QafsT4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 23:50:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 23:50:55 +0000
Subject: Re: [PATCH v1] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mina Almasry <almasrymina@google.com>
Cc:     Ken Chen <kenchen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
References: <20210730221522.524256-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1b970f88-ea8a-18bc-3643-f0e81062f569@oracle.com>
Date:   Mon, 2 Aug 2021 16:50:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210730221522.524256-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:101:1f::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by CO1PR15CA0047.namprd15.prod.outlook.com (2603:10b6:101:1f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 23:50:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de6cdc19-2d74-42f0-c63c-08d956105ddf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4541:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45414B1164C7E1F26535C456E2EF9@SJ0PR10MB4541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUt3NBBZGPgwcGaA0Luh7tyZGyW25ItPAHP406+Uie8vcRN3sGAC5BSTomndEQdNKsExoaWhHAyKdz4/368ZqZn+Z2CfVJuldtC42CLl2v7U/IjDQdkeFWYh+vHtMK2uB2O4dZZgu7YdlkrF1o3OTcnsuuCk/5klxWzugVj6yHefx6WvoR0io4Nzj08nnKnvMCrpkMCka5YNb1DE47EKjRecmeWjTAt8ofYW0qWe3192ZRXMOVn1+55sC1SXTX6yRQp/TjDsx4W2Ik5AAecFxXBzGg+55OArtEG11uHfUjJ0OqFHIPyvHVcijAfbwnRrNHj91ANH7lliegIGVACp46WUjM9TsRH5T9g1Wj94rc+ziespjEf8K0R25fetjbIf1TY3Eq56bSGNVCxoMx5XTC3OocLGRm7dtl3mzKb3nf/tosqIW+3vMNeXmehZ6UO3t8PgNcnlsy60tsEQ62GNlRpBAythKEfXIqehEGB+GiXUBioiwc3AmuR7MIvB82Fk1EF9P+84cuHgJE8QLxzdvOnf5YqqqayV0W+V5HDW5A/Dh+4nmlAUO6ll8VpraKPQv7KUopAvEqnJORruS+rTCjqRFgTJ24Ogm6CRZ5iAkiQ8zHJ8zrvU8yFFxMGfBJQlLBN0WAEN43XDKEfdjR8+aoqMneJ/0G6gDGO939sdjqNoroz9cGQOHoD8A3fd3ETTBVnDPCFf4iKLm+3JCox71e57PJActkmJMs7Lgaolth55ZBsSBLyYXWklyYzEFsX7gZLVi8NwT5bbf1SwkX+taw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(8936002)(8676002)(26005)(53546011)(38100700002)(38350700002)(186003)(6916009)(52116002)(316002)(31696002)(54906003)(6486002)(31686004)(2616005)(956004)(83380400001)(16576012)(44832011)(86362001)(36756003)(478600001)(66556008)(2906002)(66476007)(66946007)(5660300002)(4326008)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU4zazlpR1pRVEdGU0VNbHVnMnEwL0ZzRlJTNGx6SndaSUVsSWNWdUdoclNT?=
 =?utf-8?B?TXRXdGVORlg1a0FzUndyRGRqMGw1c1hhemFjNnlOUEwrNGtxbElUYTlSM2ls?=
 =?utf-8?B?L1c3U0FsK3BzYTh0UTlMa2tGL3kyUllRVVExMEgydVBjNy9ob3laN0FEQnhN?=
 =?utf-8?B?ZVB1bm53K1FjUEdCZkxrSGdiUFdXUTZvYkt1Nld4Sm9KOGp4YVp6czRWajUw?=
 =?utf-8?B?azFxY2duUTdqSHJHSW92RnlQc1FGczJMWDB3bGY1WlEyK2VmVWhKdWo1TlFE?=
 =?utf-8?B?Q3VMbG1tNkJ5RUFWS1Nxdks5YUNlRVR4RTR5TW8vU0tMMDV5VytvM1MvTWJT?=
 =?utf-8?B?OVdxYkpQNUh0VGhKbEpLZ3JleGx4MFRYWkhaV1VxaHRHWjNnQ0RhaDVId0NY?=
 =?utf-8?B?R0NoaTQ1Z1NtZzFzU0FVZEZMNmc0eWFrRm5VeUFlL0RrVHNGNVAvRDBkRFFw?=
 =?utf-8?B?WmlZd0dLSmFkaWtUemM0Mk9rS3MrcjlyelRhUjhrSVNHWHlKU3UxdnBHc2lC?=
 =?utf-8?B?SFpGMHRiWDNCWVd0a09DajlOdHZ3ZElVZ3o2QVJKT3lnaEsxb1NPNWEwT2lh?=
 =?utf-8?B?LzZ0TGNzcXZEaVlVMTh5SE5MbFAyN291WGRaZDdTNndhUStHdUtsMjRzd1JC?=
 =?utf-8?B?a3hjOEJ4ZzRvbmhCdGNFbUtrckFvMGYxVWRjZW5EdEtZMDhHQVhVeE9IRWh2?=
 =?utf-8?B?VmpPUXY4L0w4VWR1UTgyVTgrRmJ2V2N3Y3g5QVlSRHRYbWVxYVFIWi82ZXlO?=
 =?utf-8?B?cnhzN1g2K1NCdzJxVnYvejY2Rmo4VTFvZzRjS1RLSjRHNkZldng0OWxidHdQ?=
 =?utf-8?B?TytWcTljcTRqLy9MUmFIVXhaWnlmMWE5d1oyQjZPSHpnYkxIdnNmUHZwUWlF?=
 =?utf-8?B?S2o1RVVudjBXS01hRkI0amNWUCtFeTBDcDhBbzcxM0lhcjI5VGFHTXNUTXZ6?=
 =?utf-8?B?YS9rVVNFeUozeVRNMGsyU25WWHJVbmlPcFgrN3dkdzlCYjdKdzZySExLRFRR?=
 =?utf-8?B?SEM5Zk1YdWJOL3Vyc1VmUkI1UXVYdCtTQUFVYXV1eDBuYXVxdHh4QU5weHll?=
 =?utf-8?B?SVUwUmtMaHpOUnJha3hmTmoxUEkrMTlpeGErd0NueXlQWlltL1JaZVlQWkVk?=
 =?utf-8?B?cTdad0RKaG5qakhBd0FYR3R4dEdWQVFubzJGM0p4c2lhc3U0dGVBd01Dd1Fx?=
 =?utf-8?B?VmVUSHRVK3FqcEc3NzlBWGg2cmNyTXVpVjU5MlZlUGQ0bUZ4RlBUZkdZaXpH?=
 =?utf-8?B?Z3kyNm9TUFFnMW1kUUU3TmUwY0d2dVRQVkV2TXRUR3JZRmxveUZUWkw0SDNn?=
 =?utf-8?B?YVN5K2Vya2ZhZFJSNzhVQ1JVTXFVcDcveVRrN0JEd3B2bDlTd0prbHRCNEc5?=
 =?utf-8?B?UnZrUVMyS1RRZ0JTNUg0WEh4QWg4dkRvWWpwTXR5MTM4MGI5MC96YkYyanQ0?=
 =?utf-8?B?R0VTcVVxWEd6ay9FdGtoM3hiOGtKUWtUTnFpdmlkRWhjMmU4eGVoZGJsQU12?=
 =?utf-8?B?S3dSSXYzNDduSk1ienZ4L3NSQkdWdWN0aUhFdkJZVHZqVHZuQmxqSHo0bFpH?=
 =?utf-8?B?WkY2UjRlYVdnTzlXc0QrSmJTdWhhL2hCamdzNlNwanpXTy9ka2plUjI5U3JN?=
 =?utf-8?B?dVBmd1NvRUtrRW1Ubk44OFA2enMwL3dmZlU0TDRzc280a0JOVlM5Zkx2ZEVB?=
 =?utf-8?B?dHU5a3J1SnJMRUsxcWlpMjcrSm5ETG93M3dlSHFOVHY5amJaTEFUN2pwNkJt?=
 =?utf-8?Q?GyZpAnBBXAQLObrHTr07BGj7Ki+1HVutqMubE0w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6cdc19-2d74-42f0-c63c-08d956105ddf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 23:50:55.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOp/nsSks1QGdLFkp++yoBQK9IZxcYemPEPj8uEr5J+yFjA0nF+F3bUJ6kTy6bDbbJnKVCxUYebs1KVdfeYg0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020150
X-Proofpoint-GUID: Ffkl0J7wp4zMWGMGaZqNEGkcHOYbjyUH
X-Proofpoint-ORIG-GUID: Ffkl0J7wp4zMWGMGaZqNEGkcHOYbjyUH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 3:15 PM, Mina Almasry wrote:
> From: Ken Chen <kenchen@google.com>
> 
> Support mremap() for hugepage backed vma segment by simply repositioning
> page table entries. The page table entries are repositioned to the new
> virtual address on mremap().
> 
> Hugetlb mremap() support is of course generic; my motivating use case
> is a library (hugepage_text), which reloads the ELF text of executables
> in hugepages. This significantly increases the execution performance of
> said executables.
> 
> Restricts the mremap operation on hugepages to up to the size of the
> original mapping as the underlying hugetlb reservation is not yet
> capable of handling remapping to a larger size.
> 
> Tested with a simple mmap/mremap test case, roughly:
> 
> void* haddr = mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC,
> 		MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> 
> void* taddr = mmap(NULL, size, PROT_NONE,
> 		MAP_HUGETLB | MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> 
> void* raddr = mremap(haddr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, taddr);

Agree with Andrew that adding actual tests would help.

> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Ken Chen <kenchen@google.com>
> Cc: Chris Kennelly <ckennelly@google.com>
> 
> ---
>  include/linux/hugetlb.h | 13 ++++++
>  mm/hugetlb.c            | 89 +++++++++++++++++++++++++++++++++++++++++
>  mm/mremap.c             | 75 ++++++++++++++++++++++++++++++++--
>  3 files changed, 174 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f7ca1a3870ea5..685a289b58401 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -124,6 +124,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
>  void hugepage_put_subpool(struct hugepage_subpool *spool);
> 
>  void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
> +void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
>  int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
>  int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> @@ -132,6 +133,8 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
>  int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> 
> +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
> +			     unsigned long new_addr, unsigned long len);
>  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
>  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>  			 struct page **, struct vm_area_struct **,
> @@ -218,6 +221,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
>  {
>  }
> 
> +static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> +{
> +}
> +
>  static inline unsigned long hugetlb_total_pages(void)
>  {
>  	return 0;
> @@ -265,6 +272,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
>  	return 0;
>  }
> 
> +#define move_hugetlb_page_tables(vma, old_addr, new_addr, len)                 \
> +	({                                                                     \
> +		BUG();                                                         \
> +		0;                                                             \
> +	})
> +
>  static inline void hugetlb_report_meminfo(struct seq_file *m)
>  {
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 528947da65c8f..bd26b00caf3cf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1004,6 +1004,23 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
>  		vma->vm_private_data = (void *)0;
>  }
> 
> +/*
> + * Reset and decrement one ref on hugepage private reservation.
> + * Called with mm->mmap_sem writer semaphore held.
> + * This function should be only used by move_vma() and operate on
> + * same sized vma. It should never come here with last ref on the
> + * reservation.
> + */
> +void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> +{
> +	struct resv_map *reservations = vma_resv_map(vma);
> +
> +	if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
> +		kref_put(&reservations->refs, resv_map_release);
> +
> +	reset_vma_resv_huge_pages(vma);
> +}
> +
>  /* Returns true if the VMA has associated reserve pages */
>  static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  {
> @@ -4429,6 +4446,73 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	return ret;
>  }
> 
> +static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr);
> +
> +static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
> +			  unsigned long new_addr, pte_t *src_pte)
> +{
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +	struct hstate *h = hstate_vma(vma);
> +	struct mm_struct *mm = vma->vm_mm;
> +	pte_t *dst_pte, pte;
> +	spinlock_t *src_ptl, *dst_ptl;
> +
> +	/* Shared pagetables need more thought here if we re-enable them */
> +	BUG_ON(vma_shareable(vma, old_addr));

I agree that shared page tables will complicate the code.  Where do you
actually prevent mremap on mappings which can share page tables?  I
don't see anything before this BUG.

> +
> +	/* Prevent race with file truncation */
> +	i_mmap_lock_write(mapping);

It may not apply as long as you really prevent remap of mappings which
can share page tables, but i_mmap_lock_write also protects against pmd
unsharing.  In a mapping with sharing possible, src_pte is not stable
until i_mmap_rwsem is held in write mode.

> +
> +	dst_pte = huge_pte_offset(mm, new_addr, huge_page_size(h));
> +	dst_ptl = huge_pte_lock(h, mm, dst_pte);
> +	src_ptl = huge_pte_lockptr(h, mm, src_pte);
> +	/*
> +	 * We don't have to worry about the ordering of src and dst ptlocks
> +	 * because exclusive mmap_sem (or the i_mmap_lock) prevents deadlock.
> +	 */
> +	if (src_ptl != dst_ptl)
> +		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> +
> +	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
> +	set_huge_pte_at(mm, new_addr, dst_pte, pte);
> +
> +	if (src_ptl != dst_ptl)
> +		spin_unlock(src_ptl);
> +	spin_unlock(dst_ptl);
> +	i_mmap_unlock_write(mapping);
> +}
> +
> +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
> +			     unsigned long new_addr, unsigned long len)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	unsigned long sz = huge_page_size(h);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long old_end = old_addr + len;
> +	pte_t *src_pte, *dst_pte;
> +	struct mmu_notifier_range range;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
> +				old_end);
> +	mmu_notifier_invalidate_range_start(&range);
> +	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
> +		src_pte = huge_pte_offset(mm, old_addr, sz);
> +		if (!src_pte)
> +			continue;
> +		if (huge_pte_none(huge_ptep_get(src_pte)))
> +			continue;
> +		dst_pte = huge_pte_alloc(mm, vma, new_addr, sz);
> +		if (!dst_pte)
> +			break;
> +
> +		move_huge_pte(vma, old_addr, new_addr, src_pte);
> +	}
> +	flush_tlb_range(vma, old_end - len, old_end);

Isn't 'old_end - len' == old_addr?  If so, I think old_addr is more
clear here.

> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	return len + old_addr - old_end;
> +}
> +
>  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			    unsigned long start, unsigned long end,
>  			    struct page *ref_page)
> @@ -6043,6 +6127,11 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  }
> 
>  #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> +static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return false;
> +}
> +
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud)
>  {
> diff --git a/mm/mremap.c b/mm/mremap.c
> index badfe17ade1f0..3c0ee2bb9c439 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -489,6 +489,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	old_end = old_addr + len;
>  	flush_cache_range(vma, old_addr, old_end);
> 
> +	if (is_vm_hugetlb_page(vma))
> +		return move_hugetlb_page_tables(vma, old_addr, new_addr, len);
> +
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
>  				old_addr, old_end);
>  	mmu_notifier_invalidate_range_start(&range);
> @@ -642,6 +645,57 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		mremap_userfaultfd_prep(new_vma, uf);
>  	}
> 
> +	if (is_vm_hugetlb_page(vma)) {
> +		/*
> +		 * Clear the old hugetlb private page reservation.
> +		 * It has already been transferred to new_vma.
> +		 *
> +		 * The reservation tracking for hugetlb private mapping is
> +		 * done in two places:
> +		 * 1. implicit vma size, e.g. vma->vm_end - vma->vm_start
> +		 * 2. tracking of hugepages that has been faulted in already,
> +		 *    this is done via a linked list hanging off
> +		 *    vma_resv_map(vma).
> +		 *
> +		 * Each hugepage vma also has hugepage specific vm_ops method
> +		 * and there is an imbalance in the open() and close method.
> +		 *
> +		 * In the open method (hugetlb_vm_op_open), a ref count is
> +		 * obtained on the structure that tracks faulted in pages.
> +		 *
> +		 * In the close method, it unconditionally returns pending
> +		 * reservation on the vma as well as release a kref count and
> +		 * calls release function upon last reference.
> +		 *
> +		 * Because of this unbalanced operation in the open/close
> +		 * method, this code runs into trouble in the mremap() path:
> +		 * copy_vma will copy the pointer to the reservation structure,
> +		 * then calls vma->vm_ops->open() method, which only increments
> +		 * ref count on the tracking structure and does not do actual
> +		 * reservation.  In the same code sequence from move_vma(), the
> +		 * close() method is called as a result of cleaning up original
> +		 * vma segment from a call to do_munmap().  At this stage, the
> +		 * tracking and reservation is out of balance, e.g. the
> +		 * reservation is returned, however there is an active ref on
> +		 * the tracking structure.
> +		 *
> +		 * When the remap'ed vma unmaps (either implicit at process
> +		 * exit or explicit munmap), the reservation will be returned
> +		 * again because hugetlb_vm_op_close calculate pending
> +		 * reservation unconditionally based on size of vma.  This
> +		 * cause h->resv_huge_pages. to underflow and no more hugepages
> +		 * can be allocated to application in certain situation.
> +		 *
> +		 * We need to reset and clear the tracking reservation, such
> +		 * that we don't prematurely returns hugepage reservation at
> +		 * mremap time.  The reservation should only be returned at
> +		 * munmap() time.  This is totally undesired, however, we
> +		 * don't want to re-factor hugepage reservation code at this
> +		 * stage for prod kernel. Resetting is the least risky method.
> +		 */

We never had remapping support before, so we never had to deal with this
situation.  This new code just throws away reservations when remapping
an anon vma area.  Correct?  I would like to at least think about how to
preserve the reservations.  In the move case, we know the vma will be
the same size.  So we would not even need to adjust reht reserve map,
just preserve it for the new mapping.

The explanation is helpful.  However, it might make more sense to put
it at the beginning of clear_vma_resv_huge_pages in hugetlb.c.  It is a
big comment in mremap.c that is very hugetlb specific.

> +		clear_vma_resv_huge_pages(vma);
> +	}
> +
>  	/* Conceal VM_ACCOUNT so old reservation is not undone */
>  	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
>  		vma->vm_flags &= ~VM_ACCOUNT;
> @@ -736,9 +790,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return ERR_PTR(-EINVAL);
> 
> -	if (is_vm_hugetlb_page(vma))
> -		return ERR_PTR(-EINVAL);
> -
>  	/* We can't remap across vm area boundaries */
>  	if (old_len > vma->vm_end - addr)
>  		return ERR_PTR(-EFAULT);
> @@ -949,6 +1000,24 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> 
>  	if (mmap_write_lock_killable(current->mm))
>  		return -EINTR;
> +	vma = find_vma(mm, addr);
> +	if (!vma || vma->vm_start > addr)
> +		goto out;

It looks like previously we would have returned EFAULT for this condition
on non-hugetlb vmas?

I see all the special handling for vmas with userfaultfd ranges that are
remapped.  Did you look into the details to see if that still works with
hugetlb mappings?
-- 
Mike Kravetz

> +
> +	if (is_vm_hugetlb_page(vma)) {
> +		struct hstate *h __maybe_unused = hstate_vma(vma);
> +
> +		if (old_len & ~huge_page_mask(h) ||
> +		    new_len & ~huge_page_mask(h))
> +			goto out;
> +
> +		/*
> +		 * Don't allow remap expansion, because the underlying hugetlb
> +		 * reservation is not yet capable to handle split reservation.
> +		 */
> +		if (new_len > old_len)
> +			goto out;
> +	}
> 
>  	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
>  		ret = mremap_to(addr, old_len, new_addr, new_len,
> --
> 2.32.0.554.ge1b32706d8-goog
> 
