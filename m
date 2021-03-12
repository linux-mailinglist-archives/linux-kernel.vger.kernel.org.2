Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8572B339878
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhCLUaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:30:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47616 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbhCLUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:30:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CKTK75018800;
        Fri, 12 Mar 2021 20:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xt8nTPuITAMJTKIFh0QvBxkwa69pj8AbGEAvKHmIN/Y=;
 b=xwlstRALh5gWGb6kRlLr0QT97OojRvXledUqw5+s1BwWFeBVxj53LD/Bgz1q+5fsz5uh
 ygEC25JnQylwmvXqKqtyw1R4pXbsCa8Gl+qMS01eqruGgbe43wM249M+ZFuieBi29A5b
 /UmBI1fviCwVXjBPkIJA0PRs02BtVvsLZ4DwEJCId7G8hyZCID6pIVgVyw+3Ih8hcCWl
 WO05qFhHd/pIM6Ixxfg2bRFOEadjNaC/PSsHfWi0NYqjhzHyBrnQigSd8TfQWH2ESjCs
 eogSOFA55pUPfo5C8EfI3c7EAuP6ifwu7QoP2UcUlUGDxvjvILeebgnoiwVHKs25c8AA Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3741pmu32v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 20:29:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CKOiEY047912;
        Fri, 12 Mar 2021 20:29:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 378eyf9pxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 20:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqkDIN6SjLdfN6F8XrS5rPOxcQRv9Y8gIkgButed28Zt2518G5lRVF+qk4gIx99rUtf8JMPk9qTE4871NLTm7ESeJNJBVChtCO7bd/90ICxkGIc+EXVsDzbOPVNoEBLyyTmefM0EWN+eluTPf6IZlg258o+kos+/SMfHTIP/3WeBWJS914Ji67vZ3++2FPEvmqwNSNPU94aDDTlJCTiho2sD4caiszytG4FuQE5R7hj8tcRfZgnJVGMBhSn969Ch50BW6Xf/PqrZff7Hq+p/2P1fZE2Na00Jy479EZZdQsxYbA8DyuKCn/8+5A26jfntLJtjmgVJFAxeuFXlkvnjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt8nTPuITAMJTKIFh0QvBxkwa69pj8AbGEAvKHmIN/Y=;
 b=V3WybrtYoKQDzt/zExRPvsodPVm+gn/1NxPSgpkG1LumVQdrp2/JeZ+MaiEByMMWKRgytzZtt/MliKbq4od15FQFNUv+1krXQJtYSI4nFy3z63w4Rz5FEOUv1T65KIlxGmtK5bKkp80llr03VLk6UlavOF/E3fN9mE5EUNFU9zbycFK9580d1QziFoIUazwEeMh44ipgwuBFacuWVLf9O8szBgzMAj5Jwo1J60EHNIbiWBfbd76D42NKrcqJ7iWZKHN7mBWqQYArSZp/fjA8lSID7PzL8raVOu/qkx9YUv2BdLFtC/xgTLAx00hkl9Bh7p+ykethghWuoTFvixl7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt8nTPuITAMJTKIFh0QvBxkwa69pj8AbGEAvKHmIN/Y=;
 b=N03UcMBDSqfzi1bjAjxKzfpvCCiog05wxewR9Gpl8FoEBj8YKIeDZWJuGpAQ5eCm70rd+oxcAZPhu6R6FjN3O1lWfFmpPFbiC5acHLNbhb8MIOj4239wCbd4SmzksZr62ZXiwKTYhgGQLqHEqK7UdVUX/J8fFJMDO0HxhDn1jCY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 20:03:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 20:03:40 +0000
