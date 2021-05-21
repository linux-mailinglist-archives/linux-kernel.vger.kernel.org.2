Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5150B38CCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhEURu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42042 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbhEURtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUlrn083386;
        Fri, 21 May 2021 17:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RkXBBENA6A6Xzchi2ZJ3gs0d7oibFnBW9WJevMMXwTA=;
 b=Sx7D0yVbcSJFAujmuogJ7AoIPgnYo+RagtGN1PURnGhom4xmy+nRIIwbDa7UqpmNl4Tl
 f8ts8pLpMtJHGh1ixJ3btb+pWNQG2+5ChpWSBNvepQfnFJv/KpZtAFU978X0Suo32B01
 ZqmcyZErAjI/Ss9gSIjoUnstQEHHj/09F57LpHu6Ep7sMNk5XLFYtcaBYjH1Sug9J5jQ
 h8Exipl8iuGI0/t0/FViVrB4OLa0pm+MelvRP8tukbYmhrsA15D3kp3FkCasFDCCW5Oc
 NN+1+33hUlp2D2ogvnkkbbZe/rq7zIaKYY1eN666Q25ZfjMd7IwnpEZ2VO0Z1HSAlTOz 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHkYWL095609;
        Fri, 21 May 2021 17:48:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 38megnskas-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/WwFRk9dx4c7RYHhiSo+F17CcQ8xyrB1TMFdgnw7ajqw7p/PzVCtxyGQheiGXVryqPZHsgoTHVXsrovUb6Dc64CEeWOoJTS2R+DRFe6OD7iYskhTNVGMg+SkbxDRVOyRqqNaLzVpfZgcmT3ugYMw/BCqrPHA7pP6Tpkl1aaQxRQwFamv1dn39N+YKE+qxY6EKwzTasV5uPFceyTTFi1C3V4SaFQY9TeAdDSwZac4qBnDRwPkiTvY+m+vlgELLpukP84/8RmbY947j0kBXqjswtxaf6sTMckNpnWebaNn1pgMB3Yzb+vEFdsArGpSQQkFU/Kluh2m870qWnvZQrnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkXBBENA6A6Xzchi2ZJ3gs0d7oibFnBW9WJevMMXwTA=;
 b=MUxRbq++DYFmQHonr7uuwgprRI9blcpqI4r8f+sIHgZJUkwciNftCZbi4FUcmuq15TntGRII49tprs2vtciS5ohSHGC6G5wASm3hMbVZmOuM7CsvzzKKSmpNOI0WIooCTMioIkheoFgV2gN+mk3AE/mORMhHJolASkxZmRieuRDLME4DZN+snHr5T24sgREmc1vgM0DVHoVVnY4R0SUF7WnKuKan5qXExl0Bo262BA73ZFOAaMJaOKOzbIAuRbiOwKfqN/3INVRn6QyU5LpGIiV0vsiF0kdGRXhTNJ+HML0ZNqbmPlroCmmR5LBZv57yrSEBDkVbUedsuARmK9lQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkXBBENA6A6Xzchi2ZJ3gs0d7oibFnBW9WJevMMXwTA=;
 b=MZmA4Yhj8ectU5LYiCGhuNIqmhea7ayrvvQWkk5OeZtFb5FbkIqugJd/T08sm2uxYFPv5FYMqzhpYJbLG/98teBNVF40l/fkViUBfaXLncL3gMFLVKc5xPfCNe4mCjcqQsAjr4oFAyBbSS7hgEIqrRwlf6FlUSg++qLfpgMGPnQ=
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
Subject: [PATCH v2 17/22] lib/test_hmm: Use vma_lookup() in dmirror_migrate()
Thread-Topic: [PATCH v2 17/22] lib/test_hmm: Use vma_lookup() in
 dmirror_migrate()
