Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7DB375715
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhEFP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:29:13 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40729 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235574AbhEFP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:27:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C9638580B88;
        Thu,  6 May 2021 11:26:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 May 2021 11:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=w/fhaxzE6d3YP
        b1A8ivd0FpL8urp0tMSoQqWGTkdTJo=; b=o2YReWlDTlx7hyCpQBDboch01MrBw
        7XjJMkWcuWMdUU1UCbOJp6jbpppf/8T43xKOvA3KqIUNAcD7v47a11NT+xE3hVeB
        5b9FUBMWLt8yl8x2GL7hpBmyu0//rDLHhFvGadX7Xjxee5PW3R+2Ci1JHCC2zryY
        85K32UJuosb15JwG8Xyx7FDxRVfU6Z5I54Gt62vGPLz1HjySj/2AMI38Hm3OloNu
        JKqxAV3dK2QbmCg4fI1l2AnmsyZtBAWWhs2IQA9FQaemR+Sx5JbXM1ZZR9dwYFlU
        C7Eose+28so1eMCpyft0SwgW6vAUbncK/pFMt373bKzzosve58IgxM5/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=w/fhaxzE6d3YPb1A8ivd0FpL8urp0tMSoQqWGTkdTJo=; b=gQxWE4lU
        bK4F3yUwJzuKmVDo6qBZZlUL1+ZhYW79mLrY/NP7hMvxe4QA/VdzOH5NgZtGzztt
        nLlUbawg/piw67Kt61d9nCOR/eIxuJzlMPCqG3htIOfA5weA9IxRRKcVdDX5rvpR
        uZb8ucV3epyency4S+Gbfytw4h2mQlN//neD+N/IjPEVtx8/hmw3ZP/EfT3NMsmr
        ZiDQPAV5uDotoT6oGL9dqWiWFlo1hURybsVJtWEzrPXPoRWeObyIZ2xPjV44153I
        /lNHUHmErSufySKQUGqMZFLDCcr/12lBtKF/ULXTHLphvcuy7YO1OAy75/Ft0kWk
        GJbcGmY9CSUidg==
X-ME-Sender: <xms:vgqUYKtguAlWuka4gWLZw84z_ujxbRPFMqPbciJ9GOWMwUV8z2QchQ>
    <xme:vgqUYPfm9HlOK0FlFisEIXiaJT_GVanMrV1F8JEIxuidlnG5P_cNqRyv0mDXFwYZI
    R_DuuoQmYWXUxyuHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegtddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppeef
    hedrudeigedrvdegiedrfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:vgqUYFyZ3An8CimP3Ts5FZ6xV-GUeXfPtaJWT7iezRv0YQfUex8oPg>
    <xmx:vgqUYFNgadI6JoQRcbAzaG32G832LfedKLZQDeGUey8kpPyb_x7ExQ>
    <xmx:vgqUYK9ZMEaZrhJhoov6k_u0HFkzs5Lf8SFaNAKBLmqXJ5EnlkOH_w>
    <xmx:vwqUYKOzvpZkOoU09kumRbPht-E6ctzOooX4bSIT5XAYWCG2ScSt5Q>
Received: from Threadripper.local (ec2-35-164-246-34.us-west-2.compute.amazonaws.com [35.164.246.34])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu,  6 May 2021 11:26:50 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 1/7] mm: sparse: set/clear subsection bitmap when pages are onlined/offlined.
Date:   Thu,  6 May 2021 11:26:17 -0400
Message-Id: <20210506152623.178731-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210506152623.178731-1-zi.yan@sent.com>
References: <20210506152623.178731-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

subsection bitmap was set/cleared when a section is added/removed, but
pfn_to_online_page() uses subsection bitmap to check if the page is
online, which is not accurate. It was working when a whole section is
added/removed during memory hotplug and hotremove. When the following
patches enable memory hotplug and hotremove for subsections,
subsection bitmap needs to be changed during page online/offline time,
otherwise, pfn_to_online_page() will not give right answers. Move the
subsection bitmap manipulation code from section_activate() to
online_mem_sections() and section_deactivate() to
offline_mem_sections(), respectively.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/sparse.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index b2ada9dc00cb..7637208b8874 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -606,6 +606,7 @@ void __init sparse_init(void)
=20
 #ifdef CONFIG_MEMORY_HOTPLUG
=20
+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages);
 /* Mark all memory sections within the pfn range as online */
 void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
@@ -621,9 +622,12 @@ void online_mem_sections(unsigned long start_pfn, unsi=
gned long end_pfn)
=20
 		ms =3D __nr_to_section(section_nr);
 		ms->section_mem_map |=3D SECTION_IS_ONLINE;
+		fill_subsection_map(pfn, min(end_pfn, pfn + PAGES_PER_SECTION) - pfn);
 	}
 }
=20
+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages);
+static bool is_subsection_map_empty(struct mem_section *ms);
 /* Mark all memory sections within the pfn range as offline */
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
@@ -641,7 +645,13 @@ void offline_mem_sections(unsigned long start_pfn, uns=
igned long end_pfn)
 			continue;
=20
 		ms =3D __nr_to_section(section_nr);
-		ms->section_mem_map &=3D ~SECTION_IS_ONLINE;
+
+		if (end_pfn < pfn + PAGES_PER_SECTION) {
+			clear_subsection_map(pfn, end_pfn - pfn);
+			if (is_subsection_map_empty(ms))
+				ms->section_mem_map &=3D ~SECTION_IS_ONLINE;
+		} else
+			ms->section_mem_map &=3D ~SECTION_IS_ONLINE;
 	}
 }
=20
@@ -668,6 +678,17 @@ static void free_map_bootmem(struct page *memmap)
 	vmemmap_free(start, end, NULL);
 }
=20
+static int subsection_map_intersects(struct mem_section *ms, unsigned long=
 pfn,
+				     unsigned long nr_pages)
+{
+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) =3D { 0 };
+	unsigned long *subsection_map =3D &ms->usage->subsection_map[0];
+
+	subsection_mask_set(map, pfn, nr_pages);
+
+	return bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION);
+}
+
 static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) =3D { 0 };
@@ -760,6 +781,12 @@ static void free_map_bootmem(struct page *memmap)
 	}
 }
=20
+static int subsection_map_intersects(struct mem_section *ms, unsigned long=
 pfn,
+				     unsigned long nr_pages)
+{
+	return 0;
+}
+
 static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	return 0;
@@ -800,7 +827,10 @@ static void section_deactivate(unsigned long pfn, unsi=
gned long nr_pages,
 	struct page *memmap =3D NULL;
 	bool empty;
=20
-	if (clear_subsection_map(pfn, nr_pages))
+	if (WARN((IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) && !ms->usage) ||
+		 subsection_map_intersects(ms, pfn, nr_pages),
+				"section already deactivated (%#lx + %ld)\n",
+				pfn, nr_pages))
 		return;
=20
 	empty =3D is_subsection_map_empty(ms);
@@ -855,7 +885,7 @@ static struct page * __meminit section_activate(int nid=
, unsigned long pfn,
 		ms->usage =3D usage;
 	}
=20
-	rc =3D fill_subsection_map(pfn, nr_pages);
+	rc =3D !nr_pages || subsection_map_intersects(ms, pfn, nr_pages);
 	if (rc) {
 		if (usage)
 			ms->usage =3D NULL;
--=20
2.30.2

