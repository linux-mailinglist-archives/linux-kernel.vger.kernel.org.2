Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6F3FA1B2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhH0XGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:06:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55118 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232252AbhH0XGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:06:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RKRAkd002294;
        Fri, 27 Aug 2021 23:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iqSadRkYdAcfI7qI/FZEiPXWEAQTs6J9CAj0GSoSEkw=;
 b=RqUDOlnsyxk32J+5wU3ojdm9DSsUPRUc6HVKwpFGrJILRcZ1n3/1yuoHDVXxbS/Cmo6v
 N3ITf1pBXEmj+psvSDyktnyA50tc4xukEn5jGqp7PV2+12EGmuS4B34zUD9y/1//XrJz
 QERITcF+FoU0eEM4pcHxdw5deVR0JRNQxafUWllmucaU1R2hPUcl+TQ8rHSo6mB8jz5K
 Ru2ymofT91FSZSUI4D60kNXVgConxIitzE6Xo25Yq4fRvvVv9162JelAdaZdXygHE+Qf
 w25Y/ygx+1MU5xUjdocaShRPOPWbmk+FwUI7JNhiZqtA4p9v+cEeyimNzjeuMXA6xTW0 mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iqSadRkYdAcfI7qI/FZEiPXWEAQTs6J9CAj0GSoSEkw=;
 b=Zd/ce28hsfIjv0g/ii9vktElabr5O+YUyqgAeUhYKLJi87UYB4GsDP9tPJsJtlmGS+Tu
 jsWirm5zh2a9jiYQt/y4x8IuN5pSoUNMr04No23XziYyGXhQdY6NaQ4dbKW68Ndu8RYL
 jfPOmgPjol+UjQqAJuq4YGUhwyLxbhmW/u/7EQ75HE6kA0stkg2FqIooRd/YW91Jiabj
 ABL3EYI/YdEVpQP3ewyxzo/KTBetQiM5ijD5935z3BmmTlJFtmSkuvxskIVgklSjdPCQ
 nke3ROIMVdikmcI6ZBgnhtj9+Pcy0UQkENECpn8DvtNlqNvsSczkoxHhdsPE3yrES7DD 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3apvjr1rs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 23:04:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RMtOTK071728;
        Fri, 27 Aug 2021 23:04:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3020.oracle.com with ESMTP id 3aq5yy8jbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 23:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoKBpvcHU4ug+kO75gEi8I/5AV//PRsKOC5LduxpS14QzA/t/Q4uhiU9WFawUK41Cx7tQaj19vXDL/Ev5gLrnusZ+s59I46MnWr0sXhkkyDtFbVoQ7CZr3MuQzaOL1atyThxHZQp/rvkza/1YiMAIdmZm6pPxhIDnbUgek4CFO8R5qg0vDPdlosry5idu2nM4PS6U5Idfb8p8BW67tB0EG3eyX5Xhad4s9aSZosYNE1A+ITQxA7FcY6RJl6tsdnPAcupqYry+GaYziF6jKAV6V2IupRGftfktT3sc23fPuAuiSie3+xRzppRg3ZmUfUW3D1SD1VGFE7l/8patfKgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqSadRkYdAcfI7qI/FZEiPXWEAQTs6J9CAj0GSoSEkw=;
 b=ZtocbzRZuT7a4Fvkz37ALGRpAmfOgawRxOgqADs3aeZcTPKm/xySbyu2hoaV3x63ObyXTGze5GDAKp1+Ep0ijnoJ4Hjq0tGQyYbnJ4bGDZDg250wg0BcP2wnFhUlzSObelIssKKZ8Dvtag988Lc40DbTsChJ4ha1NmeevlBd1cLVwu0si/wnoRRmDfMq4lrdr1DOd+k75xENU9YYLoVOFu2c5gLXlkhO8RwUd29lrns/FeSIpDTR00Ci0L1BinYhOR17Q5XQ88Ca2dVfg33SSmERLjd7QNT5fI6WABO7Kd/rqQdUz58hjF1jgusyZjbT7N9hwRYybH/VaFAynYgwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqSadRkYdAcfI7qI/FZEiPXWEAQTs6J9CAj0GSoSEkw=;
 b=yaIf3dXoA6DOjYMpd8+n3yshIcox/K1XNZgcivVm/ji73VXkyRnULQ3nnwW65vr4dkAMqnnD0fNkr9n6RhcjnWKmSLdimGDTngxDhCmyAoq5Celyuxx3LCXyArd6F89zrE3jKF1RoFjCJ6ewttJilRyKypId6znpDvUmn3nCgNU=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2744.namprd10.prod.outlook.com (2603:10b6:a02:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 23:04:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Fri, 27 Aug 2021
 23:04:50 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Hillf Danton <hdanton@sina.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
Date:   Fri, 27 Aug 2021 16:04:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0106.namprd15.prod.outlook.com
 (2603:10b6:101:21::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by CO1PR15CA0106.namprd15.prod.outlook.com (2603:10b6:101:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 23:04:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f6c9e6a-6028-4fcb-4d08-08d969af128c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2744:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2744C4EC966D2B7A0EA9B367E2C89@BYAPR10MB2744.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvjArCr5yK9bFV1VYMvamdS94lsZ49LGZO/U426QVD9GjyB3h7TOiagItBjOjuOpjuLTpIvM7S0c8WRkCGoACLYnqgssUdadfYL8dDCrY1+Mq5W3nktEOzU8118hSUSsQ62Qg8Ups2eT2jXnW7016l76MXrxrrfUlDMrc4Ox889G1ryJIqQqWCeEYLEpfFAhq6EnwOZK8USfzyKUR4SwcV1BpgzTX+RgbckzJ7skyQuyj9MtbxpUUvo7XhR6X8Ku72yMohE0bTjM6CJRzeA/nRaDAAt5wSipBcnuWVKdr8h1Ywd6qhT3+p5iQLXVoiIf90zGRSM0DI2HJnkWR9L9dt3IFh4Mw6ZXyWy2P4NiEt+HZWWmOwpep/GcQWClyCZeglHtd2cW9fAiSfvPHEAy/itbE/4cgRZALa2I5P9U4tLPirBVmnqXb/OcusIKjoPJal1EP/MUvq3KWISKTl4wkPAscBR91wu0gou7tRa2D6UY/xW0hxAfTwc3LiC36mcV35SEpRdaW+xiYG7D49H++p2STOiJfdw/00LfFPz1fjiEWMJdYO8ex/cZAuSDV0F3JcPvqCXBrl5VcGT1hgkhrf6YkTXFlk44uhaJ5yWT0H5fInGqVDxqniNKCIY2+frLdZ+/QWWH3nq5o6QvqpnVGvToAVUTaCP1YXph/Dv5yeo6gvVmHa4Bxwsx6ub4WQ1NN8LcA0uuGSgYjYOCs1uHsHybqJSvpe14MkxmEatC21EcotSKah26uc2wCWcIeGECGiaO9qEpb8XtuVy/n6wnP6B7y7z2JeyTTgHa0yKW3fcrbcGRYViWh6nbE1PW/6Fs0i9BSgIPIydiFiFwmLqGqIFBTqKl4TGAkZLb/hDUcyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(136003)(39860400002)(16576012)(31696002)(8676002)(66946007)(316002)(956004)(2906002)(966005)(31686004)(44832011)(110136005)(66556008)(5660300002)(8936002)(66476007)(52116002)(7416002)(86362001)(54906003)(26005)(83380400001)(186003)(38100700002)(6486002)(53546011)(2616005)(36756003)(4326008)(38350700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FiQm1yT3Q5MFUwZWpDVFgzY1NneVZLQ0FNVzFtKzhENUNqRTIvRk1iMDY2?=
 =?utf-8?B?UkJGbEJaM0U2U21FTDJoKy9Mb3ZmaGtCeWRra0lqalRyMmFMUElGc2w5NkR2?=
 =?utf-8?B?Ulkya09SSkl1d0dsRXIyeTE2bjJubU5KVGRmeGNiamlxL2RlUVdvWkNtZ1hS?=
 =?utf-8?B?ZC9LYXEwYkt3ZTdnRlEzZm5EMmdDcDlaMklnWHhsTE5JK3VNWk9TQTlnWEJ0?=
 =?utf-8?B?UUxUTDk3d3ZyUTlTbFlFeTltVTBSWUx6VWZsMmdFOUdTb3R6dzI2L3pscS9l?=
 =?utf-8?B?NHlNeU1iK2F4TC9ZdDM1S3JlNk9JZWpGL00zcXpVQXJTUUVRcW9MNGlpenB5?=
 =?utf-8?B?YzhPcXdZNGJSYmxVcmJzNDF6MUlxZ002eGNMRUZ1UDg2UzBreG1YaUdSaXR4?=
 =?utf-8?B?K0pIRUdvbW1iZEJGd0VIOWc5aElZZE85U3AremtYa05vL2U2TG9sS21TYWZa?=
 =?utf-8?B?MmplZ3pTTW9XUFJGd3JvbzgrWE15Z1FVdXdPblRGU1Y0cmlqdFRzTXlJUExH?=
 =?utf-8?B?UVlpc2pFTlBzVGpWUlVMa0ZudTB0bEM5N0o1cFJwVUVyLzVUSGlPYzJPYzVz?=
 =?utf-8?B?bThCMGNBVlpWQXBDOE4vNGtjd0xmTkFvbW5MMWw4NlRrSThFV0RURXpTOG01?=
 =?utf-8?B?cUlUb0xUSVFCQVU0cW00N0c2cTc0Rm8rUExQNXB1czhpNEVtdi9oSG5VcXRm?=
 =?utf-8?B?M1h1VDlRbjBOZ1pBdzdkZW9QNlRJNTl0cmtSVzlWbUhCc2VYcGhDV1hwNTJ0?=
 =?utf-8?B?cGpHOWVjTHQ1djBSRy9OZ09ySVdweXhZOGxldndEajdHQUJWTmJQWmhpSXFT?=
 =?utf-8?B?elJEQXBLdjZ6WFN3cHdvZ3R2UGhCWFNZbks5RHR6V0hhMFpNUmFSYzg5VlFE?=
 =?utf-8?B?TkQxSU1zdDJnbHpZMTBkc0NSMGtpWGlMMUZ4V05wRzBGTlpVWmgrZ3RIK1ht?=
 =?utf-8?B?S0hxbXg2cVRTOVNNSEVqc2RrRDRGREdjd0lsNEVpR3ZUQUlJQ2VOVU1Id1FI?=
 =?utf-8?B?a1JQMVRJc28vaTZpM0QxRWNwT1V3aldrbFduZSt0Nk1vTmpYczBzanNCS1Fu?=
 =?utf-8?B?czZpY29xd3NiYTlvNzNaZXNFT21OVENIczRWRHd5amdDMWwxcFRhOHYyWU5p?=
 =?utf-8?B?YVpyUWZQMkxsdy9iZDVDU1J1cVgzcWl2dGZUVGw3VVNNMlZ6MldLVEdBWnJG?=
 =?utf-8?B?eHdJajkyNW84aXNMTG02L0dGekduV2N4bHRNQ0JROHExYjIxbU9LSWR2Vko3?=
 =?utf-8?B?YUlLUU1FRi9ISXpnODNUN1BoN3VOQmdqaWhUUHo1ZFZxeFhicVJMY3ErQjRi?=
 =?utf-8?B?S3J2eW1hcDg2clo4Y04zeHlFQ0Y1NHliemJKbzRINVk5Q092ZS9JemxsWC9X?=
 =?utf-8?B?QUlOSTZjeVJRZE04Zmp2TGRXWGh0ZjdSZm9zQkdkbEF0ZCtMTWY0OW5mZ2hj?=
 =?utf-8?B?WDVUaHF3U1FqWS9HMk5ySG9XRmJ2MnpWM1daN1NmZW9uUmprckFxYmtzaHcz?=
 =?utf-8?B?K1NIcnV5TjdITjZrMnN3UEd0dkUyY1RWWlYyTmd3dnZVc05Nelc5NWF1b3ow?=
 =?utf-8?B?RmlDTVpjMXJmeStQZFZzYWt1NDNVcVErODlqVGVyYkRPaExZdS9nS3lEQ3pt?=
 =?utf-8?B?S09hRGxFUzVEMWx3NGdNeThEa2tOdFgwN3lNcmFTK3p5d1IrSUt5dzN0amd4?=
 =?utf-8?B?c3ZLdXhNWWJjd2llc3FOcjdrd3ZJSk9rZlVCZ1JXR3Q1ODBPMVJaQmJBY1Y1?=
 =?utf-8?Q?KU9iRDjcQ5xO9apLo2oU32Ev9DB21JyM9n9po9A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6c9e6a-6028-4fcb-4d08-08d969af128c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 23:04:50.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsROlL2OVQcuRrgr3FdhySouF25JcOiPGh02zyS9uJI8lnaPn2f2g6ut/hNXds8LWP2buyWnLPwP7MOES1wYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2744
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270136
X-Proofpoint-GUID: MsZsle_Se7hL6ayENU_jZAdr5RIm9e-8
X-Proofpoint-ORIG-GUID: MsZsle_Se7hL6ayENU_jZAdr5RIm9e-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 10:22 AM, Vlastimil Babka wrote:
> On 8/25/21 00:08, Mike Kravetz wrote:
>> Add Vlastimil and Hillf,
>>
>> Well, I set up a test environment on a larger system to get some
>> numbers.  My 'load' on the system was filling the page cache with
>> clean pages.  The thought is that these pages could easily be reclaimed.
>>
>> When trying to get numbers I hit a hugetlb page allocation stall where
>> __alloc_pages(__GFP_RETRY_MAYFAIL, order 9) would stall forever (or at
>> least an hour).  It was very much like the symptoms addressed here:
>> https://lore.kernel.org/linux-mm/20190806014744.15446-1-mike.kravetz@oracle.com/
>>
>> This was on 5.14.0-rc6-next-20210820.
>>
>> I'll do some more digging as this appears to be some dark corner case of
>> reclaim and/or compaction.  The 'good news' is that I can reproduce
>> this.
> 
> Interesting, let's see if that's some kind of new regression.
> 
>>> And the second problem would benefit from some words to help us
>>> understand how much real-world hurt this causes, and how frequently.
>>> And let's understand what the userspace workarounds look like, etc.
>>
>> The stall above was from doing a simple 'free 1GB page' followed by
>> 'allocate 512 MB pages' from userspace.
> 
> Is the allocation different in any way than the usual hugepage allocation
> possible today?

No, it is the same.  I was just following the demote use case of free
1GB page and allocate 512 2MB pages.  Of course, you would mostly expect
that to succeed.  The exception is if something else is running and
grabs some of those 1GB worth of contiguous pages such that you can not
allocate 512 2MB pages.  My test case was to have those freed pages be
used for file I/O but kept clean so that could easily be reclaimed.

I 'may' have been over stressing the system with all CPUs doing file
reads to fill the page cache with clean pages.  I certainly need to
spend some more debug/analysis time on this.
-- 
Mike Kravetz
