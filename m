Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483940CF36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhIOWHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:07:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16664 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhIOWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:07:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FLYdj7010063;
        Wed, 15 Sep 2021 22:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vZ9F8+zjguH+Cyj7VnCsPX0zd74FbRatXhCuJm2zZVA=;
 b=lPDfr24JHxGOJk2w59VVf8s/OI5Vgk7G1fg4NMGc1e8PZSQ53k5BkJep9wq2tDxVSnvr
 9MzoW4+CeYxFZAlPsDb2LWWOuZ+27pYdIKyU74zn4LOVFTtIIatEljuAEqoYuzp9detb
 tJLX85k6XEA+lJibjCLx1QeGe30H15KEgTOqv/Xstgu62iLCt+8LwSzE6s+9EGOx46QW
 qgW1wKj+8KQwKOsIW5pfNcSQSFJ0lc3lNsj6Om7tcYmaXox3BzfhvFL81t1InjAoJ4ak
 3Fw79rhVf+hrFnNHvCBGM/WTOPY9nih74y8gZH4hSarU68ImHqH4BGf4tpHSFvXZrrg0 Vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vZ9F8+zjguH+Cyj7VnCsPX0zd74FbRatXhCuJm2zZVA=;
 b=IuZJI7jP9UjeYF59/uxEpLivLDLAj/Eonu0CpW28QL1mlTyd7EwFNxl0g9izJWJwOQ5G
 QlfxyeUx7+R8vE0/786xu2jTzP0ASs2UUcM9JdPnCpl/sKJRsfjmxYpqvQERCabciTUJ
 3G8FnPbEPrCAHP9wdIIvOm19wDxx/i9GUL29tvfCXq3kIhKVVmRhWD/J35WqMSKIWRc7
 /jiodMZ19Wr3SeOGhL9jWjsP57VjXIExZ040ZA0PQcgtB41sViz05nwqE60MK0vdbSJH
 g8BBI6RfG2StGCcXgjwXzmW7RdwkSoaPhnU1onoEIM2dQH/KQw+2fXsDBKKlb5iWefY3 OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jyshchv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 22:05:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FM5DY5029239;
        Wed, 15 Sep 2021 22:05:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3b0hjxaexu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 22:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWVWSMix3n9rCFe6HA0rN6G1ZWrO2lwNmpW1XbePm6uNpjg7XmZu+z2Z4GQVCZ1uXv/8gUZO4svJ6PSjXRUkOFvh8SDIyvAIknh89t4WV8j12lLAxJYGJgkiaylxPinXAedtK3RgWMMiEij8v79Nm7kFy5oc1PFqd2B4JDERGw5gx1GtqBZedTGHyJYRT0hmW1sVmNyccuJ7nZvIMxNpamA2bHkgDSaAsGmieEvLQsNuOnPheveEpEl294NmKxGrm/VWzpuiQ6V9JUjVjNfRVCSuIpYMU23cBJh0yEwK7bkcIao6QgKPE+VHYj9MmktnqLh6xYsHxDEuVwpGrCFXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vZ9F8+zjguH+Cyj7VnCsPX0zd74FbRatXhCuJm2zZVA=;
 b=Tg5bYKJbMy8zLhfFe5ajvE1Qb4p9OneZCoYJdjSmEInYpbH1GierHdPX3T84znKAb1XJ9KTGCgwNd4WU6aWED29B/2dUln03KvG3l06SR9Ra6ypfgxyhqW1gUdtg+CHbLMliVnoHGgaCUdq4iA+smnae5oU7vZXYdtiLqT3Vq0aKHo/flOiUeQB49pVQlVeSWEFBV/RegY59rP8XYNvoD4lUREGpdZw+n0DHYO7h/P8AYb9WX5WtCXkRQVaF0I9cAS7uEyrcvfmWjbBGDSlHYrlaiXYQ+esgUb0ksFZIiKxLPKrjuFwmHfHbPmFiJl2MhbV2Gq4yL4c5gZWJg6KQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ9F8+zjguH+Cyj7VnCsPX0zd74FbRatXhCuJm2zZVA=;
 b=VlHIQhLemmW1DTwQcw0bj1qdUJOW5q/tOiX0fKlRpM6etQG2rIWPPRd2sEnW/CFPQzLwBixGLbvUDfQBCXCG5Kljb5XfKD+wWulHc+psYs86yXLuT6FnSOaHYjer6Qj8gqZoAEsqE3kO3I2SRmYHDV4112Twem9V6IMFeyt7zWg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3095.namprd10.prod.outlook.com (2603:10b6:a03:157::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Wed, 15 Sep
 2021 22:05:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 22:05:44 +0000
Subject: Re: [PATCH v4] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     zhenguo yao <yaozhenguo1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20210909141655.87821-1-yaozhenguo1@gmail.com>
 <20210914205001.7ccc7ef3dd76a9ec551b370e@linux-foundation.org>
 <CA+WzARmsPT46ck17-96cJVWE-=QEK8QobRFnCnEcNxsd42zNTw@mail.gmail.com>
 <c55f0be5-f68d-1a33-a9e4-5890a2887a15@oracle.com>
Message-ID: <98a8ea20-5642-d332-d7b4-18e075a594fb@oracle.com>
Date:   Wed, 15 Sep 2021 15:05:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <c55f0be5-f68d-1a33-a9e4-5890a2887a15@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 22:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6e2f45-9c75-4ea8-b1c1-08d97894f6eb
X-MS-TrafficTypeDiagnostic: BYAPR10MB3095:
X-Microsoft-Antispam-PRVS: <BYAPR10MB30955266A876C8FAEFEE5A28E2DB9@BYAPR10MB3095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa2shapiUmTQfht7vlkCjsE4bMzF4VuyQALQ6fgqtEEIbRldTDneyKMXPaxALzP01nH9skxA0ipB0WB+2XVwOJq84MxQNyHaZvv+6ScUQRPaF7n/2Z2ChTFs1+g0AOV6e/HKYtSFQJVmAgHqceTJjOKZ8BFGPW20qtBPHrw/sYlHKBGgnAYfikGk7+gJbI2OkksnPKklqQDR4OukFFFp+9i0781zJe9IZcu6ZBeaTSCqcutxi3Ls7K+qF3oMeOcWEhqt5X8xri9o3cvlK6qIyoDWw4i7Ubhhj8zVCLnsVwpwM3QYyHTpqPGCFichhwcshs2fACawgaKlhBhcC/OM7OpYYkaSKQhrFsgp7TqJfyONroJPZgH6C6JJuS+IXQi0hPWFD4kXOHByHDndy2AZZwET/oBANI7uahE0BcrWXMOf9WkIk+iiF6XN/WIKRlbETWhEbBPJJPF9mKqGsrBHgUdQysY/NzTdxQS350t5ZYjsslvwW4Utd4ZMsEFWQcgpEyLpDH6UTZ7mafW0PUo1dj8xJG6pOPKL7vbIVCzwEmbVtUW5lUZqV2g9FvJpVRF1HtHixn5dNnUzTy2lwRVG8mfODIy3tJv8t7SrAqumQsFcdpMjWTZN1Ni/tiUXbioghHa1e/pFUXo9fHJQtwv4ROyIKgiAGo/uCoSHMHcHMe8/G1LhvdCvgA7d52uE5a2D0WoJX3NxT5qxh6wwDnj8hTLzPy4Y+UzjRxXD2gND+WcFm5k/Ll1k+MMhDs5+j9LxwQvJtxvrconcHeeV46W23Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(66946007)(66556008)(66476007)(44832011)(316002)(478600001)(16576012)(5660300002)(83380400001)(36756003)(2616005)(956004)(6486002)(4326008)(86362001)(53546011)(26005)(31686004)(2906002)(38100700002)(52116002)(186003)(8936002)(31696002)(54906003)(38350700002)(8676002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RSb1dwa3JxeFlQNlpVWXRuR0c5RDZCM0xPMGVHT1NkMGNoSTdnREJlcTgw?=
 =?utf-8?B?eFhXS2ZnYzRObU4wOWxtd2xuT1JvbHQ5dEZJdklHdDhtTlNFVUltUGhpb1pl?=
 =?utf-8?B?T0lSamh3WnZaTVU4SE9XdWtlRWtrQ2pjMFRCVlRsaUxkbCtzUlplR3RCRVVN?=
 =?utf-8?B?cmdLTXA0Ty9kdDlub3NFZ25WZ2xKa0Y1TlJWUDh4UndMVVEzeEV1NGdUMnhh?=
 =?utf-8?B?U2dSWHduTzF0Q3BlKzlQNWZLeGw1cWxXSTRDVDRtQlZRWUoxL1Ewb293YmRs?=
 =?utf-8?B?djR3SW1VRmFRcnpNTDU5YVpDc2lTaU1URTU0UkZXVGxZQTAwZk02OEU1eE03?=
 =?utf-8?B?VDU3bzlZVDQrYzNhMkw3MktIYVZhUDB1Z0oyaEt6OUZHYmRhWkJzSkZ0UTdE?=
 =?utf-8?B?SCtjSFZOOENMT3dwaUFZdG5jWERzbFRGM0ZqMlFyVkc3TkI0WFQyZUlVNmwr?=
 =?utf-8?B?THl5aGNvNXl0S2F1YTZBaW1zUndoSUVHMzdkdmtkdENIeTR2WUl6Z2U1KzlQ?=
 =?utf-8?B?MlQvMjdpZGN5M05oczY4akpJdDVpQU5lY1F0ckF6SU4vYjE1K0ZvNFZtRkNw?=
 =?utf-8?B?ekl0NWtwbGc0ZXczNWVFSFlOVzUvL0RVMFhLOFRjZ2hpVlVXQU5UVGdQWmxV?=
 =?utf-8?B?UnFQdXZCLzF1RFJrR2VuZ2FIK0xvNlhhem81SmtFNG0yVStPSkhGemxsOGhL?=
 =?utf-8?B?QnA0OHhsd1pDd2wzQzhmUEhzeGRvZElpZHp5NlpOU0w2UzY5MlF3N1QrWjUw?=
 =?utf-8?B?eVVMRnk2QXlDQUZybTlCTHpsRWFpMmlIdVBpWVprYjhTeVU3K3czNmxxd0t1?=
 =?utf-8?B?aG1Nbzc5WExIdWgvRlU1VDhEZS9ldmRzeGtCNjZqenlFSk1KYTkrMzlmbGNH?=
 =?utf-8?B?T0ZpbzNFL1NobGFSa1NhU1ZNbC9WRlUzTlFVaDZDOGlNMEQ0Nkx2ejFlZnYw?=
 =?utf-8?B?WTRiVkVjc1BSVEQ3K3ZDRmpmUGlqeHA4WS9OYXcvMmZ3K3VDVHgxOXdFdXI1?=
 =?utf-8?B?NGxXUmFUbTZCdVNRNDhyTys4REljS3ZxK2xjSUF5ek5XdnJFVUZ4ZEN3NlFs?=
 =?utf-8?B?akdEK21TVm85b0YrcVFBTExMcFVON3FkazhaTE45anlhb0hjOUxBanh2Ymhx?=
 =?utf-8?B?OFViVkhXN0pIN0dqSHh2Yi85ai9yOTV3TGw2V1ZzQ2JHbGl6QmFISVpwL0hD?=
 =?utf-8?B?M3lpdnc5RktDT00zQnA4YnFLNk5MYmdRa29OMWk5cjAyQnNIaHhaYjNFQkh6?=
 =?utf-8?B?WlVqRFMzQklzQklFY1B3cktCT0F3ODlWYlpKL2U4eVNHOEhHSXNyNGl3ZW5x?=
 =?utf-8?B?cDZLY2VpSkdEQ2dEQ2FQdi9RTlpCNmRjQnRoTmhjaEFWWEZJbnFTTU1ncXB4?=
 =?utf-8?B?ZnNBbUxwVDBaMnM3dUdpdStXei9XMkpidHFtNE5xdkdES2JJSHlmZ0Zsd0ts?=
 =?utf-8?B?TjFraGl2dStEWXpQMC93aTBQdDBiaGRyZXlOUGQvSFNjbENjcW5HMDRQUm4z?=
 =?utf-8?B?ek5WWmhhaDJGY290bExWSFBKbk42bHRhRFJhQUhOVDAyV1JZdUw2MDdhZHFu?=
 =?utf-8?B?MHIzdnRKYU1ScDlCMFhpdWRPZnVvTE5PcXNGaUdQVDdPMGxlaVBnTkVpdDZo?=
 =?utf-8?B?a1poK2llMFlkWHNqWXIvaVZVNlFOaVlzWm5rZ2JxOXRGa0FFaEhCVkR5UHRZ?=
 =?utf-8?B?c3ZYdGV6eHJTd0FDeUpocWJ4TkRuaFoxU2tKQmo2M2Z0RWVDdDhCSHRNSWJv?=
 =?utf-8?Q?qhKuotfaCioHXbmtBXNKWTDNdshik312iCpqfuX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6e2f45-9c75-4ea8-b1c1-08d97894f6eb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 22:05:44.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xld/u1/VmA8/K6pYIUZ4sprQkpDdDno1e7BBWgMn7ZlkCHKSLZmOEuMMT+9L6achMKLmUm3YWL3ABcJSZfWUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150126
X-Proofpoint-GUID: S-IwVa66A-AJ5BS7DOCWt36PFWFqh-7k
X-Proofpoint-ORIG-GUID: S-IwVa66A-AJ5BS7DOCWt36PFWFqh-7k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, really CC'ing Mike, and sorry for misspelling your name

On 9/15/21 3:03 PM, Mike Kravetz wrote:
> On 9/15/21 6:11 AM, zhenguo yao wrote:
>> Andrew Morton <akpm@linux-foundation.org> 于2021年9月15日周三 上午11:50写道：
>>>
>>> On Thu,  9 Sep 2021 22:16:55 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:
>>>
>>>> We can specify the number of hugepages to allocate at boot. But the
>>>> hugepages is balanced in all nodes at present. In some scenarios,
>>>> we only need hugepages in one node. For example: DPDK needs hugepages
>>>> which are in the same node as NIC. if DPDK needs four hugepages of 1G
>>>> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
>>>> in kernel cmdline. But, only four hugepages are used. The others should
>>>> be free after boot. If the system memory is low(for example: 64G), it will
>>>> be an impossible task. So, Extending hugepages parameter to support
>>>> specifying hugepages at a specific node.
>>>> For example add following parameter:
>>>>
>>>> hugepagesz=1G hugepages=0:1,1:3
>>>>
>>>> It will allocate 1 hugepage in node0 and 3 hugepages in node1.
>>>>
>>>> ...
>>>>
>>>> @@ -2842,10 +2843,75 @@ static void __init gather_bootmem_prealloc(void)
>>>>       }
>>>>  }
>>>>
>>>> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>>>> +{
>>>> +     unsigned long i;
>>>> +     char buf[32];
>>>> +
>>>> +     for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
>>>> +             if (hstate_is_gigantic(h)) {
>>>> +                     struct huge_bootmem_page *m;
>>>> +                     void *addr;
>>>> +
>>>> +                     addr = memblock_alloc_try_nid_raw(
>>>> +                                     huge_page_size(h), huge_page_size(h),
>>>> +                                     0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>>>> +                     if (!addr)
>>>> +                             break;
>>>> +                     m = addr;
>>>> +                     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>>>
>>> We try very hard to avoid adding BUG calls.  Is there any way in which
>>> this code can emit a WARNing then permit the kernel to keep operating?
>>>
>> Maybe we can rewrite it as below:
>>                         if (WARN(!IS_ALIGNED(virt_to_phys(m),
>> huge_page_size(h)),
>>                                 "HugeTLB: page addr:%p is not aligned\n", m))
>>                                 break;
>> @Mike,  Do you think it's OK?
> 
> Sorry, I have not yet reviewed the latest version of this patch.
> Quick thought on this question.
> 
> The required alignment passed to memblock_alloc_try_nid_raw() is
> huge_page_size(h).  Therefore, we know the virtual address m is
> huge_page_size(h) aligned.  The BUG is just checking to make sure
> the physical address associated with the virtual address is aligned
> the same.  I really do not see how this could not be the case.
> In fact, the memblock allocator finds a physical address with the
> required alignment and then returns phys_to_virt(alloc).
> Someone please correct me if I am wrong.  Otherwise, we can drop
> the BUG.
> Adding Mike Rapport on Cc:
> 
> This allocation code and the associated BUG was copied from
> __alloc_bootmem_huge_page().  The BUG was added 12 years ago before
> the memblock allocator existed and we were using the bootmem allocator.
> If there is no need for a BUG in hugetlb_hstate_alloc_pages_onenode,
> there is no need for one in __alloc_bootmem_huge_page.
> 


-- 
Mike Kravetz
