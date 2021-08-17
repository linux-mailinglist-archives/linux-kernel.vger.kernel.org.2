Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9573EE0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhHQASm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:18:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49132 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232924AbhHQASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:18:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H0CMvo027264;
        Tue, 17 Aug 2021 00:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lfg+rNHLA/GFwcH5L0WKGDt40FDqsr1zRQEPgJOeqbU=;
 b=OG8oWy+anRpHUbFurhnKO7+IFc0/EpHdiFOzDoTn/dIvitv8RTAFtRbMqNmQXrcesMy+
 5yXTeTmcc/CwJ0NLlfUEQP+OJma2zqhj5wWY8GriO4qC2iBg2rBVqvyS+EIki9N8/+r+
 S12pb7YmveuKBHorZcc78mGYqg/+XfaZ0KkaEd5Bs5wcbi/yEYY4firEofVZ01RFc8oI
 T4VqtoQRifUsFt3F8YfM/1GL8y6csCwY1cR8TAkpew5gHSg1B/ZgOTxHQcHg2glK5N3S
 nKCx2qgIzSdcFD09uymH/JWropsH5mJ+8/LI6fifOpjEmpDsZFtNGbJyABnHY27Vj8O2 sA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lfg+rNHLA/GFwcH5L0WKGDt40FDqsr1zRQEPgJOeqbU=;
 b=cThODU5kTzrYCqAR5iaRZkCM9B+uhXVJ5JjoCe5bBVIpo6SJZj/QibrtbOeaoar9oGjV
 MJsJBWNnsuCFG8zIjf6Bl8/zujoIWei39v6qYcqd0Mn9dkBcE5S2bbG2yY3xkzqW0ra5
 TtsnGIt0dQ9D5MzZzw8mADt+K1/4mp5Ds2zBWlsgOpERaPj58b+3tOyLmIJG3g213m/q
 AxT+MBXDqjkemvOl0xTmNYI7SkRmxjURBxyDly/X0K7I3ZcooDM4Ms4gRL9k+cOSfh1x
 GwVjgQ+JQhil49dKRwF935D35lBDPH1XIuzENkrlO6aBH0zNNtjbIVS4T264hCOphOIQ HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgjejq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:17:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17H0EjIU184961;
        Tue, 17 Aug 2021 00:17:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3020.oracle.com with ESMTP id 3ae5n6jrx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlmw8PIzHEblgiuFwhAC0H9GPjV/at+IijDRpD4HH6LNWcVdM+7jo80z3qyu/u5MPlgXsvQb9DKT61dZs6h+8zgd/oXMkpCxNUWpnhPpQY66v901xDCIoE18jYqK5fPPz3AJJlT9TdMuxQqPvEeQRL8bHAE329C8V8/My53D0anEQJLq6Knd1sjpxuQQD7ynHPKuLhF6tOQa6vTngdIuycpcbA7e5Kg3ONZLJ1pPeWAMK7A6YSvdGsTkxHvxtnJcaWW8JR5hNZiLvDS01XVgBybASg1FF6mdA8ynvFpSmzp3V8DYG0tj0VYGF/bQDp9u73MAPFaGbuEe76dG6uWnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfg+rNHLA/GFwcH5L0WKGDt40FDqsr1zRQEPgJOeqbU=;
 b=n06qPvGDrJUAXCOjp1A5jggOzgAULOerwNrso5u4FIW0GvWWtE0h7usipLuaa3ahdrWt55Ze/86EZf0j03h+iv5g0IJArT7m2QgKvKiVRFkfjl1YUeW0qTDZFhT3oKWiN1D6cVn9j8XqDe2c3v1o6c48nc56CJivWRmGhhDJqInrX4vuBjCEXb5pGbL2asK+EGUV4PNirhvY4RP91Dy9q5h5X76DTfm+6Z93ybQECInrafc35hpdrmArR6PFxaggCN6GRYVSRqwJx0JiSgeEF4FSTiBR0f11EvVVb1mFToGG9iUhvKCWmOkc3ax/HinsECD0Hv4Dy5c07FNaSFKPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfg+rNHLA/GFwcH5L0WKGDt40FDqsr1zRQEPgJOeqbU=;
 b=Z8MFcHQXpoFe1suPZa2XizhptAJ9RjcA9Oj8rctoh0PsRPWCsdwJItRZ0s00dfZE5vzAxqckoCVy/tHnYalNqxoPnGtVXMxQCaOY7FtJr7akEhh1LN4oR2u2DHaVP0rG3a8VvjOM409j3Uc7AWRFoaSlEhmmAvMS3xP2K2/KCjs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3761.namprd10.prod.outlook.com (2603:10b6:a03:1ff::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 00:17:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 00:17:53 +0000
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
 <20210816162305.b19bfa3f3ba7431a62ff205f@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5dd4e07b-d2cf-63f2-fc0a-9b371b469a44@oracle.com>
Date:   Mon, 16 Aug 2021 17:17:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210816162305.b19bfa3f3ba7431a62ff205f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:300:ef::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR22CA0006.namprd22.prod.outlook.com (2603:10b6:300:ef::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 00:17:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ab225c-edac-486d-223c-08d961147476
X-MS-TrafficTypeDiagnostic: BY5PR10MB3761:
X-Microsoft-Antispam-PRVS: <BY5PR10MB37611A3ECF6C49E2F802D2C4E2FE9@BY5PR10MB3761.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40YKOs29TfocdDuv9388zf5ow3EgqzL/4jvc/ygC8ATYziwZ8bnwtMvogs1Pyj/48I+HHmGJLOlf3y6bKkSsoMBhTT5SB8/ZNK6YlApBGdbYR9zVE1KLSx3lJZcgxgS2FZDSS57Frq/ousKR06Qlrws3D9lJoSktK776UegqnBUP3UbMxvkNqV2WvqSjUphDLh3kFIWXjZRWa0JbRpMz9GHRiDb/4zJ5oGkdL0Q7WuWG+cVe6cb8O7/pib88WZGSJ3mu+sb0vfobAog3oX8EwDZd0H0wBUT/q3xF7Kg9VDNmsMIcCGdNFXXyJ+ZGBhFv0zoavV0AwGMuSmocThNRCgO+ONULLk/n6DynHQHjKlnaRRBgzCUspq94be/ourl2gS4rFkph5f983BpuRMVkpTgY6XUGVA5YFoXig/mIjYfc/cHHZwZ1jEQKa5OZCb7oLgDCoL/Ur5WwYNoR3L422yHIDOEGZJpgZo68ET6IMHiuHHCoZ/meTo14KMXRw+6pov+8MZ5yQtpoDcq67zg3KkZHPrEsUP9Z+BVFEV0+SgemwOO3ENXygdMxNjl/+CvphvwxjdS1bJht7mhRpbO1071/cR4xBf1DxCyUYNKtcm8eTnctGoQ/HBd4QmClhaCJzDZJ3OxVMHMzxqQs3n45QUFxv4rDZgNEWweklme3FbcpihQCJ4j+FCePecHEj2Qn1D0xJoZ/1FPhNIV43GX22qmTdZ3TscuNEnmypQV2G2oGsQUYly50jd2O+aRsYMwhnd13tlW48YjBIQa7J6qImA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(38350700002)(38100700002)(6486002)(6916009)(478600001)(7416002)(26005)(36756003)(8936002)(8676002)(2906002)(5660300002)(53546011)(54906003)(31686004)(66946007)(66476007)(316002)(86362001)(52116002)(44832011)(4326008)(83380400001)(956004)(186003)(2616005)(66556008)(16576012)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykl1M2Z6Q21lTGNzR2I1TGQxNFQ4Ny9yczg4RE52K0d2bnZBTmcxR0xCVmIv?=
 =?utf-8?B?b0d4WTlDZmw4SnB3Y2wyTDNzcjdJcmJuaGEyTkttdXV2RldHRStsMk9Hazdu?=
 =?utf-8?B?bE9vNDNYeWtkUGhmaVB4OEMxOTFKdkhZVGVUNTdWUkRRWG5CamdDSm9pYkUr?=
 =?utf-8?B?R3k3TDVTdTVxbE9MOCt4SEdJWWNsRk9ZMTlweGtqTERBWXlKemNFSkxtYjNU?=
 =?utf-8?B?VHNuYW1kekh3QVVvZkxGUit6UWxDNUdZVVFLOWlFekJ1R3VWUFFQUGlocVhB?=
 =?utf-8?B?d0VqUVpUeS8rVGU1N3pyRVFjVHFmdHpZVmRjSzFtM2s2WHFQSmR2ZnYvU0dM?=
 =?utf-8?B?MXZaZDUzdlRGbmlhU3pzUnpGTytxUzBGMXFzQ0I0V1JEeXkrbjJhMWNGdEZi?=
 =?utf-8?B?bWtQSHNETXgrQmlMZ0xKRHBoYlJuamhWREFlMU52cVRlWVduWnhqUXFXLzVa?=
 =?utf-8?B?TS91cUlTd3hDVWpvcTZjTXdodHp5d29jRHQxUnUxKyttYmlqL3BsRjBUUy9B?=
 =?utf-8?B?alFiWjBPd092Mmp5Z2R6U2JpUXZNWGViMnlpNmtiaVVKUDNLSnBPdUdNRW1Z?=
 =?utf-8?B?ZVpSQktpOTNCUHBtL2JLTXhabE9PRHdsTU9XVnVHOEZtRVE5YTdyUENwNUFa?=
 =?utf-8?B?VGJIQWthT3BwOGFJQVZlOTBCdktzVTNnVWxCbWpjaTVvV1pZaHBCTUhEeFM4?=
 =?utf-8?B?N2ptNGY1b1ZYbG9RdEpSMnRIMjRabFZ4dmVSL3lESWZQWkt1aGpPWDFianQ0?=
 =?utf-8?B?ZFJGOTBXU21tTWdRalF4MUZiTEdCRFlIcUhDK3gxejZ3WE8waGJoZ3JiSnJE?=
 =?utf-8?B?bzIzbTJaVGJrem9VQjBBTDg5b1BWOHpIWTVjak9GaVBCNXhyVjMvcEk4NW93?=
 =?utf-8?B?ZUpKZld2ZVFKSjVaR0JPUzdESzMrcVFuRkdHMjBpTC9mVDJoY0g2c0JoZVBh?=
 =?utf-8?B?NThNNTh1dWhqdXhVTHZ2Z3lDK3U3RnlsUlFMTFc0Ymx0eExlSCtxV1Z1dlND?=
 =?utf-8?B?Y3NyUW1UeEFXYXlUVWwwQndsbks3dXhxYWFCejNNczNBS2R5QkNQclE0ZjV5?=
 =?utf-8?B?a3VJMEE4Ykp0TThnZ0JUVVRmTEdKTzdValdCNklWUWE1ODBRTHVtMk1kWFVj?=
 =?utf-8?B?S24zb1ZTS2xLN2plOGRnTGx6dUtHNUJCLzYyTDBXZWh6bmxWWm1qUGZlTDNQ?=
 =?utf-8?B?M2NHbzZmeXB4TVR3VFJQa0NHZm1lclZuN3FHV3crU2NLTitzTCtmWGZOcXNq?=
 =?utf-8?B?R1dQb0NNS1lqRW9kUmNLbnRPVkRXMXpPN3E4Z1dEMWR6dlAxZ3FHVFNaUXcy?=
 =?utf-8?B?Q1lFaWk2QVVZT0JkUkQ0VmtLWUh6YXpRTzZmQlZtK2NURXM1VysvNTBwZmd3?=
 =?utf-8?B?d2FHZTg3Sk94YTVkUVptVUpocDJiWWNQN2orWWtLdStEWjZiNzVGYWlHaytl?=
 =?utf-8?B?ZTNkOUI2R0s5TEVWL1J5MkNaci8xRnI4ZU1MZVBqVm5XT2pGTjJ0Vm5Lc3kw?=
 =?utf-8?B?djhOR2Z0VUdWUFRBUnFETGlxaWUzeHlSb0h6RUpES3Vjem9mSlQ0d0trU1JF?=
 =?utf-8?B?MUplNUgzK0F1QnlhSUhkRlRWcDloRlZ4YXEyUk9mSG13QXdxUTExR2Y0cGNJ?=
 =?utf-8?B?TDloZlhXSFRIMkdMcWNDWGtCNzZ6NWt3dmI4RXIrTUF6UURQY3FRZ1dQVHdE?=
 =?utf-8?B?NzZUUDFyRGE4cGx0VTBYQzJBbW1QZnlnSEh4NkhMVUhIVnpFUlJhazBUcDRm?=
 =?utf-8?Q?3DzY9ewXBX7O4a9X9/lTEIImubWTaFO6ftuD9dw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ab225c-edac-486d-223c-08d961147476
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 00:17:53.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBoa8q1sutdy9/PzdVPxCbq32jm5bsdIL/cPpELggb2iEAtnKw54aNbc2xFrG404KUtxluaK7NqSLiL/Mb03ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3761
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170000
X-Proofpoint-GUID: ShfVsF9PMggU4FJXGzjLplMKYCgdlc2k
X-Proofpoint-ORIG-GUID: ShfVsF9PMggU4FJXGzjLplMKYCgdlc2k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 4:23 PM, Andrew Morton wrote:
> On Mon, 16 Aug 2021 15:49:45 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> This is a resend of PATCHes sent here [4].  There was some discussion
>> and interest when the RFC [5] was sent, but little after that.  The
>> resend is just a rebase of [4] to next-20210816 with a few typos in
>> commmit messages fixed.
>>
>> Original Cover Letter
>> ---------------------
>> The concurrent use of multiple hugetlb page sizes on a single system
>> is becoming more common.  One of the reasons is better TLB support for
>> gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
>> being used to back VMs in hosting environments.
>>
>> When using hugetlb pages to back VMs in such environments, it is
>> sometimes desirable to preallocate hugetlb pools.  This avoids the delay
>> and uncertainty of allocating hugetlb pages at VM startup.  In addition,
>> preallocating huge pages minimizes the issue of memory fragmentation that
>> increases the longer the system is up and running.
>>
>> In such environments, a combination of larger and smaller hugetlb pages
>> are preallocated in anticipation of backing VMs of various sizes.  Over
>> time, the preallocated pool of smaller hugetlb pages may become
>> depleted while larger hugetlb pages still remain.  In such situations,
>> it may be desirable to convert larger hugetlb pages to smaller hugetlb
>> pages.
>>
>> Converting larger to smaller hugetlb pages can be accomplished today by
>> first freeing the larger page to the buddy allocator and then allocating
>> the smaller pages.  However, there are two issues with this approach:
>> 1) This process can take quite some time, especially if allocation of
>>    the smaller pages is not immediate and requires migration/compaction.
>> 2) There is no guarantee that the total size of smaller pages allocated
>>    will match the size of the larger page which was freed.  This is
>>    because the area freed by the larger page could quickly be
>>    fragmented.
>>
>> To address these issues, introduce the concept of hugetlb page demotion.
>> Demotion provides a means of 'in place' splitting a hugetlb page to
>> pages of a smaller size.  For example, on x86 one 1G page can be
>> demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
>> - demote_size   Read only target page size for demotion
> 
> Should this be "write only"?  If not, I'm confused.
> 
> If "yes" then "write only" would be a misnomer - clearly this file is
> readable (looks at demote_size_show()).
> 

