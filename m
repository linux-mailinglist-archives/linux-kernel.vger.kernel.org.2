Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF8421C00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJEBfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65078 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231965AbhJEBdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950Cu36004475;
        Tue, 5 Oct 2021 01:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dmgE67kB1vB3Q9GzTHWkZY+nLfBn1Qmq0vReUL59erI=;
 b=CGTXmYSyU4D0xO1P85bCN5SBRUk4r/ESJe+kSL4d7zDGuw4+gZV692GDIiYMSHjIQoPf
 WB3l+EPN1PC4uhTRhjjxNBcwj47/zBZQ8hjMVdS/lA3xsWqZqWiAK1RNixl0fe8MeVqR
 MFDvnMWJHmI4Ps7D5RdmIXPQFB5cRLX5HkRCHZM0/0GUA5UkYkUByKbZNIpQCUvTm4NG
 Pjf7GZm71RIDgbIFtM9mrCAsjbt0ZMBjHC+Ho0trWpzvrpjll9ZabHKTNGAN1mr0hHfk
 7JGAPm/5V48GiAFeJBBAhpaOZdlXp4/GHya0G20lod4SSqrcdlPPUnaS58j9daTj2dTT iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UICm178521;
        Tue, 5 Oct 2021 01:31:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ek-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqVLlbMtJsLA1KBeUhIENKzm1+YVVuzDR1BpF+aJ7E4uXKMUF5qeD8ZYAFPWaiFxyVXYkbcgO1gO3Qcle8o2CwBpM8T3/BT/WLTsgVKKOhcQ+tRXzv06aIIrxKfYfkAvg7f1OPH4xrgnIGl2KNKni/5gAPGUwgRs8m8WNH6J2PUr6k2LEFeQ7secn0QG+sxWwgyZDCECcJ6uaibvAkZoECKU49svRngNBVMWhIxEoYmM9L3fD5PpHvMqb4wnr5gmy9X7cwJ4N11B51YHAseGCZQfWadBADeeGknetKCVqza5OJvLuNFH2mjNE8fZgd2c6HBbyZKGyQAWM8pJoJXTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmgE67kB1vB3Q9GzTHWkZY+nLfBn1Qmq0vReUL59erI=;
 b=E4IqIiYyd4VmRFbrkE5w+UFMnQXPFDh1+X11seUUegWUIl9weGh6RljNS6/yB2P75DtRHQ4hMuHX3PVcdzYZ70G3syRTkBDW4kNsaAYZAsRPg/Igw96ufoz+6fSku4AHhwmY2Y0YleLVgzwwg1QOxNFVZmRpgIGFla7Lu9OztSZkfBXDQ268GTkIuydTY3la8sErkvc1E3TH6w1PpOAD5oqHUHvWJSE0rqWi6k5YVfaj8LAwr5aAzg009UG9aXGmeVmNgck+G8S/JEVaVDEB2Z18Q7kHGBsNr+12Kz7cX26d65M6nUH0zrWxEl0Iez9QR2RsCpm0tXEuwUb4F5L9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmgE67kB1vB3Q9GzTHWkZY+nLfBn1Qmq0vReUL59erI=;
 b=dp8K+PgexmgIpImvw19fPHLq5t7T4VcpgEc0e0vN+hipSDsMfkfR58gZrH9vYGmJ69CrSZCIfQrJ4ly0+2vXipGvyYV26QQXxDi4CCIujyYpBDbdyUiwm7JfYrqVBjMqX/FXvGVQwGZKlmMxM9+lZPqAmWgNU36a/I4WpivaWN0=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:23 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 43/66] kernel/events/uprobes: Use maple tree iterators
 instead of linked list
