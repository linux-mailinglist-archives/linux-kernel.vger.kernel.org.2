Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7B36DBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhD1Pha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34474 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239980AbhD1Pgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMvOU009401;
        Wed, 28 Apr 2021 15:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5huNnvy4rf4ZVFlUAx69SjcmJS0dLvxV+43Wi/eNk7I=;
 b=OfKQnQSdYggh8Yw6KC5baGk85zMj3vgkRMIxwr5vx2tA68n3LNGxduPvMRNzyk+cjHoH
 8P4QHQc4Mx6rJKnUdXz4hpT+vs4sNhFryVQhwpk30N8XkiIaS5gYq0mDKg2lVKmP8D1A
 tI5ADByH2/JaJ+xyYtEP/LIbvdVhvQjfZiWZ7YjNmhmM9XzEGZK6RngFUH+7IT5+VXDk
 L014rsXiifLzvS6JPo3SllI9+2hGOUm04Xjl/Nc1/I0h2fGSlaTC3LYPRrqD6bjQ1B8g
 oGTn5t2osCHDxj9ZuFW0os5lu/5/VWmkjNHj/kqtDyEgm+a7FDTnyICAf6AZm1TIu38Z OA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:51 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZorA158269;
        Wed, 28 Apr 2021 15:35:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3848eyqw48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB68Ld3Jjb4yxSKO7PDac/ZrF8AdGDXTcHF5OeGMdk7WCHMi2ie3xcsyZx80DsYMo8i6QSUVSbJE4boXHZ8SraojLuCsI2R10NoEMf/UP27WlvklvS4esdGqxiSDT/5sE+OWJ/uJQbBMAWaG11n3lT+pTi4A5VnubZvv65iNk5DKS8woJdr+6lM7oVzalpkMnPseCs6xqpWELYfkzbqvI6fcrQZFQthpC95uwrIwymo9JxONpk2KBJAS9zOS36c9RQPJ190DNIar8D5P/br6GeqdCaxAT1+4K3If+NF04cUON3EOI24Gfio78PmHLmETGeVvdLpgar+jXZfXeEXsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5huNnvy4rf4ZVFlUAx69SjcmJS0dLvxV+43Wi/eNk7I=;
 b=RE7tpLCui8jdDE1qXpHDOn2UOQB4pFLyzUFg58G/BfstVCeXLe6z+uiIxgYrLfSSEbZBWnyWQj12lEQmUyJv+bwE+0QLGe0o9ZZZM6iAJSBKkjOkw1rjvJ9SH7dxU3U/OirJQnixMwS29ujNC41SgQsqarcR0+ALQOgFWA9cRYoYurxehPfVH4jvSlTcD3+KBWuXOQrGWKENsILU0BokvH2R57G/AyiHtoHDSlzMYzQDCtXlVQsGS85GpQJjD+sltk/wZHvyo+1pk6Z72a6TSsQDH1CoYWEuYJ5jE7ImtQFiBKdrQGFsYMR/wmJRcdHQGqbin5lEu+Yq5SLdwdoSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5huNnvy4rf4ZVFlUAx69SjcmJS0dLvxV+43Wi/eNk7I=;
 b=T9Z7UrmyYrIi51TvzFAtz8ojiWUZIi6XugoQ8xgQjROq6tw+10H7q0aKH4CCK10vaaHk/GnaDVSZWgR9uwj/3ktOkvbjG/WARM1/TyMrtzU2Zlipl6FRD3Eg59r8TKgARfI6XqSAehmjznjt0cIo0tMdKaxliNpYCViq1/aqS7Y=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:45 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:45 +0000
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
Subject: [PATCH 05/94] arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup()
 instead of find_vma_intersection()
Thread-Topic: [PATCH 05/94] arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup()
 instead of find_vma_intersection()
