Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3836DBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbhD1PhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31276 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236938AbhD1Pgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMebo009359;
        Wed, 28 Apr 2021 15:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DCAf/GyZZi+GK96LRPX9x5Mbs3fyqGKo7wI978+vC6Y=;
 b=ydbE9X++jyhPl6Jl0t24ItwJZ4qQneXpCgqyYoNxCafnXalaVeE9CptCGRwP6xIueiAL
 HShdpGMMPTjmD5zuBsvnq4JXpeyVkoQXusdLs90wCM30pads+5FLGeAHXUAYQTmX8W24
 seJK03Nvb0ELhMolvrZODsSNw1Xc4Wn3nfJIM1ESsEs55bJBXwwNbxbUiABQqvDYsv3W
 0aD0Dm3KHTNap8h5TBMKHkjG9Pa3wsPHh58wU2k9h48dD8H39fWV5TXOm/k4uzVLAyan
 +TZYSD1v6vVXSqC7n5f/D3HcUr8c7M5M0ISQQYE7x/llbc6TifV5KsvDOzWiXIWDcPFR mQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:48 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAO003673;
        Wed, 28 Apr 2021 15:35:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOTGtbSlHzJPJB6iyJrfTFmFpqOD97W201iraX4J7NLE8Exs6YP+e7sW/VkyrLv+gcL7Pr2D1y5dODkM5gQJQaA16rK8+dgGGNnfBu8i90TrbWO5yALm8yBX8iGhBgfZqnhIvPFqAQk4ou7reGIx1l0N1V7TFgyCX0jAC9rG7+9uvaLBxAkO4U0pXmblDNeNoUk7bhe300kEAPWVWKc92hghcQ7YPE8E4xxHieYQUatkRUNckmor0Q6Td0J6EFNfEzdoHo0KGeHoNKa4S0dScJKW17UVO7KDk92SZ+9gEfnDku3SqD0OYwHeuUE/m7F8Q51XxI0H++HabcW91gcWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCAf/GyZZi+GK96LRPX9x5Mbs3fyqGKo7wI978+vC6Y=;
 b=FJumKgi9lqq+oB7gv2U6BEpvPn8GyjkSJooxG+LcBqxTkdPlAj0ceOrzDJj9mynz6SJvvIcJbYOxiAkbK1p8jibSoQknGNq+HQ2RoKkW5a3ZdBB/6oNpybj5GLP/AmKIWoAwPeTl/GipjT5ZbiPAgEdgGUhF8T4km99mOcg/92+IFEfAVsHokcPnQg7Xz9tD64e/AcRKU6OlgVq3WmeRMJgSvXwT+/XSqGHQcQV6Evu1CwIH8mMVLUZqMsaez7J6PKAxL+4bbY7JlPigFkL7ZKG9yPDyYG6sTa3/l/idgf03XDirmeA9heIIw+E+xbd59dfU0mByWjk+PNal/KyGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCAf/GyZZi+GK96LRPX9x5Mbs3fyqGKo7wI978+vC6Y=;
 b=SYdcrTLSoeSCICG8DIaGh+S3hbC0aQtqh0E7noidU+C4NVtZ3EwS5xK32l8khmRr8OJoZMty5NE7II02sOFVxFyLIGiZ15wwGLWVIA1YxwjkoW6yidRkRKfW0Nlb25xCGQqmaqlzS/lSzmHkBdTSvk5pWl9WOhxZwKU4hHwWR/Y=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:43 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:43 +0000
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
Subject: [PATCH 01/94] mm: Add vma_lookup()
Thread-Topic: [PATCH 01/94] mm: Add vma_lookup()
Thread-Index: AQHXPEQmA9/hNjlhF0O1j8k1xuPy8g==
Date:   Wed, 28 Apr 2021 15:35:43 +0000
Message-ID: <20210428153542.2814175-2-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 77deb43e-1aa3-44d8-6474-08d90a5b4962
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44974E5B28C3F7FFD52ACF8FFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0UNRv0EW8x7wsJ89RGMsfTJldrPaAURyu2wxuYziQnVvsjmRvidQV/GAXOOdXqWvhzT0qEKVJPznTTEqg4/9z0/4eKVWS+UPKjyBWttUkLfINs6AAr5brkcYHuqpeIaJwi6Fff7mtdYaQV9pNOPt9HuPnI43YVcCzRpWVMTtl53jGNTvt6Iw29wTHqs0A7ZY7swdqG76m9gLHOmG5K4Y3ILNOM9tZCN67NfNsou1VSQNkTW7NjuSpMHE4zROAYcuXV20NXyxKhiDBIt7naUSmR6Acvh34DAgBeGKMD+NNgQEoKPFMaDLbZvuFDWMlm5jO/pWLd0nLAizkO8/h5rV/rjVutUr5r1jlZYpM6DcZQVlLHlvTgJkR9d1R0Rb9f1R6jYPbywC+v4UofQEBuriMDfr9CWa6RDozDsiW5EtYMCGLr+5HAjtnwJm1dESZH0njZZri3lXiPDwNz+vVE05tKEYfl4GP94DppXIFlSLxyuMlWqTNl6XVyLWU0QZSSkuh/N8RGVEN33IwJJKLO0dsRE3wDNFSYGlKL/HzOL4MTs8mnEXjhe7hjwbO6wlVqdJLvOBRwWYPSklERi/ePHpRe2Zrir+5vseKKjGqAcxego=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?G+dOmR2d2LVMmin/gCMCqlwDuRuW1bePauHPDUUrVFiwdpKVw2ROFvCSys?=
 =?iso-8859-1?Q?8Us+Yx3YtNpY5VQMcWb0nY6WvKZQNugPIGHeD5nrPJDifOuyovun9WgSlK?=
 =?iso-8859-1?Q?hV3lpP3A/BOGuhbcuAyvYU0XBNDdEvv388GZTOXVpZqXKyr/5OI9Ly45w4?=
 =?iso-8859-1?Q?JuHn0I5dtn1kmpmT9xJdlYS69M+do/9AgHN0PnNMebAcYfoZ89AN/xUag4?=
 =?iso-8859-1?Q?0BIG6nr95iIFZVT2m9SxjN/ZL05rFxWCwB7kzWdGUGiPDSa2MflkcCVz2P?=
 =?iso-8859-1?Q?78xg6GF8gF5cYjgkR/jSoMGW9wJBKVrTkxdYwVsM0/913NzRNsHdNyoP3Y?=
 =?iso-8859-1?Q?y7efB0UvA47CQjF0veL5SJgE4MesvujPlHcgAT+PwazhhEHOCIetaQsM0H?=
 =?iso-8859-1?Q?JQH+gfrE5c1jbrCMz+nABgcer33YaIH9ak4U70YtFRIOKD+kpmTCLPgM+A?=
 =?iso-8859-1?Q?mg0p6xU0GRXu1glEKrPy7hFlPQXEdBqwvi4zjOTop2Ng6pizlvqQHZJ+EI?=
 =?iso-8859-1?Q?NlSKo0MFuohIwp9U2YhJLJBMQRKX4wC9H5gMkqVarveSx0L5BKccUiY2WE?=
 =?iso-8859-1?Q?XzOGPIYrQUbSdgSFfgN6EalGGcqaomOYsE3Np6RZCL0dUEsnlRMZKPsygp?=
 =?iso-8859-1?Q?9Nlgjoi08GwNaw7cL4px41dgPcY8f7Wr6IawYYHsJFHVlR9NgP71lQEIZe?=
 =?iso-8859-1?Q?qMcj2xxgtZE4ylQjqjbjhFXDa5ErjwQR/k84OWSwUu+AHM0LMBXMFGk7HD?=
 =?iso-8859-1?Q?8Ca9tY2BgsSX8sMryx8KuYVY6r9hBEIi/glSwml/sV3YkLICvIzcRRIH/p?=
 =?iso-8859-1?Q?ENw3RS7v0t2x+O6kYMiU4Pz3d3z74RHFMj8Mc2CSphJemi9r2mf3Y8AGwN?=
 =?iso-8859-1?Q?gG7vzBn1KCRObEA6iXJrVQVI76sprj7SkQjUuPVe6J/i8929Ujxc+C90xT?=
 =?iso-8859-1?Q?IxfxO3aM/hGaK2iveifW7jLhdcm421se8nMmiS5UZMLXZeULLmbJDPd38d?=
 =?iso-8859-1?Q?Ht6d5tO8XAqbb4bcYpWYUhd3HwEUUkyKTw1ok6EsTHVegekZob/TF9RXeL?=
 =?iso-8859-1?Q?iB0LnFrGug0/d94eCB5jH7SpksLfryDLB4u5E+ed1gZOABuekC9A+zHmef?=
 =?iso-8859-1?Q?Allo2jrc6ZYNupNxVrccONET+45+x9ac/QHXVe9rtmuvwEmrFYGnzKxOli?=
 =?iso-8859-1?Q?7aeV0aEk9768BYb6QHT0/E9TiQCtrqEgCGCdV6Or3Kebf7y4gZg7X84BVh?=
 =?iso-8859-1?Q?mTxPy228hn6sju+bkD/XtAIIV51xfknAPEVTSM4/OzgVpEuD6s+HUoYxPT?=
 =?iso-8859-1?Q?ngU+xQWPeNDy/3dgN8x7H9/Z08jJbi4s1LcB3yjF5EoC5eIFoMKD2mFf4+?=
 =?iso-8859-1?Q?ilF6nPAMZlKuqQdaBTQS3qCNsELzdCYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77deb43e-1aa3-44d8-6474-08d90a5b4962
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:43.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS/lywM6MRuPZKxpYh3bjQTIQ3V89fjf47ZtEqfV9K7Bc9gzVLVud8n1dzqoR1Ty5Su6gyw8kmsdm7yM5ACR3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 60_PYd-HbMP8oXyoBGCSla4Gu4uYFK63
X-Proofpoint-GUID: 60_PYd-HbMP8oXyoBGCSla4Gu4uYFK63
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many places in the kernel use find_vma() to get a vma and then check the
start address of the vma to ensure the next vma was not returned.

Other places use the find_vma_intersection() call with add, addr + 1 as
the range; looking for just the vma at a specific address.

The third use of find_vma() is by developers who do not know that the
function starts searching at the provided address upwards for the next
vma.  This results in a bug that is often overlooked for a long time.

Adding the new vma_lookup() function will allow for cleaner code by
removing the find_vma() calls which check limits, making
find_vma_intersection() calls of a single address to be shorter, and
potentially reduce the incorrect uses of find_vma().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25b9041f9925..7f7dff6ad884 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2689,6 +2689,19 @@ static inline struct vm_area_struct * find_vma_inter=
section(struct mm_struct * m
 	return vma;
 }
=20
+/**
+ * vma_lookup() - Find a VMA at a specific address
+ * @mm: The process address space.
+ * @addr: The user address.
+ *
+ * Return: The vm_area_struct at the given address, %NULL otherwise.
+ */
+static inline
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
+{
+       return find_vma_intersection(mm, addr, addr + 1);
+}
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start =3D vma->vm_start;
--=20
2.30.2
