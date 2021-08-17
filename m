Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999633EEFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbhHQPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55060 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240262AbhHQPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjfGl011256;
        Tue, 17 Aug 2021 15:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l7UiCeYjPWzbVRmAF2XHCz1ihatdXupn/qNM+Sy860A=;
 b=WF1DAKNad27Y8nIYuBNAE1IRrJeXX408N1ArrnEDTnCe9nwIsa/ei0BkKRFJImN1JxxS
 +inVltafP6LWZYx3TQOuodYHHqHj1K79Vb/cvHkgclD9nAkGL2nwNvju2aSqLKUXXR9v
 Q/JUEbY4uUk8+JK5jOQ4hNsl/7kPd+H+S03ub7dlcTiz7Mlw4g1BE6SX6rfBWWdeiQK4
 Mb3ifrvHsd01lSVDEPX8Z/RRNLEOFrGym1X3N2VjP4QrnzKU02uXOZghJ21mUkV4BY5Q
 Kd3F2DTuoYXzjJ4gXtjXPSWUabp3l8pZhWm4ik7UpHMP32lkE7sjuT7RrKhl9e0/4who Bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=l7UiCeYjPWzbVRmAF2XHCz1ihatdXupn/qNM+Sy860A=;
 b=eSkhIFJtW0jSl9nPd+rS+v5usC2d2WtrUA9rHad33o0vg5jC2tZb1z6MO9e4do3iQ0ku
 BhbevenpIBTX3J3d5Zd36HJoZt6LPbqr2qrh0HUKzRSP34x8RydgWfYkhW+GQaoDhV+q
 iwyDXG1RJ9LkRzhkMk9zJFoozTyHFNjN7uYWMU/UZr/CFRAgi05ZhkR7l6iFKBJPbZcn
 vOBXbwAERj2c+SZxw9LuLfciMrwb1L3EbH07jpkd0ykXxC9Wah1crXQK+RPcecfto163
 1FSlZZqVIPVuWTsYVLvlr8A35UiGt3rWP3EZQCu6FJ9R+OEiknvb2HfIuSPQQNSlvRRg Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8btj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf5158706;
        Tue, 17 Aug 2021 15:47:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I10a4WStj82PORYFBCTXobCihMxphbkiX8dCeIK9sXDZAmDnALeWDge//FOPkpBz0NRhtAVlPN+Som/E9XC5wBnEyWoXix84qMKYr2WRhoX2u7p2YH8CjNb00Yho6Z5LpszrRCMOEhrmacsatOslBbQ3w2dCby4b8Pez0Q4m8hvJam2jBObwjGyXqPINBjKGDRsttS9P0MF6OCmlVj27RNOSHQqGSDCrbMNtdTrt1kKY8fdP/OtnU26TxoY74+Z35fXanpEIlmHg6R7vPLyjFbh9WjGsHDE1C+ONfoSGPRij6XQLdSjHX90tRLvpwLIBXz33hhAqnWp8YJUEvkBo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7UiCeYjPWzbVRmAF2XHCz1ihatdXupn/qNM+Sy860A=;
 b=occfuJlBNV/Do81lqGanaJ2s84oY9L91yBCS0oIG3HY7mnyWJAZuY0mYsK+FNevj8RN4vxDAaPosaqBDsDcpE2pnd5WUX/SAcb11Rvo0242/zPxoVIyLsqoOaFx22kE0ZBF3dk9wNgV4q0edQuVvMhw55DW6NlpUral2ucO5P0hABrI5l0Qkwvb+wbUYuys5wRO6/ZzNzBWA+vVXyux9aCagnXET0elPTmTlJfvqH7U5AbzYENcG6zqqf4vMr440nSrz8lQugVdcwZPI/7e7sh5zQCdg45tqZe+4XQPJQVQYrbr6FIouphZok+HIcHHaB0TUhaGXMGPrmO5d5lNSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7UiCeYjPWzbVRmAF2XHCz1ihatdXupn/qNM+Sy860A=;
 b=LjVJSn97LbHR7qro7yrLnLmwIxZkPS2UFOReCzIG84q69izcRts+qa2JmxhDnMLtgFGSrgCvi3HWavU8b2SDPPdVodlgFZtTzxwofdk8JNdHgnPU5uaqxkRw7jQN4AAp/pk9o2rFxRR6WoHdgSzD69DxiR+hgLdCc735atu85N8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:14 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 18/61] mm: Remove vmacache
