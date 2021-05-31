Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759083957FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhEaJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:22:24 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:39493
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230501AbhEaJWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:22:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC7Vp5ZYm/F6HOTijOFGHbn85u1110dv5C7yGBXKFjL+u7ki6VFlE4jQcAx54Qq0Q8ig7CkM6RkSMebUG9CRud5l+qqRSaMlNkqtGluZvOsuU97WjRFajxeBS98tAUNOiJna41uGBxcXqTClj/LRiI8v2gFQMnskSFA9YB4Vvx2en/OxTUHgQG40zPKn7rQAMFyxBS7yo6WyHJILak8DklenajIiGfg1L5iN/XmzpgMlvV+ULhaJVdx85fLiyYpl4ZahrY6bEBJLO1xef+gdc+wlb9VzR8+ZCT8cDWfwbz0JO+nsIHm5zDGzibPXkGSATRxGqe7rmmMlfTkeWk/HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeIYaVfAHYhu6OhRzPFCf0hPWjBofkoz9rWFvH3Od1g=;
 b=eEZOhVukFs3RNNQVzrqt1B17NLhJ90CiGYYunSoae9sQYDrmE825ng6nE0Fuvo5rCjPJck3W5JImyGrl/9HBSySMLDeGbfCnY91CAsh1qj+g7tVfmIglCs5yYMwlDWxbDH9yEXDS1UZSsLTYM89WzevNL5bPRfdTNuZPw4ffo1SsOIDbKM8dOnrYzTmg6IK5Sq3To4+RonOEBQY5cRsoC7p1fMbpQCYRQZL98XTlt5CLaTLKJpp6nID7kZz/qro4VvsxhWoehAjozTJoYJpWOTIpkEvQAvS1JkYQIbrcUhr8tukNOUVYN2LWxVO48UtMLVNRScrT2S6Bx+Yn+rGxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeIYaVfAHYhu6OhRzPFCf0hPWjBofkoz9rWFvH3Od1g=;
 b=EIY3fqk7/+Wt/Ogw/6QY+wi29jfddUVCGpRCcm3NQplxAZmHeha1WVXdY94Zhnpg/imFaMhIwFV6WcZrdAefjfom+H5gCxqjARMey3so9L4lsm6CKK49jRzwv2L2r8omso3RG77JlP/rDhyKb7QDV7mHrHHRh095MGTO+O+C9qM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 09:20:20 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:20:20 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH V2 4/6] mm: rename the global section array to mem_sections
