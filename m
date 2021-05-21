Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D022D38CC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhEURt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:49:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhEURte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTc0p143238;
        Fri, 21 May 2021 17:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3zZf7sezme1jHNMqiYkuFr9o4MdYuRjYAHTl3X8tLW0=;
 b=zKsUVMZQHWXdgQ+0TUruAvP79k3XA0fv4rrcP2Y2D9Nywsk+iPcg5eAjKxfxjzfsvoD8
 3HGi/Wl/UrfZ5iZttwagS1ktCMYGX0+DqKBjGHNpDMwPivstGY35PfOUhIXPzB9MKQJj
 1ku/yFPFGztItSufAvirxkDJ3V+Zg2D0Boyja4MKND7AlrN84YWH79JDdehbiiThNlg2
 5jX/cUyfy/y4PMDSB+zBMAbHOwbg3SmyACfwDNAiB+40mYFi2Ju1pnxXJGP0+1La596g
 ufpt1IBQH2EvnBtdxY1F1sislcZlfGGFDZ0Gk+Pl7OoTWSnc1UEXaReH6A0caMz5nUO7 dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38j68mrath-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rT189475;
        Fri, 21 May 2021 17:48:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSyOTwc4Jgcg0KMiMgkAY0gAOaO4axu9gwGcrpZk1K+fZYh1LUfXsuVmxpTjtXXD11VX1ikCfCfha/LjyjEasVNg9cj8tJv33Wye+H8FYy1VO61/OaagsIoEhHSfxFvAhTkAnhXfLfIVVfYEcmeXAfMu0zHVEZvOFXDYvbL0ApU6bb2Q9f4WLU0I1w4LTJkQZMPJ3fERkLgbOYYroiokLRqmCAEsQ5D+95Bd4iOK+aIqLmeo2WuqC7LiR3Eg83cWbyA1Qtd8bzbvbc7h3Jum2idWNvgGZ+w4XrYe/w01Z51/PNFNPfW63C0vXIHvhSusqiQaQlSIED6PHXASjb0reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZf7sezme1jHNMqiYkuFr9o4MdYuRjYAHTl3X8tLW0=;
 b=RCERLFv4QMn2AwPmT3kNz2gDCPo+vPJ4MvAqnwld4RfvsT80lVFAzeCt6SqT5WhqFs/rD1U2lpgj3JdRCe1aN3yh3MGlquXqlpu2RONl1gsc8il5vBl3jHB0mf9nsEa1hnY6rxwmcVN2gJK6dsrDsl+q/PBRQrwHYhHco44hZ7cTolamXB0FvLmIzesTqbjHlQA0jOO3ssc4/9DXGVlO09IM9IvTTN6IUrEkC9UheaZA2/Le/mBnpQrooeOVWw3UZGjc2xTqx5SE+B41fjJDkiAoWr8Qr6BySWQzdFbaQSL0kjUStARTIgcE+9/AnL9HgKoUqSJiVClL2vqK+9Qjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZf7sezme1jHNMqiYkuFr9o4MdYuRjYAHTl3X8tLW0=;
 b=vZEYUY8FB0fTP5ShZcCfpzw5a50hd+9Mkjo9ev2r7aZWXSbSU5KLnudg2cQQ5KNBVe8BWtDeRFPyFZXejKsnkg4dSwprVq6Pm7NX/6KBzOf2biFsKRLJybR68oJ0EsYBqIFH9GZRtE+BuUU3429P8cKCwwBjzSJ/ZybGDVKG2Dc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:47:59 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:47:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 05/22] arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup()
 instead of find_vma_intersection()
Thread-Topic: [PATCH v2 05/22] arch/powerpc/kvm/book3s_hv_uvmem: Use
 vma_lookup() instead of find_vma_intersection()
