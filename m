Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790593428D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCSWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44432 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhCSWn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMaVo3129220;
        Fri, 19 Mar 2021 22:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=fSb40QFl2RQtNLkyWtwhIACCmV7D5UJr3w+q7n05yEA=;
 b=Vtvo/l3OAvsCVCzpherWhZmuek8K7Rnr4g6daZe5hXgbQTdpFuDIfFM0DLRW/UO3c92R
 T/AMs27TiTXdyFQt+UwE5qIfphLGQiSfBeS0B9/KblzqbUW90aEjOCIN4o1ehXTR1Wgt
 CaV5vDdb3kNpU/zClbpchDGxQrZFG00knfsrTSWsdtiFHAP9TJpakRMk6NUsODaku/JV
 /P4jTxna1RUZIUnqPhdXSiBuXf3MzUtShfhmB8GXiXvFjt0OF3DvEn/N9YoiOKyL0b58
 SQrUUOvGJy53/ploBWXRc1zVK/NrOx51otfkq9nTaxO+CBULgNc4dVBbr3cBE3xHXjcU lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 378nbmmg7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMeGih155513;
        Fri, 19 Mar 2021 22:42:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3797b4sr1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA7mYt3YhkDBygPcFUx3Fr4I7pLz7xnxwnl59uTOq2jMxSAR71fc6D7rfOVkhH7JTtZhvQwB8ir3CXJU7oRHAbeL9aCRd0AI5PheilU5ul1turao2IAZzx8NiVg9uR60xUp6SNjXSqYml7ctR4yjcwBUFQRzdbC0paj3fMRU6jFghmtnFy5lmWGIZsEvw8sNU3E7+JevbFZbblxVPYUAyaIa57GzY3uVpkOMPXZzRWmofMzI9w9n3NH5kVV60Np1cqILSJYSYHuSvilxdrXqz9bEDHIoePpndaD+QqBOQME5N8b9xLdE3uPyeCB35NuTxQsprNtZFZf3gG2a2cjlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSb40QFl2RQtNLkyWtwhIACCmV7D5UJr3w+q7n05yEA=;
 b=jPEXCCGq0WwfGFrPWR9exQs//d7CeuxtxIZbt4eyNeqT5uNGr7RctTesnaJSDe8CNmIvzcht7WyR467Zl9+n+rz3tdbDl0Ug1RGdw5950w3Tp7m6Wjlkh8aSCmdV7K0XHiHd/DdCzZ0kpBG1WWWubLXiC0E0m4Gj7+zj3kf9AbGoVPJ5L4eO/VMzwjhL78CSUVa9XkGCWvIiaAoLbJh4Vsss57bX47kZ/GmbpbCZomdMMkhzFTZvcf+1kcA4DFs4pn8G6aNIJ/UfbfwBi8lF3CB80utH0kCtAwY0EXi/Vf1G+PfmQnwWK5Y5ibJ9+fWJgKA8S+FLSjlNxXmzgke7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSb40QFl2RQtNLkyWtwhIACCmV7D5UJr3w+q7n05yEA=;
 b=WrpbXPc00FvmUKKqqlvckf9iSR8RmJqrsqGtjsQ9nPL/eT8Hi2JKe5TbOcvl/hB9TbPd/WjL7X96LPqxeKxR29hfyHK9swrOjez9NTEgfgMD6ifQGSg65y64J1gkoRMlZ9GgwROY17TUF47LiHMZaDmzmyTzLdWYP04Y4MGTTEo=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 22:42:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:23 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/8] make hugetlb put_page safe for all calling contexts
