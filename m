Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A00F36DC3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhD1Pow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58082 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240746AbhD1PjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:39:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKnmK030215;
        Wed, 28 Apr 2021 15:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NTGRVSQHogQxpWak1JpVk16tpJVew30g+qYLojCPjFs=;
 b=E1PVLT6hvuYe3dbgO88EYO3ZzTsGk5r2xmy+a1g7D9BTB8x3/9737GeJ4mTN5NfOj9vz
 FC7TM5K6+PPkrCTj2exKrc/4lstZKFih+pFRQBr53L507evrbY9UAJ36vIYDi/XXPHhU
 8DM+sAOUEzydBXqLRYonMhOnFOtGHfOxUGW1beV290APGk0HHfp9EFIo4vE5NweTyQto
 jV/8FyRBa5/M+W0l7Pgi5UNFpvF6CbeDyeW/PaCKsoERPfL22ADbafuFMxDcDtmfMNpN
 +hMXArVK+uJz32D3xkKcqDZG8cvET2fGiDNSJPBXYh2kIK6ZdI2Ik1NvUFrJQ6ZELeut Kw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh63t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:04 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFc2RO027246;
        Wed, 28 Apr 2021 15:38:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3874d2773f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEmILYoe0NM6aBA5q2zqxKgT8SWerVfxqHD1NtPpXaz2rZnR3DF5xNzGVCsRW+a3xMKBU1vpsGRCQTdSVxZFq5//d8JIncrtoboxauG9oEyINpPY3z3ygV5a7C9rFgmK4Y0XqtSKMiehS2eKB8nigXsi481FBJU3xIcy3fr5hwGzBZukOqQgxWOJ6B4iULRt/vNPO86+Uvq9rArjma4W+qDSzzYaxu+fOfDUIW13jKf/HuDnPxBh7B1w7qK0fPcgqSIhUIIsT8In0IURvhZwTvCo2Tf2x0yTEg/fha4f8mWgtaTmE7uV+RZNAc/o15LEYK3c85snCkXiy0EEHxgqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTGRVSQHogQxpWak1JpVk16tpJVew30g+qYLojCPjFs=;
 b=jk4QxAzSBslVWdishGuvBguRX6MBg8NTSYL8u1svj5bIGRI7FZLM5VHHrKdKo5gC+oTVyb/eUX/TnU/UeWqep4sIGlqtpRLLvyIGqh5aVp8VpjzSK9ycNLeCnVhaMGGebmkIV4aUF3+wzaJwBlBRSTjpgobD0QKg7AQ+DFHHafkn7sOSNx3w4lMJQLEZocrfYdJBWg3E43yqVh/MqpMYURhRxXjGywkjNkd/Sf72haG7+laoEyKBe3Uuu54WLlspMutWKXTrOKpexDyTlwjA9apMGb3K6x6gkaaO3ilIkyvJq6RNkgqXm0igdBjR5bjsej93INhSrNHOdzYl4bJGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTGRVSQHogQxpWak1JpVk16tpJVew30g+qYLojCPjFs=;
 b=NRvV4YaxE7PwZ5iiquWk9+X3PLb4vbmVoimJZFipKMbicL/93PF/BGTaDW6Y0ASNPZrgSHCgUc2xai7i/4OpxS9G3tt8nPe1fDqRjScJWVNQoX29Ak/ElcYohJdbFs8It7Cv+F+RQ7rfXk/LABTLfUV2iny5jHG3FkL/ZuSwoDw=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:38:00 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:38:00 +0000
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
Subject: [PATCH 92/94] mm: Return a bool from anon_vma_interval_tree_verify()
Thread-Topic: [PATCH 92/94] mm: Return a bool from
 anon_vma_interval_tree_verify()
