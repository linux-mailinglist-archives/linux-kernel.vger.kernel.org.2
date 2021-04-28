Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370EA36DBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhD1PiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:38:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64032 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240045AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOcnQ011645;
        Wed, 28 Apr 2021 15:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=A0NtMNmmSJQ9HVNDpgk8ekYd3cXBJuPssW8iuE6Df0A=;
 b=i09Kk5OWUuSfREIhYtwhI6z3mWjQxf6EiB2OfteLtxyG/DOmIF24E4JbL/lFnoifqeBN
 maReY2b58Utyhtp2b+gQfio4vX2kORRnTgZUO9JlwetM/c/Wc2anyA236VuLyXi74BSV
 uENFguJonHirCz2UIbycjvrVijjxeax6QfhOTXFRe9U0sL6F8B85szy5VgiALOgHFS3Q
 FBtYfyPkaS8LeLjHdmIMO7U0uBEnCiKfILA4cU4IwP6PrDaTuFFDDU60cC8iW1CTxye9
 IQtZpLfWkGyVHvUPiSWIdJMRDWrLz//yv8h3w3ymR3XH6VaoCU7tCjqEAn2wbIXhlrHN gQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:52 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAU003673;
        Wed, 28 Apr 2021 15:35:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm4YDCkfk8IcuS1hRhpLzM+NJGJ0Yg7EmJy9VesYaNCFrqB1fxCLUVsjDufYcRGA86U+SDWlDo+WclQX9+MxDV1kPCEAKD577Hl+3/t7BN5ZWmYOzB6woPFrA22L/bCAs9CDIQIe9xyg24MNPhPLLv5HNwTtVsKFT05ZkjNw2KBjfCISV/Ha575n6/go7JLBEQHJcZsqx61aqTjbgE2MASuCn2jGrR0s7kQceUmDz9ypRBWFl4AZCNq54uv5ci48RDIzWfyefi/vEwGKIA6xsk+rnKkcttGd2MatwX34I+ZY1AQoUD9B0K8xAJ/fi61j1kfwJ9qj45y/bpeJpTUEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0NtMNmmSJQ9HVNDpgk8ekYd3cXBJuPssW8iuE6Df0A=;
 b=QpSgPyik5CCV0JZWv0muWxSASEo0CVP7zFiMHJ4pFEJtTGZkNdMYc9sHuKSsA/SKQzyob0tApRCp2z2NWutI2o9n68ULezKLMK6q/lSn5u9QAoJeVAOzRyw0HYPThh7tOuh+V9/OVBcH7uqWyK6/h9wT2bNL/vHTsDSE1s7Gz4J3VcuQZqWG/p8S/uovJd3XP11nOSOXe6z+JJuyKxNNC8VzfgwxD/kR49Ofc+vOfKWm0g3vdd4qrYXLiTrxIAQtl/pffcBJ2xmjPRGReN3PwRs4voKh/UyicVKV6dNMtMC3W9pgS7LTncPihN05xqSpxo52aH/aG7fLQxV+YGDM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0NtMNmmSJQ9HVNDpgk8ekYd3cXBJuPssW8iuE6Df0A=;
 b=fTILNMyUoM0y5FBIStPzelTgJUcEej06IGob3TzJn7NKYa/Ix3rH61ADm3+jEl2HkJQeOxE6CuklLNTwEEcyr9uB3SnYzY7KDQLyUi7PKxP5OwaUjP3YjA6Pu59u4wbK0fou0sTXdk1ANehbXBHGdvgNjAQ9OTxulkvjOOetRCQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:47 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:47 +0000
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
Subject: [PATCH 09/94] virt/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 09/94] virt/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXPEQoGB4c0UJNVUSnBg9+1Gi8kg==
Date:   Wed, 28 Apr 2021 15:35:47 +0000
Message-ID: <20210428153542.2814175-10-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 03656e14-9bcd-4c74-2e98-08d90a5b4b6a
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44976D4AA85EBB649B176ADFFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7v0ysI1FjyWvIlUTm41JKRfbvq5lJ0/CwbekC9hUm1L6RRGRjMNIyBnYGCpa4uat3L2Poxn268T8HKXqz4qwOCmHEFR+nAX9goS3MUvZ8nC4QC8XLuHiARslrFZswM+k2FQUXsyx5zdjvSbdACCucD+MFDJaVbSaP1WJcGELt/bzaT1lu6DxUwN2ywm+IYGxgOqdYonxvBQKV7pTe7njJYdVdjFApAAJlns/noK2XLQIMEecyaiyqW2SA8MWg6UwgF5IHSDykMAskOA2Kvr7xVsU+MX3RBNr+OhH05OTAjYZZ2Xv5ayNp9Z/XoyhyZcTMAwOf+KT6a61IU68dKXeHY4idqwNNpTbKA7a9jKMiew0lsLPPc1JnCiByR513YH2nG/o7TH38IzwfS2SmroMHgr5a6LGv2VfiDVqhKWQDaj+Y4G5P/cSm8qer4OLX7L325iv+/pjmmcZPon7fM8MBnaKAIm7GNIJ3UOMIPyKBRIwxgBXtfz9gwhlLSjk9J0vsI+FSdjMkTYe3wJgTfoLFrh4ky32yW5JyeAh4HK+1PEMTbnj/rrtYrZktuiPYcJRw9IjwRyUbeBzRgXWMd947NbPOV/nS5gb3fR3wJ3GOhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yO3Zjs4lwDoT+/YVHuD8u5PJ8KYpSL3/2ewqzf1S2UO0Fg06xf7UfXFN+A?=
 =?iso-8859-1?Q?SsmWQjR50iJqDwzZYAxuhO+kFVUOlx6MNmnPs4QxQ1w7+168OuHQQ3S00o?=
 =?iso-8859-1?Q?XsG5qE1Fk9SAdAEXdC26ZPaVxGs9sE6UnoGTMckiEiHVkqcePpd42OXhUp?=
 =?iso-8859-1?Q?AO0d1fcN9TWFD/9YQVin/SklNzpphRNqytgKZf7cbjnTGenvglJNnUvrRA?=
 =?iso-8859-1?Q?rfU9sdJc6ennDytWYlUzuyr2X2bIl00pfyW8RGp4bMwcCFm/OhFdfJL7x9?=
 =?iso-8859-1?Q?Ie2Yd10jePtRu7rL8F2oTftR8Ekl9C+pd/139Q8P4a7x0s3wTZq3XRWrXM?=
 =?iso-8859-1?Q?xJkHhLnfm+2TUY/YEPIcmX6sUbzC5ds9yOiq4GC+mUQ5ARoAU/t5ixG+c2?=
 =?iso-8859-1?Q?WAxRdWpGXCZ/xyc5sZ6NngfAVbPxEZA1zEyvxMZ+wlZUgTP6wG2aV19reC?=
 =?iso-8859-1?Q?8PAUk0RaopNVDkM4vzriTAZNPDtEKwvGthu9tKwujQuA3rSQU7rGUokQxk?=
 =?iso-8859-1?Q?/pTLExnPdpr8OSCoWrm+7IOPgwAYg3t0bQMNLrNL+mOpjcxHJsv24bvirj?=
 =?iso-8859-1?Q?xP2nBsfxBBxOESOeglh++O7wxhdj4mfdGiUoNDRdIaFZQ9hbyo2U9tUe4a?=
 =?iso-8859-1?Q?7Tw6Ui1zl2kfU4ZyE/oqfpWvA4NiJU9K6DwghUdyaI25nNeongRw9c0pEs?=
 =?iso-8859-1?Q?HL4+CSW48wj9hyYkSlc/4CwXx6g33WqWMjyWBpQmcVFrqc31XHOyII2a9E?=
 =?iso-8859-1?Q?q8oOrl8lcmv2miiQXaluAPQONA2NrFz/lo5LuorRtAAUBv6iZk/pm8jNob?=
 =?iso-8859-1?Q?gKxg/6nTOQYWQofcivSO9YnYiQm9Yq8dVFNgJYq9wtr1YRIAmTDNLrd6Id?=
 =?iso-8859-1?Q?lbeDWL1h9pxJO5NxAqdrz/Ptfh80hMacJSDxDfjBWL2HM/MmdO9HSml6lx?=
 =?iso-8859-1?Q?2bHZzi4SyLZQjxcji9EPdH023dlzS47Ig021Du5QjeWTC9rPdLsEbfCM3f?=
 =?iso-8859-1?Q?B5dhoGN8ygUmiLmY4RyrN3dcpg8HOnA0EwY5+5HtlP5nd1ikX6Qg2Yl6tY?=
 =?iso-8859-1?Q?H6N1FlS/rZFQvOvkshkcwpsOZk2v2zyPRg9XXWPF3TERmORz7PW0nil2Uc?=
 =?iso-8859-1?Q?6EcUbyf3P/g24frLXrkE+V9tqE6EYvHUzamIv58TabfBlhXks3RJL732ia?=
 =?iso-8859-1?Q?28VQGEt2lh2PrE0G54Jej14wqLltL4R8q25CYF/CtoqV/jcW/utVBmSdnY?=
 =?iso-8859-1?Q?68lo5GyHNxx0MZlvpsITjrEpsixrWBccRFu+V/RgLmo6w6YBaeuL/hpaCp?=
 =?iso-8859-1?Q?fHABrdMijMe8F5OB6Xc70RsaAwDy+WycdOI9ioB/MG82r1POmyEuGrAlHi?=
 =?iso-8859-1?Q?Q9JAxHwYQ3uYMVG915kL2y6knvj6K82Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03656e14-9bcd-4c74-2e98-08d90a5b4b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:47.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2ef8y7X18qnhGRJ5I7XuesApqkm5wEpVLgmmbo0qjzqLc9LRLONV13MTgeTrHuqGQKNFOFFIke5dvfwQgNIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: Jc6JM2nqxFb3w_c0v2g0UE-pqC-LxxWH
X-Proofpoint-ORIG-GUID: Jc6JM2nqxFb3w_c0v2g0UE-pqC-LxxWH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new vma_lookup() call for abstraction & code readability.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 383df23514b9..aedb642cb4be 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2019,7 +2019,7 @@ static kvm_pfn_t hva_to_pfn(unsigned long addr, bool =
atomic, bool *async,
 	}
=20
 retry:
-	vma =3D find_vma_intersection(current->mm, addr, addr + 1);
+	vma =3D vma_lookup(current->mm, addr);
=20
 	if (vma =3D=3D NULL)
 		pfn =3D KVM_PFN_ERR_FAULT;
--=20
2.30.2