Date:   Fri, 19 Mar 2021 15:42:01 -0700
Message-Id: <20210319224209.150047-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:300:116::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 347c5693-8632-412f-34da-08d8eb284366
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3160B23731D733DD9584811EE2689@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AS1lpyPXhol+QfTMuj1SMvXY537WeuPb/AL9I92LhyMm6iwsWsi/RLCxg72qXN/0sc/cVfyUSYtWcjPtdls88xxDT8GfyLc9BOgC5JxnLT50GoM2lHMiLZHdxnYaCaeBfQz90Lj1uICpHAAqG37e+b9lI2tXDBoDj3Tw8urS/KZe8t04CL4XDTTqSXCMJNYwF0zEQBBipddrBI4kKPOcq1PCId0HE8UMfJSufqwAxyVV7Gv6Rncrwrkr/3llD9KbK4k6dG7m9LPAMkoaKj+P36AeDyq5bb8yp4Qglayfmu8qNgW9ZIaqc+awpuvh/wqSbIl9XdBf+mWd+ZsO9eOc5e/sxHUWSPXJ7lHTDKAzG4Dpu2YQTJlrZ4ev0U2SF8hqs5unO6zqd1egVD1G8uVu1W4SgwQ7mxK5w5okdj3R6nQMu14FXROcaKi1s8UkDXbsb0uzoYXdKAoR9WdgqyvDyOWA5/WPlD9Dw9NurMQ1WoJyJ5ViJsnywVNw9CwQG0q+Rk9JCEJRxMuPLrT12jXLTqIgPZefDHwYfpr7qoul00B0gyvhI3+RLXLjPon1Uxutz+p4JTuzGtvr6oPYHGUV9TnFKe7DOXYkiYyJi8B+int4p2Q/pxphmFYGkZuQETndShd42x95VT00/AHh0A/FJnBBz6QtmmFAH7DjS+zUUBPmkVNL+xdy3N1LooYm0leNBLbhB64Ku881QF3tmSKrRCPuzoxUFFMqQf0f3fN85d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(316002)(5660300002)(66946007)(36756003)(4326008)(186003)(66556008)(26005)(66476007)(54906003)(6486002)(16526019)(52116002)(7696005)(83380400001)(8676002)(956004)(966005)(44832011)(107886003)(7416002)(1076003)(2616005)(38100700001)(86362001)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7mNU6VqZ75dPESUAl9iSgc9JRRteuTJ0jxMDSCUCQ04WtJcnpU/d4yeXYLR3?=
 =?us-ascii?Q?v3ni2+UzPRuEUO6E8brzAAr1G75Mn5N0YkRxmeiprDxpwlIoM8Hp+YRu+hHN?=
 =?us-ascii?Q?eWdn1qXFnd3lijA/V8GGW9X54hY+ynNSNF1BPu8p3A6PIc/cGFY059Lzp0ws?=
 =?us-ascii?Q?3qfN5kRfyBql0S8DE2W7AvrD/++l9vuUsK8Gjcw71vzHW+UTPQF9asLoqaDZ?=
 =?us-ascii?Q?Bq10JVlhOeWPzx1YLsvEsb8FDLcNe7RmN1GbLc9N2S7G9NzarMBYkOysm7a+?=
 =?us-ascii?Q?debQMTL3qHy2tN97mByIja/DgjV8/jAal1JVx3qANzOfenDu2A9iPbCopDgR?=
 =?us-ascii?Q?ThpiG3u4mDzlkPPJFeGtRGu1R2kYgtNG0WRaEagNpoLYzqSelWtGZKrCOTDL?=
 =?us-ascii?Q?ZPApUCVUy2WyJmiJyChhMvLhNdDjJMsgbeLxpgc0+bhkpppfYCi51R6obS43?=
 =?us-ascii?Q?XGqPLflRbYo26MZDdFtXYf8UnErB7irfTJHz/VDdYwNpoQ5Icn3i7tCEakjS?=
 =?us-ascii?Q?UkMwzKhpQBYrxF3fGWxCQg8b3BufLkc0ti+76+7nqM5sadi1du4XwegNl89j?=
 =?us-ascii?Q?oYQMyiT+mmRAGIojIS+gLJrunNl8+I/GPjHWAoYEenaEUpph2n51HlVwbyZq?=
 =?us-ascii?Q?CSThYlYa8Ep9hfRcSdjxjsZIyBf0whwYoVh8HZbOHporc+zXE6IAOAVDpOAZ?=
 =?us-ascii?Q?l55GeGGwN9aVfRKz2EVeTsDsA5Af9LL0Vn83HKJpfX18fUcZ+Iow60O/2bEK?=
 =?us-ascii?Q?97kVDhR8xZiTFGovRr7sXW1ZlpqraUTpb0WUsbL2aTNE8+lb3X3i7NpT/kAN?=
 =?us-ascii?Q?2NY9oU6pY6ED6ar6weJhDCCoFSDcGrBMSS0sJ11BbTxFuOmHWMD+a4Vc8d5V?=
 =?us-ascii?Q?6HuUV0Iz56We2vsG8FL9md5oMEZcQXomc8/fBUCJtTU6tzIf4/u8FtVUeb78?=
 =?us-ascii?Q?xE6TDQy+yB1tNbvJPtvOOVAZny7O7KNrYQI/dIVLCdHlhMevOeVqDmWWvzZS?=
 =?us-ascii?Q?NXgV3g+Sz9t67a0FfYW2R16q7pqBhRNzNNaZ+Cd3A4mEIC5JKI86nvI7U2aD?=
 =?us-ascii?Q?7ZGdgqcmUTXrWSlg9mmfhmpzHzuVUJWQbuWBhbMhfEJh/v954btFj855/DaD?=
 =?us-ascii?Q?O90hsxCHqa6sL2+qVcf5RMdiqWHKMMOTLkoJzFSnyxpX9DX24W/erQ3EY+A7?=
 =?us-ascii?Q?Cra2ZOaDh8YznODKEkPsAMFtkW63hrZ7xwhbthKsQrmdc3Kpx5vTOgGhVy/A?=
 =?us-ascii?Q?+WxNrwMi28CsjPxiaH/0fpvMVBeExy7PKRnEDuGho3Hvxp9vQTy73A/tfQnw?=
 =?us-ascii?Q?zJojxlDAsAppQemf4eG8FrWe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347c5693-8632-412f-34da-08d8eb284366
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:23.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0AeUZDDSQ9sNpdDoFRz0p1JOZUnesKiuqj7xjWj6cCk6AEjEmS/N4ufcDdCr6ZyGdCdDbzVswj8BP8QvjcFrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This effort is the result a recent bug report [1].  In subsequent
discussions [2], it was deemed necessary to properly fix the hugetlb
put_page path (free_huge_page).  This RFC provides a possible way to
address the issue.  Comments are welcome/encouraged as several attempts
at this have been made in the past.

