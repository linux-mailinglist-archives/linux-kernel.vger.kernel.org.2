Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8370C3D12E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbhGUPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbhGUPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:14:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89358C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qYr+fejkooLprB+HBW0to2z9UK9syRmjiuAzimmt6kU=; b=bYErOGEI/N3jxH1564k5eY61gh
        BBrhHoZ1FhlWSJpHbtDmV+ScaJrKfeyZKAypMHq9VQZ1YRVxor9pUw8p6rb4keCVcP1TtJ/Pch+aU
        sD+BfK721/oPV6b29NMlCjDER9LMdEhwRtDaH8uYBWhK9QMGoynZCNndSjxdWMCQnQ2XDT1NVoZ3d
        /jC7FKMYasCDbio92YVKXwvp7ohz7z84qFzh9i84QijnZxYib8NbXHYbTcEruIvxorNMQLP8gZ3eH
        VPLsfb5u+/JqTUHoChIuZpbrk7JFN8YMcIqmJ6he+fWyWP4ay4//uGhwWeNN8xGq8ivK4IMO2g38m
        OVkNyNdQ==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EY7-009MEM-JR; Wed, 21 Jul 2021 15:54:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] drm/i915/gvt: remove module refcounting in intel_gvt_{,un}register_hypervisor
Date:   Wed, 21 Jul 2021 17:53:36 +0200
Message-Id: <20210721155355.173183-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721155355.173183-1-hch@lst.de>
References: <20210721155355.173183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THIS_MODULE always is reference when a symbol called by it is used, so
don't bother with the additional reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index cbac409f6c8a..6d7938aacca4 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -308,10 +308,6 @@ intel_gvt_register_hypervisor(const struct intel_gvt_mpt *m)
 	    m->type != INTEL_GVT_HYPERVISOR_XEN)
 		return -EINVAL;
 
-	/* Get a reference for device model module */
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
 	intel_gvt_host.mpt = m;
 	intel_gvt_host.hypervisor_type = m->type;
 	gvt = (void *)kdev_to_i915(intel_gvt_host.dev)->gvt;
@@ -321,7 +317,6 @@ intel_gvt_register_hypervisor(const struct intel_gvt_mpt *m)
 	if (ret < 0) {
 		gvt_err("Failed to init %s hypervisor module\n",
 			supported_hypervisors[intel_gvt_host.hypervisor_type]);
-		module_put(THIS_MODULE);
 		return -ENODEV;
 	}
 	gvt_dbg_core("Running with hypervisor %s in host mode\n",
@@ -335,6 +330,5 @@ intel_gvt_unregister_hypervisor(void)
 {
 	void *gvt = (void *)kdev_to_i915(intel_gvt_host.dev)->gvt;
 	intel_gvt_hypervisor_host_exit(intel_gvt_host.dev, gvt);
-	module_put(THIS_MODULE);
 }
 EXPORT_SYMBOL_GPL(intel_gvt_unregister_hypervisor);
-- 
2.30.2

