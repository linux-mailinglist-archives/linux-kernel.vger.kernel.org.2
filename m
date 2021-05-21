Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10DD38CCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhEURuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42028 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbhEURti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUOpe083255;
        Fri, 21 May 2021 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bAkh0jHWdyZt8R/qoZSa8Bciswm9Cg/FvXuGVZH+qjg=;
 b=VdpjWqv/PM7Dpe5rz5Z1DkPDMlDJ8GPf98pJOrZX5mZ7QYut8JseW7A9ZAA8a+oUuq3w
 QDext6HxPfgthIiMlwzVr6OZvRVIL7Cfn+AC7cuKMebhNa9zYjMmjMw1Qpl2b9KpZ6X/
 WQ13y1hrqhdIcW5Pr+iMyKhwNiHjVg7A45cs4qNgsP8ZFV406CNiwWeX2CmKzsOFrhRl
 2qpzhsh+K5QfHaAOoajhUNR4ZMAjEuMIbaLc4ooaklDswT+N7MudQSHlnK2Acq/uVyPE
 iYNv/DJGQH1r7EWpjE0zC9q75uNr3MOK0wg2yuL1l1dTzaeCCYpBdaioNhGxuVFanRpV xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHkYWJ095609;
        Fri, 21 May 2021 17:48:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 38megnskas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoS7f7N06HF+QOfbITsRJ+uzgOeXFHqRK4GYaxjqPy9SNLm3Zzjt8pUPRCO8UxxuPSsMV4NitzVrV5V1oM+0m9+7FCGYn8LzftTL//knY0QDC+IpKfrSCxfaVgWBCbIELOuG/wcUrYKkspE4Eao5p6CWiYZUbb+1nL8pphstN5+cvvo3GYLjbnhsBNXL71ydpJ9lCNAC0YWjU8FFg9EzI4nWrnxWwxm4LOsMISlMtwth3xg/SvRlaBOxVyW0BE+n3SBnumLYdJ4A4QM7ff6ko04wBE8qkt9zCEyvWLCKwZrUShH7mpighP1AkU8wA96x4lqHJmTvZMSHkXo9fMjq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAkh0jHWdyZt8R/qoZSa8Bciswm9Cg/FvXuGVZH+qjg=;
 b=myYHe2g23r5Y17UZ8qa/pJmV4wnRKSNEtLbSmgiAK1K1iAUVqjFPWWUpc2Cx9wVaF60gvhI7MJhbKS5KwF8GH5nKmzKTXIPH5fp09ymKAJDWWuzZwIoeQKWjbPo3Dtt1PLqXkxFhHyiS4v4kEIzGHSdQ6uPs2AJnGj0kHLeFrmifpU1egbgCeMQMYRb0jIxZzX6n90Ay91mITxeC0DIn4+jz3wmRPQHyaHA6fD12vPoV60pWxxNGmOTcAkFm+TZ3phrT+jonEQg0BmO5gbB5GWYwVGVAGrIXDZJNG2mkaIx0A3/BarNOLaV2i/GPkkb3zOG1Vv/E7fQB1WEtMDUj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAkh0jHWdyZt8R/qoZSa8Bciswm9Cg/FvXuGVZH+qjg=;
 b=h90H0GopdC9CGhs8S1jf7e4Ohs+ENiXi0j+4FCfO9TYFOcRthtyF0/i6SleJYjF4slgy6YzceUIgalwa+SVu37vW0janiu+Y6nKtpZNAfwmqEHDzAPnHEshrH6GRZP9EhFyywFKqxjdOAPu60I7S37VHxXUq0DshwXOnbpW0TEw=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:04 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 15/22] misc/sgi-gru/grufault: Use vma_lookup() in
 gru_find_vma()
Thread-Topic: [PATCH v2 15/22] misc/sgi-gru/grufault: Use vma_lookup() in
 gru_find_vma()
