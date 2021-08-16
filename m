Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66E3EE018
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhHPWvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17114 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232444AbhHPWu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:50:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMllYl031286;
        Mon, 16 Aug 2021 22:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mrO7BgSmrYPvzSUf44iF70p7lgEc2la9QBGnDshXjR0=;
 b=Rp4aaT832yar+gkYbS2lwhIdgDE3kpUuPJOjox9eI+FbNtBfJTGNP6exMpIiz2h3E2KO
 OXeXqlhIaBBZ8q4Mht2JqldcidMMTroEIpwXqPI/OhlufKb9OzhtuWmUZdBuDHr/KGTk
 o2R2Bh9+C94h9YgMxqNe2dympsIfHaP4yyenOtdUi6zdzOmN9WtR7HV5cEnSqtEW46KO
 zvjacZmYjLd2GaZ2iusy+hspyQxsEIWTCw36rz2B/W9zCwmAZmQRRMX7uW65IxU9b2CR
 cxL60Ry4M9tfbwtGaQh1T7cczoN0jNbQzHRlvLrDqfQFdDPxgs/8wbGqp9W+JeLD1oqy aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=mrO7BgSmrYPvzSUf44iF70p7lgEc2la9QBGnDshXjR0=;
 b=pk0TEh1yFVApRq6YIhbqA2kTLotKou0IR8wrGFOQComBt77btvYChkbWHL7VwoFwyQvb
 83yvtrcrD4oVpH6M1PdmC3uLL3O+e9GeGm8gBQR4IzZkhVlem/V5pgkb6Ac8Ka6l9W8S
 qxctumgu1XsF6qtt4EZA6ocPWNrlEFW2o/IIIbQ9//WVaBqMJqkXFT9ypjXsuwduYnPN
 wHJfVfKKge0ajNUcSodB6VZihoBo0qoVvcp8bDHoTBl6kzvksdRBiD5AgxfMvCMbDWaF
 O2fCfANVfw81KUwM63TAaFOG3PAfHHfskj+hPVbP5MC+kAoIPdE995LNzaqg0/LfmGZA Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgjb87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMihdH152058;
        Mon, 16 Aug 2021 22:50:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3ae5n6fxx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nODr7J6rcdrNdXZcCQhiylQwjmg1bxIHNdGYoX1pEQDCeiRZcixGfpaiz+5oI25KBD6RoJrjXyxMWhgiN3PZG0537q2ULBme3bntk9N9APbjFrJpCS/IvUcE7n9Q6FO8OnxbB2EH0PRsi6L/9fA5qv+JoTpTCrBP3uh5ZGfndlbBVhrPn7sr/v754MPv8b0BLHw6YMyE6qyaIOQkbgh4Xnx/Ksu3Nfv+WVTVZTLp3mgkFdo7y4XYafosawuerlvugPIwH0IVonVLszeh3XNyorB4IRv5IaKC3L+tJJ4MoGdeUlEduvaGk4OGjLTvWAVyDp/1hc1bnH+z5NQhofnuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrO7BgSmrYPvzSUf44iF70p7lgEc2la9QBGnDshXjR0=;
 b=W4uz3fgkRVsoSbM7kvZ1Q6nga6+6lEWat6ylh58TYaKBXdOEDx4yXhdk4QJt5pckOOsPQVr1+/kskJRzO0kNkYASaaP0oNzSZcNXv+oBVYp7xm+ijffQiSdgFS1zKRs104KFqpg7ws9ji52N9uekogArbtW6o7MQg+g4PPqYRoflHrU2770eXPe8+8hglFzEE9fSxS8Lzxb+Z/KnWCJQSffraMof7QG2lgAE7CH0UScdCwu8g0oGlhkPJsOrA8zM+s9teLlv/bscudB0C9W7LtsF3miUojk8M3lzgLZUfmmXE7j/vpKSaAXq5Li+r9fZrwlBTtVLSdk29AoMa6v8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrO7BgSmrYPvzSUf44iF70p7lgEc2la9QBGnDshXjR0=;
 b=P+DujzTel+YO169nfnK7HfyJYLGtYz+uCjBvr6LgqWZg2st/VH2ihMoyAmelwdBDqs4pI/dYWlWHyl9Cr8MlxxvSA8e3EKT4GpHxL9lh4KRx5ksH6UJjqdXmCZM4WQxBhFVajcCwB1UKvYu1fA7ek8oIyQfGnLN/5ZHgZQXLPBk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:05 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Date:   Mon, 16 Aug 2021 15:49:45 -0700
