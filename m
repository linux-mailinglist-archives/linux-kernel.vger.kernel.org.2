Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6885452581
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhKPBwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:52:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24460 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241364AbhKOSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:25:50 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFHHX0l001110;
        Mon, 15 Nov 2021 18:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l4zaAwm69yHAPTFaJy02u3QkAszuihzLA+PFPcPme0U=;
 b=K2JGCsMuVsPkIlAxZS17U4jypH1QgXSjuCCtXISL37ICdZrPKKDGeWDug3b4seQzkbAO
 ZVy9UKUxZENo18niYbRUzc9tFLycWnBx8aIcRSQQ97urn4UQG4DT9H0haAJZtclhGsFF
 OERAE5YrCMruZIiQD6LRodLXluVRB4p0t80sU1zSiKwu3+1csNcDlmjEJm5mXOjvsJlh
 X32QAmoqWEdtjtd7kYmpussV32thMjm7tkbqvW3z4ZCm7Uxng4rtN/N/bov1nIbM2GIq
 r/12zWIVLMQBvGQK/tgygoeL3gDH/k1GjOvycW8+qCrZLAncpGPYoaDWqDe+P9QU778k 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhtvkvg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 18:22:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFIHFhD150559;
        Mon, 15 Nov 2021 18:22:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 3ca5648k2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 18:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyEe7vVpYFX9qLv18C/Ya72XM7Oodk0Gqy7um7bc06U0Qw4AcrJOb/2qozrMK0RsZFLkekx4MQR00lN1LaH+LfqdbmFvxz7JGwWC7bT4SzTQzWWqRQ0MuVNsIZ0eUquaCE5fVod+X3DCph21x9FDhSzxyF90/k1EhIWGQG9G1CtGyVMzzWLBQG1itmSCC7X2qP6tzJNrAtRHRB0XQbOimsCfh7N7yn+MVYaRqTJ8Yj4Lk2ZOtU0TI3XviZdtho9WD2aQECgb8/UOFypVN7Cxk07+6B2uuk9km2hHqFuQWfJEV77FQRJdrTRodAaeUxaO+3MLmfBSrG9zED+oNmpPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4zaAwm69yHAPTFaJy02u3QkAszuihzLA+PFPcPme0U=;
 b=BF9axeUhMVo8fJnRHmYa6tE5uzchLwctn20rFtMDE4JapvyoLlAsR497jU4xnOn4EDY+vLYchnOZZekWkZ6jDJo+35za9xAz0wWqfJ78tedXGCYGcNxDG/KDhh8UftXHv0S4XrAjhHcLDk62FiwZfoQXO15vgvmaGJBGJ3ZXYPuFhtcFJT4TTDP+zGHwP9oCv9b8L8/Yk9vIIsxdu0MJuBynE3RNDKZzDQdRd/nFfs2LdAxzYQJEgHhxFqhcJ3H0TGwuU7+72WjCFgVTM+dXh3XxU+pdmkS54owncAj9rb6zW9rokcbknuQ3Ph363PYFl+OjtJ7MfvPkFGBK8VJ1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4zaAwm69yHAPTFaJy02u3QkAszuihzLA+PFPcPme0U=;
 b=dUpy6jpqlOX05RcGLPwqmRkVCZUbssRnsFHJ+2Ni9dg13qwAlKrdYq5+1r22qVW4Tf3DRuusmRh9PTkMXpr9/fQFhIzkX5sJXgdLuQNezvopJcyTbk5prVyA6Gxf+L9b8CSpl/tLi/MxzGVaZ+Xm+NohHzOEWfgLt3kVGT2IQyU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5469.namprd10.prod.outlook.com (2603:10b6:a03:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 18:22:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%8]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 18:22:07 +0000
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com>
 <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
 <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
 <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com>
