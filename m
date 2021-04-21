Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8323674F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbhDUWFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:05:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5216 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343518AbhDUWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:04:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LM2iZg027886;
        Wed, 21 Apr 2021 22:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nbaPIrxSXXS/V38vA0XpIfsxEjdwePh5U/Bj8pRpG18=;
 b=ZIV+HJQ8sQKQAWCks3W1BUPW++20I5l2kLrV9MJSJ6vNh7nhB6KJ40TOKGqehkoSlyel
 o3Yw4nnOWn1iSavo3M7h/Vp/RY85Cu6knmLzE8yDZXaJnCEtlOMVH5p3RkyaSbDAL928
 FR7wv34hotKW7KH8T/PWzVKJscgBIRN8SI2G02g647SyAdbBD1FDO6rTStMqcvTk0FnN
 fjiLRtsu1bzpoHNzSo3v0/kev798zTg10Bi8T9Ipjz7Em+O1AHSVkBf1UY2jCGEetQk+
 MYTZcymAwqjfq7dPucG468Te3hYBab3N2g4Zyqn+7xNeSEGG8pxEBr9pT1Xj9Hrk+Y9p QQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 381dum8v2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 22:02:43 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LM2g8J008376;
        Wed, 21 Apr 2021 22:02:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3809k2hdh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 22:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX1SsppU2ckdi9ys94FJSmPjtPaNQppFXS4c5+WgABPkf9ElIVA0Cu394Z7eZkqykV36A7EOx0DxB2ZhTO6JO3xTo5Cgkpe+92ZCp3PyIm4cMYbl8/cddhkRV9W9mvptzwylsEmVAZI+0RjPJGsmiSS42ZDYgTakCWjEQCTTNNyrYSt4XWpQHo1oZLlgF0kAbt/2Kklai9ClWfGQI1/khGFdCf8sHUmrR4xcOid6lKX6HMlj7VOYKmd3p3X34CXWTNFj7DKk6/vHsy7MqUFGO8XjMyAgg6M4xDNw8OxnZmZpPHPph0TVpLFw8aoVa0buuN5Q85BImMDwCrR3F9g6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbaPIrxSXXS/V38vA0XpIfsxEjdwePh5U/Bj8pRpG18=;
 b=hHlcjKw2Pch0C1M37hjd3Ixl9+4KDfwIDY7cIAKd995Ceh0oU2drg9RG9Kk4qESrpOAhMW6uJzi9s/czEcIgz8WOEsw461uDOZMTiCMCEHim4wdHKiFmqVHG07MdOYvxStpPODHeL5u06E31y8zKVVeIEKGWfKQEM6mec1ZrncNQog1f8czbD/7YBkb552iIDwlEyPYUcaA+QAdDnJJUO7w8JL6VJgUac5Rd9RJlrOINbVxsSgVLfTIIg7y9QJ+Xes5QjRc+wUrBKrqzaJdJoc3AZXVot05xHfu0/HaymNnO5DaDBDiEcAlVkg7ncvsvoKWn6jrL3DMlr0yd6qe7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbaPIrxSXXS/V38vA0XpIfsxEjdwePh5U/Bj8pRpG18=;
 b=lPkk5c1tY7tgTEVK7MzuSiPLBUFeph9Ordxn81FUgyptmsDMwHXAZvGPRhnHEKYiQAkK6KJxIJe+SxeqD8MrlFagELpNCll4OiVZZLgqMMoxJ6qQdDUWVEBkpyemPs+Qt9SLRJmB3l6uCDSS5ekOfXgrvLhcJdaLyHjh2DygVP8=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 22:02:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 22:02:39 +0000
