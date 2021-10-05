Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7102B421BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhJEBdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17812 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231444AbhJEBdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951BZid010255;
        Tue, 5 Oct 2021 01:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ndg2sKP2AOIELkHa2kQyACpbHcjdX1B3bpJlzc6m8Sc=;
 b=aMzXS327itrWiMX1hUCKEOyXuFZ2ar+LKNZthlKP+I2C3GvTQvNX/NmQA67QRJscsR/R
 1MdqD3v0AHJ9ptMU5s+/Dc3qXWuiU85mSizCDL9TcjQGc+3MG7Nu9A5A7M79lL3jqIGy
 OPIpMU11ajrOc1d9iL1UiHeGehcRIPaJ1tUME5sl3nU0cjCtN24suKoEo00udginid4y
 UWPIrThRRSs7+h3rpweiBKNpqczi3GjeXRj+OM23SrnK8WvV7MKXnMZFnhl+ZMTxOXjo
 V/jamtsmjq7fhVwxpJZxk3P9ndQLdaveDNLraWPWyjl8H/6q87PbdR+Z5D1sGXiK4wz1 gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv37b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGB141646;
        Tue, 5 Oct 2021 01:30:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzbtHOTeVQwN3z4eyQxUdQp9NKmut5x+AUcfQzUXA4fAqMO9aPTBXiAu1Dw3RkXj/WElZHsYTcjliTnNtEvinf2k9J7AfyE5GyT6x3I1UI+MDUPt8vR53qTaTQKDdoXmf4UiyZB/mPSrm5ZeWiUoZ0Fb96/NYCm95mAXvS8WCCm4u3KaXDdpav4UDFbnH/zZawi1QfJ851VC2wA+1FHwj890FFw1rzoFuVs4q2FLnnBxPiZR5VAnx9QuHkdFIqNhsJ0lEdOe/xxqia/KXE7mcRjUgdjdM9Tp3vEsOPXftuXlsuf66FuF+28KMdvwAiBvk3baM5jltrJd1ViS6tim/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndg2sKP2AOIELkHa2kQyACpbHcjdX1B3bpJlzc6m8Sc=;
 b=HC2C9W4jg4AF8SNjNvqXGDsGiB3QoiiT5VpkkdY/oKybMimFVsMr325ke4k8NDWohBiGMZLwvXC+5cSJP9C93tVrk1+aEHG1yYXN9aYaL87TrqPfYqcqgOSL78qdmyLRjbmZ/sKRA8suKhS8xWkghFaArCTGuVWLmOHq0EWxmQjaSM1CiyASGBGFARiQtWXPPCC5LI5v3dUCwP8mlX4PghJTi1QKTUKqCdTtMNRPCtBUmMeZ7hFU60HB7gahZbPSx8d1zkC/4Io3DjEumz10y1mRe3Upq1OvALxNXeoMCMUBvZLWu3CkECwV1+iYmP+d86tS5E31GXZwnNvdHx+00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndg2sKP2AOIELkHa2kQyACpbHcjdX1B3bpJlzc6m8Sc=;
 b=nK6pGtwGzDHqOy+kMMOe63Lf1RRlK3UQ6n1zb3cCUHWVfs3JzHeHfgEPPUGqZ6W1JQY914X4fFFOk/hDMh3HDP092bdMWmrv69kHTGYgNGFqeIfygjdr98R3mwWeeDOjNCPlDyGNhznInyVE/rOpftRc2D+eu7fcCNOM2BRIeuQ=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:48 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 28/66] arch/powerpc: Remove mmap linked list from
 mm/book3s64/subpage_prot
Thread-Topic: [PATCH v3 28/66] arch/powerpc: Remove mmap linked list from
 mm/book3s64/subpage_prot
