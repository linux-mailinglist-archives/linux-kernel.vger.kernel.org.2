Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1F36AC10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 08:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhDZGRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 02:17:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:46098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhDZGRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:17:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619417779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=50i75pznbchD9PzeshpgAZn1yFWSGeZXlL3S4MIsCwc=;
        b=YFGc+VpqKy1DNcwLyhrCIugzaI8AL2Pqe30J3GpQ4k10+E+vwXIY4ccjo9Maqd6gV++swC
        Q50/agexbloedjEiMfx5wCI2NDsliVsKmLjIE+QIzrUNoV2HBzzFx9SZNlXdrsecmwjZk3
        hdkXjZrG17jo3tJkiBsOq2XRY8FKhFU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27CC7B016;
        Mon, 26 Apr 2021 06:16:19 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.13-rc1
Date:   Mon, 26 Apr 2021 08:16:18 +0200
Message-Id: <20210426061618.22978-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13-rc1-tag

xen: branch for v5.13-rc1

It contains:

- A patch for removing some PV ACPI cpu/memory hotplug code which has
  been broken for a long time.

- A patch supporting direct mapped guests (other than dom0) on Arm.

- Several small fixes and cleanups.


Thanks.

Juergen

 arch/arm/include/asm/xen/swiotlb-xen.h   |   1 +
 arch/arm/xen/mm.c                        |  14 +-
 arch/arm64/include/asm/xen/swiotlb-xen.h |   1 +
 arch/arm64/mm/dma-mapping.c              |   2 +-
 drivers/block/xen-blkback/common.h       |   1 +
 drivers/block/xen-blkback/xenbus.c       |  38 ++-
 drivers/block/xen-blkfront.c             |   2 +-
 drivers/xen/Kconfig                      |  31 --
 drivers/xen/Makefile                     |   3 -
 drivers/xen/pcpu.c                       |  35 ---
 drivers/xen/xen-acpi-cpuhotplug.c        | 446 -----------------------------
 drivers/xen/xen-acpi-memhotplug.c        | 475 -------------------------------
 drivers/xen/xen-pciback/pci_stub.c       |   6 +-
 drivers/xen/xen-pciback/vpci.c           |   7 +-
 drivers/xen/xen-stub.c                   |  90 ------
 include/xen/acpi.h                       |  35 ---
 include/xen/arm/swiotlb-xen.h            |   7 +
 include/xen/interface/features.h         |  14 +
 include/xen/swiotlb-xen.h                |   1 +
 19 files changed, 60 insertions(+), 1149 deletions(-)

Bjorn Helgaas (1):
      xen-blkfront: Fix 'physical' typos

Boris Ostrovsky (1):
      xen: Remove support for PV ACPI cpu/memory hotplug

Jan Beulich (1):
      xen-pciback: simplify vpci's find hook

Muhammad Usama Anjum (1):
      xen/pciback: Fix incorrect type warnings

Paul Durrant (1):
      xen-blkback: fix compatibility bug with single page rings

Stefano Stabellini (1):
      xen/arm: introduce XENFEAT_direct_mapped and XENFEAT_not_direct_mapped
