Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE9336DC23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbhD1Pm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240661AbhD1Pir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMVKr031451;
        Wed, 28 Apr 2021 15:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GgsP1ETTSdDzVTxNcgj7BzAMpoUCtRAABfmkps16ls0=;
 b=bVuwXyNI/ZaoCxQfSdWCmzlYZLQAWolo13mWVAANocJLn7SIMPDnWGKQ5Zo8mD/Zdpg/
 C7QM3edVqX3mFmDz7IoCqJM3OJXnaProQRyjI5ta3SKS4cZljn5eiqTAd3RcBYldp8FN
 cBw1+cRJaH1q2rwspkR5CXIY7AljfMmUd+WQ7QF6kNk9E9XKZOS9FCNSdhQSiJCGnPus
 eWmaVPVDsL6ownrV1GkRhyC5UOnYDh+ygU/Wp9YFaVD7RUSCCoRuQHYATR+KkfryAXje
 Q7Lj0gmfvWP0ko5L+UgadYJVFNtgxnBcufmS9jrLKBKetzWpKg0eOks0NHQqQy3/C1DB Fg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:35 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZjx8021758;
        Wed, 28 Apr 2021 15:37:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 384b58qq07-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7nb6zg/vqkNyIcIpywSRAfpq7T66c4inM+14jZV0U9gSh+1hhjLqizR5GQwjujr8J1+a5XwiZP1D4/i66xa8slKQ4dzLNaYzh3F642pYOp4bgNcZB9IJxq8DoFmTQ0lXNoTYruQSmGnrPMjHHBTIsjmE/YWO70zlTF6jw2SehMo/W2WXVq+3SGAujNIgKo2Q+Wl+plVJKOdFCsckdw9sqa+Ld7YSNPl4rM8ySFeS4oIfT0WVd+rlnTTdWmeTLXQLqRrY5brvf4gHpbnaGGE6FBC6qjRIZRZ7NmG0gTvUHAxpjy0Bk1VKbRPQbJL243JUFp2QBxdhQiri+rhX3OGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgsP1ETTSdDzVTxNcgj7BzAMpoUCtRAABfmkps16ls0=;
 b=HvbRtkd2THICe1RZKL/oAnfv9/y4sXELTKcfBf+yDBDM//+AaOYQrGaJo+UczL79zn1LMOxAPF0XRCsPyzYKGv1C/6BoH+SoxuDujlA+nseiKIvR6NMzJROGZ/CdsaSYH6UZqZGlCIGdDYIjCmoZs4YNRmDCb3+LJ5tIag+Us3L0QeiL4JYLZ5g8cjzd9EgDVo6kTijzk9Y2ipDg5ow1hpvk0tHcgygSv33lTKnd61Xvg4+5vTsn0H+lBzezjuNTIImbsARYVEc4J48GJcaFnla5BsOJ6pYMb2dBFB8+IfAR1OJV9S2lia0t8RbkOBSM90HL0dBs554VpcC+CiEqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgsP1ETTSdDzVTxNcgj7BzAMpoUCtRAABfmkps16ls0=;
 b=zs8m/BUcN2IO1eePIW4IJooETnJnHwJKvZHxiMVWqo81XouWaRZBjqo5GVbOfXwh665cY2Epv67RbKVqi4fdyq7wv5tDLbMgJRKmt8uAzTuXD5lKJa4Ef9gdTnDVSVYLskUhZjQoBrq8DUn71oiANWOIY6KH/TsXL9chGQmOYhA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:29 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:29 +0000
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
Subject: [PATCH 89/94] arch/um/kernel/tlb: Stop using linked list
Thread-Topic: [PATCH 89/94] arch/um/kernel/tlb: Stop using linked list
Thread-Index: AQHXPERCmpNl5CkGJ0qmp2kW6nsdbw==
Date:   Wed, 28 Apr 2021 15:36:30 +0000
Message-ID: <20210428153542.2814175-90-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: b46774a2-5526-4637-c8e6-08d90a5b8866
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1871E721F66E0917093958FCFD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8PW9QJze7t98YZTuV0ZahAhw7numci9l9lw2jLeSM6qb435ZdgeZJ5odAPmZdUDVOiIvdsGv28+kvN4n3INsINXhIF0eVMhxjPEQIcTCqa5cwoKeRrGGKEmNGdVq5MnBy3OG+93jsxMENMaTwIT5Nu4Cr8IbBl9RAXu6VKBf4xlbHopgg1y6olmQmEvNWqCGkVzGdoi1Dbcwwt+Njb6nRCeVGCS+cCa5RcMQjNgHcRANgD8vhpx81HNFuXSEvMvwhHE4GMaSjaJ38aB7p22uV+3TFycRwOyyTJw+vg0WNl3kGRz4P+OAKtxHXbHipftlxaY4BSlBq7SAUSii9ONracV5wY2uCF0hNkYWwAnsWo3Z3opiHiOmaU3Js+llFL2OAlCgcEoNKyDZxg9xG6etRIn1z24CY3BSYLKyAkq6ATT9avp/CmPh0covq5jhiIISpCfD834IHGsQSUEXCiqZMP4rgxiZl+07TBkIvbJrb0LXduveemjg3bf4V4sKRHsaHPlBnf3lQt/+2Mb3NO19oi3fdKyGM5BLBkb+jZz8IuxIhI4zI/A7QvJavoIjJ3k2Ik3iT4u2VV11ZISxriJ4V79+D6rM5fgnPF4olcVWs8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(6666004)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?FEXMcBZ0MOGaTBsXvmz6H+tyFqezTuSyQl8BAyn8aDcYnsraWINULrkTVO?=
 =?iso-8859-1?Q?JuwXZ1Tdaal8sEjHOk0jE30D/xXq0iy+ZrDGqZvlfySmALHISvlH4Pm/w5?=
 =?iso-8859-1?Q?BCgGRtYaGpWyWxKbGCh7zjLwwTg+OMKYK17zaQVdj0DEobA75lCmBgAP+B?=
 =?iso-8859-1?Q?ifHyKX1Ul+gxLwQfUH2i0pNj8yO4JPQv+tgR1BaHxHKTvfhctORpnNqiZ5?=
 =?iso-8859-1?Q?W3TiyF/zn+cp29u+1/ieWXu0wKhUhyOj/B/BNAICMZWZzRgLJU9guzTUV+?=
 =?iso-8859-1?Q?P6gcx3ziBrSfynDwrrAa1uJbrOUzcaM2ytRvLPxfxpNRvVf5BN5CvFdQxw?=
 =?iso-8859-1?Q?6X1kz/kRUfshEZQAbIz8Xc2g3WTc5homjl4uqdIv4Wc/DoodgjWp49cjHd?=
 =?iso-8859-1?Q?E4QWUNxLwgW+Jm+jyYMm+Yrh5CI2zqCte7bub8aHlyAwGuwKJb9HfR3FtA?=
 =?iso-8859-1?Q?qaOAjF0kddRRChZknjsLyC5VqX6CrOUpaQZAEaPtfmwcoE975GiVaK8P2m?=
 =?iso-8859-1?Q?Y3MwOawxOc8V8rIkFBL9gEuF6RVcAlF/bMWOt/Ab25JuDOtp/K6jpK3ceH?=
 =?iso-8859-1?Q?xYCoder6T77JVQFuYneaZ/d8wGqTN361VaUjqKPLUqWWR1TTOhxjPZ+9ek?=
 =?iso-8859-1?Q?PQUgb24zRcpQgpdWcMnjOxCYw/TMggyfGUUsdAVwYcjazPjCSrGMaEMVdu?=
 =?iso-8859-1?Q?6a/ZLaUBHOA49S8rOjrdirmrKLaNLs/2RlFl7mFgwZgJO4xbaQyUtPpsNI?=
 =?iso-8859-1?Q?pqwE82a11xXo4/Mov1uId21XGsUFsA3HDW7zkhHPel/wRGOflntHl1A/2Y?=
 =?iso-8859-1?Q?pf/g8oWmxHtMdhBGkfZcY1sJfIx2lnfcfhlAdATl0E/YN3RDEMMujn2jOg?=
 =?iso-8859-1?Q?p46c3wPiTEbnc1eWtiC3Y2j5JcNf4jj5dkWNqn7+Hyo0L6I7Puv8x5Wq9o?=
 =?iso-8859-1?Q?tF1gjqi1piRl1yWKDL7GjgRs0cgbDBPJfXc+Ec8Np/rMHmtFO91fbb2Yzm?=
 =?iso-8859-1?Q?DmmkpMgY/LSrQmCBLP2QDkMQ71KzfFV6k+IROuaFfRl2iUkmYFuGDnbubM?=
 =?iso-8859-1?Q?L8ydJzZ0IeQG8MdycztRrz3GwxiHyQTrHJmw0Vz9xMpcEnW2wD6rfOPfK8?=
 =?iso-8859-1?Q?bbVNJ/dX4a8H1h5kSqxF0CkchPGu5A/OpqHvO6El2byh1DNIsZfJew1snM?=
 =?iso-8859-1?Q?SpAVzthRsVxSa9n/uVpyR/qpQfx/K6r66mXUwnsJc4HqxQHqfXqhmceiUS?=
 =?iso-8859-1?Q?Dt4dQ+egj7OtecQTxpvLESvtEfXXbqog3o9br/n6/GJ2IcBiXc2yGGfdyu?=
 =?iso-8859-1?Q?f+ZVRj9uBWvptO38wv6u3KLgWl6JfcATFE2oBPlVj73ryc60GSj6KGqLAo?=
 =?iso-8859-1?Q?cWtjgxFSwx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46774a2-5526-4637-c8e6-08d90a5b8866
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:30.6855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmQtaSSGTaooxxdnWjg8JdufY8md/PJEGszj/vuQqUngQRDWy/Z+Mg1jr0uLGTfJ5xgK3cxbycOHGmVlvbWfyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: a57XZyz91n4NGXXVYEg0hwvVbQ2_dSpV
X-Proofpoint-ORIG-GUID: a57XZyz91n4NGXXVYEg0hwvVbQ2_dSpV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