Date:   Mon, 15 Nov 2021 10:22:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:301:15::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR2001CA0006.namprd20.prod.outlook.com (2603:10b6:301:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 18:22:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7cb2720-4569-49ae-1a63-08d9a864d4d7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5469:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5469B71B753065A7854ADC93E2989@SJ0PR10MB5469.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q68Kbdje/Hg9RbGedTPbtSGEul0Vlni4QXuriH5K7wnjKvT+7Xh12FbfQ6a9+FCSECmD2qWy/BSFTK0xskIzAA+PaQSZ6fxP3KgRDb04pePenP2udK9I1V0fnFcEv2ARpa0yDedMKpJ2UJLe1oA/827K1ejt5e+SXSjNQ/AO7YSjiz4OCO54H87tHEu4cRRQek0TnVVrKkj81shTFjX4sbYUJsH+zy+qllA6RQEsSqoAQPd27yTLS9JkX7huu9NlyfXlBq9HxAW6MJIxBf5cIrc/LH7k23dirJ9xqdpSIzkb4HE1YulM9YiMvaunhVYzk/NcRak+UZGQyx1SVjFUG1BObcVvU26fV0od15lSti/St8Ez8buWhFq0t/4SSLEiYJRgJxGv4DI1JYrYhjnfAOJq4sIQKuq3K++ttNL4yMPZCwC46+Jq/o3JKJDLxB90bkpukOR0sN0EeHhfZ9sezLdSCJuax+WU8VAQ4w/PsUMYLi4WFaDiCZx/3TbQByJmj8D2gfmhzxWp8XwU8dDlocu+4uEuAWtYh2MXHjAv5lCSyA6OP2STgutpq+iyKrgA95FQDZBOhQTCbzJoXeOQxAWMpQ6H0DKmLX6wsKZumc9imwoKnL3hxEsAi9w6b1nOdwQ+Ff9zqADzmGrqWnIdaHCQAnUb6Ga3yGit4tl/XqRpWy3ZpiCxTLnmpIQSZ3PSAQn7UgKumNc9NFPuaOMNFlIVM4qZEjg+Q9F72uabs/OEwL/2o59tS48TYod3Ng5ESXRw0jQJH/j7dHm0X5sj7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(5660300002)(16576012)(8676002)(7416002)(86362001)(26005)(31696002)(2616005)(110136005)(54906003)(956004)(2906002)(38350700002)(38100700002)(6666004)(44832011)(53546011)(36756003)(52116002)(4326008)(186003)(508600001)(83380400001)(6486002)(66946007)(316002)(31686004)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0c5T3NJRnRFREs4empJMGswbTVFdENBeG54bkRTb0QwWk9jb3crS3B5cnZt?=
 =?utf-8?B?WEdLK2NNT3Y0U1YvaiszeTBidXZlbnpoWFVpUkl1VVpkQzlUcjIrNm5pL2V0?=
 =?utf-8?B?L1ZjUnpmSWxJZHlONlplZDVETFA4Wk02T0EvTnFnVlNaRkE0b2llN014Mkpm?=
 =?utf-8?B?V1BwSk1iOXRZTHc2UitZc2gwYnJmbTJGeHdIQ05JVHNUL2ZvblYzMUdVVE5M?=
 =?utf-8?B?UXdtZGpGRlR3U3NySUE0WW5wWk8zTjhVS3R1dlk2NjZLNnZHTy9HVGE4YWVD?=
 =?utf-8?B?djZRdGJSNlY1aGwvNzByLzluNEd1ZloyNmJxd0J3SlRodlFUWmcwL21vZzlh?=
 =?utf-8?B?c2c3WFdvRjVnc0Q3bXlLQ1J5VURvQzZrRktEc2pVUS9VdTZldWdhRDNSRVp5?=
 =?utf-8?B?ZmQ0RkF1MnJSekU1bjRYTWdnNThNWHJMdUhQalRUek5jRGtML0duQmhwYWxu?=
 =?utf-8?B?ZFBCSmN5eWladmVHZC9wSmZRNzN1T01WNjVPREhlcmVIV2xHb2hNalN4dGZp?=
 =?utf-8?B?cmJpKzloazcwRUJ0SmVDZmNCYk5wc3pOUU9taWNPNWtxL2VScTh0VGRqSU51?=
 =?utf-8?B?OTdiOE00WmZ1RkhhdUc2VnF1NnMza0UvY1lhVFMwZmpnVnZFM2FVUktLc3h0?=
 =?utf-8?B?elpobzdtRWJleWZWaTJVbkhYZGgvRVlWOHZhd2RzZ21LbHFDVlV6WnBBbXZQ?=
 =?utf-8?B?QzZNck10M2p0dUcvUXVFYS9SMlFZOW9iclhudUZQVWw3bTFWYkRJSUtsOFhL?=
 =?utf-8?B?ZFphblBNcmlwRm9FVFcyUFRMdjBNL3BPNWNjaldxeEd1WE01U2xqYU5oZkVX?=
 =?utf-8?B?Q2tOMTlBL0dOZndZQmRUOXBhbmdoUGd3YkJCK3BWUCtMWlU4NlJOTCtzLzZO?=
 =?utf-8?B?SjJ1L011MHh0OWFPYVJHbFpPODg3RjdpN2VDMnBNdzVLTjRQT2plTDgzMGVO?=
 =?utf-8?B?NTlzZWx1VWNxUW5IUjlicm5YWVBPOXNEcnkreVpzUHZQQWdxdmU1ODVJdlJT?=
 =?utf-8?B?TUdIVjVyZ3FMZHRjOFJjUk5mdHlnRGtCVmo4ZkxibVJzWm95WXFENFJPUlkv?=
 =?utf-8?B?VlFITEduSURqTHR3TkNSVUk1eWF3U1RNTUtXelRGNmRkU21IZGFZcTlwU1Uz?=
 =?utf-8?B?RDNlVUZIbFh0anJyOTJCamVaSGNEMGJsVWdqTm1hUVhOMm1IZ0xOd1kwUGRI?=
 =?utf-8?B?MU1yZGV1ako5YVA4VkhJMVF4M1RCazRsaWdRaTJub3BDbmNiTUw1ZlpQZVcw?=
 =?utf-8?B?NklBUjdGUzgzcVNRTnRIUzJ2bExmRFF6dFlwSEpBY3M1SHNaTkNrU2RqUEJa?=
 =?utf-8?B?WFI1NzFwN2U5ck9qUkZBdHVBSVVQT3NiZnlRV0orcDlqRzdaLzVpMmRlalRM?=
 =?utf-8?B?UlA3RlNEb1E4aE45b2tzdHQ1V2hNaTRLVlY4WHoxWGU2WjlqaEkrc29PWVg1?=
 =?utf-8?B?SVFySUwyVldmaUkxQUt0b0E4c00venZ3dkJhc2dhUExKOHlWcjJiYkVzT09R?=
 =?utf-8?B?UUhBQnU4WVpTVGNCdnBOR1lOMHFTYkJiajY5b1FKTENrYU5WTFlUQTlFSnYv?=
 =?utf-8?B?M1BwMHJzV2dzZ3Z2aDB1YnF5RE1LdHRsY1Vwd2s1c1daQ2Z1SEZsZlJtblh2?=
 =?utf-8?B?RDA5WVJTNVRrRlNQS2Zza1M5dm5SQjFMWGdsMVpHT2VLcW5FL0MzcnhZQ0or?=
 =?utf-8?B?aVpxUTFDV01nbTFHenRpRkRtSGVyd0tCajY0ZzhSVkgvb3FJMlVEdHVIZjFj?=
 =?utf-8?B?NVQ2NmFJTEVjNVNhNTdjaE9LbUlma2pXcjVGZDFDcDNBTkFjWk43Vkg0MUo5?=
 =?utf-8?B?TjAySWZHSGYralNwVUIwSFpsaEQ3czVJamFGejNVWGd4U2Z0b2J3NDlpcVpv?=
 =?utf-8?B?UExyWjJidEQ0Uzl1QlN0UVcwSjJ0WDgyZHZYOStRSkQ2VFN4WFNRTk5YbTdl?=
 =?utf-8?B?ZlZRZ241cWhCOTdmZlJ0ZmliYmozam8zNHRFODEvcEFTQS9QZlBmQXRMQVZj?=
 =?utf-8?B?MjNuTUJ5QTVxV3NYRENzU2c0TVZWQ2xYOW1QaGZqSGN4d1N3Wmdra29uRjk2?=
 =?utf-8?B?ZkNLVXJTdi9jc2ZXeFRSc1V6aTJCOHdGNEs5THZ6TSt4d3RmMHNpUnIzazJ2?=
 =?utf-8?B?VVk4Q2x0cDR3R3pTdHNzMk1oem8xN1p5OWMwQXBPdElLMkVPLzVTVHVOenFp?=
 =?utf-8?Q?raXsKya3l4+01fnjJcoYLUU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cb2720-4569-49ae-1a63-08d9a864d4d7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 18:22:07.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMfLerrd2NfWSjFzc0INEjoeVhtYKQrHXCcVvW8suotgJv16oiJ42HZS3XywRZqkN1hOExuYJPAUS/4IMM0H1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5469
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150092
X-Proofpoint-GUID: yQ50I4A16jADQMup3xQLhhqH4kGri6am
X-Proofpoint-ORIG-GUID: yQ50I4A16jADQMup3xQLhhqH4kGri6am
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file

To:        Muchun Song <songmuchun@bytedance.com>, Shakeel Butt <shakeelb@google.com>, Mina Almasry <almasrymina@google.com>

Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>, Cannon Matthews <cannonmatthews@google.com>, Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>

Bcc:       

-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-

On 11/14/21 5:43 AM, Muchun Song wrote:

> On Sun, Nov 14, 2021 at 3:15 AM Shakeel Butt <shakeelb@google.com> wrote:

>> On Sat, Nov 13, 2021 at 6:48 AM Mina Almasry <almasrymina@google.com> wrote:

>>> On Fri, Nov 12, 2021 at 6:45 PM Muchun Song <songmuchun@bytedance.com> wrote:

>>>> On Sat, Nov 13, 2021 at 7:36 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:

>> We have following options:

>>

>> 1) Use atomic type for usage.

>> 2) Use "unsigned long" for usage along with WRITE_ONCE/READ_ONCE.

>> 3) Use hugetlb_lock for hugetlb_cgroup_read_numa_stat as well.

>>

>> All options are valid but we would like to avoid (3).

>>

>> What if we use "unsigned long" type but without READ_ONCE/WRITE_ONCE.

>> The potential issues with that are KCSAN will report this as race and

>> possible garbage value on archs which do not support atomic writes to

>> unsigned long.

> 

> At least I totally agree with you. Thanks for your detailed explanation.

> 



Thanks everyone.  This makes sense.



However, I should note that this same situation (updates to unsigned

long variables under lock and reads of the the same variable without

lock or READ/WRITE_ONCE) exists in hugetlb sysfs files today.  Not

suggesting that this makes it OK to ignore the potential issue.  Just

wanted to point this out.

-- 

Mike Kravetz

