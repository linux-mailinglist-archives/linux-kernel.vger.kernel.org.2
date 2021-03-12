Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD01339812
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhCLUNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:13:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhCLUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:13:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CKANHP177973;
        Fri, 12 Mar 2021 20:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ob/bU0hJzV90EhaxxbiZo9Dmz6ARi4eF+0oJp2lJRm0=;
 b=U8KnEFuIfn75ApcakB6fusPHUlxrMBP0OBLv+iLjuSuC50DZlWnEHVMyVxHnKRLHhwHj
 RaBmAGJ6YokEt0+ISuQ8O0nOZXmELspygU6GIrhfU6Cf4M9+hOpm0qJUB95xv17z0dpm
 K4M+Ie8iN52TCmePqX/2SQkf8Kg/bA4JZCRHBXKk2CpzviT34ncqTzyCsJgI4qlVvE2v
 +8VM0Tu6ICbcPY2gDz75xycqp7MmtfIszxl+Ymd4yoLpyWNuV8i/2vz+Wfdb10o7Ew+A
 Af1mGAvG23iHA2TvrdGfFV9XSki6p9zay3kbHYnayl4pOKrZ5GV8J6kjwfkG7u2ramcY pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3742cnk0vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 20:13:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CKB76t052746;
        Fri, 12 Mar 2021 20:13:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 378c9sfwpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 20:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzsQru1jVTxhWmVlCGRTp4lfd5p+wDV57TmcGxYj/aCGhF11zZ/CzACvpyeVtMRfuZYkH+z+o6SQ/wUwoouaz1Rotl5sTbRq1Wu9Q+5NktSo3xvQnVKNbLCVJUX+Zkl+7EaihT79YJCeRHQtgAEbFSX/0u6Q+RUdFCYyZbfR6w09bVgYn6sRPjZWfaDhpa5TAgVbVo2yrTc0S2tE7pn77UexDSI19NcCxTPBo10PoM3y5CZVxsRFPJfyji96F1KDbRewPB9KqlJ45tszIgDo/pG++Kdk81mTt1J8qLV/ITR1OWjtDgAdxu5PIFhVcMTGPa6fvYYAatJeXOIK3BTLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob/bU0hJzV90EhaxxbiZo9Dmz6ARi4eF+0oJp2lJRm0=;
 b=NI5GfdSseDThOh8XTeO39n9hahdGGoX/jUoDqhVi3ckJi1PqMgtWojPLmo/f7cZJKYCbJK36q+K14Ad5VfIbpSt6dAzGHODksBub8DcCId88Ei/UJ0OLWk+XKHXWTuQLQLzCAuq3G+OW42joXbLnQG0A7+sup6sUvLnxplmx8wCockZ1TAj2UtVfwPsTjE9fGOz0h2oYdB8a77WsbpIEBtNdw0SCbJQC0tbpBw28MtOIm8oyrJm5Gheys9JsoEnR/WRK4ICju+eqoojilyxN8kv8hHYX4ByLbuX/k6WU2WAwTsnZL5VyXONRdcTcVC5ziuOeyEna3uIneYoO4OAbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob/bU0hJzV90EhaxxbiZo9Dmz6ARi4eF+0oJp2lJRm0=;
 b=ovGnE+9aZS81g79TcgNkymyQVdxfaX9R64rII/bNjXI8MwIhZM6XBvFamM33bNsg5uJkOyn7Q2/02sk+mlheRuYS0MrdUOcDAl+Prx1412aN+9cJOT+96buFI8dDoQvL5VzkvH6iR89zsjysrbceRC/lFcW61V2PZeN0V4eG2ss=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 19:46:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 19:46:20 +0000
Subject: Re: [PATCH 3/5] hugetlb_cgroup: remove unnecessary VM_BUG_ON_PAGE in
 hugetlb_cgroup_migrate()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210308112809.26107-1-linmiaohe@huawei.com>
 <20210308112809.26107-4-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4d302b2e-39a1-e4eb-2b7b-b5d4145bbec2@oracle.com>
