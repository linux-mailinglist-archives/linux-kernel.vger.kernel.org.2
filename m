Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3400C354917
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhDEXDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:03:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57012 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbhDEXDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:03:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135N1H5b119509;
        Mon, 5 Apr 2021 23:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=v7Cf3DJQwHnjleB5Kg7cg59T27pXvQ29HOQ/tZXoHXI=;
 b=VurzjOQXFA9qkOavwzWM0ruDbbkxX7A+41ALOGT/CbISLm3xMfCZi67i3aCsygwOMpC5
 56b2v4Slfo+FkM8YS89SZPT317na1IJAJmMkvkCw6nvSups70aYiDUavKt8ena6GwcBz
 eOcgr/bMk88/7VNdHdZ64XOO/j+sF4/0/j7G/AGLTgrtzTocn3j+1Xkb5z8sYue4jhbK
 oFd3zKjd0DQo7CiXIA8iljkHdlD/VC/paDRdIiv0zqKqoT4JFChxPKqqATSOiIaZsUKh
 0ltMlup2kENzap+YQhu1bgAOQbVnYZSbbeZQgOdQClsP/HNimDeFNY5nwUZwSdBYix23 qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37q3bwkk8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MtpQK089284;
        Mon, 5 Apr 2021 23:01:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 37qa3hp31j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9RzuTRbRVNx4c3CP8jQtmgI4Kwxho0gU1o78qw+A67fHtRkRIewg3KeNkPj1AvlNEhylJl70ux5WT+yq14dUdUX967rHN5B3i8JO6mWjdJGcy1TsgTFgnTTYvMWangFZhXRc9Nqpg829Nku9YYf43qTBIRGYD9Plp6LwMWiueNPhHseenJxAEZr3GUsimHof01GuB55GNnRHHwRn33oAl+kHco3CBLTVDElVVWjJnJs0dSx3aSv8aC/Ny1kxOT/UrQdbRcMt5Burt9PAYoNjC1RnZ//bLocMH728NPWNlPaDlnqAwgHZykvKLsCs/P7ZHPsEJLswPZAQ26sZYuqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7Cf3DJQwHnjleB5Kg7cg59T27pXvQ29HOQ/tZXoHXI=;
 b=YOOGF9Xgo+xZEvlXwaPiyyQEIj4fCrft+w9ZdvVmphiUPjnTkYnXVzYqt7j8TxJUgA3lWN9RCeGJFR+XTk0y2j1CyiiZeQy0g+pCv7BgqGobvPeguPbnU9LeuOapNvBoGXYlmU6hY0jTQA7JCsRYV6EyYjX4kYNlrppf+4jOkLZkEexBtyeqc43wBi22Q8KuskbPv6zkaQVs+3Qz00k3zhyek/JyWTmkSn6QUCNFOlKS9/VF4fTavDEH5gnN2KUjspDp4UGcRfVSioSEqRcLFolgYwsMwnshQ6MUYQ2ZFGywEt8xavUhsy4rW67BS8mqRrjGtbHS8GbhVhkIpKf4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7Cf3DJQwHnjleB5Kg7cg59T27pXvQ29HOQ/tZXoHXI=;
 b=pXvriErwuRAuQeRB3P00OgkcGCU2HXMbce/57NBvccwA5YAYDAfd9s0HiE5guU3slcwkL1QamvWLesb8K9p/vjJoZdO7skejHmyTuBG2MmuXbJklpXMkMq4VTRgOKiYQkrPqSdZY3b/kY9fjDiZr7H48PRKHvNLriQli7L+mH5I=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 23:01:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:13 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 0/8] make hugetlb put_page safe for all calling contexts