Thread-Topic: [PATCH v2 18/61] mm: Remove vmacache
Thread-Index: AQHXk38m7YnZ0VGyPkilG3wX4te7Jw==
Date:   Tue, 17 Aug 2021 15:47:14 +0000
Message-ID: <20210817154651.1570984-19-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cbf70c0-7cee-4564-2160-08d9619648ca
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236267FFCD88EE2445B9B06FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jS7NaQLAKqnZBG23nNsoe7JDA64oZrnmftU75vq9nIkNNJ/TQU6dmGBfGoWFFwluhGYXsYXrDSJ6HoWO+7kaDKJocuq9LCFLeTy+ctuXRs45sNl6pCQwA7xQ4N/oMozQtTWNBOHbKHfRv6VXdXxP/JMBR8cb7/BB+C/9jhf9rjXalVus/bthON3CrdXFGtCbniRg7p/DMlPY7StmrpzWTqRWVfBhzEl7jbJt0H/ljtwZ+W88MnqE0yTzmCQcKFQd9UuMURee7cFkWYSz7BhOWUOPgvxwNcE4aANmF0wR0+Z6I50J6ZSPQRIdw0eIt7Y4dbSAbRbqK1d0UjBN0iR7K6TOG41krAXj1x/UCsaSEYeIh4RtxyM4XKAQelCv1wT21JgkfD0fwocOf3ApcZxxHjLs9OBDzIizggAu6LLy8XeREI7cpuKuMYsSDiF6XPlr+QCKDtxZ2N9cdtBdnJhu8c/kbyTbA5kVofb6I4Rd0jPduE04GRAy/swCkMpHPhdXc5meZRYay9btgWoo+Nak1qXrsoZxLe6NuNUEtjVGyl6K8nftt4SBxS8QyNcL7eXifqwvdY8/2uLouRRPdvxEIWKvMNffwnNVFR0uXL+gT3GJy9FCAx9jCaSplKEc3aGPrf3IfAKzNzrCCkUVPgR9EKrm6gZ/9cqbWLIv89h571DlTgbcnx01/U1aoghbG0qqLiFrae4wV4CZnAE8DzpkCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(30864003)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jiLDCZrdf44yTA/GiEd+Y2YM3moRhBfcJQOHWlofbGCtDuOEg2NDVBp1R5?=
 =?iso-8859-1?Q?kTVyXZIiHjmnZAJkeILOrBvBqXDBdyY2EWsGtAhGlHrUAiGnJjWTFIpD9x?=
 =?iso-8859-1?Q?TbS0CyHr5xWfB0NDUKag4zCh7S/o0CVhr5BzhUY0z6YZZ6kjYeHCAWrTBv?=
 =?iso-8859-1?Q?pB0mA4bl3F2hXQ9EvsKB39I2SCzIEBB+Y3oqTpa3EFxgxORV3dkG+zmcjL?=
 =?iso-8859-1?Q?jDeApB3M+wOazFpcUOzFWpZ/5orZCeIvbPG2my81h39wRoIWeoALCO9QHY?=
 =?iso-8859-1?Q?lHF+BdXtoPcYJTllhp3i00RrgAu6dyFIC/jdJG8CtAuNC4c4PWVtuJ4dJY?=
 =?iso-8859-1?Q?NtCHlw4fyyN4gqOWl5gtxbDsNX1OuGJN+HubEJyB8pNQ1uREgt/64sddI9?=
 =?iso-8859-1?Q?7yNudF3srbbyCGE89mwcubGKgEXxHvOAQe+jJG7x3G+xP5B396vjJF98ps?=
 =?iso-8859-1?Q?umF7EPY6sxu5Ra806cDZhnWGgeLvharRCB6DK6ADld06fjVzwP34fGpJ5f?=
 =?iso-8859-1?Q?A3EEMDF3ne8/Aaz8Ei/+w3Qs4dtkCzMQg87EbMfdwIMiPKd9/sVsXTEqea?=
 =?iso-8859-1?Q?+ktfhHt73C0uKy+sXmwHHXdlsMJceqxpiXKIlrjE36UvCNOkeR4k2lU8C3?=
 =?iso-8859-1?Q?tRVwHBSPWfKMxiQtqAVADQXtJQAtbLrVWUxW+uvP7XJTZL4CkOK63s/0Wo?=
 =?iso-8859-1?Q?yIJjxxeL9GBt6DU7TjUPXybcasVpGwOmMzDRGP9AUp8PbStRLw1MnxDXgt?=
 =?iso-8859-1?Q?ycHjmjEblmdMKkK8h/R1N9p8TnhHV1I6NBYHb+w08yQBF0xpPJGX401xQK?=
 =?iso-8859-1?Q?QJQrdRBCygpbKQ8cuBpajVtwKiJXfv8QSi1eBzhbeyiJZPearwrgVD51SP?=
 =?iso-8859-1?Q?qJknykkbI1DpYZZIOzNx3YImRLSYlNi3tFDmoToEm9lRtiGdl2rkYkBL6n?=
 =?iso-8859-1?Q?DZjL4MCRiznEljbA7l7ayF50NaHOVVU+tkQfkEIyETB3xqgJYOlXFTYTp6?=
 =?iso-8859-1?Q?OIeO07CbkXvUQ6Dwn0KBxXHKZEyeMiUUf9dH1iuizT2Yljnt6ZNk//DpW9?=
 =?iso-8859-1?Q?bEPDZn8o6gC9o46kXrHx2QH0/qQA5G8VwwMj3mGFa/jmE4uEl9I5oFjEm9?=
 =?iso-8859-1?Q?LKxlnBpukmTXhvAkU+TZbLd03dUguu7hSYceXHjDIltcy1LLLA3Dn8Lr0J?=
 =?iso-8859-1?Q?9cQi5d3DiJGQ231xFB0XIUHTiy6N9hZQfLEWmsO5O8XRSxPvXFwT70wf1q?=
 =?iso-8859-1?Q?/dHcgguLp9/htiK11P6qBYOO5TxFuRnhYIWa3GEuOAc1cWOkeXEYCrf9th?=
 =?iso-8859-1?Q?Gbw9a4PRGvoWsLyN2cPo9kQMXbWPytOkJCIcJ2q/2ZGw6cMbTT34g6RPla?=
 =?iso-8859-1?Q?0xWjgwoQ9P?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbf70c0-7cee-4564-2160-08d9619648ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:14.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHba10axvfch08Saf/Jbxmk30VbgkKwL8YC9yKu/odGIAFBn64pHFZ3N/FFQqFHgZQhlATA53XHm3LlDh2Vy1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: yZsrwTWS24zxNRxBJ7tce6O1jeXHgiqM
