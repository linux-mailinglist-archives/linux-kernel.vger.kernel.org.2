Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF053EE174
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhHQAr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:47:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62168 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233057AbhHQAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:47:54 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H0fbAA030215;
        Tue, 17 Aug 2021 00:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3fdE2/M5F/pHamC49x7rUf+JiZ9A425brDa0hoA6Yk0=;
 b=IFhy6oVVpLIj406EVT7aaZn0bIi4RvZwhhsOWZoNOpZCT6urMVdOrKBjkH4D9f+5Rao+
 vPSA6th0YlG9snUj7Cp+7SBbXvQFMxnDc0K9HP4nUOvn0BlDzes34nNqdvTbIKXy7v/9
 +30eqF6gzLwx+y+Du44T4LcyoH6J+/v+tdCM21r0rV/CuUhnvRt+3uaDCIYJ+nvs3Koa
 EQsx22J2O3VoJwaVhj1AA0XVfc45CnCw0uph+PZS8/3ddqJ0mh6OhtfJcy0qeM4hK+vd
 tLPAlOXvmHPaSn7gHf57DARFj+3Q1huydvuCA/YRXXUliTMElNQ3fKB9SuqLQQkkj4YS Vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3fdE2/M5F/pHamC49x7rUf+JiZ9A425brDa0hoA6Yk0=;
 b=OZaV5cL6HeAJczOsKhYQCi2DWgrEbF81QSFpKMhIn3edxkgHgSyPfuY23NJ9lIsV9xmI
 5SbWYbobs5f6xVDvBhLkG8ZLj7JUJyyPuWjF8A5V3DpsAsVP0SB7kC+hxLs45xvOfGgq
 qTIf2BEtC0PvDgs12zhvuFfRjUeV3XarWLp62YaBvBZWoXPOmRLmN0IlxIhzrFxUFbKo
 FofvHTC7mxiwzjGbc9K8vMKYhHi7qFAZM3bimd/UlyaZ57IvbNuyVbVpe7CaPjXVkwW0
 6NN65G+lcjVvCtV4ss8aQ660VtMyx9CyZ3hy2+cCZhPjARG44Le6V9lnI3q2Z4S3uovY yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af3kxube7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:47:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17H0er8N036712;
        Tue, 17 Aug 2021 00:47:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3030.oracle.com with ESMTP id 3ae3vep5da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:47:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL4o3LqhjRjNko81DNOm3HxsAOEeFIbKECKrVMqDheLIsOMMA3JCed9Uy2zLl72pLkWgbRVLXNmjlEXXGIfW4iXS1sO3y89R5hJLHWp+du/xgy9ufmNvfTAqgeu2A+PHyKqUsI4J1arCU166MGngcX65A7XP2R95/UQFsPvfrQEb97GfJn3MYAaevK2NIuWF5szZKKk7r7o530WfaaE06ZbHAy0/BaO3erKDZ14OGGS2joB23lVdO5o5BN/Y/x47KpEvUAxNrz6wPop6+910Vkm5M4YCsBz4G5EwK3qB5B8cxSVeaaKlZe8OF4hAwrvSFFK3STke1f+tFQW7X+RM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fdE2/M5F/pHamC49x7rUf+JiZ9A425brDa0hoA6Yk0=;
 b=bN2noVJoBqdQujdrQxVS94Wbxfepwq6s6V5cd/YiBktF8qw0ylJ0o/OwNyl2+hJJmBsNIwwErz8hvFZpTRDexX8+lbYcvYznKqGTSF91mL8kblgtlPeCCXmqokliN7CHZ6em4I8+MB92avrfuWIW51KMtCfaG4TVujM/ldIdlohKdjBmuusahOLNWUsWA+U2vIdU9NUJAU+TYhu5rjue9OADNFmUFNpnKben3nVLae2kAlm0E9niMEGzT6mVaFkM5IoeCRvzyc4bFtlmb2MkpRuMcE1RfySbB5GBMtaVWRhJcY/eHBXRyK7TsRSGvC7dR3nkQ7d7+J3JlYmadq2wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fdE2/M5F/pHamC49x7rUf+JiZ9A425brDa0hoA6Yk0=;
 b=SwlQJvh6Nizl6cAeLV+jxFSH5QB/mm2Y9/2N1LXBX93BzGp0rtlxGFSFkZgLBXxFy5gR5iW9C3rxu7T1BawV3HbsWafz00FQYfpNBE+t35gULnF3aX2f8mwd3kgS2Jb1nCxsNWJmG0E49Gb5tTC+rGGGN0c/cxND/HOtYinEjP4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5423.namprd10.prod.outlook.com (2603:10b6:a03:301::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 00:47:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 00:47:02 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
Date:   Mon, 16 Aug 2021 17:46:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:300:ed::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR20CA0026.namprd20.prod.outlook.com (2603:10b6:300:ed::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 00:47:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3efffff0-e006-4af9-fa1c-08d9611886d7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5423:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54230E9C626C7402C78C8BA7E2FE9@SJ0PR10MB5423.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/tWn8Y0cidqsoaUy+iLxLvdj0lc9lJBS+hvYeC3O6pJXTMsQvqgLtyNKLHqarpG/RKQhcDvLozUkgn/J3VPXV3lVTZY1wGSOvinGgzZOlT8oi9bgnt/LP+9rJwW+ESz7zG5f9RyIoPNOGbW8weGMtWudDait0XKPbXL0Mhu5+EjISEizoIK1GViN6z+HCfDQFvzqEFr6ukT+rx74ScHQlKwaThN9jqrbA+GO5+hzLRq71r5mOQKMTdL9/BGDqlfrq5i3kp7t0DQ93WaJM4L8OgbTRonuAEuEygkMjGOf9x9fKhZ6H3EwdxS5leN1zqr2Ot5leurRS3XstMohfU74j+pSSvBBw5pNY6UbXBeDAcIBTSYzSg5wL06XzVsF/JQDcSOgpwRvuCe7yXZop3+SO3mtHw+C7Mghgx/2pKbo1qNR7u6274G/A73m1dalSXGJjTnb+tEHUqn8dypaEPxBaPVNwf4caZva8uj7dMNFqiZ6X/NW5k6kwAPQjO55gjidfzTtW5baoX0FpzUa2oTJ8tzibMDjHquiRfY6T6piS8ezoHNb3U0ScNoM1uz/hcwudhbTiOQ47GhvGI9pKnvcCIaV9lkno1ffSvQKCQGc1jWIIgjAP4Mu4yX3lkjyy7m7GD6tfiXnDhCjUGyxoFAz2zfAbTe+oIrASCOhVAHEzBH/H7RjnKaj897Y/ZfuCX/23kwbZIK7iJ8CZfH+qPtc/zBqB1D8boADfj4qMBTVMlrG3VcUTqO+scTJPQotOp+kPGKvLULKz7EzaNp6t7WOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(366004)(16576012)(6666004)(8936002)(54906003)(2616005)(5660300002)(44832011)(36756003)(956004)(53546011)(83380400001)(316002)(6916009)(52116002)(26005)(7416002)(2906002)(6486002)(8676002)(478600001)(86362001)(66476007)(186003)(66946007)(31686004)(31696002)(38350700002)(66556008)(4326008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9sSjRHMGNmMUtrWEhFRlR5anFiUGhrd3AvSkdTKzNqeFBlbkUvZnNoNmU5?=
 =?utf-8?B?aGxsZTVMNDdJK2xmNVhTVFRrWUlQaktoTDZaNWFMUUU1U0J5MTEvME9oY2xm?=
 =?utf-8?B?Qnp3V3RCdkxiMElVYW9tQm5wYTJ3eDhLTzRCSHRLZjF3cko4Uk9rV1dBTWFJ?=
 =?utf-8?B?Mjl0WDFRVmNhT0NLVlBxbjFJdnZVYjhnYXJEeHhWNGliQkpablV2VzRGY0pr?=
 =?utf-8?B?OGJpMXlndWwyRmNnS0l4Tm8ramZZT0FrNTZ5V2FOYWVIKzY0UTgrRzBRbE8x?=
 =?utf-8?B?aENsekMwNktkTzBJdzY0VlpOOHJrVHI0OGNLWDBGdnNNeUVCaUxnVHFUaFlj?=
 =?utf-8?B?eHA4S1lYcUNJYkgzejFIQk5HSU92ZXpFM2lNMGxwdTZIdzQxQ1ZiS21WTEpT?=
 =?utf-8?B?SlNIemhYbGZCcHhxbTRTT3dCUHczMkJOb0hsR0RuYXg1ZjAxci8vL1VUTVcv?=
 =?utf-8?B?aC9jVVBteGpWRytuOVZrcnkzWGpNaEdRUUJhM2NDcHZWMWdiS2hKR1U0TnpL?=
 =?utf-8?B?a25rN0ptMDJJeHVJYlJDb0p4ZUxvbjBkYS8rUFJJWWFhVndZK1RaK2wxT21Y?=
 =?utf-8?B?N0dzeW9sUGpUOEdOd28raGQ5SHlHL1BaKzZ6cWVIa1YyWmJPNW1EeWVuTmpB?=
 =?utf-8?B?TzZBTWFhRVVKbWdzQnk1MEFLTDBnTDk3VVRRT2pMcXBXaEFUQmVCU2hadC90?=
 =?utf-8?B?NWpMUUNheXR0TGN4K2lBeFExQzJVRGxKZFQrT3g5SnZqWXFEWjI2NXlYdDVt?=
 =?utf-8?B?NjlSNGpEbEt4cDFFak91Z2RvOFd5d0NOeUlFeHlYWmc3enloeHFNYVhNRnZy?=
 =?utf-8?B?cFZ3eU5oMU9JQlBTQ3hsR2JnRDd0WWdyS0VMalhXMHRhdzdkZ1NQR2E4M294?=
 =?utf-8?B?Z3V2YmY2OWF3d0JOYlpQMFRPYTlMNFlCcTQ4TFFCNm4wVjRuWFhKY3R1UE1I?=
 =?utf-8?B?VUR5RHJuSmJhZkI5dFpCMVF0QlRjMHRaUk9BVUt2R3BDc3VzSTNabGZhaW5N?=
 =?utf-8?B?M0xkWVVaOXdmVFIvV2E2ZjU4bHVqUGZoRUU1V0FhZFdzZVdLSExtSUZpQlEr?=
 =?utf-8?B?ay9ZL3JmWFRpNU4yZjdXeks1clJuNlREMGFxaDV4ZkZsUWY1VFRROU5HTkRm?=
 =?utf-8?B?c2VURXYyRkFqMG1XL2JTWC9kemhIRkpTTnF0cnV3VkVNTGxjRzBnRTZrL1Zo?=
 =?utf-8?B?SnJBdE14QnpwbFpQbitmL21Ecm1wU2F5YXJHWWlZMWhwL282U0tkWm1jb00x?=
 =?utf-8?B?MnVTOXZKMHpWUEtqQU92eXhISitLQ2JxVkJ0NW82eW8zWFFwcFo4R1c5UHpP?=
 =?utf-8?B?TTQ4ZWd1SGo4ZGVlQUtPeXlRc1Q0N0FHWXNaVW04WmR6MDBDQk5aZWFveXQ2?=
 =?utf-8?B?ZXd4SnE3blMrN3BObnZHUUlYSlRGSEg1VXZOT1BjNHJ4OCs1YkhnQUc0ek5j?=
 =?utf-8?B?Z0NiQnJQMFBESjVqd1F3YkM1ZS8ybDlzR1k5NjZXL0VLWlBZbmt3VW5IWkRS?=
 =?utf-8?B?Rmc3aGVjbFoyNUJSWTJ2cC9MNjlGU0ZKMCtiK3RZbUtXRzlyUXdPNVYyNERV?=
 =?utf-8?B?TFlTWThjeHlCeDZ3UDFjdDBaWlFjc3E5Qjc3T1VOYm5UTHVSK1N0TUhwMmh4?=
 =?utf-8?B?Tm5rajI0VUtsVE51MDliakY0WXdPT2hUWXRNS1BYK0dydjhyVkp0Z05hUEVW?=
 =?utf-8?B?VVQvL3Jmdm9GVldteFVLQjYxbkFwTVhDTGNvU0R0dmdjUkdQSGkrcGp5NnF0?=
 =?utf-8?Q?JMse26I17r6NXhi0dcOXc+E4neTVxnJyBCpteSN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efffff0-e006-4af9-fa1c-08d9611886d7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 00:47:02.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMhfeJBHWIaUFZntRdEDG2MOuNsoxKnY/YlP1kEyNfAWgMXNDBdFendixZK6m9PU47N4A0C5smj/vKxzW3cBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5423
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170002
X-Proofpoint-GUID: DFNlLaOggYanp6yo_QOlEW-2lfB4fhuw
X-Proofpoint-ORIG-GUID: DFNlLaOggYanp6yo_QOlEW-2lfB4fhuw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 4:27 PM, Andrew Morton wrote:
> Also, pushback...

That is welcome.  I only have the one specific use case mentioned here.

> 
> On Mon, 16 Aug 2021 15:49:45 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>>
>> Real world use cases
>> --------------------
>> There are groups today using hugetlb pages to back VMs on x86.  Their
>> use case is as described above.  They have experienced the issues with
>> performance and not necessarily getting the excepted number smaller huge
> 
> ("number of")

thanks, another typo to fix.

> 
>> pages after free/allocate cycle.
>>
> 
> It really is a ton of new code.  I think we're owed much more detail
> about the problem than the above.  To be confident that all this
> material is truly justified?

The desired functionality for this specific use case is to simply
convert a 1G huegtlb page to 512 2MB hugetlb pages.  As mentioned

"Converting larger to smaller hugetlb pages can be accomplished today by
 first freeing the larger page to the buddy allocator and then allocating
 the smaller pages.  However, there are two issues with this approach:
 1) This process can take quite some time, especially if allocation of
    the smaller pages is not immediate and requires migration/compaction.
 2) There is no guarantee that the total size of smaller pages allocated
    will match the size of the larger page which was freed.  This is
    because the area freed by the larger page could quickly be
    fragmented."

These two issues have been experienced in practice.

A big chunk of the code changes (aprox 50%) is for the vmemmap
optimizations.  This is also the most complex part of the changes.
I added the code as interaction with vmemmap reduction was discussed
during the RFC.  It is only a performance enhancement and honestly
may not be worth the cost/risk.  I will get some numbers to measure
the actual benefit.

> 
> Also, some selftests and benchmarking code in tools/testing/selftests
> would be helpful?
> 

Will do.
-- 
Mike Kravetz
