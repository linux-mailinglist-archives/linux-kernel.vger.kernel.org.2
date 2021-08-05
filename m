Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2643E1BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbhHETD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:03:58 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54777 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241703AbhHETD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:03:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 36DB65C012E;
        Thu,  5 Aug 2021 15:03:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 15:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm1; bh=ikQQ45fLfFR3RTVxZ01ZPTIWq6
        pilqkf8qSMtcqFJC4=; b=jAlF4nf9E1HY7B801BTjxPRTNtIA9jcRNBcn9rE6IK
        DbPRiy9n9jPEuFaq6ezeBGXFI9hN6ApWAHtH+GjhVnp0JcegDF2ioaX8G73ja5ch
        gy7wh/W/PB+GUwhfpjHx4Wvs+lZzJGAGvG/WcP+KfSn1Ly0P1yKhfKkvPwNfF6rl
        ICjzyBFq7z/F6GW+EGItssg+kakooioVNpTG9okFWAAUSgHE1MAV/Zn6aKd5IejF
        j1OKShe47+s+EwDHvLt28nrwid5t5s/Vp8/z9pAh7P7qEvz0R6dMyKxe2+akeX6e
        qooi+2kxLS/7oYYdtP5kbLdnW9utylH6gPcvgT/cYSSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ikQQ45
        fLfFR3RTVxZ01ZPTIWq6pilqkf8qSMtcqFJC4=; b=koK5lJxwsX3Vwp1chcjxwV
        5kboLkMieJmt386YaUjllfuHZYrN30bLliezuOZWPS72a8Dq6eqyT5EoBgMnMNMC
        ul9lyWKqvzq6Hgd3TPd58DCm1R7ug8rnq2p/ViQXLIwvC3lpeA0kw5DIhjvwEayr
        itSIxSRjSXhwST038G9Jz0NvO7gyXcdLVUXk+Gx+pmEHI6FWj+CtiGckqgn09hpm
        DGJK9Ftnq28FniPkWBdpUMBn7iVxrgZbsr9hW5KwwWLIXdwIovdcYwrQ2sKkia+x
        Nvr3mZVfwnE0odVVa8FpLJVCbQ2AK7YExmHcRgk0xRzmCoUNfviv2ebnmIshb5NQ
        ==
X-ME-Sender: <xms:DDYMYUZVZ6AUe3tOFSEFe5_Q4E1SSvtWSP3MfbIjL4uL1oryZHj_oQ>
    <xme:DDYMYfZOGrvvFw6_UUtGmVy4G3we-DbpDoL8KkMHgmxkEq1Dptoj0a-c1gjVdZm3T
    j5P4Fz4KMRxGA4Fsg>
X-ME-Received: <xmr:DDYMYe_6TGNyJ_PDAtVAHeCJMKtKaCz4L2AKt5-Hz3wisPovrfORCuF5YksBmJTr4x2s9QEZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteevueeije
    eklefhudejkeehfeffuedvhfdtteffvefgleefheefgfelveetvdfhnecuffhomhgrihhn
    pehsihiivgdrmhhmpdhprghgvghsrdhmmhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:DDYMYer9cEyN0oCsynz3sNx9aA8nwv3VrjjzLHaehLqJDPVCVQDkZQ>
    <xmx:DDYMYfocOExNNBrk8YsTl0P1MI3sOqCtOyl0CpJTh-pROIN7icZGow>
    <xmx:DDYMYcSOS-EX_x0DL_DFQzuU2oV10546L5Jcw8yCRen95a8Py7FLbg>
    <xmx:DjYMYTd9fFxr5ysoFfaW06aQZ7Ds2vaOON81Su0a_LWWw9e0ZH01CQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:40 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time parameter.
Date:   Thu,  5 Aug 2021 15:02:38 -0400
Message-Id: <20210805190253.2795604-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset add support for kernel boot time adjustable MAX_ORDER, so that
user can change the largest size of pages obtained from buddy allocator. It=
 also
