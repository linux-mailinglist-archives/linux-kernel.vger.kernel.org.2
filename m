Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2C3794CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhEJRBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:01:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34188 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGrlNT173094;
        Mon, 10 May 2021 16:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gpVKZYEf9oVK0xIn70NyOFwHcCVoB/1gsgI8Da9CMWw=;
 b=FM6wuLYKVh8cB7d/m4cFuc35rPl6uq7+maisbmgYh92aPdFhUOUIcg6LoTcRt/9iyT24
 BsRH7/5ZyzJjTdunNqf9KQFq3Fa1oGYWlCJ0lgchNKoxgwBlRFMHJ/VEX9rNwh3NKDL1
 JjCkhdiEJCELC81jKuCwiR9Pr7d1KN6HwtRr0rWuH3TlxQBpB3lkYSVj/uPHjnH76OcQ
 fXJVGhFC3OVfpNgW3fXs1w6C/Zo/GGdEv/HIGbv2F2CMm1WJclNbiolkC9Om8iRD8kr2
 2+PrZXx09rdfm+JW3JVSYORFiQglNPEl2j3OxFnL+rU2GsEmGgz24DkEl8VoNqvtK3pk zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38dg5bc2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHC109288;
        Mon, 10 May 2021 16:58:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvBxX/OiLOrgJ/xr7j93himIJjL0NQleFfq9V0KXTSGNUcIFGQmcbCJVPr4CCQNf3KIJj17YWbd7X+kqUvIRZvU9Y2CdWXIm9AuLw8i5VA/W//pT5nPVBITu1k14XqRwsQhS7CuxuTnNGsA3FZXz1WcQMPc/3CWhCihlnmPwuEULehJ/3D1XytXLpDAQC5HGNkOTR9V+ocaq9pDOO5PMCWxcIqiF9ysm1D1jLj7AfeSnscqrH3Y4yB6Ttb87frZupWFH2uAeVxFrhFrGoRN5kfkH/UP0XLz43wxqW2Citq0LPvayHjwroqKd5zXobJQ6lBguEWI3J7eW6Xg89PjKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpVKZYEf9oVK0xIn70NyOFwHcCVoB/1gsgI8Da9CMWw=;
 b=PS+w9GHT4wQPLSu/RSGYUDXbj8/yyk9zrK5La2rb6zMYVCbAY5b8g3bpUhrohpPxu7xPQthJm/Re8ajanLkYbo7QHrEHx5Jrs8nI/FQDGnEv0khBdRDG2Llg+wct+HwtuZ9S9j6iS2CrGAtXkTCjPIx8Pn9dKLzl1bpN5KWQcb/3o+GySobj82+It6hi+9zfBEg6W4WdcQaoTixiYlA7HNebv3XvIzYbTjWh4YUy7u1zXZn3S/0LkypAQaPLiDZ1MtTaigmE7gsGJJomlTad+GeD0TusAPKWdpx0q9yKlrQ7zXspwJlenqzO4gtsGnn9Q03Q+cZATnvS9qqsgu06uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpVKZYEf9oVK0xIn70NyOFwHcCVoB/1gsgI8Da9CMWw=;
 b=o68EgBE/6IoPN0w+RByfj5yCDCy3UsX/y1B344HIZXMyEq1xdnx9Jex/N31G7drHy+9eca/r0XtRzgrMBQwjmOlqspEHR2pUjep4EvVn3AVszffNmyaIK+CK6YEz2g59r02ZFzzvNkWKX7sq2mk5gKcXD4/Kx4QXpX90aJf4QZU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:50 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:50 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 03/22] arch/arc/kernel/troubleshoot: use vma_lookup() instead
 of find_vma()
Thread-Topic: [PATCH 03/22] arch/arc/kernel/troubleshoot: use vma_lookup()
 instead of find_vma()