Date:   Mon,  5 Apr 2021 16:00:35 -0700
Message-Id: <20210405230043.182734-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4737512-a47d-4ad2-ba1f-08d8f886b4fa
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3544E28283694768FD23064EE2779@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixnDjxAkMmdTHC8pWzm0wE9yH6qxV3Bh2uTg4RJSEIc6LCuNp1roSuS4+bKRUEw18W5fwlXbq6cBO0arIKXt06G9MNDS6w7QryCMpVWr8ME2fS3kI1lg2mZPZj3Ep0u3cF3rwBgh8BI9dTXpC5uME1HUj6ebwEG+tXJLL47PXcd2S7mlESd1ayP/LHknF9fUvi2nbd+vYRdaZrq/jdNoUtPqlrOZAgoGQgFSm4DRN2kzr5RLSmEG1GNLWndPOs2R9hyJeBej8HoA3kkT90PfxkHIH2qIZAjAH1ZdzLjz98McQMrZCg1UkUiLcL83qqKJG5x/S6KqcZmXPqlCtSP5shT9Bj/VUEHs3FWuMNU68wH3TUqakk4diE6TZJwG4k21O9YzZJha/1oM683+f0B5NGxbEQ3zPJo81QEmc0kAS2R9HHCU/oQFq1Zi0P2nRWQgFSr/OppXii64VwP63L/m5B/td7P7iUTXir9hnuXoxNSLZ1pFQdsvqnj7srrXi4RAIC3PaVXMur5L3yA6WyQghiyPyHLX9WUw0T9me3TunuyzzRv2Ibsh5oIq5y+DFdjClkvzN4UrfaSEevYnH0ED7JSqJ3LPxr5audCXQBSQJQPK/QoooopECjHecwTvdfDFWVresqIQqOtSkEQKXW/XDyOYU7SVylwbgE0FtpdFmOdLA7jhSqX7jxHwrUj/7aEwJP4K9kYr6hVvCXRD8GEs+9WfyTYFJdrS3Ga2H8LXx8zn5ADh5zeiJKh4Lc7kYDctHBIb5AzCtkXe7iVm4OqSCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(44832011)(66476007)(5660300002)(107886003)(8676002)(86362001)(26005)(6486002)(966005)(66946007)(16526019)(38350700001)(1076003)(2906002)(54906003)(83380400001)(4326008)(52116002)(7696005)(186003)(7416002)(478600001)(38100700001)(8936002)(36756003)(316002)(66556008)(6666004)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SHh5SdPJtj4pT1DTTLF6EtiPBi9uWOc2RqZJ+japZK4zeBNgcw7bn58a3gYU?=
 =?us-ascii?Q?1W/9tPIuNwM9fQjgnJEwidbBT8u9Jq3dxcaAusg8ACjCaEIeawZetD+m3CSv?=
 =?us-ascii?Q?4ZI/aws5/94N4wwmMtztHHMn+1X1/x9X3EtKtkhv8pqP83tse/xAijMp90JX?=
 =?us-ascii?Q?ctACg400qrAL8Mf25fL8ooQ/oRVtCypY8izOcRdjin/jFyb8w1pRKd4B673X?=
 =?us-ascii?Q?UwbMMYWNd1n5US+W63wOCkFCIAWMaqhFBzbM585lPTPm54RUJ7ERKCyDUXB7?=
 =?us-ascii?Q?jo4zFk9/w40fDdH3FPb+z0XdPkfDdad33HTTXYZdzzV/28Sand2denex0rMS?=
 =?us-ascii?Q?WphMsfst4D9O2XmKXlrF6FETXKZi4M81P6xw161te2tfZeYpva4WkM+lO4qO?=
 =?us-ascii?Q?GeMWDyl0uGcf/r9tzKDAuNDqIeVcSA3C3G20e9aqNe6bVFeqeBcoD6WZJcoD?=
 =?us-ascii?Q?f43bAj+B9OqIKujJNeHa+KdH5ZMXxBuzWuxjcJmxPHtUAc+Ac7iZrrdX/j9d?=
 =?us-ascii?Q?dpJz5Q3Hydvdg+gTRO5/EmgMcOqfD1Nxpi+8w+2F4NJrP2LK1Hv0vDfRw9cv?=
 =?us-ascii?Q?yAJu8E11JVLJ/HMt5Mkdp9/iIWy1bKEoTRdF/0EaHJ387hnKmwM68wo8SG/R?=
 =?us-ascii?Q?ZCMLbIk7cFZtOSQLNTnYyhaY6LlsFQzVEGELmmoPNFy1YpAJwexjNVoEDzHt?=
 =?us-ascii?Q?kzEjop40e6yRPLNLh61N6/wLhFC/52qDV7Iiskmb2xIfC/LTti1brooCnbvv?=
 =?us-ascii?Q?8AJQttRwr5WjpfGTN8AYYfPe8BhTOJ3GF97SGv1IzO1W+iTBf0S+p/w0iXup?=
 =?us-ascii?Q?rlByT3sBCXj+qIqwuQ/ikERtdAZ4yiSZZtZ8MU/8g06ci/5rFn+niG4xT7wF?=
 =?us-ascii?Q?VJ6m8KPmLjXqLghC5kqWyValh5LoZdcLjOWhfJgwEfwbWJnrUTEiDh+Ubjaj?=
 =?us-ascii?Q?5aowrQ4Qzh8gxRNGFzUkBssOQ/5vG291pohce1nxGAxfV2yWcm7KI6zt6cZE?=
 =?us-ascii?Q?bV5Sfwyc41r4VTB8P++AA0/vqMElHDiqDXGZHJLjt4KvdkCf3u6BgZH0OqE0?=
 =?us-ascii?Q?wjoWvpfzmetHO7SpujEm/Akeqc/uH7NKg03LPH/+R0PCFUT24yS3OVavLC2S?=
 =?us-ascii?Q?LSjFAO0JdZoBrnCNWI2kECCAuQCy9u5tJ3BXH9ChLcujivV6zr2iqY7OfyFf?=
 =?us-ascii?Q?0rPmSi1XcGOIeZ89WhEG3fEhBjiozyylro2+dcupY51JRE8GvZK5XEQtlTmu?=
 =?us-ascii?Q?i4yf4RpqJwIxBrd3mFolDcQMhlhfxTHs88Vw9DMMUiIyjKZKg5pcHZOBg4UP?=
 =?us-ascii?Q?E7ROiJIv56XAIaolP5+NpzT2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4737512-a47d-4ad2-ba1f-08d8f886b4fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:12.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCHqyzM2NVt90J2EDD3opgYYFpR/GS30op+nicQSyvLb3DPVOqVZHMpdtS/QfQH1G+af3f4R2TrzmXNVYPCdMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: _5wnfXvIRQa1MZMUuiOLkIQSZYPtDtg4
