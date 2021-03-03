Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C632D642
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhCDPPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:15:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhCDPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:47 -0500
Message-Id: <20210303132711.340553449@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614870845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W7oApS46MDPIMz++QVI+vaMG2S2wg5cT666lhSAPmrA=;
        b=qB10s7b6LEeIwHAxokpDovRbZ4E7paZAZz8Ep8zuCisdn5vUVu1cODeEP868R5dWht+Ccy
        hTRcgGssSmtpXoIdTHAFyKB1D7ns4yAQSqo8sWDj9gCvOU0oiLphaEUJVRVPP5l4uHhMxA
        KYFX3xRyBfIS2hbVdCTGXXtx7AdHM56BnSAjFOf8niMB8SNd1G7daMIL9XF3ic0euJni5w
        8L4hiHYyq4dU/Egvn6CcnMKftiK9UK1oLEdt4NfM3VpFfkvBUZz1VJkxcfHPaB2vQd2kn8
        raDJVfyRetjdhytPQrdrf6GOZynJke5+7R6ynEqgS4wGsS1YkSv+Povw5ZhF/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614870845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W7oApS46MDPIMz++QVI+vaMG2S2wg5cT666lhSAPmrA=;
        b=2DQyCJ6XggnTkGy39/on30lgXHHfArioCYAj6vuZB/jAFSaqLL57CRl58SOtKKbLbX5JmL
        njvWi7Pub9fsXoBg==
Date:   Wed, 03 Mar 2021 14:20:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
Subject: [patch 1/7] drm/ttm: Replace kmap_atomic() usage
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason to disable pagefaults and preemption as a side effect of
kmap_atomic_prot().

Use kmap_local_page_prot() instead and document the reasoning for the
mapping usage with the given pgprot.

Remove the NULL pointer check for the map. These functions return a valid
address for valid pages and the return was bogus anyway as it would have
left preemption and pagefaults disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/ttm/ttm_bo_util.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -181,13 +181,15 @@ static int ttm_copy_io_ttm_page(struct t
 		return -ENOMEM;
 
 	src = (void *)((unsigned long)src + (page << PAGE_SHIFT));
-	dst = kmap_atomic_prot(d, prot);
-	if (!dst)
-		return -ENOMEM;
+	/*
+	 * Ensure that a highmem page is mapped with the correct
+	 * pgprot. For non highmem the mapping is already there.
+	 */
+	dst = kmap_local_page_prot(d, prot);
 
 	memcpy_fromio(dst, src, PAGE_SIZE);
 
-	kunmap_atomic(dst);
+	kunmap_local(dst);
 
 	return 0;
 }
@@ -203,13 +205,15 @@ static int ttm_copy_ttm_io_page(struct t
 		return -ENOMEM;
 
 	dst = (void *)((unsigned long)dst + (page << PAGE_SHIFT));
-	src = kmap_atomic_prot(s, prot);
-	if (!src)
-		return -ENOMEM;
+	/*
+	 * Ensure that a highmem page is mapped with the correct
+	 * pgprot. For non highmem the mapping is already there.
+	 */
+	src = kmap_local_page_prot(s, prot);
 
 	memcpy_toio(dst, src, PAGE_SIZE);
 
-	kunmap_atomic(src);
+	kunmap_local(src);
 
 	return 0;
 }


