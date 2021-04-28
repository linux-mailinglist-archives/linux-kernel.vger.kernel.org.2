Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D3436DC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbhD1Pmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33748 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240652AbhD1Pio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:44 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKhaC029931;
        Wed, 28 Apr 2021 15:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cusezFqyJQ04LKuSFIqsHc44TQtyJikVNrNN9dFfO78=;
 b=mds45J6PFeu9a8qd+9pbuSmrMh3KF4c5kHRDNYHD2fhN3wj+Km+DwdxT7Ya7g02Ch8pk
 sjeSZhKxOL3THOhHTju3kn74DYH2V71UCYW0Q+mIwoGI0ArMK3gz/lEi7QOvt7DNilUH
 XDsTu/sLV5r4y1muQuIG+mYeAu1KJu1lREmv41U1AUqN3h++364v5riMBso12V0NtFIB
 n+NHGKZllaCGdzaw06gm2XWXbVd2SNuWD3cZt1w8LFP1yAohpYuRaDNZz9IDwZsXnpxu
 s93VpIIIA739oojFd3yVlXr3mfeCXY7SuBdl3Maax2Hl5x6DiyP8rYeri6rLEfX+OcqI gA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh63c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:34 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZjx6021758;
        Wed, 28 Apr 2021 15:37:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 384b58qq07-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erKEEIOjSKAbOpeOQmvawGwAYfUW533nL7jLT3A5FKQa1km/1CRDgNj5Wr74bZnUoSdONOqDAcxTFq+UnuJfZcppjL2rTU4XKqFGz+GSHRbT/PZYAv5WBliLUzMmbFeZYEHdhMlhhehhPvwGde6JMqc8D7PfOhlmutTxFs+YqdamTcSA6ucIWjrNF53O+z064hm91aVWN55RsZsOag8EOYXvgEHx0LRgGhgr6okwniUVcE7BtQhQF6ZvBs/NHSt4DtG/+lpvulVFJ0WZMYD+glcZzZjbloBkwfCH6p7QFxPYp9t7vudBUGiBh+KCuWHIvlvMG4l09HyuZP2C7+cObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cusezFqyJQ04LKuSFIqsHc44TQtyJikVNrNN9dFfO78=;
 b=HMLtgptr4Ls9H2ZPWDo7V0WCRI03ZGy91mb0reG9c2e3qXLuKx6cz4PEnsStP+AegkEU3HAuCDQoTpGn0bvtiuRhJDSkX3TTUCBbrOkvT0GQJrBn3UUmhMO/3xEJMdAJvBQJskdlheFeXwPgt/60pezoyMkgtibbUlpXrTakU7fCtdJOwZnDVQZhQ6dXO4gd7A+SWPBVRav6WZ+UYnG6obhu68jKpmXY3hHJIla/IWkIIwzGYCacT4X54vKtjJhe4h6wWdvJ8H9iurNzCeuzCeOiTycJRfGr2NbjqlvAkqHpc0y/qWKtBqHkbeh6WEhpqS7ynWeYVr2+6b1gWwXtuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cusezFqyJQ04LKuSFIqsHc44TQtyJikVNrNN9dFfO78=;
 b=IIqgYv1PyE17X8dCg9bnpVhHrQwN39oZOHfxG/tKhLug34yONtqyi+kV3bWWGWqae9Jo+d8WSn9AeIclKN5H2kjwUx1/ZdAG2OQi9LfRiDz/EADrlmLAVHeUIaXZpzrO8eEK2AIviEZfqzrxRlQpyNFMXYCZmALuITI7K7CMGPU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:28 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:28 +0000
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
Subject: [PATCH 87/94] mm/swapfile: Use maple tree iterator instead of vma
 linked list
Thread-Topic: [PATCH 87/94] mm/swapfile: Use maple tree iterator instead of
 vma linked list
