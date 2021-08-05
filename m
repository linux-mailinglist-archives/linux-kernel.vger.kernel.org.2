Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C953E1BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbhHETEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:00 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36005 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241868AbhHETD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:03:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 462405810AD;
        Thu,  5 Aug 2021 15:03:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 05 Aug 2021 15:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=wTdo21iBPQX8U
        kFAjwkvjQ0EK84I1J4pRSwJ7mQOzr8=; b=YuF+9bhrhzirasmvngw+F+N/MPIwF
        u3mw+9QZ1B4MiFo3OT8wBrKfvWpiqjOKrDLnYLRxy+bHMBEZ+pA2ALHoWrhprqZX
        yhk/PPeXrUOjEwEmNIhtSPu+R1D3PDsnStNBKdpmJSdod2eiiFg+NnBoGD2NRTG5
        wGJl1PhZaiju7Kcao4yHJqxarP/HSuoRNFvSJuQlJ8zR3AmtiQ+fmCbYF8VMEy3C
        kHE5Twb3irrjoPgjKH71t0Q8lDNdyaDcEUiJq+q4seGpEexo85vFsXIrFpcIttoK
        Jv+BaqPNRylSofoIUJhOPlxaabVUNbg/af6v7hC3LGdPecjuVU04QMalQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wTdo21iBPQX8UkFAjwkvjQ0EK84I1J4pRSwJ7mQOzr8=; b=KLYqgml+
        nv0rwA7/vkJ0ZDg8612bfnM3HTTAHpyqw+RwC+eT+LioA3XmQ7ELdy4tCxBUY64g
        yxqCmMwNIpOl/Wu1LOGUD1b/fqPpaD941aXu8oliOX1pk3swfd9M0xgelr6jg9x0
        vCHag1XB3FygIwVXU4YDlgQOVPDFrIF3Pw2fTFqCEnCTTIBsw26wwK/GlstkkiFB
        fmcREPjqjdlRO0a9RfiClljJcLB6dh5+uloW6HfZztn/Gjtsh7ddtScZj1NLXZzm
        OzAn9E0Km8k1az9oXj8UBpbaxoa3KPNn5COz4VfeUQm8nDG7JopsK126y+NcehBK
        xj7+ZjE21KVjNA==
X-ME-Sender: <xms:DjYMYZnFOaG1hjoLBKvtDZViDwVM-pW-5_LYHM0uScaqomSyUkV5Rg>
    <xme:DjYMYU20IqwXslK7x_1FWTrkoeF4poxz_Kf--PFjzr1G8ErVeD62zD-fMZQ58C0rs
    h95d7eGjP-GtA_2TA>
X-ME-Received: <xmr:DjYMYfpKIG1lV-Vbrmyy2ig2zWpt4OaoNzTzlytqdu6pt2weDQD9sHfW7GMDBvMDNw_rQJoJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:DjYMYZn0d6lhvP1wc8DAh1GA4rnEw1vgqsRK34qCv4uQkZ2G0Yx5fw>
    <xmx:DjYMYX1fJFWNpn36ltvpJVRgiVOJ3xumLXI6EgkBIXFhXhlSGorEPg>
    <xmx:DjYMYYuSadyhKRSzDR4kQGLFfocuMbZCtYfLxsHJaIAFEwvLUZz60A>
    <xmx:DzYMYQvLBZxZBrIdPpx4TVKHWFF5nNICUN4ATY-yub2YQO5yYPuM9w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:42 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: [RFC PATCH 01/15] arch: x86: remove MAX_ORDER exceeding SECTION_SIZE check for 32bit vdso.
Date:   Thu,  5 Aug 2021 15:02:39 -0400
Message-Id: <20210805190253.2795604-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
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
check during 32bit vdso compilation. The check still exists during the
compilation of other kernel components.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 arch/x86/entry/vdso/Makefile | 1 +
 include/linux/mmzone.h       | 3 +++
 2 files changed, 4 insertions(+)

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
index 6a1d79d84675..c1d914a72489 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1245,9 +1245,12 @@ static inline struct zoneref *first_zones_zonelist(s=
truct zonelist *zonelist,
 #define SECTION_BLOCKFLAGS_BITS \
 	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
=20
+/* NO_MAX_ORDER_CHECK when compiling x64 32bit VDSO for 64bit system */
+#ifndef NO_MAX_ORDER_CHECK
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#endif /* NO_MAX_ORDER_CHECK */
=20
 static inline unsigned long pfn_to_section_nr(unsigned long pfn)
 {
--=20
2.30.2

