Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45E379C37
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhEKBou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:44:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43262 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhEKBot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:44:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B1eAiR152152;
        Tue, 11 May 2021 01:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=tliQe2nRMAe71U0aVzREst0rCk5Tw0qZN13IYlKOZiA=;
 b=hvOmLvZ7urAgMSDk6xTUbqTKRDXMXT03xmnZZ0KwDX3luCjgmTy0ljF9/IfqBFaXOk3N
 CmmL1AFakNxw3xxKz9e2vim3aml698+GE09YPgffiTzcRL+SXqkTW+3MD3+0a3wr6zPP
 9U6jvJuDwwic6E8ELsEbkp2+7YIqN0Tb+iJI74WIAEA24W6k1fUjEXLL7TBDKmuF6rAr
 h59t7uN8ZtPwATBSB9PA/BO2UI5noDFWodcqQmRgVPKe6+hZAALDtgPdrW2nxfpoC/TO
 SKpOHezIPviFZVr2Gt4AWKrlt/lAL22+3DYaTt5tNFy/aPq9nnCyBm/WdeS+RZw7F7Gq cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38e285cbqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 01:43:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B1a0ec033019;
        Tue, 11 May 2021 01:43:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3020.oracle.com with ESMTP id 38e4dt8avm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 01:43:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0g998HnyRDMnIloDtXIwHQRaRIm+0Mwsgir3XspVBYQyYUkvRB9HH6F2QML1yLlRwJSaUuLhat4b+/0vZyIKJS44c/MJeXgBtnie9o/Hv/Cy1hAAcqkzbuN6f0Qbp1tHq+TPZqd5FNvKS9eNBbBjbN44yiaWK1/xHIBfvbwF+BgUpEfyKNYHMJDYdHW/DQbRW/AkaTwmZeA/XlnWXo+ul8K2ooMR7Os5jZw7opfzZxDUvBRhu+Hnnq1SwSf63gAsZyoY/2RKhY61WN9fwzvMfsFuW1KeJ4gAHTG7gdlNb5D7u1RYh29CWkm4Q4ELgBOdInchnMk4odG0ecHiQ5xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tliQe2nRMAe71U0aVzREst0rCk5Tw0qZN13IYlKOZiA=;
 b=TtbMHGzcLXvga5ZIY6OOqccfs/q1gsEN08Us5mejBWQiBvlDqEc8j0A5zlW+2lEWH804ujJIpzs1ATGgtWvenxUJp4Tq8KOSi+vA8Oa8SA8lKhPQkk4+GJ45aUf9K9D9fE/DD91giTyU05tnwVAX9tkPtOAebqznW0fJg0vglZB1vyokbxqB/WfSg1FcSc1fgWhp1LCIL5YfuzfAqJftv1unfLoRlIS5HjkF3uKsfeSnzLuy7VD3lKLOSCOXP7E8GhfOMTbWsLvcF9a5tyMkP72uZF0QT7tpOfcaX2BQxaOEGr/i91rmD7W5bjoMfUZLuoXOg68ZUredOXEZ0DuVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tliQe2nRMAe71U0aVzREst0rCk5Tw0qZN13IYlKOZiA=;
 b=CvjYz9ifv0GJuA9ODygdkTytXmA2ktQbDZVIF6WTNPCUzw5RvsVX56x2gZvyS33rjw65CWUDwvjtUlKq59I6fo6mSaXQLcjGJ+/K6vhs9qDvlXSJPGHs6P2sfcf8EZH39aEQveg5Y7F4ywre4qgNhrSUy6HzPyk72hzaSVOAVcA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1646.namprd10.prod.outlook.com (2603:10b6:301:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 01:43:38 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 01:43:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] mm/mmap: Use find_vma_intersection() in do_mmap() for overlap
Thread-Topic: [PATCH] mm/mmap: Use find_vma_intersection() in do_mmap() for
 overlap
