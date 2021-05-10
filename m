Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E23794DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhEJRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51660 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhEJRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsAJu073906;
        Mon, 10 May 2021 16:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0Oyly/paMPcX27WMbzcOngmLoSxrl7QAR0W0dQKYkmU=;
 b=qfg+yPI12dxRlxBU1Gk2DdKzKaYKrVkBvx3akvJErBbeLUqMytZAMh7jFMRQdytnN3eo
 xT755r9nOh+FfXLjJC7WZWMdzqYuJS4qcdgWO6bkUqUFM8JkMFOZpbuho7lGVMWQ+cch
 1vTMOiFIkf9r1Bj4n1UsT+NDKZUD594dNodgo3nUOQ8KVckd+XTf58n+GLDzl7pFFEkS
 YLWQ6qpZ4Bl40yN/kVvgRV4Hl6CYoAaFhc21RyN1XaKD4fxKkah+9qdg2KZqRpgToklq
 N6sKuLjqFrxHi6sPLRx1QPlctYiySlAB3cDN+Fr2QCpsfqG4FUNoDHtqlLjhVla9hsmw Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38e285b77u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtx3U001777;
        Mon, 10 May 2021 16:59:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dskqwm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEJGTewpz7LNbtvCHXiEu7cBgtWMYcDHp1eqYznjbW27e5++TZbGH8hNoV1rc8JOiQxvNdF7T81iD9ZNp7zXPVfznEhg5P2VmmxjuTMi6P9uuCuQ6kzlbelpq6z6xfK3ew8LokLmoDr/4Mvjw/xW4hiBNfMHwg1DHrlLRw0qgJpqxW6nafcKP4wKzQ/KxdTQ/5NvvftYI6BKGtPPxZFc3j6y8YQUKXZZHqsehXi82dGjcan2mR09gv0DrNwKvaHjdMW/QECazjJ9OT1RyB3buS23HXQbnx7VI07a1p/dC9wmLMQC5cU6Ma50vQ+0PMsAGJxL9Q0QsCkBFpXpetroAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Oyly/paMPcX27WMbzcOngmLoSxrl7QAR0W0dQKYkmU=;
 b=FwKxbs7DNkluG51TXbrwgnjKtl3t0of86R/ndqCemlhDhcO1oc28G9JDe6sw48lCQpRRxFFXG1VaZxo3fvxyZUku7gv/BBvXw3LUq0fTa06efM7wH5wLPmbi1nEcoMIHxfd9tzCqVe8GosDiZhI/zoOnCTLZ1u1KDRjOfAoz3Q/IY7nxzNEF7/hDaGseXakqlXgGVGr6JvzyFNm74DyfHDpeEbL/sOfvKW1aNn4GTSfd7XhoQS064iNhJmykYQNHllJRXIaa6WdqYJsTO18jtgGRTirQ1rQ+RnmhVx/iTb1HZzPQLaJBDnaS7Htw074TFjVCDZLe88V6ymIEl7nTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Oyly/paMPcX27WMbzcOngmLoSxrl7QAR0W0dQKYkmU=;
 b=n0dPPhZdKf4ukU4sRaB96Bkq5fPkv1jWEjTL7x9R3+0S14EC24y7ORTLMJfXj0kXM4mVA44CzlZ8YQ4p6WIQnihqPKY2UWGNn9q+JUv/bX8sDbcaCXEND9dE+YLtx4Kj0lIXhpi90R3lVdRgtTMXJ3i7FwsiA1qifXmrlA+OZRo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:58:58 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:58 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 19/22] mm/migrate: Use vma_lookup() in do_pages_stat_array()
Thread-Topic: [PATCH 19/22] mm/migrate: Use vma_lookup() in
 do_pages_stat_array()
