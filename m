Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20DD3EEFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhHQPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:52:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41954 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238138AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkEMI023526;
        Tue, 17 Aug 2021 15:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nppClKEtVsWtXLp/qb5jRGCAwLDh7UoOZBuInh9EDCI=;
 b=ikk3XC6SSkO5kMZn/NL6tnbN9Vq/8DtNAth9tc8DrihYPUP4a2mA1GRfRAssgqF93qn/
 iL2IUObmIGdR8mVN4VHrBTf9ckHYLRNpjM1HPULoEydC5qSgABomIAVsiccmEHS6lSVP
 W8AHrTMCNiYSPoF2NAUjDPzldSSykbhPZzxF+slAxKjdvYkr5FMe6hVGZWgqmZzLD8Cr
 o7P93zzXMHyZVB3HMRlV3eaNI4oyDqYbw69pwb1eNcFzPGxUVhLAvShVva4Pjsvd5Pfm
 Hx603xPn6WkMFYFeNaMr9HYVvBVCbZ63JOHqH7F+WgBh2qZ7VGIXqSRcY4fPMEEQcopj ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nppClKEtVsWtXLp/qb5jRGCAwLDh7UoOZBuInh9EDCI=;
 b=f3KGZT7mDHBBkTsN9H7iumqRsZmzz3FrrhWuF9p7wrH35D6/3wRpj+O5G8Oa8DPHY15H
 S2oIIGr/LD/CGxwuxuA2Cbm14JUdm8PqAKHE1mBgSr9dVkWmaB7RzZTir5FChOaNyV2V
 F/WrJEtZbv4eZU8CeqejnnAvkoszda9Z4/AzVziUfT3VCDJ+6EVQS6SaXg4eUSb/6LfG
 z6JaP2EGF4Kg8oNigBCi7GCvH9mPuuFrGZb/ONLz1JUvJrITLj/R/tEtIrxBTDvBiht6
 4nQeFkbe8KMaT6zIeL9Cd7E92UQApdkkweZ72qBZeWy7Z3pkkPTP4W3Zqd67BSU0vNea EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf1158706;
        Tue, 17 Aug 2021 15:47:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA/RtykRTQuakEu1lvsxnLzyISEP39lCx+bnE70njMEqcNtQ44JcMrlPWA031i3fVyPVwTPMQOc/csJFoB4TEaI318tHjFyJTIDKBaULrVYqeb+NbhbtZNOsGo9zJIUuM1N6g+OXZv5wxxECDwIjOZMh8XuV/vG2Lg9MtXDCFo/pn22F6eAqkDuKzE5PsaW+bzKdLu3WKKmgW7PF87kHUWBJpnDRXrT5BGdyPHBxRreVW9Z7n1rjbebH/FdWmBC/GoG9vti+B7KZitw5+w5RRaH5uwqcJFnyTwv5IE/5jqsB6JufEohtQfD5mNu3rsG8NpRLWPEwefetKAbR3DuiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nppClKEtVsWtXLp/qb5jRGCAwLDh7UoOZBuInh9EDCI=;
 b=gjQn981FempcKXrqa9GNhhiwLGWZloYrXbPJB3f9VMRAIWYDn0GUn0qX65XXRqkAuLZZDyBXS8J89qQllg7UUJxkGC13KOuPv4eFI3YAFqLqWhoYKnJf2iNBLO8JssGTxh2jAuvKVoHK6bLFzSBlX+kZn184AXVzUVG69mS3cVvUym8sXlGnxNwNrOL6Y8x0lX3Kz8okGgEM4RjDYEoicERcNE+CbXwOGF6ZFA19Ztd2VkQVdyrfUB4TTmmCwR//meBNujWzyLbdki1svOUBRZOIKxcGus7IFwP7+tX2xLDBtjSDFZjcZ7coGji7UofOCrB2l0MEiehEPGCOAf1FaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nppClKEtVsWtXLp/qb5jRGCAwLDh7UoOZBuInh9EDCI=;
 b=lQKGapjgZVLEVuFdoI32RJcFA/IQfZ2ylw809FGr6r+QWn8uMmyBt8OfU+loTOS354938Izd7IiV9NLpSjUb21/41bR+bY3ZRL38ZdLVZZj8WntVU/t8IETyT8o9GF70mcPuPC/1pWOXkQ4McRy2XgDZnrXrOnuLNDHq8kOGZVI=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:12 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:12 +0000
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
Subject: [PATCH v2 10/61] kernel/fork: Use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v2 10/61] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHXk38k0JUHaKd/aEyW/GzwRyUQFQ==
Date:   Tue, 17 Aug 2021 15:47:11 +0000
Message-ID: <20210817154651.1570984-11-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: dd8cb4cc-1645-49ca-0ba4-08d96196479b
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423622855AFBD51633A69F43FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVS5bZNICdKl58VyODBMzxKvdiT9VnZdnZHOaB5SREfNoE3GaXsOY/2Rn61HOgJ4JNbXUfHoDc2D7J7nuSKFKLlubGHJwsWgq/z+THhHHhswQksnoa5IZhBM7nWIB7rkkp5hukk6DM/pSmlABu9qJR1wP6BVcNAHYYbQzoZBhmoAWtxjlXmE8JD0GAG7qTUbHCZK89xmFeU6OGDvJbG/Kf6XD7koGJy3A03O8O/lJZEkMkbKtSdj4s9VSI7nr+cwI32heQasCYYdz36aPZJemQU6QVUM5C0FyWfezFZygVZeBAujEx9gqKSLXMyId4b187dI2v2sMMMKasjcQyoHpZHP1Yr1CKhkxqDqY/z5ewTYFM7noAOp5aBo23UuVCh7MoK8lhdB/rxLwq0sduhk+kOQRfXxNXU1KVESJppPLUDkgg4XimMaVmo8GhZ85u0s9wMCsTNVcS9kMQN/YVWrL5kZMCo1bjmMwca8yqPpFBuioh0TuyxcQFuesL6aYNwbKePOT2OBgaEv+rBWOVKGJHAShQ1K3qmQpJKHgtjt8Yk35yDU0JXpHGUyHe9S0C9sEMOb9U60q2/bVn/h2e1HS/xZ3zaUglFHKbYgK09TzL4C73eT0Od6/bwwvs12s4G5Ps2nFjuUNauLM4s3sHAeZh96DBEZMIL19C9fYfFa7ZdsS5fnYo8bIf9WDDY7r5JLMtv2fEsRCL4O4j50niEZfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sw1ODl91Izzvl+7uA22EudtTt0lvlofCHwfS0lGIyscqazaUVGP2moMUE1?=
 =?iso-8859-1?Q?xg9Ivle13sKH72dA5bQVwdCqOzMxWpJXRN1C5RM1QBSChJIOF6y8oi7qWt?=
 =?iso-8859-1?Q?Q2+BKvYb6rGxLQyMQMuQrCjFg/Ma51By7QlvVsbJ5UnqQJOW5DY5DCt9te?=
 =?iso-8859-1?Q?SMnWvSBvEIdu6gUmOI2Kob+/FXEefEsT84SpSYto+lL7bNAb2KduxQDT6w?=
 =?iso-8859-1?Q?zJD2O1ZX6WN5vCfObO5GWjh1c+XmNBbpWO2QotuwnRWSonC9ubAs2zVmys?=
 =?iso-8859-1?Q?6ZVIcxSebHu5ZZzFrdM8UaSXB6P7QoySXhtkKVUkixqAV0c+7tagu07A9R?=
 =?iso-8859-1?Q?ntMGXn8sfwdNv45CWp733fc6pkVzR2zXqz7BnEGE7mCzk2EYHYLU0tcCVp?=
 =?iso-8859-1?Q?yRCtuxLdszY78JqtOdSM8s9xPKMbHFaM7JmdWFO0rlshau9oElxXXtcaEx?=
 =?iso-8859-1?Q?24YmVQjIfT3Kb2x3V58bikqn+CRrS8g3WIpLHg3m6B0wOWZKuPkwL1W5Ag?=
 =?iso-8859-1?Q?iKiYK0SraOkCW4FwqCrDeAlHJbkQ6weN+pS8lqRvSDDEV4VrOD3oIeek1S?=
 =?iso-8859-1?Q?hxHnsKViNeRLbSuOpUGmhE819GlKkgakxrxhUsZw4g53kuyIHFCwdECpQF?=
 =?iso-8859-1?Q?Jq5nauPygtGBIll+ISCHRaiRYLsDm4ewMSqL/Ps7mcG0qFWwgL2e5NeC+4?=
 =?iso-8859-1?Q?UDoVPaVxRkc/czVRWy+IDxsEdGx10KLUbWA/I6b/1cXpb2nFgen2AYkxOp?=
 =?iso-8859-1?Q?3N6K/PZEXSg0Y5FyoMQS4H+HkiaGUXdNYfsZfMgAb7mqXH7cpWklNZOdxL?=
 =?iso-8859-1?Q?N/4Shp4JShpYroS16i5muLGeEGHWvMwyTX//0bUjoGzAv5ojxYcT7yqf4I?=
 =?iso-8859-1?Q?QU1Ciby4EeftIAp6jwJTTo91ruzwZTd1904DKgPYEu25wCdSv04x/tqp5I?=
 =?iso-8859-1?Q?upJjr8X7LooPnqZKGxE7NTFnXckB8l+854kWYyxDMo8hH4SIntFXjgknYr?=
 =?iso-8859-1?Q?j6Ply7xxFAt58V0ygprNvFRb/gIueTgx+Ya/z+sQ45RetQXMcRt0kBkoMv?=
 =?iso-8859-1?Q?dA8akjR0zWIXcGWwGAnRybxSsnWjptwpcFibjSP6u60wRbYaU81K8aI7EN?=
 =?iso-8859-1?Q?cTMqYQoHdBAvxOH0DMJ9cbWc1iHymp6fALPfYbiJXl7xAIqNL2620rzCDh?=
 =?iso-8859-1?Q?La/iWuSHf+041ddDdJkqTfYT6kfp9HqHnp+nmMmDFlojQAEqFhJvfjmySr?=
 =?iso-8859-1?Q?j0bJL0oUHpF+4FUdtPUgRQRJXcxtughA57dER5q7VjUNq6/NsfRkGY53jv?=
 =?iso-8859-1?Q?ForCho/BQ2G9R80lYcXLKFabe05gNwXAOK9aMYviTMXhLH1yLSYnkzvedg?=
 =?iso-8859-1?Q?7exQLG5o6+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8cb4cc-1645-49ca-0ba4-08d96196479b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:11.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/ORB5i0gjLRgoDa+tVddSKxhb7eV1MaGOLZ9Uz1hVUz/wJKmLkZjJ5IaQc9rGwjkGgPzVOSvnEHAg4+4+Xp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: -xgDUg-_sf2kMhuD05Qe-4psReFcvqGp