Thread-Topic: [PATCH v3 43/66] kernel/events/uprobes: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXuYio7BNQ2U8LYkOB/BbE0Y/bQw==
Date:   Tue, 5 Oct 2021 01:31:02 +0000
Message-ID: <20211005012959.1110504-44-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 158b6116-ef9a-451d-8128-08d9879fd764
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504488E2D523ACE202D2D437FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owyuq365lAg8uljv9NkLIMRXbmE5qanUw2VYu55LrdvOY0Y23N1mZTlYpnHBENtxAROKJ4ISWe0YTN8/WOBt7gxkvKg2UjjipxaM2Uc95S7qDN4aakXW2fVUsrJHVry+heg7ImSe2b9lOIj7yQTozdBxEpWXM3P8ow9kzbOHs80pnDPCGB1k2rWFHRWWZQBfLbaP4lavjK7DqHBgHd3gMxhyIX0P/qYeE3dqIqNLcp8NgcSnpZjiy8Y3D21g5oa5Qvrd6R1VI/gUXw6texV7Xys9/L1XQJeF5Xs2BT9rpjBjiriXoKX0rod4rctVZi6oGMvy4B1NexkxH0B7kqutvlw7y2Ew87l+et7X19xmUnFl3R5XbWrby6X8V3zaua3lcSJ5K8HpUaiRccg1VDgHV6DDcsn4x36SWTAuPpvxujEgGCXbKmwsIHMLsC4MwbNrR7wyDEAADb1QNibaKyf8kKlDFJ4Cuqifff+wnNj3mH1rtVk+nuX6wgtoljpOTLyruvt4V8pKkfbsZ0jt8RY4jOF8M7qKVJ5AQ3ZZRw/11cqXge2gr4ToXG+NlRDQZxdm1ceHiJ/+s7eBXBWIqRKRGw4WtocqgEcN4zRmksEUWBHlQS4wj+640DWkJxdclLCRO1m2Y+h2Fz4YTBz/U7Vx68T6crK1E/k9gDouUAJbTEZIQCKfeyCXoRGedJHeoVF9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+OnSHVgHIMCXIMgDGZBx0ohbjt5jQEbsBnqBNQbpzwZhFsTKaP/uDf4oCx?=
 =?iso-8859-1?Q?vg9FOPToVUDIV/YxXKiO/IcJcmblUsyRJCdUOZPLsX27z9QJqD/UZw3FtV?=
 =?iso-8859-1?Q?Kqa3e99a7+v9tVP/JhBWHPD1epHsIn7W2nHAQ6j8qlzXQ1h+TxBn/CoS9C?=
 =?iso-8859-1?Q?zuiRKa0lU1/RrD16eygCNtNE23K9y76Yegu/U+0BGO4+xhsF7lNceXfXTW?=
 =?iso-8859-1?Q?E6kGAvMi3NDzjqz5UGvHj4PzY36PlHWeoaeHJD1uPaHMIOmG19Cl6lHyKZ?=
 =?iso-8859-1?Q?WGCckFJXTyGn+L7LfO/ou77xYw1QMmiVTqcauY05He4iIXjWKvetGVJrgQ?=
 =?iso-8859-1?Q?1JfaplwXs+f4lU/pwpPK81LlAvAN2CniDugeUxvq6v6YBpQM+8Mg4Vm4CQ?=
 =?iso-8859-1?Q?ML0a0MEiJUhRJ5HzOeC4eKCV+pvg0wv0ZPmpGFwqN4LmXDAicdJ5POdaN2?=
 =?iso-8859-1?Q?eC0ikKIqM01d0iChOW8JKOmM+e0+vTMWKiI0CtZW2mfWW8u7yrDmdhqhEY?=
 =?iso-8859-1?Q?qHmlFP+/puXIw0zQY3dE01ZIbzApg/Br2Lql2Mfkzf127tp/ED5OmOoUI2?=
 =?iso-8859-1?Q?T+cE1fyVH6IK6KXmmK/KMMGsTQ7rZnu/eH36H/bn3I0bWS8t1yIwcvO9Xa?=
 =?iso-8859-1?Q?/XOow2GPuxEHWSSz0IN0XTq/LzSRirRr8vLDK25QCaWEJnDqM1Q12Sd+ym?=
 =?iso-8859-1?Q?5QoMMpHNfgyJsLWzZaHsi4cICShxdX0zqrqlVUlFfHfCNOYPk5iN+m9xgk?=
 =?iso-8859-1?Q?iqETa2dGYR5vfLZ+kmwDbqZBw9Iy5rueiGUvt59r9depQT+323Hjvze1Op?=
 =?iso-8859-1?Q?bNPZVA3hLNmT+U3F8yZOd+joy0Hc/4gTKIDJLkzMs8NG9flTJiFM5oLMfo?=
 =?iso-8859-1?Q?eWeWpxC9vAS6S/bRdyvQOXkYH0eZlyhF4BBTVLoLwqD+4M24zFXuM5z+H6?=
 =?iso-8859-1?Q?fC7fAsZl1Rhu8QBgKaEmzM8gCpgmqm2vMMUZDv08ElA90rXOe6zhkXWZuD?=
 =?iso-8859-1?Q?5HVnrLAUWaMgDi9toL5vsuYCIsfult9d3afJLovbgyDeo7HVD7giKYrEm5?=
 =?iso-8859-1?Q?sJx9oSsf/07frm746RfuElS5Y0n3pGZxYAvL2iY4Bqqzzjfv8sghr7UwNg?=
 =?iso-8859-1?Q?mQfhLX4tXbk+CV/IjXtldHDSw5SOvu+xiJpznZ7MesLGIvbFbwf5L3SBJl?=
 =?iso-8859-1?Q?RxurotjF9MTYs5W9FxdOJXSgxF/f0tCsEugiH7SA5w/SSjqjMTXIVJuYK7?=
 =?iso-8859-1?Q?x8MjyQKGevRA4G2XK0DMhU1oUL9ClyF7g9yHlu5ax4A3fhFKJQUY/bKwAY?=
 =?iso-8859-1?Q?U9RVipQOt2dQ4mcnpN9/1M7s7bAhOY51CsPuBaCVCDQZrYBY5oSnra+xuc?=
 =?iso-8859-1?Q?3AUCJpXUxB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158b6116-ef9a-451d-8128-08d9879fd764
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:02.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l21TClPZlSn76onvnSxsdEYGhZR0DW4MbyFICniRAmZbTQJX+unC1AVCW3F0yNFdqcAsJyabxBNT2NNxDHuw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: lmy9Tn3zbAvE5HPq03OvfvYQL15zlT0_
X-Proofpoint-ORIG-GUID: lmy9Tn3zbAvE5HPq03OvfvYQL15zlT0_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/uprobes.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index af24dc3febbe..e0f8d813b066 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -355,13 +355,16 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
-	struct vm_area_struct *tmp;
+	struct vm_area_struct *tmp =3D NULL;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	rcu_read_lock();
+	mas_for_each(&mas, tmp, ULONG_MAX)
 		if (valid_ref_ctr_vma(uprobe, tmp))
-			return tmp;
+			break;
+	rcu_read_unlock();
=20
-	return NULL;
+	return tmp;
 }
=20
 static int
@@ -1238,9 +1241,10 @@ static int unapply_uprobe(struct uprobe *uprobe, str=
uct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	int err =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1989,8 +1993,10 @@ bool uprobe_deny_signal(void)
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
@@ -2000,10 +2006,15 @@ static void mmf_recalc_uprobes(struct mm_struct *mm=
)
 		 * Or this uprobe can be filtered out.
 		 */
 		if (vma_has_uprobes(vma, vma->vm_start, vma->vm_end))
-			return;
+			goto completed;
 	}
+	rcu_read_unlock();
=20
 	clear_bit(MMF_HAS_UPROBES, &mm->flags);
+	return;
+
+completed:
+	rcu_read_unlock();
 }
=20
 static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
--=20
2.30.2
