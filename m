Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A68C399723
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFCAnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:43:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:20968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhFCAna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:43:30 -0400
IronPort-SDR: NCunTLOx4NyE7SHArA4XT1iKjqRUyRIE39R3w0Vboz1m+giWuhkf0Qmj1lfw8OGzPoDfskapnI
 tkjdpCBgf9NA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="202075167"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="202075167"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:46 -0700
IronPort-SDR: dhLv57dz9HwwibPiEYbHtPMONcCxCLxcsR6TEmsybaNnFlLNXLEmFLYBV1Mc+W09uoYz9GxbpY
 /iz4i02nlxTg==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="549686674"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Virtio hardening for TDX
Date:   Wed,  2 Jun 2021 17:41:25 -0700
Message-Id: <20210603004133.4079390-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v1: Initial post]

With confidential computing like TDX the guest doesn't trust the host
anymore. The host is allowed to DOS of course, but it is not allowed
to read or write any guest memory not explicitely shared with it.

This has implication for virtio. Traditionally virtio didn't assume
the other side of the communication channel is malicious, and therefore
didn't do any boundary checks in virtio ring data structures.

This patchkit does hardening for virtio.  In a TDX like model
the only host memory accesses allowed are in the virtio ring, 
as well as the (forced) swiotlb buffer.

This patch kit does various changes to ensure there can be no
access outside these two areas. It is possible for the host
to break the communication, but this should result in a IO
error on the guest, but no memory safety violations.

virtio is quite complicated with many modes. To simplify
the task we enforce that virtio is only in split mode without
indirect descriptors, when running as a TDX guest. We also
enforce use of the DMA API.

Then these code paths are hardened against any corruptions
on the ring.

This patchkit has components in three subsystems:
- Hardening changes to virtio, all in the generic virtio-ring
- Hardening changes to kernel/dma swiotlb to harden swiotlb against
malicious pointers. It requires an API change which needed a tree sweep.
- A single x86 patch to enable the arch_has_restricted_memory_access
for TDX

It depends on Sathya's earlier patchkit that adds the basic infrastructure
for TDX. This is only needed for the "am I running in TDX" part.