X-Proofpoint-GUID: -xgDUg-_sf2kMhuD05Qe-4psReFcvqGp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator, rcu locking,
and switch to the maple tree advanced API to avoid multiple walks of the
tree during insert operations.

anon_vma_fork() may enter the slow path and cause a schedule() call to
cause rcu issues.  Drop the rcu lock and reacquiring the lock.  There is
no harm in this approach as the mmap_sem is taken for write/read and
held across the schedule() call so the VMAs will not change.

Note that the bulk allocation of nodes is also happening here for
performance reasons.  The node calculations are done internally to the
tree and use the VMA count and assume the worst-case node requirements.
The VM_DONT_COPY flag does not allow for the most efficient copy method
of the tree and so a bulk loading algorithm is used.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h       |  2 --
 include/linux/sched/mm.h |  9 +++++++++
 kernel/fork.c            | 35 +++++++++++++++++++++++++++++------
 mm/mmap.c                |  4 ----
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80b7af9e725c..ce8fc0fd6d6e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2596,8 +2596,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* maple_tree */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index fd6e4d14f477..0b8a4f07f3f8 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/maple_tree.h>
=20
 /*
  * Routines for handling mm_structs
@@ -88,11 +89,19 @@ static inline void mmdrop_lazy_tlb(struct mm_struct *mm=
)
  */
 static inline void mmget(struct mm_struct *mm)
 {
+	mt_set_in_rcu(&mm->mm_mt);
 	atomic_inc(&mm->mm_users);
 }