Message-Id: <20210816224953.157796-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de810b9e-de00-45a5-c00f-08d96108305c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB33972A508C441581CCF4DF3BE2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oc3wDLOQEIGmcPECYVO/z4OMx+Xw8RsGO1/u57Z+D7EZ4l96nBYDdvIWDV/he6knPTPRn+6L8Qo4uoQNB+e7WjGrIdKaQOlYDYSJTHEmt2MiuYmJ9kRlzR7gO16Ql4+lNY7BCQMcGGoDC1gmSGe68x3z2VML/6C/CAHm2FDzhbA7BibkvwK6OdmsuCtgtYsxwOywpFEZCkqYc5+Jng8SQSdg7aNfohzc3EK67NG6vNt1Jtlw4+dW5OKIczkeYknhA6WRXNabGkKNFqrDFGXN9HLslSAreClerO5wxR5rsAM4X6Cvz0uwx0EAeLoiRRizjdBkkQLe4S3k4xsDBBuzQ6RieczSypzKPups7MoK6U/gMEiqT469rZl2NxPAyD9Sv9wos6CQNeWktaqBaorSMvin9Hc9NVENs+GaBZPYy0St3Hb37NNBOGAw1TNH5RoP6CxxFeOPCqMoLX8Cid1ZTqYHwAbyu/pOVLF1BJOfhOnVC4nK5wQFe3zUw+Im68bJUDPdKkVIc/OvtTDB1M2MBM8UCTAb9U054Zub8hVrRRNNSbHKPT8MtSp/Wk34XvP9ZYAccmxoIRTJw8389C9HxUOHtlp8Dz1a20vWDBRweesyE3jh9y4E6E71kjB65u2I3vngra1tiHLifdsZF8R5xKlAF2HQE1Y7Zsj8kioUSqLF8QyYmZOGD/oy32k02IV0UQGDOAhMLmvNDclmoLpNa5B1yI9SOCVqJxfzat1GsR+CyP3hYEDd8K52h7AjAaMW2T2IRc2lGbd3KUHuCufCRVAsxEVFTW8RHEpr7FIPE5RRB02MPVkMTSkoziY3v2eZpHjVGmzmMFFDodNOhxYoUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(966005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ymrWfSOW92qHRhord93b9TEmKeyNXzYN4hjdhvfz8o9EqKhfY04EZfkssTRw?=
 =?us-ascii?Q?OQzhSPiYF/tXmAltHI86OOyovxWSrfc3gbygFJSm16DVivP0J6n920yc53BS?=
 =?us-ascii?Q?7DVjlwuRJQDsZWdADaOhlqfrEZpgoH+aCOXCm4XOGAg8qgDH0VUCTl8dNF5k?=
 =?us-ascii?Q?dXks4eqTBf6r/Y37lz26wU4RQw5kUorMSUWQT/0Xah2pFedRuQTtmrYe9rZR?=
 =?us-ascii?Q?g9uCUgEf9aeJqg2Yy+k60F71D/bkisCs/O2BvIS7FnPqLBzig4A87afUQzc1?=
 =?us-ascii?Q?oD/qqZ8rnurMw+4Jv28KboZGTpHxod39V/wek7yUK2xUKqp/6oRB8quuxRhj?=
 =?us-ascii?Q?+CN1Ua0lolo6qQgZa7Rezza13Zox3rMC7sfA4AHJwl03arqA8OtjUJEGpCMA?=
 =?us-ascii?Q?iIvZoPNK551DIHw8nSTLnO7J/xVORiiTJkL6ooIUqa30iQkVw7RtcH3yGFlb?=
 =?us-ascii?Q?7KzeAUWFqa7OTag0OlG8o/79hP8OpvRHP5krUuOugu1DIzWkoUhhkYenCeuV?=
 =?us-ascii?Q?gFzq6rA+pw7S89hY3mgLndkcDdf5Tbx0Ok50uteQXknxaA2HFPQOQJBIhUq0?=
 =?us-ascii?Q?zN1ieCLlDxmDU7CAOej48bRlx9HgopyXhz2xuwI40sFEUIQQaONiLMNVrl1d?=
 =?us-ascii?Q?wMNlLrMelQKPuH0F7VOMHAqlijxe4MNx6/lEqNI091U+KUHQ5upcEcjDu0ws?=
 =?us-ascii?Q?uejRbJlK6gMgUUlYsCyQE8rpJY1tvc4oQlJVZm2ZxhUeLnmlKdYG/Uv2a1jU?=
 =?us-ascii?Q?8Wpu9g+gYLCNPMDUaJSxstZBb5F0ZEe1SkmrXHefwUjg0B7a38Q4iMnQ+MGs?=
 =?us-ascii?Q?m2pz4dOejpnkc1csG+/LrVMC0U7khyTQEcwT8IVPu7Yod5H7sMFGcbXrTHd4?=
 =?us-ascii?Q?76sQQwPjUD8U5dueeJ2ZzgZWChjDUQgYzP9c7t+GwIRWSha7QY8FSP+OxDeg?=
 =?us-ascii?Q?60/+3qZxTizabRPurUR3U4ITUj7hE+D0zngVKEvEW2EqeQ97/pFAy/2xh0DG?=
 =?us-ascii?Q?V412r2AbN8pBi7UJoNqQ13h4TGEpHpymacgYtRGaeV+h5WK2mnoOThc73616?=
 =?us-ascii?Q?1IB1cB/QZd7XXnDEZcYpl2RHsLnz26i/ihF4n3vka7ZoN3/+2zFhpD28vbl4?=
 =?us-ascii?Q?TdA1cGH5xqHejUDe0+IsmBMVcDPA2Vjc/BvAkMpb/UsPbrowc0nZWckST+GR?=
 =?us-ascii?Q?EkmBLxZMBaLuDeq3gyY+AZqgFG/4MBX/uPAelR1kGIngYm1vOQ/ZMSIBFVcj?=
 =?us-ascii?Q?1UEqntsQ1iTOqTZ9sYFQDElkGqi7KANsJHK7t8LifADXA4CbhqmdK07YCWsq?=
 =?us-ascii?Q?35wAyL9gHuhArl74eSYtb2pe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de810b9e-de00-45a5-c00f-08d96108305c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:05.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eH4UHUQ2Vfq+10q7+IZbYPdCPhRPvwUz2tb9G6qowEeTR0Qw3IWeqnemW1L0ix8+/kmFVQeLWKEZ+BdT8bmAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-GUID: ZJuR_7S-lgSpYIu7X4ZbIid2vt71b6lX
X-Proofpoint-ORIG-GUID: ZJuR_7S-lgSpYIu7X4ZbIid2vt71b6lX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of PATCHes sent here [4].  There was some discussion
and interest when the RFC [5] was sent, but little after that.  The
resend is just a rebase of [4] to next-20210816 with a few typos in
commmit messages fixed.

Original Cover Letter
---------------------
The concurrent use of multiple hugetlb page sizes on a single system
is becoming more common.  One of the reasons is better TLB support for
gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
being used to back VMs in hosting environments.

When using hugetlb pages to back VMs in such environments, it is
sometimes desirable to preallocate hugetlb pools.  This avoids the delay
and uncertainty of allocating hugetlb pages at VM startup.  In addition,
preallocating huge pages minimizes the issue of memory fragmentation that
increases the longer the system is up and running.

In such environments, a combination of larger and smaller hugetlb pages
are preallocated in anticipation of backing VMs of various sizes.  Over
time, the preallocated pool of smaller hugetlb pages may become
depleted while larger hugetlb pages still remain.  In such situations,
it may be desirable to convert larger hugetlb pages to smaller hugetlb
pages.

Converting larger to smaller hugetlb pages can be accomplished today by
first freeing the larger page to the buddy allocator and then allocating
the smaller pages.  However, there are two issues with this approach:
1) This process can take quite some time, especially if allocation of
   the smaller pages is not immediate and requires migration/compaction.
