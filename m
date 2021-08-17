Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A23EEFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhHQP4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39068 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238117AbhHQPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkDb3023520;
        Tue, 17 Aug 2021 15:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+ilX6LO9Idoocvnv+cHWWAvmokrJwh74dcYMoVhkW5g=;
 b=1LiFZAAc5w99+3+FSTQ+R3vgLZNsgAvE2gMiy+GH9Qui2MuAdFRjLuBP1vVuxNJk/BTR
 K/WpTRRz2px/Ay3ibH8qPFmPpEyn3k/1gn4nx2Z0SlJSotMXjwtVXugOWrXhf+f0/hoP
 oamB6NCoKw5lvtMs/PYwOZz8rOHMgQTxSCaheO/Fr5t3q3Can3KrsvDqDInLwqzMgjxG
 0PLfp9/ndCnCws4EMAUjID+2wRHaFLCGCIH6GovesfqKmt+MZ+Bq6u0r1cu5A5h75v3K
 DcGZOfZFfn1OhkKdS3ZdsfCrbxFfjeQcCnAfb2fkZxr++9VTQiSK05iKlshevvFd6Okz gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+ilX6LO9Idoocvnv+cHWWAvmokrJwh74dcYMoVhkW5g=;
 b=LOgz/u0T+xDG4SruXCLFsWt7nU8m49knzUruN14zD0lDurQKL2HEDiduy1z+NMI9wyOp
 y9Jji0895lhoiXdsdh8huh3BUbiFhJ96qTutjLtkmpU4+1uxoQVHKgEO0q/Z1lpPCU6g
 TLfNxDfYPKlvgV2W8H1Xr8RcWQBSIagJQX3HRif8yGkDqBgULrr5g7+8QFFT/13SPi7O
 Kd3posLjIcNJ79IvbMn0qbklgG2U3BWnhGPQmYLLI0V0VWesb2b/AcBHkPazsPng1k1b
 AzdPMEWcCGAmT+7S9qdAOzGol9yKzBMaDLa3mqIruMk221KWgFJEYi1FkQPgpwDbAd29 cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4ked-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfc158706;
        Tue, 17 Aug 2021 15:48:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo4keURoukXjHJoiD9gJZ61jWvF+csnC4ilo2LHAJ0AY5AfbBTsoUVXoDHwVPuM8lmhk/1W86BfvFyv2/iPKMcnTZDuiNto6r8gn5tulQGrFF80+oJ0zG8faX2/sVVY0gJVEBSH+bIUmLJannzdnjDtk34pFZ0PUaHCLof5cojN22kL0FFMSvOGf1M7kS/USq+4anGAsPDsxQqp9FuArgESlHxgmggbsWAQvyyxghw0c7PIdJl2gl6pCwVVATEw1nT8amyvOUKBO0DPFPKg9vtKaeMhalwDl1iqcB63pt+NRiisMTnuihglwdUepU1ldeo+qGvbORKz5IMCOYNA3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ilX6LO9Idoocvnv+cHWWAvmokrJwh74dcYMoVhkW5g=;
 b=Z3TAv6d6rhRiB9MToCic2ZApqh23Q8kZRy+lVzsJhife3GpkWKZl09xutZkuFoOCL0isu77lXhLO1q7WxzjB7nhyVYzRywOo2fl5iAG8GptD36PWxWSdhuw5byIVoZL3nZe0TDvr5GhthWDZ1+DEjB0gQwJG/UwIFuzvjnrLI9/WLYBIVep8FcNYeDriJmvWO1gTh5aGEss8iMnp9p8SP04SDmhWPBElVGJ4cctXNNRGYEBOEld719NmGLUhAflUPVXoQDv3XUlk1ZZn0Gy/uRzuwKAPqu4DxjW5Yn9oltw9tifwZguic1e0LIF1nod/zwEr4cC7Jt0mxHNR93FK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ilX6LO9Idoocvnv+cHWWAvmokrJwh74dcYMoVhkW5g=;
 b=kExuTM2g9E60DmeZ2Jjvw4gHcsv0cgYlkz5gLFP22xrGRhBv+W4ArlCYkoDuf1TrujrS3LyvX0OELTVXyqMhHBqO376H++Qey3kLl+dHi5RCV2mbiR1Ivcjiyzlo1PX4dHLH1PT4NEkm7JoeX5UIME00STsgTYAY2BEdErE9ORw=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:56 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:56 +0000
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
Subject: [PATCH v2 47/61] mm/gup: Use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v2 47/61] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHXk38vNULo+HVkuEqkjgwDb7Qz4w==
Date:   Tue, 17 Aug 2021 15:47:30 +0000
Message-ID: <20210817154651.1570984-48-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 60ef6d32-fbc9-4e7f-96ad-08d9619661cc
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580CB284A3F2166985E1C36FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lAhch36U/dBkbDKZUMZ/KJLEFnGxBZxRZcxT1i1y/G6GM/rpW4AuuJsHMkxIOjwjhCJEaQFOc4Z9S7op0gCjElZJD9EEUd2onMYy2z+Sm0YpnWaBRZMO6PtrNCa6N3pok2/0aFjWChomdipbOSPwedFEoN3uTJSvyP43+FtMv36+6BqwWq5l8Z4FW7gpJrunl70Fd/wzk/Ks7sWozFdq6Wtxvlv43vhhAJC4m73Suk/l075J0eLSMox7eKhmwZecrgz4Y02TuXmQImTFEPj3EDj5aL2R1o5IPdjWN5ZKWp2v9cHiIpYjx7wRPPXhXnHh6oqadptbtzmc7vp1zlAMRk5RSOnHBaxqgSeWswNYIyj77UGx0XEV1YO6Xcmy3Ws9l3bmlWE3ZNbzRIDnhIuxUlFGmF8pLLiIH2nVk9yJlMIwKzko+UCZnn3L/J1A1Wi0UPAo3DQZq8LozmfGnlD+IcxkHJK9ClKFPjustzbx5IB0GVvh54oVypBzwKYymQKsdDyXWvt/aYX5Wej1xqh7mwq8TWNutalkF5bF0hN7TBpvhantg21Hfd+4nGyJL3NEcJCVOa8A1IPBhczN7XZYLYy1uLv49wMXaKoBBukWQtvN/O3HbFivintZacdPlOG8rhySh35nmjxRCL8sajw+FiRByC7vAM5JKiOQuSbEnidqtPViW7M+ZYroS/n1nhSm15zB1LEfku6ShXhBMUL2tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(4744005)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QQ1TnHuckGuWLmmheI2vSzDHMRA7O+L1MHAbXIlxctxcUt2tx1Zkdf1xpa?=
 =?iso-8859-1?Q?xX84+9WuABZc3LHh/PVO6R6Sbr1xWTQ7HYg1l8twaY5ydT5EAnjLsxdKFD?=
 =?iso-8859-1?Q?gr2If4AzBGzkaZClYHHV0rQIckJc6n3pCKDPR7aKgv9K62ABAATNsyVh+c?=
 =?iso-8859-1?Q?2wOjAEI7EKpzgMVpPUfRpVclzk1lfT+BDLCPFueZB+H7JP9XmFFE40BDx5?=
 =?iso-8859-1?Q?hhjfK6BveKOELsfJPSwQeXeLY/isHikPDkenOWYfKp5rWWgltMpfT4gP47?=
 =?iso-8859-1?Q?QmT5OfJ+IOqySmPoEl+VhM7C0M4SWdAbL2DylFbG+VVc/gxYB+AGTAe1c4?=
 =?iso-8859-1?Q?m2WnqKdJyT1oav6edotGUIKsFg2bbpEkuR1ZP7ENmpcrBJmp6ZS6X5rg2h?=
 =?iso-8859-1?Q?ZF38l+aZXLkoidK8d3w34WhBrcqvNTce1OWZp+4XSvq2IAiAf4XLSPAOxl?=
 =?iso-8859-1?Q?nyPzR/BUsK3lV8yw7PNMcp/VtwzLkJJ/5ljLLef/hTg3EDjuFuhZDnRqel?=
 =?iso-8859-1?Q?hnJpyjEMVAAABCgm4xkl5kD9WwXAGD79iE1IqldIzoEvIJ44azmn1OV3Pi?=
 =?iso-8859-1?Q?aa86voVgYDu0nMdQglXh8TotXyZ71W4hD+ynFywmwBx8alvqUKb3qdaUya?=
 =?iso-8859-1?Q?m+Qrd5EIqZ7WGugydcE29OjD5IP29oVXpjVnM4Uh3TQU+hPVJLsdnW7xif?=
 =?iso-8859-1?Q?HIaHAlEI+tCZXrd5uXaUtrgrtg/DJzk2eZ2oVgxYCZYTeyVMDP+Z2gTDNC?=
 =?iso-8859-1?Q?V3dI+7f61TOexhCkz7kwTvpUX7oISPhWVNJjJrwxryBj9ZmGZbLIkavT0v?=
 =?iso-8859-1?Q?h6cmmBdIkKvqYP0y5jXmDMjozt/qAa6eVijwBOiIQ7vT6iWkI8nufidW+0?=
 =?iso-8859-1?Q?5Q4WfCejRTzrojbmzRlSUxHoLXFNqHQGRVoXJOHHIq9zqUOVOrlVBy0KQy?=
 =?iso-8859-1?Q?N4biLF7J+1SHMer6i3Yx3SPUkhgOxiQ/rk11gsd6xcT/TlL1qbOM5/vhRx?=
 =?iso-8859-1?Q?QYy6aDNc3PFlB0fnrW5fWRjh5alhmhT9/bGQteiwl+LMurjIcet6YlrUQ5?=
 =?iso-8859-1?Q?kBXHtSrOXYlPWY5CFwFXCAR2IOp2AerPojaIws7Q8N7ezdyp1fsAxekZYR?=
 =?iso-8859-1?Q?cqm5rIXTJKZ7wOldIUkLG3Wb2sObqJBeXk5ne8C1A9Kyweq1Mq7SHlTyiN?=
 =?iso-8859-1?Q?li3CN25fkjzA3kfAAPy4hSudEIItQgUtGVwTmYAMLrxC1q4lec9iP/TdCQ?=
 =?iso-8859-1?Q?9zKMDxCsCm3WEe96fxrseJfbHydEoQ+fMeb/Y24OC2ohOzPQ1ipKzwUWAq?=
 =?iso-8859-1?Q?OX/znqYe6oCV9+P2El4UkY3nTlG110g3psHBF2PriFBoMy56HGGn2j4FTe?=
 =?iso-8859-1?Q?UX2M8wj6yf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ef6d32-fbc9-4e7f-96ad-08d9619661cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:30.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvb1/de0cXQqQUZG5IbbYyEyJITW3wnjuiZ7IyVLmIIQdFSI50pvhpy6GHRl9oYXZnEEGnSELthzduxlgtq4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: w4TI19xOSBlGHjawgs6LwRI52FTT9GJ-
X-Proofpoint-GUID: w4TI19xOSBlGHjawgs6LwRI52FTT9GJ-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2630ed1bb4f4..7a34765d28d8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1580,7 +1580,6 @@ int __mm_populate(unsigned long start, unsigned long =
len, int ignore_errors)
 	long ret =3D 0;
=20
 	end =3D start + len;
-
 	for (nstart =3D start; nstart < end; nstart =3D nend) {
 		/*
 		 * We want to fault in pages for [nstart; end) address range.
@@ -1589,10 +1588,10 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, start, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D vma_next(mm, vma);
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.30.2
