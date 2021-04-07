Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8C356082
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347641AbhDGAy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 20:54:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347607AbhDGAy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:54:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1370o2nx008579;
        Wed, 7 Apr 2021 00:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HYAJMloT09ba7cWbQimG3VHbwINeVCc6DCeTxTiXhfE=;
 b=skuxpe4r+MuJuAlToeyJZYxnPYWnbYUK3Zsv/JXC8vWv0ARZIzJRzxep/6JcIBFQ8TDS
 roQIgTeX+Eb9gboYc+MyRSq/56wxRd9MJJCu1oPN2I0WPkcD2AJMfzvA6umsUhtPf9iD
 yBP3/hxJj2omwPVDSmG204mSIrotnb4bYiOqgiouBBoIRLhWNtdvL7piIcphMbZzjFMH
 a2AE9QS25x/v3YrF078FYvvYe8oftCmpkaDNZHB6OWogg9q9e6ky2BVLj9TjIUYEXDMc
 Vi5SxCIHz0yZSfVGwK6S8ZVOIoEIBxa+EDMBGFOB/2RVnWWDXm1f3fWaUQDAQy85RvRY yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37rva60ujv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 00:54:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1370nuRR077527;
        Wed, 7 Apr 2021 00:54:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 37rvbdcyqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 00:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBtcM+w2RkYjmWlqABnOFhH4mPnoABwRQYXrpYxaJ31yB4qKR81JNUFaCchshi11LBy+XtbikVcVREjGDzW2WOKHEfzaUe/uPqbFrjKFUBMWgAeQUDLVXovvJfQbKX1bpmp0ho7/wUHuecumGMlhOBnrGAKQCGTrwjTawEt7W6tebCq4w92cjViU9Wp1Jdm6BlEhLa6Eozv7Y+zqtA5WKY4X3wszjafX93LM7e8iA4GPLGvk1wD6iCYXuVh6t905bjXRPXYFVJ66vF9ECY+6smU9/hQMXORddAz3T0cHtBWS+ZRsIW33BFvOt4Wh6YQMTIA8XzKWCOV1aMGUgs3aZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYAJMloT09ba7cWbQimG3VHbwINeVCc6DCeTxTiXhfE=;
 b=Vw5DI3PmfF+41jIIJ5iM8ekyFpICXIgwJ6NFJh5TxYao59abzeRkh8DUYP26+t5eqK/UUc24bEZ7Qdt0ZWQc2CU6xgJN/JPwReRCjBIXOq5O1PdI/IY8vX/hDGz1Tt1Zk4zmNSBfr66ft5uU50E+/qkFBXKiP11MpN7sBHdWPY50QnrsdOR742rNZ9/lE7Q8aoTUv8isGkMwXVieIzMt1dgt5RXPTiKs50mhzJDDNQv0zQuheo7Nr35OV3fC49wHJJyjQUeD3AWRmhWDPxgETMcWd9j6rIwC5wocTad2fvar8Gchvtt400MM1WWmld6+9LIBS9MkSTG/mdki2rYqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYAJMloT09ba7cWbQimG3VHbwINeVCc6DCeTxTiXhfE=;
 b=IJXZ/oKVyfKcWkdXJYf3iP2qWs2jYAashg+vN+mwhuBf1h509G6AJE/tuFQbrN35b+nNLIyJM58ykv3ahYmBi00P50J2Ku+LefKnDw93GncvtolvNj4cQ37zoRORhLgUaz2IuAEb9f+MVEd175xvJwrmaFa495KLXWcRQdEPsz4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3761.namprd10.prod.outlook.com (2603:10b6:a03:1ff::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 00:54:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 00:54:01 +0000
Subject: Re: [PATCH 2/4] mm/hugeltb: simplify the return code of
 __vma_reservation_common()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, hillf.zj@alibaba-inc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-3-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e958d731-67d4-a56b-aa1d-a8054cf232f2@oracle.com>
Date:   Tue, 6 Apr 2021 17:53:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210402093249.25137-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0151.namprd04.prod.outlook.com (2603:10b6:303:85::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 00:54:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77818763-d84b-4410-f2a0-08d8f95fa246
X-MS-TrafficTypeDiagnostic: BY5PR10MB3761:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3761FC37A932FCAD86EE1BBDE2759@BY5PR10MB3761.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFqL0Nq7i6d4cWxU58NA8SVOcNQHqOnvuXemLZs96uQ2X35ai5LXp3maIFjORU/av+RaD6h41NgJO9al2yttTZHgn60bIfd9+CQ/P4x4N4/1ge/9a7vOnFnx5y+SpguSqbLs8lugmXCXDEd8Qy7IP6MTS7anlIq00B9pC8sCXvQsNKPF1MUXkk0e+qmm0xo8g7zAjfPNj3ywz+af5XS1TIs93TBV98knMRAh9LVHv4ONjwny5eCHfpffEebhNHH3VIhur+V/sAI6iKuihxGuJGJ1yPYfGlW6s34JgVt62VY1NnwzbqcGAcnBAO+j6wDRyJPw/7dh4gAPuIj5d9BldqYNcK8+LM4S/7JyymKBWdnOHRxIFbXMVS5IS8HDHlWM522q0QWqloBZ/TqzInC0cFul9eaLXa4y9mZLjTivVOPEtYmgH1Idd4Ytep6c8PaG47DwV7jYtKGTQxgAd4Hr9NmpMNe6N2YdpfxDiHFQ539Gd2HU3v+SKd3Aj8vE/NHSLoTMJCiL+ET4ZtgkzQvTonib9sozaTDGI0nyRIab2r24UhudbfwJntK+eiBh9Oa82h7ycmBi12pXCRNFlfuLswYF7b+2jPk2h6UMK+dtIqPb3GSabrIL3AoEnUHy4YNqNzKx9RtDX8zt7Y2wH7bkrBXxLfrP2gNuDf8pRpcC0gbp4oGRmAJb/AI7NNG+j+nA9GsU+E260g8ARPAllLZuqliaVT4NjsB+rcWNbxN3K8T4j26BDbz8XTwv+Y76voBv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(396003)(136003)(6486002)(8936002)(2616005)(956004)(16526019)(53546011)(186003)(16576012)(478600001)(316002)(4326008)(52116002)(5660300002)(31686004)(38350700001)(36756003)(26005)(66476007)(66556008)(2906002)(44832011)(66946007)(83380400001)(31696002)(38100700001)(8676002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEhzZlNkNjZVMlZnUi9NVXN0Qi9EWFFkK2tCbFVuOGl3cUtxVmU2RWFiU0FK?=
 =?utf-8?B?RmZOOXhVWWJYMlh3bGFKRy80Y0U1cE1YK0tXR0RIeXg5K2xPa2JVdWRWVDdY?=
 =?utf-8?B?c3lzKys0NE5aVWloUlRnVzB3N2hYNWx6alhoWmpVS0dad0NXZGNKemltRWJy?=
 =?utf-8?B?M3BKbDZCaXROeFFvL0pEOFcvUG50KzA0VTNIUnowVXpFeUwwTkk5MmcycUdD?=
 =?utf-8?B?RkxEclQvYnI5bFhLRzZFZVAzZE1tVEVFMVZzK0ZMMjZaR2ZjY3FzaGlYUy9x?=
 =?utf-8?B?aWpsbTBlMW1aYUlIbFFuMUdJR1pGOFNndEFJOCt5bEpKVWg1bnpBeDZkVTZm?=
 =?utf-8?B?a1hDMkZJR09HVFpRV25nU3ZzKzJGT3lwU2hXRWxCQ2d1VnI0VHBkZzhOdFdJ?=
 =?utf-8?B?dzFuR0l0eEZoaEJkcTNoQ3F2a1JOSXhKR2lvN1drSmRDampuTEt0RjZPR3lC?=
 =?utf-8?B?VXBrakM4VkpKRTQ1dE1SZEdRNHo4Q2hpRVpEQU1hVldnd0gzclBpQ0N4OU9k?=
 =?utf-8?B?Tnp6L3ZZbnFMbFh0TlhnL1pSSGlKUkc0aFlCTlJzKzkzMEd4VFMxRVNNcEsr?=
 =?utf-8?B?bHhWNzc0cW5sUGlTRlROdHpMNkxKU2xlczNRZ3htS2x6MUJQRFdZeklTbDJi?=
 =?utf-8?B?L0cvMnVnUEJTcFd1RTZBWWN4VFVjYmNpM05KZWRBV1B5RUplUGdFL3VlUHFF?=
 =?utf-8?B?UmU0K01MUFhEV2xEVVZPTUV0d0w2bjFVZzlFN0ZaMmU0Ukh1RG82OCtZYkln?=
 =?utf-8?B?QjZ4Q2xQS2FLUmptZnRrUmdPd3pMUlkzajM1eW1LM0ZMSTdiTkhlMzVmcGlq?=
 =?utf-8?B?clAxSENRS1pPYnptdEtSbE9GUkFaL1krZTNZbmh3eEtoeVozTzR5bHdiaksr?=
 =?utf-8?B?UWFxMGFyVjA2M2F2eFFDbDE4ZUtrS3FwczllUStUQTVUUGQyeVEzTi9QbU1G?=
 =?utf-8?B?RVZPY0FaYitRcDhsQkR6dXBZdEhRd2RCaHVoSzQwVmRIVFNVWG54K2JxVGNC?=
 =?utf-8?B?RUptV3dBOXllVkNQWDhWb3ZMVktpTEtzeFhXd3B6TGdlems5WjlpRkpFV1JV?=
 =?utf-8?B?K3dEY0kyMElzanFrUGlYVk0wSzZnUnh3b21qcjZhVTE3cW1BVzYyeVd3d1pQ?=
 =?utf-8?B?emFNT0Jyb25GSnp2TmFVckVsVld1SlQ4L3prWjhoWk5leUNsanprTzlicHRB?=
 =?utf-8?B?czNrdmRVWWZwbmxkOXdMRmZyaWszZmhWd1EvdEh6Q3FOUDUyUk1tNzRRYWd6?=
 =?utf-8?B?WGcreWROMHBjUG1OcXhMMjJJUThzL3hzdU5TaXh4Wi9TempSNjE3QzR1Qng0?=
 =?utf-8?B?SzhqUk9jNnJ2K2xFaW5HUGQ3alhRQzlMek5qTFY5eXBUUUt6WGRQcjlBUzkw?=
 =?utf-8?B?QTdmcXljMmJhSXdOS05TMG1mdWlsSnpvdnlOOUM0eDV2dlkzS01Rd1MyQW80?=
 =?utf-8?B?OFkzZVM5bGE5SkVVQlNaVmRyQjhiL3E3ZXVuSmpUU0llT0FzL1dKTlRDNlRh?=
 =?utf-8?B?MUJ6U04wWVdUb3laOXBJZnhTVGRXaFJwTW9aL2JyaU1hekhOWnNUemZ4K1hW?=
 =?utf-8?B?OURyQW9oaHhURGlhbHlMV2pPS0U0SjlGcWhycHhUM2tjektUSEw3UFYzSHMx?=
 =?utf-8?B?MFZrd0ZncE1ab2p3RWVwaGdrd2VFUFU0dTBWUkxmb0dGZDkwUUY4eUxYbTVu?=
 =?utf-8?B?SnNHRUhrcC9QNDZtNnRMeWdOZkNGQXI4aTMrT3Q3Yzl3Z0dQOU1DSlI0cHoy?=
 =?utf-8?Q?x8DVMDcWULgvBawowLj9pQ5gWcEfvcee5Abd9Gk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77818763-d84b-4410-f2a0-08d8f95fa246
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 00:54:01.4126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgFnQB7TAbXMmKi3bqYFbMB2mvkW5R2wuqCUfGC7BFvcHR3yAEy+DwUipxZX9/4MdAURSxg3RnX1IT4gXbA3Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3761
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070002
X-Proofpoint-GUID: Ovzhoji-rl_az51d0grfwna55kNlzBAp
X-Proofpoint-ORIG-GUID: Ovzhoji-rl_az51d0grfwna55kNlzBAp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 2:32 AM, Miaohe Lin wrote:
> It's guaranteed that the vma is associated with a resv_map, i.e. either
> VM_MAYSHARE or HPAGE_RESV_OWNER, when the code reaches here or we would
> have returned via !resv check above. So ret must be less than 0 in the
> 'else' case. Simplify the return code to make this clear.

I believe we still neeed that ternary operator in the return statement.
Why?

There are two basic types of mappings to be concerned with:
shared and private.
For private mappings, a task can 'own' the mapping as indicated by
HPAGE_RESV_OWNER.  Or, it may not own the mapping.  The most common way
to create a non-owner private mapping is to have a task with a private
mapping fork.  The parent process will have HPAGE_RESV_OWNER set, the
child process will not.  The idea is that since the child has a COW copy
of the mapping it should not consume reservations made by the parent.
Only the parent (HPAGE_RESV_OWNER) is allowed to consume the
reservations.
Hope that makens sense?

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a03a50b7c410..b7864abded3d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2183,7 +2183,7 @@ static long __vma_reservation_common(struct hstate *h,
>  			return 1;
>  	}
>  	else

This else also handles the case !HPAGE_RESV_OWNER.  In this case, we
never want to indicate reservations are available.  The ternary makes
sure a positive value is never returned.

-- 
Mike Kravetz

> -		return ret < 0 ? ret : 0;
> +		return ret;
>  }
>  
>  static long vma_needs_reservation(struct hstate *h,
> 
