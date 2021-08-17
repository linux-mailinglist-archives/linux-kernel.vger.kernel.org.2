Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22503EEFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhHQPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13946 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240299AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHLx018102;
        Tue, 17 Aug 2021 15:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RgvzM+LwD/ygjbwCckEswJS/NotmsR8/zzXIATbhx5A=;
 b=WRtCUuDFyOLrsHUPgNudIMcEMRDd66N1zEjA1iCqgTNjn7IkicaR1mTP98HQJo9WQgXr
 QYQ6P6sadkv/ts1kThTzCO22kLZtm0cm3bBqNE/aQmm2qCPcFdLTUOrzrFeSym+6BsQz
 CkdcF8GVHUgiVxZV1hWUw7qypPkccrk+kDCloZJr3ZW7zHL/zoJ+hoINLXSloF1Id6Pz
 +eytvVaYKGbtytaf5RgVYEglsT2Lr/Yf7Vw6KrqiPTGVAtGnmVWkuh8GmklBulzADvq1
 GKtqIE++Iu/KOJIhRWH4cJW8kMfJoH+x6tPdMfYo6YH201tNj+20cRcuZQGgpFmzyzWM vQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RgvzM+LwD/ygjbwCckEswJS/NotmsR8/zzXIATbhx5A=;
 b=G7kepA+mIR3fIES9wLyuk38WaePsLWMahI+JipSXmtusb7Fi8orcluHihZxkkQx6s9f5
 yvrm2z0GFMUzY4b7ooW0AQdNf8FNCXOo+688PAs8u1VbmZBmyV9zkDoX6BNqtcrJR/m3
 uISi1gQzV4ZafYsVyeMlRIOUDVnqZEi48/7cB6LmM/4+VyOPri5tma18x+K97Cx5AkV0
 k0+XsPVGxqJHT87qJDrngS9cMXWLmUnqnvadDkCAo+wlk9JoLPxktpgLUES52bY1U8sW
 YeE7M8XTDLePVm/MHbwsokn9aaoMCLPbqHeA3G3nS5HpLRgpW/tt54Gn/u+QiQy5LD82 Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfa158706;
        Tue, 17 Aug 2021 15:48:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaIbwb6hmOw2TZ2+ilGb4LWlUIg29CFMCc58moYvuXu3xSQker8D2ATutr9mp4G3+v/sWwBfMMgsZJgPUie6UG18GcXGREODcRkXbYVzrG24oumERqX26qpDrPB8wxr3ZI2Jmi4JEwAEoYjK+jsvjI19Q8HzluI4izGiT7iOdhez/Xdu9/PXwsWEK8NkHnx6A9KtkoDOwcBntk19cIwfk+kJ/AmWEIUj2GNXsRr24sYraDER29Vmwn3Ag5Ocb5gLeWSf+VY6rD1FAtpTL/cLUD/Aden8qBTNuCp/OEkr6bCmQSCkReMZSekY0nphw2Ww9NzC2NhvfblHgg66pCAFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgvzM+LwD/ygjbwCckEswJS/NotmsR8/zzXIATbhx5A=;
 b=QWSVoCIo4J70i3ncd/UZa61sDTnlcX5gcELvoWWHd+eaukI0xSoX64MgRFFZKmeHUfCersnJOlb3MLZAhUosbV1bREaaptIJWBOAL+bWCS19AnOGY/81qWIqUHPg/HZ0oS/N7rqj4K18EbUD9foXScF/ulCpPu8Yjzna3zHUM26BOxZIRYrgRNcttW1h6b0dxxv2dLtKvVnG1aUBIoowrr3wkMEWju/pTVvfyTnHUtfT3yafmTATcrLqmxjhmCkxib2aiOQnz3vE8HezOILw0Ubid+mqlLfaI1wEzBXB1EpdmjcOFfIbbC1v78BiANPXcYvPJxbzIX55ACwT+ajZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgvzM+LwD/ygjbwCckEswJS/NotmsR8/zzXIATbhx5A=;
 b=FTwNoLkJrCS3X8eBmBtp6ltj23MDEPtcCMLnaZ7pjkhx9+yuemYBCvx7MkQLgE1VoJg5N2NuokqilRw1THOFH660GqHX50kUGqCkRcHJIyar3RUDg9x+ob9MmU6TBSgVWp8Cw5gYWJYI2pZO73MtBcfzbawFBnsXXi9fpcQi4wA=
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
Subject: [PATCH v2 44/61] kernel/sys: Use maple tree iterators instead of
 linked list