Thread-Index: AQHXRb2/F7whDJMve0ea4HAGjCf1Dw==
Date:   Mon, 10 May 2021 16:58:49 +0000
Message-ID: <20210510165839.2692974-4-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: e12c3ffd-f300-472d-45b5-08d913d4e256
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769B3C86A01CA3BB5F51300FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkMZUR6Qse7/qFxqPtrtRcjzcSTG9g3IFScTxn4EOh5FpucDWOsgBGuMOZGMxMaYtmUDpBeC7TfXF1JSXI1LCC1NsX2uBNLhpBlpI1suBVi/2lHHNSdtdl3ml+1pOuLwF/q96qmrJUHXN6xCKfdKgMlCMW8ipYt/KrDsJdLBmbaB0R2MGvqXloDbws8mOHz1UUYhMG4f9l6WL0Ce726p5WmBwCqjOlgAboMvF7wMjHMi+qorrZNvlvaXLItnnGNBcS1Rd0u+jNNNxO88s8rGOqafigbBccr308bYzQatW8TSxS08H2+I+sWPcr3i+hTIbdI4O1/nZlpwYq8MbpNdw8ERf5u+wiFmZkF7mKUzpvo0KcgsLUYstXrebd66eWtRj7nIE/jrxacwWlgYXMq1jqMfb3yGoLdV6wdyXsrwZNl5SOv1kFn7UqakZ6h86Ujy5rE3acCXjzuVB+RxHHHqJ7E1+vgDdtDOIdKIBV8vUpYrD4pYbpUFrC+beZ3Dw4IKn1To/o9a0ZMXsVjywfIUi1ROFtq2p6c8kBasT9ccvMSvOngtc7AQEBY+k0ResNXnqYpztDvZ68Gle7toTwE+uaDlaVT7612kqWV4Qspv8S0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?kD4PY1j8FwqsAm2/bv8RZiOge+KmbMHfHO4EvtVaJR4KuRNT+lwoYr9Wvl?=
 =?iso-8859-1?Q?Fy0lRf9RzjbLFURynAIbZbBPf2oedA2sjImgUOeMT1JZxldpCeSeefDAfW?=
 =?iso-8859-1?Q?smbDVe1Ysdl3ItkBoBM+LXkASu6L4FN3J5OqbMsGM+Y8xCAky1LxR/6p99?=
 =?iso-8859-1?Q?sRU3K4KHLFlrjbnAr6Ft5IEm+aO5kW6P5kfrnn1w2ztF5/0jwzKg0zq+qc?=
 =?iso-8859-1?Q?WilfFl3nRS/i6/Bx1gnIDNzUafshvQNWur/X9fBt7zUkPoJEwM8aeEyyt9?=
 =?iso-8859-1?Q?A3SWWxBXRCWPAESTDsEXDs891dqw/UwOehLqnB8mS8P65Ux9wwSteLCZis?=
 =?iso-8859-1?Q?qy25+H4L/jK/HBRiyVAkh7oJt4xPjA1FzdjZFNbv9HZnsHZX1Va4A89gpv?=
 =?iso-8859-1?Q?RsFbNwMVLfKGu6lVKOgFZFD4LMb21u4+90R8zazjwEE4fpOOZAXlTPH8Ly?=
 =?iso-8859-1?Q?ytasmrYPTI2l5QMgSsWjBIsnhlHA6faXEufOTt3prgZksI+qRbDz5Hlc8I?=
 =?iso-8859-1?Q?CzGektGtqeq+v4HTJ/l/0EjtAk/Y9ftZDJ+ihNg3dLXCXrFY60wbu9HBxR?=
 =?iso-8859-1?Q?N34EvbBhuvwr+xts/XEbh3YKw3DOSl71OyPWn04GA+d32wZvxSVoD/8fXq?=
 =?iso-8859-1?Q?H0b32kAV4JFcjFBNLCuMTunQHumNQRFggKo1h1tRR3oZO7HHJ7MFvkxkug?=
 =?iso-8859-1?Q?K6U6hbReN23K2EwHZU6SHxXahKDiemTEJxBwWPUmsT3P/BG2/uv022pISt?=
 =?iso-8859-1?Q?pdBWZOVokrG7Sf4K9U0gg414ZhpU7/mZ6QF4C5JNjfGa2ACyHGn/v/WoLp?=
 =?iso-8859-1?Q?V2dfXnJ1zQqjqalsHTaBCgRNVSQioTbj3Daxs+giUZmMPMxn8OPqxmNug/?=
 =?iso-8859-1?Q?usSnxNr03QtYsuuFLMx0b3+EuPiwMt9/U+5IFcejH9P1I9RziWP/COEb+k?=
 =?iso-8859-1?Q?rMn5BYO35f1YoBT1ZzwqqeDiYwvF+qcNSz+EVQ6icyx715eFzv25owCgyR?=
 =?iso-8859-1?Q?v1ko8kS9WaDN3KNSlhcf9mAaNbfD0gk8OAHZoTjeZRuhuZNYzUZPtuF5IU?=
 =?iso-8859-1?Q?SfCdmXwneXP+xCj0yQf0EEh4FkMSqXIo852/bwO4JpXooWHkZG0FJVfIBT?=
 =?iso-8859-1?Q?Ir+91bo5RqCJMAiscMuyK96AADdhQ+6oywXghb9lVhl2fAWJEbzf1aDusP?=
 =?iso-8859-1?Q?P5vlZLnm2JXIZ3UnOH8JXl9U7vhWVsRbPirpGtY+XF+ZPKWRbYFJJqB5zv?=
 =?iso-8859-1?Q?pEcS6MIrdowgSLsIWDnM73ueUoDgW7cJ5Nj2zvE1vzXXNUcKkX9IPOSNb1?=
 =?iso-8859-1?Q?8BS9dySUZeVAvywzkRagho0i+YTIcBlMBHoTQ97ctq2H6EvTZkBactWEkq?=
 =?iso-8859-1?Q?MGyn4jkG7E?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12c3ffd-f300-472d-45b5-08d913d4e256
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:50.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwFcWcCRttlQ0bL22Pc8b0U1ooqOvlMle5j1u39kWl51THcOZnnEyIKq2nDKn2SrFpHMVeHWW2DGR9NxyuE2Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-GUID: P1nwJSshixonnhJwR2COMU8eGgepcOBg
X-Proofpoint-ORIG-GUID: P1nwJSshixonnhJwR2COMU8eGgepcOBg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
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