removes the restriction on MAX_ORDER based on SECTION_SIZE_BITS, so that
buddy allocator can merge PFNs across memory sections when SPARSEMEM_VMEMMA=
P is
set. It is on top of v5.14-rc4-mmotm-2021-08-02-18-51.

Motivation
=3D=3D=3D

This enables kernel to allocate 1GB pages and is necessary for my ongoing w=
ork
on adding support for 1GB PUD THP[1]. This is also the conclusion I came up=
 with
after some discussion with David Hildenbrand on what methods should be used=
 for
allocating gigantic pages[2], since other approaches like using CMA allocat=
or or
alloc_contig_pages() are regarded as suboptimal.

This also prevents increasing SECTION_SIZE_BITS when increasing MAX_ORDER, =
since
increasing SECTION_SIZE_BITS is not desirable as memory hotadd/hotremove ch=
unk
size will be increased as well, causing memory management difficulty for VM=
s.

In addition, make MAX_ORDER a kernel boot time parameter can enable user to
adjust buddy allocator without recompiling the kernel for their own needs, =
so
that one can still have a small MAX_ORDER if he/she does not need to alloca=
te
gigantic pages like 1GB PUD THPs.

Background
=3D=3D=3D

At the moment, kernel imposes MAX_ORDER - 1 + PAGE_SHFIT < SECTION_SIZE_BITS
restriction. This prevents buddy allocator merging pages across memory sect=
ions,
as PFNs might not be contiguous and code like page++ would fail. But this w=
ould
not be an issue when SPARSEMEM_VMEMMAP is set, since all struct page are
virtually contiguous. In addition, as long as buddy allocator checks the PFN
validity during buddy page merging (done in Patch 3), pages allocated from
buddy allocator can be manipulated by code like page++.


Description
=3D=3D=3D

I tested the patchset on both x86_64 and ARM64 at 4KB, 16KB, and 64KB base
pages. The systems boot and ltp mm test suite finished without issue. Also
memory hotplug worked on x86_64 when I tested. It definitely needs more tes=
ts
and reviews for other architectures.

In terms of the concerns on performance degradation if MAX_ORDER is increas=
ed,
I did some initial performance tests comparing MAX_ORDER=3D11 and MAX_ORDER=
=3D20 on
x86_64 machines and saw no performance difference[3].

Patch 1 excludes MAX_ORDER check from 32bit vdso compilation. The check uses
irrelevant 32bit SECTION_SIZE_BITS during 64bit kernel compilation. The
exclusion does not break the check in 32bit kernel, since the check will st=
ill
be performed during other kernel component compilation.

Patch 2 gives FORCE_MAX_ZONEORDER a better name.

Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
pages across memory sections. The check was removed when ARM64 gets rid of =
holes
in zones, but holes can appear in zones again after this patchset.

Patch 4-11 convert the use of MAX_ORDER to SECTION_SIZE_BITS or its derivat=
ive
constants, since these code places use MAX_ORDER as boundary check for
physically contiguous pages, where SECTION_SIZE_BITS should be used. After =
this
patchset, MAX_ORDER can go beyond SECTION_SIZE_BITS, the code can break.
I separate changes to different patches for easy review and can merge them =
into
a single one if that works better.

Patch 12 adds a new Kconfig option SET_MAX_ORDER to allow specifying MAX_OR=
DER
when ARCH_FORCE_MAX_ORDER is not used by the arch, like x86_64.

Patch 13 converts statically allocated arrays with MAX_ORDER length to dyna=
mic
ones if possible and prepares for making MAX_ORDER a boot time parameter.

Patch 14 adds a new MIN_MAX_ORDER constant to replace soon-to-be-dynamic
MAX_ORDER for places where converting static array to dynamic one is causing
hassle and not necessary, i.e., ARM64 hypervisor page allocation and SLAB.

Patch 15 finally changes MAX_ORDER to be a kernel boot time parameter.


Any suggestion and/or comment is welcome. Thanks.


TODO
=3D=3D=3D

