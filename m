Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672ED3FF8D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 04:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbhICCWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 22:22:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23588 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232931AbhICCW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 22:22:28 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182MsRsD002824;
        Fri, 3 Sep 2021 02:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=XXXDGhtVNgyvHmad4nO9HJw4CBxDD4+M16LYAiSJlXk=;
 b=DvyugFecGVUVX7cfPZ5AmynZ+TSpyU0FS6lRZfYsU02fUpZZSi98wKqLqqPGscnZhIyX
 vMa48CBE8IFjPyvXvnSn8HGfWGIV+RTWVvQ85fuJ00h9WDXPr/FFbRnCN+VbSscbvraJ
 DC4r9NmYeTejE430uQALC3TTskR/v1JAw+p6L3B6Glr0XulszbHeqwjgnIaALBcV189+
 owS55FZ+jk+JHkEI0yIVjEhSBULMyiOCJKURO4Zy8DjK+MCHcRjfHoMjAr6QAk/LeXv3
 tsjfNXaMv3UpQaW2mAU92BuviE0nvesrz/bmcoRITJ8wuIe0WuSFcivl/UZ9esnT0k50 4Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=XXXDGhtVNgyvHmad4nO9HJw4CBxDD4+M16LYAiSJlXk=;
 b=Cb5aEA+96uYWXIF6/PM0c579LTc5ezNVjV3tcQ/VNadGcsRwFMzDcJ17oyYGBlXdABzJ
 cl9n9TYHJwlzTIbHm3PXeZudnL5kawH1uGxfpJm57oLFNeLOoW4PbjCd6QcYG+6sEhWN
 MAwAvSi8njfiJx+J+XH631V4aYjcdRu5E5fnju1ZLh62ZzqCRNzfIlSBgTP40xzUXn1v
 R4PngvTdoaJcZTC7uuyen0PZVJfJgnQ3cQtPfBe2d/CwgmfgZ6M+mfVommicJVxBT5Mq
 MFZxJ0Jm1Q9QDlJZe11zvi6P7EAjei/t19zLr7909Oh2GWaZKufKR6kVCZuMpO/Nh1Gw BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw1cnke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 02:21:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1832Bln2086144;
        Fri, 3 Sep 2021 02:21:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3atdywfqcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 02:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdDfmLmegac3xocrrnRqAisMbOMT5Nu8ZkXGPIRVckm937oMEoTeItCWhU++quKDU+uDIQatvemxIxntS7CIq66fhjhfVGMUnVuVMP736NMwUqwqUyON1yW2D5xpXT5TGj+pLFfGQf1/M0s+o1rF7BtY047GOj2nymsnqDl95T8y5ukKAwBclc/xsiB7HrirXqn/w91Npo7gqBJMVR7g2DuZnAeZlzZZ/Q3lRPiARHencjLiHErvE9Tm7XEm5RAMwxVCn4wtSdVppDN8AkOqpjH4lH9UcagW8wF6eC1M3XcNRdWv08yIhphoUi+erFaWHRIyeQoT6+HDJEQXebdB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XXXDGhtVNgyvHmad4nO9HJw4CBxDD4+M16LYAiSJlXk=;
 b=gNUcoARRrEf9GpXZEjnv4UUmbfTCSXF5Lq4iNPiPAvY1oHmetufgCqv7UOhjSVcqXriSODN1GwNv1U2FtDu+jZrelL1o1EQAD2/msreNJde6s4ZgYct9OnSSIqqWCrfZ16nV6qRHL3dfqwMQY59GHCkiZeuQsayo9NfNcKuEGtpZ846xc4uC68Oav52qWetg/mOViHGs6TphcrWbH7e5Jr1urr0LRFHyuY2TFNZQCVW7iRwV9ggZEW9g5fl7jk1X5DCupb5X+5LJN7zLESOVzgtgMjC4kMEFVjVN6xrROUaJEKZKi1hD9d3bEA+sk/G8cerzcFQPkoy7+PE5Qp6cPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXXDGhtVNgyvHmad4nO9HJw4CBxDD4+M16LYAiSJlXk=;
 b=CXsr2YkhBTDikKaACsXJ6TS7wGXrVHOkRCJv4OsHXxVs8yMPa0aACV9U5hI4PNFXjYcYl7bGgBCYmGeoBK6kQoaC6nNNBRsq/kBxFA8O4jcFolebtua2o5xtdeNpNxmid3dsNw4QJ9GJ0bQLsebML2GgeHzG84vc7/6siR9hr2Q=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Fri, 3 Sep
 2021 02:21:05 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 02:21:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mmap_lock: Change trace and locking order
