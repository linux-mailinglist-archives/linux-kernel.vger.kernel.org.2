Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86783059DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhA0LdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhA0L3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:29:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE5C061355
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f16so1222939wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAcqugrgmh8drWeQR+i/2G20G7LeMdKvoS3TGhgRh3k=;
        b=ki5sKBbvUH97xRS17R7ZRIfdT505bJXJc9ycIieG3YZtQaTkl6hn3yT88GSXjJuHaU
         G8uyBhNCIhFO9tEnbFNRwqusT2pALL0FwFllWU2+xaIXeB0tpu2BvCR8Mm2p7WNtR/EA
         UF7gMvG9H6vTfL41sL8BMOkYwIpyE8FqlZeVbbVVOVjCtiqekiIPwYXSReB5adhLy7FH
         YhcNNMOKwxHYfgOX35RJibYYXNdxm9qbFNxss2BxQLPRkK5vMju+WJD0FdzGFUeDAp9J
         K+fJZ3OwNg6PL/c1WHUJ6qLk0sX/CykQF8o9ZM+aggfzWS9Es44h7IpCPzwKgf+5Yo+f
         jB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAcqugrgmh8drWeQR+i/2G20G7LeMdKvoS3TGhgRh3k=;
        b=AuQ39KD/EYecv214nhkEPLpRWunxkKuJsLLOyqE1QfdWGbBGfLwXBIJi/UUWqmXKep
         J/uSUOxcF8BCWRfmp6RaZfcL+6F0SzMSzuxLWuWFIm49ByHwpEADt4NkzP8VrQ0NZaqn
         qbA2OJ/bH0sHkKVniP6TIIu+q2v2xt07RzB7WPToIbG9CYNXfdCB898yudluKCjPbtdn
         ydtiU1LJaymrD8MCNSJRS5Ha6BOLU91soVDwdZRwQLQqiybYzXx/6J8Or5C3xJYcgSa4
         /fx8Rl/MjGSf+TupIzcSarMzJ/+pxQn0xo4cw2BW1r5KXBz+QMpjJeGiumRsSMQSYFRp
         RFTQ==
X-Gm-Message-State: AOAM531tQUFUO24HDJ/unBNvG4yKBc77CEe1ioM0J4A6mFPL6DvsD2mq
        7HCRSqxhOppUR9DlaqGv8crzWg==
X-Google-Smtp-Source: ABdhPJzrgEGUcdu6J/3N6xbN495gRs1VHWUonXUpRjsX+BWZK2Id+wPxgtjubHMm9Bnty6EeBy2rRQ==
X-Received: by 2002:a7b:cf34:: with SMTP id m20mr3889202wmg.84.1611746767374;
        Wed, 27 Jan 2021 03:26:07 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 07/12] thunderbolt: nhi: Demote some non-conformant kernel-doc headers
Date:   Wed, 27 Jan 2021 11:25:49 +0000
Message-Id: <20210127112554.3770172-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/nhi.c:53: warning: Function parameter or member 'ring' not described in 'ring_interrupt_active'
 drivers/thunderbolt/nhi.c:53: warning: Function parameter or member 'active' not described in 'ring_interrupt_active'
 drivers/thunderbolt/nhi.c:114: warning: Function parameter or member 'nhi' not described in 'nhi_disable_interrupts'
 drivers/thunderbolt/nhi.c:191: warning: Function parameter or member 'ring' not described in 'ring_write_descriptors'
 drivers/thunderbolt/nhi.c:225: warning: Function parameter or member 'work' not described in 'ring_work'
 drivers/thunderbolt/nhi.c:599: warning: Function parameter or member 'ring' not described in 'tb_ring_start'
 drivers/thunderbolt/nhi.c:682: warning: Function parameter or member 'ring' not described in 'tb_ring_stop'

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/nhi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index cfc622da4f832..2ba33b53d4eb1 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -44,7 +44,7 @@ static int ring_interrupt_index(struct tb_ring *ring)
 	return bit;
 }
 
-/**
+/*
  * ring_interrupt_active() - activate/deactivate interrupts for a single ring
  *
  * ring->nhi->lock must be held.
@@ -105,7 +105,7 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 	iowrite32(new, ring->nhi->iobase + reg);
 }
 
-/**
+/*
  * nhi_disable_interrupts() - disable interrupts for all rings
  *
  * Use only during init and shutdown.
@@ -182,7 +182,7 @@ static bool ring_empty(struct tb_ring *ring)
 	return ring->head == ring->tail;
 }
 
-/**
+/*
  * ring_write_descriptors() - post frames from ring->queue to the controller
  *
  * ring->lock is held.
@@ -212,7 +212,7 @@ static void ring_write_descriptors(struct tb_ring *ring)
 	}
 }
 
-/**
+/*
  * ring_work() - progress completed frames
  *
  * If the ring is shutting down then all frames are marked as canceled and
@@ -590,7 +590,7 @@ struct tb_ring *tb_ring_alloc_rx(struct tb_nhi *nhi, int hop, int size,
 }
 EXPORT_SYMBOL_GPL(tb_ring_alloc_rx);
 
-/**
+/*
  * tb_ring_start() - enable a ring
  *
  * Must not be invoked in parallel with tb_ring_stop().
@@ -665,7 +665,7 @@ void tb_ring_start(struct tb_ring *ring)
 }
 EXPORT_SYMBOL_GPL(tb_ring_start);
 
-/**
+/*
  * tb_ring_stop() - shutdown a ring
  *
  * Must not be invoked from a callback.
@@ -754,7 +754,7 @@ void tb_ring_free(struct tb_ring *ring)
 	dev_dbg(&ring->nhi->pdev->dev, "freeing %s %d\n", RING_TYPE(ring),
 		ring->hop);
 
-	/**
+	/*
 	 * ring->work can no longer be scheduled (it is scheduled only
 	 * by nhi_interrupt_work, ring_stop and ring_msix). Wait for it
 	 * to finish before freeing the ring.
-- 
2.25.1