Thread-Index: AQHXPEQn6fFUbe5S50mxPCgNKNEZRg==
Date:   Wed, 28 Apr 2021 15:35:45 +0000
Message-ID: <20210428153542.2814175-6-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 24062a1c-c8a7-4084-7dcf-08d90a5b4a60
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497A4354CB5730523C9B19EFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMISpVJnbpnDyWQF/EndPhPebCUI5iliWQYkdVyEWa2pmuk3HNHtbD2UI7FIsWc0b8BuPwFgyGIWLKlmBdMcR6iPwWcvWgu2PtVrjhygOCmqirFrgcKzOvik0qn/P+UR8aINQWRD5V2diw97VkNi+TwXOu86wauKghuSzdchoDOjb8YlasZRrJKYj9nyh0Paf3ftOV/hB0wdAE2DWxmxYFyjkDadi8sPSYULAbnKLfgz+wYd2lH260ea/ZCnS9XU6SEnpIFb0GJssWbEQj+MxpGtBy0JSOiUUuuEJV99GzCOrkz6v7cyRyiHDg/XKTGAwazkr/WWbZzFogezpTMCw/G9WXUhaC98aym7fdupUbqO7rRqN6q1ptNcf4uoeTIBdCsjRRyqn+m6ItysH4Hc2zT/BDiKVOeFmWvQ1GgM4kbPtoAMuT3JObaVQVyAK4/tcyOs2NWBedsvw2IhZPZ+o/pTsvjmWdT4/pCtW+ZiLgiAG+NcY0DaXxEI6B3vJBy/JBZT7upDMFn/axUepQtXxCfMGhVw87hje23qYxRoHn0gMaGzO6ieGZINwUiJ+uA9eymKL1SMCq3ipIW0GcADmF58sd4ll28Vg/DuztS8ZCo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gcF/W2TO++/2PykOQ3Fe0qrKlYQILJ0H/wu7jpS9NzSikWRsH7YLVGt3st?=
 =?iso-8859-1?Q?FS50Hd/V6k/MZEHdOl3hMuED4sCbeHokTapjdWiGMsC25zZdi7gkwKTf4N?=
 =?iso-8859-1?Q?o/zZ8U/NlcrcP1n0gO64jb4vt64iTAZonrL/idNCPUjYnqilzJtnQuaqzv?=
 =?iso-8859-1?Q?Sg5JoUWLtgA3n/Xl3radt+01efl2QZhmuw2J4P84D9WUNzgF5eH25BEeuv?=
 =?iso-8859-1?Q?CJ4l0mra0W+3VyjmPPT+B3OnwbqO+0kilHV42kj5ccOe6SdxXCVxbC3hOc?=
 =?iso-8859-1?Q?sxzY2QvlqMW/1eIBkhjGHRfsZbGk8LJuj29TSjMor0Mxxus6J3by4+K28j?=
 =?iso-8859-1?Q?vWZYO4PvZH7rkzxsBg6NE1XMBUdWnpZ8QNaI2O8uukMlJW4UY2+Oi98Xoh?=
 =?iso-8859-1?Q?QygXsuqLN+s6A3ru/1gh75aNZthTktj6fYJk58MFFQFChY/ROBblZ1U9hW?=
 =?iso-8859-1?Q?JMN+sPNDQ4p3v+iObl+C6kyqlGU54YdvJYxXIQ7ZSJREU0s9lq1/47YBUW?=
 =?iso-8859-1?Q?U9QTJbZpurZ77QJHfRPD4H2UiyOF7Nm4Eb8loQbhOwLcvicHawumFnmbBs?=
 =?iso-8859-1?Q?9NT8qKhkk4OjZtlFbKyOiLWK0kBc8UZ13N9wkA9Hd5Bw4vH8FUXkB1RXyW?=
 =?iso-8859-1?Q?O4csmRJ3QII9cVGUNKvoYCXGXu1HLtF1UQWejfkIWgXsg5NtD6sIPIfUXT?=
 =?iso-8859-1?Q?ldeBBLguQ390ph5GWE0zaSRKuGOEqHCDV1Nb+3hLJyeVMvt8NAlbI0vRa8?=
 =?iso-8859-1?Q?f9lxoH3AMx+VjmFWfqzadlwmh09+8AzjTLWWz5xv3uk3jCkanYr3HUEApw?=
 =?iso-8859-1?Q?lQpyswSdxfLF4AoKTTqLH8xtlbNxlYNh/r8dyb/XZDbUW/YmV1gXv4FMRh?=
 =?iso-8859-1?Q?6B0tEz5dCOPxi8JFK/9mFX371SbDNIrzGA5IVfwy7IlRQXCfF/J9/VkNDI?=
 =?iso-8859-1?Q?iS23s747sxDPjynLQdfiX8+mORL2v1I2lAglRBCpUPXezCk//aUWUc6yYe?=
 =?iso-8859-1?Q?QjeMAE7z0Qjc9GtiInipGpRpKwlAHIDr57HJZcJHCpLO4FbQWEXPiYfrNm?=
 =?iso-8859-1?Q?5TdK0bNxgad96shILEHEWesjHliaY42fjzPSHyAcoEEQvT5GaYGICs2sNw?=
 =?iso-8859-1?Q?Dz54tP/8poZmFTvObcbRQyVRFuxgHyOJuZYCKc5AKJmYdSwK9X7CthxmZC?=
 =?iso-8859-1?Q?hQ4a2x8TG5e7UdcAq/ADnw+TkgTENqveNOVZGrZ78wEyKINRtrv1DZRK3k?=
 =?iso-8859-1?Q?PV7QoZgNHfeeJn2N3mWSaGO3vZggNgcLV2GEnCq8Er+RvgHryjeUGOc4VG?=
 =?iso-8859-1?Q?GMhbX+GlbaCxSB9uneCPkqLp4D39fNlGmp5Mll4hMt/bSu/+WZPuHHNF0s?=
 =?iso-8859-1?Q?9IycN8x7+6TQSaHVTks3fHl8PiFwXGYw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24062a1c-c8a7-4084-7dcf-08d90a5b4a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:45.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PrS2xZjsFOSt3fYwknfvzGLZphRH6w1mPsILNKQzW93eZdbFqZfzaQK3VjCtwXSGm85/5gBd1hqjZa3Frugdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: rZzQAmgglwRuqNthVScyZE50bWof475U
X-Proofpoint-GUID: rZzQAmgglwRuqNthVScyZE50bWof475U
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new vma_lookup() call for abstraction & code readability.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_h=
v_uvmem.c
index 84e5a2dc8be5..34720b79588f 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -614,7 +614,7 @@ void kvmppc_uvmem_drop_pages(const struct kvm_memory_sl=
ot *slot,
=20
 		/* Fetch the VMA if addr is not in the latest fetched one */
 		if (!vma || addr >=3D vma->vm_end) {
-			vma =3D find_vma_intersection(kvm->mm, addr, addr+1);
+			vma =3D vma_lookup(kvm->mm, addr);
 			if (!vma) {
 				pr_err("Can't find VMA for gfn:0x%lx\n", gfn);
 				break;
--=20
2.30.2