Thread-Index: AQHXPERC9MWevQv7+UyWz2oMYI73Tw==
Date:   Wed, 28 Apr 2021 15:36:29 +0000
Message-ID: <20210428153542.2814175-88-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f3d4ec8-b300-41ee-00d0-08d90a5b87fe
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1871D5758A367551B75787D0FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A9TEU5+au0ZuJ/kCRzdzSiyxD8/+Hc2LaHL0p4H5lxEQv/1XXnujm2U3prNXoig9QQfItlwZyrW0rfy2ZFN2TyMl/wxn/J6YR783A+pprvuxMdh+1i7AQvJuL5yOmCmptuU6mPQ4wt0IduM47u2ASQ2ZCm0dTcSonipgfOhNrxy5v2F5TGXC+vq6L0UEIf07K1XDC8uAo0BTban4x0krYBwEtjqYxrUOkYfJsnjf1mEiyc761QIDeFFxJoHHAzX+3trt7g0ya4lvGtzaGf0t+g6Kr3VL5e8rr7uqGZ80iHyMydIaYvy5fnPqyAAY0t9hHxtrcTNK17kTLCkzF/PE8GK2+pSP/cobqi0r2yVENKO9l0867W2Zr/ASQIVasEBh49q2+c1mA0rs6NFzt8Ci9ESwclIpmSPUossvK03HXnf+5efKCFYvMrX0VJKs30r1Wxrunty7mFy6KvCXFque/MOiRissQAxUB2GqS+1p97DW41KaKQ4QPQmafVQQ+UYnJ9YHe1BfVbC0KPMOhxE++NRbOq6vpGHk/2L9rJB4m5xSWDS9Cpr9yZgBruFON2Q8z4havS+J5L2w3YHDSqr4Mn+uVPcZNd0BqR6Eru8zyBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(4744005)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Zk75DNBlJZNIS/g0cSBh5qAmplw1y4K2pZ2EbWVa7xGbyo6AGVH3c2u0xj?=
 =?iso-8859-1?Q?RdN1iv4KJKzZXZ/Bc6APJ6aPVQtiOnReo5aIhCedvhsSuv4geQ6/4xSVJ3?=
 =?iso-8859-1?Q?L98uGGiZpIYVOO1SvH5l6z3I4LCrFKTOWn8mB3Bl6wDa31qyjsz5/DU5Z7?=
 =?iso-8859-1?Q?kd3vq+Yxu0cWVcf6MkNDtKqnJQwh2ycdF18UQmzgBXbWjivZ1P3gK6I2an?=
 =?iso-8859-1?Q?O1Cj/TwIOahmUVmeWFRcRfRkKU8j3KOC1YY/9LOW20ZQIc5Lfz5P4WFHDK?=
 =?iso-8859-1?Q?/a2TjCth1UYwKyI6Um+4H2u3+VlxSmoJaxA9dpdpbR5/i4csmtAusoAxcK?=
 =?iso-8859-1?Q?/LpR0qbfjRYqRFHH+XLYHpucSaHlCXketug/WYkweDIJVqNrtm6EAZurDb?=
 =?iso-8859-1?Q?W+e6MWn8v7XPNx8Z4GwxvYuxQftLwc226WMbe3xRqAj7EBJFd2lHhgBePi?=
 =?iso-8859-1?Q?wWrFRxaYujmpPIqCSSckCaUDBUXzYwy/yHpL8epgpJNJcOq7FHthvk7SeN?=
 =?iso-8859-1?Q?u4BrALD9Jt4l1OVj3i6sBZgwfeVY537EYVjZ3Dn3H4wO5x+T8Jwb/jHjR1?=
 =?iso-8859-1?Q?fceDzT2JX6yGFBnSWx3myaF4VqsNCvLRNgF9qvUd3rR2jJYI3tBg2IPPdh?=
 =?iso-8859-1?Q?EgyspQ0/54Q+EYs/h/IuSOFUi1hcuY9bXxJxGyPzo3Lp05A2VTzmunI29f?=
 =?iso-8859-1?Q?qT4cfd7TFljuKaxE67wJnOHXhtZxXYaT1voWVGGUcrjC6YbcOjZBBG68T9?=
 =?iso-8859-1?Q?/84riMyeqeeu/v3uD4iZe4WJKLKbJmPmHd2VYGLFHvJzR6Ss6D+gNvS4Zt?=
 =?iso-8859-1?Q?Eq1lXQU/8Zwrwv/qWUyBaekmonWqAaWXM1qlqYHrZoLmlp6avXjSHpBbzg?=
 =?iso-8859-1?Q?vuPpHiTVQXqfxRftJt/Nwi2zYVqrouBcU79NEFmxI3YwMR57amfcGX823s?=
 =?iso-8859-1?Q?EA0U3H1HpkxIaK7LBHxi6t+9nHS1JzQp0Wxtb5Z1SOORtPnAJxwSB6r/FE?=
 =?iso-8859-1?Q?SGnlaXLlC7/+V357I6rWecV5ZGlITaGVIrCKPycWd8+BTeZu1rkL8xUVxK?=
 =?iso-8859-1?Q?BIMMxCrmDVLOijpskwwvCR0J3v7nZgcAVAKs+9+kZniOUMCrV3nAIVjfuQ?=
 =?iso-8859-1?Q?qg3JLkJxLtn9D3keMbHXhtjWFV/IFmRZrd2r0aN3++ecGMD20YwiagAJUA?=
 =?iso-8859-1?Q?zSwhl8wl0wXlWLGf03Ir8eib6ECsaZH6+bcL8HLB5VM8zySHVtykq/qZrz?=
 =?iso-8859-1?Q?7wPNVz+L77S9LP6Shf3NeKnRtxWJK+h9fg71d6pMxNra1Ar2xbY0dm3iwy?=
 =?iso-8859-1?Q?NntAYto9pArxBV4FJQPKuS5GzV/QJWHywUy8fcO4NFqz6LtPAni03s5GxV?=
 =?iso-8859-1?Q?MdnBcAIEtB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3d4ec8-b300-41ee-00d0-08d90a5b87fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:29.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7bqbVwLB9750xvAcfjeTQtRdMYewFhlY5RirOV4FCkNtKrRZoXTZVrQYkw6WmtDwDY9+W4OLOHuiAvZ2YhEsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: lglxMz5weYGL1BYM9DHXfHTzyv1cQmqY
X-Proofpoint-ORIG-GUID: lglxMz5weYGL1BYM9DHXfHTzyv1cQmqY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/swapfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 149e77454e3c..69003ab63e64 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2116,17 +2116,24 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type,
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_lock(&mas);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type, frontswap,
 					fs_pages_to_unuse);
 			if (ret)
 				break;
 		}
+
+		mas_unlock(&mas);
+		mas_pause(&mas);
 		cond_resched();
+		mas_lock(&mas);
 	}
+	mas_unlock(&mas);
 	mmap_read_unlock(mm);
 	return ret;
 }
--=20
2.30.2
