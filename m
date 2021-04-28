Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1388936DC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbhD1Plo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42912 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240606AbhD1Pib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOcnb011645;
        Wed, 28 Apr 2021 15:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=82Pk1GJP833lcrCSJX2y3mIEnej+VZGLhL9pVk3c0Rs=;
 b=o0YD8Ne6mfbvx0+IclKl4Wbzurfas2kGPGFzUSA06iJ8lsgkGNoX1n/BGK3sOKhVhLH/
 HZztdIJCvpNgdxmJJ0kEjJCFu9+RqWe2aRggG+5Bad++urXzaJHF+SvjsOvLAE2s67ys
 vwww33nAYNnGbEDIElmOTMyfZqQao30GROYujfk5eKvUvC6YemJe8z/Ili8hh73RfMgb
 bxB2NoYmm6u+5yS9FFeTOoq1Z4gsfZalzKcOtdJ52KeG+M7hKsnHG7jehtVwCE46b0sn
 nhB144O3NdluWYpdVSe96hM+eqYXKsQOa1MhmS3seC4ekO8xIpWitG3Hchs8urhZ8sm1 aQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387891060e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPcc024423;
        Wed, 28 Apr 2021 15:37:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USFXql4dCm3T+mw2j957/1masskXMuyH9QeVPD0fo/eAmnHCcK3DDcEdff67AzXCEkVUjBqnYxcHeMqWvBTCzuGUNNOrP3XPw+rX9xm1oSv3dZJUP9RU8xIY2G4kSBkuwbzyNIKt1YlmS9JNznbGmTqvePqDgSocBO87MPCu2RgEqFXAaz9kdPCD9z433/3yPC8ACubVf7Y4FtmOixvfP+jT8heLIRWSuWF0TAgWA75Hhjb8GlW4U7KrWrmBUDDlMhoM4Yl6VLeILfOozZzUWawcL/j9L6IZj5RTVuxRUJcp+A2tVeCHZVW8dCTtoZx2UaQXM5LX9RlPDa4bQfrD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82Pk1GJP833lcrCSJX2y3mIEnej+VZGLhL9pVk3c0Rs=;
 b=QhA0K98bMhBQIji9KRresJYKnAzskce8qkhnJxnexqfKa0MFmiPRLAtjzMUR+ofIJwsBnabM2n1obaAMzNx2TENgOdzgGJIlTWXy/UViApDb+sfHkBU9RlYZgSFI9UTlr7nMNxhPNSoVDi50RUA54YPV8vmeFfNoPnFxmukPeykVmGm1BAExpjYmxI7OBccCdYBb6tbf4Q7h+A/X4LYSVRbFCwHwuT0fzOPafi6flm8JfdxIOnH2DVbFto9R+/qEwLXNoQNematWymGxZE0XUPzCNIsN+A2Q4Bt5jCn728AabKmhlE8EHbsAFrEwmatPIj4UWVfQOc1kPF5lGkYssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82Pk1GJP833lcrCSJX2y3mIEnej+VZGLhL9pVk3c0Rs=;
 b=NEupNQjgvWdg40Fo7/NBUAvPkwoPD5bSoQTmiWLBb9IJQHzdxwARpZqruGxFpg90vn1lzkQK5MHtQzJe6tiKWRpCAQKxjFiCrxmJYFrOsdLjK45De4BjK66ZmwZpkzNei3zAdx9gaSMmIUX+/qvyNONHWs0zPRPZIahMex/T8PY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:24 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:24 +0000
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
Subject: [PATCH 74/94] mm/gup: Use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH 74/94] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHXPEQ+/mEs1cQumEGp0hh0ZjcJxw==
Date:   Wed, 28 Apr 2021 15:36:24 +0000
Message-ID: <20210428153542.2814175-75-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 52c16154-1f76-4946-0afb-08d90a5b8512
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB454815E83713250C1EFDCDBCFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acxeU9pH3ubaeI0Dry+egiXHttLd2ZMdNYtVXRU5a211GD69ZsGM3GfNgGVdDgiZCt5kXazA0CnXQSIaxgVH7H0mki38tAaZ60Ouh/ybXvmCoppE+40mqvdOROcd1aqAV77j6JBoLAXPDYXS0OTUowCrS0x/uvYkrMc/6QX19tiOyGMPKBAauhB4vA9zwwie5qSwsLB7r28HjRC7RpiHwSy0qDD6FUDeV4uyiWWaceovJ89cYsgBSdAoVAzCnudPDV5aLihMutvlSXVuND2U1+16pxATE4iGjnsgJbZJxbtU4p0ViQu7FspdIxoPtjTYG0hXfsIzBwnCzA9qO1ebp0W/1kFZ7Ey7KEF3njeI9HD2g9tx7y5dyzn6yQIlCdZ7X92LL5Pono+ByPOLAW0wTof7Fnc14z3JXJFNKlMAb8NoMuEaPIbBlHED5mAkv6psCk4dVUQNFGTpIq45BNhecPr1F3H5nZbU2Z0leqj8qyvPFyzgMECaqxjrDa5pgwahwAf/QatOzBwIV88RndsiCoKuJ5/iX6vAmysfsY1HaHYLpVviSTgP8wfA+9R4NWzkNg8hU0uHqaKHT0iPgLzV6bHW4Gl320dQ2W7CzIYbe6E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(4744005)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?JKwqbtzO3fZtKfNY0ph7b98UZ+ScN9/gF/2III3Ofn5EnTsbJC2J++SRyk?=
 =?iso-8859-1?Q?We+XqOgZkATTYUdI7dAEjb8wpo0BP+ymr96VAe6l6xyPpRazn7nxL1f/ED?=
 =?iso-8859-1?Q?i6/SFgb9IIcfUwuEHM//TmiqK4ehNusS/CBP+AUYa4+RtZrsD8NHr9cU0/?=
 =?iso-8859-1?Q?1a0+qsM9G2PRV830JYxUDGaqqjgp9PujS5krMgQiQR25TmanVErDyiZco8?=
 =?iso-8859-1?Q?gGnW1CKcpEy2beNLYam8RYh0C3W8lohVJ+3wI3Sizw5gRB93p0kASXBnIS?=
 =?iso-8859-1?Q?UBKUmedoO3Xx7l3yFwTX0d9MmRDZWxzY7YAZqYovBz5Wjtpv3f872pYDt2?=
 =?iso-8859-1?Q?QrDAeXySq/smn0BGagc3SrTvmNV773KVb+tYvRFMgq4kR/6pC/FJFKWq+w?=
 =?iso-8859-1?Q?1AEdw5H1uAZgVMQhFxJOtMKNzXCBtDC9/5VCu0zk3uQBq1Zeg9MvJ5Vi9y?=
 =?iso-8859-1?Q?2yA0JYu3xawAMs6qfhotYcnPCRmCOrL0DL2t13zLOnhVX1oMT8XBH0CZ7Z?=
 =?iso-8859-1?Q?rm3KXZ8Xd8krvnFGGZNYbJt1uxqpM1RgFx5TLlF5rdBrfru/TDTWQL5yWI?=
 =?iso-8859-1?Q?OLCd2fMbpjDv5H5W5OulOVmDPnHq9J1Jt0pGyTAQ8C+Mxnn3Sj92nQNJ1F?=
 =?iso-8859-1?Q?txUZDWaMjG0aPBPey6Abbfo2ctCNJ/TiOr8GoMjozpsprDSub5XvUQZKOi?=
 =?iso-8859-1?Q?0TrfxPbgNVmnkNKa4Hw/xOi4QL7RDTv+h13WEPPWUsVoY1/spOZYp8oMnF?=
 =?iso-8859-1?Q?r2SKjbyxyk0lcY4zeEnub/G0HXs0bYzPye2tVZyiqz7MDEHO59hAOKXtzt?=
 =?iso-8859-1?Q?xwC6BoHL+ICT36dKEtwJoaKt2w2MeIif4cPI3+i9El/aC0o/UFXO+MhAOZ?=
 =?iso-8859-1?Q?vG2zhTDWkpADSkhwThVXgJ2BoRSvQFon/7uKSiDENXbxPymdkKIYh/k0xO?=
 =?iso-8859-1?Q?tnMcxSvTuhqbYgd50ZiZjZIDbhYp9a18vi+mJ+cd5YeTQoKhB8JDAnpN7Q?=
 =?iso-8859-1?Q?7A5KTSePXsCt4eI0I1rAmjIceZ5sbfV/UxEQBOs/uiB1ZNrlKXTd9MOnQq?=
 =?iso-8859-1?Q?IyUBU2cg7tAuS4wKoESBZOsLlku7fipSG6m8q7amLJMzpP+Wv/kW2hcAdJ?=
 =?iso-8859-1?Q?Sry2FbwwfMnVoZyOAML6s8dfGS63FjMJ6VlULlHciqZKsA9///dy/CBQ3K?=
 =?iso-8859-1?Q?LpzE2+5PEtghcXH94yhxZuCM0WNkty+tt8KtIKOstXY60AfCWAGpzaLNWN?=
 =?iso-8859-1?Q?cqy9J5hdoYhWrasQFZ1KcCx6/vd5zIFpcOZowltIEGFY3OiiXfEs4Ke9V4?=
 =?iso-8859-1?Q?vXPriKOO0eTNCgY/WsXSniLQ6+3B5NDJvQ1Q8hjelZDKjSDEc7lnSn9mk3?=
 =?iso-8859-1?Q?zjagsTPoRB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c16154-1f76-4946-0afb-08d90a5b8512
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:24.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBx9caYAJ8eP+VShSctIwYOMkKI2zYNeJs1pWU1zJDRoJmXJtcar4DfuwXyv7ZDB8YVBbMZfogIfQgGGeHv6iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: YwYRUuYR_nHUTS2gOtN4ARWlmuTJKm_g
X-Proofpoint-ORIG-GUID: YwYRUuYR_nHUTS2gOtN4ARWlmuTJKm_g
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 48fe98ab0729..4acb0aa75d80 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1502,6 +1502,7 @@ int __mm_populate(unsigned long start, unsigned long =
len, int ignore_errors)
 	struct vm_area_struct *vma =3D NULL;
 	int locked =3D 0;
 	long ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	end =3D start + len;
=20
@@ -1513,10 +1514,10 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D mas_find(&mas, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D mas_next(&mas, end);
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.30.2