Thread-Index: AQHXPERDF0w7lyOXCEuez/kdxsg2Kg==
Date:   Wed, 28 Apr 2021 15:36:31 +0000
Message-ID: <20210428153542.2814175-93-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 6eda7208-94ad-4a63-fafb-08d90a5b9b03
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB454870F28E994D4BC1AE40FAFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zn/ZTNxub/Bpt25QKgZU4W22NtYcxAAubzEZhjKLgMKH4+FpliPopv8WCOqIc+w9Ysce+Lfc8GEMMQ9dGN+51hVOH8x2lK2e3tulUGGEKNOSYQOqt/1CNtb5cbeF+9cZSm6eXtsOacT+BEhted2c6kOMAKirD9aL9lg16wkEXFaykHk5AjmLpUwWKGG4wpLJLVSKRqrIGIz0c7cpTxeuADH1677oGY8OD81mFWTVZDYlTE4W2yMCbqRwF30V3gj2eRkO0TsrtFRBhRyf8j82N+3Q1gfAfU3dCLdfDnzZ7J/JHkZpw/w0jtnICZ78v9Ihxwq0aVOp2nq+5GuSkgqY+Pr/uGAPqxuY0aQF4Yyafoz5EMksDFKj0lTHWnsl8S3dTdD/rasdzLft1it8kTE9l9D3qoysQYGSVcs7DXu++VnO8HddHu5Acq4+ymFEJR9rdzzD9IFB94eJDxz0rbUgT5PMUE+BMZdKbmCMK0r1l40D8k/kQZp8fq5reppq6BmkH80yfuyWgBkjMOYTTqIvpOH5R2aKTG3fdw/3nTTucSo1BcbUCTqEiQ8MzwXecdf0tHcXF/LEoEH2PD+0bBzErM3R32xVIjVMcbrIsoGgQm0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6666004)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3gKWGpYJeQ9kn3CNcV1csaljC+6hDJT5+kWZKbQo17gEgBDJTi/cByEtth?=
 =?iso-8859-1?Q?/Rz1zOgbMEM0adeN8eBnsR3eZjhOjLv8KlHvL1UdjM0WJ7tpAiStsY3uaQ?=
 =?iso-8859-1?Q?aDc8O4F5ngEGSnUF5rvaRb/4qUHaKzMropqjd8GBKhK3Mum4UNrAavlA7t?=
 =?iso-8859-1?Q?8TYrozAaonKgszPCrtCJ8U7WyGFJ5ehUYQt1Yip6eS1UajSyqcnRp8jicx?=
 =?iso-8859-1?Q?9nWdI8A9K2J48fbApLY4rWJluzOOnqPmAKMyk0Jk9fOac+g1ETWwfjSxfE?=
 =?iso-8859-1?Q?TcDxwk5DKLSOS+Lc24FUwpLl/PTp5qOsgVP5LH+ecxvHCXwXAXz39fOXN+?=
 =?iso-8859-1?Q?WUSBWnAWYluxd+mKo3P75R03+CT4v2RPcPwnGIzMJj0DDSlPvnK+0pL6/k?=
 =?iso-8859-1?Q?Omll39KOizOrNWcloYRQZkESp5cBzANfqbeBNZ6gG/sYNwfm+Nr3UEAv4a?=
 =?iso-8859-1?Q?QLrNDluuYuDacYMDe1QGUy14qusViWfutIBGa/iqrJvnoUvuw9rO0mY/F5?=
 =?iso-8859-1?Q?NPgyQ/dLJ1SUTEEzq58TiUAXQN+XpMhMbF4uwBMH8PDKhqqqChG42w0jo+?=
 =?iso-8859-1?Q?PirszKYI4Q5u6tWs63UAnpsEENFYghrg4MtxfJUEPXqEqICcPZ+TmbUeGc?=
 =?iso-8859-1?Q?ab5Ldf/G8CarHvyv1Ss4TXn/aFdXXmMuiG6wjI9XP6l7+MzKxnbj1LuNfq?=
 =?iso-8859-1?Q?mUQlX2X04CZisPWSHJieej5teM8LNwj2rdkFcBmcJYbi4VPSfGL1qZtAdQ?=
 =?iso-8859-1?Q?Iq8HaHL3rBcI0gnAcjMhVNK3KXLlqUYpSZFad3wNHvz3IL3zxR6IyvsddA?=
 =?iso-8859-1?Q?MVKgBYCYx4m3wzJClqdgMhoDCrefBCDcD5HJMhBVdmXhI87bFY8NQYh/0/?=
 =?iso-8859-1?Q?PkKcv2i6lzG2V9VjsY4fhmvunxceKW/+VthRcLX1wJHc/Nyrg67etCRL+z?=
 =?iso-8859-1?Q?mMG5LkufU+A6fI2gyD5BRyUIagkZ5HO6r1OJCBquOev0DXuYnaHwssTM5I?=
 =?iso-8859-1?Q?w5ZnR8Nzj+83TQvtyKmBEhPgTw6m9h5RYGRMLSqJlIg4K3JmkakQErMtLW?=
 =?iso-8859-1?Q?LNf8+2KrxP+gpWY3vBBvXl7Jm2FIDw90ngbqXZcmUxe3SNFazCw1U+Ds3C?=
 =?iso-8859-1?Q?rnOr2AOK4lC5whn9/44GZhmuPhH/WkQEupwSxw4U+Up4/2BGnsSEGeYc0x?=
 =?iso-8859-1?Q?Bu3dHzlBYkziFtqHodzdorYdAqwHHQfHCQuCgJbFGcBY9B3XNuwmk2pPyV?=
 =?iso-8859-1?Q?Zmd70K9YU4JLxJNvkZtZjTXSnWlThffpWCS4kxueZXA7HAxcVOH9tYyt4A?=
 =?iso-8859-1?Q?hxHIP5KP4LO1Tu/1FE8nnd/ohPUHXfNZqsHZeKefy6LdwxYqmPy9TjhmJU?=
 =?iso-8859-1?Q?U7GfoUHX2f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eda7208-94ad-4a63-fafb-08d90a5b9b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:31.9740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fjn2eWIblQcER8ZbmSIw4P+qZ8WExvxQG3dSsyZt5zCZjGm3rncyGmwEPKeqvOr0lepSCU+yBmR/Kff0MUJd+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: aVq7bm3_SBbW_dWvHptmW501fOLx6GQU