2) There is no guarantee that the total size of smaller pages allocated
   will match the size of the larger page which was freed.  This is
   because the area freed by the larger page could quickly be
   fragmented.

To address these issues, introduce the concept of hugetlb page demotion.
Demotion provides a means of 'in place' splitting a hugetlb page to
pages of a smaller size.  For example, on x86 one 1G page can be
demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
- demote_size   Read only target page size for demotion
- demote        Writable number of hugetlb pages to be demoted

Only hugetlb pages which are free at the time of the request can be demoted.
Demotion does not add to the complexity surplus pages.  Demotion also honors
reserved huge pages.  Therefore, when a value is written to the sysfs demote
file, that value is only the maximum number of pages which will be demoted.
It is possible fewer will actually be demoted.

If demote_size is PAGESIZE, demote will simply free pages to the buddy
allocator.

Real world use cases
--------------------
There are groups today using hugetlb pages to back VMs on x86.  Their
use case is as described above.  They have experienced the issues with
performance and not necessarily getting the excepted number smaller huge
pages after free/allocate cycle.

Note to reviewers
-----------------
Patches 1-5 provide the basic demote functionality.  They are built on
	next-20210721.
Patch 3 deals with this issue of speculative page references as
	discussed in [1] and [2].  It builds on the ideas used in
	patches currently in mmotm.  There have been few comments on
	those patches in mmotm, so I do not feel the approach has been
	well vetted.
