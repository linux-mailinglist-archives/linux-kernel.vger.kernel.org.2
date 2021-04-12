Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541C335D052
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbhDLS11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:27:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhDLS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:27:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIFiuQ002032;
        Mon, 12 Apr 2021 18:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cchgPw19TAD17YPRXFQ9RKeDvNNGNmb2S+v3eewihoE=;
 b=jhra3S72TCuibDsawYVt+jTqajjLupIK5m1HMxmlC9oRmbfjBTUQdlkXu1kuUOFnpCoM
 uXw5Z0fQ5Fr1fWuUlazQELCCT38zPTCVk3O/kUgWUjlgPeQHqFsY1PTlccFha2D42k/y
 R5FEeiOjVNuaMyqZSDSqvVI63NMCVT1HGzu5Eye+m6AWRUOn8Get1rBc14OBVz7pToHR
 RKbUSnRPk+ZGqsPzXtpJU53581aW+/k8dCEwl77Kj7+1XRbRNpI3n14hW3tdYD6OcQwW
 OpsfIZhZf4K8VI7IOdTP90flJ3H12JVoRG2YDVK8hBRHde0nN2DUFGl0lRuiSHEIAch9 hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37u4nncnra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:26:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIFdSr003519;
        Mon, 12 Apr 2021 18:26:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 37unwxq9mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXy35K+rmAAI/K7+lW3KW1ratfFWp9+ucHkEoq2DdNoHQkZyYIPX9Uc/F4Hd3hyCk2Mx1enSh03H6epq20+M3wdfkBLZbNL8uDrOjZYIeC7jYOLjMQKW8bxEkEvsg95eS8KU8Yuhaw8+2rw/FjGYui+vRUg/jUKeTqF4lLBZ65epzMMT9MBCyElp324vIqObuwltv9+al8qef845wGT6pQKY0deif74FfPMaiLxg5B4Qjf+zr3OPACCfr1x2HmxlhkbNfXoEdwlLJVWMYyEeOoMC9SECfdVD4EXQxMqHoJ/gsDi3hDHPnJHbiHl99EAjw2TsECpCvB7PsoAxlkrshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cchgPw19TAD17YPRXFQ9RKeDvNNGNmb2S+v3eewihoE=;
 b=C8ZGWIK+xXCJFQwGTIXYQ0GHgbvweQFM49FIJ2/XaBPCcqFfQpayWuBj4ZQLoXO9KgHGoiS+4/pC2es6+Ntegqb9SFYh269/T2VfI9PmR2/uhrhT0X1Su8rqt5IWfYoPKOjGlyNLQZsLm0OarpZILRu6Yx/A8JoqiO6Jv2arTvOpu+pCZctsALphQLf3VDLmSUSA+iDLIlDoUpj5S6OTjrB8Kw8jf4h7NRFKevNOI9t7T0ZcE8t2izZKkGkdCnQIDQ0KqAYGCS0pDtxONyyUxwmGxEkboJPg88dPCUZXmPdLOA0u4HJXtDGIs3RYv6PD3QL9Nal/0emBRbRIOTMwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cchgPw19TAD17YPRXFQ9RKeDvNNGNmb2S+v3eewihoE=;
 b=O9tOpv4AcKCdrjZKXDUiFbQQsSF+g1Y8lm8pK0w6pc2BGx4zcbNCByfNI5Mu2oU9oGN23E5QI0F9MAc95sECGL+HdF5cgwQaJ3OeIqDn88fW2JaE5eUkxUVMYlNnM0OuSh0jENfBAxunqmEW3bvsEsVy7Wq3szeFYCeM8a3JCA8=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 18:26:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:26:54 +0000
Subject: Re: [PATCH v2 2/5] mm/hugeltb: simplify the return code of
 __vma_reservation_common()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linfeilong@huawei.com
References: <20210410072348.20437-1-linmiaohe@huawei.com>
 <20210410072348.20437-3-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6412045f-f115-0872-7645-6057f0369c57@oracle.com>
