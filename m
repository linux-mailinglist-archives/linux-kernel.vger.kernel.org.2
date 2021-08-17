Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389FE3EEFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhHQPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13754 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240295AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHuO018094;
        Tue, 17 Aug 2021 15:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HxhWAXWM6y+VcWxUh9pcws20WJFjI02vkI/DDWpFO2w=;
 b=J94n37/Q9rCQCJtHZDImkByPIqC/xPMBbKA06ZmRNxqyrflcfHg+GngwtFAG58fcQbMu
 WQDVee42aMv4tzCJjOxtAYRJiKazYkdONawk4tMb4iuos6CjaBJ5NRTkeZ4yh/W6Qs7J
 C/MeXq/f6dTik6CCrWKW8uvrU06BTpLfA5+tKum+/BucgLHGX/M9I8QLCLt6XEVqBcok
 lzerGyzeZptkzdkGoDtmki7lGIZQ6xuQOLotopDwMMfnLdxK6oajhXM3oyUSi9tStO9I
 1t+93ENLBIHiGMiBiEAhDKfBw+l4ahIMdXgNn+yCR3JSW3AcLlgSmJSv2KzX8es9WllV 8Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HxhWAXWM6y+VcWxUh9pcws20WJFjI02vkI/DDWpFO2w=;
 b=oRRTclXQwZ5huIyhmFMWegGFMIp9o139xC2mP9IIBnEBzaZPIwUZuDL/hukP5eOz8fdA
 /ZEjYBa6Fh92mJJ9NXftRyyxhMoR6sqoM7Iekuw0DvEEGsjJW2kGw3Qng5fZDFr/AqFR
 Ra9pKz9rvo76mxdX5LNsgHFHj/dyZtskEgMpua0QFxQmRBOIy2pIb0Tpfn9MP2i1uTKW
 beorVNdhQI4nm/y5QgVCLEDLiJfVyLi30wnN3qljuhnIP5YJBjSsK3Rl0NdBs0+zkoom
 vIiHbr/LBauAjRPxK+lYDrr4LTyOysyGYWU4TOXGxLKh+J6PfaIb1kCxVKxBuZCsif6x rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfY158706;
        Tue, 17 Aug 2021 15:47:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ugn47v66N+K2H/EOlJ9Y0bq93yQwQdiFkicIaOvGqKiIDHen2BTrv01pIyrM9P9+yTcm6tBz7aWHJ9FFzy60opVQLaJMkLTowpiW59IwrTB2ATc6ePkRLguyIDbi833UqavciaaRcYP0jAkBECPkpXw02bqwyALUJrNtAoHU1PD/tP7TH3g5kjxxUNMXEaUfTuGMKcqBx7CKxZGqHQhM57zIi70aJTn+X+qa4BoTIgDYHtMfp1apk/nwqGAtj7otB6jE2y5z9eRItoPBnvt57rKlr4S8WOMoXf75vxOjYCk80aD2CKIAtV033k+YtRVQOcO8DtGgG5tOJhd8IvwbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxhWAXWM6y+VcWxUh9pcws20WJFjI02vkI/DDWpFO2w=;
 b=OMQ7nTKl3uYskfYt/B+J4ekijOjKbmNnRhTxpSFuke0LSdWd/geMlcGbMCofosRAdNxuV1IPqBPdrNbakKQfFTmdba0qFddNuB0TLmC45E2hdAChp4QGnx/YBNJUSOGxDa8xecK89e0Y9cEaJFuPIzNtsToE2pQHowm3ZQ79kgefJoEoPvIhkhB59k+7IvUDHjzvFPLYEh5OgdIsO4DsMU3AxxyAOAjLg/O6TW1mEr0WWFtE0+rOSc9eESRDgRkds3RhNZkopmBYy9OkDvn4zVK/Eulw1186Gu2CJfWOTKu0jigdyZQB5zmvxbnaK5Y1sKOJsaYEdTHlF5y3ZDGbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxhWAXWM6y+VcWxUh9pcws20WJFjI02vkI/DDWpFO2w=;
 b=p1mFKy4xh7yY0agXMIfrArFdQMDuEm1c58I+8ZAI0LtihShqAG7P4+Aql20GdRQ/QDQeaM+g6Y/cKX6O6lrTt765Yg3i5W8fxZAKDd3Xmdw5HUTCOFU4OoV35RbHm4vAZ+ktLgC5Rlb8m5rCMu+J1tUEufX28nwbkEd9PdgNA2M=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:55 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:55 +0000
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
Subject: [PATCH v2 42/61] kernel/events/uprobes: Use maple tree iterators
 instead of linked list
