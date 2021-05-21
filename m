Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D7038CCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhEURux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33898 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbhEURtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTkpW079006;
        Fri, 21 May 2021 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bb7g4yaqV6Sq7r21Occ52NZF5XHRr4S3MM3/46JZ5b0=;
 b=hDy0w+95NUxONYMb/cIgk9CtDcdgvWYdwRasl2inA+/Q1NjXNbvGMYOAoqz8NC4rs18d
 jiWADgIULiF9WDzwDivSevZRktpJVze50eNjBdV/xTH4O3KsM+bniiB/B8OHkx3Ojpsz
 DBzD/cPKmzZtyI1NPQUttyhwR6y1GQEi0QJ7tYDXSPNIKwwa5z8to+ufnQuNZ/g5o504
 WKjgi54nCTdpCYKbe6KNnyqkMgfqTYTkqc67wdQoCGr/2M1kZDHP3BSoZ1haCLwazimI
 awcvCEKmOB/m0JZmazDScG7XPSvQcA60ptVL8gr+r9wCPzCFrfW9bgYk939d8sgieANQ dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38j6xnra84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHkYWK095609;
        Fri, 21 May 2021 17:48:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 38megnskas-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhnGvDFYu4Mrlafwm+9JNhIWBjRqkgPpUove3+MmvhpGe+928iApmQRGNAStl0jJ6DEKVihnsRYwmoR8OjcflC8FpKTAoDbwRkG/Oh9TLtemlibF6Z6PSsfFAC9QUpiWKus1hvC4er5EPtKe+hb//dKlIjMqVYeM4dkE7SQTZnl1e+KoUgZGxA4+ZPqTaQvUFDPppERLKKqt3EDn8zUTYabzBu/DH+ntjXL19sviyPX1oEpVhDSiXUUg9h/Fz9DpU4BpgixYXvJ3fT94Q8/SLyvoFpVBpb09WL1qS/OCemDIQp6dzf9B4nsur2oWbL+lsTEMryXLn/tS+44Rr0ODoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb7g4yaqV6Sq7r21Occ52NZF5XHRr4S3MM3/46JZ5b0=;
 b=clRXj1DvBOVvDtXDnzFIHnS3n9cJUOy2UmEN5troouVNTK+lYZpVHc4+TUlwBFRDdF30FHORdeLE+aZmX2lZzPeZBOn8B47bi2hsocrTii/53sqPyHDh8PWzYuLC5uroRDwwJw2u93vxMlf2xPcbOFE6iwn/yJviPJxlIxtDEzypwM2EYz3ziMfXdscvWA9V255Z+woaAYYTzbafKYM7C++0mQPEL4gqBGSeKRTTpV5kNtVCdxBx2PERCMgdSVJ26wJKwk2dhtRlu/3qgtjHvXLbs35fPg5vTklS8TsvEIVUu4B8ow7JxC11vA9fugRgPO/m2PKFg6lLEfUvw12sbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb7g4yaqV6Sq7r21Occ52NZF5XHRr4S3MM3/46JZ5b0=;
 b=MY7DUw4hCBdMrphoKJWS39GSU+FYUG9rbCYgcQHmyDU7p0oIdhVxeCqXebzM7q2/1013oSq+yBl2s7HRuyil5h4w5detEku9oy6kql0pnRLmjJ3fyoYv/zYNpUKUXAZVL9YgYCgRtpMwEmCSSdL6R7OE2cQvZuQQHPLgvAdd4tY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:05 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 16/22] kernel/events/uprobes: Use vma_lookup() in
 find_active_uprobe()
Thread-Topic: [PATCH v2 16/22] kernel/events/uprobes: Use vma_lookup() in
 find_active_uprobe()
