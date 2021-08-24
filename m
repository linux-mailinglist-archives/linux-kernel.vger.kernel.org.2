Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F128E3F6B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhHXWKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:10:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12820 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhHXWKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:10:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OLQcO5015021;
        Tue, 24 Aug 2021 22:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fZ7LSrlL0L1+X9Q+XEVQQLcb/UCOzkfNTUmmmi1RZxY=;
 b=Onh5rTCaULMeH3qEcuBGlg1Y7ARRBxmBLgaPy6J6HT73AFbNeYtwHd20Pl9RjnLwIr7x
 tBC5PAHRyUptEX1l8Paq1Wq++0oz+IvhnzgdwbD44FlP6jZ4kqRf/nviMzpelHeeTLtk
 Bh0bRyP3TKFZtzOhQbqwjLC8uv2shT0uo7dg5HRI1dq8gfXAmCM8d1XK2J1hXIt8gPbc
 DWEFSJ4uuyWXwoBI2RTmBvi8Xfr6z8/x+8eGO+4OaIxs4ubTuNwztq0A3KbDMRNMoBY3
 k+BWrwrIt5mhuJwaaqh3ewCbPxGhtIhE/GfOB534Kv6ii0wevQSFXzuzHfuXKAkLjRiM gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fZ7LSrlL0L1+X9Q+XEVQQLcb/UCOzkfNTUmmmi1RZxY=;
 b=tSKDFvp2egOP3nK5Qh9ZvwYu07CuurFA4AYyPelAQRdxUasxb3rdVoJzOvbGwhNhGZa6
 cAzqXWIOLfWXmFZQG3gjcRZMV5x7Ma/uQTIn67tfFv5X6DGLxOGkbMHRdJU9tkQJtduG
 m2gdChNWPwHu/SbPqgvxOHuVMz0VEMKViVKYboVJ4hBC8fP564kYRZ1utjltXmn7X8Ga
 EplSD+lSebq7M/I7TDEyrlL2f/rYQMBS7BHZ/R5IyQh4ahejRVtC/VLWAoXMDBk6CJoO
 0A2soQNRVQijobvfkFnTwvkwsXqmJArRH22avyitJGNnLUskpOZ/c6PBpdt81Cx5Mf6B Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6hwcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 22:08:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OM5O7N035067;
        Tue, 24 Aug 2021 22:08:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ajqhfd567-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 22:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK2XFDqxkBLPTBSTQyAPcsMijg3nixGgu+jaEOIdjtLYEO9RbVXA5L/uy7qTIieUxHNpJqmlzvsxvpC/D6Yzm/mNsNQfZ/i3UDsD5dq8sf2a6PoGbIAp/tQkobiRJO9msvat5USi6m4fiRNWPyHVss8L0dtitQ+ACpA5coPBWw08slK6WQ8QCWuz/H1+62qw9P9mnD1xkw/v7DDp9zvInH/Ido7NNMHMQLgRX6ZweMNGVkbAf6TWn6GsFeb9auWkywSHBVt+VPB4OXt/xDgwW3OpdFIx091D3zGuVP401e1zIaif1id2kVT3pBe3a4d43362w5UouuLItOhutsY9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ7LSrlL0L1+X9Q+XEVQQLcb/UCOzkfNTUmmmi1RZxY=;
 b=ilEIBQpQ+KYJdsCs7WlLge82skotE7yA7dbl1dLoO4YqcsCXUommidMpu4Cq9Xk9dysMEhoNUl2Wp5BjiLS5PvjPGcy0XwLBzOu/w2YmekJWEEf4/jLl930havzrTJXAuGBKRv5Uk9UO2Ic3YdRQLt+EvY0hoz/fkGHLtUuXAq7fSB5DXPRVqP7X3+5qyTi7OaNgLMiNUomFY6cDClX8iRKlhF4E6K8A2hlcwT2zslIu/fA369SbfGxcbtRHrzASMAY3EAHD7n61MzLMHIYpHznwOnjmZttjbDm2/BgsC4kUdyinuTY7gppweqef1734QML0IfKx46e6mXzxcqtw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ7LSrlL0L1+X9Q+XEVQQLcb/UCOzkfNTUmmmi1RZxY=;
 b=PP5MPAESzkAYWoO2OO+eTG23f5J+LLoOuqS33g5GAqxAwYKwhooBE7tfWTLsveVH+RF5B5+ylfAfK+j3cuSOvcxQ9QzCdY419V4O0ZMf0S5EXFtHr4qG6mxQqA1lwrB6lqcU6SZctZe1cYIEIJH0H4EnaRoZZlHknfwXQPPEj5s=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4276.namprd10.prod.outlook.com (2603:10b6:a03:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 22:08:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Tue, 24 Aug 2021
 22:08:49 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
Date:   Tue, 24 Aug 2021 15:08:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:300:95::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR13CA0038.namprd13.prod.outlook.com (2603:10b6:300:95::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend Transport; Tue, 24 Aug 2021 22:08:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a439a4-38ee-484e-6c50-08d9674bbfd3
X-MS-TrafficTypeDiagnostic: BY5PR10MB4276:
X-Microsoft-Antispam-PRVS: <BY5PR10MB42760944828702DFF358DD23E2C59@BY5PR10MB4276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Obm7OhvNZl1kFYGaInxJbHDP92k/87phgmaJC3Rrs/IK5sI06L6uYzCwB+vRbpzHYw6WZm7XP2CbLe35BQ6CLiuhWIbLM1QYqGA+OOzikrzR3gmzunqpgbW3gqTOeex0k6xEVVxtyl8DU/5dJ8ANk+X4hpPwoMY19gYqNpgahfkPURk+vBmmRf2cGC8Fk8SZM+vt6TZCa8pybMSwRFNW1fW01vUB14HDE2Ekg5hfB0DEjZDRF7Yli7v55xAnuep0cioiWXvL8qmCKr56bdkoVq5UpCxqyLC1o609ibCwH0NHdIIZB/g8Y47deC6zUxMt0yUVcuyBIibvNL8wA5BxFoj9Qg+hw1Hphwa+6eFI50mkvi9jNQTstAAYE3YJDykWJqvvujbn5wWh3kuxQT3nd0CZm01fMx1Pk4ZSQxpBFceT6dBFA5KnZ1SjrRYprIh1h+M8wIkin8QSPdS6CM0HXpWuOeI+XGatub6dGdI1PGmGiq9tmAgJWW2TgPSWiCVl2bX225ja29+IamM3JPFNgHWLDKFR+FVa7QVZrJr+F9NCFVEFWxqMLMScl+B2w0nXKBuQsckVPAEwQt7Xu9EDcvGfujgSWmMGQg1Keba77X1l7ov1ew2MVuKHupflIEaB7GiojFgofXpb6Z2VKIr9OxKBfL1G9PgvspH0u1rzvQz+aRp4OfCG3dG6GkbQdgt/NTo1Af2F8S9hihiBsZKPIm9D98kqGv1rURZUuKpKax7rdvwsf2mTGYmAs43yMG5wO04tUexKkJ8mJ0OySUZQgx27A/nX4z6JszUg0NAHHONn5MbIE+LIPeYY+slkcel/PjRfCcnmeIyUFE3UTSn4qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(38350700002)(38100700002)(6916009)(66476007)(52116002)(26005)(53546011)(5660300002)(966005)(66946007)(186003)(66556008)(8676002)(86362001)(44832011)(316002)(16576012)(54906003)(36756003)(31696002)(7416002)(4326008)(6486002)(31686004)(2906002)(956004)(478600001)(2616005)(83380400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmVXaG9iMlFpZklmSmQ0U3F3Z1BzVkprMFhDWk5JTlpwSDUzei9ubkZ3dUJr?=
 =?utf-8?B?Vk1ISkR6ZlRzdUZ4aCtqc1dyc0MzY3RHMWVPUVBPZFNOUzEwdHd5YUJITXhX?=
 =?utf-8?B?bFRETGQ3MzhmeUtWMXNJVGJhanVqb3p5R1B4M05zeHBoeElxR1NkSFhqbHpF?=
 =?utf-8?B?eXV0SUNiYzhGWHFvV0VubXkyMTlNdlFadjlyUmxqenBDWWFGbFNKZWZSZ2hJ?=
 =?utf-8?B?SjlJekNIbk9DMm1zdGs1NkxUYVJla0k4OHpDbnBaSEdFaDh6d2s4M2NzQnlQ?=
 =?utf-8?B?bk10cGkyd0VLVEtVWDNvbEJtNXovc1hvQlVsQk5JalBRTnBzNDNDK2NNYlJk?=
 =?utf-8?B?TEc3TFFMdGdNRWNmbHNqOWsyRjRuY2IyNVJYeUFVdDVhYlB1VnhYdXhBdUxU?=
 =?utf-8?B?d1NYMzJWc2Uxamo0ZlZ2V2VkcFJLZGozdllObGJZaGRMcjJIYjdOekVMQW1t?=
 =?utf-8?B?S1FtWkJmTFFoMk1rQmxPZ1g0cVNaZEFMSEVxUzVadnZHQSswaitVWGNJWGIx?=
 =?utf-8?B?RFZ5eFB4RDFQNTE1QUlrbXVETjVrRkI5cmxVR1czc0dRdkVaSUlCdlptT3lJ?=
 =?utf-8?B?dDF1c0d4ZkVxdElVb2VqTHEyY0NwbUhYUVlhMkRBam9JVnZHdGRRTVpoZkVu?=
 =?utf-8?B?YWRRNW9JMkY1ZFlGV2ovSWpRQi9TNHJTeldCamc4dDRPVGU4UUg2Rmk5czA2?=
 =?utf-8?B?RWFCY09FeSszbFFIcnZQdHVwK2NTSFcva1hSdFVoOGM3Y0lvcHF5RXFYVXJH?=
 =?utf-8?B?eENnMzZFNWVkdlRUYk16dTV1Z2IwVXZhRHVxdXhtRmR3RWVtc0RMYzBUNVVw?=
 =?utf-8?B?d2NhZ2tjaUo5RDRTbE1hMUkwMTV1a3VWK2xKRjltVmxtRUxVVnd5TjZtZ3J2?=
 =?utf-8?B?NUZzUWtuS1Zwem0zSFlSVUR6NU1LRUdFdjZzOXRUQmR5eEFnczA2RGZnSGJK?=
 =?utf-8?B?ZzFaWG1idFArZEQrZkRWM3FhSE1vcHN0MXptdE5hdnVVcENlUDhLYi9RTEFC?=
 =?utf-8?B?S3ArQzl6SkpZRDJIbXduTTVxQXA3eDhJRXZkWFB4ME82M1p3R3R1ekJPNlAy?=
 =?utf-8?B?eU1jcDdnN0h0QmgyTHJFUlN6QnlsUnN1bmJOdWRVYnlaTFdZL2NQZUQ2ejQ2?=
 =?utf-8?B?UVg5MDZad0JZWDUxS2xEdUhJZjNiZ1paTnludmYxQTNRTmIwdTFYaGpHMSto?=
 =?utf-8?B?RmtZUjQ5cldGdjhLcGJSOElzNWkrZWN5aXBCVGEwelNLOUlaMFZrcHZhMStS?=
 =?utf-8?B?Z0tveGlxcFpwTGZRMWQwOHBTUVRKWDRNT1dkVmdDQjhCcUdtVHN1d29mY3py?=
 =?utf-8?B?Qm5FWW9WL1FEWkVUSFpnekN0YUJUVXU1b2ZwdTE1M3BoeW9VTjlmQ3RrS2VB?=
 =?utf-8?B?dGtjSmRBUlh0UVJaemZXeGxQZWsxdGlvWCtHc1ExRVFhd3FqQXVscjlsQ2ZK?=
 =?utf-8?B?NjlzTWhFeHZ0NmZKSHFmbldpbm1DS3Z5dWVMMXp1U0dMdEV1T2N6YmVOQ1Zi?=
 =?utf-8?B?WkNEdXpOdGRSYlBSNGpIVitTNjF2SWNDT0REYlRUalNCK0R2L25aWjJCZTho?=
 =?utf-8?B?TnVQV1k0L252K1ZsSFVrUFV0dTA2eUkzQ3BGaWJBVlBWcEVNeXpndXNYOXB5?=
 =?utf-8?B?TU5WZDk3REc1clN4T24vamo5eVczc3BHR3FwSGVjNmxyNXFxSHFvQmNXK0Q5?=
 =?utf-8?B?OE0rK25kQ1dQV1hIaEVtZEsrZ1ZkbHYyOVZBSzlzMmhSc2J0b3RuWVNhOFRh?=
 =?utf-8?Q?JX0kmYwcPNdGhpQv1gyUHcasm5zxny8AVTnkDFR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a439a4-38ee-484e-6c50-08d9674bbfd3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 22:08:49.0139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RB8uqMxhaJ2CZOEotr6s2Zrpc9bHCIVH9uUa4Ybiw6qISW1TFEk7Do9r4eJkoYLWq+3XkUxMH5Ge/0B95WSLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240138
X-Proofpoint-ORIG-GUID: sO4mAeNgYL1NlIXrlHMMf9SZCZhgFhIw
X-Proofpoint-GUID: sO4mAeNgYL1NlIXrlHMMf9SZCZhgFhIw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vlastimil and Hillf,

On 8/16/21 6:46 PM, Andrew Morton wrote:
> On Mon, 16 Aug 2021 17:46:58 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>>> It really is a ton of new code.  I think we're owed much more detail
>>> about the problem than the above.  To be confident that all this
>>> material is truly justified?
>>
>> The desired functionality for this specific use case is to simply
>> convert a 1G huegtlb page to 512 2MB hugetlb pages.  As mentioned
>>
>> "Converting larger to smaller hugetlb pages can be accomplished today by
>>  first freeing the larger page to the buddy allocator and then allocating
>>  the smaller pages.  However, there are two issues with this approach:
>>  1) This process can take quite some time, especially if allocation of
>>     the smaller pages is not immediate and requires migration/compaction.
>>  2) There is no guarantee that the total size of smaller pages allocated
>>     will match the size of the larger page which was freed.  This is
>>     because the area freed by the larger page could quickly be
>>     fragmented."
>>
>> These two issues have been experienced in practice.
> 
> Well the first issue is quantifiable.  What is "some time"?  If it's
> people trying to get a 5% speedup on a rare operation because hey,
> bugging the kernel developers doesn't cost me anything then perhaps we
> have better things to be doing.

Well, I set up a test environment on a larger system to get some
numbers.  My 'load' on the system was filling the page cache with
clean pages.  The thought is that these pages could easily be reclaimed.

When trying to get numbers I hit a hugetlb page allocation stall where
__alloc_pages(__GFP_RETRY_MAYFAIL, order 9) would stall forever (or at
least an hour).  It was very much like the symptoms addressed here:
https://lore.kernel.org/linux-mm/20190806014744.15446-1-mike.kravetz@oracle.com/

This was on 5.14.0-rc6-next-20210820.

I'll do some more digging as this appears to be some dark corner case of
reclaim and/or compaction.  The 'good news' is that I can reproduce
this.

> And the second problem would benefit from some words to help us
> understand how much real-world hurt this causes, and how frequently.
> And let's understand what the userspace workarounds look like, etc.

The stall above was from doing a simple 'free 1GB page' followed by
'allocate 512 MB pages' from userspace.

Getting out another version of this series will be delayed, as I think
we need to address or understand this issue first.
-- 
Mike Kravetz
