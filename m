Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF18F3EEFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbhHQP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39180 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240335AbhHQPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkDcf023523;
        Tue, 17 Aug 2021 15:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JBsq+ztGJ2IUiXBFegoswjtIjPG6hdZrrZFxhda8MJ8=;
 b=d/ysbpJXhPXmna52t/DsQlPpZXIMUgRfcVmxbLvLX1qc9HlJthb3ulgh+Yjyjn4yOkXI
 P3NC5EbPGfKQCgqOXghnAIUc1Wpp+VsagnXWKsY4oxVavkrgCMoFaQqP9ESSFZD2pM0q
 LjTyXz84NPGHfaIclm0sX7W/l1EJ2XAuTbenTyN1QI1CqwqWLz/yGBrN65hzNnNLHdIn
 Wjy/BL/6+sbvCdtQy++rQx65I1JYwvj5TdKClK+VQ7USXdMDY2Bk+lQRCRrJMZ6+KRPE
 LzkW7zoNcG5OxsGo/WVHRCYHbR7be8sYZfaYaTMphl95uFuNcW2wSWjGseQBpKh85Lmt Vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JBsq+ztGJ2IUiXBFegoswjtIjPG6hdZrrZFxhda8MJ8=;
 b=mO6ojYI8RjosRgiVkytN12TWIF42p3qQJ6gnAZGa9ePTa1oNhq73aQ3W6+hA0jGu9bfJ
 ACrFJq4M6DT9jd65v1VNI12xcGDLDFlL7TEDDyK5cNDXmDoCxYrA8jphH3BW6/KwKSeo
 7JeKftmNrP8GTPs5nPumlahGtpUjzMNsspCIJgXPBcqRISFkxnzCMXGmI8YXS5vCAvfi
 RBnPdPFY0DQsofACRXsUEj5s04a8NJX28wnxMrweoRolC5q+xabwo+TGOzt3Z3aZZd7v
 XazaUwwq5izeQi5p7WswBJnOozAY60bj3lv93wS6Qu2lP4+dPsCMVPnDl8it4e5oJEWd eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3Oa174039;
        Tue, 17 Aug 2021 15:48:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwHTI5iDgZ4YnYGzoNk0TljomiGosrf4MZSl+Iv2slsd1JrUK6GGvGbcpmcgmk4U+7X+3k9U4cjKJMnLKEVvFPOtgI3yG9dLgpy3jMGxYR52c3n15ellbWv+iCS5vs+oLvlnkZJlGdjFgmB1cUfmKat/awdtwLKTrtOPrcQEHB+bbbQF9L2nQ1AyfXrSnLQavrKSJah1U4iyyeK+yNDC5VPyr9KsYQ3ATEigUxS+A+vfY5BTHtbGgGnpsSuUWlOWChn9t9xZ2RIjZhdnvuN5RxSLqTr7vG1Hc1UxYAWVP7nGnhaYSpMT/JxCLycVw9nG803kx7x3vRh95tb2xOp4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBsq+ztGJ2IUiXBFegoswjtIjPG6hdZrrZFxhda8MJ8=;
 b=P5rO8o3UwWQFaMXbZ1LLCcx3k53mpbJAj3DVjT//y5ENZummw2Paw3lH9sv+N9s+HmR4pl6lfKi4zar0eKQcFJcGd/AbT9afSKHqUnNk/xGYZBSUZO3VV4a52+Jyb632UIhaYReHk1OnVVDKTMar2RJU8PMifmRv4+IiaO1w2THkTFjafMoR746L4hgdmPSk1lvdu0Sj0ylRTs9t1xytrynUDQLcI80hQBqYm+WuxNznudLC8uHh2zJHxFp8YcPNMgTR0euMSEbhu8rnDUB30uCOUa28Dv6Z8MVdaK2YtFcHya4dfnjDEXw9dsqBi5FcYWKS4irWfRweSUclQouEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBsq+ztGJ2IUiXBFegoswjtIjPG6hdZrrZFxhda8MJ8=;
 b=pWcZrdor0bSHZOjEO9JJ4IeVhmoznWENStdA54oax/StkP2YZk6QCMagbJFrscCrDv+KxOaPbjyQygpyVGPE6DXCA39AfuSY7akWfWQDfgk34CmOBzQn1WqsG2O7oGdXs5WQOUeFEMok8JcK7g989/YKRk2EbWjFo5e5YQd41BE=
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
Subject: [PATCH v2 45/61] arch/um/kernel/tlb: Stop using linked list
Thread-Topic: [PATCH v2 45/61] arch/um/kernel/tlb: Stop using linked list
Thread-Index: AQHXk38v8ie07+tbbEiIog/VXtJB+A==
Date:   Tue, 17 Aug 2021 15:47:29 +0000
Message-ID: <20210817154651.1570984-46-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: dd37f710-76c3-452c-11b0-08d96196617c
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB35806B9BE566F509569DF1AEFDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jR2VuI2eyHWHoUgm1CMDcK/7asKt6awqyv70//tWombJMdJhXX7sjOJwfRcfoEEhDGFLOa5HLW2Ik+nxY6YObwTLUkNwu/vhgpUzmdx1Of3FLesCYKJEry7jaAcOTKW/7aq1uH+6fqJ5tkc7caUoPILgwAYIbzPI8cJnv+KIzk1ZRWOnKZGZLvRD+CLUwQkYp0kAuoXdYTxAUJZvj2W1dAFH/ir97TTO/eICntrRTdn6kf3LTl/wksMhp5a+cnOhG8ODvlzGW/1ixN60YWa7zD3VDfumMwqtaq11gYlW3k8yZyDW8BI6FeMEhKst8jkohildhzSKCjrLyrEAAnpxMoYXGFtbJfsnBkZFSZEe8lKYHj46D2H+ishMgGXpRlAMqvn6unAnNzn47KIMA/Y1ALyTZ55XggVmmuFml885UEGwvaFHVgjLtjTmkRJQPcVzJLcTjpcfxufmoF5LDJ6ZGwGcqGP8b8g5lenK4iDtsQpsBkpY7y1+XfJ395pQ6yisG8XQ3psqMii/162gkTYergFT6LnyK8P3psczPR6+IzpG/P6mssE54RevxXQcLjKvGcBMbgACl3zx4F7fSCem1mJ1HSL3j/WwnFnaDwotf+GibWI/FutSDj1rjTacxbZdPfHGFz3Vk9TPSh7JsSeeZho7ZizS4M1rlFFxlsf9jyw4LX1tn+KB26/roG6zJGrD/uNZaF16eZlxKvUBuMGlJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qnVYg1XKw8Lg/A63X3iDRlXfUVfxuTL32lK5EOMe0YsdwkNIR+xbrHkxBR?=
 =?iso-8859-1?Q?55xwQQb7pVYhRndQaoUBoconnNd3yNv04PBbp+JTiDwx9lvo0pbBKl7WJo?=
 =?iso-8859-1?Q?vlxhKHNsgqJ8FZxRF/BCddF75n9FGg/EtuSGvjB2wGFQg7uE8NDFO7kJVZ?=
 =?iso-8859-1?Q?VN7/ab/p9e8+ZeWOOSXNmuFybezKT675e3H9C38SmmOgOhi90xs/v3TCN4?=
 =?iso-8859-1?Q?uClC3/xcXLZFSrY/9N3SeUlB8/r7f/DCU9OjPrCEO2wDH9f6JtOzYBWAZi?=
 =?iso-8859-1?Q?BFyUC4riBG88EHLuwA5C5D14GXhU5W5DDqg+CI4Qj/zn09BoCRBGV0FFlb?=
 =?iso-8859-1?Q?awQZ7/qMO3TQIB7+0gYATzTnIyFmj6qsCdMwr7vY+B55TOmU2szH75L7i7?=
 =?iso-8859-1?Q?zR6lndFz9nQWjc2Kt1jcpH9rtIUjANAweENPQ3Oy1GstjYHqnnEWN330i2?=
 =?iso-8859-1?Q?rKRttn6xmNeQ9+ROqwwyn6rKj/XwWVqaMrJxOaPMCrAEpzuHmVeuSVXOwl?=
 =?iso-8859-1?Q?7UUbBEPThcCj+ypCN0GtIjxvkAVx/BQND0UY+TOv3VYfGWKrKUh57N0Ep6?=
 =?iso-8859-1?Q?0XyWXLy5aEjT0FiR8pXPaXd3oDiNK5HYxD1E9WOFwDTsddtP5EF07g+FzS?=
 =?iso-8859-1?Q?8QI+rzLSwQLyUDcJ3vS+U5XeojuNNQ+B5o4T3xXMk+W/nXNURWg8kKQU7s?=
 =?iso-8859-1?Q?LjIvl35T3PI6NAa5nZaoNwOXUqd01msXU+3FOu23PnjmpGlQxScU6Wj/sq?=
 =?iso-8859-1?Q?s98wUDIJK+9Q+G/Sh15MyL6d34KFHiJCzfQf8/9p9Ab5w7FDKokiEqtlm0?=
 =?iso-8859-1?Q?5R23GdHEglguMOKSKIaA9n2xLIrKoSf+aBjrJJeMUmW7SiXSM5+uTT4/SK?=
 =?iso-8859-1?Q?ws4Jdfq9vdEuT6fLfhqxyJ2wJgivziE9VN6O7XoSnBcrkDiMsoHAyf0b/d?=
 =?iso-8859-1?Q?E5k4DEK2FtWp0rMN+aLzg62wbrTWdzhlblepd7kpKYjGMM7JitmrOLJo/+?=
 =?iso-8859-1?Q?clW46BxhasEVSeC86I/1QYMXqX2EKuiagccytv9DtItMJg3vh6vMFSyi2U?=
 =?iso-8859-1?Q?F8MTehQmrNOu48I78VdUMOEJ/29+1h/YMwZpjqF4GZIJlpwrtN4gsT/dT2?=
 =?iso-8859-1?Q?mqITb3sYLiLLzQpLBlQYFgLuheeb3sGvZpYSCLfbTFnlGWVOjFZ8qo1idc?=
 =?iso-8859-1?Q?KSjorzm3Tz5rB1DNH/GW4yhpBBTz5TAiPbR6q6naJ2vOQM0NvDp7CsnkDa?=
 =?iso-8859-1?Q?ySaDXlktRyJ0dJDnGCmtVpGXwst3LoGE8yFAxFrkAF98dCNn95nRitPEhF?=
 =?iso-8859-1?Q?slISNqdl0y/Nasl8cASxB1KSoEyT/j7/fy6yfkRFghk+ynxIPiTs6LAGOL?=
 =?iso-8859-1?Q?VFuqIipF3p?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd37f710-76c3-452c-11b0-08d96196617c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:30.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKAU52xNIEHdi8zv8U0iwdqXiRZu/Fw+1UF0nh5HosCcVPBm1Wvqi1SSH47Y33b1GjxDuGvQFYiVEPvfoNP3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: xgWTViV-7WMAQLaWDEcbWnxHnmAn6BWz
X-Proofpoint-GUID: xgWTViV-7WMAQLaWDEcbWnxHnmAn6BWz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/um/kernel/tlb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..0cbbebad70a0 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,21 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	while (vma !=3D NULL) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	while (vma !=3D NULL) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.30.2