Thread-Index: AQHXRb3E7jBeLNiltUu5hyFb8wN1AA==
Date:   Mon, 10 May 2021 16:58:58 +0000
Message-ID: <20210510165839.2692974-20-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 8437e423-e7eb-4975-daf5-08d913d4e739
x-ms-traffictypediagnostic: MWHPR10MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB143764F0E83BF1057E6F943FFD549@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dTTXQZdv1NLFFrCxmM4FxkeNNR8tz3RJaCA41MeHebu0TU31VOS93CGwQKMbrPITlFzDOKtwsNMHElsJYQx+UTjMx8/e3K1zHJi7Dtoiakwf09z+pUibNzo+6iFUk0BI0At54TnJzOwb1H/6HYLjQJZrYp1PwSi2cb579WDSC6IsmTUpQKahF/qcTEELC6dhS+2JtqBrefX16PODW4xcuMqjBSfiFqWFgWdmi0vTrbrgM5KookPfJsaJxQ6iR77Wy5eHXdnnRXva2EirzxysknpPykFZwa7FRn9iA/wJrkOX5l6s09dBoNfCEhNBRYHFBC97DTbGyPTB0H+Usrxe5817Ozsn/181RHDkFKrM99A4cbp4ix3I7/mf8adfGmtEXvMCmz3q9iheiaITzSeCQo2Sd/uPFKIqvSa4TYCwEujGF4SDHgW2VXDcMu+XITAu22r3jT2kUEGohO6+rukGDTw+Vh9OG8uS+HJ9OAmic/SsFf3eo45qAhxbP6Q6jQSenwEXwvJ5uUbNE/CQWNk1XjiNGtZlWGpLI+mUVrfiw9SCUsjXtMZsLOS6fCEQkvCGd3VOdMStmfG6gulETb24x7ukiL/pusOlrQ7jgWbb+4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(64756008)(66446008)(8676002)(44832011)(1076003)(6486002)(122000001)(66556008)(66476007)(8936002)(110136005)(26005)(83380400001)(54906003)(71200400001)(316002)(6506007)(86362001)(5660300002)(38100700002)(4744005)(76116006)(91956017)(478600001)(107886003)(6512007)(66946007)(2616005)(7416002)(36756003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?0vzCIZ76qs8UG2OMPZuIkoft8LLwbVjNcJ7wSbozko4WS1M9KVZJFt+rRp?=
 =?iso-8859-1?Q?nTLTSeWcN1gvTSuI4jDALYFnYrJ9OSEP5d3nrrVqV396Z3b5jaJwn/gGSY?=
 =?iso-8859-1?Q?O1l8+eGbDaOFXk8SqO7madyqelSV4U3DyOb1uTi0m1ALLQJxK3ZXBY+SbE?=
 =?iso-8859-1?Q?ExJCNIrVlm/YBEVO8NtYiq0kmSnMxfdNm25Pdxd/L/DNCD8uathBVhrSWG?=
 =?iso-8859-1?Q?gcSyBU66G9SXuPAxW/zy4DTqJ8X2ckZZCPAdpkZo/bg8gnBKht9tOl7uSo?=
 =?iso-8859-1?Q?n6ETCOJmEJgNlmBVotjMk0ZJDJtE9t/khA3o5/LtYl78IldSlZ2JdY5z1p?=
 =?iso-8859-1?Q?jZWabDsQ6il8uslbHulnwDHGo9VsR/5msM4tiKuGiD0ZWL6SoOmYPPaG5D?=
 =?iso-8859-1?Q?3AMhHWAQpc0jwWJ/72rPvGE0b6gUJ02tn0RnMyY1Jui+p7RNDf095/P88w?=
 =?iso-8859-1?Q?+h7DvLNatSEvnY8/GrOuGZqlDznuSDPu+Lp5IdvoAmpWjFoZF7AGsTCoH5?=
 =?iso-8859-1?Q?oxsRMbdPbRGT19vaBN8u2MFeG6SJH3oE5AnylnpkDA1xRRmh2qH6gk737Q?=
 =?iso-8859-1?Q?7ZW9JO1gR2vqcl3lkkSQjeyG952MeNwcFLukC5dcwmYB880z/yjw6CA9oL?=
 =?iso-8859-1?Q?XXh+xymjgjVQNql9Tav0q3oLWQnWV+O0dQPk34+mMMotnJY0pcht135fJX?=
 =?iso-8859-1?Q?jDDTjgfc4jLQX/DwV/Y16sarWrI6dsR91H28NykrXfInxqYo/yfrvSKxDL?=
 =?iso-8859-1?Q?uVWB3FJE/x4yQo7cNTiAh8EhWrHkziZWdn3yruUIXtHBp6zqO+0dZz/sNV?=
 =?iso-8859-1?Q?naRER0AvZFedbL2B7ogltZZEbCOSmdN6fbWPoI5xqy9WrT5inq7jMAlV5/?=
 =?iso-8859-1?Q?FW3OJDTbQ1QMlkjcm87ekEW5+ovW5ckaFCvyMhx297oB465pEbTYOf27MC?=
 =?iso-8859-1?Q?Y8vAd4ZrMbzlk7z4UeltuXTVK++R02G43fmSHMrTnB3Iun7LaPOplGcQ2b?=
 =?iso-8859-1?Q?5SlXk1+oGfu6cle+1TloDlHWqU/fcuzlFn39W0nNozJMTutr63GMm22R6W?=
 =?iso-8859-1?Q?SuI+VdIgK3k0AdK1venDHXQsJxNP837sBPOYLPYKNH1gPxRw/K09TqVRPG?=
 =?iso-8859-1?Q?mnuqtF6CQHXz99e0NpOZKY8+fXDC3YBWQPkpKBfQfHZt0g+/qmIOuM/m6E?=
 =?iso-8859-1?Q?9wuP9ZdM75ZXaKGfleVGIvMQxhLNbqDG/08G+/UWvpxZKuxn9idvtkzzZn?=
 =?iso-8859-1?Q?tHwpzqpAPjkP5PIKhuhN8su7iqOzBV0MIu7NQ/WaqDJTILr8DBJgL97YSn?=
 =?iso-8859-1?Q?d2JTGKEeB96nnI5F7iiL4fQaJAqldYXdeHboLhv3g3yif5lfEzGSJtS4Dd?=
 =?iso-8859-1?Q?35hzF+6BbO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8437e423-e7eb-4975-daf5-08d913d4e739
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:58.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MN5OfBr1NIzqWNw+mZ0/+NTGvnbrSBPinJtEsO9S8YrGVFZM4X3HXzWb2MN2MVNk/PJHMGmfFtCJIwz2IEPefg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: mTJOjpexdUSX4q1BYPisRqDybHRwl4e2
X-Proofpoint-ORIG-GUID: mTJOjpexdUSX4q1BYPisRqDybHRwl4e2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..611781c0f9b5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1833,8 +1833,8 @@ static void do_pages_stat_array(struct mm_struct *mm,=
 unsigned long nr_pages,
 		struct page *page;
 		int err =3D -EFAULT;
=20
-		vma =3D find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start)
+		vma =3D vma_lookup(mm, addr);
+		if (!vma)
 			goto set_status;
=20
 		/* FOLL_DUMP to ignore special (like zero) pages */
--=20
2.30.2