Thread-Index: AQHXTml0LSrto7fC+k6A9paDA44skg==
Date:   Fri, 21 May 2021 17:48:05 +0000
Message-ID: <20210521174745.2219620-18-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: dd8b391c-0abe-4387-017d-08d91c80969e
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44677DD68514B30DAC072C35FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sYOH224gBtXKco9ICN+aMQw5R1S54fHSEYWtMHdSiFNYYFmFe3ju0dysXxm09SIcDv3nM6X2wXoPhsHvHjrUIJUA4GKT5fD3D90qXmtJqFpbWKgCxTj3AiDLTawFTRwclikKN6zasHZomphyNOtkNUAepbJK58Qmj+4Hfv4L2G+uTjVTFoIqQMMSafzngwR/P/bzhZC4RYufEzRd/b6NnXxD7GeIvd6EKjQXg/NJUIvCpMOir26gjG1RPORTDxmqSDZ86Lmv1j5r+d+rI5um45MwdN3IKHruH8eNp5mFn3fN7SI20tbCt/3bMyxgukeaOqt95OujD2xH/qx6rr3vw3p7sFHr6cLXdLukSCv7BEkJ0mgMh3wSCUNQ96jBA3etCL63WrAFtO9bnnqIyRl9suX1iHH1UthAfbjoZjk1AW0c7GZwxRG/S6XiOyPrz4sTzcYRVff/f9mavaU3o4+en7bDRAd1Dd6iuABOA8FwbdTbuO42YFB+gmHYjMKXtgr+D018O8uh27bYM5YI00cJhCA4AEpLSHQiLL7jv2H1YqAzzAiO5tvsoPmeL2Lk7pQS5/nk4cUkDUWJnfCPuxyMjz0RLLSLUgz1yfvhGKaUMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?DioSCmpn2m0sXdnTEd9raMqpvY6qnZHDAtIXA2Z4GYJmPEcdtt2QbZcULy?=
 =?iso-8859-1?Q?UXdoFThvc+BbW8GgRVqLsqQsb/o4UIPAoSFciHHgH3Rn3QkRUroROvMIsi?=
 =?iso-8859-1?Q?bts0ijihc4JN+eTn7eDgv+0+kbnDmAKL+grCgLipI43hT3E7PYKlsvn3S1?=
 =?iso-8859-1?Q?ISWvqZX9Tr2u0UgyvO5Fd7IT77DC+KKoXiVyzwVQQcqJGsn+3pBLZJRpk3?=
 =?iso-8859-1?Q?IxPCyzPmXu4lGukuT1pFFM89q8k39ob6AUZvLOgVNpNc9JoKfmkDP0UQvy?=
 =?iso-8859-1?Q?qEQECLhvNlhSuEGwvLH8fC+uumC4al+ksHVGx/yo1rOUxoP0cfov/J5hx/?=
 =?iso-8859-1?Q?3UPCr3vOQbKt1/xALwNqSAOJr6yZXp5KBk5H8pApsDp72L7G3DkRMNwLFM?=
 =?iso-8859-1?Q?PcHc1Bh7Bae5m03kVQc+2mLXt4OqSltjCODKbrTAkLRSzdfuhx4O0W0UcN?=
 =?iso-8859-1?Q?D9pUPIv4xzGs0t3BTEVpyAq9VfGJ78Z7yzzCUAfrW1iWk/4y8y2aHGrSw9?=
 =?iso-8859-1?Q?D2saechdS345CSnUY6+YvOQRLmr6zeWd+taCLFRIVuuichKmVuvqfAg5tP?=
 =?iso-8859-1?Q?Okm4phE4vssIookjPpgJh8fDSv1BQOeCOKu7ztr3OGfZiCuraBu8YGguFW?=
 =?iso-8859-1?Q?+i1YdTfPYsQxa2tOlepITJ7kE4JvP1/BPrigqIQQQuPdARUPbuPZP0AgtI?=
 =?iso-8859-1?Q?npjGxjfXwHHXa+Zr46HxfTBN3W5ASOAKkFpO0SgJs8Ug6FADzp8NRE+tQs?=
 =?iso-8859-1?Q?toKk1qEtriFLyVOba9nzBm5lkX1kT42hcdqkFSaQwRWYYfdJJCfSeYFOvs?=
 =?iso-8859-1?Q?iIGH1rE53FHsi9PSScw28M6Ax9CaZOcdCmVL8uj1BsB9eZ2teDoy1dL581?=
 =?iso-8859-1?Q?12N4Nlz738zp9NevM8jxtLJ9f1JqgICSntO85b0SaCw9WfYESpts08aTNV?=
 =?iso-8859-1?Q?syLxUT3JX4xpJBxrqiDAwIC1+B32Z7AQ93EPcYRn5UunCgYPRBJAg2k5TB?=
 =?iso-8859-1?Q?S03ikHtHCZ2cKKqaBZHW33syFQvgM8dhDkodpLY1i4/RfgOshym43eN/19?=
 =?iso-8859-1?Q?8rPXtpHTXZUf0va9Ni9b/jqjMcdkqGSEx0nUKmXRoxDFTuuUKd/GLIetOe?=
 =?iso-8859-1?Q?7DhqG3wWpOd1Nh+qnEAXUK7aqWeFjx2QYiviT3UoM+94YzwlIppITmY9iE?=
 =?iso-8859-1?Q?N19UCL//Ijy6PaN/F0TO4NgKJZfZqKxQf9uZRSY3vNpm/KhmQNXfOEtbEZ?=
 =?iso-8859-1?Q?wxI2hv9NMHNrNOgMPp788hNnvkPHg9+rABy4iPbH+AbZhRCAHrfWtVhduc?=
 =?iso-8859-1?Q?ZpJ4DXmHaPfx1BHf5iHslWPfX9dO6kaKrX52mORVvrf7R9ihQaXRg7SdS4?=
 =?iso-8859-1?Q?81cmKi0zkf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8b391c-0abe-4387-017d-08d91c80969e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:05.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mX3iKhgzWCQhEQkmueT+DvUzso5Lp6UJ0jTvpb6QcgCYBzsZpMUyX7kvGoyQv3VhBpGBkOTRaTv/dLnNM912Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=931 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: mdOVipWhJZ618WGNPLA0UFuoH9Bcl13X
X-Proofpoint-GUID: mdOVipWhJZ618WGNPLA0UFuoH9Bcl13X
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
 lib/test_hmm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 80a78877bd93..15f2e2db77bc 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -686,9 +686,8 @@ static int dmirror_migrate(struct dmirror *dmirror,
=20
 	mmap_read_lock(mm);
 	for (addr =3D start; addr < end; addr =3D next) {
-		vma =3D find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start ||
-		    !(vma->vm_flags & VM_READ)) {
+		vma =3D vma_lookup(mm, addr);
+		if (!vma || !(vma->vm_flags & VM_READ)) {
 			ret =3D -EINVAL;
 			goto out;
 		}
--=20
2.30.2
