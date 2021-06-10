Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5065B3A36A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFJVvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:51:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFJVvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:51:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AKA32Z089808;
        Thu, 10 Jun 2021 21:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vcpvz9Y7CnFtMg9i9PpfbNfNvhEzwlTRdOc/dm2Cvb4=;
 b=SccqZzFd1dmdHIFpeeLv5+rVXfnXo8UTpjkIs6+Lq+FfuL8URfWdCeWXQA+9zn3NN2OI
 /zquY2ngOFSB5e5A+r+Pmo4sydmv9swuO1s9cCvInOPtOKQp3SZdTvztUrZYmFpmyd26
 3Ml04j43Prm07Tq6SLygJdxRlNIPY11HOSRMNvtVvegcxSV2WjmZVsHcXyR6Hjyu+4cY
 t3OXtLXEfWcbx2id6Jk8Ljd3yHSYlhhqv0dzQbDbeZsCdN7PPnGLIIVnDt4ZL6eBKhEN
 3QFQqtjlZRAVK9HHYwKOvEzmjanzlPvYxq6nqJXZLET/3/Ngs43qgOTAcLod2kEOoWNb BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 39017nn59k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 21:49:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AKATT8068314;
        Thu, 10 Jun 2021 21:49:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3030.oracle.com with ESMTP id 38yxcwxkgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 21:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYTiOyJZd0GyEAljkzKTRySHsmDaP+F2DTrWO2SyItgaXexVNa6FFZMvCl7FidwIqs9kkV75B9W5/t7BZPp9u3QuvMSqt0NcNFntxuHRLlrl/kd+jyvVfs1C1A/x3FTCyIr0InUFDrv5OQEY8rd4Y/P7PyXUKY0J+tZJlz6o7kKBFUjaB7BLAOLhCUGbQsdh0aeesGuM/FWZSpimZ35sqa05vG+qTJkpBH2Qo802o3fPKbh/eVSailbsZmqg+y02UJRpVZdUoFwwj8pE+KUPM95Jl2eIXhpZKHDYe0pO4YqkLt8Ul/TrPVh92UEI6/GydxeBB8/QNG1UOkr+tZz+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcpvz9Y7CnFtMg9i9PpfbNfNvhEzwlTRdOc/dm2Cvb4=;
 b=khFrEujzYiPai7hsrvTv/kqjNwcqkWr9aLLDJK409H1aoSKaiweiun7E88R/fooTUhnH/AeMGTKIogZ2eXw+FSj1LAdBNXHR/lR6VTIVmxQfIqVFzHYlJ25z9/n5hroSxMaD9gCjAuQCd2/KpHF6Qsgpb0/4RycvxYfn1Q/8B6+2w8/fEyM2e2exCrYyPqjdzD0Jj+ROKCVQDfZ00DLXUluUk9HvVPZ1flQp3Acc6N9eDohC5ndclxKNV0kFC/0J9tSAIEgFEcz4Pk6i9sUzEwtVULXUIdxfWrMkeNqnyRBmG/jfxws7g47TzZWTiDvX9lKxt0bQ8aazeVB+bgriSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcpvz9Y7CnFtMg9i9PpfbNfNvhEzwlTRdOc/dm2Cvb4=;
 b=XZOUXcGI2Ze0+RRyzthqrZdKfW6mmmjq8Bi3vnHuirekYVJh07YFst6oLEZFA4HhUUy89a1VLAgeizeoRlkADoOGh69y+vunjpcY1LoaDFzoB2CZqnd9MMG+rI2rlAdws/BOg/5byt2gfFE2XU0ZjSpxIVZWRTBT/jMv1PoxvY0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 21:49:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 21:49:21 +0000
Subject: Re: [PATCH 1/5] mm: hugetlb: introduce helpers to preallocate/free
 page tables
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210609121310.62229-1-songmuchun@bytedance.com>
 <20210609121310.62229-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1db48b66-8b99-ab4d-4b15-b4dcb7084e8d@oracle.com>
