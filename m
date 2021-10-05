Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B66421BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJEBdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63872 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhJEBdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951BZiI010255;
        Tue, 5 Oct 2021 01:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wcX9CWLGniA1x6xIB0OKjUtIkB4Q/X/ewOI3qsqfxvQ=;
 b=thsRJhaEh9bRqOsDGIFIkbxqGZegRa+0vCo5xp+7JNHwhQ+Czmia77Bwf+QQnGyJ+efq
 2N1FOc1f4vyypThaMqjIPVXGF5Ygcb0p2JB+zhjbv9dH6bsxMKXDNofR1+s2WkudJdWz
 4MYNv1z4ai4hMu5vGPrhTeB0KZCRzJuA0KF59X/bhg4+92pMrg9/pV6qmWUltZCppuwl
 gYwWsSCoQtRvHojjpr6ovXBL4oA8+GKW9iMG0xIZtzMhxE8NUl1pPd0vxcsyireQLYXE
 vlXbesCx8cHs6hWQgUfSwD0gXkqt/ME10IL5ebpYvMH3AT83gzjnCqlmOLAFNr7mmKHj tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv35e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Ueb8141761;
        Tue, 5 Oct 2021 01:30:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyV7DhcaoYaVKu9ye9VZM0n6FtweOrcXqhVyUXuKG8CgxTdDNl8sqSZCFLci5GW/BlIPPBcZus5ssbkv9Hj+Ksjcv1NfXw0tIc0QcdMKRoZA0qNC/QY8PMrl2rxm5CvfqWjv0vyABzn8+U5NhbXcNoODBDTz+hmkRVLK+wq+hMqCmbzPHFeQoJjthidwWlXucLbiN97agvHtuckMuL+CLxAjOfJgZ1GkfnpwMJRyqbsD+Msmndsb2PGWPXzi1FdALOtziW4zXbAfuUIlFYAo2qBxyJBrWh+x/K1Wwe5B5fguTWSM5fu7VM5Y66ZcgjlI0+faE/rFHVtZk2GvyMPurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcX9CWLGniA1x6xIB0OKjUtIkB4Q/X/ewOI3qsqfxvQ=;
 b=JqygSjczSQkCbfUfQFUzQWeWJ0NWHYAiBgfeMg6BvS6u5XEWrs4diP1vaR+RfvLALLf4HCdmOHmAyQdGv6PXdrGdFhp/lwn+xlZ5/Nwlp41bnUtNaJtI41eVmIUyCWENL/OlN0n+UdB95uuq8MjppU9CvY32nuN4Fy/v2lLh5yt8OMyki8ow+641F5WvYYwY6FhYqOwadyakT66WW6BLF2PUV6hGM2hM/MqtW9tJTSQhIJeqBReTrqiF4WZR/rmQ4fBFG7kISba+bQc+7GS5tXu5y7m68xXiQKKdsklfvam7fRcOrspGejDBA9drTG6zd1znntLQvhI++ISXSXItMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcX9CWLGniA1x6xIB0OKjUtIkB4Q/X/ewOI3qsqfxvQ=;
 b=j39IC60qsdQTQh6iss534ro5xqRXSTO9mOg0E+HBxJ0GuItOMWPq8fx1WaEJEEax6hQMYk1RfD3QUmk8TEb3o7emGMx9geiyqJ6lP6CLGlY8kLT3fONYfyyYwbVkDF7a3gTusO4rRbYMtbuFpINoLgDP26VX7CTAciiRzwW1Z+c=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:34 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 07/66] mm/mmap: Use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v3 07/66] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHXuYiXeE+EPpF4fEGbc1GCtpLXaA==
