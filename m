Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56B03EF019
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhHQQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:20:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4046 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhHQQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:20:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HGGGD4005460;
        Tue, 17 Aug 2021 16:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c/pu/vww8ZxT++OFFg+83nzTvpD4Hz83Du42Uawz49Y=;
 b=aaV10jek3tssviJlwq+u8OZLdZZJ8dJsYIL4op/2SUSCuKzHo2NOtu6cG15q99u2diiV
 3b5dluTE6P/ogJDtqff5hnGg4HNHJIfui8krjO9Zyk0WQs05jL7f5W2EGAYNcx8yRkc4
 tF9usUwDGa93PN66DrTZDOyfvRddmX2NW69HFij5mUm74ik9BnoUo8nEXmyIzD3fifVI
 Amsgh+uQ2ry15idFzukfXxE+9V9Wp+GGFfa/jjnfJdy0/1s95hr1/wTolz9C8kRo86h0
 yHsdhQ5GNw9svxdXezIvndorxmZZQ7+ID8t8WKHCdKpz5Y1nrUzDE451JQHDV6tD3Oma JA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=c/pu/vww8ZxT++OFFg+83nzTvpD4Hz83Du42Uawz49Y=;
 b=FvL0RXo8m5MMd1kLE4OT8WEudD8QqXpuJr9QzkQDyjMCF6QVjQU5IDkND9yfQxWMW9Lz
 CWPDWIY2k9D+xTX2WFaLKAwU38LeCLwXMZ4a1qgqc5J54xrCg8V5R/1p5f24/ViN4U5o
 /19JaTHbxn1LAsiaQtvdXK+pewvD2pyt0GZ6fkLuruTC19FQbgVejiUBmYor3MSgoz2u
 ncPPKVNyXDZISre+PdzwNGKt/F0SQE6VfiZXDAm2nkzArqVpq7igpncuhO9//gzMPrKO
 P0U4BvPITNl/e8Ef7B+3BenMC4dhjzTzM0T9ROXG10JLfYGuKQPZrd2AUnkwdQjvIYEk mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgmbuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 16:19:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HGEl1u071506;
        Tue, 17 Aug 2021 16:19:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3ae5n7up7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 16:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvPtvy6zCZzN3Wkgtr37cM44g4pY7HmRBoCbwKe4ZQtkGDrsysHHGGiqxLzji9SW0SRlGWqGXmcFxttn9mKKE8FjRcBT43AJjVCxAjxRiUSpmbKdp2AALLWUZyZQy8gtQxXIa2vHVzV1H0hZls8C6hzI74myv87PVUlz2O85HK3qI/uCGj+pSwRaOOmzlHJSmy1tgBGeC/BBX6omX01kW35HVmWFuuG8pTjqBpFtMpIcD7ThgX107o2ZurECLZDzbJBDPDaHRExR9habvs8dAkkKsJc+Os1eYPgvN77DUyIp40v5SxfLyCFf/4WijhWhWjR5sdLbZ9ng9HmPiVVzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/pu/vww8ZxT++OFFg+83nzTvpD4Hz83Du42Uawz49Y=;
 b=jGmkp+mnSVM+pPpc1ER9kXNXkmg54VYECQ6tzXPKhCNnoCe3HcBBENBrnLNFKySrOY/ixrjGb/YNGXKR50BSbWaKJhDyTE7whUYgniMmEUYrkC3JBzWjYKhYcHu5CBu3eyEOQgH06jluNVRdMZbmy/uuhPCy//m1RKBQSTMp3QonxQOuH2H1XN7o71nQuI7xmViv1xEwwj3ePHMyPsNkHXUP6IgSX6We+ctf888Qxbk7vuPipmZncLqyH51tNhO4FGBOOB4lOYnwafVGyUDjRr3OKvt+LJ/qAOo2jLnOzpa1ccN2vS4deHite60MFRD0yHoQdFgOKIeKzYcrhly4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/pu/vww8ZxT++OFFg+83nzTvpD4Hz83Du42Uawz49Y=;
 b=s/rwIfEGnI9+p+6iZNCh+gi4PYhfeUghP3RWZt+B26KDpPOKEH/zgoPwsBB4qD2Thqfv/LtZeLv4Kh6vf9TddEtmo5aOt7LAyMR+WFYbMHjv+42bl4plkhezoHoJSRnYn0MWdwS74sAnjdtiTxXLKmQmMuqv1WiLcO8Tbivx7E4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 17 Aug
 2021 16:19:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 16:19:25 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <f19bfed3-be85-114b-7a8e-72bef58cb74f@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b4799d79-7966-90ad-72d9-97e9deeec6da@oracle.com>
