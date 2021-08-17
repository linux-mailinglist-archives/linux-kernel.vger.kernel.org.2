Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164013EEF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhHQPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:49:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22882 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240206AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkn1w017380;
        Tue, 17 Aug 2021 15:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pN5wCstuIcqVa9nLkCJOovfHCI6jkIFZQo3JtJdBTVA=;
 b=S9HnIf33FpeDcaEtwDseiP6Qka/vJZQuGeBPTiizQJ4mpRwdE29MlcZdjT1fUB7zYkqu
 FCpEdrphk5r1lO0TeRVjPzFD3Y0Fa/AQkICiMIQnONHuIC5wgjYKPSD6h0YyMu6LCOsc
 atFPY6U2Dc2lBW2MuBbZev1evhrxeN2yhlG3UpyixkwgVpbQUN7sNK6csNJ6ailOg6X1
 BEyMdWdGe6HF9OLTlyeP2n9eSMzxQnVedx0hgV7bCvd5B/IGWaDHmy8Pk1qCAcre6Vb8
 PRd3sYMGei3QCtFEk7jY9yBK0oRE3K7YtJCqU0WpbWJZx6wOPuuNgeCKuCD4UM5iVsWG Ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pN5wCstuIcqVa9nLkCJOovfHCI6jkIFZQo3JtJdBTVA=;
 b=HfYclZqggb6VKTkUmvkuVtO/SirbKAXu6Xd8XUQ0RE9wQvMEZ2fhYSS2Mq/DCCUYI3Vr
 /PHCZE0PD/nlrdcbAMZNm29Lv8DkzmY8/FGJA0iZGuJrxghFY/E460ObxgfSf0PR0isf
 1ttadkYHlMGnjwqYxbPjmxGiX/hylBdKTeC1YkuvgrlwXYsFbKn66nd4VeKvXakBsOTS
 IuFWvplGknT46vsvDDGTIDYJj5/v5Ex2jw8+mP87Ojg9X+ifYbgmpZ50M4R9yTrRHASs
 dyilAoE2rvSY3Dms3BNFMqVI0oJNaizlO9CgxG7eYNRcm94wD0C1IWObJS7fcfN5TKYV Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmhP158764;
        Tue, 17 Aug 2021 15:47:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3ae5n7su0r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyDhNajZJCusSpuXXZtVq5D3CT7eLOS9UKxvbSDTrstT7xCxrjp/MucHvK0o+wmSMNPKJcHurWlz7QclQqQ3/Jrk5Eaxtr9A4hzp8Od6/w+lPKHMVFx0DU8LPjUbwGdlREREymdqcD29esh4lXghnBp6356cg+fT9D8AhqxNtq7IVDxkeA5iMg8xoDwMi6HkTcfW+89+auD1MJwaWxPxbi5M5j1KkdS9Pri6pkUlF3uDWbx0ZiEcxnyk9R3TCflmrwVPyab5LurPQ9bb1vN6LmNcS+DN8G6E8fGOogDZvmNiQUVYl4MHkCWc7+3pj/t/b37wj0Y87KmQ3IqDjpHnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN5wCstuIcqVa9nLkCJOovfHCI6jkIFZQo3JtJdBTVA=;
 b=NbZbQKi/3Zs6QwvwTYRmknz+JwMxXrpxMHRkd4mTTjR6FUZM2PeOSfC+XcZbCpD58jVdCu2eHdByY0iAa9zf7ZJucaXa+sUYp+1BSMzalE3xN0xnSS1AfcSGZ3yI3V6RCdIEaULfN/aKyYM85nZ5o7sZ1nM9kyWJchuy3lKAcTU8msJnwEqewRBwKRy8Vr5JoGr60wo+9+rbYUWL3kNCsdTdvkLveY4uP8v4ywuN9hk8l3Z31Qgo0DRCYhtAJ8rzgsc9l5mQqxV7X4+2HCHsCp5EIcaZ2DpdZ1NXSaN7pVP1fIduGN/ItwZY6p6uwYzVLT6dsA0LF4wWtafOCdNleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN5wCstuIcqVa9nLkCJOovfHCI6jkIFZQo3JtJdBTVA=;
 b=hIivE/eeTT1cX9iDfiUyN7KNFREQoNf6SZxh6kiRvMpN2SBYcIdVn0mZJ59j8QoJHqHgIv+tTj94juHoGXUIMmGZi7uZGr2ofvBz88ajI6tjY0bwZO4KmtNVQJnqkXw19edwUpIrouhLrNFHdoEMfzsFhOMvmnVtHOFSGfjM7Nk=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:11 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:11 +0000
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
Subject: [PATCH v2 08/61] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v2 08/61] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHXk38kelZldq9nNU+hAT3iMDzzcA==
Date:   Tue, 17 Aug 2021 15:47:11 +0000
Message-ID: <20210817154651.1570984-9-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: b8b24bf5-99de-46c6-3c7d-08d96196474f
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB309757F73F45B52011F4566FFDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NB2hN+/YZVDTwR44SpRFpHJ0R4Jw0yxaaCgGXtuVD+N7fHQ12PnN2w3ahXzU4SrAD8WuJwiwPiHdSofA1KsaswKi2pHiaUhEmksBwOosjmi1V1NRgsQuFUGJjR8gScd1idNSNGInpDbLyIDTiBzBB2JPapnbH5aZvtf3OxP5BC0/sPbyYEF6CKHTZ/uV5iC6PgciLjSvmDVf+AxQ3gQWLY1O7349bpveZewmlu3dllTscE8gko1oNk31cQ/ZVOdkGg/hK9rt5ubQFLbWEwLgzYpjlCCYa8Uzs2UNXrT8v78fHZsznfdHCQ4zvLsRGxUnDX9+K8Smfd/R7lCTPxYoH4Xk6WR8g7zsvGtjTtidHYop5PA0ltbnellt0rOdL0DMoMmnAyshWZzqhiUwkO5/T29dXEVNHTB3rOgUP5eBrDY2OwFEqClXPoAtKvuZeur1goOKIeFkyCdZQNyHOO/n7MrThsZo/X9pCn5bR5m/l/LnU5Jz+Vij11Pdg/F2DgezOpwAYkErYyIFLeSL+/Ljy8MxYuu6Y07VFFgNl+Fp5EVecSfbIur0CRTVIRIq6yCcZ8Asgr2QMGmtm87YqHX+Jg86oqOCdF00oBWR5Ru8BskJtFyplyTyaGN5pOVzpKoV6UDNEjpn65GiObx49Rg7ZYB1s8MiHcYefJLBQj3mx25/C1+40ceK+tnV79t3p+ayGju6fUOi2FQ+t7bB66J9qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kb6GwWU0qOZ5vRgKVH9AF+Z8FFTUtEHfFtxYupy9NNtWlos5xF7T1170Tk?=
 =?iso-8859-1?Q?potrM1SdS8maDjR/wumZmLETRN4sjI+S+Nn+G+yIFqW8aK/ue5zZVES1/A?=
 =?iso-8859-1?Q?05+XH0ot+TMC7NPvagAbdEvk9+6eJNzHOfn82S5alPzfPFk82PNWcAh7U1?=
 =?iso-8859-1?Q?+P41iLp0emTIkhBt0TywntyTDTNs/qFeU22gPcYNrbzDmxuJqR8jVX0TDQ?=
 =?iso-8859-1?Q?S7LGbywBSWRAGArDHRDaoItcftBMXBjsScNYBICLEen0MQvsAbt9XIgWMq?=
 =?iso-8859-1?Q?FWccnqMf5o2Q8KcJ15291u8/pgLJGmG3cnFd7undP/1E+8g0kCqp8Wj9MI?=
 =?iso-8859-1?Q?iOFTQBLJhG9PcqSLfv+eJV5VwBK1Bic9TXEBeh3XIh7yKKocunkC+RIG11?=
 =?iso-8859-1?Q?2spgImce14DZ14wmCU4iDu6V6JEWf+pFKSY7Mi5eieOHg4I9J5HwQjFBpV?=
 =?iso-8859-1?Q?Hqy1uea6SaQKrjqFa0HskjW3YUPh6l5WOqfEtcxfvs4DmDKQQLdew1k+yH?=
 =?iso-8859-1?Q?0kVnJz7HPQvmb7bgDgr/P7V2ogQq9gzAOcpZQBYKINBuOogsUSedvHhVp0?=
 =?iso-8859-1?Q?Tve7QjNauZNhaw/nbWdwIDChVkjWnW6gXwjN0DZMLRjIDT6XedhDkSApfY?=
 =?iso-8859-1?Q?R643oU7oBHqSBIXuru1fTqKFyPaqILGnWbFZDoVBlblOow2qMiHnBwRSqQ?=
 =?iso-8859-1?Q?1uTpMdw++4RoEW03f8lYb00TLmeTTRkKOBgsD+iUB4eP40oOz0bSFHjlgQ?=
 =?iso-8859-1?Q?wmzLXLe8bXgd4gfU2va17IdYa1d3VPJrdnKmbDjLG5HxyCuG/b8MuKgFsl?=
 =?iso-8859-1?Q?0jRgDRrd/NR1hMuQqpwG6EmCl5LR5Dd0SRVTVEv3bpBPJTIDechrQkduxr?=
 =?iso-8859-1?Q?poQxEZKIMIF+t3C5d2dDvSjxY305qu41CyAfxHrH3lrW76IJjW7iS2lVqd?=
 =?iso-8859-1?Q?AYmJZj6v4dmr+evwfBP2ifRs9gOqTyDUai0NEp3NDe89pSf2SdAF2OM5xI?=
 =?iso-8859-1?Q?z5+cnERjpGVfla0B+Tb5PYM6GDHqOXvykJ+VE8XYjB8feogr3Ix8RvGgk1?=
 =?iso-8859-1?Q?bSljROk1WLhXQRwiEX2GVMvq+Q5OyaWqxRHoR2Lm+aJks7qrzQmO/rKWeS?=
 =?iso-8859-1?Q?zaifT1wpnVQ49yADPtgYPowsrbIkhTq7wWShf9htGhOwaiEh7dJRxiT92D?=
 =?iso-8859-1?Q?nyN00S3p/Te7iWSqwlHOXGzS1CwKhDy+bk9npw9ZvJhKixud3Yp+VMp1tM?=
 =?iso-8859-1?Q?3Xn2vBO0y4nTp1IZzCzMCOzEpSVJGdUqXPL9oPJGrYR4TqOlRArYGY0B3t?=
 =?iso-8859-1?Q?5N+mgjEe6Ce6AB9O6n8GZ+agLNalkMAjaWkqnLeqnOV3pZMCJcZecxeU8T?=
 =?iso-8859-1?Q?tA0OWx8gFr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b24bf5-99de-46c6-3c7d-08d96196474f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:11.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zEdIyFwT647wVdxqLVIGvOH8C155tAnPMWCvH3jqfns6MxaCYasUoX+hLpyyleP04txoS9+Vq11zws5+U4LTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: X_4sap5wlS_SvslnzvAsE39Rfv-NA5w7
X-Proofpoint-ORIG-GUID: X_4sap5wlS_SvslnzvAsE39Rfv-NA5w7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address or the next vma, then use the maple state to
walk back one entry to find the previous entry.  Note, the advanced
maple tree interface does not handle the rcu locking.

Add kernel documentation comments for this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 899747a75d5c..4d996ab2372a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2513,23 +2513,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
-			struct vm_area_struct **pprev)
+	      struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, ULONG_MAX);
+	if (!vma)
+		mas_reset(&mas);
=20
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return vma;
 }
=20
--=20
2.30.2