Date:   Tue, 5 Oct 2021 01:30:33 +0000
Message-ID: <20211005012959.1110504-8-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1970603-37d8-4435-f55a-08d9879fba5e
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-microsoft-antispam-prvs: <BLAPR10MB52188E8C58188C29A3C5D770FDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/93PmmEcN45c876maifu0HAMVoWCmbEkglRTsgxrXXcjQbNsTTu5I42NvmM4UgMFbW6nX2aFMhcbRvwkeWZUFadtgSaZexLrdT4afEXgKbqc0jebnmN7x0QmuRhybKJ4hW7Hw2iE2XvD5/vQnelqjA+qWUtX2vK5pDWOhAeGEV7uRKyrVSUm2WNWTa6EMHoheKS1/gZAQ19+/Mr39sVBDjFYQEjTmZYv199hdW0xKFgYP4FQlFXTnZharIxAgCiFqDM1gk1DA9yaztc7rB0ad4Fvto7oO8+0a9Mfy8CT0SZRQaQPEzJyjOzzhwJuIDTs30DXCfE5fq7eXbnwmPfJgjyg71uI4lVfm1VAy+tNCFGomxtm046XiQ/sAPkyWr71VsbZO15nl0zayEnpEZ/knE3p8wzmt5kQ+eoaK0m2oVodg9RaCcFilMjDfiqCLcS4r758+o9nQinu4bIJENvb5RtIitHTyzSxk9JR6qBuuGxZdfRh1IADJgqJ5hvy3H37Fds2APBIlCY9XGtqTmDT62AMhtyKv155YhNorML9nI+00W4Ve1EEz25ZhkeyiLnG5/dRPuwJJtFyQSG3lpC1oJON9iVtheEKwU6q3RtU4B5exjCO/i9vnBpXd6RLoVSk/rV3ipGM99uP3bzE6rfb2qg0Fp+JK2X1gr0zhde/8fmlqDczB2RJW0197Mp05kUo+7HXOVcD3t7NQfOyl1bBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(6486002)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(38100700002)(508600001)(8936002)(71200400001)(8676002)(122000001)(316002)(110136005)(76116006)(91956017)(2616005)(44832011)(7416002)(38070700005)(54906003)(4326008)(66556008)(2906002)(64756008)(83380400001)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aGYKotGglfgAoP6/ePpw7vJB5Xx7qck0bvQcePVzi2nid5yKJGHK/KdYx5?=
 =?iso-8859-1?Q?FzSiV1YibpRT/9lrQ/leqsCsHkNfxt5Q3W0I0W7aehiMKP0rD4BKWF45jf?=
 =?iso-8859-1?Q?OLMHkKqJQkY64XLCVq2NpK27yWN4Txi94JOEibAwkHf526E5cLBcspCf3e?=
 =?iso-8859-1?Q?0A5FEtOBgmmbOh9eCyLMlXURFL3UDoswsXs724K5RolX7nHgK4jclT4IZN?=
 =?iso-8859-1?Q?zjA2g5o1OV6W88oIQpG92O/uwcwk7EPSJFpdlvZUP2rrZA4SuJhxrvx+Ax?=
 =?iso-8859-1?Q?TB7aLdh6AWDmRb2bUKoMLduhr5gYlg8fPmgxTtPrkupFF0ydh+PZP1exA/?=
 =?iso-8859-1?Q?w8Bd/m2wIgYjQr2q4yM6DHazuNjfxLcE/q1XR1t9nWa7UVxrpHpBG1dH3i?=
 =?iso-8859-1?Q?ijJ9m7Ugg41dvkZeC5lBzWstmmBPdFsbbWoJshXGch+vxRV0Ew81KSQbke?=
 =?iso-8859-1?Q?SZqX3iFwyORTr2tGh1tPOAyodd5uX8Fp0u3oIhe9UeoC3n/tlKZULWMuLd?=
 =?iso-8859-1?Q?ljJAYjExqHrNYLwcoiATSmnFvfIW8ut/Wv3RS4m6XxMq5IAoOkWg+Qk/Bs?=
 =?iso-8859-1?Q?Z59iZ+ANg4/3/aDqtWfCtk2pRmPGQcPGtHkTTZJ0Mceviud6Fmko5+ug4v?=
 =?iso-8859-1?Q?SYGYWqHjJzFaD4IE//ochSdURl5LDu3HWfatIajpIbfYxT5b3mtemxa5MO?=
 =?iso-8859-1?Q?l9NytBD279CpsTSwod8CAQHNgj5fPD9XEE7ob0Qy04rMd6+wn9quU7+9UC?=
 =?iso-8859-1?Q?sGmSe5yZ2e6cQ3+HUopplhq/Gy1vRwp5uX1jTeM0BeYZ14lzUCcvvA2Cw+?=
 =?iso-8859-1?Q?zkXS0b5C2HgMxOGQWcu3SzApNF0wgA6EWo4J+nLpZ9iXaomaBEcTEn1w2O?=
 =?iso-8859-1?Q?3wtMbJK+O7LZpU5s0xk1ULyUxEFlz+w40KCixn56ZiJ7BK6BA0A90s3lOA?=
 =?iso-8859-1?Q?ZU5eYt/CFOMCeqomkdmWeA7tBinupa2YjCZh4a8ZejKXFL6ifddNMf09us?=
 =?iso-8859-1?Q?53dnYXIhK9yr3NoYs7YKdNXCI2C4DG0ZtMAOA+jNLoWWIFkyYA5xdU1Z7v?=
 =?iso-8859-1?Q?GQabn0jB4cLr6tL8yOzSmnfPJuuWBK+v92IZ+UskjgIpo6p2jwkolGkwWy?=
 =?iso-8859-1?Q?YdvMrbQThUzhvptwEhtOEaRoZuW/sywm668tJMz2VKTisPV0bq3nCu+Thf?=
 =?iso-8859-1?Q?0dTgSo/FSZx/EWX7js3tISZIRCd4JQMpB0ZjKya8aLSW1JjJZYMjftVkWE?=
 =?iso-8859-1?Q?JEunsgFuWXMfVYm/+K+iSzTAh4nGwCAtZubclZarG5gAYxGEgk58BJzn4v?=
 =?iso-8859-1?Q?uRZFQvpX/mQg9QERB/KYKuCjRR5MTQESyvcG61hPpdJqy6jclkiQfMPAVo?=
 =?iso-8859-1?Q?oSUEmeER7k?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1970603-37d8-4435-f55a-08d9879fba5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:33.5616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R+YR4jCDBoE3LpSTBW8XJcaSwZqZK46bfpEA4k0JP6keTxleo9c+AcfqeVTxWq/C7ccrqfPUkIeUGIFUwTrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=917 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: 30cNCaj-WzzYmQN0MOvq8I_OJMnDLpl3
X-Proofpoint-GUID: 30cNCaj-WzzYmQN0MOvq8I_OJMnDLpl3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b9078e6d7d61..fde3497a3c85 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2458,10 +2458,16 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
=20
 	mmap_assert_locked(mm);
@@ -2470,24 +2476,10 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
+
 	return vma;
 }
 EXPORT_SYMBOL(find_vma);
--=20
2.30.2