Thread-Index: AQHXTmlz4hq47phI5Em2l6JBBmvPuQ==
Date:   Fri, 21 May 2021 17:48:05 +0000
Message-ID: <20210521174745.2219620-17-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 6bade16d-e146-4372-3cd8-08d91c80964e
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467DFEBC5265AC778DB1A61FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYPqrqQaU5LZr3etG9gfz+FbsRez+QhZVeVeNvXLRDFauIRpguFDz7jdwADzy+g7GSGe93IWtnMUvN2XCU5X0g1xFov4Wp8d6bZ3mETI4ICdXaz/uHMvI1ZyN9zeSrkKBEdkmvqXdPBTUrk6R+v55DeVCbF76j2bH2IZrZlEN5Ru+TQZEILlXVOQnKi2upwtkQb/aLiSAj2IbWWO+877XYxqpf4g+UIpRi2lI7z9UUxaLdL2jB1k56cFeBXyxD4JpVnRmjKccIrUUxZlei//g3wS/V6+OnIUlPeKYwwinrp9xQEhmRc8tfAGi7kaR/YIGwZfhvRla+BeyIwRMBhuJOOO3BTqP7ePS41mxlEq2NMRe6EHyhyUKdTgvU8S2MKDZd3DWSGQfwpoiHsjQlQ5lJB9QKRlgdUbjj1lG8u8oaeZw3UDGUYb2hLZFEF4gninqY4NWkUPNFQ2V5hxEQT3srQfTiSL31MSyfKYSi1mgGS1EmdDwJMu7a4wOJGBXz5b1++K5ZmVR6xl18HY7wivXNrGaY5cgbtzcY9LU5tgPAX001bOoHaZNa6ELCzjzILDj3DMy8KaKMOe+DVCTJ9L3c1cBb0bzlm5ocCY2KNydjk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?iYUI/suwOup8Ntgzln9fUpjqVymx8WZPwjnqzFLZJ4g58hwiSaIo5+OVzj?=
 =?iso-8859-1?Q?OYXRgf3CW5e3+cORJb6HuUUUmLZhUQSOX3CtW2FEG6YIKORVHF77kWr7/a?=
 =?iso-8859-1?Q?3mmFyZwNrSStA81wh7VRue3yU1fk1D6S2zeL/shpZPUPSKa8Yl8Jt+9ST5?=
 =?iso-8859-1?Q?3lnmMSSIyI1Seecw5B364Gsg4l2TysG1/3h5SFHXRoUWTUgwVJjGiM7ODm?=
 =?iso-8859-1?Q?e/tFPPn0oUeCMNwv6WqrnCdccv/ivIu4jQLnGJpDM7yFBp7aGJR3Fw62mD?=
 =?iso-8859-1?Q?TzKCqDPjQmBuDanKamkUKSv6SWLBtSmXIEq/EAO1WSFDDFN5HcoMPLTKuP?=
 =?iso-8859-1?Q?nZknoRqm5b9QBDVBS63hBJAR7gR9D93GDSujegF6LQ3JibCOb0Wu9jycr6?=
 =?iso-8859-1?Q?pgUL4R8noGndDNpRS9TkFGz0lPnIOl/WO8h3vvEybhRa7k+3zzJAbUCfwU?=
 =?iso-8859-1?Q?3U53PoEqdJBSVtSr2YyHpwUBF127ZM4W52Q9bP0ykSqE9kQkA+TI9cpGO+?=
 =?iso-8859-1?Q?V4eoevd2PzqkbMGuM/98pnQN9jNdtm/TJ/Pd2yItdBc5SbidUQd/chzpoK?=
 =?iso-8859-1?Q?xk4Jvs9UK94qEaQ5F6Bmhr6uSZgdnCMBwcBbAPF19QXz4e9sk2KlBleviU?=
 =?iso-8859-1?Q?qviWVqvYQwRe00Tjnj2o0dCHQnzBixzpGNA+ZtVaR6stNBNUWtvMvYVit9?=
 =?iso-8859-1?Q?5SkIdZICg1fDTMiw1PymGvelBj48tP60LEdvVKuOWGf5gupdJzoIxTHo6x?=
 =?iso-8859-1?Q?72w9fjE/hqm0nJ37PgyKkdyq44fxYPDkJmBRPd16brqYzzFQHNyI6R5OGR?=
 =?iso-8859-1?Q?l7DOINFZEQbvmXojPW5zecagxdZTQWcRBLcZB4+C4/3G0GUMnWIwC4i7MC?=
 =?iso-8859-1?Q?XJqbrcluTSBIagnBBsCAtiHIFSsT3cH5tbJnV5lh6sp66oIoHYZnvC6IMs?=
 =?iso-8859-1?Q?AGZsBVe+CpfwKAZqb8RzMdtJJAs8IEjC8Om/pP+cX3cudaERuWkQMpcXZV?=
 =?iso-8859-1?Q?WrJwcKnY8VCP/HiWhGL6Yhc8qyKyaJFJn93wZ3KwsJvCybPT4LHxg+J7ek?=
 =?iso-8859-1?Q?kQ6oeJugRUY30wZJ2sPvuqBBSXF56WjIzzeIceIAzL5Rb7jA0nCqS2brp+?=
 =?iso-8859-1?Q?MtVpWlhRrkAt5EsfN5pmqYk29OTc9zSlzsXph+trU7C1HDLZ4H8A3a2WI6?=
 =?iso-8859-1?Q?dCGa04oe2Fyrnao5NE5rkaLJ03jukCopai4W5da7a4B1qWTXRA/z61Psq2?=
 =?iso-8859-1?Q?sNOKcTpi4M5CdPy2Ozpe5EDY2hCFIXBjFDBapTvEAJAhfrY3+uXknWHBR7?=
 =?iso-8859-1?Q?c+ZBPPYLgO+LJRCAVsrXK8H7CM5WEBmTX3+wfieZP0ZOxDyoenTyfcmg1s?=
 =?iso-8859-1?Q?kPzU8XQeyB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bade16d-e146-4372-3cd8-08d91c80964e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:05.1008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pk6gB1lXLmiuasRGDEPYhyw+hrhRU7xIniHfxGH+7iXjf5V+xlrg5tS4iZrWi5vuVZy6/PiSIJNyorcXsIDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210093
X-Proofpoint-GUID: ve-Ry2mvIGvrZ-wBDRQAPQgJtb7f55xd
X-Proofpoint-ORIG-GUID: ve-Ry2mvIGvrZ-wBDRQAPQgJtb7f55xd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
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
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6addc9780319..907d4ee00cb2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2046,8 +2046,8 @@ static struct uprobe *find_active_uprobe(unsigned lon=
g bp_vaddr, int *is_swbp)
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	vma =3D find_vma(mm, bp_vaddr);
-	if (vma && vma->vm_start <=3D bp_vaddr) {
+	vma =3D vma_lookup(mm, bp_vaddr);
+	if (vma) {
 		if (valid_vma(vma, false)) {
 			struct inode *inode =3D file_inode(vma->vm_file);
 			loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
--=20
2.30.2
