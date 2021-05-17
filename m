Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0915E382ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhEQLXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:23:19 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:4657
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236717AbhEQLXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeUFGxC4OBPF6xpefDbwkvtAnykEZ+rSIcQWiTo5/+U6W9+DtjLh6tTfs1kWiMK1wv0mRVl30YlL9gfxQgsVl8txOuXELlONbpkZ6P9HwQaHFPo2n7nlODxgGLa/egoM1nN6R9fe9Q/1DEGN4Yedf7R9R40pD6VRQ7fQhYyS0CxNbNLohKjI4VcBJpw/VhbKpijX/UaWnZJ/7cPSUvcz5VRA6wOAyzqh3z4zydW4Fh1PXOwSqR3NMOLEfwUvMQGcaxdi6Pd/2MX23nc9C8vVbU22Vci2S6jD8/hwQPGaHKdy+ZTeo3spPUcTv5q3pY7r4u4ZfYz8nbBUrb+8Nd1XZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM5Sym2nO2CWtQiqJ9BW5If8ZC+fKi/yN/cPhMRlUGg=;
 b=iPkQsyGL7xzQINX2Lgko+7+Ht0LgCtA8EEAb6H1FBEEZMpkfdFSAsPLUzKC6VnykY6QHMsteGnnaXiwB/9ZHfiwjdmJpsDzZS0sMksfkhNluZsr2RHKr7391QWwEXhnXqVYkAtF8z0psKH9t5+BblUBw7cErAHJoL3Br9bivnnESzY4/ZupmVRBdNdkdKaQKGzshYznx3aOuTAaUlKDLbrlzCy13b+t4fJ6u1D2xqGYzGMpJ5SBIu+D9BWNWVHic3Ri5S/THJvzkEItrOkrJxZaSPLesU35/s3MulT+/fdX66ZFm25cfUnJwDuhQvFgIN5iKMkpWzUksTMRN/RCMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM5Sym2nO2CWtQiqJ9BW5If8ZC+fKi/yN/cPhMRlUGg=;
 b=Xmdr1IpoUS64jL8bH+eho2sXt2wiQMP88nHR7nVFANNGKx7uB8zIkxFMxEBvqDuzKC/TtSgTxaRnVSXuW4oXnC0lkPIzSS1GVm+L3BZ4TSj3LIKkGrFUvq1brKbSc5NlGfmD5/XJlUjhaFz6NmMnZnLW/mC3D+tMRc7N8DXCdKE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:21:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 11:21:54 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH 4/5] mm: rename the global section array to mem_sections
