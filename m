Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCD442779
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhKBHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:08:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC24C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IGVxyvjj8wXeCYhT6CzTbR/ke8h8L+4v3JBouegccAI=; b=xuz7Pg6HRx6pjfl/p5EmaHC61v
        DPOOh3jPtvhr8M6xFdpCqxf81D6eLREP0JBhAf5pk80fOXIlq9gkj02ZY3LQztsy+/2V8h25anzqW
        SpwBoxpXfRMybvABVRPABf64Z58TWYJwLZzzCSO7MgQo4lzgRGRaiX1wxMWCs4Y9EBSwsKgW7op5A
        CePCOxCq8tU13yN4xpkPiOhzXJWa7AJr7Gbq77auE8ea7d2mSdKdux4oUnCrUd/DI5Fjf3B8SqymP
        SdvCUtnXpbMUxyrrGGwu0IXDN2gfoUIq+v3cFP0LQIXNZuiH0TnGT8UoN/x5/WDhqEdeyNj7IJLCm
        MsqpDqYQ==;
Received: from 213-225-15-89.nat.highway.a1.net ([213.225.15.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhns4-000hyp-I2; Tue, 02 Nov 2021 07:06:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/29] drm/i915/gvt: undef TRACE_INCLUDE_FILE in i915_trace.h
Date:   Tue,  2 Nov 2021 08:05:33 +0100
Message-Id: <20211102070601.155501-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102070601.155501-1-hch@lst.de>
References: <20211102070601.155501-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenyu Wang <zhenyuw@linux.intel.com>

Allow for including multiple trace headers.

XXX: Needs a singoff.
---
 drivers/gpu/drm/i915/i915_trace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index 63fec1c3c132d..a35a8b46ac2ce 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -17,6 +17,7 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM i915
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE i915_trace
 
 /* watermark/fifo updates */
-- 
2.30.2