X-Proofpoint-ORIG-GUID: aVq7bm3_SBbW_dWvHptmW501fOLx6GQU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added to allow printing which vma has the issue

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 2 +-
 mm/interval_tree.c | 6 +++---
 mm/mmap.c          | 7 +++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1f1ae32fa9d..6bf5369ad319 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2526,7 +2526,7 @@ anon_vma_interval_tree_iter_first(struct rb_root_cach=
ed *root,
 struct anon_vma_chain *anon_vma_interval_tree_iter_next(
 	struct anon_vma_chain *node, unsigned long start, unsigned long last);
 #ifdef CONFIG_DEBUG_VM_RB
-void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
+bool anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 #endif
=20
 #define anon_vma_interval_tree_foreach(avc, root, start, last)		 \
diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 32e390c42c53..5958e27d4381 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -103,9 +103,9 @@ anon_vma_interval_tree_iter_next(struct anon_vma_chain =
*node,
 }
=20
 #ifdef CONFIG_DEBUG_VM_RB
-void anon_vma_interval_tree_verify(struct anon_vma_chain *node)
+bool anon_vma_interval_tree_verify(struct anon_vma_chain *node)
 {
-	WARN_ON_ONCE(node->cached_vma_start !=3D avc_start_pgoff(node));
-	WARN_ON_ONCE(node->cached_vma_last !=3D avc_last_pgoff(node));
+	return WARN_ON_ONCE(node->cached_vma_start !=3D avc_start_pgoff(node)) ||
+		WARN_ON_ONCE(node->cached_vma_last !=3D avc_last_pgoff(node));
 }
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index c2baf006bcde..ae1ffe726405 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -326,8 +326,10 @@ static void validate_mm(struct mm_struct *mm)
 		struct anon_vma_chain *avc;
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
-			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-				anon_vma_interval_tree_verify(avc);
+			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma) {
+				if (anon_vma_interval_tree_verify(avc))
+					pr_warn("Interval tree issue in %px", vma);
+			}
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
@@ -339,6 +341,7 @@ static void validate_mm(struct mm_struct *mm)
 		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
 		bug =3D 1;
 	}
+
 	VM_BUG_ON_MM(bug, mm);
 }
=20
--=20
2.30.2
