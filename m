Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2C36DBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbhD1PhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32486 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239702AbhD1Pgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFPXuv015928;
        Wed, 28 Apr 2021 15:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6RozRhsNbDnjGxa9Ezr+Rad/MvR7ncpZbNMnQdQAoYU=;
 b=A7FQ9C7n7h3BxuUqI+36zwryCA/o0OO0UEAZooDDjWHOMzCFHA13dbJ7jLZEPyNM2cu6
 xl2WPcqw08ZUnEemyYI/m6WwCNcGl/z+qHZ6AZEYqwn4iKBrhcG4IRztt2iqRc2/ubon
 7ikcLC8MaWKfjeyJVVF6Co+BRWHp8xPIws97OwQ/PlyFpR1N5Rro8bYUYTL0XrTZ46kN
 mA89r0S8bOKokYB4nbbhva/mlvAx+YTQDlL2d46BGBOqlCIElBhP4/lDrkqFUY8PPTSe
 rtfBINPB1A4jWQH2s6kXAiZJhgbPt/Cg3eogp+JNKGs46iaZOdbq/1VKN8dKxYMi3md6 JA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAR003673;
        Wed, 28 Apr 2021 15:35:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUjYDk2Mq2MnQuXsEYGSDI7uKbJtkOFuLeWJ9Ilum4qh/0XH1KbghT1e2jb+p5xa1y+j/+KGTjl/decSkEbzSGXJAQb29ZyLGOFpcMCU+orZGMx+XnxgX7MXIMJyJgrqXEhWdkfRllX7VD1ExixQHmbXD7B0H2QuWixI7VQdhihRQYnuzX5AM1Jpp/IsO2YklESK8Tlujmd52A4+t03zEuR5l4ntuzWNQIt1TcW1DDdUZ/TUj6LXx10m0t0JCdOZ1Igj6dXUvG1Gbjzy+1dLG9XDZkhzjzssqFcvke40R8nb7JkXbb4lgMxUETe8Tjn6W+GEYHpRpAv1DzwbMFooRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RozRhsNbDnjGxa9Ezr+Rad/MvR7ncpZbNMnQdQAoYU=;
 b=Vc/HOc9sQSKY7Zz/iooltVDKaKHoozQT7naU0GL3s60c7TqSQIPmNdpZoB9CTfGpRcvApcGVbW45d7WbbOnEgPfPjssrbwznTtKFi+pAKj3yrhAP+fAEUXwUgxplUV2a+BbQ3vZjZC6JbgFOPfpldh+kumkiPgoUiSMXLzZ5R14yasqGYdAM/vf3oY+kUNN1DfY+nW0Vvmwbs/TXCragmsBcuMJTIkJ2K63BBZnACvUDRuEBi/eWkfAvPJ71ZJ4mcSJJHLD8kL6A+Mb0HMzbRVHGdCiFYl4HbguOCQjxiiiNWUf3bpsDs4XNTo2pTRK3b54UJAK//93NbQMOBJDPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RozRhsNbDnjGxa9Ezr+Rad/MvR7ncpZbNMnQdQAoYU=;
 b=FUN7+rhZJOOR9zAAQKa5c3Mt443DlL93nqASZfszfTVz0SRyDwFzMR/5ooiueBs96RXhmDWxbczZqkk/IFBK2HtdZum2Guk31TeRltD6A7NQtlmBTfvZI5UxUoI6aWrgbqmasdSNHWyx/7AyJNCIJqd4sD8eY8vQ5hjlSS9FwX0=
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
Subject: [PATCH 04/94] arch/arm64/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 04/94] arch/arm64/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXPEQnUDB1dankOkC5OvvTcz4O4w==
Date:   Wed, 28 Apr 2021 15:35:45 +0000
Message-ID: <20210428153542.2814175-5-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 263942a3-3141-4559-0280-08d90a5b4a1c
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB449742715671A167FE16F82EFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSkjyazA5Slwx5NN9Xj7sFfpS6FzC2C7ekkrnHe2YCNRVvSMAdA4Ujk8ob2niY0OZyW6j6YauBl1gSWXby169kb0ls1nDJKpJIzi6ZgrscYmEIXvch/WEaNzijt1/wYTRgGFCVxgnSJlNn0AcBoaPeJwpKvJRASpFW5eN7jQj+WVzvHVezkb1N4C6hlE6OvEWSWx5SMV458K/9pX87R/PDevM0z5I9ZwO/aql30b9P2mF15ry5CtZt3cwOWXWXs8V8h3SQN797e3JDEetjYy0KDnVwLDVjA1DchCPV82lt2LfD7LkJ6o7LCybFBp9HUqhQRe0Fl/j73w7v+N0j+ntz1Yf8Ra0TmGkdStsHPyPS356ff+dm9ljUdv0VCJHSAmEfHQz5BZ0EmFUFDsgQfKb5XmjV9wCcCwyHsnNAgZNKGfThCatvqDzZK0Bd6TGOT4UcrmVTSsI493ofl2IGO+rC6rGwBV2jjuE869KUu7XKRaO4GaIWT6mqhaODwb/xSu82s2fII1g+vlQYKzCFKracKlavtN0zosa6YSozNuO6sRQNTg9ndAYnkm2RhWEJNr2n9BpsPNpZou4upb8dD/sJdYrbBgBK+waJyCmp+c0Hk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?NB6mUKg6lyIgkQhZGHG8y91OoJT7yw/JTt3eW0prGICQWXgKPFDGy9iZAw?=
 =?iso-8859-1?Q?46j7ZHXzsgVdiL1Q9x9K9zIaDbjxL3pEE2mVLgFAZy+VtyP84CBlqXsm+V?=
 =?iso-8859-1?Q?64CLxnOINtVCeg1PE2Rz/aHTTl9iFpHJIFINzyiK2tfgW156t7ZZoCaP7/?=
 =?iso-8859-1?Q?K2oRbQIr0CYlogf3pGfnlsYrR0jP7bPCfHWcRjx0OL7vRolchKtylCkS3z?=
 =?iso-8859-1?Q?xtQ6vfXRGXOqhQwBRb4TueqnDjn81JlnuEXA0F9lddjGr7iPTL8BUSorGa?=
 =?iso-8859-1?Q?xA2B4Hxd+oIfSWshxRpbu2rkAI7jAAH/yLp2snWdmQi/e2/yrj+ToGAo6w?=
 =?iso-8859-1?Q?9mdn9X1yoRmvJAkI09LkTe0xAcYlopxnsIViSDG+ui5QCKsh8WaNez0pFe?=
 =?iso-8859-1?Q?GI3mZzhuZS5Q204MDl2H/7Ma7tqScS6fFyhVQdbjNsL437dNB2h2bbd/PV?=
 =?iso-8859-1?Q?HZr7dLV9h/cY9Xp5DczGyYJEpouD10bp5u7G/XzIFmE46ZRbRJz9I+Jzbo?=
 =?iso-8859-1?Q?D5nejxErjePv2Jb44bdN8UpuNPWeRYIR1uPxICjoYsIZDrb3FwxyAskP7G?=
 =?iso-8859-1?Q?jwZ++QQ3J3mIOo/G7jQWDgz2XgUdqAYiHfi+eLTkDZ43psN91CM/G2l8lR?=
 =?iso-8859-1?Q?Yp9t9uOebJ+mBrRoLIgeiXCsIf8Pkgpj8j5oAr8FTytSUs2oeCgCeipFd6?=
 =?iso-8859-1?Q?2oCulCCM7wbX7nIN/2AuOnPFLJZiej5F6OGCYED6pRV/4QQTxbQNDwJJ2s?=
 =?iso-8859-1?Q?9mWY5f3H017rvs+bbdGzobmqCdwQPUqbTKhmgWQ1U5i2Y1ftYb6Y4MfpdZ?=
 =?iso-8859-1?Q?CYzwY8JqqDnmLnswdNfo6gxnqXHL86Sdg3sOKe3SvnVxVM6fH0oeJzh168?=
 =?iso-8859-1?Q?zWAz8nk9iWDPSWjIFn2XjEcDXtILoZQgi+yT04maLhwmBZ8A9Ynz1MY43E?=
 =?iso-8859-1?Q?bzFAPmG0gH1qwgtzd33OrHX5UVirU+Rc8en2SEDqgxQ6zGsKohVjJ72CgB?=
 =?iso-8859-1?Q?8XjzYiZ6XL0SuB25jmN06ETpo8ekhuJnxVs2ZOJsqIKsyM3XH4GA3gZDCx?=
 =?iso-8859-1?Q?HSuy69vGwu9ioXYqIFSVFIKpgEGwMr8nMQTmfXU5uKm7ppUm7WrteELxny?=
 =?iso-8859-1?Q?SyEdZ53ampkxbEDfvAw6Yt9S+QwMVIlsBK8hvV4uj0GwDohF+AixdClGAP?=
 =?iso-8859-1?Q?KMXwARjGR/Gf1ObgwYbd+p5a7r2veYGvtpec4TmtkHWoX43Dy3hXyN/x51?=
 =?iso-8859-1?Q?O0PJIxXu77wVzka+IwILHEFCX113CVP+092Ql/OOapEFok7UKuguZT5sA6?=
 =?iso-8859-1?Q?4YlVFieejHD1X/6XQ5oyHVXbSovMuJZOTgYbvd5AxmUXHr/pD+knnUaPuV?=
 =?iso-8859-1?Q?XPAGY9DpFLAEJnmC9QgJ3O/q9gu+dHTQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263942a3-3141-4559-0280-08d90a5b4a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:45.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgC2TPoi25YDuxNmOZB8REuXdWpkDWskFCwycFyX1sxN5UiEyf1QWy/MmdSvhzWOLnqerXluURJt+xCgPEg/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: qjvmP9j-VFEAv0i3BH8zLOXWnZKiKp7Y
X-Proofpoint-GUID: qjvmP9j-VFEAv0i3BH8zLOXWnZKiKp7Y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new vma_lookup() call for abstraction & code readability.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index cd4d51ae3d4a..11069db817f0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -855,7 +855,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_a=
ddr_t fault_ipa,
=20
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	mmap_read_lock(current->mm);
-	vma =3D find_vma_intersection(current->mm, hva, hva + 1);
+	vma =3D vma_lookup(current->mm, hva);
 	if (unlikely(!vma)) {
 		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
 		mmap_read_unlock(current->mm);
--=20
2.30.2