Thread-Index: AQHXRgcQJBtmOtgs+EmCsyux08q6OA==
Date:   Tue, 11 May 2021 01:43:38 +0000
Message-ID: <20210511014328.2902782-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e19424a-ab22-479c-175c-08d9141e32b0
x-ms-traffictypediagnostic: MWHPR10MB1646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1646590F4B501993CFFB283DFD539@MWHPR10MB1646.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNpltm3CdgeHXEvt5rz627cfwmTGD1S80/QHkk244JuQeLaFQrDtK1POOOup8GEODE49Td7StXdA1JO6BjIUH5YrwENEbq7lA1IuezGe8moZ5eVybowWMCgpsJwzu2okq2pGX3+idFZvT9fEkxM9+7M20vJZZROvwpJmS7CmFWKibFXqFUqGVUKfX9ok9HKDK45Votmi9xshHHiOKaQLsq6+wUEmHjZEgtcdqmwBQl9XgOem8PcAtiE4hqivFrAp/VrVpf74EccwQ4RJFsRYTVhQPbVNCZe+foquHguZQEj0YgB83wzj5CXnMk0tz9DQMI3FypMPWf6TkTcmo+zcet2PDajY7j9wU1AGb1Rum8UPJV7MjNMKMKGFbKGZGvbZti6przYAMmkSkQbJdvAH8FOMjEy3sR2edM29DRlyLDDlVB0znj4erm2uFiXvUb3OSNv7zLaR1Nk8EqR11qXE3C8hYFE3DhhrpRkGjbeR6EdXEk3e6BeB2U7xE7zjcfQ3dqvZyUWhFKKkBW0GQhq0b8ua1kVpVGtdgCyzY0NRS+zsf0nch71z/8D7M/PJpyb6gSYkhRtqgDQ58O7dxOeq4LnpsPHjhPixY36e7Jr0G/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(4326008)(83380400001)(66946007)(2616005)(26005)(6512007)(107886003)(66476007)(64756008)(66556008)(71200400001)(44832011)(1076003)(2906002)(66446008)(8676002)(38100700002)(122000001)(316002)(186003)(110136005)(36756003)(6506007)(5660300002)(4744005)(76116006)(478600001)(91956017)(8936002)(6486002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?d+wyZChoqyLBqdqwmGkM+tdNryLx572veHaZSI4idgAW0/VOVg+hPQ1EZV?=
 =?iso-8859-1?Q?/7hxsPll7mUpUMkw6CItOTIlCHgnvwr5FODNObdE+K2bIlkkKHnkVKtxJ6?=
 =?iso-8859-1?Q?Hca0CB8DBFq4yMQR9jboecMBW89KC1HDHyDFjAutfoHkvTYcRPOMTSV2gu?=
 =?iso-8859-1?Q?3yGtydUNEA6fQ22Sf/BPISp7KDaIrctFKUWRAzEV5yGvu0dK19G3Gu6ZXc?=
 =?iso-8859-1?Q?dKoMnmZwh5D6Tmm85b+E1yDBtQIfaHnp4DmKSajvEf5NggnfdacFBCOrmK?=
 =?iso-8859-1?Q?1Rlp3/CuwTpxxoRc7T6DV7W4KxAMZ5bB6mbYJX5/KAl3/CCdcPRhZcZ2L7?=
 =?iso-8859-1?Q?OK58jcSZ2jU55wLDVnKJ6T/DWKL+etYNK+x7cgh8rF6FFD8kDuBWcUnYow?=
 =?iso-8859-1?Q?Y59A0TwNJjQXeRNaFEJGCeHGJXSLpW/8wa9+RH3kUbCF69PfgpOT6EHBOF?=
 =?iso-8859-1?Q?j33EYz9sY31oeONzvgxSTyslwtWNnxMJiCr8UxN1NgpNzZNfx2dVBM9gHI?=
 =?iso-8859-1?Q?WRohjCOu69bvAni140my5TVFSgRNwtnDCidGFw8YI7u70KbP4RdFP/IWxD?=
 =?iso-8859-1?Q?HJS/EX9a5l7RLsAg7nW1uF5sgzBuy0jkM0WIh3kslHat8gSLlVLUWljNBc?=
 =?iso-8859-1?Q?rgjCipFriAXJkG07Tf/jhGkVmIpIjMIQquNR5ww5JuPt8HiBSrFh7suAr4?=
 =?iso-8859-1?Q?rf6QYQAbp4KFjmVI6jQjCQT3kL6mVsuoKStnWXRJzSVaQ5a4EbVp3e6a3J?=
 =?iso-8859-1?Q?2JQ/u7gNmWHUmGrSQrdFpPd9gl1MdO93o42XUJYd90k3Kv1LT6ooPEnXjB?=
 =?iso-8859-1?Q?iJSMkTTLfuIlnPg7W1YC5j3RiHoGrME9mz4kPXFP6gWdYxtoHTpOKfviQj?=
 =?iso-8859-1?Q?J5gnQ0TZvkc4WOE4LRpPWWgt3lkFiloTmM5w36gyyQyMGYesQm3ZD4w7uw?=
 =?iso-8859-1?Q?UF/4vUPUB8OYn+/fG4YQATWSd0tg7DY3KbZXLGrjzLntOC/xfX/doF7jpw?=
 =?iso-8859-1?Q?wxQCxpe/osHbZseW/hHd9CXrCZF0oH4ZGhelDBKPOae8lwClMfOSssY8+o?=
 =?iso-8859-1?Q?YF2Pipdej1gtwVhaDCmD81oATLnNYrKPigT2QS9U/cHQFqmTVmdt6UrpxS?=
 =?iso-8859-1?Q?AzaNIpWs0kcQh/XR7dIRsEwMNK3KhEJ5AN77QgmS8ibfxvAB0O6gNLA9CJ?=
 =?iso-8859-1?Q?OKUZbeotedw0sJC4VMnNbym8LcPpfGltjyDmbK4NgStZVY8wit5fRAMZBP?=
 =?iso-8859-1?Q?yJkaH/D9Np1RpEVX+PSDc/SZxAF5AYaVKM/g+kF/7xN2vI+1dWHsL8ZNK+?=
 =?iso-8859-1?Q?wvceE+WleFRt34UgdKYbZa35eGt2WvmyDSNkq0o+OfP99RRM+bf9yagCFC?=
 =?iso-8859-1?Q?y+WarOhp/j?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e19424a-ab22-479c-175c-08d9141e32b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 01:43:38.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sBELXYXjtlOVWUTL7UJNIL3hpceTNI9t+tc18HpPRJ/br9Cmw9aJCCAFsGiANoAQk/e8ZjqpS6T/oHc7pAoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1646
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110009
X-Proofpoint-GUID: L_Tgw6VlEd_VqsZdjhQKfPN-exfkuGOc
X-Proofpoint-ORIG-GUID: L_Tgw6VlEd_VqsZdjhQKfPN-exfkuGOc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using find_vma_intersection() avoids the need for a temporary variable
and makes the code cleaner.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1bbb3225c958..016715924529 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1456,9 +1456,7 @@ unsigned long do_mmap(struct file *file, unsigned lon=
g addr,
 		return addr;
=20
 	if (flags & MAP_FIXED_NOREPLACE) {
-		struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-		if (vma && vma->vm_start < addr + len)
+		if (find_vma_intersection(mm, addr, addr + len))
 			return -EEXIST;
 	}
=20
--=20
2.30.2