Subject: Re: [PATCH 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in
 truncate_op case
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210308112809.26107-1-linmiaohe@huawei.com>
 <20210308112809.26107-6-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2baf9a1b-1c69-8168-cfd9-5b5ad45a4cc8@oracle.com>
Date:   Fri, 12 Mar 2021 12:03:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210308112809.26107-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1401CA0016.namprd14.prod.outlook.com
 (2603:10b6:301:4b::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1401CA0016.namprd14.prod.outlook.com (2603:10b6:301:4b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 20:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e264142-a8d8-44e9-f79e-08d8e591ee0e
X-MS-TrafficTypeDiagnostic: BY5PR10MB4113:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4113BC4C4A11F63B38E7D436E26F9@BY5PR10MB4113.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XDMQLZfAlTTBY33T8OHiDUit8+FBQYgGHXTBzhN+aKLAlCWwsSzj2wIy9YLc0W7FPRemRlcixRnEqjj/EvuYt7lBg2nI27DkiiQfXrXQ8kEse1vg4X153ee4a8k88WiUCEu9WNyP29Jb7hHR5l30GtHOIZyxDWmv9y2nYh7paM1VXsytkXrosWzKAFBmOv4W7/SxQxw99sI9D0xpfke9AL+tKC2WKow/3dDvng3WZ3ReGh44OmL4jIHZmDOKzz2CcOHZYhJLM4wPLEmu4CovGpoaBwTkt5hU6nyprxggNONn8uyI27lA7AfY2CkoAUKM1iNu6kBlgXmEgJN+aM6cUDr+ddhFnjUj5sOEUYZdFPpD9TdJKf531Ui2UmxSSbdEWSAe3ADqdlCo2teXogNor9QMCzOPfUx2YTokOu/b6/bEPsb9zifuk8wTw7mld8B1wor78o1quqpCwT704K5e73c/SAQ79d9dGcr1RcZQs4pa8yaIQvB+VgM6UuZuaPWwEm7kMjrTRGLsqpLErh5ECc2rNWXO2Trcv9pAc29BDQ//tlp4yvgcStMxcpI3N4jsoMyQ1lb1Xz6meTmkC/l+F4yHFjj3Yneukq9Ya+hto0TQUNFxYcw+jdML8hh//zmuypqBPzvErKyUCRml2nZdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(83380400001)(31696002)(52116002)(53546011)(6486002)(31686004)(16576012)(4326008)(26005)(478600001)(86362001)(8676002)(2616005)(186003)(66946007)(956004)(36756003)(2906002)(5660300002)(8936002)(66556008)(316002)(16526019)(66476007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1VFci9YTS8yUi8zN0E0YmkveklRaHVEWDRBbmJLUURKTUplcTI3NVVPYldO?=
 =?utf-8?B?bjhhTE04ZjcxRXJvZmZlWTVHR1R1eWlxRkZkaXp3cE5JQVM0czZoZ0pEWWpT?=
 =?utf-8?B?dFI3QUdtd0tyME91S0FUOS9ocVJEMnprMDY3YmxRd2VPL0V3Wk42eGxVamFV?=
 =?utf-8?B?VnhUVXhhNXM3TjdMVkkvK2RxQmNxMlhWU0ViZ1lTei8ybUxTRGtjbmZBS2lQ?=
 =?utf-8?B?Tk8ySENXdkUyb0JCUW43NWI0dUhwZEVEQzdOa2F2SVl4cmVRWG5XRGlKbWFw?=
 =?utf-8?B?R3IwRkQwS2dyc3R6QTFsdWw0bjZOc2FpUzliYi9KeStrZkI5aWNpeUcyME9W?=
 =?utf-8?B?akpaazE2amhzSzY3UXZ5SzNyMXh5aHN3aWRNRWM3RHFLQmwwZ0EwNHRYUmha?=
 =?utf-8?B?dkxteXd3Q0dDVFJVZDJCOElyemkyMUtJKytUV3E2OTlnallZYTJiYnMxZnVH?=
 =?utf-8?B?QzdvWGVpNmRvdnFtRHM0bXNoaTFFK2VKaG9vVHl3aXJ6Y3dja3NiRmVnUWxs?=
 =?utf-8?B?V2ZnRTdSMkJuVHk3VkZVbldHMlVPemt4Rzl5YzZmVnJSYUUyT2lrcWYrK0NG?=
 =?utf-8?B?L1dqbXlCSUptMzBxM0pQQ0R5TE4wSWxqZURMSUtEWDVpeTZFeHQwMFhOQkFs?=
 =?utf-8?B?SjJsY2FHbFM3UDhXZURXTVk4NEJyQzVnT3Q4WUVXVEQvbUE2ZnJnMGVVamhH?=
 =?utf-8?B?SkJKK0Q5MXFXak9NdlQ3Lytrd1RqSnphUnB0THZTUjJhNi9MNWE2MVBuTmY1?=
 =?utf-8?B?akdJZnU2RlJNQXcvVFFoMjRaZ0tRcUxhVkRMRDVpS3FzQm52dTQwVkkxblJQ?=
 =?utf-8?B?MFRzNlNReEgwVHpMcWhBTTRkelM0WERVMEhYS0UvQVpGUHVQeHdWTkhMVHYr?=
 =?utf-8?B?VUFveGZVaTMwZnRwTWhKSTJGKzE2UnE2ckVWWndPZXBDQ0V4cnVtVUVOdjlj?=
 =?utf-8?B?N2xmeDZvNzlJeUc1clZ4NDFPbmplSUV6a3ZyRjlvd3l5d25MVFJ0VWR1Vk8x?=
 =?utf-8?B?emQvd0FPVEJuUkFRVEdmU2lSVkdhNFNJL2ZGSDVNc21vemhZQ0puUHBYZW1W?=
 =?utf-8?B?VGxra2Q5UlVLT1FLRU1VMzBESUh1UTUwa1M5TU9lajFxRlBuUm9MakhHZkpq?=
 =?utf-8?B?c2lKWkFUckVOUy9GcTVqMGc3S2p4WThVdkl1eERERTB1T3BjWExRSHE2MktL?=
 =?utf-8?B?R1Z4bU9RbndzMVNOQVcrNWs5ZmhpdmxtblpBUHU0bUtPbFdNK1U1T3VDMWx1?=
 =?utf-8?B?RStOKzdmY2FuVG9Dc1NXSWUrelNrclVUWmkySzNTRDBCZFUxQlNPMDR3RWx5?=
 =?utf-8?B?Z21VQm4xTHN2Qk1hZkxibk1ZNUJFV3ErbW5kTkVpaC9QRkh5c2NsQUlyZXho?=
 =?utf-8?B?RjdlaGF2WGVnZThiVWpFNk1WMFBKQ0JTM1ZMUFQ5NVppVXpsUGQydmRCejlD?=
 =?utf-8?B?REpFL3cvWGwzUFhiUEl0WER4Uk5DZ1JzSUllRzZxbEZpSmhvOW1JZ004eng1?=
 =?utf-8?B?V1NpVHJBZ0RjTVJTamtYSm9rL0p3WUd4SVdhZTgwN2p4ZzBGTVVKUXRPemVz?=
 =?utf-8?B?b2NFcTdzYXVXV294OWt2RVpXWDZ3alBVVjd5TjlicFl5Z2s4cFE2aFJXZ0Za?=
 =?utf-8?B?bUk2NVdJMmtMK2orQ2o2bGkyLzJiN1ZMQ1BmUjZyMmxuZTRlT0ovL0NMM3hw?=
 =?utf-8?B?S2xYWjVoMWhzU0NjYXRiQ2JDY1BIWXJ3Tkk2WkNWdzZ4eWlneklUMmk2cm1s?=
 =?utf-8?Q?2ssHKQPLZbz3ZFoALizsbgJXkVVg4KQSOY/xGw+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e264142-a8d8-44e9-f79e-08d8e591ee0e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 20:03:40.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1morZ694T3asyP0I7RTfIpv3Q2hv7mkx4n4hAHHq3Ymi0qaCcbAU5EW/mYlLpuI89RohFUjX+dNsJ99ILOqsEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120149
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 3:28 AM, Miaohe Lin wrote:
> The fault_mutex hashing overhead can be avoided in truncate_op case because
> page faults can not race with truncation in this routine. So calculate hash
> for fault_mutex only in !truncate_op case to save some cpu cycles.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index c262566f7c5d..d81f52b87bd7 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -482,10 +482,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  
>  		for (i = 0; i < pagevec_count(&pvec); ++i) {
>  			struct page *page = pvec.pages[i];
> -			u32 hash;
> +			u32 hash = 0;

Do we need to initialize hash here?
I would not bring this up normally, but the purpose of the patch is to save
cpu cycles.
-- 
Mike Kravetz

>  
>  			index = page->index;
> -			hash = hugetlb_fault_mutex_hash(mapping, index);
>  			if (!truncate_op) {
>  				/*
>  				 * Only need to hold the fault mutex in the
> @@ -493,6 +492,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  				 * page faults.  Races are not possible in the
>  				 * case of truncation.
>  				 */
> +				hash = hugetlb_fault_mutex_hash(mapping, index);
>  				mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  			}
>  
> 