=20
 static inline bool mmget_not_zero(struct mm_struct *mm)
 {
+	/*
+	 * There is a race below during task tear down that can cause the maple
+	 * tree to enter rcu mode with only a single user.  If this race
+	 * happens, the result would be that the maple tree nodes would remain
+	 * active for an extra RCU read cycle.
+	 */
+	mt_set_in_rcu(&mm->mm_mt);
 	return atomic_inc_not_zero(&mm->mm_users);
 }
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index 1da5c1b20a60..9ef5661abbd1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -477,7 +477,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
@@ -511,11 +513,19 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_entry_count(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	rcu_read_lock();
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
+		rcu_read_unlock();
 		if (mpnt->vm_flags & VM_DONTCOPY) {
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
+			rcu_read_lock();
 			continue;
 		}
 		charge =3D 0;
@@ -525,7 +535,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -553,6 +563,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 			tmp->anon_vma =3D NULL;
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
+
 		tmp->vm_flags &=3D ~(VM_LOCKED | VM_LOCKONFAULT);
 		file =3D tmp->vm_file;
 		if (file) {
@@ -594,7 +605,11 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas_lock(&mas);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
+		mas_unlock(&mas);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -604,10 +619,17 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
+
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	rcu_read_lock();
+	mas_destroy(&mas);
+	rcu_read_unlock();
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -623,7 +645,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
@@ -1149,6 +1171,7 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
=20
+	mt_clear_in_rcu(&mm->mm_mt);
 	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index fac6e2554351..cec8ba0b598f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -786,10 +786,6 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area=
_struct *vma)
 		GFP_KERNEL);
 }
=20
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma) {
-	vma_mt_store(mm, vma);
-}
-
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
--=20
2.30.2
