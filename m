Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F381438CC96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbhEURtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:49:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41944 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbhEURtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUsGj083408;
        Fri, 21 May 2021 17:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=k59vWAMubZgwv3olcX9aSCIbEMGGhhJ9Jrd1lIV5/E0=;
 b=qhYQBomcox5BACpfFa4SmNRPojK43Gxdf44APV8ZimdmGUPXcBDlqNNCV8Kj4gRPO8Vq
 DPHHo+EWAYxUKYETw/ls4DTlIf1lw2L3dpV6KwQCMeB/HdaL8xNueEN3gcMGi5/CGYi5
 WICB8S2tSGZEJLDcq92ueCk5XKfKlYCll+m7QjmeNKyBD9HivJYUm73dJgqev0HCP9GF
 eOXsSQZ4pSPuL/MvLBhY1dfYStDTqDAMjjPNVHKLR97EBFI7BhCnZnzRXUH/RO6/w4Wp
 G3SexuJbVTE9Okc5JAaDvkHEc02yr0XAaRoMpeHbW/WUmZ4FHE9NKNcZVxMBvWMedibs EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rR189475;
        Fri, 21 May 2021 17:48:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnfHMAVbcTOlgDb6qgwiHghIG7f6fl81qdL+wuA36Sk0HeUIEcIhzH35ZKT0+CZ6WiUX3Jf1nrmgGQ2ATKw5zcHqwRwK0CBx/z07W2sLuSlx4QN37TBPAKCmd8Cmg1BO/pZIu4wP9AIQEuYMZO6rhmbbt+5xFpxzjcdq1SHMce7fxJoE+xHzaq+QholuAUAie5CeQqihXC2inGxqfq68/Drj4acyRyFcJScN3ZKk7pGzzBpnggYfHaaQKDUJ1mO6rJ1upRaWlvbn56R7Mc4/xqeQhWhkCQlTu/pYe2BI1oZAnOZG9VBxTLnFTcIOiBZc98YOEeo0TkwN2RshS88Q7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k59vWAMubZgwv3olcX9aSCIbEMGGhhJ9Jrd1lIV5/E0=;
 b=XpnnDbtSpl0qk3/F2DobPpq8Mk3UfJ/8kDkAAcgdIGlHgdQfHrBwqBrPIKn03oq+o+uHxf1NE4Zg9wFH+WmiP6UCVl4zqF3HO7fT3xea7xKGu7bIImZtO8nzo/RO0KX2HS9W6GwKuEsREz+Ly1IdiSOJMd5hSviqtSY8bwMCVC1nq2fu3eI+z0dWoXaXUVl+KKluyJJF6yvfsEOOPzhN0OF4x71ICd8CmOEjpQgpZpGJAlixH53aF8Tl2F2CxZOrVwOMoPYDuY6udpEhMCRkLUTcckeitILevsepxvhdhvICUtGK4GW8ti6jzma8HmmzZx1pX3dvpild4B70famVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k59vWAMubZgwv3olcX9aSCIbEMGGhhJ9Jrd1lIV5/E0=;
 b=V/XlkHC3HnapXRx/x8qvawkqetnWkTk68QLr4dyoG6ZU5TsT96YAxxKlaHfZvfet4P8hlPxxN9ARC7QPOnBd7Xln8lZ6mOZ5uOqAfcCRj4XG7RvklEzu/eFlIDvgLd+H423mCPXqyIejElpXhw3WRhUQmtXaTyxv/fQopxxeEDQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:47:58 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:47:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 03/22] arch/arc/kernel/troubleshoot: use vma_lookup()
 instead of find_vma()
Thread-Topic: [PATCH v2 03/22] arch/arc/kernel/troubleshoot: use vma_lookup()
 instead of find_vma()
