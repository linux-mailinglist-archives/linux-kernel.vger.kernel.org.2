Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B73EEF90
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhHQPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6198 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240195AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkIpK018121;
        Tue, 17 Aug 2021 15:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IMzdNn5Qgs+TDhnA/hGVNQWSeJJr7kMvGhlpcIbBKjI=;
 b=MKt8BtUkBBwPt1UQdHXOjdymLuQknRCFtXD1Sxw+Ge9BaKdCUcAsh33sW+b3GRY/PaxG
 FAVACdJ16ipNqb6Wr8V7a+nQM65SPkPYZHHryvEYT9LZkzSG2IGP1ck9Y6o3qfuCTNu5
 tR9PeL0KeJBDuvqhOFoeSX7sMwIdOFsOXUHCR70VgE/nSFaZq5PfJyhVSGxgIrL40pU7
 DlPbY5iMVbUeFdnXiiqUlAabe5stELA/Lt9Yjfn5GA7MLOpxcm99tJuAo3r3y2iaJ2cZ
 3W0JNoHVd60ZODU+FLS8HYYklXW+tdlBdquectf2x+tjc/8ot6Rsv83PkzvA0x3t5gS/ aA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IMzdNn5Qgs+TDhnA/hGVNQWSeJJr7kMvGhlpcIbBKjI=;
 b=muYsgVt3kiKB6iUX26SibSmrVzmW/Koiwq7mdIwLHDjoLhEPolc0rx7DMhH4lkqV6aSX
 2qPFlk1Yy0x6+p6id/4thpyiidLWI8mwTdNkqwRoCZUtLQg9U/EJeutMDG69MY27HFCr
 X+s46Zn3K/ZlFJKiMcD9SIVKIGBcpDY1xVTOTaR9/9kyBAmJQ4eYV/oTR8Wdegb2cbia
 yoHwPaCQksaFSdla4XHMmu+7qIDerML4Uw/nxx3YPB/64ooRfP41SjKmJA/A99lk6n8k
 loQdFZSYN8lo2OgOXaC9Ik/SIs27RHO6OcnND3Ctgq62jT5b0aI8sPdfqrI9cBED/6OJ xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksAh094402;
        Tue, 17 Aug 2021 15:47:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdbk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUnxTmF186VV7kGOplcp5mVaGj34FOGnuI9N11+oJKpDfRlfxS53yGh5JOaVz4LJYgZYz3emCJNTSy9SKJshWnlMGGba9iZF3PnUkvKQ9UXf4WRO6ZtOIsBk873MXwyVs/RXBhkQF3RDaKnE1wNdjyUdDaZPaIGK2lHvOOfALuVFamjCVK10EgXzpxZ7S/yqM6ie/tCfoEPu9yx0TGlpqnsuSor7Hrlejs8PEm3rRcjrzsp3yUx6oigmKXtPF/g3tEJ/tdcyOKkepjEMMe9yESBQCKnMOlT4B6Yb8lDl8Bd969vYxO+H83w5hQ1kkabL3SmKKNSU4f5cBHz3CPITxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMzdNn5Qgs+TDhnA/hGVNQWSeJJr7kMvGhlpcIbBKjI=;
 b=H325TBXhsRJABR9ZidxDhM0O+3VwBXHBikbi3kExIlk2T7bE914sMewvuiicAVT10gEZUhDYsuAZh93EnrPCy9xPj6/8tu+zcYWKrJ2PZvbqQUfHaDYCz9Hg6/c+mxOD3Qoz8kd9BC/hW+ZgOG+Sn3dds5ltmt0IKjyVfjccnZ7No/XgAtO/KKz62ZNcVr3rx1Z5gk3QIvmxrJx1Zi0iF9qRdvCxUIABp9ttc0k1t0OeMdRHlBShLT7zD/VHgpIlblrAxvkBIalYlsY1696qjG0HPOmKGS1EdnTIm709b4h2WzApvrwYQrXd5EYubzXcSNqk+HJliT2FbALEbcYX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMzdNn5Qgs+TDhnA/hGVNQWSeJJr7kMvGhlpcIbBKjI=;
 b=ajTzXV5x11Yyp/9AJvWaMc2GDBdmu0fqifS6D6W0fZy/S1Y47+kxNpsx4JxGoSdK04SGmUaXPjeMiuxlQkqjR0V/ezNdemLnKJhd8gi4xr7KECkz/KVHv3U7wXzAgWwgFJwsLkuFagGZoQTiObCrVSqJpGcR8C72Kk4JT+LjpYg=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:13 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:13 +0000
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
Subject: [PATCH v2 15/61] mm/mmap: Change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v2 15/61] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHXk38lgAa7mqvcx0+PhrxexEkAUg==
Date:   Tue, 17 Aug 2021 15:47:13 +0000
Message-ID: <20210817154651.1570984-16-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9492b644-e91c-4866-1834-08d961964835
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB42369E996B301ED0AAADB2C0FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYuUOZIbtOQvqDPYtaFssKHTygV2EwUHLv1mjUaqp991U3Wi/3f+ClfhWAfc1tdzl+97zIgonHe0v1bDH5Lt/B/vNCzjhGCUpvR+NG8aztH4KwSKLVkEBNCnUCiVsTgywZPCxbMO3ONQ8RxGh5dkatFlytFoAq7yhvvrBJpW6C5jrmtH+omszEqDwVyH+vhQQRasPKa76VuORXzq4C11+zR3uYEHG7n3ko5uxKH/F6LUfXxrIFco2VwEu5QefK/Y5mhK3mGLkfrKnel22DrbXXuZkNtEm8WJcLBast8hj/GMLxCyCq3ltB8+4bpE9LJecFRXL6SLsYw3knAJ2+BNna8Sdw9Z1QKBtO0r2V3o8h337wO3Ylrnd44jR14DaJt4uxehjj8rXh/JzI6qeDrdWQ3kwFNfpPUTWnOBqfNp5kF/EuU/9zlNMwfdkVYs9+x8HFGeasbF66RMumrbmAfv+mF/GvXR1/D4sephrjv/3lyatNeXYi2RCwfns83BU8Xw+/dzHMfpfuagBUCTm79Ek2Jx8K2bU0fsRM28yCicIT8gSJcTB+5s+N0sOEVR/mSQvJWSKRxjfxz6ekdF/wDYTFzazR+SZKlubby3zEG0uMZGd/zoQPpIsKMJEFsCW5XpwZ2vGrrTZKqyEvq1zKqOGoLbF/CQn6kKz6XfQI5Vu5bBioGynZ7/z+jUmSf62gtvAp/OUScgRGVvmj3kdmlnfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(30864003)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J37Y+8SLSwsVwXDfgSJARI0v57H/ofMXgmIosnu26iaMrngBRnyEMv37Nz?=
 =?iso-8859-1?Q?WhHImJSLXbSvfU5ZN5pdgg+87kF9E+lkJqrM8hgBxV9Xwb6Ftv9o8Cc5aZ?=
 =?iso-8859-1?Q?iG3dqfUZA9rOH0Djr6yOE8NQFfDf1/ssAUrxV7QgK2vPYp30JV6siFk2tV?=
 =?iso-8859-1?Q?HS3OVi6W267t9NN47VAhWo+8VnYuwCmZsL/yRdWPAv2JRij/OMUkAf8fvA?=
 =?iso-8859-1?Q?Q56UXmLDO0OWf4ij5rZOD373Y1bq0JdngMZ723GyF+z3poV3i5aoENV6GN?=
 =?iso-8859-1?Q?U9M5UDpMa0+nn2iSDbNBwsXHNClLYfuKzxbH5TByb9AGCu4Q4a4LQ2yFAm?=
 =?iso-8859-1?Q?NGLL+hPPKvaEmmqHHjSUYD7vdgSU+129UGnzGuHeeSwk7MfquEWa2pO5qf?=
 =?iso-8859-1?Q?Jd4kzer5fFzL2ojHcN/GHn1Rq+bmx4Vmh/D8LgKr8PZm7bxpk3ZMVpa2oJ?=
 =?iso-8859-1?Q?Le64Mnn/S5jJE/H6I1TK8fvReNV1RRgezHdzIVbj5u5V1TaQ5LX8K8Hvvs?=
 =?iso-8859-1?Q?kJnID57zRPsl93C1K5UPlfGMpSfBv1mUMRHH8UBaOx//TsSSzbDNi8jg3U?=
 =?iso-8859-1?Q?QAsq23HjJukRd6UAUHVmhvwNaUVj/UAQNCJ965JgqysQMOJZ5ktcCZO2Pz?=
 =?iso-8859-1?Q?geLkFYrMXA1peCr+EuTXs9uzLVR6/NwNWxuue6Dnw5tQorrPz10HpwiQhH?=
 =?iso-8859-1?Q?wMHTXruyreU+9w034134j+0JqgYswT8MCX3ah5KZlNG+bXuH1wFcoQqW6f?=
 =?iso-8859-1?Q?guO4VqJcLprPBwTz0xb6mbw+rrB/VmD+507mdKwIZRfRsodaqO2JmW4Wgv?=
 =?iso-8859-1?Q?ucWFWyU9v75SuhvIS9PCulstikyArDeN5Dk8+anr1RhPFGWE8w6h274EXL?=
 =?iso-8859-1?Q?3Jf/XoKZAT/iC/xaFxZS0/gA2mumivG1F3Fsc3hhYEkYb6IMzA/aXBD3gq?=
 =?iso-8859-1?Q?owaHFc68YbdAto741n636Q7OVVCUp+56dgzqAdB/ov+nRCI2VGv5QDBoGq?=
 =?iso-8859-1?Q?8UHJ/u2LtmDEjzgX+YzoQeYiFPS/I3Wm5hO/jPmpDXIXI5SDnysQrKAxR7?=
 =?iso-8859-1?Q?Lw+9BsCG7rXzL1DqcpMXGGjYdn4dnSScFGAX78+aLkOOZ96RkpNmQ9hXh+?=
 =?iso-8859-1?Q?4JCu1RZBxBnKpGY65vEb9UBZhx7L1xwIarCcJTlHSp0nowsOqlbaSHfvDT?=
 =?iso-8859-1?Q?+Z+6kxCz0/AI4u6L+gP9wbJhQ3pqZz7C7Dp0SbLBaZKBdNYvEw/8UW1VQ6?=
 =?iso-8859-1?Q?KQBRsVpp7t/t6T3YKE62M3zop8o7aVLkbV2rxF4wLpZ42vJIiifrEBe+7b?=
 =?iso-8859-1?Q?II0pegN/jo+j8rPYh4YuuoztxyYCi22X0ALjs7ZRSq6u8lPMulSz8o1FHx?=
 =?iso-8859-1?Q?CvIQWwo7Wb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9492b644-e91c-4866-1834-08d961964835
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:13.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hniv53z8pLgopkd8eu0AyqQBRmTpLIh3LTb+X9Xwv8IHGprpgBVPPkYPUjvIOW3P9F640MyS7TCXFUmDX6SylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: Qo7LYyOYv0iGWbvO-c2vvkuUHu37fNys
X-Proofpoint-GUID: Qo7LYyOYv0iGWbvO-c2vvkuUHu37fNys
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to
split or coalesce.  This avoids unnecessary allocations/frees of maple
tree nodes and VMAs.

