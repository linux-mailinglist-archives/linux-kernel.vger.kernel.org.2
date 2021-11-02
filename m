Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC95B44278B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhKBHJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKBHJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:09:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B9C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Pfpk1vpyS/9vxmYclFpbAHoXF3sQPSIFV4EVEVBOemA=; b=1YopZtYHfI7Tts5qs1hxMQw1At
        NQcHPvsu6MYq76qpUkTvRkAQdH/AeOD8s9wgupr6JPAsbj0ULC2E3iBi0L2osba8OaZ/u11yJkLoj
        zyIR8TJy3aP3lSmjKgZEWfgsp3s0kBiStTQzFZsEqQx65sH6/FWKfwmzh66c6i68/alVLJziiG5Iy
        ECj4voEEG9MhTJcvYzvtJj5DqxBqRbYFIgs2JRkpQFifsglc/StCcL+lZCoztG/4tIJemcjCI38A4
        /niVa0ZYqZx5HBPnqtAYcxbfG6bhTXyWyvFscc5xQdbOuGxVpftDDUVB2Z01skj/uwUNt9+DCRdDa
        625dwqKQ==;
Received: from 213-225-15-89.nat.highway.a1.net ([213.225.15.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhnsR-000i2p-O2; Tue, 02 Nov 2021 07:06:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/29] drm/i915/gvt: rename intel_vgpu_ops to intel_vgpu_mdev_ops
Date:   Tue,  2 Nov 2021 08:05:37 +0100
Message-Id: <20211102070601.155501-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102070601.155501-1-hch@lst.de>
References: <20211102070601.155501-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the intel_vgpu_ops symbol name for something that fits better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 904f9a31bd3a9..80809866cf743 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1748,7 +1748,7 @@ static const struct attribute_group *intel_vgpu_groups[] = {
 	NULL,
 };
 
-static struct mdev_parent_ops intel_vgpu_ops = {
+static struct mdev_parent_ops intel_vgpu_mdev_ops = {
 	.mdev_attr_groups       = intel_vgpu_groups,
 	.create			= intel_vgpu_create,
 	.remove			= intel_vgpu_remove,
@@ -1771,9 +1771,9 @@ static int kvmgt_host_init(struct device *dev, void *gvt, const void *ops)
 		return ret;
 
 	intel_gvt_ops = ops;
-	intel_vgpu_ops.supported_type_groups = gvt_vgpu_type_groups;
+	intel_vgpu_mdev_ops.supported_type_groups = gvt_vgpu_type_groups;
 
-	ret = mdev_register_device(dev, &intel_vgpu_ops);
+	ret = mdev_register_device(dev, &intel_vgpu_mdev_ops);
 	if (ret)
 		intel_gvt_cleanup_vgpu_type_groups((struct intel_gvt *)gvt);
 
-- 
2.30.2