This series is based on v5.12-rc3.  At a high level, this series does:
- Patches 1 & 2 are cleanups/fixes to existing code in the areas to be
  modified.
- Patches 3, 4 & 5 are aimed at reducing lock hold times.  To be clear
  the goal is to eliminate single lock hold times of a long duration.
  Overall lock hold time is not addressed.  In addition, the known
  long hold time in hugetlb_cgroup_css_offline still needs to be
  addressed (suggestions welcome).
- Patch 6 makes hugetlb_lock and subpool lock IRQ safe.  It also reverts
  the code which defers calls to a workqueue if !in_task.
- Patch 7 adds code to defer freeing of pages to a workqueue if the freeing
  routines could possibly sleep.
- Patch 8 adds a flag to gigantic pages allocated from CMA so that we
  only defer freeing those pages.

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
[2] http://lkml.kernel.org/r/20210311021321.127500-1-mike.kravetz@oracle.com

Mike Kravetz (8):
  hugetlb: add per-hstate mutex to synchronize user adjustments
  hugetlb: recompute min_count when dropping hugetlb_lock
  hugetlb: create remove_hugetlb_page() to separate functionality
  hugetlb: call update_and_free_page without hugetlb_lock
  hugetlb: change free_pool_huge_page to remove_pool_huge_page
  hugetlb: make free_huge_page irq safe
  hugetlb: add update_and_free_page_no_sleep for irq context
  hugetlb: track hugetlb pages allocated via cma_alloc

 include/linux/hugetlb.h |  20 +-
 mm/hugetlb.c            | 450 +++++++++++++++++++++++++---------------
 mm/hugetlb_cgroup.c     |  10 +-
 3 files changed, 310 insertions(+), 170 deletions(-)

-- 
2.30.2

