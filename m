Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5733673B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbhDUTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbhDUTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:47:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A15C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1906166wmy.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/b4PlwxeP2QN4jZJPRCUuw530f+oAMFiERG4rj/EFOU=;
        b=oRb/Pv7kKn6wnsQoRvbOHot0M6ERkC5VhaOWWR9PziWbjjeHA4mMoLvIDw4jv9NQeN
         +uB8lGcgtWmIXdzPDScHmJzixhHWpHObtqEBdOQvlmAApqk8g6Pxgo1Ngax39zr4OhbJ
         Jw+qGjGRsOofNnwPUsdy2R8epkMkQWt8Ie/NpXyCFcd6aFROHl8ZEHS0OIBI8AP1NG+J
         2X9IrP6HtnyHnAu39yW56UpSqq6hrZ2OI+5z2HkZlagtsc8Vt7kVNLluICtnfoL/BdCx
         HG9rHoLExR8S3kWPRBGanrdENDBbQeaLf5DTieVAzLOUFccx1yZBV/9PzIYC/pljKIf8
         3+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/b4PlwxeP2QN4jZJPRCUuw530f+oAMFiERG4rj/EFOU=;
        b=rv/dqhrGYVOHT6haIkl3Pz97pb8SjQuIc5Ana33rkr1WoGfqj25MzrGOtDDUcPMSg1
         +Ibxb11Dbqffjsgdrl8CZox6qJjerx8rySWlSNkAp2C+2OG241Dj0GZHEBdhVnRl9YWF
         AtuObeZtjABVDXChYoU1kSIaAd7tfDum6lQ6d8WBtJZKusTtzS/XyuyNEcKMwG6CeDrc
         ScTAP2P1kqycIeRun/5wSM8icv42vJbePF9/xO/nm1Fu0/yzyYTRCBi8Gqellfv7eBQi
         qEm3EUCORsM3EjTJSh0JBZAruwVS+jPM2adPxsHac9DnZ355sm0+kqc6lFsYVzVr1Nmf
         gdIQ==
X-Gm-Message-State: AOAM530fxC03urlaWVVkk92xZdQg2jk1TOevoagdMKIki2Md7+MRwPnp
        zhR7xJrHxAawDGLlQ8vg/ak=
X-Google-Smtp-Source: ABdhPJymZJaAG6iK8rk6VTmbVcTXlqdX94dLNUJfkHzsI39JJC1B0LOSzvtXV6qUC3J7GB3Fxl+4fg==
X-Received: by 2002:a05:600c:2d56:: with SMTP id a22mr11476861wmg.175.1619034426954;
        Wed, 21 Apr 2021 12:47:06 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id c6sm13004217wmr.0.2021.04.21.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:47:06 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 3/5] drm: drm_bufs.c: Adjust end of block comment
Date:   Wed, 21 Apr 2021 20:46:56 +0100
Message-Id: <c3a261994b88f6fc39f69ee8c1af8ab115d76a87.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new line with */ on the last line of a block comment to follow the
Linux kernel coding conventions.
Problem found by checkpatch.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/gpu/drm/drm_bufs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index e3d77dfefb0a..731a42a31c44 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -325,7 +325,8 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 		/* dma_addr_t is 64bit on i386 with CONFIG_HIGHMEM64G,
 		 * As we're limiting the address to 2^32-1 (or less),
 		 * casting it down to 32 bits is no problem, but we
-		 * need to point to a 64bit variable first. */
+		 * need to point to a 64bit variable first.
+		 */
 		map->handle = dma_alloc_coherent(dev->dev,
 						 map->size,
 						 &map->offset,
-- 
2.25.1