1. Redo the performance comparison tests using this patchset to understand =
the
   performance implication of changing MAX_ORDER.


Zi Yan (15):
  arch: x86: remove MAX_ORDER exceeding SECTION_SIZE check for 32bit
    vdso.
  arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
  mm: check pfn validity when buddy allocator can merge pages across mem
    sections.
  mm: prevent pageblock size being larger than section size.
  mm/memory_hotplug: online pages at section size.
  mm: use PAGES_PER_SECTION instead for mem_map_offset/next().
  mm: hugetlb: use PAGES_PER_SECTION to check mem_map discontiguity
  fs: proc: use PAGES_PER_SECTION for page offline checking period.
  virtio: virtio_mem: use PAGES_PER_SECTION instead of
    MAX_ORDER_NR_PAGES
  virtio: virtio_balloon: use PAGES_PER_SECTION instead of
    MAX_ORDER_NR_PAGES.
  mm/page_reporting: report pages at section size instead of MAX_ORDER.
  mm: Make MAX_ORDER of buddy allocator configurable via Kconfig
    SET_MAX_ORDER.
  mm: convert MAX_ORDER sized static arrays to dynamic ones.
  mm: introduce MIN_MAX_ORDER to replace MAX_ORDER as compile time
    constant.
  mm: make MAX_ORDER a kernel boot time parameter.

 .../admin-guide/kdump/vmcoreinfo.rst          |   2 +-
 .../admin-guide/kernel-parameters.txt         |   5 +
 arch/Kconfig                                  |   4 +
 arch/arc/Kconfig                              |   2 +-
 arch/arm/Kconfig                              |   2 +-
 arch/arm/configs/imx_v6_v7_defconfig          |   2 +-
 arch/arm/configs/milbeaut_m10v_defconfig      |   2 +-
 arch/arm/configs/oxnas_v6_defconfig           |   2 +-
 arch/arm/configs/sama7_defconfig              |   2 +-
 arch/arm64/Kconfig                            |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |   2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          |   3 +-
 arch/csky/Kconfig                             |   2 +-
 arch/ia64/Kconfig                             |   2 +-
 arch/ia64/include/asm/sparsemem.h             |   6 +-
 arch/m68k/Kconfig.cpu                         |   2 +-
 arch/mips/Kconfig                             |   2 +-
 arch/nios2/Kconfig                            |   2 +-
 arch/powerpc/Kconfig                          |   2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |   2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config     |   2 +-
 arch/sh/configs/ecovec24_defconfig            |   2 +-
 arch/sh/mm/Kconfig                            |   2 +-
 arch/sparc/Kconfig                            |   2 +-
 arch/x86/entry/vdso/Makefile                  |   1 +
 arch/xtensa/Kconfig                           |   2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |   7 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  58 +++++++++-
 drivers/virtio/virtio_balloon.c               |   2 +-
 drivers/virtio/virtio_mem.c                   |  12 +-
 fs/proc/kcore.c                               |   2 +-
 include/drm/ttm/ttm_pool.h                    |   4 +-
 include/linux/memory_hotplug.h                |   1 +
 include/linux/mmzone.h                        |  56 ++++++++-
 include/linux/pageblock-flags.h               |   7 +-
 include/linux/slab.h                          |   8 +-
 mm/Kconfig                                    |  16 +++
 mm/compaction.c                               |  20 ++--
 mm/hugetlb.c                                  |   2 +-
 mm/internal.h                                 |   4 +-
 mm/memory_hotplug.c                           |  18 ++-
 mm/page_alloc.c                               | 108 ++++++++++++++++--
 mm/page_isolation.c                           |   7 +-
 mm/page_owner.c                               |  14 ++-
 mm/page_reporting.c                           |   3 +-
 mm/slab.c                                     |   2 +-
 mm/slub.c                                     |   7 +-
 mm/vmscan.c                                   |   1 -
 48 files changed, 334 insertions(+), 86 deletions(-)

--=20
2.30.2