Thread-Topic: [PATCH v2] mmap_lock: Change trace and locking order
Thread-Index: AQHXoGpZMTHOHeoOlEi9q/cbKaDHwg==
Date:   Fri, 3 Sep 2021 02:21:05 +0000
Message-ID: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d7c86d5-08d7-4052-054c-08d96e817bee
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-microsoft-antispam-prvs: <DM6PR10MB3097BB51175B319D2AC89B79FDCF9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxgiUgqs6SRELkTMH6s0xH5ek4yZiJjX5kIcgMiMdl4SCtED90N0X2SJ25df/4c6Pq4gYcMNyqqubLyjnXKajPfTNLDbI9zF6b05TtudB7RAHZ9kNOTUqr26FgyQa+5V8phnFdAuJuWv2y6QB/d4Mx3HKz2hEETqh0tL7U3Og+TEdxQV44KDTkzNa/t1asCsQ8Mu/2fKx/p21fnnp6GBIBFRJXFkDaHG2He1wh0ZHo6IDa8aOcuUNeyIJFT1pa/eve1Cdqza22gC51d7tr09QdMfRHopQAVHNNhziOL07xYCLn6YVIiJn1f0d7ZwgF1iujk46YTceHTXxkc2TfvXnZxx02Gbzw8zifu1T+ggUgcc8EJK0PhNVAwvv4PVBPceRVuH5ZCP152yHRPifGZHPWIM/bulZ/7/rcL67QIEb0Cyawbg5Z1b7eqM/ALjaYFG0yFVdSk4kXfDHd9ZInJ3f7rxLW4B/X+Zx9y5/WQ01V3l+b3CB9eZMBZ7C2UpEfxjkUTKQFhsNXRU5fY2wenXlvMoVISoUB49Vlo+W/qp+jeDNfEvTg/viiVSxEzhIm0g1bm48JS+JjODM1ECMXlqhXHA6PT0fPydqBskVy5m/k0OmZlpgZwUWbUDrGLGvfjyFYgmnK7sYKfu5Lt3xgKjy3XndglpP1l2NoL+DFk4cNAhTwy6qgpDeGrRmYe+5EeXU1JvSrBk2GEP1hLwiPIU3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(6486002)(83380400001)(478600001)(38070700005)(66946007)(2616005)(44832011)(5660300002)(2906002)(71200400001)(316002)(8936002)(54906003)(76116006)(110136005)(86362001)(91956017)(66476007)(1076003)(66556008)(6506007)(4326008)(6512007)(26005)(64756008)(36756003)(8676002)(186003)(38100700002)(66446008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NM0TUjSrowf5gfPBwzSL2BKeA0BToFp2xkrDBBseKpQ17OJ8Qot3t7QBn2?=
 =?iso-8859-1?Q?Sb8vuMzipM1/Tpk61C8qDA4RW3IYPqTu6NeKb9M7HemzRk8jufldZ/HvwM?=
 =?iso-8859-1?Q?jBcla6svoZ+NNECb5uluJfBfK3E38IlJapYLIBg23VfwyLjCDjU06wFVCI?=
 =?iso-8859-1?Q?BqF9wmJtNxFRKRVIX7Xd00PgC3XKhpulBvpm/331YjF7klfH0oPwoC6AfA?=
 =?iso-8859-1?Q?n8LZ1YURieXhN7fNlvLVuX1blTF6veAgVCcqAy6IE8mzON7XaoQ5Aq/bPm?=
 =?iso-8859-1?Q?/XRNZ+zi+AlO24eGAxQO2VVlkC8lbRLbydBOTc09yv/I3TuX7ie+1qm8KF?=
 =?iso-8859-1?Q?/zgLDVpNqOuWKjm0Wvwp5O0ohlQlrfhnqVj9jJEOXY2ao1kfCnpVn3UT+e?=
 =?iso-8859-1?Q?/gteUT8i28jQRJ1KKxyhaE+qI8AlTaBcv8YEXdKde7xnuyUhk59nWhGXl5?=
 =?iso-8859-1?Q?uoBvdSiewHJdRTsb59NuYLHueSKwMCVViwDEWQDrxm/hl3nnLh3UOYlouy?=
 =?iso-8859-1?Q?zIs7HB0dSbH5BiP+pKo/Pzck0zSQ+Ftj05cPwPF5FZpfKBPg72ndQ5lB3S?=
 =?iso-8859-1?Q?i+dQHP+KUT74QwBP1apFigECGoSVZCORKdIaIyo2PzphmenYkqZ1naBTk2?=
 =?iso-8859-1?Q?9h9apiK1IzVpgQKf2EYK6U94lGvnm/+y4iYxJ+zLKEm2FeMCOtf07P267i?=
 =?iso-8859-1?Q?7wVNcz0fiKdyE0oM528iN2lDEjDV8c16dhbwOG5XDPCkOiSB1gSiCMpb7j?=
 =?iso-8859-1?Q?jIdv8sDrhdkbicE5fUR9Rt5bBeICnw9CN+RLYrxF7s2PKZY/ViOkEVkqxS?=
 =?iso-8859-1?Q?d/A9EMOfAqvlfUL3BJqcjtU9dPKt7rrmEi/YToqdWNsTCGR7W/9vsnMDoI?=
 =?iso-8859-1?Q?j3ZYy+QgDY30t3bygjmqpL4JqA6ftB9ry56m0k5HHyy26ZxHheYfqSrkp3?=
 =?iso-8859-1?Q?tVxYXYdyI/d7om8YpaEtrXpkpGsWNuHb6ZM7lNVFmmc9xiJEDYsOCkooHv?=
 =?iso-8859-1?Q?aR1XFu6j+9JCwaaWWWaxRP8xXeplKlg6VihRZKA0hJD1L0cps5qp4sWyd6?=
 =?iso-8859-1?Q?AF5YGP5zlEXJkHrLsZQ5yDtWW5pnpimi3SeDtNXg62rleRltoqA+zscG5r?=
 =?iso-8859-1?Q?z9Dmopnb/cLdbVtRDXmL7sHvkF7tIqc7Rv1EPYPhVcs1UWNAkB8DI5o+Va?=
 =?iso-8859-1?Q?ZABKRGyhniIGE7hRCq6XZa1P3Q7w8Dnjm1xXNmKrXgn5k2f5F4eEcUlxUn?=
 =?iso-8859-1?Q?eND/LmLxssfnDuesB2tSnFhCD6AWploTdD6Y0q8kWdx+PoOKhQCZj5N0PJ?=
 =?iso-8859-1?Q?h3WlZ9Tgjoy2kSdqDnlksOru9nuA+tB59AyOzHGLczwEZDhETNrTPvYgFK?=
 =?iso-8859-1?Q?2afpWVC8iT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7c86d5-08d7-4052-054c-08d96e817bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 02:21:05.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20RWdShhD7m2auz9L32IOHcy4QzwZ+UQwuPpjVpp0hU/scj7HTdXU+fJaQD2vxTYonn+OTA9m55DFGftHz2kMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030012
X-Proofpoint-GUID: gCXzSwf9o8s3gOIG2nFM684OCkbDd-gE
X-Proofpoint-ORIG-GUID: gCXzSwf9o8s3gOIG2nFM684OCkbDd-gE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print to the trace log before releasing the lock to avoid racing with
other trace log printers of the same lock type.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/mmap_lock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0540f0156f58..b179f1e3541a 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -101,14 +101,14 @@ static inline bool mmap_write_trylock(struct mm_struc=
t *mm)
=20
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
-	up_write(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, true);
+	up_write(&mm->mmap_lock);
 }
=20
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
-	downgrade_write(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, false, true);
+	downgrade_write(&mm->mmap_lock);
 }
=20
 static inline void mmap_read_lock(struct mm_struct *mm)
@@ -140,8 +140,8 @@ static inline bool mmap_read_trylock(struct mm_struct *=
mm)
=20
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
-	up_read(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, false);
+	up_read(&mm->mmap_lock);
 }
=20
 static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
@@ -155,8 +155,8 @@ static inline bool mmap_read_trylock_non_owner(struct m=
m_struct *mm)
=20
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
-	up_read_non_owner(&mm->mmap_lock);
 	__mmap_lock_trace_released(mm, false);
+	up_read_non_owner(&mm->mmap_lock);
 }
=20
 static inline void mmap_assert_locked(struct mm_struct *mm)
--=20
2.30.2
