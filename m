Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101C3F6794
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbhHXRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:36:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbhHXRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:32:10 -0400
Received: from localhost.localdomain (unknown [IPv6:2600:8800:8c06:1000::c8f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 109241F41A29;
        Tue, 24 Aug 2021 18:31:21 +0100 (BST)
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/panfrost: Handle non-aligned lock addresses
Date:   Tue, 24 Aug 2021 13:30:28 -0400
Message-Id: <20210824173028.7528-5-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824173028.7528-1-alyssa.rosenzweig@collabora.com>
References: <20210824173028.7528-1-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When locking memory, the base address is rounded down to the nearest
page. The current code does not adjust the size in this case,
truncating the lock region:

	Input:      [----size----]
	Round: [----size----]

To fix the truncation, extend the lock region by the amount rounded off.

	Input:      [----size----]
	Round: [-------size------]

This bug is difficult to hit under current assumptions: since the size
of the lock region is stored as a ceil(log2), the truncation must cause
us to cross a power-of-two boundary. This is possible, for example if
the caller tries to lock 65535 bytes starting at iova 0xCAFE0010. The
existing code rounds down the iova to 0xCAFE0000 and rounds up the lock
region to 65536 bytes, locking until 0xCAFF0000. This fails to lock the
last 15 bytes.

In practice, the current callers pass PAGE_SIZE aligned inputs, avoiding
the bug. Therefore this doesn't need to be backported. Still, that's a
happy accident and not a precondition of lock_region, so we let's do the
right thing to future proof.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Reported-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index dfe5f1d29763..14be32497ec3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -63,6 +63,9 @@ static void lock_region(struct panfrost_device *pfdev, u32 as_nr,
 	u8 region_width;
 	u64 region = iova & PAGE_MASK;
 
+	/* After rounding the address down, extend the size to lock the end. */
+	size += (region - iova);
+
 	/* The size is encoded as ceil(log2) minus(1), which may be calculated
 	 * with fls. The size must be clamped to hardware bounds.
 	 */
-- 
2.30.2