Thread-Index: AQHXuYiglqQXXwqiukCfNldaHT02TA==
Date:   Tue, 5 Oct 2021 01:30:48 +0000
Message-ID: <20211005012959.1110504-29-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8be8cd2a-0635-425d-1ebc-08d9879fc2c8
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044555952B4925F7635BEC2FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hm5Du8NExO1VokuYapcO1W1RnBH7m78xCnTJPuAQYzWdOvD896+plpfzQV1lA+/Kz9Nt/7pymmChG7by1Ai/AupoulwpdoLTs2Y6DsgpgkCxCsIf0Ll0mbRRzTFbQzuVu6LaEVkqaprI2DBRVwgC55j8y0OadMz434H/XOfz8mWEiWcpVAX0VlkVL8uQnrMDN55e+krN8/XWIhZjP2g7KlbpxiYY7x/1w4MasiZyTtUiNpWuq/Ncc5cgK1LZUEu9vGSxHO2AvYpPzY/v7t09KADM6O2fXV344QwjXokhKa8XTvLvvFqKKB/raIOxQ6rkKFfCnh22i1Oe12tvnHeCy8fZ2lbaS9xT5n8HYEa3ALqXdnZQXDOvfMYmHrBFAOuIHQMWNYbeqTG8Xfh34ttSBU8FFz1AZNE1mm3x5DPJPM9hFJ5Ls65DWqYqyrvooGeEitY7r8WZk8FFMLSjIrGr1fvePGxfZJZ9rq9YCpjTdmRwaJig48++Pql2yIgQgJ7c7tpWBRKHeDxqUpaQr7jCTVyLz82+IACZxSkjsuuIkwHE5WlwDBjBVAlQg4NBM4rF3ylmZ99btXB4quOz7vaKfcDVurwRMHh0PgdqQAexZ7JItHDfRjNywwOP34E1OpvGzItwPadXrDKdNkYvNXQo+ongVq18lRYE5JC+Nj+jmTStFvRv/OojSOwbSTKBDifkRulGbL3n1kyD3q6WsWAotA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S24rNWj9R0I+aaBK8otfsWwqJjdzIh7Eu+gPn0S2+uKykNmOBDyrXhp1mi?=
 =?iso-8859-1?Q?rhF1n+2tb0QOuf8X3Tk83ukBKeHFU246xkRgLuiLCZamy73D8Ue/0oQZmV?=
 =?iso-8859-1?Q?CKAG3e2D897CGZBBSPSZejNjrFMmOaK+nd3xYrfvitlGrWNz80EsExRg6x?=
 =?iso-8859-1?Q?V2ZSNw9V2VAFbGU6zzVaQX1jBqHyAQyncs3kxjwT8EF05+Ja1/gW7MPrsT?=
 =?iso-8859-1?Q?yx4bYwETPyyxfpA1yukXIpTUcjHCyyx6njc1ygA1izWBHCat9lfXyVsgDA?=
 =?iso-8859-1?Q?gre9nlrRgUYimt77N7FrUeypDniQxKCplE+4FMXdPsdkHEzthtUXU80KPt?=
 =?iso-8859-1?Q?oRcJ5LzDGXhVu8HPJvfaycZySlJBhLyijUZS4FvXqOw1rwc7Fn1D+8g6qu?=
 =?iso-8859-1?Q?C95/dZ3qZVE5poTu7SKZvsu+kNB+48jneb6unYDAzA5FEwGbNsYox9w2dc?=
 =?iso-8859-1?Q?RHE9pysfEceMxdaoGxE/rTfXLHB9hUQkQSQ8zM/wpv53sQttoy/8NcXfid?=
 =?iso-8859-1?Q?DUW5RfcI0A/Z88p6sex8Rb/QJozKdVVuXYcJ18+co1ZsAX12NTZAsPGwd4?=
 =?iso-8859-1?Q?fRi+4HdT5fdbcmBAztROZEO8y6MysJPQlGmlTNoztOdUAAsp8/YGVJXI/w?=
 =?iso-8859-1?Q?DVY1Xr9FpVpf/5vB4ranqYVbqblTX9M8AiMIF2OGB1sK8rCJr+Jm9upyr9?=
 =?iso-8859-1?Q?EA4fpNs9ohdQ57Ti35mSEsm6xbNanbuvUoqaUKs6lve3s/CFVm/rj32hlx?=
 =?iso-8859-1?Q?CpVVs8vxcDy8eRFLkCrL8Lm0wPxR7AFOXcJ6zHAYLjTxsRTJldg9I0v5rJ?=
 =?iso-8859-1?Q?/1zjAY16yG4FpulWpu50tNrLXwfuXFvrLcADPWwY173EZeiRFc2GwtaD17?=
 =?iso-8859-1?Q?3GdcAOmYtTp+cC8jGVKGL/d8NnO2fb/3jzNIQ8pB6S+J+29FDdW7c7F5Is?=
 =?iso-8859-1?Q?KcretmcKgT4J0iExRjEcH/okr3otSAThP00GbmGy25k4ROaaVRE4ECb8+R?=
 =?iso-8859-1?Q?lBiNAZv6bktH5FuH0f4bxs6u65CYWvC8a270rIZu05X2BKndx7+8hMj/Pe?=
 =?iso-8859-1?Q?DzRnpMGuoksfqgXBB8n6EhqL0emqoAei9HJV/JPp0Q2OYB4Mr7UyfMYoXj?=
 =?iso-8859-1?Q?CDIoIq200l2tiIR1/VhZdh2QAAiByaZddbBVmN0fbiufHh1iKizzBFpwo+?=
 =?iso-8859-1?Q?QL+6EVudKPlWJk3AZdaK5R3tE1ot783Y4dDiKj5uKDlQmZ5zDd4Lz3jOU/?=
 =?iso-8859-1?Q?3UtFiRu/a3U1X3TPjHLCVlCocoq4xPVlsgMe1nYnhrMLGvSIFFaL7sfToq?=
 =?iso-8859-1?Q?HfeZUcT99PHTNWLa5rb8g3M5l/Y0Htx7QNyVDxka8zVcT9AJBHrDAaE/vB?=
 =?iso-8859-1?Q?r2lZG4fxGs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be8cd2a-0635-425d-1ebc-08d9879fc2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:48.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+N3lKV4w7c5OXfyk6kPD7oIRIFdjmnWkisxw+IwxE1YrSvfTw0XB4dIPb3eigYZg4OB41VWyWoskMYR5vmpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: hnz9_p-SMfH7CCY4YYL7zKbzTjSUNGai
X-Proofpoint-GUID: hnz9_p-SMfH7CCY4YYL7zKbzTjSUNGai
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
