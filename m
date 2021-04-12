Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4598535D09A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbhDLSwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:52:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhDLSwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:52:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIagSj053060;
        Mon, 12 Apr 2021 18:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iXhqLRmTJjLLt0+swJKUdYNqn5p8233/DZLr836ZfMI=;
 b=brIjJ5tktXyRNJ/xd4YYSVoN1aCZtGkWOsm4jNXUHIz6LFr19GdjjzoI4n9o20eSuIsG
 fW77N0PqQIxj1xr3cN//eSGJZm7emL19p697LIpcSzLPLrI9yvUMFcqNtqzEbZpsVlIY
 xQrJjsiHTyd3k7gpqpew6LaxNgifSoGSBcYjlqdRpUUoj0dMkqorAC4DiUszgjycmNfO
 mJZW8VygX5FwGMCiS3lXHeFO9R6o6FSP1jhrsJr+862gqRnASM99PIyF68SnrmzKkWDm
 7f27QqITRg8HbFOUpxD6XXMSUxk422BHUtcTTG5oJaIhshq1R+3ayPpe79U/HM7bXRt0 vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37u1hbcv4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:51:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIpcsn163121;
        Mon, 12 Apr 2021 18:51:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 37unwxr5e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:51:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH1OSd4pOmgR2G6/KN+X/PyRxQtUFT4MVX4kUEDr/699QUELVfVDhNN9YMLLoGPJAj8YzwIjyD6XOhKOp7OY5iaZ/igNhmK2jf4BTNTKZVP8Uy1+Fr+ozY/QbKDYuChUZYjjqBedPwP/FkDP4hDhkf0WfVvsO0N4PrCKjNrlGkcgEuUBz0k97q89wdfOMi+9iQPr2XVn1ZDuwxgnP+BlMDYAUL6kpapwJh/uoIVgdsMyYTXLmB9uflV1To0MkrP8HWtqSZN1OVMgbuzgzgXZkT1JfBacW2+bXNjdInRzjeZaU1yPdz2xT8/y7gsZDeovVy20APe2GoPPtifhka83HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXhqLRmTJjLLt0+swJKUdYNqn5p8233/DZLr836ZfMI=;
 b=X/7aW2yuPJ+cGT0ejUEu0xhRrAaTVHUHBr9Cnua22k27Z2G4fQZnai+SPNiSWCF9B7vMXOL/bU6c71zKlgvk8jyw+MOZpyaPJjGFyAgBRKP9NPR9jV2YSg5yZyTrMFMCd8/RR75PDHlWVDiHU0ikg2z/q2bgtfOt34qVZ3UmdPWL3Uw3U11QRJiUbvrnJ7+GJFrkaVDUs3nIZiDLyvnGYaRf8aO6aXXHlVwcnlPx9un3coQj5FuC0+tjsOiiHslaqCMpS6N360iZDkz7XQjKZZDAcn+akbQT6rd4ryVBiFhP9HvJDjC8fgweLejcZwOa1EJC+t6ANRf5B4Lg/pHaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXhqLRmTJjLLt0+swJKUdYNqn5p8233/DZLr836ZfMI=;
 b=Q19iZodTxDqv+w/GORv8/weF+naZ+nq36ff8RoYDGMLSoZGYy7DyiIIIKU6DnZqkWhf7azsHPTvwuLdBeQzyFQWH9SS2lhTQ0ftfKU4O2Bs7Uf7jMcDest3qJrKoFFch0Cg4sHpx7Hr/KicOkkT1qzA/6+6XOMLZSsjMVEDbuKQ=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3302.namprd10.prod.outlook.com (2603:10b6:a03:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 18:51:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:51:52 +0000
Subject: Re: [PATCH v2 5/5] mm/hugetlb: remove unused variable pseudo_vma in
 remove_inode_hugepages()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linfeilong@huawei.com
References: <20210410072348.20437-1-linmiaohe@huawei.com>
 <20210410072348.20437-6-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1c079255-180e-6002-45d3-a5742d4c3346@oracle.com>
Date:   Mon, 12 Apr 2021 11:51:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210410072348.20437-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 18:51:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7040235e-4dce-4e70-ada5-08d8fde408d0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3302:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3302E6761F660AD666F2EB42E2709@BYAPR10MB3302.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSpiKPrR7P+LuY11YoiI6y4eaAx1Qe4h0bphiFh8FrINpqQH0JuoseBEW8kvK+dxXHQOJN5UciNmsdqdfVHRzvZPm8WR826kezXUQg0zeZc574GB6jG0m05IjpQr04bjYrKfUEM3c+QeoA8y3rSQlFlC7ME+ieJ9KMbsPsUatEm8FogjtbHmnSUpbePgLrgFv3E4Fg6r8pRDFJLMb0n1t4e+a8opJ4rf8EGZPbfTL6+PpycpSbyWeqBV0ZQWfvK8/xvpTvngHKdXyLiBdku0dfckNY7XpO6SBKsOiomXm/OvT/5ZTkSDIVQD8NKmaVYHZ9qYgWUaV4+d+9xlYZMdYPUEgonHeOudVW449RCa+iunJYC9KaWpsCCIBZ5/Am8rCfLlrGKGvFHrjTQJhyr4QYTzavOvYw22Pu1lfAQBfPYKWfkfM8kQvqWqY1lAlCdL7zNyrXytAt21xhF+Q7A+r8GGKI5WVsCmFfMitx6ZeO62plLw1lhLQW46NdF/RDp3guB5ivoFf/sug10yHj9ier53nxqKy8t4JeZeS097oQunwEGMWPXHqyoxjTp/ZKivVKvMCbdrQgCu5ld3G01YH+wdMe0Js91TeznKFqundevUhurGyN5wHKdkSYbpRqRlhEUwUrvK5g6QVvGPFgjMpuQ/0uozZitT+6K2nCK8i4I4K8hyVn6jAvjAqv43G2OZwR1nekKZ3QR8yf1AEp4KgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(66556008)(66946007)(66476007)(186003)(16526019)(8676002)(26005)(38350700002)(38100700002)(31696002)(31686004)(478600001)(5660300002)(4744005)(4326008)(44832011)(316002)(6486002)(2906002)(16576012)(52116002)(53546011)(36756003)(8936002)(2616005)(86362001)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dUdIc2w2MjhGRXppWG9MN08wTWZpUUVRaVpGNzNmbjR2VSswRGFzL2NVamtl?=
 =?utf-8?B?UnAxZC9wZHpEMEEyTkdLMnMzcGRrbGo4S29RZVBObXdjVFNoUW5LMWt5UkVs?=
 =?utf-8?B?UTZiMWdxMEV0ZHFiemVpUHJPS2laZUdRb1BSVDYxN2crbFVqaXpBTloxZzZH?=
 =?utf-8?B?YUl6Wm10RHRvWVZoYUtLOWFhRXIrWlRIcGNCTi9iakZad0t5SWhXYUNoeHpD?=
 =?utf-8?B?TWJISFRFNEkzRWpsTG1BMkVldWtKSnYxK3p0YU1oaWx1U200clJUL21xcEgw?=
 =?utf-8?B?Q21aZERxT2g0Y29iUXNsa0lHK1o5djRYK09QZnJ4L3RjYS9JVjJSSjdOL2xF?=
 =?utf-8?B?eWJyK2NyVHRQQ054cHU4dlprT3FsS1FBcG12UmwrajV5R0p3dlBmOTF4YS80?=
 =?utf-8?B?a1ZVdGkxTjNhenVvMTFBM3dkL2svZlMwSDlYWWhVMW1aaWhOb1NZT3RGNmlQ?=
 =?utf-8?B?UzJKa21ZVWFQWE9ERjFmQkcxMXhwSUhIRkRIMnJYZHFDRmFtWlJVdkxSejVM?=
 =?utf-8?B?UG9KdzN6Tjk4cStzUXVRalF3cFVraFJ5Z3hUenovem9SN0NjMGV3akJEelU4?=
 =?utf-8?B?L1BxSDZGbXFUaTRxRTgyUWpJOWdReUhYU2RuZnNVVXh6RkdBeEJLR0lSWDJm?=
 =?utf-8?B?YjBKUkhWSUFKQUZaLytqV2gvYUtleC9rYW5zZlE4UnZ4KzJkWG00U1FuL2Nq?=
 =?utf-8?B?RHlZQWFDUzlybU0vaUNBRjAwK2cybmNWbGxMU2pVWm5nUFJTNDQ2dHprRm8x?=
 =?utf-8?B?eWNjRmtSS3ZlVE5BaXhPcVZhVFZIWCtKdzloMWlZRnhtRmw5SFNEVnRjOW1n?=
 =?utf-8?B?ZXdIcm5tOVBkTzJXNFBYR0JGVmFOYjZQSVI5bkxJSnZkTGtXcWJVLzY0ZnVW?=
 =?utf-8?B?Rmd5RFVyU3dMTnVtOWNoTU5TY0RzZllXUEZ2YnBGMHEwb1Q0Tmo5dEVicEw4?=
 =?utf-8?B?UUZ4Ykp3QWx1U1owRjBsTzRlaUhsdmF6M3BoTm4rYXQxTE5wUmY5UjVOUDdV?=
 =?utf-8?B?azRnWjZWajM3YXdLbXRwOTF0VG5RY245UTJDaUFrWjQwVFRiYWJMSGpaUllI?=
 =?utf-8?B?eWJYM3F2RGlUUXZ3SjI1Ykt0V2RjeDNCV0VxVEpBVm03Mk9IVGNFb0FIWFRv?=
 =?utf-8?B?dkNZNkdtRnROVHBTTVpLSDBkZ3lBL3czVXBqaDdSdjZxME5uNzlkemZsemZM?=
 =?utf-8?B?UmJVMVcvNmJUWEo5WVcwMTFjK0NsYW9HeFBSb0ovVnFINXZqYmxyY1Y1Rm55?=
 =?utf-8?B?akF4ZW1NSys0czhFcUY3cy9SVXpLK1dGd0F2VHJiTmdHWXhFQk96NGpmYUtW?=
 =?utf-8?B?SDFMRlQrdWNuU2xkQkpmMXJpcGUvNjV4WWxSUFZOOUF6NmdzemlZQWhIN204?=
 =?utf-8?B?YUFhdE9SQ2xkMis2RWNoSWZJWlAxdFp0STNUZ3B3ZXFabjdMZFFPam9EQjJN?=
 =?utf-8?B?M1JFZUY2VVZlSXJLV3dlME9PT3ZTaUVKTkR4dXJUQ09FYm5kWlREd2l4N2Jo?=
 =?utf-8?B?ekZiOGVVK0xxb3FmMmdzSkVRUGRiakRoVFZxNCt0TVp6MDczMktNSk5RMnhH?=
 =?utf-8?B?d0MySzBldEJ0VHRvVEZhWlJFV3laMnZIVmVFZVhNNjM3blNKam5DQXE3UTBh?=
 =?utf-8?B?cDh4VmdjUTF5WHoyMVNtekRLVSt5THpKQW51S09Vc25hb0FBNFRUaGh2S0Vl?=
 =?utf-8?B?cStMQ1RVcEJiNFliU2pvMUtOeG05MEJTM1hvY20xNnJRSk9ZaUJJWGhBZ1N4?=
 =?utf-8?Q?GctcdVu/9nclxZUx2BwdW1vI79gSXWg3HBtqTiJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7040235e-4dce-4e70-ada5-08d8fde408d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:51:52.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMfqn9A0v2jCTDuFrGWOn7JxOrGXYwg3pXqenpC7Dtluxmc+iPEf4r7/hqijH51K6pDJ81Q7K1W1CI1kd9S/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3302
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120119
X-Proofpoint-GUID: NAGCNVi4ksWZo3BIJUjSujC0mNnxeAy3
X-Proofpoint-ORIG-GUID: NAGCNVi4ksWZo3BIJUjSujC0mNnxeAy3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 12:23 AM, Miaohe Lin wrote:
> The local variable pseudo_vma is not used anymore.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,

That should have been removed with 1b426bac66e6 ("hugetlb: use same fault
hash key for shared and private mappings").

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