Date:   Mon, 31 May 2021 17:19:06 +0800
Message-Id: <20210531091908.1738465-5-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531091908.1738465-1-aisheng.dong@nxp.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:20:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6884ab0-9855-48df-1e83-08d924154ff5
X-MS-TrafficTypeDiagnostic: DU2PR04MB8998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB899821425FFAF03518C5B8B2803F9@DU2PR04MB8998.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8ZCs2+Wv1zvw3KpNOD92BNT3rXC5zAtlrbsIwsMneessJoitX+VTBJAPuRIWPJsWLkRGC6t//LXaMm3FJSGOEsDCSgMeMA8vlneIKL2tbprGHYJlPoWY8nPL0wQXHpJfhAh3URsGzNLiJlxfk6Q0ez4LhIe1DtU6v4Zdpu6x5fp0WMGPDN39xTsw4vfyqd593UvdiOIR0nVD9sd6e0f5Rdby1mixJa4fNI3UNsG88PmbC0yu+BD0UaovgprEMUZ2oVbwE8Y7bkM0qEhnj3OYgJbco6Uep7j92e2c+WdVhKXqoCv4APawrM/hKj24oPBDk4ZXHM/DiFe/eJiHzvVAEqdBmAFdEOE1si+0lTohHC9sVAWJ70mQsnAM1MzD0QfSMriBf8TepsZaujSU0qhGmh7b58S5Tg+4A1ZMRIKw6gnAOAJzBuTrs2jw/QKTaySNJZOnFczvqIo0JL9v7KRmdoxZDdMJCc2seHGSbqvOixUUnRyEHFFll72VlfzrViD5sLxmPwUO/mYofCHIJBvVD1ds5davBu/LFe6NBW87dFr0BuTTiAWpAfMYR/m7q/W0bsowV9evxt9gMjuI8bzr/PInEY/TQPy/ljU1WZMRBQHq55NrG8PEObRMKDxOzNgOt7u45kvOtY7O2mhoNk+FzFiQPIQOmEsWUug4MpzPWbXgMOl0IsbdLmUa27fjy1z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6666004)(38100700002)(38350700002)(956004)(6916009)(83380400001)(6486002)(86362001)(16526019)(8936002)(2616005)(186003)(8676002)(478600001)(6512007)(316002)(5660300002)(52116002)(4326008)(26005)(6506007)(36756003)(2906002)(1076003)(66476007)(66946007)(66556008)(54906003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S/4vJWKEMQvmGNT9eXNBpkQ01vEMqyU1D5A3cE5wxjqOx8L9u/WEJtt6KVDS?=
 =?us-ascii?Q?hQjcG/0ieQohfUaxDYxqwmNDzTfxaCGjKiLGw1EG13OYNU0Ier6Mec/Ic0R6?=
 =?us-ascii?Q?67VwpRRYNzL1ojGitWIsDhdDcGmLl0jjASX8uOtGZLLOsT8qwKOOgpFK/N6W?=
 =?us-ascii?Q?vG4xo0KO4AfZSDOPt/Trejf8v2NaCANsi5fVfmxwrVKCq9aN08GZnFds2ugR?=
 =?us-ascii?Q?2E35EaLAS6stSlUmNpDHhmSYD55Pke22xMQ4M+u2wMa5i8rJqpJly0SwOiF7?=
 =?us-ascii?Q?LE545r6UZEliB9xoCmmgSIypjqbgTn1UWrUKUU2C7kENsMS4DVfvUswlLxXs?=
 =?us-ascii?Q?aGn5ma6eEidPqBUoJ/k3wfqE14xp1z59umTFc80aohQ4qvfETwSbAH/UimdV?=
 =?us-ascii?Q?MwPs2WUGEQCZfTC++WT/Ez5UWVucTfs9g+59tpIa/qRgkhOE4i8mD9nOSknP?=
 =?us-ascii?Q?+MWwPzqOw7izvKa84hSwaOtQOUiMtsBFUw2bYuu2AgR9Wn/t2dOI9DfQL40f?=
 =?us-ascii?Q?mF5Q+8kIjCZSi1pAM21d9+VscGygxC8TdKNQUOgt9ls7cVfjuijaj6HPlDxA?=
 =?us-ascii?Q?BT6LuuOMxhtNeUDWtFwL7Pqxdu9tAHWcGZjCmfGwsiUOmjloClX4qNk5yNXu?=
 =?us-ascii?Q?bkcuuEm1eAYoMbpqUJJIX4GacxERGM0Z18hKnZ5H/FGwGK251ur8I338h9aa?=
 =?us-ascii?Q?cS60f9ugTBaiYwASnAVnJwd39iFLdGam4pW5NXXag2eKa0Aw9SW1kzeXjm31?=
 =?us-ascii?Q?s4pw21izhgAWyK0dmSbt7Y64T2OO5jIO1nPsDiVRtnPOH/j55vhRXbmg/9rV?=
 =?us-ascii?Q?cZ+Gyox8yXmxU3HUMnrpoWxk/Cj7u8ErGRtGQVdwpJTlrnBoyARvjBlhcH8V?=
 =?us-ascii?Q?ZbjhGau3zFVu+v8UwwmCeK3n/g7HNct949Ghmg0lWPUTlrBOdQ+a6mL82Wfa?=
 =?us-ascii?Q?XX4v/lxvA12Tm18STupr+Z1NbDLUWDZ1Pm+BDoHdc9XvDaV+NQKc9+JmPJ5M?=
 =?us-ascii?Q?g/6AuI3oFK7XLIZX4JzgzBilwn6ltfuFFzwNKO1pMhkALWHFXlyaoqrRz/md?=
 =?us-ascii?Q?qLsZFU23e+1oBe8203p1rZON6xkAF0GVvPdn1gToPvXig1ba2ktGTYoQ+Mn8?=
 =?us-ascii?Q?WxxJ4QawNbkjhzriBYU0F+FavgohAxAac2Wx78Wn7kYqj/FMTCkrLULvlYfC?=
 =?us-ascii?Q?6kHZgcdsfPwsm42DdvA4gFeDeAg5hROzpmscYi1LhYfitgKqorWkSAVrn6lc?=
 =?us-ascii?Q?Mvijmd8U8CAOAyOPJX3+ayhpozKkhqhTKx26srdnmNrxxYDss/Za0gjLnF0h?=
 =?us-ascii?Q?Wa+THf1AH9q7uEGU97I3pfd6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6884ab0-9855-48df-1e83-08d924154ff5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:20:20.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELYPVG77FOJUrTV48TgV45hULU8M/syt+h5Vova0zNesEWVHCst3LQJvaQMQZEBzd4OdnA8l18l5bzIApANzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998
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
v1->v2:
 * no changes
---
 include/linux/mmzone.h | 10 +++++-----
 kernel/crash_core.c    |  4 ++--
 mm/sparse.c            | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a6bfde85ddb0..0ed61f32d898 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1302,9 +1302,9 @@ struct mem_section {
 #define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
-extern struct mem_section **mem_section;
+extern struct mem_section **mem_sections;
 #else
-extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
+extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
 #endif
 
 static inline unsigned long *section_to_usemap(struct mem_section *ms)
@@ -1315,12 +1315,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
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
index d02ee6bb7cbc..6412010478f7 100644
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
@@ -66,8 +66,8 @@ static void __init sparse_alloc_section_roots(void)
 
 	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 	align = 1 << (INTERNODE_CACHE_SHIFT);
-	mem_section = memblock_alloc(size, align);
-	if (!mem_section)
+	mem_sections = memblock_alloc(size, align);
+	if (!mem_sections)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 		      __func__, size, align);
 }
@@ -103,14 +103,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
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
@@ -145,7 +145,7 @@ unsigned long __section_nr(struct mem_section *ms)
 #else
 unsigned long __section_nr(struct mem_section *ms)
 {
-	return (unsigned long)(ms - mem_section[0]);
+	return (unsigned long)(ms - mem_sections[0]);
 }
 #endif
 
-- 
2.25.1