Patches 6-8 are an optimization to deal with vmemmap optimized pages.
	This was discussed in the RFC.  IMO, the code may not be worth
	the benefit.  They could be dropped with no loss of
	functionality.  In addition, Muchun has recently sent patches to
	further optimize hugetlb vmemmap reduction by only requiring one
	vmemmap page per huge page [3].  These patches do not take Muchun's
	new patches into account.

[1] https://lore.kernel.org/linux-mm/CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/20210710002441.167759-1-mike.kravetz@oracle.com/
[3] https://lore.kernel.org/linux-mm/20210714091800.42645-1-songmuchun@bytedance.com/
[4] https://lore.kernel.org/linux-mm/20210721230511.201823-1-mike.kravetz@oracle.com/
[5] https://lore.kernel.org/linux-mm/20210309001855.142453-1-mike.kravetz@oracle.com/

v1 -> RESEND
  - Rebase on next-20210816
  - Fix a few typos in commit messages
RFC -> v1
  - Provides basic support for vmemmap optimized pages
  - Takes speculative page references into account
  - Updated Documentation file
  - Added optimizations for vmemmap optimized pages

Mike Kravetz (8):
  hugetlb: add demote hugetlb page sysfs interfaces
  hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
  hugetlb: add demote bool to gigantic page routines
  hugetlb: add hugetlb demote page support
  hugetlb: document the demote sysfs interfaces
  hugetlb: vmemmap optimizations when demoting hugetlb pages
  hugetlb: prepare destroy and prep routines for vmemmap optimized pages
  hugetlb: Optimized demote vmemmap optimizatized pages

 Documentation/admin-guide/mm/hugetlbpage.rst |  29 +-
 include/linux/hugetlb.h                      |   8 +
 include/linux/mm.h                           |   4 +
 mm/hugetlb.c                                 | 327 +++++++++++++++++--
 mm/hugetlb_vmemmap.c                         |  72 +++-
 mm/hugetlb_vmemmap.h                         |  16 +
 mm/sparse-vmemmap.c                          | 123 ++++++-
 7 files changed, 538 insertions(+), 41 deletions(-)

-- 
2.31.1

