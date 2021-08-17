Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB453EEF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhHQPtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:49:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36588 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240227AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkDao023520;
        Tue, 17 Aug 2021 15:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ndg2sKP2AOIELkHa2kQyACpbHcjdX1B3bpJlzc6m8Sc=;
 b=P3DHvFAUcDVV9L6rv4pQJi0pgE5YPGhtZPD48ZYTpadf3M37iTYI2Wm1p81WqTunV+ko
 aE/OgBkA9tMyU/z8gLdJsbJQAKwVsMAO51YIty9QFxiedJiHbIMqWJl6w/1RmsYzULpc
 Mh1dwGiUeSyENrtRm1nvvUCpJ/q6Hw6tuS4hr2cQnra4JDA9AE8u3Z9do+Lnr2kEvRMp
 zxb3Aa6dUmzrg3xpE6kPaWyItyPv/se6T70WtHSiTXKI/FJUHk4yrmVHRDwkMTbUAjbJ
 eJv8Z+/1NKbh1xHynZQIeBuRvxMElWXaxQvVo76rpyQUAoNTLAIsLKKoKoJksGy2tVi/ pA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ndg2sKP2AOIELkHa2kQyACpbHcjdX1B3bpJlzc6m8Sc=;
 b=EO0gtfqRRkDnOBlqyA7llfBDyaOF5GJenZM+cldAUF6aPUmFAeebRP5e251aChg4WW5w
 JbU6BokR+fUjBHTpxgcGcqKXiAApboK4FWdfUgyFamXAn6vs2MXN45HboadvJ3iugbZW
 lmf86Lcb+4BgpdIs92d+MXo5ZFX32NgsNaSbTE2FcRmgP1LGenPEbDE2mzJM7my5CgwS
 DYf0+XIbG+4kPvor/PcQXP1du6VywxLi4FjhnZ6KBeINB6RO/UA9W8dmq3BYgPA1fIHd
 AwQPXIT3v1eu7TKkXO7/c7pxwAPW2Z5hO++5btbbKTGf4qQcjEOOc6ahC/Fh+4bnYRIy lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksn1094410;
        Tue, 17 Aug 2021 15:47:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnO2JR//pLrb4SF/DWQkndNu8oSJt/SAv8yoaZUO2qBSDt7ndKZIcLM/stUJXS9st5mIdUe/Ojx4C6Qx2BV5FAZfq1WAsOn25pZNKc7n/Xa5zXhRVDlnl89mBJJb3o7SpqGPDUQLASZuu84WUmMXmBgeNYgS22Fe08bnO4b5VuqUGwpmmtjpJ0N5QxN7jnpixgx1UwJU+IIrN5Ncoc1iEraHmo/F9OPpK/Z+LJN1OptUaPfpFFloA4rCNXmyfjDeUDyO7SaToP5nM7xR9l/xxM6XNQlSF/IuujCnfF55iHE+Us9IoQf13Doo+fLJZ6f3sNRugrOMdsB6maRVU4uEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndg2sKP2AOIELkHa2kQyACpbHcjdX1B3bpJlzc6m8Sc=;
 b=NOgLoADzl0a02Exaavuo2sKDBf7L3xgbisolbTgYSfhW5vtf8HV08MC/lyTXkcQdcdeRK8r3OuiK/BXd1no5fTKDOoXEKjWBSHpMhQcR1wAgnPowAfA2snut6SVZfxaG5wpg0+6pNc7/aR+/qstsrjpqiehCeBfU45YcSsIl6sXyG9CAwnc7RjNCBp3nHhPutuLxO4+DHJl/95F8Op7PuCXoGYheb8+HyYEvgqrqywIKODzOtMo4kMQ4NgNf1arwHhidBHvS2UUrDjP5xOBSRxNc8n9kl7t0O0V7w6OgR34DWArTCRd37f04N4Y7y0/WUPod+en32fKS1dL46ce3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndg2sKP2AOIELkHa2kQyACpbHcjdX1B3bpJlzc6m8Sc=;
 b=DsdPOohIxY40RyPlkMcOYQeFEmqWJxt+hRDnNu3lyZDA3yKrvcPDexzwLvn/SVEkcm7ulTuotouVJ7Wh0h8GX/YiEhf7s4F5eTuzzlOjnaEM4Pmu/+eelH3L6VzAxBUW5r3RrQDAocAnn96dcQP6BoCEECfUi/aROGdecllMZHw=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:20 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:20 +0000
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
Subject: [PATCH v2 27/61] arch/powerpc: Remove mmap linked list from
 mm/book3s64/subpage_prot