X-Proofpoint-ORIG-GUID: _5wnfXvIRQa1MZMUuiOLkIQSZYPtDtg4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMPORTANT NOTE FOR REVIEWERS:  v3 of this series is in Andrew's mmotm
tree v5.12-rc5-mmotm-2021-03-31-21-27.  Muchun Song noticed that Oscar
Salvador's series "Make alloc_contig_range handle Hugetlb pages" was also
added to that mmotm version.  v3 of this series did not take Oscar's
changes into account.  v4 addresses those omissions.

v4 is based on the following:
- Start with v5.12-rc5-mmotm-2021-03-31-21-27
- Revert v3 of this series

Patch changes from v3:
1	- Trivial context fixup due to cma changes.  No functional changes
2, 3	- No change
4, 5	- Changes required due to "Make alloc_contig_range handle
	  Hugetlb pages".  Specifically, alloc_and_dissolve_huge_page
	  changes are in need of review.
6	- No change
7	- Fairly straight forward spin_*lock calls to spin_*lock_irq*
	  changes in code from "Make alloc_contig_range handle Hugetlb pages"
	  series.
8	- Trivial change due to context changes.  No functional change.

If easier to review, I could also provide delta patches on top of
patches 4, 5, and 7 of v3.

Original cover letter follows:
This effort is the result a recent bug report [1].  Syzbot found a
potential deadlock in the hugetlb put_page/free_huge_page_path.
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
Since the free_huge_page_path already has code to 'hand off' page
free requests to a workqueue, a suggestion was proposed to make
the in_irq() detection accurate by always enabling PREEMPT_COUNT [2].
The outcome of that discussion was that the hugetlb put_page path
(free_huge_page) path should be properly fixed and safe for all calling
contexts.

This series is based on v5.12-rc3-mmotm-2021-03-17-22-24.  At a high
level, the series provides:
- Patches 1 & 2 change CMA bitmap mutex to an irq safe spinlock
- Patch 3 adds a mutex for proc/sysfs interfaces changing hugetlb counts
- Patches 4, 5 & 6 are aimed at reducing lock hold times.  To be clear
  the goal is to eliminate single lock hold times of a long duration.
  Overall lock hold time is not addressed.
- Patch 7 makes hugetlb_lock and subpool lock IRQ safe.  It also reverts
  the code which defers calls to a workqueue if !in_task.
- Patch 8 adds some lockdep_assert_held() calls

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
[2] http://lkml.kernel.org/r/20210311021321.127500-1-mike.kravetz@oracle.com

v3 -> v4
- Add changes needed for the series "Make alloc_contig_range handle
  Hugetlb pages"

v2 -> v3
- Update commit message in patch 1 as suggested by Michal
- Do not use spin_lock_irqsave/spin_unlock_irqrestore when we know we
  are in task context as suggested by Michal
- Remove unnecessary INIT_LIST_HEAD() as suggested by Muchun

v1 -> v2
- Drop Roman's cma_release_nowait() patches and just change CMA mutex
  to an IRQ safe spinlock.
- Cleanups to variable names, commets and commit messages as suggested
  by Michal, Oscar, Miaohe and Muchun.
- Dropped unnecessary INIT_LIST_HEAD as suggested by Michal and list_del
  as suggested by Muchun.
- Created update_and_free_pages_bulk helper as suggested by Michal.
- Rebased on v5.12-rc4-mmotm-2021-03-28-16-37
- Added Acked-by: and Reviewed-by: from v1

RFC -> v1
- Add Roman's cma_release_nowait() patches.  This eliminated the need
  to do a workqueue handoff in hugetlb code.
- Use Michal's suggestion to batch pages for freeing.  This eliminated
  the need to recalculate loop control variables when dropping the lock.
- Added lockdep_assert_held() calls
- Rebased to v5.12-rc3-mmotm-2021-03-17-22-24


Mike Kravetz (8):
  mm/cma: change cma mutex to irq safe spinlock
  hugetlb: no need to drop hugetlb_lock to call cma_release
  hugetlb: add per-hstate mutex to synchronize user adjustments
  hugetlb: create remove_hugetlb_page() to separate functionality
  hugetlb: call update_and_free_page without hugetlb_lock
  hugetlb: change free_pool_huge_page to remove_pool_huge_page
  hugetlb: make free_huge_page irq safe
  hugetlb: add lockdep_assert_held() calls for hugetlb_lock

 include/linux/hugetlb.h |   1 +
 mm/cma.c                |  18 +-
 mm/cma.h                |   2 +-
 mm/cma_debug.c          |   8 +-
 mm/hugetlb.c            | 384 +++++++++++++++++++++-------------------
 mm/hugetlb_cgroup.c     |   8 +-
 6 files changed, 218 insertions(+), 203 deletions(-)

-- 
2.30.2

