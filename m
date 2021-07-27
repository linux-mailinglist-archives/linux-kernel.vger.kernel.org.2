Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715C73D842A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhG0XmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:42:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50870 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232766AbhG0XmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:42:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RNem9M002183;
        Tue, 27 Jul 2021 23:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BGwmiwWLSQKFJszRTJhcdgWCySrf7XpLQfffBWFjga8=;
 b=mAPLZ1K0JscE8s+hLeTCfS47V8sdGYlfC9ipFRZ2q9P1L/7ujE7jrLTS5yLMssLdrq5Q
 HNEjllXkUnq0UphcVZbOWPVDcTWkOxjkFNrLZCr7YfmeAr+8FE49vad6NGoxzV4nCRji
 ZXOrVOwAoLETVqNGagmpqZEO6uncfqIPEWgDLYqkA8Ct1FKvXFuSmCbT0KordbOi77BK
 ws1QN0h4rUMtrECRuK5f+SnMQenVSVl2wzN3nC7svC+RLMTwWrM5stjHzaiBz0O7d0+x
 7TPLVJ7/B25g1ST+eMnwN1552SK0IschUJHRYe2/Dc5xe3uV3Fn5mfgX8J0FBlmJsN/m gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BGwmiwWLSQKFJszRTJhcdgWCySrf7XpLQfffBWFjga8=;
 b=pmW03iAN3pywfDVavBaD69xY2aQpjY33Msj8RvDdwy2vZi3GWGN561Y3Mq6tvOxoRvFF
 c3EgGZbt5+vEoyjADbZqM7atodFCROzFaqIxMjjw9enNPwCsme13Rl8MIs9Zq6DfeYfe
 a/RSMy52JbnRS1PRwM6/DvjIsDHFbrkk0xeGdxYg/YjBZYQsB8sLiWWnKwolcxtj9UuY
 RX+SIyrMvfI75klC51c+s7PK+B4abCiRWa5y7oPdCY6lWXfzac65oiKKwaq5eYqL8uVK
 AFbqUo74JeHLqJuOhhghSSrCqvjlDqCHdlh8fKfxTeyVYZGUTY/WLJSHHQAkl4JD0BnQ ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234n313u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 23:41:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RNP8ng089853;
        Tue, 27 Jul 2021 23:41:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 3a2353xyap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 23:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvUA0Q5Py7LrqFkMe0HNTvwFyPoP/MiwhVWpyaLBtI8m8hZnmDQxhqUWwQtKJRgm6vc+qcFCEzdXoI0fs1QAmuJ/O29b2jtPLQAtpgWSPJBv4KTvBERc0/C3UExCI5ywXIxIrPrpJWTXlhmZtBwk1Tavn3eq4fNTCTOfpJ5zDw9sPUJX02T+7Lps6eS6F6nDEiZdkLy68urJgWSMDdkoL0mBgBT1FuCXMYJcOOjD7i97W/FFob2Ecp6LIIe3MD5vO15qA8Pg8BPMgWGWIXlQi33Tk8x1GXSvSNW6m8TwcTKLemHz4mH6VT4ueEKEAcf+MW0TyadQ6BVZWxFfDzOGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGwmiwWLSQKFJszRTJhcdgWCySrf7XpLQfffBWFjga8=;
 b=UJqKmEdhr4KJSZDiL6lUErQmvGp0s8Orv//53uVMzi2qp5feDVhZDSZ58TpOBXDOOCSqPn7YvtXqUa1wvHyioO+vb6dfandeyogTehOCBLDSN0pmzvDYsEvtsfOjYyuJQeAm3Eb0/n6nfL+URmj2AMFgitroqnRffNLxjpUzdDwfhgetjCbon6VivebCRUvo5/7YHqQZTdA70HHP7RKDO1EVN1THgnaavSIhPs68YwQJ05Hf3TZBsnJG8LOREosSSuf5U4pKj6FzJ5cq7SC2UC/f5yQEaBHKz4u8aSLPdl03l824YuNXa+7R4sq061SygPDzmjDJSg/I11Gssi17ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGwmiwWLSQKFJszRTJhcdgWCySrf7XpLQfffBWFjga8=;
 b=rlDx52ZYjvjwNVEdnW2NFhGXCMSuNr/VH2j8kEC12zdbQJ403kP2i/Y4eKNCGBU7583euKXNLnATRQ+iaPfajVsWIn0XUE/NiuFAzm0ptlVT5V1wInSxKqIrxrOfzDDasiTpmLcqp1yDCZAT6HCgoxaL5Df89daXOs12NfBaQ4s=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3591.namprd10.prod.outlook.com (2603:10b6:a03:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 23:41:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 23:41:54 +0000
Subject: Re: [PATCH 0/3] hugetlb: fix potential ref counting races
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210710002441.167759-1-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <22abb0f0-ce85-3567-3bfd-74dd1450c14f@oracle.com>
Date:   Tue, 27 Jul 2021 16:41:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210710002441.167759-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR2001CA0004.namprd20.prod.outlook.com (2603:10b6:301:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 27 Jul 2021 23:41:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: febac2c9-77d7-4664-5f48-08d951581d36
X-MS-TrafficTypeDiagnostic: BYAPR10MB3591:
X-Microsoft-Antispam-PRVS: <BYAPR10MB359182634B3B549F4FC9EBBAE2E99@BYAPR10MB3591.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PblOZDrW1D2xWAzrxAte7qb5mUyK/p9dhZc2VFpPbeIZMfM3vAx32qP3CWfOufMQEPWrVUXJUq9OQznBA71gaWnXZ6yyL6adG/Mq5jHQ5MJq35pLXbNr80Th+Ownzgt1Ab5WDJcRTIB3I71hcMCK313ZyV2OlOjTlcsExiC4QqYB1DZ2NCkmHFNK2nuNw9Sq6sWqt4rMujM57Z9523p7c47Rq/A+cnqYhDj0CJnTYQjyjkLhg4TjA0bH8j0asRrvbn/FXT94mkvp6mxv1GRu5GJMbHdVfnzoBcbfoVGDYM4H8AlZCWEre12YFKg5Af0brFJPctY2KzWnKaduCqBPd+j99laS8dhudSZFNO+3rVQcF1kNMn6YpMYem7ujbfh2VaRLPXA1pSaGnuQ8sUZA/Y/YIkmAtZbcpAM9YtFXFo7OsXRRDIYg+cdg1XQU25an3f29jOayM1T8V+QwGd4ejO73S3zrQF22qgAxksa022BxbU5mQEjS02AMY+q3iosPWPNbrKsfSZLGSEtf6y0xSk2VsTdNnTP8LP+DwwtRKpLMvL83BX/rl4YNL659/Ldbvuog4SWmpIKHG5Jl7oP1QEpo2puh+TvlGzGeUe6oeb9TvI490f4mL6uzYEeqcxMrSsYI/vgoBn+ahFU4MPlZYxvCbuyPspo376HLUzZqWnD2DWarwV5djYBQ1jw/lMdA9GoiHpOw7ftcfwa5fSbS2PU19LbIHMVtAEMpAvD/GLnyp/Mneyeqy6cNr7+Mj3J+l9np2sXSV7QMsISkilWt3ZANXrfh2Yqoqbv/au4GzHrlxZGa5aXiXluISM26NJdYzKdFoJ6jL7HStupeGxXN8D3pBNL+V8A11GWlYeC+3XA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(366004)(136003)(186003)(2616005)(956004)(66946007)(66476007)(38100700002)(316002)(7416002)(38350700002)(6486002)(478600001)(16576012)(26005)(52116002)(53546011)(2906002)(966005)(44832011)(66556008)(54906003)(5660300002)(86362001)(31686004)(8936002)(31696002)(8676002)(83380400001)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEV5RURjMjkyMTZCOHM0S1FLSlhvenNzcWlCL09vS3JodjU2SCtQVW14LzVX?=
 =?utf-8?B?NHBFR2U4VEVZZHB0WnM0UG1ac1dTM3cwdmNTeEtzN2gwRExXaWo3NFBpUGZa?=
 =?utf-8?B?VEI2ak1kSEdXdW9kVWM1RTNETXJVQkVJWDg2cUYxV1NsSFpiMXFMWlZmZFJB?=
 =?utf-8?B?SldDdm1LMEhYMWR2S3JvU3FBSmFHTEdXLzhic2tFZ2xxMGxjaVVuR2F6UlFh?=
 =?utf-8?B?MTdweXlZWmVpYlpjMjVUV25tVmc2YVEyNE44MjFDTWk5WU9FVjk3NXVrZ1lZ?=
 =?utf-8?B?ZEx4NmthVkVuL2tJeWpwZ2tzdUQzYmZNMlEzc05qWURFQW1uSFFaY0xDZlc0?=
 =?utf-8?B?M0dDbitEeHVHQUh3djZrMGpESkhuYWpQSUUrRTV0OXRFOFE2a1hUUnhaRzgx?=
 =?utf-8?B?MG9LNmtlNG12NGxkOTVZdjdvZjZvcU5FalZhcytnZkw3NzNkL3V4NGROaUVB?=
 =?utf-8?B?MG1EaVRWbDRzWHgrR2RzUGxwU08wSmlINnVYYnRiWk5aV1F4YUlBZ1dDNUxk?=
 =?utf-8?B?M0dEdElPUFEzSzdKc1d1TGYvWFNLWVlGbk1Yc2M2OEREeXYzdmlwcCt4S0lD?=
 =?utf-8?B?bFJWWDc5Zmg1QnRqRm4zU3JFTmpML25oVjA4QW5naFlXUk5pbW9jakFibkQy?=
 =?utf-8?B?cE5YVU94SURSam1HaVRLcU1IWmVQTXd0cTVjcFZyTHhlTWltaktVaXZKVWNj?=
 =?utf-8?B?QzJPS3EyVTByS0xWY0Vsa05FdExtbnhFbXlHVXJpMDFlN0NDSmRyZE9kb25T?=
 =?utf-8?B?WnZZT1lNM1NnY3d2bERKaUI0anpNMEkwQVRQNmpTakVTUlQrd2ZxS0NteThO?=
 =?utf-8?B?czFnS1haOWZsaDNXR1JUenZqUTBvNG9LQUd6SFFKczMrUVB0T3JpSjJJRWxV?=
 =?utf-8?B?OG1nTGs5TzFsQWkrZXdzaEhlV2VlTHZzMEdZTEwrRFphS1RHVEQrSU51bVU4?=
 =?utf-8?B?Z3JVQm5UcjBaTGNsNHJJRDZUU0JtMFlJRi9RenpKcEFZQnQrSUY2bWVYbmJp?=
 =?utf-8?B?MGdaVHpaMlRoZXFiZkpOelZQbjNjVnNoUnBhNE96Zkc4K1IycTBaOGRhTGJx?=
 =?utf-8?B?UzFyK2lhWkg1SCsvUjNyRndzdXFWaHZpRGowcFF4SkFSS3JJYWRBYnV6Y3I4?=
 =?utf-8?B?R3N0U2dnSnVqc3p2Zk53ZHVrMUMxU1A0aHp3TFJ6NUNvUWxSUTR6N0JJU2Nx?=
 =?utf-8?B?aGI1MDZOL2o5Q3pjekpYRDJTR2M3dlExWTBRMU9yUUVXTTFOVFV6emtjZmNH?=
 =?utf-8?B?T0xDMU11emQvVUxQcjY0N0FzL3NnZVZxYUZGMjQ0bWJXTjNsVDNPNDVKeDEz?=
 =?utf-8?B?L1llS21sVWt4UGhWWVRUMnQ0SkhvSTVuWGlMUjFEb0p0SGNNczloV2pJMTdV?=
 =?utf-8?B?VHVEeE5JZ091ZkVRMElQTkRPRDdwYlFKRGROcU1wUHFGMU9SdGJkaGNqandj?=
 =?utf-8?B?L1laNFR4cTRXdG85QVB3RHd1ZzlmTjJGSksvZFhqQktJc2V4YURaMko5dHVx?=
 =?utf-8?B?ZFh4UFpDTzdwTC9Vbk5jUXJVOEx5TUh6cGRqNHFDSFB1ZHl2NWwvM2Q1b2VQ?=
 =?utf-8?B?dXRQLysrVmVwSERESXNlNlZpZTVhTWRhc0xCdEJlamc2eUtmYlR4T3lVeXl6?=
 =?utf-8?B?bm5rZmM5R01ZeWh3UmwvNytGWkgrSVg1K2lMU3NPTExnMml0SWcrclBRMHJ4?=
 =?utf-8?B?Q1NGQTN0VjYxK01hV2FybkgzVDVVYlIyb2tmcElhMWVqVHkrQi8ySkhNYU1D?=
 =?utf-8?Q?INLtG9QoanAluwwa2tyf9fSCNcmIyIMrDPrQPRW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febac2c9-77d7-4664-5f48-08d951581d36
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 23:41:54.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6os7bC+m5j+sxWA/1JBVeKCIxvvKKLjFlj0YnK2hbhEISzw//00JOWUk7d6C67ZKwuqXONvZFGLol/cvAgKJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3591
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270134
X-Proofpoint-ORIG-GUID: hvruIxiQOHyG1EWp2_Rvs1KVddQ9pXiv
X-Proofpoint-GUID: hvruIxiQOHyG1EWp2_Rvs1KVddQ9pXiv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any additional comments on these patches/this approach?

The first patch addressing this issue actually went into the 5.14 merge
window as commit 7118fc2906e2 ("hugetlb: address ref count racing in
prep_compound_gigantic_page").

All this code is very tricky and subtle.  It addresses potential issues
discovered by code analysis.  I do not believe the races have ever been
experienced in practice.  If anyone has suggestions for a simpler or
alternative approach, I would love to hear them.
-- 
Mike Kravetz


On 7/9/21 5:24 PM, Mike Kravetz wrote:
> When Muchun Song brought up a potential issue with hugetlb ref counting[1],
> I started looking closer at the code.  hugetlbfs is the only code with it's
> own specialized compound page destructor and taking special action when ref
> counts drop to zero.  Potential races happen in this unique handling of ref
> counts.  The following patches address these races when creating and
> destroying hugetlb pages.
> 
> These potential races have likely existed since the creation of
> hugetlbfs.  They certainly have been around for more than 10 years.
> However, I am unaware of anyone actually hitting these races.  It is
> VERY unlikely than anyone will actually hit these races, but they do
> exist.
> 
> I could not think of an easy (or difficult) way to force these races.
> Therefore, testing consisted of adding code to randomly increase ref
> counts in strategic places.  In this way, I was able to exercise all the
> race handling code paths.
> 
> [1] https://lore.kernel.org/linux-mm/CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com/
> 
> Mike Kravetz (3):
>   hugetlb: simplify prep_compound_gigantic_page ref count racing code
>   hugetlb: drop ref count earlier after page allocation
>   hugetlb: before freeing hugetlb page set dtor to appropriate value
> 
>  mm/hugetlb.c | 137 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 104 insertions(+), 33 deletions(-)
> 
