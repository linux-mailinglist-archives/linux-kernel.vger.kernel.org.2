Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D305D3E952C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhHKP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:59:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54188 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232847AbhHKP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:59:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BFqvsf021933;
        Wed, 11 Aug 2021 15:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mov+pIiWYezlmZnjK10SpiDdJ8m1Tn7ox/O6EQSBwDc=;
 b=CDPsLsHiDbhqpnQ/jz3aDiUhYX6M4Vl5QsPVgvpSs6ZLo5riT54IXUdW08OjFPMNRMSa
 Q//IhIpYT8p7vwCt0bRVXOSBYtaqNunNhjNcFfQ7CnZhx84Vup/pO3Mr6B1/8kqSQ3xo
 YT8NuaAM+XXFm1Xr1T/WToNBDC6KqqrzLwTIM4MWlrT9f84JV513MxjyOTzjzWjZJF9g
 nbYH+ihkFI+USFc0pLYkap2C1DV/Ra/GuwYWMnvfN3e10KlrKPhZ913zJFtMxc/Fbsa5
 LCeGC25wUBFlzRGhl1mLsvViMngIOMGTmE1U0hFIhN6MRw6GXxMelaWohVVmkMV3o4qX +w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mov+pIiWYezlmZnjK10SpiDdJ8m1Tn7ox/O6EQSBwDc=;
 b=q7tlccZaGBhGngpgIKxXAcue2j26Vk+EEiCkDTcCbvKvUrdLfGbdGH8EUWiQVaB0+FRZ
 IW9lQoOjObedSJrzJ5bo90KDlTkclHMhqGfWbocgU1CXyyvo+d8Ebp2561JJagyjbxx3
 rvvudfDjKFicTeQKzju9E/y250vECGVbXTmQQvRGaTrS9bCpSbmP0UwSQLV0xHLQBe1S
 cE4iQC0W2ffxbnekSu3vf31pM1lhba89VUKuSJDTsK2745O5SmbayFmyDaRlnQ3koZ5d
 QNq3k/6BljHjUNERxMwTF1suBwHUnzU0oddESVSNW6IFvTwM2gGkXqyl4ZjCUwxzJ/ZG lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd648rfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 15:59:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BFuWqh104834;
        Wed, 11 Aug 2021 15:59:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3030.oracle.com with ESMTP id 3abx3vyx6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 15:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEGe9Yw/vyYuSvBwJTBBSQja+74lJC2d/DZyMNOBxRMJTbV42WkgEU0PhxSdhwSncEkbseXQuOSIDFriskfGzoYbUYNDPOjTqxEZQjx23FAOKnIhIQjbuOXn3ovY4En8ivhy0pADvCmuGO5QAvVIvdpVWos0L+t3/oQEJLT5DeHlAZl2tFVHuDVs/IhXvTeBJgxvLKtCBO5X4j4bdGQRjuxUhh/iQ1NnhPT3N8/D0t2XffkWhGm+sl292Mn2PNOKoqL1fisbAhik68GHd+e1h8Cgld0oLse+lWxJoXR6RYnMsAwdAmivGeCOStHdHaRye5oqx8DTz1+utz/hV3C0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mov+pIiWYezlmZnjK10SpiDdJ8m1Tn7ox/O6EQSBwDc=;
 b=PtRuSeHcCOBfTE338t6QJmpJs6r0+WhhYRui/u78mR902y32QofAPsnPnfxPqMhN1lvMpR1K4XarFg4V5HJS2w8H0cv0lNUqpB1ofn7GXY++mIHQJ7b2RK15LkLwaLpwzXqDBPSnS6sOWJthIra2xHe5FRhucSNJq8/zS/n4QziS26ypdIOjdbb8it+bFod/9yRY+IFFKQa4Hy7VZUwhMwXUrodWn7Nn8uEhmsibM8NevyenXcFoP8IIvHe4ujme9XxY9NERd39JDLXeXlZ2SvnZ4ObNKE8oR7DjGjgH0Oocar7M17VSipGjKQ2IdSywoRLQ/agLHs/hwtka9VSJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mov+pIiWYezlmZnjK10SpiDdJ8m1Tn7ox/O6EQSBwDc=;
 b=pZa0avA5mAjRS+jAOZioq1FxQ0m1TM4kJRrRRDvI9k6a4epRUBLuOf+o5dvr1locQLpH9mk+CeOh69I3GN4alxNCQzy7vMau2fa523bwc7Xs3pK2O8wnH/bmdRMC2E+K7dPDxurbtdlLyKGXm6IjOaa4X0mg2bQUkbYMhbpKBHo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5438.namprd10.prod.outlook.com (2603:10b6:a03:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 11 Aug
 2021 15:59:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 15:59:07 +0000
Subject: Re: Linux-next: crash in alloc_huge_page()
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com>
 <YRM+qm66PfTUQNFL@casper.infradead.org> <YRPaeQYHPwI9r5a/@linux.ibm.com>
 <8379f7d5-5d89-ac37-be83-aaa185dd6c3c@quicinc.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8f78bed9-a677-0e62-e517-ea82850c0bff@oracle.com>
Date:   Wed, 11 Aug 2021 08:59:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <8379f7d5-5d89-ac37-be83-aaa185dd6c3c@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR01CA0045.prod.exchangelabs.com (2603:10b6:300:101::31)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR01CA0045.prod.exchangelabs.com (2603:10b6:300:101::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Wed, 11 Aug 2021 15:59:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4aa6291-3054-4aab-99c0-08d95ce0f345
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5438:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5438589AAE53601D0D4B820CE2F89@SJ0PR10MB5438.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wmye6CybUw1TdN313jNMwVEL/SP6qy4xm+jt9hn4K4n6OcbEqH0lcayWbPkqG/pgaK9BQ3qRzpBSWrOqZtAXahL1L+epkwd802x/lxPoK64H2ZQOGCHqjS36ScnwoGK3Jrys5YnQuXYclmdLTBQqP/zy0+ZJZ9r1psAoqfkPN1wHaM5qVAS/BS/Xxe0zAPYAVYDf5LILRV3z+zxsKA6qxQpccMCVX0CaSdjOuyqdFqdAPr8YyNi7lS98vYbKx4eU98IpAN6rjwMIHjpDHFtLveUkURcSHJcJ3UMZ3cqYxMiUNIMxLveRlfkTBAn/Mb5w/SFWDPYcDmNe21t56ENVsFzNMioXijkqJU+S6jJKlIp68OHbJEm06y64wcaHgfw+Dj+4PEjuYMbAjqfhLffGZohxQ3yySnvrcJsb9be263u7oUfQirG1zw5q2jXM8AkC5PJDrCsTPn3zPaatYtlRgLkHie5u+VKyK/uzS2l67wRGSL2NDmrDpCc6GHJDmSgtW5dxeOk/BmHMJzVEQGws+4ezoXMdOJn7+KiIFrUjubwdBvylNmr+eHJX0G45L5Jo+J1v82/cpjQTvTZSxNEo8fHNX51NNNXCQ3XDOfmR5r3OhEv+HXRc4W7JV2TZ9pU9V7eJzYefNWRNqvM+j709iurx/c0zG3yjr4elE3E9OzzOyIVTTkr1Q15URef4jF9p57ER2CLUqyvJxp5cVePa1wgRwoK19h2ssO7aE7cCPH/KZrEacGtDnQBmTMgkWGZnGtaxlR6OgjixgXiH67PbQ8nRrkOYOzIOGb4qFhXm6neL8Ie/6eUn6sMlH4u9HN3t/fk4rTg7PY1O9UuU28M+jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6666004)(5660300002)(36756003)(2906002)(83380400001)(53546011)(54906003)(66556008)(66946007)(956004)(31696002)(26005)(8676002)(186003)(31686004)(6486002)(966005)(8936002)(2616005)(66476007)(508600001)(86362001)(38100700002)(38350700002)(52116002)(316002)(110136005)(16576012)(44832011)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2F6UnhTT0dnUkpUNVVwZVNrajh4alc4ZUF3cVByRHg5Y0FYVEtSdngzZ2xR?=
 =?utf-8?B?alJNYnJIS2YyNUJRelRWVm9FbEZ4VEFzS0pEWHBHcmRpSVJGOVpQdHJzQkw1?=
 =?utf-8?B?OVpONVI0V0NhZCtJVEdqemZ5eVoxNExoWXhpdWVQSGVRM3ZIcDVaWElkYkhJ?=
 =?utf-8?B?T2lIN2JoRXNoSmtYdEQrWm1JNGZoS3JjejNFZjFpTXVFVERrRmJwTGxmbXMw?=
 =?utf-8?B?WnhjQXBXRnVhQ1RJbGVNYmpmblNEUVk1cldudnRIYWhta2xuUjJROXpSSVAr?=
 =?utf-8?B?UXQ5UU00QTJGU0R6ZzNxOUM0VWFWRHdCYi9rWE5GVXkxYmR6TUt0dmVwZ1VI?=
 =?utf-8?B?RlI2ekJycUhIbVZCUDJ5Z09FQjNjMUROY0dWT1pSRVNFeERDUjZCa2FIS1BH?=
 =?utf-8?B?QzJCaUJPSC9yUjA5TExEV2ZqSVhnZUZyNTllampKQnlVY0xyQWd2SGhCY1BW?=
 =?utf-8?B?blZXT21oU1paNy9nUlRBTjBNb0orYzVOTTBhYnlEMkVaTnFZT0FVRWV0QkdQ?=
 =?utf-8?B?NnVJa3JqakJFOWZKamFyeWxrL25iTkVwaFlJZUZ1VTVHaWh4MWxXNGx6T2FB?=
 =?utf-8?B?S3V4L0FaQ2JjeVlETSsxbEZhaUtrT1Y1RWpIQWpMOWptSXQzZkNLUDNLMDk4?=
 =?utf-8?B?eEZkNFoyT0E3SVRFeXdaekVOVDBYMmVQSkZFYml6VnRvTjhZb3A1aERra2FG?=
 =?utf-8?B?TkF1OFE3L0FkRWM4WjlWRVdKaHVnLzJSMm5PT1RzMUNsUlVPdjJ4ZGM5RUxL?=
 =?utf-8?B?OE43SkhDYlBnV3dQL3U2WlordGRCQkh1eUQ5RUtweldTc0JldWRUak1UajJL?=
 =?utf-8?B?VllyQ1BIZURZK1phd1k1eCtKb3RPdE9YdXIyWm53MlJJSTdhQk4xUElpYU9z?=
 =?utf-8?B?cHFERXoxMFRNelk3cUJPY0ZLYmxuSWtpbmhIT25EVys2Nnl4d0Mvb3Zxc3ZN?=
 =?utf-8?B?SXl6NVovK0FQSlpaYnRxZ2FwTVhjVm9LVlAwVGFURWg5SjRvWkcxWXRrTFBl?=
 =?utf-8?B?S2p6aUFHNW1qajRCbktSYjJML01aTmM2eHJPVU1Udm5ZWngycW5MOFZVdEM3?=
 =?utf-8?B?dkFGbWtvNjhCeDBtdFpwR0V1R04wWk1lU0haSzllWVNFdTNmLzJhWHJFOUFw?=
 =?utf-8?B?dzRSYVd6cUxlakhLSitybGhnbldhKzkzUDNtcG4vZjU0Q1lvaFRLS251UU1S?=
 =?utf-8?B?aDJkdWpHaDRISHB0b1AvVmhqVkVPUXVtMWtlYVAzN2JJQldoYnpCbkpJQnlZ?=
 =?utf-8?B?cEI0emc2L0xSd2NrY05mQTZKZTBRTlpIVjRhblNqbkhpdHQ0TzBiM1lNdXg1?=
 =?utf-8?B?SnVZdDZZcGJ5ZUtnSGg1aU1CV1Q0RW51NlFTVGZ3eHYxQ1VkSkFGNWk3QkZ0?=
 =?utf-8?B?Q2ViMWVBYW9zQkdURXZLQkVvSmYyNUF1NGllS0RQZHRqN1R4bEhIeEpCcjND?=
 =?utf-8?B?bHczOUZ2T2dhWFZZS1hoN216eVZOV2JPWjZXNVBZUmsrdXdtM2tldUF3VDhQ?=
 =?utf-8?B?cnRGbjVwQTg0M3dzcWZveTNLQ1BrL08wYWIreFdOYTdpKzQwZDk3SGZzNU81?=
 =?utf-8?B?T0xPTG5UdXJ1L3g1QW9OUHl6QzRJczRQUit3L0I5UGxSMmJZTjhVUEUvY01J?=
 =?utf-8?B?STRqZVF2S1F1Ylh4VjdNcVJ5TlhaaXlTS3RERE15Tkt6Q1VVK2s5emUzSnFl?=
 =?utf-8?B?MWdVeEsyOStTc1J6UmtBYzBlL2FHNnRlVlRoNE54OGhmemwzc0xUVDlia25E?=
 =?utf-8?Q?skqatWnMlh/h/Ds0oVxtcKKeREU2opp649F6AjW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aa6291-3054-4aab-99c0-08d95ce0f345
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 15:59:07.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv28jjb6f8yW8nSNUl7VVtS4L0hqne/k0GCmnYaDdjR55VsR/95gwfmZVNaSYrDyTlBKhidipesxKBAF+H23mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5438
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110107
X-Proofpoint-GUID: UAm0jjtDao2YcAtNe66QmHPeJNHgm1jE
X-Proofpoint-ORIG-GUID: UAm0jjtDao2YcAtNe66QmHPeJNHgm1jE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 7:25 AM, Qian Cai wrote:
> On 8/11/2021 10:11 AM, Mike Rapoport wrote:
>> On Wed, Aug 11, 2021 at 04:06:18AM +0100, Matthew Wilcox wrote:
>>> On Tue, Aug 10, 2021 at 10:22:37PM -0400, Qian Cai wrote:
>>>> and the page->lru has an address fffffffffffffffc for some reasons. Does it sound like some error code
>>>> had not been handled properly and had been propagated here instead? I tried reverting a few recent
>>>> commits for mm/hugetlb.c and mm/memblock.c without luck so far.
>>>
>>> Yes, ff..fc is going to be at offset 8 from the actual address, so
>>> that's -12 and -12 is ...
>>>
>>> #define ENOMEM          12      /* Out of memory */
>>>
>>> so something's returning ERR_PTR(-ENOMEM) instead of NULL.
>>
>> page is not initialized in alloc_buddy_huge_page_with_mpol() and after
>> commit 2cfa8b23744f ("mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix") we have 
> 
> Good catch, Mike! Pretty sure I missed to test that commit thought that was an old commit along
> with the rest of the mpol_preferred series.
> 
> It is a dream that one day mm tree could like other subsystem trees where "git tag --contains"
> would work to indicate which linux-next tags contains a particular commit to tell the timeline
> of it. Right now, we have those commits ID always changed and commit date is meaningless for
> mm commits in linux-next.
> 
>> This should fix it:
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 008662083fec..6337697f7ee4 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2152,7 +2152,7 @@ static
>>  struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>>  		struct vm_area_struct *vma, unsigned long addr)
>>  {
>> -	struct page *page;
>> +	struct page *page = NULL;
>>  	struct mempolicy *mpol;
>>  	gfp_t gfp_mask = htlb_alloc_mask(h);
>>  	int nid;
>>  
>>

Thanks everyone!

Looks like clang already found this.  Andrew added this to his tree
yesterday:

https://lkml.kernel.org/r/20210810200632.3812797-1-nathan@kernel.org

-- 
Mike Kravetz
