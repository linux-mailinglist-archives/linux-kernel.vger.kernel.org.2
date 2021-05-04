Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB173726D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhEDH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhEDH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:59:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E350C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sXgrmVuHfa4aFek6+BLNJ7tIPk2rJFVZ+IKiwBfq8WY=; b=L46wAmpOtecCf5PjUSrZ1TMpt6
        mAgLFqGcJF9vkNLDepdEdZuI7fgvIO/10TZru/mnGyHPBGx96t/baKdM9UbvGwSMIJcqq0sjuAA+e
        n9G1d1xOzFeOe+qswGS8MWIShIgxZnsqu6bS+qAcqyp1ynvnRSOuyaJgEnkKfe8I4ZnWl5S5ab9ic
        H/ArbDzj2Cd86bpFrke12ZldcjdZONcJ0CZwRVIxt0nWI7r0yJ7iM7G7NwswqqZtZciOTpWf8S+DW
        BBp7LmHLi8lKeYlrC+xO08g7iYD47os7sKmUmC4Y6N4B8VHkZ6A6wjQXU3YRKlUYP2jXEwVaE1eoi
        uyF2fPrA==;
Received: from [2001:4bb8:180:9479:4770:b9a9:306b:b991] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldpwn-003moi-Qp; Tue, 04 May 2021 07:58:26 +0000
Date:   Tue, 4 May 2021 09:58:23 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for Linux 5.13
Message-ID: <YJD+n2zT+BOA7ar8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.13

for you to fetch changes up to a7f3d3d3600c8ed119eb0d2483de0062ce2e3707:

  dma-mapping: add unlikely hint to error path in dma_mapping_error (2021-04-02 16:41:08 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 5.13:

 - add a new dma_alloc_noncontiguous API (me, Ricardo Ribalda)
 - fix a copyright noice (Hao Fang)
 - add an unlikely annotation to dma_mapping_error (Heiner Kallweit)
 - remove a pointless empty line (Wang Qing)
 - add support for multi-pages map/unmap bencharking (Xiang Chen)

----------------------------------------------------------------
Christoph Hellwig (5):
      dma-mapping: add a dma_mmap_pages helper
      dma-mapping: refactor dma_{alloc,free}_pages
      dma-mapping: add a dma_alloc_noncontiguous API
      dma-iommu: refactor iommu_dma_alloc_remap
      dma-iommu: implement ->alloc_noncontiguous

Hao Fang (1):
      dma-mapping: benchmark: use the correct HiSilicon copyright

Heiner Kallweit (1):
      dma-mapping: add unlikely hint to error path in dma_mapping_error

Ricardo Ribalda (1):
      media: uvcvideo: Use dma_alloc_noncontiguous API

Wang Qing (1):
      dma-mapping: remove a pointless empty line in dma_alloc_coherent

Xiang Chen (1):
      dma-mapping: benchmark: Add support for multi-pages map/unmap

 Documentation/core-api/dma-api.rst              |  88 ++++++++++++++
 drivers/iommu/dma-iommu.c                       | 103 ++++++++++++-----
 drivers/media/usb/uvc/uvc_video.c               |  94 +++++++++++----
 drivers/media/usb/uvc/uvcvideo.h                |   5 +-
 include/linux/dma-map-ops.h                     |  19 +++
 include/linux/dma-mapping.h                     |  37 +++++-
 kernel/dma/map_benchmark.c                      |  23 ++--
 kernel/dma/mapping.c                            | 148 ++++++++++++++++++++++--
 tools/testing/selftests/dma/dma_map_benchmark.c |  22 +++-
 9 files changed, 456 insertions(+), 83 deletions(-)
