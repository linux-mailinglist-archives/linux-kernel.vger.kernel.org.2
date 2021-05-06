Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E588237571E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhEFP35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:29:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53305 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235503AbhEFP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:28:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 46CE9580B98;
        Thu,  6 May 2021 11:27:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 May 2021 11:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=CNhCM5piZYB3R
        G0DYNDKizi7nXlnPEa9s7srXlj6PXg=; b=ERr+ibPOf0zVPcQflUsZusng7IDBt
        Ly+me/4A5/4jPSYelctQuWumPKZHomt2odPjYpof3hzY459tKjcCPONvUILkhh/t
        6OC9a5HPpB2Yyq0o5us8PKWmCvW0mQg0f8aYcFxatzcRQYA+Eo0sWo/ZiTzuKXmI
        Hd01N3Fw2jIv2f2YFBMQkjq8B1pc4vuSxr0UIiQSeIIs85G/OdYyaHjWXBC+xCAX
        K6LBqXwl30RHi/8Vt2uTdqBmdlqpltiukvdWtro7EpYqNBN3iugBknXl6MwpGfFA
        mQRSO5ILaqStJXxGzBc3QKabgCtMhBgDXKM1Wk3hGtyex3njKiN0j6RfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CNhCM5piZYB3RG0DYNDKizi7nXlnPEa9s7srXlj6PXg=; b=Gy0HBk0D
        anbxcrn2TuZswDhEOR9nzUkL2OpRqP+G0E19ruuqkPdfG2QaMkjbgAmYgQDs2PYh
        X+u9gTjbgqnObnMCUoj+FaA95NZ9nq3dqUJghdetX+vfhI75COOAIVu45MvktsRp
        uN67O1drDk5ZvdUy0NP/n2xtAuMwihR7u7jxaIwFEFvS+Lf0X7Bu8G20EewqgnkQ
        wNmhoLBgWiIJ2Q+gcJfXE7xX9ZnkMm45EiNdfx6VxiK0pMrKHq//PZK0Gj78wkXb
        vHLLIqaG6XGkdvhTQPQ92lb9hweVk9danextwxInKDS/il/3M6ZqnGhSpbXu1q+P
        JNOnDyTiAoP7aA==
X-ME-Sender: <xms:1AqUYCulhFTFCq1TuIitxSwjbJhsysFyDWUIdrqlrydF-otZD2kHpA>
    <xme:1AqUYHcRef67m2nBpQTonTKTcKYIJ7CXSm2um39PI8T4RYV45KzrCen5CiNaIHCew
    pmrlofvEXwhQdEu2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegtddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppeef
    hedrudeigedrvdegiedrfeegnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:1AqUYNyxUWL3vkssN2aKr6C1w4NWi4ijMS6vzUobtCsaH6Se0wUjcg>
    <xmx:1AqUYNPOR0aPhbs12_rW4UBrnh8mhESTe0nMFBQzvCJJkG8ka3lF1w>
    <xmx:1AqUYC9mLFHQjMskumASj7jqaORsqmWfp5qx_O7C4l9zV6VhU2vw6Q>
    <xmx:1AqUYCN8ya_kW4otEza_yHf29kFghE0pN4XXQgR62DB2F1X4flPr8w>
Received: from Threadripper.local (ec2-35-164-246-34.us-west-2.compute.amazonaws.com [35.164.246.34])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu,  6 May 2021 11:27:12 -0400 (EDT)
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
Subject: [RFC PATCH 6/7] arch: x86: no MAX_ORDER exceeds SECTION_SIZE check for 32bit vdso.
Date:   Thu,  6 May 2021 11:26:22 -0400
Message-Id: <20210506152623.178731-7-zi.yan@sent.com>
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

For x86_64, 32bit vdso is compiled for compatibility reason and 32bit
SECTION_SIZE_BITS value is used during compilation. It causes
compilation time error when MAX_ORDER is increased in the 64bit
environment even if it is OK for 64bit SECTION_SIZE_BITS. Remove the
check during 32bit vdso compilation. It will be checked when other
kernel components are compiled.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/entry/vdso/Makefile | 1 +
 include/linux/mmzone.h       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 05c4abc2fdfd..cad339136ed1 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -156,6 +156,7 @@ KBUILD_CFLAGS_32 +=3D -fno-stack-protector
 KBUILD_CFLAGS_32 +=3D $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 +=3D -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 +=3D -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS_32 +=3D -DNO_MAX_ORDER_CHECK
=20
 ifdef CONFIG_RETPOLINE
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 965a0cd5eac1..fb5a0c2ab528 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1211,9 +1211,11 @@ static inline struct zoneref *first_zones_zonelist(s=
truct zonelist *zonelist,
 #define SECTION_BLOCKFLAGS_BITS \
 	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
=20
+#ifndef NO_MAX_ORDER_CHECK
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#endif
=20
 static inline unsigned long pfn_to_section_nr(unsigned long pfn)
 {
--=20
2.30.2