Date:   Tue, 17 Aug 2021 09:19:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <f19bfed3-be85-114b-7a8e-72bef58cb74f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0050.namprd10.prod.outlook.com
 (2603:10b6:300:2c::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR10CA0050.namprd10.prod.outlook.com (2603:10b6:300:2c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 16:19:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790df897-d0a3-409d-68fe-08d9619ac7b2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB55504122083D4D10C2037A31E2FE9@SJ0PR10MB5550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWot+NLySsJM7TjDRt6R+PDX7V9dykQNdOY5mtTfg72FuagJ5QKdISDboSFFtxRjsh/sL/e8Gure5XEjQy33GYAKif+4DJtNeOZiYJeaLxZfjZHUIi8RLXc9HvwWWD5X85st9hh8WZUOTVzYmNJ+61CGQX5E3zQTBJaagV6LNcDZlTtInCfjejUHmMO1sA8ivbPbGjfSFf82G1rp1UCe/2RCT/+2RPA0uMU0Wqhek4ev/8NhRMcFhRfkhl8QmWBX2zAY2GLem3Ug6Dr7Gx4GEB+UsocenkhECGcG2bNFX65Ai3Odl9MIApGvacbp/uOUCWuRwVELJ9o5kGp3gxcVZzRmBahtuIyJAcGkI+M49c4bFjXY9atxEUYseWucL0yb0wqBRbxNxt1W8COzM+mVOPT/725Y2EQwLFXbKrhrcfWcHaf24mN+aAE0azEigJIPniwGJlKbDu87zbcZ8uQ6vJeeC1zrCbF7PbShdTt7K9Maa8262uHRIKgdEt65ejidD81KXJPTiXi0E6WYdFYlFZw3M4cuFobtvbH8g0kdJQKYhGdmmW2BCojJmjwYHg+EwqBV4EshPQRbpMVYa4NPbVv8xbSqL7gZJjixkhoAYQIfvVST/mAe7aye4UKXo/esqnEvWqeNdU73bm0Zw+UcXPFm9Zfc5Uewiddx0LS8DIJfuvjFIomCEuEUdJZ2Q4YzZ5IP8dP/xwUdYnqAUFRmW/b7PufgUzaSyAr5oorR7sBCLnb6gED3SzFUfc94lYsO2AHDyJWVAP0XE7dCtNf6KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(31696002)(83380400001)(31686004)(38100700002)(66476007)(38350700002)(44832011)(66946007)(66556008)(316002)(6486002)(2906002)(2616005)(16576012)(7416002)(110136005)(8936002)(52116002)(54906003)(956004)(8676002)(508600001)(26005)(53546011)(86362001)(186003)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFjZXJNVjRSN2drMW41b0NjTXlyZ3hxTUNXUmNuNzJnbUFVYmxoWG5BMzUy?=
 =?utf-8?B?dUE1d3Z1WkU5dFVUUTFyMnozclc1UkhQV1hWc2JYbXBKR1hUTkh3alJxZUp5?=
 =?utf-8?B?ZUxscnJkdFJnK0lSem9rcmRRRGtYTUc1UkhNRTNxWEJuTzdMbWppUy9WYnQ2?=
 =?utf-8?B?KzU5SEhaVkRkV3I4R043TnliVktWWVFDU1hhMTlORDZtMSs3RElDS1NTL0xK?=
 =?utf-8?B?VW5UaGdYOUlYbXpKYTNWUUxCOGpRN29GWTRZTnhPZXc4T3l0SmswTlBMNTN3?=
 =?utf-8?B?eG1yeUxyRS91dHpDNXpPTUpEaDlvd2hRb1BsZHV6MjQ5MW1EOWdXcXJUQUFs?=
 =?utf-8?B?OCsxVjQvYzRWMldhZTF3K1ZySDZNZm5BMU4wMHVHejFoSnVxbVU4cUtwYWl4?=
 =?utf-8?B?L0dUYm84OTA2b0tOUHBBREVSZ1JXdnNNcW5YZVJSMnZXRVh4dWxGTEczdDdJ?=
 =?utf-8?B?WDJIb0w0N0s4YUkyTkxpMVhMSUxJT2hIRXhlblFsODlwVnFiWFNJNUxyYTRN?=
 =?utf-8?B?WEp3aXdpWVB3NXdGVlRQcStzeDJJUk40blNBb2N3KzBzWDBRK1o2dldyaUgv?=
 =?utf-8?B?N1RacjlUZSt4S0xyWm83YTU3UG81SzFINDhvRmJ6a0pKVGtGMnEwWm1ET2Vp?=
 =?utf-8?B?eG9aMmwwcktiNWRvOEQxL0x3KzFTY0F3MmIwMllPWE80Ym5wbUtjajVLL1lG?=
 =?utf-8?B?dnM4QkpyMDN1NGlFZWhxaFM5SkMrR0xpdHdWM01PYUVEbFQ5L3dhTGxZMWdo?=
 =?utf-8?B?QjhYUkhCRm51R2xYSWRZMjlOMUlYZXFtbHlNZDdqZFhxYzhJUGJXWi9SSERl?=
 =?utf-8?B?V01FY0xlMThrUS9DUkpwMVc0NnRLa1dVQU1ZeGFEcFg2YWJ3aGN2U3k3blVK?=
 =?utf-8?B?SXlob21IR0tuZE5NQ0pJcGlMSyt6Nk95MXpVY21ya0w4K2JHdEVzeFNnRlR1?=
 =?utf-8?B?YWdRNzBCalY5UFJET3dFOXhrL3gyQkNxZDNzUVpJeVRYcTJKTXpTMWVaeU51?=
 =?utf-8?B?OGNYOHBKcWtEd0w2c2FRbjZCVTMyTHNaWVk0QUxnNmlVcVQzYklsSWFYbWlu?=
 =?utf-8?B?a08vRWtwZFVHcTVSTzBVelE3U3NPaC90ck1WSFBkNDRoN0NsTlFROEZuanBz?=
 =?utf-8?B?YnhvTC9WQkw0SEo3amFMTFR4dC9mYktYSmJCeDU5Z2cxV3h1elpKSE9rNktZ?=
 =?utf-8?B?UzcxdTdueHpKQVFVUDhTdWRCQjJHdEJ2Q2k2cDduYzAyZFk3bUVWeHlxUFBz?=
 =?utf-8?B?OVkxQkdNdmp2c2pWY2MvSEliLzFuV252QStSQjFMUVU4UFJhakhCbFltOEZO?=
 =?utf-8?B?Z0had3k0RFFOM3hlMG41ckFpL1hKcDdkTEljMjcvUEZJNFNGSXRUd3JXQjF0?=
 =?utf-8?B?dUQ5bU1HME9UanlXbGV3SUJVRjljL09ETmtuU2tNSkt4ZEhKVDU2VGdQWEpC?=
 =?utf-8?B?YVFCbEt0aks5TWRicGZUMDVnbGpIeEtyWHY4U3ZPelh4TnBPeVpvNDdLWEFU?=
 =?utf-8?B?bzJHQ2I3aysxdWlkS1dYTVQ0dDVSZWtKb2hZYTV1ZVdudHZxNSs2RUJCb2lQ?=
 =?utf-8?B?cFZBb0E4UCtVUTFsN2FaS1hDdnQrTzRVdjlOZGJuR3ZzdEdKbXJGSDFnRWNY?=
 =?utf-8?B?KzBPUytjS1BpOFNwaHliMDM2NTRwUzVPSkcweE9uRDdQVkszV1dQR3Evb2tr?=
 =?utf-8?B?SjQyZ0hJbWtpSjE0UmNZcjl3bFFncmlwN1U2b0tBbkdnNkNvWE4wNFlZbG5K?=
 =?utf-8?Q?YUsqyFGYlCCN3I5ClKIXSCoEb/yDud5ZjirPDID?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790df897-d0a3-409d-68fe-08d9619ac7b2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 16:19:25.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUCKH3kzSvObWH9pw0Ab+L1N5KqMSrUFszvX0dPrCBe4/UxQeiDOA4pQx8ZMWjQRwpTHjsRpr9HOlT5dnhkIMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5550
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170101
X-Proofpoint-GUID: 1k2Vu_RkHQwix7Oje-tAhj0wOmwXNygp
X-Proofpoint-ORIG-GUID: 1k2Vu_RkHQwix7Oje-tAhj0wOmwXNygp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 12:30 AM, David Hildenbrand wrote:
> On 17.08.21 03:46, Andrew Morton wrote:
>> On Mon, 16 Aug 2021 17:46:58 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>>>> It really is a ton of new code.  I think we're owed much more detail
>>>> about the problem than the above.  To be confident that all this
>>>> material is truly justified?
>>>
>>> The desired functionality for this specific use case is to simply
>>> convert a 1G huegtlb page to 512 2MB hugetlb pages.  As mentioned
>>>
>>> "Converting larger to smaller hugetlb pages can be accomplished today by
>>>   first freeing the larger page to the buddy allocator and then allocating
>>>   the smaller pages.  However, there are two issues with this approach:
>>>   1) This process can take quite some time, especially if allocation of
>>>      the smaller pages is not immediate and requires migration/compaction.
>>>   2) There is no guarantee that the total size of smaller pages allocated
>>>      will match the size of the larger page which was freed.  This is
>>>      because the area freed by the larger page could quickly be
>>>      fragmented."
>>>
>>> These two issues have been experienced in practice.
>>
>> Well the first issue is quantifiable.  What is "some time"?  If it's
>> people trying to get a 5% speedup on a rare operation because hey,
>> bugging the kernel developers doesn't cost me anything then perhaps we
>> have better things to be doing.
>>
>> And the second problem would benefit from some words to help us
>> understand how much real-world hurt this causes, and how frequently.
>> And let's understand what the userspace workarounds look like, etc.
>>
>>> A big chunk of the code changes (aprox 50%) is for the vmemmap
>>> optimizations.  This is also the most complex part of the changes.
>>> I added the code as interaction with vmemmap reduction was discussed
>>> during the RFC.  It is only a performance enhancement and honestly
>>> may not be worth the cost/risk.  I will get some numbers to measure
>>> the actual benefit.
> 
> If it really makes that much of a difference code/complexity wise, would it make sense to just limit denote functionality to the !vmemmap case for now?
> 

Handling vmemmap optimized huge pages is not that big of a deal.  We
just use the existing functionality to populate vmemmap for the page
being demoted, and free vmemmap for resulting pages of demoted size.

This obviously is not 'optimal' for demote as we will allocate more
vmemmap pages than needed and then free the excess pages.  The complex
part is not over allocating vmemmap and only sparsely populating vmemmap
for the target pages of demote size.  This is all done in patches 6-8.
I am happy to drop these patches for now.  The are the most complex (and
ugly) of this series.  As mentioned, they do not provide any additional
functionality.
-- 
Mike Kravetz
