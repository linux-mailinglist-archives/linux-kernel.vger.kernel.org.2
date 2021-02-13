Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66A131A96E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBMBRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:17:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56116 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhBMBRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:17:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11D1EB96094716;
        Sat, 13 Feb 2021 01:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=okeGlH0U/8Kn5ZimgqG+1osKKJSRHEFcU5Qq4cieqhk=;
 b=yOkU61vqCvNa+85wrNCwbPyfgGn3n2+cYwy8S/VV6DhwO9xgy9WxxRwzk/bcyfTov9fO
 THNIvpEyetp6RKnC6VWsVJOTviszTjFpjnsN6WSAQrNjsaElmU47b02eE4h2TwU0eWH8
 hB/Go+Izh9e8AFIrz0vYuIiJcGV0iEyXG0yN3ohSoHPAzj1dZUZsGRDEmbd7sHHnQHRl
 vonRyzYdqj3xpHiGr3jj2mOf7ClmRR1r/SGEA2+LfyDsFiRW05gW0JW2OlZYAYqx4VYC
 2bN0O9ryffHTK6gCGAyZADNXzzhTte5JZvXA9fc+Ppx0jA925NPXAI6b/YOcASq5DsTJ 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrnd0nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 01:16:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11D1GKnV034114;
        Sat, 13 Feb 2021 01:16:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by aserp3030.oracle.com with ESMTP id 36p4ta05rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 01:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpn+vpniP5vfMOrvx0XlWy1IEH0rzGxDipKyH0nTiCL30PepIaJ2Wk7Ky39HC8OMuG8HuUrvm7d3jwV/L3WYR5QZuePp344HF6VhM6rL5iaorxrLhghLibdbCml1R2RlJ4uuOs395sKQiOOF2eadpT2jYRYzpLMJAz1ECNtrIsRcB/pIByf+CQ50cLGDemrJD8aBgiX2On4JrpB4oRak1PRUNtGE7EU1k9X9BHYGhrkFYvidrBRaa4B5rKRo6gAQgBXChHogOuw1hJy7Jy60qMJrv6uwnbw9qDo3SJw9nM8w8v90PuN8AlmeHppp/taAlKC+g/YNwWxjxl9dVfOqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okeGlH0U/8Kn5ZimgqG+1osKKJSRHEFcU5Qq4cieqhk=;
 b=fXsHmMsEAnVObJDE7tuTGUART86e6sb7BD7Ld/a8o8J9TsjgaGLwCdcDLKml/yTpPboN7RYx2qtCiXGm2k8hPjM5tIpYET0NjgM/YRViZ32n2r78Duz5dU+xP6Zm9ledlrb+wuahCBSDMuEt0VURgX8iIR8Qf/yRa332EnNOk/tx1mcxcRZwZz98KOuhU/xHcrNBqxm8GJWcPWeUHbH7cABm1huKmajVU1WXt4MaY2sLt9oqGB9EGlhNAURK91wTCnuR/g3IgdVLxR3SpANToZlkaqtc6AUrmZjPSa16WbyIJ57+j0OOWbvFt4GGWmIwpabtVCP/yGCC2AAMRJlX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okeGlH0U/8Kn5ZimgqG+1osKKJSRHEFcU5Qq4cieqhk=;
 b=bKWFwC1z5JU+rbgbncJ/0cFKI7OdejVA0AwQ2x4fh6JN2X4e8AOaDkpa5JtO4HkLGQk2ofD14P7Dmu3EqHF5R+y1+HlsjgRC07DCTjdf7mCdk7tRCy1RPUwlF5FkZPUoixLw03dDbEnR+yfOYi8Ifap88nwowJNa658+NE+Doc0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4611.namprd10.prod.outlook.com (2603:10b6:303:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Sat, 13 Feb
 2021 01:15:54 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Sat, 13 Feb 2021
 01:15:54 +0000
Subject: Re: [PATCH] mm/hugetlb: remove redundant reservation check condition
 in alloc_huge_page()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210210075443.26238-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <32f628d5-fa0c-2a81-2de4-d0a76d1c3e45@oracle.com>
Date:   Fri, 12 Feb 2021 17:15:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210210075443.26238-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:300:d4::26) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR19CA0016.namprd19.prod.outlook.com (2603:10b6:300:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Sat, 13 Feb 2021 01:15:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75577bc-bc15-4ddb-a09b-08d8cfbce8eb
X-MS-TrafficTypeDiagnostic: CO1PR10MB4611:
X-Microsoft-Antispam-PRVS: <CO1PR10MB46116D22937690BEA325484DE28A9@CO1PR10MB4611.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/Vy/hosd6AquGKDNXKDoet8S9R71c44PuT2cBDVvl1jJSTkUX01fTWx2Ia1E0QD5Av0jIKFW5JxrwqL+G44s34IRR+Dro08kc5MkWLZZN1UmVYIZ1wCUPuNsnzOiQ6TWioV4qfL5RW9XSiokdypVGFYD2wSgEXZ4MRtrpARvlH7UfMcCkJONUnVIVrSAPlMg+lftESoTOTb3tohvLwgBGFlUPgxm23a6jP8IP9py30AHodj8Uj5FsKCL93inlQX6mOPf3XbNgAUoqNF/229zvSN3cwwUN1/CpbLOEPocg9h8JzRXE8EwYY/ndkQzmSZI/T2ONHilg7dXPOBIV5t/Ivc4BIazEsGErWgfGa5vZ3hHY6B9JCTofVsbatwfXjoGrt86vuFYpNFuDIvX3mEEFKe/gzvS40+ogw/1RJcvKFYgwbRIgubJ7vBpKD/MZt1IGVMychxGDkXFpLuM+JOQHSKUfJMvt6QXtQ94y6OKoBRSNO1LB0Hb5sOs/1mnPBGavdMJ1EQi5x1iOBgHX7sIQb9KhDWUkByFJWICjzetyNx1CnmS71TiZJmvxxkpBvMJOtaJrT0IlzEsDQYCF7jbfSXh82ztY/HIbyEHNQ8VxU6zKNdJJiKMrU6hoOgzFGU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(16526019)(316002)(186003)(2906002)(26005)(44832011)(8676002)(16576012)(53546011)(6486002)(8936002)(5660300002)(2616005)(4326008)(66556008)(66946007)(31686004)(36756003)(86362001)(52116002)(66476007)(478600001)(956004)(83380400001)(31696002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1JwRXhLV0VjSExJVjhxU0NjdmNsb3N1MmZVQllmMmNvVEJyd2JtUnZ5Z3VS?=
 =?utf-8?B?OWxOeUN2b1kxSE9BUW5iOGdyaDd0UGZ6TTJ5T0pwYk9ueVVhZW5GRGZ0NXp5?=
 =?utf-8?B?K0RRckkzbllhaXRicVZvREJPU0VIZWRWTFIyYmk5NzFKdlBmTGRSOXQvOEFy?=
 =?utf-8?B?NEcxeS9SZC9BZUdOUW5GcnQ1dzl5QnpRUURLbXBUNjhHa2k4a05tOGoveWxK?=
 =?utf-8?B?Y0pNL0V1MXpRLzR4S3EvQXNra2lDMU9lSDVRc1h1SWhBNzBFd2oraFhEcU1w?=
 =?utf-8?B?Y1Q4Qk9aaVZhMFVYTzZoZTBJYmk1cVlpTlNBQzRCd3FtZitkMDgrV3RSN1FQ?=
 =?utf-8?B?ZHllMmFNbVBiU2F0dkJHUEhGZVhwTDEvaFk0T0treGk5S3ZmQzJUWWJTMGgv?=
 =?utf-8?B?QnUrS1diWHVhVzQ4dlZyQ1ZZY1RqcUNtRXpnZTdRYllNRkxnTUNna3lIaXBR?=
 =?utf-8?B?aUVTd040RjFCa1VncVB1TkFsVEN0a0xmMFFvdWU2UG54N21nWlhMZTYwZjlH?=
 =?utf-8?B?SlRob3JJb08yb2d4Zm9BRmRGTkkzMWF4RXdEZWtYN3NxOFVQa0VrY2VURlht?=
 =?utf-8?B?K2x6YnNjb0o0a2h2TjA5ZVBoc1dLS2c3cFpwbmVFSFVBV2xNS2tyZ0pPYXI2?=
 =?utf-8?B?eWEvNG1BNmwyMDMzaGJKZnREYktPS1FkZFlmTkVoRVRxMzlKUUM1VUVqcDE0?=
 =?utf-8?B?VnBidlBzRTNMNUJub29iNUM4MHVEcCtIaDZCUURvRVVsZXBPN1VkWnFScDlx?=
 =?utf-8?B?YVdtSHI0U2tJT3RZSVpZQzZoL01uWEU1Q1FlN1lxNmxrQStNeEtiVGRTQllQ?=
 =?utf-8?B?Nk9hUkh6cVlxVlphUVV3blBVSjRTMlAxOEx1MkVWTlR3aVRocSsxMW5SdkVk?=
 =?utf-8?B?MnJWNXhUTFc1WllJVGtqK3dJMWJBMmYxb3pxUFRxZDRTVXNpa2FsczB0SFpx?=
 =?utf-8?B?bjd3MGltNzM4SEhyc3UxZlUrOXhHa3ZtTVR3amh3S21heTZvb3dCNHdOQVB2?=
 =?utf-8?B?bFdEZ2ltem8xSlc1eTBzTzNOMm5FQlJWRW0zMnRaYURZRC94UzBTdE9zRzNH?=
 =?utf-8?B?YThvb0JXa0RUZFpzYkZyYkN3RkFucTlFZlJDY2o2NFRqU1RWYzRVZmgrYWh6?=
 =?utf-8?B?YzY2T2xKOGM3azdEZW5RZm4xUEZpSjYyWllCSVlLWmF6VmlSOGN0TFpsZGpp?=
 =?utf-8?B?STgwVXcwR1YwMEo5L3piamdCblV3YmVlc2cwYmk3a1NLbEdkUFVWQngrd0Zw?=
 =?utf-8?B?QTJhdzdpR1h5SDNhTkcrNlBRbWh6ZFNtT1RyeHFUc1I3eGVCWnhkOUI1Yng0?=
 =?utf-8?B?eVNscG55YWVzb0ovekdxb3hIdTZWcE95NE16TS9QOXNQa3Rwa29ieXpMYjJY?=
 =?utf-8?B?bVhJeUFQNzl2Z081UGR5MHRpOFQxeVlXR3cxRE1qSm5XN3lmVHdWV1o1cFpY?=
 =?utf-8?B?K3NVblE0VE12UlN3U2ppY0w4bUZzMW9vTWVYajJ5ZTdXYzBuQWVPMWpsZDJJ?=
 =?utf-8?B?QVB5aFNOZ3A5VXBoeGRGN215T1Q2bm8xeU5hei9YbUdrMldNWk1jOXhJUmNZ?=
 =?utf-8?B?c3RRZnFMRzJiOUd2YVFUT2JmOWN6YlV0ZnJDZmhkbitFbTdNU3JRcklRYUhF?=
 =?utf-8?B?WVpJM0dFUElONHNKVlZDUnVjZGhQQ2pGdzlvcHYvanFIRE8xM3ZhS3l0UmEr?=
 =?utf-8?B?ZVU0SHpmeGNUSEEzVmVqTXlSTkFxWHVNK2FlSTRveGZya1FiN1hYbS9KWW5O?=
 =?utf-8?Q?tgZEW4Sl4GjWXbmzIK4+kkhJNh6hL5OM29YtDwU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75577bc-bc15-4ddb-a09b-08d8cfbce8eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 01:15:54.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws5FmrQriU3T2Nwg7SgKYYBcS0tTS5RRWl5wcB+LkNccJXXu7JW5tbz5wjnksnwDhHHEgAYZsU5c/DG+8HJwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130008
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 11:54 PM, Miaohe Lin wrote:
> If there is no reservation corresponding to a vma, map_chg is always != 0,
> i.e. we can not meet the condition where a vma does not have reservation
> while map_chg = 0.

This commit message might be easier to understand?

vma_resv_map(vma) checks if a reserve map is associated with the vma.  The
routine vma_needs_reservation() will check vma_resv_map(vma) and return 1
if no reserv map is present.  map_chg is set to the return value of
vma_needs_reservation().  Therefore, !vma_resv_map(vma) is redundant in the
expression:
	map_chg || avoid_reserve || !vma_resv_map(vma);
Remove the redundant check.

-- 
Mike Kravetz

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4f2c92ddbca4..36c3646fa55f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2311,7 +2311,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  
>  	/* If this allocation is not consuming a reservation, charge it now.
>  	 */
> -	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
> +	deferred_reserve = map_chg || avoid_reserve;
>  	if (deferred_reserve) {
>  		ret = hugetlb_cgroup_charge_cgroup_rsvd(
>  			idx, pages_per_huge_page(h), &h_cg);
> 
