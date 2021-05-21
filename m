Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46F838CCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhEURvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:51:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42996 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbhEURto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTCsn111399;
        Fri, 21 May 2021 17:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RtmL1Js5HBfjd6BVl0esciqMvQa5juk0s6gowuj6yo8=;
 b=P8MKCx/qOxM2JJ7DuG+JuKekP+x1kjWh7+3mHHwX3goQL2Ydo358qvtxMGq44+GVVhmV
 cBbEYqgidbarIFISFM3CoDSQHznv5GcBQsnWAM9YnflpQP9jDw/McFqiEGLEa2sBSb3i
 Qm7bUPcfbo8gnX2PFSLzkRHwZAVj0v4uvrsKAkDxs1li3vNdN3sa7BDtdanGN5tt3mZL
 TLGuYvwdSO90dO1CVBb/CwzwKn8ZkwpFr3NIiHYJTxqyn4H3OqKWx4Iww7qnnGo4tqoL
 hMJ0PRRpLKMC4utMo6zvWR8TjF8/p3jpAoXut5t2ipnoTxB2G2XQwi8WybuCtpQu1+KK +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38j5qrgcjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHjg56188662;
        Fri, 21 May 2021 17:48:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3020.oracle.com with ESMTP id 38n4930d5j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iezGYUlNn9ITawL/L4cCIFeHeVY2Kybm+0WFpPCEIYg6VZIxK318LCyqsu13iou+CdMk9FihI+S3gbsjDdbwa0tEW/Odg9lUiVOHeUwS4t7/36WUwy6miIMz3ztKiQguFPeIaeEFxuGvbWc7RScf/VDjtc2q5JAkfa2kvoKmt7ToZHDrWCxVwoVvu8Al78eB4ZilUogGK1CGGX1/mQRXL6S0e7pmm3bjEp7RhdMkLV38qT0fvl/BRouteaVCNcxRJKH9Umbb/lnEU5S/asI0KIMjxWXX2ne9cC/vCO0CuJU4rMDE492IL0MKhilhEnAXHgc3WpJgazKLRTsHYk/8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtmL1Js5HBfjd6BVl0esciqMvQa5juk0s6gowuj6yo8=;
 b=AUuxjsnKcVXrXeuQzgBedzrgQ2d/2rMS0dOgPshKmSh4Fqp+TPxk0apEb6K/wBEPlKE2UZckfzZ9yKHUKhv1RAp2gbvLh/jgCjCDu6SKzEv2D+DO+9xg0VDHdT1QkIq/CAn0FBJweZPGSn7OG46Rt1aD9aZ2SpmgV3ywJ9471iXwLDPxL8NtLALggq9ug9Z3z6d+E+C1W91ux+LMjg8Ekk/pQoYtkLg123FPV/+AQlexnCiHLuoJb4KV2iySNbEYQwVoD0uzwy7IxW6+BLi7FuMEavDF+nPKFNBX4BNp6mzB29U+dLTXYzV+v5tCgmeiL8UIMuoeCB/VWC9OuIdPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtmL1Js5HBfjd6BVl0esciqMvQa5juk0s6gowuj6yo8=;
 b=dxtg5OLEpaWcIGQ1VFcRNgHGdu/EcMcpc+h3gSzeciPzya+TU2YrGNQRiTz5gW9eZZi/y3AWZbr4kDd4PRkCzfDTAaLOXiQvt53aEBoio4OOvO+G5LlsMDN+ZigsOCmY4tpXuy0M7VVxw+szcmCJ29FbALBK8c2CirudVuh2ays=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1646.namprd10.prod.outlook.com (2603:10b6:301:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 17:48:08 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 21/22] mm/memory.c: Use vma_lookup() in
 __access_remote_vm()
Thread-Topic: [PATCH v2 21/22] mm/memory.c: Use vma_lookup() in
 __access_remote_vm()
