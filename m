Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C23798CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhEJVLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:11:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43492 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhEJVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:11:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AL5lL6126973;
        Mon, 10 May 2021 21:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=+6Oyk1FYt5s00RL/tqmJ/7ajITuvnolf7pQNq81xC1U=;
 b=GR76XGL1z3sVrU38GL0GoQhdxKEzjmkxsmX2ovo5HdiDl2dydCFP0FEIT3VoZpzU8pRT
 y2wzevfoWzRvrvx84IIrr7wS0FovOhYTxiQjm/36uUCx29Sf1JkbODcGVQf5FR9U577T
 AGaImVd4zVFZhLWNn46oZFJ/prOdzjqPJRMSscG2AYmLi3N4SUa1jNd6JhTtu+qua3+p
 /EOTtMwHTHiHBBs1rBDkOchI6X5rusqhfhC0vY7iGetIQUhmMw76qbHsb7z6O33juIMD
 dKw2buIQimVHTccit/WeVKQtO4y9Kf74accFPe58Z9rbS/TZ3FH2HAiCQ1VRBbODNbaw iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38dg5bctey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 21:10:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AL9l0Z062150;
        Mon, 10 May 2021 21:10:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 38e5pw0qrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 21:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WypuAJbGYtOVujV+MCWNsEC8cMe10TDuyQWqPzUVQ6DLvXq5YBWDWI8gw9GthV3sFmXR3EY6tbfQkktiu+NKCI6AWQAL6RYNNTbw6AdBn9lXqY9XCoS0PiL+dzuBHnHQwSzHHiY4qb8w63en8TTj7a23kKExQlQMtYdmn8Xp9hvmJDseFcHu5WccrFqJZSxNAt/yGHuslEQtzICVTRmfg2iiumeaRSnR9tzfzv++BTGTfg8NPTxUCK5vZuOnSzL9T+UAZHha1sdHBb1Rn6lnYuFH8NF3CVD1HRVAZFmYLG4ZRrW0ARiQBL2Rn1/MVakWjHNZTHRpbB4TheGLCQElmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Oyk1FYt5s00RL/tqmJ/7ajITuvnolf7pQNq81xC1U=;
 b=fgI/mm+iZPy6huSD18oUPps2Kxq7cDMC0u2jjw7aiYx/BKNeb3Vw08oI6A56pWtlbDVTTVNHDrGqWgGmmhLBiJNeL5J3nUee+b4bDCrt/wUfHlM9IaLSY+WcYoxRYclk1lGKwIUE0q/Bo4d/6D460i2dauw1tWlxTT9NpRI3pGIUn+ca8778om73hbTtWaSI1VmmxMbiBe0DphhHwr8cs84lU/hC12diGqyF7p/k6QS4ajzxtBdt+cs5JjJ4V5EY3LsPbKDKJNbjmOsdzB+vhCPUjfbQu3FWL1L3E8iGhAq9yUE+xaqzRFOlyX+LCnZKBhVbnze/iRVGXin9K1Xicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Oyk1FYt5s00RL/tqmJ/7ajITuvnolf7pQNq81xC1U=;
 b=JL5cJ41R6I6QzKysa9nO8A5BScOakkx0Qdvx/y4WZpUXKjASUZyLVx7jGNT1+N/XaAQu3W7xsIjNQAXEkxEkm/QC9WjMEPkR/yG9JoKJdK9yqk+lLkEWrLm0GID7NXVbwRgk3NcCCgk2d9Hoc61OuCrATsc8mAknExr1aDat16o=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1983.namprd10.prod.outlook.com (2603:10b6:300:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 21:10:27 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 21:10:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Topic: [PATCH v2] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Index: AQHXReDmp6/TkGiktUyg78V+0vP0Hg==
Date:   Mon, 10 May 2021 21:10:27 +0000
Message-ID: <20210510211021.2797427-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28d2b24b-535b-47c0-3abb-08d913f80940
x-ms-traffictypediagnostic: MWHPR10MB1983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB19838AD1127379405ACCAE4FFD549@MWHPR10MB1983.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +F5eB1z71vuICUiHuzBYuqNA4IEwKIjvhybqkjwXR2BebCk5tGPnuOd6FqKmgXiBZ76cHidIEywLBeWgwP0fiQ0+vMmL7d6GN5PfcCWB2KpRm+qPVES3H91Djr27f7LCtQnYjLkzOzWgHgDWuYFtV8qu44YB9/z2akMmY3TWg3Zlj2kYE7YWm2jKcRBNUmavBpCf6fwFBxcgFBUtNHr/7PcPAG3qDpkKfFRv8tppwG/rjMQU/EA1I5qicHtMsgMaji4yjx32loGdaWzt1Gh8b6U+V4faXb/Th9u+k8Xqi4FCmLuRSAWQ5L02sl7n5h4AK2joDvM8nAXFOZMs/HSVFfnu9Z4gFMgYvNtyoeDlegiVKlVbh7zpAZ/aaJNek9EnIu6bPLd6KKYpmLR2z7FtXGLd7pDqSH9wbZ1Dl7+ZGKOFD/PgcbzwfjwhVODjqfONhEcdRzuG0WMe/BZud869L2FWszFKbEhV6jq3TgjdH1KTzdytSrDUkEHKC78P6LwhYfeHrOAcWfYsMM6bbbS5/x69T/wN+uCD1Id2sx0MhpyIVmq40UkAr418lLWI2+zgv6VIzzLzWc+/jY1gpqrJ7QvSHY98APwERN160hFKgtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(66446008)(186003)(91956017)(54906003)(86362001)(36756003)(5660300002)(26005)(316002)(478600001)(71200400001)(110136005)(66556008)(38100700002)(2906002)(122000001)(8936002)(8676002)(83380400001)(6506007)(6512007)(1076003)(66946007)(66476007)(6486002)(76116006)(64756008)(4326008)(2616005)(107886003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?x3cLafRdwtq3HgtNrxEb4e5QSmtbDn1nuskC9Vg368/eFj4VnNJXjNjbYr?=
 =?iso-8859-1?Q?QB7GFl0G2643KPVz4aKymddejH8E9XBnzn9zuSqks/5RY3cqxMSTPsm+Lf?=
 =?iso-8859-1?Q?HoX2EEzJ/lMD0VFnEEJTKX3Ub3bCPOtQ/IHWgjtlz3zPEcwGrM61+jjx/n?=
 =?iso-8859-1?Q?tfQQrWjSFdwRcY/LPbb8cNcf7TasRsi/QZ7HnDXBIUSv5uMBG0vKs0taBL?=
 =?iso-8859-1?Q?MWnDjEJgaManKUEJYith2bTd6YvXwFgL3BA9kvqBiItx5lHdufUgUAAaWG?=
 =?iso-8859-1?Q?xKRBX7DgIQ8XlxR4vbtG76keZoqxLrFKV//gUA4fIurcUF3eCKzIgZpqN7?=
 =?iso-8859-1?Q?yzZ5A45KitX3frvpP76/cdVatLcnh/wFVaGZncKTS3PDc4Q5rQKxjSoFvu?=
 =?iso-8859-1?Q?wP81YfVut+GTyY/5WG0CabMnYlcdOOVmzR9jASHLNbEFl93rRlnpdOSnTw?=
 =?iso-8859-1?Q?+VvEN9Sb0xXeNwTnuzgYKLhj43rhbnmUF2xdFWN+xmuhMF3F2IIk21vwwX?=
 =?iso-8859-1?Q?NWHKY3Vr7xPVc2aFhdZjXU6lmNcWDzVsyq7XBSHl8nnSzuigs1rzVscLxD?=
 =?iso-8859-1?Q?Etn/eeEq5HRjQpDbAi4Z9RHTZc6w9DrhW+EpkAi/PEL1loWKXVbsFIGz6S?=
 =?iso-8859-1?Q?M6pjGRBW3XLBjz6pawovP5WuhHTaDhic8hBX7YGF2Fkd5cNgjmnYs6qYE5?=
 =?iso-8859-1?Q?cybHQZ3peXQ2ZS1uQv59VlSNFdNaqOhx8HcYp/YLyJ0UgSNjr0YdrtaKIs?=
 =?iso-8859-1?Q?H2pX0uiYFES+o0rXIwK0jDBVBxEPqASegHpvYkl5DWZwxV1lMVDr6Satvw?=
 =?iso-8859-1?Q?c+9Cc0MMmdRgtROiBJofHouEnb8CYPdbTWDvJqj5CPJzEZmVStBxQVuW4D?=
 =?iso-8859-1?Q?4uxAZ7ZmWM+sRJ50LFP4k9xMXTgiYgtoevA8c4WeRTGlTDVEjf9FrV4WgL?=
 =?iso-8859-1?Q?BZxFxccu3359MksZTZaT1fTgpJTTuz2SZEHxlsiiAJo17iz/BT6pZnKV70?=
 =?iso-8859-1?Q?4QW/k8F1kgJiOKUaSiYRu+UqX4EblIiIVpZzOJswQtamooAalKn7umb+WX?=
 =?iso-8859-1?Q?vgkyiXktG0t2YouSlWm2imbNu69/xX0THoUKWeIslrmhj+ryJYqPMPrfTe?=
 =?iso-8859-1?Q?cef9X67od66Hrqb+OgjIO+n0BDqRIaByex48TYOUOhPLIh146TN3coN6X0?=
 =?iso-8859-1?Q?enGV3GkIRM2v5EcjwpmzN6UIW20OX23ZrW5gWh4gslaaw3COEMh4HWFbco?=
 =?iso-8859-1?Q?AsHvdhylCfyoyWrIxXv2fHQ3kpXp7Xc9WFEeLcXa9keY4ySsKXLbPdm+mg?=
 =?iso-8859-1?Q?hp/p8BN+ZtMSFcgtd0fdxQbe90Y31JZS/cVSC13HbXv66RqMAgtgVq1MZZ?=
 =?iso-8859-1?Q?6AZQ9blWd+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d2b24b-535b-47c0-3abb-08d913f80940
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 21:10:27.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Id/oto8UutVIONuQ9kMbhHTq+Mh+eFDBUx1qskh1jVH60Z0a7IZ3XK/cvL++MMWatUsKPQ6vcQKIIJZaCwDtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1983
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100146
X-Proofpoint-GUID: EkoSP_ISFYLmeQMF135sbqOa5NgAtTMd
X-Proofpoint-ORIG-GUID: EkoSP_ISFYLmeQMF135sbqOa5NgAtTMd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both __do_munmap() and exit_mmap() unlock a range of VMAs using almost
identical code blocks.  Replace both blocks by a static inline function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mmap.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 81f5595a8490..1bbb3225c958 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2801,6 +2801,22 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
+static inline
+void unlock_range(struct vm_area_struct *start, unsigned long limit)
+{
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+
+	while (tmp && tmp->vm_start < limit) {
+		if (tmp->vm_flags & VM_LOCKED) {
+			mm->locked_vm -=3D vma_pages(tmp);
+			munlock_vma_pages_all(tmp);
+		}
+
+		tmp =3D tmp->vm_next;
+	}
+}
+
 /* Munmap is split into 2 main parts -- this part which finds
  * what needs doing, and the areas themselves, which do the
  * work.  This now handles partial unmappings.
@@ -2889,17 +2905,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	/*
 	 * unlock any mlock()ed ranges before detaching vmas
 	 */
-	if (mm->locked_vm) {
-		struct vm_area_struct *tmp =3D vma;
-		while (tmp && tmp->vm_start < end) {
-			if (tmp->vm_flags & VM_LOCKED) {
-				mm->locked_vm -=3D vma_pages(tmp);
-				munlock_vma_pages_all(tmp);
-			}
-
-			tmp =3D tmp->vm_next;
-		}
-	}
+	if (mm->locked_vm)
+		unlock_range(vma, end);
=20
 	/* Detach vmas from rbtree */
 	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
@@ -3184,14 +3191,8 @@ void exit_mmap(struct mm_struct *mm)
 		mmap_write_unlock(mm);
 	}
=20
-	if (mm->locked_vm) {
-		vma =3D mm->mmap;
-		while (vma) {
-			if (vma->vm_flags & VM_LOCKED)
-				munlock_vma_pages_all(vma);
-			vma =3D vma->vm_next;
-		}
-	}
+	if (mm->locked_vm)
+		unlock_range(mm->mmap, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
--=20
2.30.2