Date:   Mon, 12 Apr 2021 11:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210410072348.20437-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:300:4b::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 18:26:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1444e7f6-aa92-4e31-27ff-08d8fde08c23
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4462E37F00EB4ACC00986C5AE2709@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1ekseJBSKSXqZ/rQljmHRLR+OUIGlGatnFJQ1KLAV/KhCbnIpC7rR6KV0WsfspcKTL6tpVlgTCBO7fyKFbhOsr8agfYqlhY8qX4KNfsC+D2Msobsu/WzThM+fCBmJn4xN7TFXL085o+e527vzaI1FikCrB0oYqXkfNNRsp3dceykreY5ca0HuXcKrn5FfYlzGmxJs2g4H7av7lIMgTOCON49qwwoA84fKwXVuY6Pd2ACxrrAtSmoLyMWWVjPr8H4mMuZ9NR2v4SwsT8tVkVSXej1YDh26n7Ark3uFx3ODAR5nf2MqVsBFlhULvR8n4+MVnAjU9dvqFtAXH0eK4hHyE7PlTuNe8djLp1hxIK8AAkW9M+ZNUIU5XbkZHuCkLyGeWPhDMu8LITo3GxixP5JJXyj96R214a+sEZS6mTcF44uDi6J+509oX8tZetoFnDFLYmpWqugfkGWSO8ARNnNrXIyp2QTZIV4TyxaJzuouVPBoJ9/Y6Da+FEOdO9GBam/DLQm9+tD3m16QvXyKNtowmpCJISzQ3Q0IUfZoW/dDmPsxNRi5OgIu59GEEYp8aFjKMklYspq8qxcgSDhNUwbee4qvKKHftVdZdfM0AIHK4UvQhHBDBzCLnMrDj6bNAbXYFafTPqHrLzDqpO8jJ63R1X37icdUkC2XxJIioHdpBqp7rOnyDu9dD+5ur9xhYP+KIajNasfVP9z6KzMCPZ/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(396003)(136003)(8936002)(52116002)(16576012)(53546011)(316002)(36756003)(16526019)(478600001)(31696002)(38100700002)(26005)(186003)(5660300002)(4744005)(66556008)(44832011)(4326008)(956004)(2616005)(66476007)(66946007)(2906002)(38350700002)(31686004)(8676002)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a2IvbmE3cGtqdEoxVGsrYW90QUF5d2xHdzFyR0xkS21IRFUyU0o4QVV6NytF?=
 =?utf-8?B?eTV2eWx3amdvaXoyMENodU8wUlVqWnFhanNwQ09xY0hiNitQK08yT1NDSzJm?=
 =?utf-8?B?anVLN2VCSW1HRGxKazdyemNGTmxPZGhkdDU2TkZyL0RGYnpQcHljdEhSSFFE?=
 =?utf-8?B?ZHVFZHVNbnV2L2ptZ1JvZlFPdGlvWmFGRjM2U1JOOXI1WGx4Zk1ZeEhNL0tQ?=
 =?utf-8?B?YVByaWZWMW1taS9vNGFHRnpib3o2MEh0aENhdFF4Ykw0TzBjWnNGOExoemha?=
 =?utf-8?B?MVFsd0xXYmtDR3hPdm1JSWQzTFJlb0o4V2FIZVk3STRzQ3cwR001U3ZidkZi?=
 =?utf-8?B?ZEkrK2d4eHVrQTZtTTlwSHFvZ2xTbmlPdUNkMCtZOGNBaW42c2xBc2RjTlhK?=
 =?utf-8?B?MmkxblA1WEEvTEhGZWI1ZWZ0RDk4TmVQNThmMkdNQlFJbUQ5QzhnTy9JRFhE?=
 =?utf-8?B?ZDVtZWo0eHArZllyNGZoZkdBQ3FkeVF1aW5wdk5LQ2J3WjNmZ0t2a1RHTmtv?=
 =?utf-8?B?RlBtRFlCREwrTmIrOHpkN1JrZTFsOHhYaDRQc2E3bnZhaEJ3NUhEVlJLZ1d4?=
 =?utf-8?B?VUpYQUU3NnJubThwT0l0cVhwZzNyUktEcHk5MDlodFNiWmFnQ0l3YjQwbHU0?=
 =?utf-8?B?eDhaL0N3UlE3Y3djdGZ2dmVrenQxSTJIYW5LakF1ZDRSSmRLb0xRZU1mMlRw?=
 =?utf-8?B?VXVvZHVsSHdPN2JJeDZjL08zTHlRdGlJQVFLOHBhMkl1cXJvOW9BbVcyTW5I?=
 =?utf-8?B?S1Jpd0ttakpKVkVwREZEOFBJM2pFZnFPa2hkMFlSZkptemNCVkN6MENTZTFD?=
 =?utf-8?B?WkQ0OWM3eXFORnZPVVdhMGhqRGoxa2tBdEV2cThUK1dvREVQSXhId3NTaHlD?=
 =?utf-8?B?R1YwZ0NXMGRaT2R4RDdJVk53Q0JPR0hxdFdnc2tjc2JpcWNnMHlWa2hmSFpm?=
 =?utf-8?B?bnlkcXlIYStIQW9GcjBPUUhiaklxeTFjWmxmT1JnQ25oN2U0b1c3S1dUTVJu?=
 =?utf-8?B?ckZ5aE13Y3RaZU9hV1ptTzNTQzJrSytpQnN6bGJJWE5KVUF5N293dUFQWENK?=
 =?utf-8?B?SHBQb0NNK1grcUJXRVo2aUNhZDNzcmtHdGhTaHdMaW1tcXgxT3lZNVVlK0F3?=
 =?utf-8?B?ZGx5L2lDeXRrTVZIVG1CWTlCUDVleWFWNUIwcktxNE50OU1QcERmUDR6WDlE?=
 =?utf-8?B?Y1o5ZTlPRFJTZEhMMnhQN1d4Vk1Yc0taeDVkbFl1R3R1NDRXSW4xL2dZSkt6?=
 =?utf-8?B?Y3d3Qkc4U3RVenNnUGlXZUtiM1B5SHVScTF2T2lXMjU4RzRzWnBFUmZjcHg2?=
 =?utf-8?B?OVl4M1RwU2d0SkpmNHdsRjN2ZVBXRmpmWjJXOXQ5QksxcTJvV3JTY2tpZTcy?=
 =?utf-8?B?S3RxTTZoZEl1VDVoWXpqelA3cHJZNm5pdnhaT1gvMGVkZVVqYXdnY09mRWpG?=
 =?utf-8?B?bFJJRWJnTndiYmlCc21lZklTQkRZOGM2bVBrcU1YVkZvVzFyc2dvSVVPeXRj?=
 =?utf-8?B?WEVjSlg0NkEzTkRnREhTYTdmeXpBbThZcDNEVXFBVWxkUHhDNU1IbDFNTkVQ?=
 =?utf-8?B?c2g2djh3TGdwbHA3ZHFyak96dzdzU3pQOUMySEZCSUE2VFlnWDRHRzVUc1da?=
 =?utf-8?B?QUJZaFNRcy9Va2JjTmJORDJJYUppdXBmOXhwUVNucWxnT2JQallkT290UlAz?=
 =?utf-8?B?ZDc5Mkp4akZ2RU5tM1JBS2RQcWxKL1NWRFByK1hON1lMUkpGZXNObVhnUHI3?=
 =?utf-8?Q?/QdzoFw7vtOiOEWmH8kkDOT78hvSR3WqXRGjyFn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1444e7f6-aa92-4e31-27ff-08d8fde08c23
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:26:53.9885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIChW2M8j/WXRIIrgLTh+fVbRq6Pt3+PSOkLgOSy7vp2jJB3YLPY0Zk9ukYvmI/C0Rl9iHE05k7AMZj3KP/ejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120117
X-Proofpoint-ORIG-GUID: nEEfWJtJTMecGimBS2ivpSSheraw7G0-
X-Proofpoint-GUID: nEEfWJtJTMecGimBS2ivpSSheraw7G0-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 12:23 AM, Miaohe Lin wrote:
> It's guaranteed that the vma is associated with a resv_map, i.e. either
> VM_MAYSHARE or HPAGE_RESV_OWNER, when the code reaches here or we would
> have returned via !resv check above. So it's unneeded to check whether
> HPAGE_RESV_OWNER is set here. Simplify the return code to make it more
> clear.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