Thread-Topic: [PATCH v2 42/61] kernel/events/uprobes: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXk38v1bB41oM6GUqmNEwJx9iYpA==
Date:   Tue, 17 Aug 2021 15:47:29 +0000
Message-ID: <20210817154651.1570984-43-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 95450c6d-7254-448b-fd2f-08d96196610e
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580165630E253FC72BC848DFDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gBgFrmRgDMZJC+jtwRgWdiMXpTbYXEF8nWX/ZNZgjQjbiy/rY/nNb8y4L20AcGbjfk2cnDk9Mle/2zYITROUSyXaHDFZrJdBhKo326+/C1Ah/CyvajKXBKP6PtyPTmwWSs5oS07jaD9GlbgHlNxj319olEgDm9Cz2kqsFqme0V19iJ3/2Z91S10HVev2qfr+KG2ybwhbSl2YFWlmj4SnIsrMxmZ5/ziyRho9waIL7/4CM4PfpHvm0FufeKZ19Z6Z1o4UVxVus92yySLRb75wrbwSYzK09Pv+2lfsWLgTz2RZUAb2klz0U1ucgvPrVDbIvT4ocrOdIc4mNZpdayHlxRiCvMoCN+Ydj1UcAdudYLxnYo9hf0hNrkyKZN175pfpsX7UbCCgPkfhqSdPpC3hX2/Q045dIR+3By60tykA4nmVflx55QWZVkXDr3udbL2sTcxbN0VI8cLdbHhGFg23CDIpfKgKz2djzpZO1I6OP1eh5R2ktER14zp018/COlpi7DtRXRONNfsVlL+HDsTS12+eEdW4iTGjn1iyTdpDIvbxc/0p7+O4weaCO0+y1GoUZcD2dgEGD20KKgcBPtpuY1rmuVlbMhekQjOOJwGCrTXsPwi8lpePFt0WSLkDh7uIAqxoLF9POeQH3Q0XHmEFla63M6jifKVFtFUpn3ILNCUlen8hDdvoWKw9u1FuGtJK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hTo7CjS/E4gbu1uMnJdyKYpForaLZ0hmoYYOzk9SzFHf2c4tsb4qr2H1g8?=
 =?iso-8859-1?Q?ZfsV7XcYeDWX+SUzr1gE5g+36dXhghhNcr9tQP+O64th96c/1KyDn2RvbN?=
 =?iso-8859-1?Q?hFX2eycAqdRxbhIrvBYCmjUaqKraP84yITJAlgTcdm0KGWAfVM7dwKb88W?=
 =?iso-8859-1?Q?ZObDnsq9MQuIwQYeFo7gYRbQTdbCZ3DnKf3aOlBDKsjnj5fcfThOEsFke8?=
 =?iso-8859-1?Q?FI8HkshsRB6r/mLPKhmx/wuqYQnxUkp9TxYHm011rxMnRM3LIR/ueCkYdP?=
 =?iso-8859-1?Q?xq6QMjEWFeoK9OKGUR0HvAVuFZgoGEEI9naOd1ZZfAeGhCV8J3hW3sfmEc?=
 =?iso-8859-1?Q?9yE70M18Jz48/8AC1DuObw7Y2yb464BP/CAoJfVtuY/oC/TJQdTMsK3oZX?=
 =?iso-8859-1?Q?KkCp35Xv+L48ZKlgktLzQNciKuIrPPYzj5pMWmWth744O2PuqNxQ49+RlF?=
 =?iso-8859-1?Q?S9MlBp9dlUVZAID8pyBpP7EVOCoCx94X4SYt0aFQ/vOXSTjGWaJYRe42Zk?=
 =?iso-8859-1?Q?AkycAbW1lc3s7kGak3A5E+CK6LkqEzjWp6W15f0RXZVY7b0pthtJ0NKJYH?=
 =?iso-8859-1?Q?Gq47E7BAKILxEpskUuXPWdZX+dPcAsUYWP2IccN7ak9fRWqS0eB0GjNgNB?=
 =?iso-8859-1?Q?Rd2csUf4RcL0yWqyUnCiinnk2j0QFG/1EZLrL5Tej67Rf8qE1Rm/2qfNlf?=
 =?iso-8859-1?Q?N7FV2mrfB8JHm85FlezqvKhNukKvp06ixKhWI36xlxAcQJnFdqisjhV5OW?=
 =?iso-8859-1?Q?+Ws7HHMK6YfSR81DGMc5eXL386b6J2d3qaglV6zZZm714U35chFEKxzNtn?=
 =?iso-8859-1?Q?+e/r6hkRXd5X0tTt+hBzz9TKgpWW4Q3gl3Ms6shQ+QWANxqLbdWsLJP2/9?=
 =?iso-8859-1?Q?oHA2TnFLinCpF19roI2WY1kTsLQwuvV684ixToVhD5NnRdH6xLvQMfUa7W?=
 =?iso-8859-1?Q?acHF2CHo6h0uUBMvMBPY4Zalgn1TJThrCFmwrrkam4540+ovIrbkhmIma4?=
 =?iso-8859-1?Q?DuhauJ/6RKn7c+NVVvdllcJXJrMOtytcOIp2R2ehm+IMswOs2P974EST+o?=
 =?iso-8859-1?Q?MrMnAG/Fl6sM0zU3A/rzYZDUytn5sMR1cCFkDoJXT3VAkXs7oz9Gw+u521?=
 =?iso-8859-1?Q?/KLtqi6k5lKTh8xGJ2wrK7hhKht8RNzNFqlQx2i4rTdk6PfVK8OVyc3C6g?=
 =?iso-8859-1?Q?Tkd6EQP9ItKET/+rIfv1SYGnl3tP+3uga6vw++/TQf7TJZwC6AVZAv50Ph?=
 =?iso-8859-1?Q?7RPuGGt1a3WJmU/g5uwRWl22RuGKf/G95PwUNFRirN4kmEYV0fSw1+rgDD?=
 =?iso-8859-1?Q?NyZ92FFl/LMB6F+fDIHXB09rta9EjB4/kUlV1ArVXghrVfQ+8uqi1RsHB6?=
 =?iso-8859-1?Q?n+wdMK2GxP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95450c6d-7254-448b-fd2f-08d96196610e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:29.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaNUxdIRviYQsUFYPYWiDI21EmPPHoegKGedpogip25Ntkum+S+xmFYmS4GbHdLubJCy5OUbG1J3bZMbmVfy8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: GrMSaUNWps6M1wbVtEMc5KOkwCMZeusm
X-Proofpoint-GUID: GrMSaUNWps6M1wbVtEMc5KOkwCMZeusm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/uprobes.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..40f5a07d8f16 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -356,13 +356,16 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
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
@@ -1239,9 +1242,10 @@ static int unapply_uprobe(struct uprobe *uprobe, str=
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
@@ -1990,8 +1994,10 @@ bool uprobe_deny_signal(void)
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
@@ -2001,10 +2007,15 @@ static void mmf_recalc_uprobes(struct mm_struct *mm=
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