Date:   Thu, 10 Jun 2021 14:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210609121310.62229-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0006.namprd10.prod.outlook.com (2603:10b6:301::16)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0006.namprd10.prod.outlook.com (2603:10b6:301::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 21:49:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acd4cc55-0392-4479-86d9-08d92c599ac0
X-MS-TrafficTypeDiagnostic: BY5PR10MB4369:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43692B4CC63AD1754661EFB7E2359@BY5PR10MB4369.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvXtXkVRBDGHbjSyZMyZmVvJXtwsQqAjWTsyWOAuimmg4aeY+i0hK0CX2U71o7rTNW5snWWxARWtrER/amjrHQYN293dLUaCYc+Z+IPfAQ/z6q+34SdapZT6MAjoMAbpCP1XfmuUNqDFJjej9N0eeukxWHnSpT3ydauZLmbTWWd64d53594mlq1+xB//jtk7Y63LUJ+pl0jJ5ofcC06qTXWxa/03BRixYG9gwfDV71bdMNkAANXfK1Iz9M4s1gEWVVRbZSVN2SMdR1EKaqnn3v5wRLo4VwBq4phoy689c7XyU9udBGlrfaHoskBV96c7Hb9Kc/IYjikQ30e/SvlbuaJDWQSgpSjSgILrS0lSOVhPEwmcvngBeHy7T2gduaU6w9kpV/s67YBnK92Gmu1NMQtl6zp2zs5hdNJey1WrgbEl2EJ0VIMcWNe6BBo3pqSQ4BVqIki7KM78ckLwa26SG7inCtKA+/98fAYZlvhK/ngmduNYx9xt/gaQZpFABaozETybO5fJRR4mmxGRCCvAasxiKapB3HVppec1L5uPJdmp5jxIRmMbyovIXsuUr8l+pPWRzW61TiKTssRFr21O2dy+cU4FXRDEtEYisO4oGTL1ppS4R8CC1VpCSWbsLf8yysJSbBs1a20OtB33NPsYiW6IiSEVyyeLGmJxsmvysw7yZ9aEG6rSmoOznhoKj0SKR4v5V5SUkHBb3r6nH1ssQA8p7zxSJJQiS0G1bD5aFxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(5660300002)(38350700002)(52116002)(4744005)(38100700002)(31696002)(2616005)(316002)(16576012)(53546011)(2906002)(7416002)(36756003)(66476007)(8676002)(16526019)(186003)(44832011)(478600001)(66556008)(31686004)(26005)(66946007)(86362001)(6486002)(4326008)(8936002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlplemNLVldYUjNSY3hmcjJybnZERTlZb3dZTEdqY0oxQk5aWnJ0akxJMlJC?=
 =?utf-8?B?di9JanF3V29BbVVpKzBnZG94YitYMlZnb0lueEJFS2dCbnpNTGVPclRIb1hY?=
 =?utf-8?B?SUFXTFdtUHBJRWI0bEtuMW5lM0hJMG1ZUUZSa2RuQnZtRnlpOEowL3VXamgr?=
 =?utf-8?B?R1M1NTRadDZHMVRzS01oM3VQeVgvQXkrSUxjTytSRnFKdnh1TmRxYXJneVMz?=
 =?utf-8?B?TTdMc1BVSUh3ZEJKeitnanZZSzhmWWkwbHg3RzdJc283NStBQUh6dzRKWitK?=
 =?utf-8?B?MXlqcUU4QTBvZ3JpVUNCN09tR1dPcWxlU01JQ2swNmt5azUvN1RUbTA3SUlO?=
 =?utf-8?B?VFJuL0F6MkZFWVl5WUNvRmVXa1B1aUtVYjFua05qdmJUaFhTVDF2MUFzYkZk?=
 =?utf-8?B?VmpiQUlobU1QazBTV1ErVWtSQXB3SitFUlc2cnNVV29OQVdZamg2a0JpWjk5?=
 =?utf-8?B?dmJodEl5N2RjSTVBWkFHWkhKUEVVOHUxYzVsbU1tS0NtVERoSUxXK2g3QW9X?=
 =?utf-8?B?cTlxRnBpSG9aM0M1aWFra2wyQmVlVUdncjcyRzY0ZmpGU0RmK3NvQitBZnIw?=
 =?utf-8?B?bUNsaWhvaU5SUzFONitkeW5nQmRyYTlBUm5UUmZjdmpOQmw2NFRhSjBhUGhY?=
 =?utf-8?B?S29KQll6bzZqMWRSS3pCY1JocEdBZ1N5aURmT0JkczZoREVYY1ZQT0ZWUFVH?=
 =?utf-8?B?SFlzSFZydlRHYjRjVmhzR2ZmNHlhY1lGN2loNUsyNFlWQTJKRUZjRHQxSGkr?=
 =?utf-8?B?THRKVlgyRi9Zb0owdXptMlNaTWNpYVZnLzRlVGNEMHM0YWlIemRRUnI0Ym8y?=
 =?utf-8?B?NVVsVzV2WnIzSkxjM2RrRXduVVdwUWIyS0NaTVhGTEZQRFh0aTkvaGdpbHlH?=
 =?utf-8?B?WFY4MG03a3IzRXUrQlRjZHJ2TEFLSUkyMnZQcVB5NmdiLzZSTlUrWlh1bjMv?=
 =?utf-8?B?YzZpRHFoNi9jUlBjWS8zUitwaWF5MkxjelBkM2NFdDZJWXdxSDVNVjJoSHZU?=
 =?utf-8?B?NU5VVjFjZ1NqZHpLcUNCNWI0Rmg4QTRNMDdiL3BmRDYzUXFPRTArNnUyeGc1?=
 =?utf-8?B?STAya3JrV2VWc2FyTUJtT1ZjNUlwSnFjeGIxT1lPZFlDdzgrb3UyQVpobFlx?=
 =?utf-8?B?eXJPUElJYzdIaTJnbUo0eUlPY2hELzF5M3pCWVBwYWVQZ3JiZkdiVHBpZGFX?=
 =?utf-8?B?dE1uUktwUXNuVEVzbi84Y0t2SE5GNnFYOHZUcWNlUHdyYlI2SkRhMDc1RmQ5?=
 =?utf-8?B?NHJCSnFQRE5DTmpudGNWb1RyM2dXa25HdlljbHZuWkJ4bHBRRmNrclFJdmRC?=
 =?utf-8?B?MUZxMmJoVVJUbHNJc29ndERVWktoUWhNZzZSYWxZa0pTN09NeDFkVWFUT3Q4?=
 =?utf-8?B?MTd4ZHBueHJkT2NCK1NDL3I1SWJtMGpseURuQ2hJa0I2Zkg0S3JiQ0M1ajdp?=
 =?utf-8?B?bnJIcEFCbXI1S1VUSk5BWk55ZDNOa1krYVNtYUZvOUg2cWdrNDJQcUpBSW1L?=
 =?utf-8?B?V3ZFdEdxNkF1T3RKd042RlQ0dUdYcWxLT3BkOHVjRkRvTGlFbUorUkxWT2x3?=
 =?utf-8?B?QWlyV211VVJ5REpWVHd2ZFFLVGx4QXUwZEsyV0dyU1YxSWZQMDRGdjAvRnlB?=
 =?utf-8?B?cGszZWdVd3Vza2t0WVZIanBya3pVVTJFSVNUY3pIRVB2eTFtM2Vqc1Y4OUxV?=
 =?utf-8?B?YWl4eFd0TjlsYTBKM2JERGFuVSsyK2wzT0pBUDkzMVZ6Mmc0Nk5FRmVSdTFZ?=
 =?utf-8?Q?92FzCAxgnOXFKIm0sl/sS74aTqfTMPTsEoX0Ue4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd4cc55-0392-4479-86d9-08d92c599ac0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 21:49:21.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wveLUuS7uZEvFcC+Coh1iwDGGBVT3SUML4Wf4G3NHRH6MY9CoycVibaCOfWzhxYGdHNXMStyQXPFEWHrY7iIQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100130
X-Proofpoint-GUID: 7pOckIdD5UmbGgXQrHLbLPut61gheFuP
X-Proofpoint-ORIG-GUID: 7pOckIdD5UmbGgXQrHLbLPut61gheFuP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 5:13 AM, Muchun Song wrote:
> On some architectures (e.g. x86_64 and arm64), vmemmap pages are usually
> mapped with huge pmd. We will disable the huge pmd mapping of vmemmap
> pages when the feature of "Free vmemmap pages of HugeTLB page" is enabled.
> This can affect the non-HugeTLB pages. What we want is only mapping the
> vmemmap pages associated with HugeTLB pages with base page. We can split
> the huge pmd mapping of vmemmap pages when freeing vmemmap pages of
> HugeTLB page. But we need to preallocate page tables. In this patch, we
> introduce page tables allocationg/freeing helpers.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h | 12 ++++++++++++
>  2 files changed, 66 insertions(+)

These helper routines are pretty straight forward.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