Thread-Topic: [PATCH v2 44/61] kernel/sys: Use maple tree iterators instead of
 linked list
Thread-Index: AQHXk38v9ujBrdymU0OFKW/9goe7DQ==
Date:   Tue, 17 Aug 2021 15:47:29 +0000
Message-ID: <20210817154651.1570984-45-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 1616fce2-a465-4182-066b-08d961966155
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580F1252B8050DA0178FC49FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ta2DdOXvlLCAgo/k62NbzDAkaQGs9MPjBFyc2c2l2VeabTRE2jJYR3AkyfDNzw1GM27FvCbj4HwShlgXH12eBK4eKFjAlcOp3dSKYaH9HN4EYk+DSn3Hskj34RW+/b4qfyfkGp6Ag439hSH2BENlng6z8njBmsSr6w7wRIhGNplHZyy4IUiMp6lHFlLjY0d3h8tSqrI+Aov+vl8Eu896omiM/g4C+olfm2mkE82HrI6JY1mUMXdO5RfXWpQWuJrzgcbQP3RNBPN3yVnZ1njG7hlRblTGK9mW6BbWyWvEIV3oA64gyx7QGkRhHNvCJECHrglk73i2fiiQVYAEtikgIrr0ZiA61DX08zqOj5RYMulpAwq2QFGnXuUnajuDo2dyW/bx9VIkROE568FFzl2q6KzK3OI9Vtw39hNYO0P+iSf4mJjOzCW45xgXwoJsP8IEKmIQg33IHvud7+jjBr93zDSRpKoeYHbjHMzaWLQdVTrAqL0WApAqX/Rc5Ayo3Zeb6lEywPKpGFeAzU3+Rdn+KmtsgBJH/hkZ0QQ/r0X4YEJeOOMD5t/0uWB7saJRzTLyGRBwkKRXA+FmnO+R2LAACPNiVKrTfzUIUyZgNSddtqIc7lvOwhx15OeLS6N+KTDgl9eUwbh8ahHNk8PS4OhHbighap92GnkJCHGlUbmFAfFODxUIqToT23IqgaRSHJPzP4+50w6WUso7hW3G3N6yiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xcvkEIDK+8CS+K4RBjbTV0X4kL1Hu1q0hYYlkgCNPTSgEeAvS7N2H+MIOO?=
 =?iso-8859-1?Q?sDhqRMkd4d4rJQGCu5bCkHQMZWn6sq9yxVvnKpC1Mul6Jv0e17Lm6qo13d?=
 =?iso-8859-1?Q?bzUEr6w9lE3smjEVnEa0aZRmd1GgbPxgpHllxSIe9YECxoOOtYyNN9wakM?=
 =?iso-8859-1?Q?rY4VXTBhblLfd/RVG0yXRno8VbZtqB/TYd/VBzzEXYxJKBLY/L5DvvyLFv?=
 =?iso-8859-1?Q?yitHwa53WvZs48vojW5zjgAhENttyUOcc55mHkZiPqteyieUvZg0c5496u?=
 =?iso-8859-1?Q?DJLKYG3YC9cbN4m/qbBfw4ynIyiknK7k92xwIj9/C1CNLwBi5vYKpcVh9v?=
 =?iso-8859-1?Q?rD9mwSDejQXgQtmegtE1YNejXedrn4JpcJSo8cw/8orC/kytUbW9RncPbD?=
 =?iso-8859-1?Q?MU++ncyW8FxsXyykLo4tUbUMNrmwmBtdhOcCuEDGE8Ert7DBL4GTDW5Kqe?=
 =?iso-8859-1?Q?Rp5yVh9uf2BBX8mRJU0E/uXx0qTvnb3NuEE68gv5YxiZVJ8REciFi+B7d4?=
 =?iso-8859-1?Q?BhbpRc7rNUx90/BzRDnDqv52w+pfblbi+TB30Lk8Ibnwu9gnZAtqak6MK6?=
 =?iso-8859-1?Q?rD2geB3xXMBiE47a0BLcB3OHaNry77i14/O6R6fW2ytXYAVcJ84PzwgEe/?=
 =?iso-8859-1?Q?OTdpT4amu26hm3TtFEfYsT+yxGSh5AJEtyhKeVv4Dg6VMHgk2be3GuYh/I?=
 =?iso-8859-1?Q?hVyPw52wgm8mpo/CwTVTQlSgNPwfBMNANyvC28m5B8Lg50JhmJGYXsKKGc?=
 =?iso-8859-1?Q?BxwwueXoJTYS+DIeMImVw6KZ+rIUpK6rUGsEnSJexLiuenQdZ1hjEgjBm3?=
 =?iso-8859-1?Q?+VgviylrYrvYZAaJ8nZrq8cut7dVMjOqjetGyJ2cUQBRAonPdPX9SmPcJS?=
 =?iso-8859-1?Q?wo3nqyWDQmy0HfzzAwlp5QB+LhpHsN+1FKKlIm6G+jTDI779TXSBEx4j5J?=
 =?iso-8859-1?Q?puHdw3NB05l2b/urmcPFYPZmh6RHnDImq04eTRyscszL62O+FZCM0kHJGo?=
 =?iso-8859-1?Q?pZ3mSB0RuGj3HAr1IgUTZO9KaF/qPSMZXd2CYZdVV7HhsNcrnQ7ylTf9mf?=
 =?iso-8859-1?Q?+1ZI4u/G4Gu8zBiqhEMUJZxVkgBfRmNxQ4muiBvhE7BxWmUgC9FEhmtf8G?=
 =?iso-8859-1?Q?HkQTFiwqtIYv20SOiGrnYKjwJwUohlF223Ol7LyQ5GqtdTZybctDMRoKuK?=
 =?iso-8859-1?Q?X3QYQoMzNyUrwswdsJ0/6hg31Bq+wTds+McLvzkXE1qkoIhZ4y7/Pxy7OT?=
 =?iso-8859-1?Q?hUr0vg1NzqcHj84CPsnbEKqs8tCo+F8aS8bRKpRBjHUJz/wGgtQ0PozD1p?=
 =?iso-8859-1?Q?zr1T+XR8APzvOE3ZWyhc9lq5Td1gK1QFjw7U4Xm0nutXTGW8Nz6EuSvtC9?=
 =?iso-8859-1?Q?2tff0g5m4W?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1616fce2-a465-4182-066b-08d961966155
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:29.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zZt/pZB7qzI18p9J1sJWfOvQu+QST5dRAihEUu7HkuDxc2a+8gDIgrhCgyhesKZ2CeJyFrHYwoB4nQnBSk8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: X2BpwQFERel3mrfxr-XpBUHd_SUietkz
X-Proofpoint-GUID: X2BpwQFERel3mrfxr-XpBUHd_SUietkz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/sys.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 6ec50924b517..402d5da903fe 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1876,9 +1876,11 @@ static int prctl_set_mm_exe_file(struct mm_struct *m=
m, unsigned int fd)
 	err =3D -EBUSY;
 	if (exe_file) {
 		struct vm_area_struct *vma;
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
@@ -1886,6 +1888,7 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm=
, unsigned int fd)
 				goto exit_err;
 		}
=20
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		fput(exe_file);
 	}
@@ -1900,6 +1903,7 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm=
, unsigned int fd)
 	fdput(exe);
 	return err;
 exit_err:
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	fput(exe_file);
 	goto exit;
--=20
2.30.2