X-Proofpoint-ORIG-GUID: yZsrwTWS24zxNRxBJ7tce6O1jeXHgiqM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

By using the maple tree and the maple tree state, the vmacache is no
longer beneficial and is complicating the VMA code.  Remove the vmacache
to reduce the work in keeping it up to date and code complexity.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/s390/configs/debug_defconfig |   1 -
 fs/exec.c                         |   3 -
 fs/proc/task_mmu.c                |   1 -
 include/linux/mm_types.h          |   1 -
 include/linux/mm_types_task.h     |   5 --
 include/linux/sched.h             |   1 -
 include/linux/vm_event_item.h     |   4 -
 include/linux/vmacache.h          |  28 -------
 include/linux/vmstat.h            |   6 --
 kernel/debug/debug_core.c         |  12 ---
 kernel/fork.c                     |   5 --
 lib/Kconfig.debug                 |  10 ---
 mm/Makefile                       |   2 +-
 mm/debug.c                        |   4 +-
 mm/mmap.c                         |  17 -----
 mm/nommu.c                        |  31 +-------
 mm/vmacache.c                     | 117 ------------------------------
 mm/vmstat.c                       |   4 -
 18 files changed, 6 insertions(+), 246 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_de=
fconfig
index b88184019af9..08508d5e805e 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -800,7 +800,6 @@ CONFIG_SLUB_DEBUG_ON=3Dy
 CONFIG_SLUB_STATS=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
 CONFIG_DEBUG_VM=3Dy
-CONFIG_DEBUG_VM_VMACACHE=3Dy
 CONFIG_DEBUG_VM_PGFLAGS=3Dy
 CONFIG_DEBUG_MEMORY_INIT=3Dy
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=3Dm
diff --git a/fs/exec.c b/fs/exec.c
index 816c7e347c9c..9cc6bf3a5f0c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -28,7 +28,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
@@ -1019,8 +1018,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum =3D 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..ab9b4ff44b54 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
-#include <linux/vmacache.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
 #include <linux/mount.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 514aca4fe9d4..374c48169692 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -472,7 +472,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 1b222f8039d1..418ec7df5f18 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -36,11 +36,6 @@
 #define VMACACHE_SIZE (1U << VMACACHE_BITS)
 #define VMACACHE_MASK (VMACACHE_SIZE - 1)
