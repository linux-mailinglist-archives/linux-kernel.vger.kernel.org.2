Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34E836DBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhD1Pjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47126 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240390AbhD1Phi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:38 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFLhoJ030867;
        Wed, 28 Apr 2021 15:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PnCniHFvoQHuR6/BvcxrA3AybD6G+abKfCVUkpP4J9g=;
 b=hKylBP0FrMgkk0e3dCbv2oIQiOLjcZ4MyjVLC+AfTvI1SoS82i7DCCaYPRFlgTnMjZ0Y
 JFSVh+22eA7e3hrxPD/zkAGVAGcqkgHF0oU3wMy3YMuQWVQsKeJkwESZNx1tSCnQpI6g
 CJiPiYgT5adoCkZbPunBiYVkOcyJN7u1sbE0fPo2Ko/+/gdCX6rWcFmzTNU7oLlWFIaZ
 y/mLSrMBie5QOF82Zqb+q8Cg/zzwjWXe6WyOCp6vpCqa+kFLGOBf9o6Bv66Z1XQBpNT5
 H0+7TP6CYlyRpgGvOYGebCkLcm0mMyeyI9MO4RQNSV/vPW7ObOoIVpimjsEnDvNl42K/ aA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0epp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:40 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWB5n196126;
        Wed, 28 Apr 2021 15:36:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 384b58qnej-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVFRqz73yjs6NIaO51z6gj0dEfqYCzptqd9dBk+r0846VJaSaBH4KFdxr0X9FYU/KmlLl9x5h6vqzJqVyedY62CSljaFjtFK8jEK0WNt79tGEfDK5jK4O9cii80RFDK3NLYvhc4qfgLL6DIsmd/VvxyE0GefEpZalZJxOOnSKACwV6E2+6vw670Jbi+JltI+tCWYgTTjET6PXQRKBKiiDYiseT6QDyAuOFy1r5jm5tAzlTiJ31vZtHur6iBka5ZKmTWOQxvinxK0k/JOlWoSYo1W9lSwWgpwhp6pRSZyl0sq6xpEc1C3YZy+x59QOj+scINgoPH85QEhBz4UB4SRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnCniHFvoQHuR6/BvcxrA3AybD6G+abKfCVUkpP4J9g=;
 b=oAhk8/r1IibdHVwtQ5Qp+EYSDC1t3nfj9FUILYLy2tDkCLOumQH6mrjJswCZaCFQAz8esp9zNrFkFt+6A7j5Fq8lcGrBSI7tkpoo2Q6HkEwljeSWCcGWYm5GS2YO+bPehwQNtVcbuybS2wJ9ASmeRa6xg7rBqSnsOtqR/SqIkLU8hRPK/B4xcfxVqW+7EvNzNJ66E8f0sNOID7diR3HbTLkVrZhU2vAXYlAy5Mip8ic3bO2JW47ThQ7EbPpQY4tZhyHBi5cizkPizX2Nu2wsNBXCqKovMkPNa1qySo3gq/IhFYgI/dPoHATF8EWt9b641NruLiFzgVDEKirmrvkLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnCniHFvoQHuR6/BvcxrA3AybD6G+abKfCVUkpP4J9g=;
 b=uZOU0NFMBQlvu83QW7WG1R+BsJTt/Wq6P4D+Z6SL+lsmcScQA3h68qzvdsv5txgw4yXyISSi7cGFvQLDJi9Ke0JNPFk8xIqt444fN8iwuf/97n0Hdvi/AP7mU2AJ81W1N0kOfFrB4yoHOZcPyEudWfl8GLn2eDsYXpJMMQAenI4=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:37 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:37 +0000
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
Subject: [PATCH 36/94] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH 36/94] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Index: AQHXPEQ02ick5RZhzEeid92wN7mjjA==
Date:   Wed, 28 Apr 2021 15:36:07 +0000
Message-ID: <20210428153542.2814175-37-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 7db1a308-fe8e-4f37-bd7f-08d90a5b6960
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB47691A80EC95D007645C2BFAFD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4eQaGJeTBRXaWSvqn3niXh5JYUM9viebf6tHUfxfp2W/arLesRO5Q28F7KqyBlNyPbrBy/OmAGhXiqU6XpE1WlKLbjpSG+prbSOjxTJa6jLAWNDNZEFmyqCvC5L/96yhId/pJwfxq4fuc3+CMmutJPcPTAibIfRbA+3DmWBIm9nPCRLq3+Ac7iLoGg+j/CeDNQ6p5klH2dxhSSu4LOsf4VmTDdyRldg9QXPy+E9E/scU1GrBKdca/A4l05gQpwwJjihAq3SRPIny8INPDvRCoErSMZRADEza+db6/Bha9dngKJ1m8iFAO2RGUfbcR8Y3SIEYl+pP2Fdbof/0Zqa3xKbXhOd+fv7/seUA5UicrRcWLxjEFx0Du+0c7vSvz4GxdxZX5IvJDNlhyMUB/sm5a70vp4IYbZ0m6SNFTk8lXyTfE5oya/PEC80UF4/8PFDvDNy+ybeP3CSu+tyl0K5NDU2Q+2prL0NJDCox6XxYvmT4O1mnSNUHqrhhaQB10tM/eja0RqC/Vcsen7BWPDQAkmYdgsRQJbV6WgdUnqNluCiFoa6lcbU7acA7CGD8XcCLTFkCY6+Z9Vm39We6os2gUVQh0Lnau7ciPUpAAW88UY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(4744005)(2906002)(110136005)(83380400001)(66946007)(6666004)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?XR7Gjoc7yxlL1J8s3TtGLmrovsxJHQXDzpnsTx5ICku7TvU0XwcbS2XhqO?=
 =?iso-8859-1?Q?wrkzzS11CFyy+5XuPf1vEYYwmXbn7E6dhf2V8SwBhF3BPAFrNb41f7zbyI?=
 =?iso-8859-1?Q?Bv4jp58tFY2i+rtM4O1/3ltQEJPEodYTqJCMqVm+LHzBRNuMwNJBRISTVQ?=
 =?iso-8859-1?Q?3EV7KDb1UDx/wGxdQDIqD7BciB6/leNi2ebRmLkBXGbUVwfBm+8qb2bpk2?=
 =?iso-8859-1?Q?6/yUpeRkVeeXgJDXerc+85+rzh1HUFAJQtKj8Yx72Uo9Ftn8XxnaCO+CQD?=
 =?iso-8859-1?Q?BpVLBACWsNTXnsA28EvDAWNhDKRfjcof35bEQ5xTlCAyR7XuVFwErz7nif?=
 =?iso-8859-1?Q?z1iTTAsydhvVUyWEbbj6Gf9IOrHJZw5h30cEQFb53XckXCuaHOTqA66wP1?=
 =?iso-8859-1?Q?Rb8IxQmPwZT86yOpjr6Jxbd14BvIaixWqle2MRvtr1E5bN05N7v28WyzR6?=
 =?iso-8859-1?Q?aOSEL0vKBLYtP6wktcZk56CU5XaFYQskd9F3FzoYjE2Pv2Gt+6bmv0lK+W?=
 =?iso-8859-1?Q?6tgcCmveUSr5Ja7jcfrtCLLMmzygxGDfBLeQKlfAABRZhYjV7n8zbzNdkW?=
 =?iso-8859-1?Q?pSon8G2GIau0IurNZhG6FrL6243j6OcdI9A7Q0KLkJRrDH+yxgvv7eZfck?=
 =?iso-8859-1?Q?MgS0DwT9KZTwLIHnnTp7xa+E2VhxtOlRJGDeAPRJ312L1xp1oRwX3utSoj?=
 =?iso-8859-1?Q?HKYnesB4j7bTwLhDgvcqFNK/Ewg4ZoUl8VpHOSEDHoimWHf+Xat5jIq9H8?=
 =?iso-8859-1?Q?Iusw6jIQx3V/8i3Gy/Jh2gAVDy5RenwUr/ZKYQrHgULCAnkolapP8F9+Fk?=
 =?iso-8859-1?Q?Wfa+8paX8ZbdUVko08JJhFSpA+SiEMKIcId/inrhsnhMZJ3UjiFeLl+d8i?=
 =?iso-8859-1?Q?9Wly9x8TNDaKB64kIOnIuvaD/d6ksr09/ounSrrFSqyZr7urbIeHvcv7WB?=
 =?iso-8859-1?Q?1QixfFp0UcC/ulRSBtw91i+ZA7dsFGLgRsSU254cRAMvjfC+QPbb+8eByA?=
 =?iso-8859-1?Q?9ZJOutebWD1FEJE+VJV2UlKK+hyyhalfdghznzO516elADVpmQe5WOae1t?=
 =?iso-8859-1?Q?ziCoXgUHwLYIUL+LZ8nlXQc9vwbZ/tBWaO/YvdYkRwkYTbNfdWoTlx29uW?=
 =?iso-8859-1?Q?dAad2lBQE+4BDhx2zoC5KLZgtoYrhtUyn8IQ9jY/8ekPsvcONcOaPgNYpg?=
 =?iso-8859-1?Q?hzU8Cet9UV1CkpGvDUE0GPqUU7cz2MRJEAjJCrZIqIJdLTjLZCeAvlwpVr?=
 =?iso-8859-1?Q?woGRXtm+sA4DtRbI8YZCp3et77WMDZYc2VRzwHhJpMhKWc6gTNN6eEwrQd?=
 =?iso-8859-1?Q?fLvLnkq5J2S73G3uLD8W8ubywPZSNI8K7XgtRrp518Rz7SA1sojlsIisho?=
 =?iso-8859-1?Q?mNgIw3dsVo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db1a308-fe8e-4f37-bd7f-08d90a5b6960
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:07.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kD8lCiw6/vM4AygaLphvbI3KbCIcjapLc6gDnhQRjPGngscrY9587pmF/URbIvRsu/aAPYMqh9AWkawOK3s0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=938 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: CDv5ptQy0lN2n0GbEeVuCPey8KotmUww
X-Proofpoint-ORIG-GUID: CDv5ptQy0lN2n0GbEeVuCPey8KotmUww
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to walk the tree to the start value requested.  If
the vma at the start does not match, then the answer is NULL and there
is no need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 146976070fed..cf17491be249 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2733,7 +2733,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.30.2