Thread-Topic: [PATCH v2 27/61] arch/powerpc: Remove mmap linked list from
 mm/book3s64/subpage_prot
Thread-Index: AQHXk38pONqp6/PwmU63yGn8MkKKdw==
Date:   Tue, 17 Aug 2021 15:47:20 +0000
Message-ID: <20210817154651.1570984-28-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 8e4fa3f3-f34b-4fab-de7d-08d961964c6d
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236281E2489CFC524E1756EFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H81ryZU1aY5dRRNrI+5VmgFEt2p4zkMKRQHRpc6Rtl1nS04rOtK1VucZxrpUH2STM40IrPjZ7IwTzqGZle/SbDffmrE+mSbFNpZgNTj7dqc9/yxxoX3OEMDU5vAq7nnh2DPZgPlwLI/rqEz5Kay/kIFhtLCi9YEp7ZsLkV8Rz8qajL/YZLw7rmPWmr5qxte2vipAHZwtQwJ6jCiyxu8YKCUI7ldhQMQ8S0U2VPXlypCTRLJ8k/vQ/q5PI9VGVnI3vAPJHSRTYMdaC8NkQbxqExTaNhsAByqGf6SkKMQYxoMA2AK5c7QnB7KvQsAaP6lduz4VNHim37bSruCIEC4DkWbDSPFU2N6z8V5hEr5cs6bV0L2x9i2CdsvX/4xWjKQ7STgr1EqK7JlL0SebDECa4SsbepCrIrk8U8EolU82REPIE6hYtxfGDj+7ZKryY8ir1SEYGP6HOD1gAHEpANUkPvo+2O24Fd7+CWvVEoq9fqmb92B5p/VCB/CWxsMiki5XeVtJWcOgMWH6eweXCW7BINlmJ1SaNW9SZJ2BQm8ccmMKRS5z4UV27lGjCT0x2JAMysYQkgPEfQzX4otWgy8L06DFXvvhWkqp3O6prqIlaOz4+vR8XVKQ7raLbt1gNsoiX2VpHO0WJxi9pYdGmAlkoibOzHpXmVSkbgEG2+9jnoaIqltOk1SY/LNm4MomA9VgGqnSf/s0VzsNq3GT9Z5E3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iAOcErcQ8gweuc9MFa/GlemvQ6v1RSuSZ5MrfMyuWKi5J3WFTqazDK/RqE?=
 =?iso-8859-1?Q?ZiLVNd1NKB0a0RSlSaEuzrzxTPzF4Loy+mwsL0CLEyhRoZtGpmxe4iVqlg?=
 =?iso-8859-1?Q?8/P1VdgHRs6sidKS3aMkjDxEXMjyUFdGddtN7tMoFV74WSlvrvd1GQLkaR?=
 =?iso-8859-1?Q?ekcAYgKGGN5sa4dakkwSfD7VSO0s+YyWA7vEtAUMurvTrp1BPH/1ddShHL?=
 =?iso-8859-1?Q?4pC1DOKtKInEP40cKgjgK0A5MVsHpQ/B6gSnAzEmaJeha7tgDMezeDXArf?=
 =?iso-8859-1?Q?Z4b8efiImx5tZp6OJeo08KwBsinCfqF2fEKHjpwAMxFx34DgAxboMALKhq?=
 =?iso-8859-1?Q?f3BE61gIOAxzBVrsSgNOrkgECfQRPhf1d3raXZF37o5j6yBPRPQSnFKUx3?=
 =?iso-8859-1?Q?IDg/3FMS0EPVUzJ87LcyWtBv2kpOlZqEhHiFBkPKC+vf4Z+JIo+lQ+bngp?=
 =?iso-8859-1?Q?NkeMK6RU5S9V0gwcKtq6fOeV8UVs6phVibEjJhmLb14i5CshfxA3I2r6dj?=
 =?iso-8859-1?Q?PTFGHB9+fyNZrEvtZMeXQWnof15lxiQpsAjP45V/e84vllpnHLKDQ4So33?=
 =?iso-8859-1?Q?DZ0HMsNf4QoQ+vrUqnxiD91Despjo75gPoCzmonVEImp1qVISo6ZfaU02o?=
 =?iso-8859-1?Q?/UIBmP6+T+pKiM8Jq4h8Cbj3m3GYxi5hExIueoAwOwRQzq5yhzsUrUfFo3?=
 =?iso-8859-1?Q?9kEBfOS0HnXO74AwLAbJA879nsVA+DTQtZNpobudoFdmmghsCBsNe+u2fR?=
 =?iso-8859-1?Q?OAr2/jF+cKcvXWyyoJ1hkhGHHcirV9rMC957HafkJO5pzFIH+DTkRZYReS?=
 =?iso-8859-1?Q?Uk/QRfgomxRkp0pljoAdgJs+Cl2d9K1e/VEvgSgTJYSVjToEPJkxuilvMd?=
 =?iso-8859-1?Q?t5ecti+uGkN+CG9i3Eo+Ve1HUiOQG/lnEhLzx1n5Ow9y3P5ctQZWAZHjpt?=
 =?iso-8859-1?Q?3y1jLt67zarIiPGPH9dQlrGwKKl6PicrNdq8+TOmJl0GdTSLq69Y1HRCRf?=
 =?iso-8859-1?Q?Q7TIfTKgHCmWEbCv3a9OeCSMnnx4RaXM46snqd1uIy8Lmyw9ea0cQzYErZ?=
 =?iso-8859-1?Q?7KQonf68AA3f07xJLhAX/z67SVelSFEwqMFpvonr4XDgX4YlTMHz0v3xwg?=
 =?iso-8859-1?Q?8n/QbVp14ovhy0jxwm1/+SLk6WBjUokjtXQxOBoMtnWSSse1a2Tmk3Nan/?=
 =?iso-8859-1?Q?Rma30MqM1wZlfqM1/UqsCk9ISEVqv0ELDqEImjDgqXq5uE21FKNLb1R3mu?=
 =?iso-8859-1?Q?69YlX0lrWl4AXs8ICNqDiULNvA9hhkJEhalkm5/YUJ5uWLfOEGq9p7lJvX?=
 =?iso-8859-1?Q?6OJ3jGSTq3bh1QCFv4isHXVK4u0zfezuOmnq5B2qOkag3SVaMqYCAA+Rhp?=
 =?iso-8859-1?Q?QrPo84DgVf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fa3f3-f34b-4fab-de7d-08d961964c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:20.3698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cStrgS2sdeIeS26/eiwIUlteuu0HRzlEcnX5h6C6Rvp6Fa8zhEnnj+LmiYbydeM+L+HOwFgV2Pcr7Vabv3UCQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: e7ZinSjnXlsL7jADfsUdR3BT84W3O5Fw
X-Proofpoint-GUID: e7ZinSjnXlsL7jADfsUdR3BT84W3O5Fw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..51722199408e 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,25 +149,18 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	rcu_read_lock();
+	mas_for_each(&mas, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
+	rcu_read_unlock();
 }
 #else
 static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long ad=
dr,
--=20
2.30.2