Thread-Index: AQHXTmlvizQ4ZHqYvE+wrl+yf7LwMA==
Date:   Fri, 21 May 2021 17:47:58 +0000
Message-ID: <20210521174745.2219620-4-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83de336b-b21f-4458-45f6-08d91c80921b
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467EDA9F9A5A3D3AAB8314BFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQ29j0XnKOfimHPSuOTfHeUXkMpmuj+fzPVVRAuy1e06WGlfQedxzyau+mytFyyDUEuRQRQeRWLirCYjPtGDZ3ypMTTsUPvhD+zxZmSbkS9RzP07Ifqn7uVbMCQTZBLraaJOBp+KiEw/WfmfNYNd1Ux0nC4fUx7CZF7OG9pb9Cv0S1bn/3Q/FQDELHWYKY0ywm02M+HjxsrYQp8gKfnUOg/GAyW79o4QoJq5b5HI2Ppmznjn1fXoGbWC331D3CSVx4ULY/ni9VsYev7KFntOHQhfFz0BxV79Vodm7wLsEattnXC92wyEDaXvUa0y3pK+cxnOcEfHUVQOyQ/ruVr8Lbc6NVo40/e+d6NFed/uHdkgyzbQ6cb1jaAhOd3vAf270DIrEOYG+Z2mdeg9pTk87a/TMotMfSb5cXit8u17vLNNjlibkOtce1WfTbBE2req9g9YI5+Ox4iEuv2+BXlcBdCeuuuRbUMGLn128FnUczVIL2f+yGzWDoT51DWzG9XnZ3wQsYBGbhCiaWQJ184rGos888vqD1qbsCY+pYVOA/tLaePVhXO9ftbo2H6BAD/funfsmrhTa9h5DhlLxDHk/6aqfxYCvpT6t+ty0oP79mI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QfuZXyYTTBU8z7i+xMJ0W+TZeYHLp96MlKChcLx31BRDH2oFVyqCx+eVXr?=
 =?iso-8859-1?Q?6Tjvp/jmH+cfYYPoBoJNDsX0DhfadZsqt7XZuYE/naQ3YkQGN8GzuBkUEY?=
 =?iso-8859-1?Q?ZHknIIA8dhUcqPm6JuAVKJ69gh6/rmvOgqnvMYlMo+BMMuhH4TLoxRfNWd?=
 =?iso-8859-1?Q?FzsCdtAwH34s8WqWso120e47IFGz4EEGQtIEpaxuPl3vN7s8zFNSHmku0h?=
 =?iso-8859-1?Q?z5ENMmNbHUu6lPnic4icJe9et+gpaPsEdpG23dXl88iAU/bpoxYrJUoAo7?=
 =?iso-8859-1?Q?AoHiirrChE684Dw/WQNA1SuSteJhfDpN6qnsg5dUel3ClytLCIEaoxr+z3?=
 =?iso-8859-1?Q?22Mu5XLWOfcDwDOGnHnFbr1pQuNoRUKyGnZ7f74sD88KwgNWge4YNG26i8?=
 =?iso-8859-1?Q?SpCIE3qUY5jAU47iFhPbHngHzXQfrJziYEPMIDfQ7DhDmPQV3x3qOBl3dd?=
 =?iso-8859-1?Q?Ae9ZJnhsFHH7GxR3Cz5GWqyRHp/qsGZ/Ard1Om/Fs5UosN7axFvkfmFUr/?=
 =?iso-8859-1?Q?eBbcNexNzjNUI1+fW1SGIu+gGXXCyPcutDZjScs8LBiucUwNatYKZeZtSM?=
 =?iso-8859-1?Q?rkn+B5TG3Gooc/xoqcCFTaj2dBK8uVVcds+iqShbEKsmVnTWbag1fZ5z+B?=
 =?iso-8859-1?Q?VpfJ/b97LnDiXv/QWz8akGWo3d7ZpIlkILPgSCmd6wJfmxRagVFY43Aaaf?=
 =?iso-8859-1?Q?M0TUn1bTdti69eSLepSbotLkOXIYhRcI1QsiaYuGID/Hcn/qSYgz7fjxfE?=
 =?iso-8859-1?Q?BODyPtq/0OYqhNYdT56IGaybgHdyrA9KCeeKKAzMyaAO5fqov1h+h7ytHU?=
 =?iso-8859-1?Q?hNb/CHMcAweWrHmFKCjmbY7iNcJv3G3LnEU3VC3t55PR8aYB1KlKosL/yM?=
 =?iso-8859-1?Q?NGmhyGvMlp5pOHIJABQrENaO9GmmtV6y7/mg55/8VlwEsR3/UDMvKtjxak?=
 =?iso-8859-1?Q?l7K5akl4zCID5Xja3qiQV06BzQdRAWJsitMRoC8mdFFNq0Fv3ktenb0PD5?=
 =?iso-8859-1?Q?IPECyQya9HHdM+TBlAHpHFOZj0fL0IHqb7lC/EUF3Ihm7MGXSmxTAa0hhi?=
 =?iso-8859-1?Q?N2bGwa9TsTtfI0++/+RgaefBAnK12FOhJQb26j8GNovnjXmtJBYChT7PM5?=
 =?iso-8859-1?Q?04YMsxf4CxTTe0oy3Ku6h/z2BbHpqgwa4xPysqBukHqZhNWSo/tf570R9a?=
 =?iso-8859-1?Q?6JL08YK0WfPQaOcwC4tLPlZxp3yOwvoaOch0BVNG9H0RjBBtQev+OeFNyd?=
 =?iso-8859-1?Q?h7S1K36+lSlusC75a9lLHtWf+wHF9Z764W9PkU1bMQqDPyd0mBgqyeROTS?=
 =?iso-8859-1?Q?9up3m/dhHLQqINRnjxV7PX7bwFYb+2MY67vNiTKGMpVFcreHjbOk2Ooztf?=
 =?iso-8859-1?Q?DUUPapLd+d?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83de336b-b21f-4458-45f6-08d91c80921b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:47:58.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i66IVD7CsEL4cadBSpJr2BTOaBGFjLQq0bRTaEePaVfwvc07m5h/xzEe1T8YNUzD35KShpR0D4akMR9S8yIXpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: GzE1rHXWN3-CQg6zaSUavTlDuJuvFHHU
X-Proofpoint-GUID: GzE1rHXWN3-CQg6zaSUavTlDuJuvFHHU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/arc/kernel/troubleshoot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.=
c
index a331bb5d8319..7654c2e42dc0 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -83,12 +83,12 @@ static void show_faulting_vma(unsigned long address)
 	 * non-inclusive vma
 	 */
 	mmap_read_lock(active_mm);
-	vma =3D find_vma(active_mm, address);
+	vma =3D vma_lookup(active_mm, address);
=20
-	/* check against the find_vma( ) behaviour which returns the next VMA
-	 * if the container VMA is not found
+	/* Lookup the vma at the address and report if the container VMA is not
+	 * found
 	 */
-	if (vma && (vma->vm_start <=3D address)) {
+	if (vma) {
 		char buf[ARC_PATH_MAX];
 		char *nm =3D "?";
=20
--=20
2.30.2