It is read only and is there mostly as information for the user.  When
they demote a page, this is the size to which the page will be demoted.

For example,
# pwd
/sys/kernel/mm/hugepages/hugepages-1048576kB
# cat demote_size
2048kB
# pwd
/sys/kernel/mm/hugepages/hugepages-2048kB
# cat demote_size
4kB

The "demote size" is not user configurable.  Although, that is
something brought up by Oscar previously.  I did not directly address
this in the RFC.  My bad.  However, I do not like the idea of making
demote_size writable/selectable.  My concern would be someone changing
the value and not resetting.  It certainly is something that can be done
with minor code changes.

>> - demote        Writable number of hugetlb pages to be demoted
> 
> So how does this interface work?  Write the target size to
> `demote_size', write the number of to-be-demoted larger pages to
> `demote' and then the operation happens?
> 
> If so, how does one select which size pages should be selected for
> the demotion?

The location in the sysfs directory tells you what size pages will be
demoted.  For example,

echo 5 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote

says to demote 5 1GB pages.

demote files are also in node specific directories so you can even pick
huge pages from a specific node.

echo 5 >
/sys/devices/system/node/node1/hugepages/hugepages-1048576kB/demote

> 
> And how does one know the operation has completed so the sysfs files
> can be reloaded for another operation?
> 

When the write to the file is complete, the operation has completed.
Not exactly sure what you mean by reloading the sysfs files for
another operation?

>> Only hugetlb pages which are free at the time of the request can be demoted.
>> Demotion does not add to the complexity surplus pages.  Demotion also honors
>> reserved huge pages.  Therefore, when a value is written to the sysfs demote
>> file, that value is only the maximum number of pages which will be demoted.
>> It is possible fewer will actually be demoted.
>>
>> If demote_size is PAGESIZE, demote will simply free pages to the buddy
>> allocator.
>>
>> Real world use cases
>> --------------------
>> There are groups today using hugetlb pages to back VMs on x86.  Their
>> use case is as described above.  They have experienced the issues with
>> performance and not necessarily getting the excepted number smaller huge
> 
> ("expected")

yes, will fix typo

> 
>> pages after free/allocate cycle.
>>
> 
> It seems odd to add the interfaces in patch 1 then document them in
> patch 5.  Why not add-and-document in a single patch?
> 

Yes, makes sense.  Will combine these.
-- 
Mike Kravetz