Thread-Index: AQHXTml1kOvKWUpcDUKbCPPyPTY+nA==
Date:   Fri, 21 May 2021 17:48:07 +0000
Message-ID: <20210521174745.2219620-22-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 0ca9959c-3f6d-4ecf-e705-08d91c80980b
x-ms-traffictypediagnostic: MWHPR10MB1646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB16466C3F0880B6CAE1FE392BFD299@MWHPR10MB1646.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRH+gJVWPyYIOLfosov/S+YDJRpC9xWJB/fZKTGZ14f2NbPhOqxS8eHDm2hnHweAxZpX8vOafA8Etoadg7dyISYu+bsX4ixynxuKb03T4A8wTAHTh+TzkaPB7kiHLFcIQa/Gon1m2UjCqKJ3tsX+qLOtfZ1VaYhIUmSnax4tQ37jQU4+1VKRifKDnNJbu4AIUkOpfp7ImsdysPTy2TGjliyeSIjwGfJ18+v/uAPy4uYH16TWKKT2TSmo/tgKhqhnl7xyd/WL6t6s7kRpgL9d8KK3e7VIE3+TbJSFTCAso+RFJ0kAEUXj5GqTVTaq7geNRJ6yeTkpoHp/W+F12S0GLod+aqG1USVfPp+TKcerRs/LuKdhH/wMNHXz3xgVc9iAFU7IKCSw+8BED0znj38WGNFvi+dyyejCEe4D61NFKkcE5mu31dATJDk/7AGtLgAsKScsTQeBRHSvrwCUy0v2b1EWFVe/igtVJSkUEF95/EYdnGhKd1+b7C1Lk/Mk7GOQGenwXU+19MwnoHq7yS5pskq731G6n4UrgFF7SeaX81rxBTInog1PJtyTY0UF6bg9MbCb3p3pWtPBDs/zwuWytTNnAjud6Zd5BeKHl3glNZc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(71200400001)(186003)(4744005)(1076003)(36756003)(6512007)(86362001)(26005)(6506007)(122000001)(38100700002)(478600001)(83380400001)(2906002)(4326008)(2616005)(64756008)(91956017)(54906003)(316002)(44832011)(110136005)(8936002)(107886003)(6486002)(76116006)(66556008)(66946007)(66446008)(66476007)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?u+CLZGl4gRvhYBYFUniUfqHPoEFHJ7BG2+yFNzl2j62OvbGu4bXCDhpQqu?=
 =?iso-8859-1?Q?Bj2AVfKMozuP5Wb1T1eztSB/N2R2WmiKIseuX/RSAIMjFeejHMUiACAjgV?=
 =?iso-8859-1?Q?s+SUQ6y2iwa3BA2NDOuV8OI/bcBxSsjb4Aox7NimSNu70IhWyw7S3ErPgf?=
 =?iso-8859-1?Q?FYW3iCbI+Smanpsa39pl2MF2cFchPchclg++3merozblw01ogqRjbISJwM?=
 =?iso-8859-1?Q?XqT+InD7NvVdYGz0lZAyOBjqDPV1YHbnyZRedqPceOa6PcWYbk3h7/1QQi?=
 =?iso-8859-1?Q?gJa6vbqrp3R2OIk+cKbqz3D3MFdSzG9fN/ifHOCbMnzU8+IAJ8ta9L5ety?=
 =?iso-8859-1?Q?ulWffV3dyk6x8G97KHywDKuq3mggGbX4TQkqj9MU/NKHJNPKCCuTW65/zu?=
 =?iso-8859-1?Q?y/MpuRE9DoRjo7wkThMz/RPB0rxtwQbC4zpzeBQyxuurjkpmi7AZfU2rbp?=
 =?iso-8859-1?Q?V7YhlWlMakNTO86lvOxpD0gtqNGzo9/WLOKC9Y98O3afUn4ya9vNljtt8z?=
 =?iso-8859-1?Q?MqPdzzGUepCM+IZJ8BKqmUrksVF8TsdceQjook6arMgFh69qBYUHcx51hZ?=
 =?iso-8859-1?Q?gCDfv8QkBcKevobFXPNDgh46U8BMRDJIO1MoKfjB1GIjfTx1REIs5Zx/VY?=
 =?iso-8859-1?Q?820/F9pKzZaHd3Z8Ozal1Z+XLaBzFSa5ijliN++e+MLTo/Jjt+EY8AewGw?=
 =?iso-8859-1?Q?CK/rD5wrIdebnO8AKHp1jENA4JR151I0zEPiASn6JkxMi1G+7uLgFhezI7?=
 =?iso-8859-1?Q?KRc5dAvrshp+HZGfv9pv9nw72ClDnPKZOkxn4B2nCXacR3OTj1HjJnTMka?=
 =?iso-8859-1?Q?Ipu1DxepuJA2SFPE++DDPHFaHz+aYTgUBjnomI+8kGZXJ4ex+pR/jtphZH?=
 =?iso-8859-1?Q?1eLVzWUGoRjj/yxOS533R+upMk0nyMWJgWZtkX0S1Z5GOyIQlrdK0J0cct?=
 =?iso-8859-1?Q?t32HSfEYMiqrccbMUJPB1rxQI9HuYPJqObPXLHNGI3GLzTFYLyp/5G4Wqg?=
 =?iso-8859-1?Q?QE4AbqCGTHqWBZsL/I8w9pBcQgcP5Gh+EIwt44rAAj/axNPh6Gcm9fmc0i?=
 =?iso-8859-1?Q?cE0wQIgXoasxDf3FBKVUu58QJC2ZJbl0eCEJM7xcYavh6ABVU2+1RpVup9?=
 =?iso-8859-1?Q?rtautfEvzxNt9V0Ac2S3/4xaZhdiHY1f7EqtedzlO1h8+JZHgGfnwASERF?=
 =?iso-8859-1?Q?xkf+da+GGfcnaq0fQ2eR59MtZFm7V1/2f1lKqaY2+yPrGWRZT0zkGrIQCb?=
 =?iso-8859-1?Q?IM15aJus+hDmvy1C/pYIoIb/gDlUO4OHbakFuTZwJt/XAUMmiLm2lyeaKG?=
 =?iso-8859-1?Q?8u3thmHGpQpk4/d6NLhyUZeGQs+RmlFHu87j8tzOyl1A8QWFjxUpui0myD?=
 =?iso-8859-1?Q?RkzWHIXqgY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca9959c-3f6d-4ecf-e705-08d91c80980b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:08.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64uSA1gez9JxvrzcDA0UQAWkrVOkRq31u418zhUFAjCsb9RJw+Euxhm0ZX7F+21CRqu5HF/Rxde5ukGnDPcOng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1646
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-GUID: m-apyIPRFrecFNLayWyPhz2m0mCR-Xnr
X-Proofpoint-ORIG-GUID: m-apyIPRFrecFNLayWyPhz2m0mCR-Xnr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 86ba6c1f6821..e3b56903b111 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4954,8 +4954,8 @@ int __access_remote_vm(struct mm_struct *mm, unsigned=
 long addr, void *buf,
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma =3D find_vma(mm, addr);
-			if (!vma || vma->vm_start > addr)
+			vma =3D vma_lookup(mm, addr);
+			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
 				ret =3D vma->vm_ops->access(vma, addr, buf,
--=20
2.30.2
