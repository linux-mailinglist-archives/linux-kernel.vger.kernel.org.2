Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB336DC32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhD1PoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2594 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240471AbhD1Phy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedF010520;
        Wed, 28 Apr 2021 15:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=D5DTw6iu2PbJrFVh8muv7zqPaZPor82bOKejcKv35s8=;
 b=K9EjFQJZAzfySH9bfQKf8cX+AG/hBVyKi7wyQKxsI2g7qm0/MD/uzGha54n6b8x8VUhF
 JOQq/vn8kg2EivH90Kv8UVqDiTRBD3K9AaiiTAHHtNtz/cMARNBqBiXI1Jw5vHqjOVeU
 P/LzE/W4k6iNplAIACdNpaNDFGy2igRkJzP6c514+7Dw9pyULRCT3CD/6vj+1chrhRSW
 R0bXnq1LC3CrleDRJNM+iDVYBJ0wBxW/xoEtDjmnmpvrRZ/llghQUbmPeloCfY/R8VNt
 uU9xtYuDSnM0CtRJfRjh6pDGPs8NGsZBLtKxsWzuwqY9D2qghGi0li0Cp6H3Bm9m/OAV iA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:48 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAx5018431;
        Wed, 28 Apr 2021 15:36:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikj3zJoYhWnjaeJoCFpKwKkVNzixZ0aTXWF3A72jUO5yquLvJGSU1XQ4MRNA84aHxjkMsIYPMF0QCjGc8EWUOqs1LSayeTJ8t8sHAppNh753PS3S2LUZ8x1V4ea2+eFpTnd3KjHYl8ifHyPvzuHPHO4J7/S5ggEPiRBCJO7FlxDka1nuXKA4B11J03WWocNSp//Hc8S5FGeKnvk+HqxBpwsqnVjmLejhYzFfis4L8MAWTDbsKpLsq1rG7heMsxad2gcB8EV/jLf5yjMQ+ZikGG0B+8PYLs58AZ8BlL8qwXOBiVRnIqyRZiRgCYwXpEmt/j3wrqvhQ1a7CO4RobFk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5DTw6iu2PbJrFVh8muv7zqPaZPor82bOKejcKv35s8=;
 b=hdY/DiTIGIe2uYnUv8qME+2r+Plqnted1GpA85Hbijpb7ocnuZliqaxBUk29baITZeCn2k+JjUS+CPBS+Nv8LekrTAPB+2mYkETpCw2SOoglWdZ1i0rEzZrEwwCsBMAUwCCAZSHQ4qo1kiG4QoePBEnLdjiJORkvIOumIA+a+ckkXlePTfzLr1VkXYjQdSVu0ZVhWfpLASTvmfh1p1bIG5LShy1auQgrYcf9OyYIN1DYUcNW6jKkCP97sjSQx2m1wqKPos2p2+lpF4TmbF+PE39OvZVvOC3BRdNBGQNToG5teYa1d2loAgBwc/ZwwiVTdssqeGMlRtmprBr2P0RYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5DTw6iu2PbJrFVh8muv7zqPaZPor82bOKejcKv35s8=;
 b=DNftrDSZupwuDvYK7J1+zcoCT1d6jaFLH9Aq1Jnh/Aa4ROzP690uajPkmiOZu73HVRjT+bOr71Mkfc42ON34yRsqNW/LqYUrvXNe6E0L2boKwEQISK8ZlXybgJ+ltGuf00lBh5Q2SsO0lP1RKcwF5q0l+BxUjLYmzo3WQmGJ57Y=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:44 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:44 +0000
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
Subject: [PATCH 51/94] mmap: make remove_vma_list() inline
Thread-Topic: [PATCH 51/94] mmap: make remove_vma_list() inline
Thread-Index: AQHXPEQ4KMIG7vdxfUyDO0NgKnBBjQ==
Date:   Wed, 28 Apr 2021 15:36:13 +0000
Message-ID: <20210428153542.2814175-52-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 3cf13ebd-8da6-4f44-f3d4-08d90a5b6dbd
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1743DCB6E99134614C4211DFFD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrApHSkukNSxutMI/zLp9vVAYCScTn0BuRZAy2hj1tFDdOPRo0u8g6zHY/ZWeyML4EKCdzTW9NMROK5trSrpo1bYPBBlJfNGngqSRHbZv3n8+TxMVlZRm+lAXDQKRKRtjB2WnaUX79qZdGNadiX45+jGSXv7ScyxiwpShFNKLTj7hl58uTLc+FJUwhdr5WcN2+ifx06FvKTmlYe+H+7GEqYE8TtXoaJwDdmegKBZqTOBHDHW0w7nIytsI/2bpKBurrwNtIeFroap51kuTu11YEeAjrWo10GnrlzweanJH/dqH07vFh//zZdcqf66lNrqWRDVYlNFrRBRnOupCc0csg/OfcCzxe5eWuw90z43XBEx1+EpTBKcUnHN498rbt0U7OeOS0+tONxg1yCJB+8RrgkQseVanuq95gP8xQGTkVXyhVC43fR9clcT8QLfqgPKbPf21H622GIu73mC1V42snj3P48bE1W/VNvU6YZqLWtA+CiewdowvYd0aXhEtllbzWDn5oRJ+9k+3CwmbpSMFMf/awpEAOKWF0QqHjIPMP9JcrncI+i5s/c5mmbNm/XB/INIYPI0xTyblTZKJ/AYGJhScYfWpsZIDuQZlKOFEi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(4744005)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?oI0BuZpNX4mmRV9tDJOgqhwaEef85XYr3qQftQSySQYX+c0uADKg7tz7Ha?=
 =?iso-8859-1?Q?wl90FSAoEyITDpRnKtjylQtrYMIjaUOHIqufvPmAnvONxxs9oAwT3hBMfs?=
 =?iso-8859-1?Q?BX2VoygJgo+iPnwbCCRHYDOoYZkymKeRVRauB6OLZ4jb+s/3q56+rdMnos?=
 =?iso-8859-1?Q?HKD5SwGRgl9QJpmgH/XzGf/mtctA2jsy99rypkhvEPURh28zSOqev3q559?=
 =?iso-8859-1?Q?D0C6X0uIQu6rFiYErbuVcM+Dh0EsUoff2qDhLWvNVRQUt0PArSfQIORr1H?=
 =?iso-8859-1?Q?iAmOiW5UTcShuK5n6PSlG4MCRKTqvoPRz8oxNQb6l4YiqIZ9V1GUqjAUE9?=
 =?iso-8859-1?Q?Jy5u9BXKvUL2UDQgliSexLNmuoEsvPNyKoadHZJwOjxj8+6eN1tXVw9t7M?=
 =?iso-8859-1?Q?LxG5yJHHfIcGbHOt9HiIcUa8T7Gr7P7T1PVja5IR/ZOwexW67zzlIYs3CJ?=
 =?iso-8859-1?Q?RYnAo209OGeLOMw8I/MeMoX0TY75nq5dDeQZSxOkcuY9jDcxXngWZontmU?=
 =?iso-8859-1?Q?7WZaF8QEJOZH9E1KdMpP7zidOsa2QLeDZDQVh6xwmRThqfLQSZqZfkdOa1?=
 =?iso-8859-1?Q?tuComAm3SAl53RYI1Jff4GGvZvAU5ySVvzjoIxYHSlMytr5VcDB6M0OsUL?=
 =?iso-8859-1?Q?2FM9D4UXTSIfVAWFwz+dwfE5pc+x3OCpxrpBqPez7ADYwPR906Yd5b/+Bs?=
 =?iso-8859-1?Q?gijyMFWy2OhcIInrmJgZjvTJcUGfVvutkTXYdo0iMQMfuuilc9eVT1wp8D?=
 =?iso-8859-1?Q?fFh3n2KmHfvSiCwGgOfiFEhTsT2uMaISV89TtDs124QJkDu1b1ifMCW9sw?=
 =?iso-8859-1?Q?QZ/5Calq7ZncCFML9wEfTCgzuT5vRXKZ9fJFLpeu6vr0QVqD9TYfcAuhhr?=
 =?iso-8859-1?Q?BNrKXUBL87xIloebAkOgkcVgprlH/t7v1bVMAttq0WOC7fIEey3l2PXCze?=
 =?iso-8859-1?Q?e0gxqCLd8Tgk9JdAT3BMLDtZ1T4hSoOSxfWftmAjxPpo5HIGNisHHNbimu?=
 =?iso-8859-1?Q?e7t9aO8hvBqhaSrlAgm3QLHb7WL5OlWIB9Pw7vFL8ATEn/yl79mSOzegBg?=
 =?iso-8859-1?Q?gZjZkK7KZBEhsIIALaHbA1MeIWTKY1D/XM2+BtimUPs+KTnPzqpYFZBBhh?=
 =?iso-8859-1?Q?K3AuljNkMTgq/+zsw74MT6DEbDhX3P7hQjRq+n41CMqoNtjx7A2YP9cFS1?=
 =?iso-8859-1?Q?OSZj6bDYD7s6jRDYOS0TKtZ2u2GaN3CCSDQBo/mlRg+rA7zzwEv5NHPBZI?=
 =?iso-8859-1?Q?U7mE1qwU3XrHXLv5SCDRwGNVMFPu+DQMQw/QP1MLa646x/hConeBNwAEwe?=
 =?iso-8859-1?Q?jMLIvyDZZBKXteiJ38v5GbFXDJTr0rXg62xB9jJE5m9qIE0CRv+YXgGklh?=
 =?iso-8859-1?Q?vuNKwOP93N?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf13ebd-8da6-4f44-f3d4-08d90a5b6dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:13.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pI4eo2wcNindW3+1ZwSfhcMahKPsKUEd7uBpmTV22A7wlZUDcfQmoDuc+iNlB9pCh1nJkE74r9Q4RGQIXjkrmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: 3p2jbd7DgL4FVkUH50Y31jT3q-TAKKQr
X-Proofpoint-ORIG-GUID: 3p2jbd7DgL4FVkUH50Y31jT3q-TAKKQr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3b1a9f6bc39b..a8e4f836b167 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2274,7 +2274,8 @@ EXPORT_SYMBOL_GPL(find_extend_vma);
  *
  * Called with the mm semaphore held.
  */
-static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *v=
ma)
+static inline void remove_vma_list(struct mm_struct *mm,
+				   struct vm_area_struct *vma)
 {
 	unsigned long nr_accounted =3D 0;
=20
--=20
2.30.2