=20
-struct vmacache {
-	u64 seqnum;
-	struct vm_area_struct *vmas[VMACACHE_SIZE];
-};
-
 /*
  * When updating this, please also update struct resident_page_types[] in
  * kernel/fork.c
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c7381fa38e22..3f99a38c58da 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -791,7 +791,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index a185cc75ff52..dd9e1e98bdec 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -119,10 +119,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_TLB_LOCAL_FLUSH_ALL,
 		NR_TLB_LOCAL_FLUSH_ONE,
 #endif /* CONFIG_DEBUG_TLBFLUSH */
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-		VMACACHE_FIND_CALLS,
-		VMACACHE_FIND_HITS,
-#endif
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
deleted file mode 100644
index 6fce268a4588..000000000000
--- a/include/linux/vmacache.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_VMACACHE_H
-#define __LINUX_VMACACHE_H
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-
-static inline void vmacache_flush(struct task_struct *tsk)
-{
-	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
-}
-
-extern void vmacache_update(unsigned long addr, struct vm_area_struct *new=
vma);
-extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
-						    unsigned long addr);
-
-#ifndef CONFIG_MMU
-extern struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long end);
-#endif
-
-static inline void vmacache_invalidate(struct mm_struct *mm)
-{
-	mm->vmacache_seqnum++;
-}
-
-#endif /* __LINUX_VMACACHE_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 241bd0f53fb9..fcd1b853cbed 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,12 +125,6 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-#define count_vm_vmacache_event(x) count_vm_event(x)
-#else
-#define count_vm_vmacache_event(x) do {} while (0)
-#endif
-
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
=20
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b4aa6bb6b2bd..6a99dd2c71dc 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -53,7 +53,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
=20
@@ -285,17 +284,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr=
)
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
=20
-	if (current->mm) {
-		int i;
-
-		for (i =3D 0; i < VMACACHE_SIZE; i++) {
-			if (!current->vmacache.vmas[i])
-				continue;
-			flush_cache_range(current->vmacache.vmas[i],
-					  addr, addr + BREAK_INSTR_SIZE);
-		}
-	}
-
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 4311715e9266..0c35460c092e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -42,7 +42,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -1094,7 +1093,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1491,9 +1489,6 @@ static int copy_mm(unsigned long clone_flags, struct =
task_struct *tsk)
 	if (!oldmm)
 		return 0;
=20
-	/* initialize the new vmacache entries */
-	vmacache_flush(tsk);
-
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm =3D oldmm;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cdfaafa30ba9..b9bf55a9c6bf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -799,16 +799,6 @@ config DEBUG_VM
=20
 	  If unsure, say N.
=20
-config DEBUG_VM_VMACACHE
-	bool "Debug VMA caching"
-	depends on DEBUG_VM
-	help
-	  Enable this to turn on VMA caching debug information. Doing so
-	  can cause significant overhead, so only enable it in non-production
-	  environments.
-
-	  If unsure, say N.
-
 config DEBUG_VM_RB
 	bool "Debug VM red-black trees"
 	depends on DEBUG_VM
diff --git a/mm/Makefile b/mm/Makefile
index 970604ea97dd..95810fb5e032 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -50,7 +50,7 @@ obj-y			:=3D filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o vmacache.o \
+			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
=20
diff --git a/mm/debug.c b/mm/debug.c
index e73fe0a8ec3d..f84662c87b4f 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -203,7 +203,7 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -231,7 +231,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index 060a372fc812..ed9a60d8a006 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -712,9 +711,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		/* Remove from mm linked list - also updates highest_vm_end */
 		__vma_unlink_list(mm, next);
=20
-		/* Kill the cache */
-		vmacache_invalidate(mm);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
=20
@@ -929,8 +925,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
=20
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2226,16 +2220,9 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, start_addr);
-	if (likely(vma))
-		return vma;
-
 	rcu_read_lock();
 	vma =3D mas_find(&mas, end_addr - 1);
 	rcu_read_unlock();
-	if (vma)
-		vmacache_update(mas.index, vma);
=20
 	return vma;
 }
@@ -2628,9 +2615,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
@@ -3010,7 +2994,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index eac5ca450bef..675aee78f8f2 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -19,7 +19,6 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
-#include <linux/vmacache.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/file.h>
@@ -586,22 +585,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
  */
 static void delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	int i;