Use the advanced API for the maple tree to avoid unnecessary walks of
the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 278 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 224 insertions(+), 54 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 04b9dec91bd2..3d88fc87c289 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -190,17 +190,22 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -240,37 +245,60 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
=20
-	/*
-	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
-	 */
-	if (brk <=3D mm->brk) {
+	mas_set(&mas, newbrk);
+	mas_lock(&mas);
+	brkvma =3D mas_walk(&mas);
+	mas_unlock(&mas);
+	if (brkvma) { // munmap necessary, there is something at newbrk.
+		/*
+		 * Always allow shrinking brk.
+		 * do_brk_munmap() may downgrade mmap_lock to read.
+		 */
 		int ret;
=20
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; // mapping intersects with an existing non-brk vma.
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must to be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
-	}
+			goto success;
+		} else if (!ret)
+			goto success;
=20
+		mm->brk =3D origbrk;
+		goto out;
+	}
+	/* Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area */
+	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	mas_lock(&mas);
+	brkvma =3D mas_prev(&mas, mm->start_brk);
+	mas_unlock(&mas);
+	if (brkvma) {
+		if(brkvma->vm_start >=3D oldbrk)
+			goto out; // Trying to map over another vma.
+
+		if (brkvma->vm_end <=3D min_brk) {
+			brkvma =3D NULL;
+			mas_reset(&mas);
+		}
+	}
+
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, &brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -372,16 +400,16 @@ static void validate_mm(struct mm_struct *mm)
 	validate_mm_mt(mm);