Thread-Index: AQHXTmlwo9JEXWHCqEa9hOTtXZWibA==
Date:   Fri, 21 May 2021 17:47:59 +0000
Message-ID: <20210521174745.2219620-6-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 90eb13ef-dcf5-4fb2-c579-08d91c8092d9
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44674FA8AEBC89051F1ED704FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhW/45fpvjYz1q3855dC8uUwpFDZu72mlhAMjG3aTs9MYqzk/XhMdFF/wAPQ58HF7wCPn0SvRMJZtQVDj2ywvwPbvCizd5q8H6c70lOGnneYS043YQ2Ltb80oeeaIOhfLPkndkMN95lFWaO0quq5hM2zS1kzPCZQGJHSwGllrc954v/lcH/vOG/3hJuhG26W0Uk9ZqU5rzEI47eKaR/7FnCPVWzqjIffqnUqg5TsZXYLTu4D6+1XnthzmXx38J5wuSZJfOu4bIe4yAANLpQUvXKwyq5Q8yqRcwiGTg5sjv+oqio8cive9dJMdIofPrJpiBmy+ooWIs+8M5+KD6OatIXV/mkHwh5+YRllI/3ZREBwNO42dg5n3syOQX2EiAOISK5DQLjhu1DgbJtM+2IfsqwQ/GULU1XdaqpUg9Q343SlUNmD7Bu38HzZ5qN49YXAuKLCfHgDVOVD7N2v+ndKEiGVAE/ybk96nKQL1biA7ySEBdt676B/h5NhXDbIaPUbNFAxWB8yQikywneZql8LCGzFcQj3qcR2N+AcfebgsdPqtBe76H4YqXYLskWrJFkSMMNaQ9frHw23IaRRzRPddT0B6KpX0tMkMd9J0hk8wOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WXQaVo9ANUz3HXgHQjNJ0tBjLEXzut8N1xA1EyFj+fHGsOzE6hVNcw/WRc?=
 =?iso-8859-1?Q?utjAvkHI15wXd2LbA8qGiRBZI3nb+qubin8SA3I3JalUeVRJk+BjFScVHE?=
 =?iso-8859-1?Q?fC8XkkcWVUvjfQfab3o9hPaQ3h7X+kgojYbbNmXP0AjmwEKYt1Dex8BZ2K?=
 =?iso-8859-1?Q?Klech9iXaoCre8DDBDXptNViNnIet1rf6fQWCJnLuOXR1SGUy+mChBsx0d?=
 =?iso-8859-1?Q?i3IhCwXbrwB4H3uSXpG0oEcWECuOeq66l1XlCK/Rbh93MR64nyEj+X6Jls?=
 =?iso-8859-1?Q?QVZnq+QZI1wG36l16poGtmlhPL8aUXPVMKwtP7Mg46Z4sPBCbJx5kGVfWk?=
 =?iso-8859-1?Q?1BA2eNEJi8dUVhs75lDjpmYAz2CYq1J5Ku1Eef7JjE2wzutL3E7Yyn/0pm?=
 =?iso-8859-1?Q?qMcwjYxJD8vrd2HBBa2pr4umRH3rtOF8lax66F3/hwxJD+MSRp3/D8S7K8?=
 =?iso-8859-1?Q?3fvNZMnW+wt3knZAOe9xvUcUt13LHdAmbhOS0AGUga11SyHM3ObACEWosf?=
 =?iso-8859-1?Q?jdcxyvqp4CSr6zLLZHPs49GCUrK0iLcDy2M2qnPbCqOTHhOzz15kzM6ADA?=
 =?iso-8859-1?Q?J2jKPXDdDtn9H8IDyefaFht6G7JPc9txjljuz2Afv7eaoVhxBx2UOvYeXY?=
 =?iso-8859-1?Q?1vOPruyUbiUeU/lGZegQuUwxotsrUwYMTO0HRzMZWfdpPLYyiYh27oUy/g?=
 =?iso-8859-1?Q?obrl6JCPlA+d3hp5s7sthjlU9kapn1rzl/js8i0dKFWCd4Mvc8iJPGVeWW?=
 =?iso-8859-1?Q?3KrDNB8kiMI46FqGHXeKG5Ba9772rBHteVbElXdY9pRAs/B7Q5+tP5C4Ae?=
 =?iso-8859-1?Q?9LTexEXBbTGMmunxnZO8GxvlA8rEn6ynooEID8qR9h/0s2rkuMsByg5Z9h?=
 =?iso-8859-1?Q?nDO0zgVmOSYrNQa/y8mVGW7u4EeA9Xa93RWPRO6ZYQrZzAaRkSpWcBas3j?=
 =?iso-8859-1?Q?pzldJrPPmjbwikCdAF0vJtXq0tNIIBd+y59WnU43gAF85RmhGqCb+j4CqQ?=
 =?iso-8859-1?Q?BZkt5PgUk0uTxkQrhOKL0ZfMCM6HpWjF3Kc5nA2sVIEsvVw/wCPq6D1E9u?=
 =?iso-8859-1?Q?hBjlQCG7F2Ecnb6Qaq30yz0AoMLOes+tWOybRNsYPRzyIiHS+xlXihwsuv?=
 =?iso-8859-1?Q?NDo6lNCQcsuPRnpHx3tr72Vbtq2/vu5YpsfkdUKJcw9pNweWjZGHB39wZw?=
 =?iso-8859-1?Q?3DBuwge2omBEUOCz4RLAHhx9k0VfJjcDe4dzgm74vHm5+6GAQ9Q0/xjwzI?=
 =?iso-8859-1?Q?KtN8r0c60iCI3aDJ3cbbatULxHdtlU/P5g/2IbgRI/RR7iHrjrKXHvKEnE?=
 =?iso-8859-1?Q?F5ngUEWVvpdG5KnjzbYRId7CoMJKcmiGg24thKC7Yap5GWa5dAk9AAmTEi?=
 =?iso-8859-1?Q?pcg04CQqPt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eb13ef-dcf5-4fb2-c579-08d91c8092d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:47:59.2903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuOwzapp5AREny9jmlm8oMDPpyib4Ck1AS8MhncBlJwUet1IjbuFI+p3q6Kd8xizR5SMdZw0Hyh7ds3h0Rl+Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: 4WETrzmu6NevzfbyZf6woylzeCl7fOCs
X-Proofpoint-GUID: 4WETrzmu6NevzfbyZf6woylzeCl7fOCs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
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