Date:   Fri, 12 Mar 2021 11:46:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210308112809.26107-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 19:46:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a63988c-af9d-4fdc-7de2-08d8e58f8263
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4670:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46708042A2D9B5AE1F3518C4E26F9@SJ0PR10MB4670.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnC4Ea1d0txHE1+YThQDnYcGYJIW0JWNYLXVCHdLKOWCN+GT1Ur6Z9/XrADLAh0KehRnuDWyD2Fjmd64ZqDm3Gzg04zvksdEK4AY3guY7Zao/B/tD2b0VmZ8iDa2zpCkMbBgJf/EiWGRSY2D34YCBb0+hm7Wv2sc2wvOn6B2xSm9mqPoE2eFyq8opjUvaC/KJD5LTYiWtqkbU6taEgBXu2CtF62ypocwJPYoukd1gEoBUfmAa+M86drSRcF3aVnrHP493Y699zW3Kf9tL1jtPWoqre5d/ndBmGNdxQbzcIb2/wQcx5ZcCwshjjOE7TC/5MdOWgrr3vu6knBgrjQeEyg2DY87vX0dCydM6A/0kJAcAUfazJrHhwylYZ57phKxBhiK/mVIClipq9I0DjFCqAXPcny+Le0ehX+mgkRrRUuA+s0H27d17kMFHaWaUn1Tx9E21JZsd9rQQffIKPVtg2njB+YldWbCI9Y58jEQVcpEOCTLCrAOVgVqvOiT/YE3Qth919B76tK3XsST479EU4aBJEvKl3mKqupddxAzzTWkZiyUCEkpb2lJkK7hEf9ykRt0nV4n3TXTLc0+Mz7IIJ18ojX+oZdZIJnGExoygBVTPlnOnY8207SKxVS4RXke0tv9c3oINGzuKZhTX4oxrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(396003)(376002)(26005)(31696002)(16576012)(8676002)(8936002)(4326008)(52116002)(6486002)(5660300002)(316002)(2906002)(16526019)(186003)(956004)(2616005)(31686004)(66946007)(478600001)(4744005)(66556008)(86362001)(66476007)(53546011)(83380400001)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b09zVW1JUnQ3cGFPN2Q0aXRSUXpkOVpVcmExZGhHTzZMUEtNaCtobC9EZWll?=
 =?utf-8?B?VmhvUmdFUDRXc3JtNi95S1VqL2lDVkdsd3RHR1RIbG5pQndTWUsxYUlybisx?=
 =?utf-8?B?QWFsV200ZmNFYk12Nlh2V2RTWENqUDZmTVhTOGVJM1ZJSmFmMTF3c2VqblJy?=
 =?utf-8?B?RGd3SDdDNFA4R21STEEvL25iTWhxdDI1WjIyREFHWk5ZRGs1UHV1clFuWHBU?=
 =?utf-8?B?ZWsvVHc5V3V5Tk9lNDIxbjFjOEoxY2RJTXZMY2dHTzNaRTNiNitRRmF6ZjQz?=
 =?utf-8?B?ZjhSTkQzMGxuaVZvZEI1RGRWeVNLWENRT1VFOVNyM3lWb1VCZE1YbXRaY1R2?=
 =?utf-8?B?THM0UUt0UnNSUDQxWlVmS1AzZE42KzBTak1uRWN6Nkc2MEJGTW82MytxVGtI?=
 =?utf-8?B?UVQxaFRqckdpZEJvNmxDTFlvSTdSdlRjSDNaMjNUQk9JVTRFSXBsV2prdTVj?=
 =?utf-8?B?WGhZUXFiNjdBVUNoaFJXY0RlL0RiZHFXMm5sRmZXeWtpcHF0YjhGYXVQV1BQ?=
 =?utf-8?B?TFVTY3Awa0lsRGVpK09yOFhUeTNEOVFqNHpGMmdsWkdYdFRmbTJiT1pQSGpn?=
 =?utf-8?B?RW40VlJGcFVhLzZ4V1hjL1ZwbEdHY1ErN2Y3M3luTE54aENyYWFQRUR3VndP?=
 =?utf-8?B?aVZsTUdLK282b2cxTnh1WGhadlczNXh0K2U2aURzeDVNMElvWG10U3RqQkdj?=
 =?utf-8?B?dXJzMm4va0I5T25CWGtabnQvVGNBMk1MVVVZUit3QXNTSENCMGVSdTB3MGVP?=
 =?utf-8?B?bmFLdnV4TFRqdU5kR2E1SWJpdnNYcUlDSVA2RTFwQzRRSUQweVlQV0pRaFJj?=
 =?utf-8?B?M0YxUkJwdnBJK0oxUlRwSlZIZTNVelloWHI0MHp2SFF5S0l2R0FiRzF0YjBH?=
 =?utf-8?B?TUI5cnJodkIyOGMrYnRGUEJTaUI5cmJKWVpraTFaSW8vR3FiLzNxL0FrWGdy?=
 =?utf-8?B?emFKVUdob2YxSnBsQVIvbnpwMGhSUE02WmxyS3oxVnpPWWR4MHpIMC92a3Zz?=
 =?utf-8?B?emxVUDRqbmZzMG1lQTQ2Q2lkWWswMDJqVVpYY3JZb0JQbE04K0Fud3EwbmpB?=
 =?utf-8?B?M3FXOG4xQlIyWEZ4NEw3R094N1ZvOHVKVklVL21JY3R4SlQ4VE82TzJPU3R2?=
 =?utf-8?B?bHY4Z3Q1ZVpBY0RVUjZ0clNtRnZlMWpGQnBiOXJPemNILzhNSUxsYkRtWFN0?=
 =?utf-8?B?MnBGQVdqUHBHS0d3NlNNdWlnRDNUaHF1a2E4LzJ1eUZSSmN2RXFXcDBCTXZi?=
 =?utf-8?B?SmZZU0JIRmRuL1p4ZHkxdzRVdmlaTExUOWs0Um1lYVRtS0xYRkxOR1NJNkor?=
 =?utf-8?B?MVY3MWlkYzdBY3M3ekdPZmJ6d2ZHUEJ1bEV4UU9VZklNMG9vTUs2RjVXQUt1?=
 =?utf-8?B?eG93c2Rrdyt5WkVaaDU5ajBmQUJPeVhqdnozUHFtNHpod2x0OGtUVUNVOGhB?=
 =?utf-8?B?Tk5CZVNVeXdEc2RLUzhERkljRkdxcUVMZHVIZk5va05nU2lTaUdLSzUrdW1y?=
 =?utf-8?B?ZGd6dUo3VHRNZVVIRXdhb2lvdG5ra0J6bkdFN1U3WnM1bTZ4by9maGhRZlpm?=
 =?utf-8?B?aDl2THFxeityNHlDWkRwV3VSRGJHZDNMRTJiTWhKc2ZPanNJeEdiUyt5aHM0?=
 =?utf-8?B?STNvMHErSmhHeGtwaFZ0WnZMUDNrU2lPQWQyUFZ6SDRuQkNtaE51TnZUOEZ2?=
 =?utf-8?B?bkM0RWFUcHhwNkNoeUQxdW1vd0dlVGxCNSt5am9URGt4Tyt2aWdmdU94Z204?=
 =?utf-8?Q?4KWAm6FFiJ39rnt+OehWv/3ELyoPYVrXdO38VIF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a63988c-af9d-4fdc-7de2-08d8e58f8263
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:46:20.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 453uX2GbHPHzFS4suQlki0uS8CcfhhMwi0ey67M4HEPhKwG3J0LhQzma/bVyXKL5TzPr3llGSAAP0e+mLaFh+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 3:28 AM, Miaohe Lin wrote:
> !PageHuge(oldhpage) is implicitly checked in page_hstate() above, so we
> remove this explicit one.

Correct.  In addition, this will only be called for hugetlb pages.  The
VM_BUG_ON_PAGE is unnecessary.

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb_cgroup.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 8668ba87cfe4..3dde6ddf0170 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -785,7 +785,6 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>  	if (hugetlb_cgroup_disabled())
>  		return;
>  
> -	VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
>  	spin_lock(&hugetlb_lock);
>  	h_cg = hugetlb_cgroup_from_page(oldhpage);
>  	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
> 
