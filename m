Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E2433C81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhJSQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:41:05 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52975 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231668AbhJSQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:41:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 17E5D580FA5;
        Tue, 19 Oct 2021 12:38:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 19 Oct 2021 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=i44Zg+dk2G8UzNjKJx/clmoHyO
        7G3q1KIpDDZTV8ztk=; b=J2L3osf5Ze6kpCYL57tdnuL4nc0bObyqpKRSxx+bPe
        eh2+f/AY2OxGYdyXXlT2wjon9VI9jGfiDyTeMMF9opD890dzHeoIXehAMfss3x5O
        I+kWXK6Yawym280LGgZNIqirV63EGRx+Mi0DZlMdXTUxuLMMq0Nm6tn88aWgzsxl
        gyBwaCADxK6je+pBpp9qWzvdeVZ711VdF6SSeAmjQ18eoxGgM3HH/XbmESdLzVCF
        dNXAIrGAHRv72aPwumKF6orzsw93wv8eSLDRy6HA3F7BwsTXp2plSXBUsH4+ODjr
        IvjxJ3Q7S0whoTaUf8Ee/EObVqQ/I1TebGPEUxFxcHzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=i44Zg+dk2G8UzNjKJ
        x/clmoHyO7G3q1KIpDDZTV8ztk=; b=LSwMOpqkjE94C0FXnJLpyFfkL8ue/1aKV
        Llso7UU5GE6k3bftdiTVwvwuDQkICATTvt/Y0NnJv650UVgkP3UFY0LEsDa4hiCS
        pKcejmELgIVerx1AgCN1ZRIZY9wu6d4jq3vEXK8VcCvKXuNA0KHxnNH0K2pITnSm
        EbxRGt2gJ1JYb/a2x2SiLwLsp91eSYRJzginDAvNBzhvxzEueM+q7eXt16aQ5LcG
        yFmXhqkTlhxKqjyYD5ZAcupQoalGAsaM+f6ZMqfL1hpqxDSAduYPjt9hvdnrWmlN
        2FZWOirryxvd0WeJmhauOPfosq1nbGhSd1UhQ3NaVQmwVP8SsXZGw==
X-ME-Sender: <xms:mfRuYbEUK9xq7NgiLhca8Dn9S8KLaJzLo7oK4Ow-bdX0cHgaf-V_UA>
    <xme:mfRuYYXxEEz2sWZ1k8xep73_ScNx0a4w4Lv6InLNA5Uc0BM0ihTxrGUUJ1lT5LU4k
    6rydvpWF0-JkSmZCu0>
X-ME-Received: <xmr:mfRuYdKrMJB_BqVJkxrSvz-oJIq2CwBHFXwIK5NmS-EKoGf08h3rtqOFjrse2ke7uW2rRJwpUlbRRXfopRUqcSsvfVcW6kqVS2M3HnuwU1DSdEvxCYYanAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:mfRuYZFAk-VVY5zeIPV8kQwQaCW8hF7RjxM1xECCnIiNbVbKB3GaSg>
    <xmx:mfRuYRWIpIulohQCa2EPey_PsX172KUt0h_2K_rO3XERcnd_itSAjA>
    <xmx:mfRuYUNrk3FklWjIVO9RFd5TnJrYDHts49ZUY_RuxigpJ0z0YjXeTQ>
    <xmx:mvRuYaNJwddulYrMwAHmiECV5rSYanq4IlXAQMa5L1vAGOmuQrdAdg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:47 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Support IOMMU page sizes larger than the CPU page size
Date:   Tue, 19 Oct 2021 18:37:31 +0200
Message-Id: <20211019163737.46269-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

RFC: https://lore.kernel.org/linux-iommu/20210806155523.50429-1-sven@svenpeter.dev/
 v2: https://lore.kernel.org/linux-iommu/20210828153642.19396-1-sven@svenpeter.dev/

Time to revive this series:

v2 -> v3:
  - Dropped support for untrusted devices since swiotlb currently does not
    allow aligning buffers to granularities bigger than PAGE_SIZE.
    Getting this to work is possibly but a bit tricky together with min_align_mask.
    Right now there are no untrusted device on the M1 anyway and this series already
    feels big enough. I've therefore decided to address this in a follow up.
  - Replaced phys_to_page with pfn_to_page(PHYS_PFN(..)) since not all architectures
    define phys_to_page
  - Replaced the PAGE_SIZE > granule check in iommu_check_page_size with
    domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)) as suggested by Robin
  - Rebased on the latest rc which required to introduce sg_alloc_append_table_from_pages
    since __sg_alloc_table_from_pages no longer exists 

RFC -> v2:
  - essentially a comlpetely rewrite of the first approach which just padded every
    allocation

Some background: On the Apple M1 the IOMMUs are hardwired to only support 16 KB pages.
We'd still like to boot Linux with 4KB pages though because that's what most distros
ship these days. I've been told this also helps with Android userspace compatibility
and x86 emulation.
This patch series adds support for that setup to the IOMMU DMA API.

This is essentially done by always mapping the encapsulating IOMMU page and adjusting
the returned iova offset. There are also changes to only allow DMA domains to make use
of this and prevent UNMANAGED domains from encountering unexpected situations.


Best,

Sven

Sven Peter (6):
  iommu/dma: Disable get_sgtable for granule > PAGE_SIZE
  iommu/dma: Support granule > PAGE_SIZE in dma_map_sg
  iommu/dma: Support granule > PAGE_SIZE allocations
  iommu: Move IOMMU pagesize check to attach_device
  iommu: Introduce __IOMMU_DOMAIN_LP
  iommu/dart: Remove force_bypass logic

 drivers/iommu/apple-dart.c |  14 +---
 drivers/iommu/dma-iommu.c  | 134 +++++++++++++++++++++++++++++++------
 drivers/iommu/iommu.c      |  40 ++++++++++-
 drivers/iommu/iova.c       |   7 +-
 include/linux/iommu.h      |  18 ++++-
 5 files changed, 174 insertions(+), 39 deletions(-)

-- 
2.25.1