Thread-Index: AQHXTmlzj8GM5mCXjEWDa79gRC+buw==
Date:   Fri, 21 May 2021 17:48:04 +0000
Message-ID: <20210521174745.2219620-16-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 918440e9-de16-4a95-a3f1-08d91c8095f3
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467A4EA9E787E9E309EEDFFFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mjR4Ue+mPIztNd+faEjcSe+34+8c5YCJocRLP5j2QZsx4cmTTemwLvE5ZIrwEahtZsT+qedO1z5sp4PWyR4UAEbTCXWiiQ+mKK7Ak7DiGxPDRsLIqrX5+Z60Fu5BfY8VeBZhyshJoYMuUlalTvZIOlhUDJYjgHs3CO5u9GJ+uKrmGdHkO4W71fs6+HAgQ7ScnliHTcI0etFc4owFYwFtTULxoxXO8XM9O2DVMBLWkYr4okJEjWIYJBJZac9bW+GrthrEWDTeN/O5Sx9GrUsYY3SEsCOCBLMMtFLcrwa3QcY0B52Q7aUHZOQSVWG7U5ziJYv90KO5lY/JnARzWTSVzY/F2bDNW0rhaIwjlLCgHvlC/oECnfhtDAcmtYlkLHZmdlTrUYy0Fa6G0iS4fZETLhDHGHmLNtGCmeTk+VpFrxQHvqGpwWBjiw4b7ECKBJcrRTP7g4rZay5oAuyMbMc8d5tRHTFQ1bAJ8DEwgD7paQR71mynA8LTV/5rTXkOkzUacXWxeDKWqFQ29F1NmU/2R9oWA5ynrTJC3PB0eZ7Cgj2CXxLPYY35jiqB73vIlDZ69FGYoSCUjkGxjhy5XLYt6L4Z02mxjVpEl7X7JFwE+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?U+fyYRZdR4o3zkxf5vtaKJTUSZcCoUORFsl9577+xUU6J26gUrr53rgG0/?=
 =?iso-8859-1?Q?MXK6/sktEr53m41ozgcfEiRtsgyGCTU2tT5momuNA2f7WIPHL10ncPQff3?=
 =?iso-8859-1?Q?xx0ekepNnIGB2oe6O1kC8OtvR5/IJTIPy5IpX5ffeTnC15/Vyiy3MmmMdM?=
 =?iso-8859-1?Q?v1XijR2TzbGD2niS8AZcQt8PJ+n2/ec6Yfj/B4aApY7x82f/4AuMET/spk?=
 =?iso-8859-1?Q?QAyNw/c56YobbuLSzXVKkvo0OiccudbUfRdzJix2Ap50dNJfclv3AaTsWN?=
 =?iso-8859-1?Q?swxwnsZEj5/RNROAOW5r+tdKCeSlBYsZ9/VHQj8MSovc9bpU7Dwl1UdykS?=
 =?iso-8859-1?Q?nA+Y27Bs+MbFt3o6x3K5FMV7B/ZTAGjU+v31x5JWSxW6c/sy4TojLGq/SL?=
 =?iso-8859-1?Q?aitjG22JO+eTU+0v+InMz6HWISLPV9O3i/0WSkFdJtmAoa5Ps40Ddibiab?=
 =?iso-8859-1?Q?i7qCcY/eXrJ0g8AdaPWH4OeCWZ5nVlIgHkcpvJz+qSa8e3N/t4q1OUzwFN?=
 =?iso-8859-1?Q?zsPZJjKawe6rheFI5VdxsoDSGd3dzh1z61cwoUs+skHW7/0YEnHpQ0icNy?=
 =?iso-8859-1?Q?C1LiGtuGXQWoYSdWvMmNn0kEyFhU53dIWdbs4V6GSx0qHHOqgT1YxnPiNb?=
 =?iso-8859-1?Q?WaFTxX+JeM6egLX7oem04l3tND6CWEy3UWf6Uo3qhrQZYG+lwycnvZeIaN?=
 =?iso-8859-1?Q?fpnst7+MrhW3P8o/Y2RID8JbAUMT0qEA28CqnyW7+eCwulHF7QnvFYTbSl?=
 =?iso-8859-1?Q?KMq5rKJnSo24JdfWXVC7xqvmWawsLcLb9nYNKml+xMDynbaonadsV4TJqF?=
 =?iso-8859-1?Q?Gkt2kwmPQeKYRexezBcuUepKWyS+agHlfiyclZEFLZsoHtkPUJb/l77Pcu?=
 =?iso-8859-1?Q?2HriDQaR8feN9JeB0IFb77k6jHul+mfKiiYM+eRDRQU7tr4Asw9ByY5VrP?=
 =?iso-8859-1?Q?jeOji8ooSDM3u0sRM2y+/5qJLxiZ0wxJHjoDgphLm1S417ntrxYHXZDU+p?=
 =?iso-8859-1?Q?/1+Lc+co5BHCxVCOM+pb/oTlLOBUePXDnUUHKwe/qgLvb7tSj7X2Icyl/U?=
 =?iso-8859-1?Q?VupXBYyB8lg1ABnzpnUUe1gcUeQ6YwQW4B9alsFbhRqukkV4vR38W8swx+?=
 =?iso-8859-1?Q?0/xdWUodgkOXgk2kMNmb+HmxfQTUfWgeUD25QYwg3cAYYh4m/R+KpuL9g/?=
 =?iso-8859-1?Q?Pxl36BZQTR7A13WKHu6ayO3zDI/g84RagOp8cMyoUelZd5SmzMVy6GsrIv?=
 =?iso-8859-1?Q?hhbJBFAMSgQo02fjrdCTnVJrS+7kRBPKEI6YFi2ZTuPGl0ypbpsADkJD3D?=
 =?iso-8859-1?Q?1AuM+Z/NvUbHehAzXwUELXz40vZ82SwqMBG8hxDt/n+M06IlvJSHV12Xi7?=
 =?iso-8859-1?Q?QJXd1Ui5js?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918440e9-de16-4a95-a3f1-08d91c8095f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:04.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m55lKK5aIWuDW02UKYhiAe8/zol41zMlKnrd9MKKdYHseij7S7IpMOAtVhjiM5ZL+8IGTp//Mi/CiQUf1fxZrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: 3dIVQ6xm0tm4W1byhAbIc8ENSX7TEQsm
X-Proofpoint-GUID: 3dIVQ6xm0tm4W1byhAbIc8ENSX7TEQsm
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
 drivers/misc/sgi-gru/grufault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufaul=
t.c
index 723825524ea0..d7ef61e602ed 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -49,8 +49,8 @@ struct vm_area_struct *gru_find_vma(unsigned long vaddr)
 {
 	struct vm_area_struct *vma;
=20
-	vma =3D find_vma(current->mm, vaddr);
-	if (vma && vma->vm_start <=3D vaddr && vma->vm_ops =3D=3D &gru_vm_ops)
+	vma =3D vma_lookup(current->mm, vaddr);
+	if (vma && vma->vm_ops =3D=3D &gru_vm_ops)
 		return vma;
 	return NULL;
 }
--=20
2.30.2