=20
 	while (vma) {
+#ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
-
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
 		}
-
+#endif
 		highest_address =3D vm_end_gap(vma);
 		vma =3D vma->vm_next;
 		i++;
@@ -2034,6 +2062,7 @@ EXPORT_SYMBOL(get_unmapped_area);
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2041,7 +2070,9 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, -1);
+	rcu_read_unlock();
 	if (vma)
 		vmacache_update(addr, vma);
=20
@@ -2526,7 +2557,6 @@ unlock_range(struct vm_area_struct *start, unsigned l=
ong limit)
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
 		}
-
 		tmp =3D tmp->vm_next;
 	}
 }
@@ -2759,16 +2789,105 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * bkr_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 0 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
+ */
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); // cause a re-walk for the first overlap.
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
+
+	// Change the oldbrk of vma to the newbrk of the munmap area
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_end =3D newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages =3D vma_pages(&unmap);
+	if (unmap.vm_flags & VM_LOCKED) {
+		mm->locked_vm -=3D unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
+	if (unmap.vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end =3D oldbrk;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
+	struct vm_area_struct *prev =3D NULL, *vma;
 	int error;
 	unsigned long mapped_addr;
 	validate_mm_mt(mm);
@@ -2786,11 +2905,7 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len,
 	if (error)
 		return error;
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
-
-	/* Check against address space limits *after* clearing old maps... */
+	/* Check against address space limits by the changed size */
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2800,28 +2915,65 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
+	mas->last =3D addr + len - 1;
+	if (*brkvma) {
+		vma =3D *brkvma;
+		/* Expand the existing vma if possible; almost never a singular
+		 * list, so this will almost always fail. */
=20
-	/*
-	 * create a vma struct for an anonymous mapping
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+		if ((!vma->anon_vma ||
+		     list_is_singular(&vma->anon_vma_chain)) &&
+		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
+			mas->index =3D vma->vm_start;
+
+			vma_adjust_trans_huge(vma, addr, addr + len, 0);
+			if (vma->anon_vma) {
+				anon_vma_lock_write(vma->anon_vma);
+				anon_vma_interval_tree_pre_update_vma(vma);
+			}
+			vma->vm_end =3D addr + len;
+			vma->vm_flags |=3D VM_SOFTDIRTY;
+			mas_lock(mas);
+			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+				goto mas_mod_fail;
+
+			mas_unlock(mas);
+			if (vma->anon_vma) {
+				anon_vma_interval_tree_post_update_vma(vma);
+				anon_vma_unlock_write(vma->anon_vma);
+			}
+			khugepaged_enter_vma_merge(vma, flags);
+			goto out;
+		}
+		prev =3D vma;
 	}
+	mas_lock(mas);
+	mas->index =3D addr;
+	mas_walk(mas);
+	mas_unlock(mas);
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	mas_lock(mas);
+	if (vma_mas_store(vma, mas))
+		goto mas_store_fail;
+	mas_unlock(mas);
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	*brkvma =3D vma;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2831,15 +2983,32 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+mas_store_fail:
+	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_mod_fail:
+	mas_unlock(mas);
+	vma->vm_end =3D addr;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
-	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2850,10 +3019,11 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	// This vma left intentionally blank.
+	mas_walk(&mas);
+	ret =3D do_brk_flags(&mas, &vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
-	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
--=20
2.30.2