Subject: Re: [PATCH 15/23] hugetlb/userfaultfd: Hook page faults for uffd
 write protection
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-16-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <902cbea7-0945-eeeb-a73b-52be652c5d1d@oracle.com>
Date:   Wed, 21 Apr 2021 15:02:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210323004912.35132-16-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0090.namprd17.prod.outlook.com
 (2603:10b6:300:c2::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0090.namprd17.prod.outlook.com (2603:10b6:300:c2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 22:02:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e7c238e-7590-49f1-0b60-08d905112db3
X-MS-TrafficTypeDiagnostic: BY5PR10MB4305:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4305C6620E28AE1A75B1BFE7E2479@BY5PR10MB4305.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKQp87JowGoagCPOrtYHkqKI6w8mC+HQ8mdtz9k2rkVYIyy0X5WFzmxU6UTKIM21djom3i/mdhhdZee0FCx1tHM29V7CaTaQFtWixrF/0VfRZnmNN3fHAaB4dZApB/OlsToViqTMQ9oRkw5tyIpdAgzpcOM+rgRH0Uyyo2ERSa6FKfYDAfkloJYTr60ZpvZ+kapmR/OngobMhcdSwwFgS7Q1OzSI/e7i3V2LX2AGzYWyG7arJmRp5f3eijBpReQzcBbLwwwQIDsDzbfAnOUP9y6uAKC9gV5uhGt4zlj2IIEQPXH53+CClDnAON12udPJKi7eeGrqL0pf72vxnCaepikbKHZlFMOTQatyrP+3+mP5XGykWjZqoFSvVxSd83+6c+kGulgB+tJXVOexyb/KF/t46JLKYn0RPJNycstwSANqKJUKnN4rU4aDd64p/nO90o7F98G0opLZJtaHw12O8/M14LLrT2R73LxlhRKiUB475htz+Uvt2hjthHVgx1ctdCcyEbn/g2Zoa1zWXLEKmTrnyzbezIbD0gn4C56oTwKEaZWleFh2XhqmaJhY6MhoHbSUq1Q+MAPGjfFcJejKe2t288XyEMn22UEBm2eV+JDBISPiqzwhfarqCfgAwbmel19kKBw0gumd1aN5mc3f5eD9AXaOQjqsXzdNGUc7fLhalqhVnkgcM/y8/p4DG1/JIbw3iX88m9C4E7F1JhUnTN+hhJ5qGDrb5RcMcJl1ON8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(7416002)(8676002)(16526019)(53546011)(16576012)(6486002)(54906003)(83380400001)(5660300002)(38350700002)(478600001)(44832011)(86362001)(52116002)(8936002)(31696002)(36756003)(26005)(38100700002)(186003)(316002)(31686004)(66946007)(66476007)(956004)(4326008)(2906002)(66556008)(2616005)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cFQ0QjhyUW9uNjNCNWVpdVZHUFVvVXVIdkJmUzE4SmZNU0RpMjFzT2JiMDdJ?=
 =?utf-8?B?aFQ2ZHhsakRvZ3pqVU5QWWdFY0VubFYvZHZJa2d5d0RzdWR0UlhieGVlQ0ht?=
 =?utf-8?B?aFFkOTZNVUZLQjEyUEdRNFFYSGRIOWxNaTNPZGh3aHNJRWxQc2Vta2kySndL?=
 =?utf-8?B?L1k1YTJkb1o4ZytkRXMxM0VNVTJoVTQ3SUhhcUxUMkltUkNFZ3YrQ2Z5eGph?=
 =?utf-8?B?UzNxZG5sd2xSS2NSRmoxZXdEc1ppZWJHczZiSkZnd2JUVURhdlFBZjFra3hp?=
 =?utf-8?B?MGNyeUk1czFXNnJXV2ZidlhXUm4va1Q3VVZ5U1dDTlhZWC9UOGlESThhb1hO?=
 =?utf-8?B?aVhRRE9GV1pic1Z5RG5hNU51SEZKNnpjajliU1BmVjNyaWI0TDJzenQ0R1c2?=
 =?utf-8?B?bHFYTG5lSVBtQmRva3BBUFZtODZjaGFPVVVNYjVJdllHYnVJaHhrbmV1OHFN?=
 =?utf-8?B?NFA2VmZsbzVSbWcwVVBpVUZQeEFCK1ZhcVlUNEQ2amZrYUk1V3hpY2Q4M0hK?=
 =?utf-8?B?VXNmUUtBTXZVblA4UG9KRHFLbHMwSnBsK3ZoSEN4SUJBYitRQjI4eGdFbnFs?=
 =?utf-8?B?NFlhYzRZRDhvbnNPcitIa2NvcGZrRUtnejNWVUZNbitLS1U3d1g2eTBvNXZT?=
 =?utf-8?B?YmFZbXl3WE1rblpXSFVla2hubTZZejRpeVNXb1dzYnA4NFRYQVFFZ254Sm05?=
 =?utf-8?B?clcydXJGc21iUVNzZGV5VG1WbjFWcTFLNllCMytXRHJDR202SWowb1NUK0ZY?=
 =?utf-8?B?ZVVYdGNSQTVwRHd5cTA5ZzFmVURkRVFRTnFRQXp3Y2dNSk9TM0Q4bGRQdGJX?=
 =?utf-8?B?Vkx5dXlhZjBDM1dYM08xbldWOVdKanJVeXJLam9lNlRvWWRNa0k2STF4SC9j?=
 =?utf-8?B?WHRJemtGVkFzSVhZRitvVVdOOGlsR0pYMzJDelp3NFdqd3B2K2lmZCtwTHFO?=
 =?utf-8?B?a0Z2ZndnWXZKUFJ2RnZOR3lXbURuTlY2M2hUenNsaHg4MjM2MCtWZTdHd1hV?=
 =?utf-8?B?dkh5WTAwYVVRZnM0eU1RdENuTDFIaENkWmpieFp6MVd4by9wL01GY2ZrZmU0?=
 =?utf-8?B?Q0VwOEhOeCtxS3BLYS85VENROVdpT3ZGMVA4WHFiNVd6NHcvc0gxQU9YRHZq?=
 =?utf-8?B?Tks2TjF3MHR4M3BLQytRalVOVzgzbER6M0VmNlc3OE0xYlBQRmoyMy9HQlpX?=
 =?utf-8?B?M2FZNUlYb2Jjd2xvZXQvWlByUWxONTZjb1J5OTlFbEpsRVF4MkduRVNGeHhH?=
 =?utf-8?B?d1pObUdNWEN4VVNpajBBdnNhRlp0TGRTSFJnQm1mQTdsT2hYM3VzR2tqWFda?=
 =?utf-8?B?SnhjcEMyZVBhOEQ2WXlFMUgzL1BHUTZpVjRhb3dhNnlWc2RMUndETzZlQnF2?=
 =?utf-8?B?YmF1TmNpMDRSeDVwVEZpRzBLQ1d6eE9UWmlnSTd6eVk1ZklZYkJ6eEp5NHRW?=
 =?utf-8?B?eG8weXJ1N2xXQnB0eUFHd3dtb2hYR0NTdVhtREViWjhOZGxyRkhTSlBHOHlu?=
 =?utf-8?B?TkpFcFhuMzdCY0JxaS8yV05UR2lzdThPMGQyZFdFL3RiU0VlNnhabWNRVVBB?=
 =?utf-8?B?VWsrVDBxVVlQS01paytLRHN2M2IrWjlRVWNPRzRDdmtoMCs2OUhJSG4rQmZW?=
 =?utf-8?B?aXRhSDdIWG5GZ0xGdEhYYzN1Yjc2UlR5a0UwbmloSjBVdGhhejRabXVyQkF2?=
 =?utf-8?B?UkhLdytnQUkwVitueGdTTEo2V2NMZnRPTlMxSVIzNUhPQ0hKZjNZSkdpS2wx?=
 =?utf-8?Q?aMLLttquM4lhHs7QwbwINTMg52UGvmmFbJzNrZo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7c238e-7590-49f1-0b60-08d905112db3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 22:02:39.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMct0PW6THbM2U6n6PDlogxh2DPK78TyWrsn4v39QHYyklFMy7jWwxOsi1vHsZM/ww8LTaKpAkyiJl1rTjqL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210144
X-Proofpoint-ORIG-GUID: Ji0MRIeh3TRRMZlGlw2WvGF_TMOYhPXQ
X-Proofpoint-GUID: Ji0MRIeh3TRRMZlGlw2WvGF_TMOYhPXQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:49 PM, Peter Xu wrote:
> Hook up hugetlbfs_fault() with the capability to handle userfaultfd-wp faults.
> 
> We do this slightly earlier than hugetlb_cow() so that we can avoid taking some
> extra locks that we definitely don't need.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

That is pretty straight forward,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