-	struct address_space *mapping;
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct task_struct *curr =3D current;
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
-	mm->map_count--;
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		/* if the vma is cached, invalidate the entire cache */
-		if (curr->vmacache.vmas[i] =3D=3D vma) {
-			vmacache_invalidate(mm);
-			break;
-		}
-	}
+	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
+		struct address_space *mapping;
 		mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
@@ -613,7 +602,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(mm, vma);
+	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -638,18 +627,10 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
 	rcu_read_lock();
 	vma =3D mas_walk(&mas);
 	rcu_read_unlock();
=20
-	if (vma)
-		vmacache_update(addr, vma);
-
 	return vma;
 }
 EXPORT_SYMBOL(find_vma);
@@ -684,11 +665,6 @@ static struct vm_area_struct *find_vma_exact(struct mm=
_struct *mm,
 	unsigned long end =3D addr + len;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find_exact(mm, addr, end);
-	if (vma)
-		return vma;
-
 	rcu_read_lock();
 	vma =3D mas_walk(&mas);
 	rcu_read_unlock();
@@ -699,7 +675,6 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
struct *mm,
 	if (vma->vm_end !=3D end)
 		return NULL;
=20
-	vmacache_update(addr, vma);
 	return vma;
 }
=20
diff --git a/mm/vmacache.c b/mm/vmacache.c
deleted file mode 100644
index 01a6e6688ec1..000000000000
--- a/mm/vmacache.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Davidlohr Bueso.
- */
-#include <linux/sched/signal.h>
-#include <linux/sched/task.h>
-#include <linux/mm.h>
-#include <linux/vmacache.h>
-
-/*
- * Hash based on the pmd of addr if configured with MMU, which provides a =
good
- * hit rate for workloads with spatial locality.  Otherwise, use pages.
- */
-#ifdef CONFIG_MMU
-#define VMACACHE_SHIFT	PMD_SHIFT
-#else
-#define VMACACHE_SHIFT	PAGE_SHIFT
-#endif
-#define VMACACHE_HASH(addr) ((addr >> VMACACHE_SHIFT) & VMACACHE_MASK)
-
-/*
- * This task may be accessing a foreign mm via (for example)
- * get_user_pages()->find_vma().  The vmacache is task-local and this
- * task's vmacache pertains to a different mm (ie, its own).  There is
- * nothing we can do here.
- *
- * Also handle the case where a kernel thread has adopted this mm via
- * kthread_use_mm(). That kernel thread's vmacache is not applicable to th=
is mm.
- */
-static inline bool vmacache_valid_mm(struct mm_struct *mm)
-{
-	return current->mm =3D=3D mm && !(current->flags & PF_KTHREAD);
-}
-
-void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
-{
-	if (vmacache_valid_mm(newvma->vm_mm))
-		current->vmacache.vmas[VMACACHE_HASH(addr)] =3D newvma;
-}
-
-static bool vmacache_valid(struct mm_struct *mm)
-{
-	struct task_struct *curr;
-
-	if (!vmacache_valid_mm(mm))
-		return false;
-
-	curr =3D current;
-	if (mm->vmacache_seqnum !=3D curr->vmacache.seqnum) {
-		/*
-		 * First attempt will always be invalid, initialize
-		 * the new cache for this task here.
-		 */
-		curr->vmacache.seqnum =3D mm->vmacache_seqnum;
-		vmacache_flush(curr);
-		return false;
-	}
-	return true;
-}
-
-struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long a=
ddr)
-{
-	int idx =3D VMACACHE_HASH(addr);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma) {
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-			if (WARN_ON_ONCE(vma->vm_mm !=3D mm))
-				break;
-#endif
-			if (vma->vm_start <=3D addr && vma->vm_end > addr) {
-				count_vm_vmacache_event(VMACACHE_FIND_HITS);
-				return vma;
-			}
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-
-#ifndef CONFIG_MMU
-struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-	int idx =3D VMACACHE_HASH(start);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma && vma->vm_start =3D=3D start && vma->vm_end =3D=3D end) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-#endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3b6a69496f48..e536f9f9f569 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1369,10 +1369,6 @@ const char * const vmstat_text[] =3D {
 	"nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-	"vmacache_find_calls",
-	"vmacache_find_hits",
-#endif
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
--=20
2.30.2
