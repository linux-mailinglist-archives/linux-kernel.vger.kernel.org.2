Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741C03ED784
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbhHPNeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241360AbhHPN04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:26:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B3A60EE0;
        Mon, 16 Aug 2021 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629120383;
        bh=nJlI5nsttxgiWcZmG7gDRDAOUwH3HLjZvAb35dPozVg=;
        h=From:To:Cc:Subject:Date:From;
        b=AQmLm1LoZ1gUij0NnLdcMeyWAc7Td4t533QxhJCPA2KyWC8TgyjVriDo8NCZSZN5S
         X3mgcUSmvudWkU0W3xHhnfhBfqKIqYeSKM3intDrqzxxZYIOL0sjqu/2OYKUVneQzK
         /AKisa99nD1tJejzCdfWFJC3X4PabPupp/p9se38AU1TOY5z6lr+gado7MztakUFAG
         v4ulrwVEI2mxsUAM4LZ5JYdNlrDEosUzrl131NRSi/+QlMiciW9KPiCHFS0ePcaFdM
         qRaBzGMC1EFmucTbA5c/6LmZ/uycj6RF94uOwJRWrnyYO7WR/VC6psQB8yXoDGhU4M
         /wHG9lcQFwn3g==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/2] Don't fail device probing due to of_dma_set_restricted_buffer()
Date:   Mon, 16 Aug 2021 14:26:15 +0100
Message-Id: <20210816132618.11707-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v2 of the patch I previously posted here:

  https://lore.kernel.org/r/20210805094736.902-1-will@kernel.org

Changes since v1 are:

  * Move of_dma_set_restricted_buffer() into of/device.c (Rob)
  * Use IS_ENABLED() instead of 'static inline' stub (Rob)

This applies on Konrad's devel/for-linus-5.15 branch in swiotlb.git

Cheers,

Will

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>

--->8

Will Deacon (2):
  of: Move of_dma_set_restricted_buffer() into device.c
  of: restricted dma: Don't fail device probe on rmem init failure

 drivers/of/address.c    | 33 ---------------------------------
 drivers/of/device.c     | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/of/of_private.h |  7 -------
 3 files changed, 38 insertions(+), 41 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