Date:   Mon, 17 May 2021 19:20:43 +0800
Message-Id: <20210517112044.233138-5-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517112044.233138-1-aisheng.dong@nxp.com>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0132.apcprd01.prod.exchangelabs.com (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 11:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c17ff12-8f5a-4548-9388-08d91925f9c6
X-MS-TrafficTypeDiagnostic: AM7PR04MB6776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6776AA68FD0E3705DD775B6E802D9@AM7PR04MB6776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrNYlm82hoExt9ZOqLg8ncYl2sjOy79Q1MzXPzHJvq9Zmf9/vGIf9TlHwFdHG4UjCzX0fEyXYly7JV46pf7gzFwkCNa632wnp5AvyUHuriU6WyuiG5NiUEnLQtwXGeubQLdFrl609nCgoXlTq1vw58H/i4YrUa5XDBLHS1zRIM+JHnqHudLSYZqMWTeVxPxNnzRiIzi/RUEtrcUF3jezmeAjDtMpe5M0P5eIbStiq6HytRyvYB2XybFQkDshUopD+uPtfzGHdyf9mAPZs+KVW/yPE3zoyPMWGy8aBBnxLSMDtPsX3ZsF5ZaWPQE4MuX3DT9OvjKjGetJD2E5o5hYFSZtUX57B8VX2o8cUs0kTRmmI89SatnXcfmdUZkxL/klQOwmYF2jlgn+HKCAV2AAQen5kf0/50l3v2ACPndecIkeXKEp/PhY6LSHH7Z+6HyPahcaGLc/SucWot0wNaZUZNmsOtpvQe5myDHVaLtTW4B8Q7Fh5vw51gmFEZB8S/XM70TMP0vRhnnc7jFcxlOfO5onz57FFPvPypG/2WolBXyi+QBP1M7SJ5zR2sxH1M7l5J2YDO49cYIU+EWhv5Cc7Vruo1beP1Uk9gypUg4x2Gyf7CdhZqW8SEEbV54869kjNKMposec9JfqLDqZWD2UwdslMrvUmWsC/9QPPOAFFgcwdX0+LfS6oqf3/mDaTHju
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(6486002)(52116002)(54906003)(16526019)(66556008)(66476007)(2616005)(956004)(36756003)(8676002)(2906002)(5660300002)(186003)(6916009)(478600001)(8936002)(4326008)(26005)(1076003)(6506007)(83380400001)(38100700002)(38350700002)(66946007)(6512007)(6666004)(316002)(86362001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n/pv+IJ2EQYG1S5QE5r7Jvk+08s/O5DgHq92VHYhn9znQw8BDlNlBCtL6EB/?=
 =?us-ascii?Q?qeD4jf0ofHlFqJXtvgqw1ewqbFTQ+0YQGGygVFbRhUUXXRNjR6Zt6Kwd8+vx?=
 =?us-ascii?Q?0mzMkH5MSCHHjBP7bj/PkMRbE0tMh+kKd3vhODczUiS+1VmFIswN6Vq0PH59?=
 =?us-ascii?Q?HfmBpZth2bY8Ke4c/MW4Ll9EGw1pJ2bEawbxWPDwKz/N8y6OyoZg35PD5nHP?=
 =?us-ascii?Q?O1fDcq7OOgxZARQor35JS4e3XSXZmc7C0UsJtzyhTMH2ljdvKYIdaAmzp5HC?=
 =?us-ascii?Q?xGBREJSaI//F3+T7YspDwMyP8eY7gvbU9iKmZi5BCgheFUp2aqFDGNWske2D?=
 =?us-ascii?Q?HTz9NJTZJqLbAXg+URqS5ds2Zk474o4SwZ4Fv7LpwvXcQhcPXXlZwKxriC00?=
 =?us-ascii?Q?DCV5CIthUyyYZZfz/4Qe6UJHq4bosf1ykeENu4JNjFMbvdFJ2Gohg68R3spd?=
 =?us-ascii?Q?qZVFsi6+y0xdFby/BbSZP1qfR1iJuMpkD57XinTd++tT2YKlGGHszbzxsnSJ?=
 =?us-ascii?Q?8glwZMX4lK9fOGat63bguYbSVmw/sCHTsTmBlR2GTo/Fi0Gqj6F5qOmgd9CR?=
 =?us-ascii?Q?RO5If3/oVdTcfeDEbBYZQZyl8ISMtL+HtWdlgYRBGL9m5nhFeKupSqgAC08H?=
 =?us-ascii?Q?Vlzlm445a1X4/hf35LOSHZ9DSu/w6009Ot8XkHwbePC538D1ouEucSrspddV?=
 =?us-ascii?Q?DnGkcNbzo8ff1hpbq6rC8bPOC+OqVKMCiird498spqwNvO5AJeJwV5U1YwwP?=
 =?us-ascii?Q?y8iblkoq60NWk6E9MVe120Z7JVn3e1XBAPWHHwBVmPx1zbGG6CMj80cZbqdr?=
 =?us-ascii?Q?hsZQuMrGa0tENcHI27n0tN6GtufIuOBPrWykGZZT/7IzhZhrrsKJGS9ThReJ?=
 =?us-ascii?Q?RrigHIHet+5nBOxW0KATHlTsQSWIQZaZtNGrLAt8qjToAs6O1A7Cl3C78d8F?=
 =?us-ascii?Q?00RhhZOXPdRZNxXKMCvyM46S4olbulKEpGNAJLuTMIpo9Jk266zHuBMfYMeV?=
 =?us-ascii?Q?npNFJ9vNUEJnSHAmtoXm5evPWUGEG9Cf0PeNIAKYjJfTGJs3heTpQH4bLBCr?=
 =?us-ascii?Q?DIv9X0uPxHv9hef6rWunK8ptsgvdn0r+TJ9voCJeIoNGTlup5rm7BS8x2Tv3?=
 =?us-ascii?Q?EOij9cBwVXD2ssTW6AvxL2yZF28XJVEBP/2DDddMP3uRR0E59sarC3n5XjDd?=
 =?us-ascii?Q?MthJp+OPBWT3LBzGrnsiOQE6IKvbefWWhVKBU0uigAOHZF+N4LsYMYsffbZi?=
 =?us-ascii?Q?zetyHhzNFYgxrk/fpfuEW49pjvycJmHieHyUJT812eXdY+m01cwEDz4y/d8G?=
 =?us-ascii?Q?RXs6OMJtAjHeP5+IaZ/EwNCX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c17ff12-8f5a-4548-9388-08d91925f9c6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 11:21:54.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJee0HshXdl2vW5Y/IBG3y76h0R/2MUmJc+4ogrP0Efs62TDhyWcM9xVteq75BlWdM4bFTfjyHewypcDw/yJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to distinguish the struct mem_section for a better code
readability and align with kernel doc [1] name below, change the
global mem section name to 'mem_sections' from 'mem_section'.

[1] Documentation/vm/memory-model.rst
"The `mem_section` objects are arranged in a two-dimensional array
called `mem_sections`."

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/linux/mmzone.h | 10 +++++-----
 kernel/crash_core.c    |  4 ++--
 mm/sparse.c            | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fc23e36cb165..b348a06915c5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1297,9 +1297,9 @@ struct mem_section {
 #define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
-extern struct mem_section **mem_section;
+extern struct mem_section **mem_sections;
 #else
-extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
+extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
 #endif
 
 static inline unsigned long *section_to_usemap(struct mem_section *ms)
@@ -1310,12 +1310,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	if (!mem_section)
+	if (!mem_sections)
 		return NULL;
 #endif
-	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
+	if (!mem_sections[SECTION_NR_TO_ROOT(nr)])
 		return NULL;
-	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
+	return &mem_sections[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
 extern unsigned long __section_nr(struct mem_section *ms);
 extern size_t mem_section_usage_size(void);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 29cc15398ee4..fb1180d81b5a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -414,8 +414,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #ifdef CONFIG_SPARSEMEM
-	VMCOREINFO_SYMBOL_ARRAY(mem_section);
-	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
+	VMCOREINFO_SYMBOL_ARRAY(mem_sections);
+	VMCOREINFO_LENGTH(mem_sections, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
 	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
diff --git a/mm/sparse.c b/mm/sparse.c
index df4418c12f04..a96e7e65475f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -24,12 +24,12 @@
  * 1) mem_section	- memory sections, mem_map's for valid memory
  */
 #ifdef CONFIG_SPARSEMEM_EXTREME
-struct mem_section **mem_section;
+struct mem_section **mem_sections;
 #else
-struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
+struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 	____cacheline_internodealigned_in_smp;
 #endif
-EXPORT_SYMBOL(mem_section);
+EXPORT_SYMBOL(mem_sections);
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 /*
@@ -91,14 +91,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
 	 *
 	 * The mem_hotplug_lock resolves the apparent race below.
 	 */
-	if (mem_section[root])
+	if (mem_sections[root])
 		return 0;
 
 	section = sparse_index_alloc(nid);
 	if (!section)
 		return -ENOMEM;
 
-	mem_section[root] = section;
+	mem_sections[root] = section;
 
 	return 0;
 }
@@ -131,7 +131,7 @@ unsigned long __section_nr(struct mem_section *ms)
 #else
 unsigned long __section_nr(struct mem_section *ms)
 {
-	return (unsigned long)(ms - mem_section[0]);
+	return (unsigned long)(ms - mem_sections[0]);
 }
 #endif
 
@@ -286,8 +286,8 @@ static void __init memblocks_present(void)
 #ifdef CONFIG_SPARSEMEM_EXTREME
 	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 	align = 1 << (INTERNODE_CACHE_SHIFT);
-	mem_section = memblock_alloc(size, align);
-	if (!mem_section)
+	mem_sections = memblock_alloc(size, align);
+	if (!mem_sections)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 		      __func__, size, align);
 #endif
-- 
2.25.1

