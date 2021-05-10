Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B328378EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbhEJNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbhEJNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:18:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660EAC061352
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:16:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v13so9106474ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ua8K1EdEgu+P2D3MHGhK9KL8rinnu1K5br5+Hr9m6Y=;
        b=RDUoseO/yhqyEsZbGXXurk2NNaM/ZRrpkxCM8aTex4vRWf70nD8z4zCqKTqj9BdJ3J
         TpogAD8aGRQgyXqm9oZwLxX/GTPoWvcy2iHT5JGjsAr8MwAHnjeEG8/8lzKQCGrJQ2q+
         vJSKUcWLCw3XcfELal3+gMlrMYx2MAKyiJRuarV1076vTQ4zy9oiW6paNVc5vz+PiK+a
         1kpGJiWyb1NaBlpDi0oZ5QBKzPsq0D0q8UsMaduK9798eOQcKKFAZPu9nBU7Yw9BamTi
         Bg+okM9q3yJwpxrOJP0GCKwMfOAWlZtFZ3TRcAgRGDhlc523Ca99+2CCq8NeXyHiX1j/
         mFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ua8K1EdEgu+P2D3MHGhK9KL8rinnu1K5br5+Hr9m6Y=;
        b=Px4e1kDY4aXk5Vfs4GpD4J7q1g7hov9Z6RuxiEj9fa3Mgvf/bjWSU/OGsac8KvWfoL
         uCqyI32byXtYa+jLSURGP2GPJBv499tQCoTiXVaOoRdcrYhjr3vUomACjzzve+7mrZaJ
         vcHoI92aIFR7urUDSqL+akcb3/5ZpIr+X4udiEvDx7o7VBm+lw1P4tuuu9Mg4OWDB0Jn
         ttUp/sfRONUjabXdmb8J0kLq7lP4TAPPD0hJ7l21WO/UunE7xtT1v0+DcqzhZio5RumS
         egnSPyXk1drcez0keWVSLj7+ZZyhm4t687ubzuNlCPTeZPfx58JnA8vx9YexhyDVLv2S
         eOlA==
X-Gm-Message-State: AOAM533Nbcyn8U1kAzo028S9l/Joaq7PSVjtxOtdgE9GYGAVXCNTBL5F
        7MPJZ2ytBPo0FXwFTC1kcm4=
X-Google-Smtp-Source: ABdhPJzsBsSQPk9E2Ceyd+G4hkbvWXHGgfT2Vt+wSorlF942NRObmE0ekpytDqr8raVf/gs3421t/g==
X-Received: by 2002:a17:90b:3686:: with SMTP id mj6mr41167040pjb.116.1620652614991;
        Mon, 10 May 2021 06:16:54 -0700 (PDT)
Received: from novachrono.domain.name ([223.235.208.114])
        by smtp.gmail.com with ESMTPSA id u1sm11320991pgh.80.2021.05.10.06.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:16:54 -0700 (PDT)
From:   Rajat Asthana <thisisrast7@gmail.com>
To:     mripard@kernel.org
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rajat Asthana <thisisrast7@gmail.com>
Subject: [PATCH v2] drm: Declare drm_send_event_helper static.
Date:   Mon, 10 May 2021 18:46:16 +0530
Message-Id: <20210510131616.544547-1-thisisrast7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510123243.hmwar3swmrewskjs@gilmour>
References: <20210510123243.hmwar3swmrewskjs@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare drm_send_event_helper as static to fix sparse warning:

> warning: symbol 'drm_send_event_helper' was not declared.
> Should it be static?

Signed-off-by: Rajat Asthana <thisisrast7@gmail.com>
---
Changes in v2:
    Provide full name in Author and Signed-off.

 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 7efbccffc2ea..17f38d873972 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -786,7 +786,7 @@ EXPORT_SYMBOL(drm_event_cancel_free);
  * The timestamp variant of dma_fence_signal is used when the caller
  * sends a valid timestamp.
  */
-void drm_send_event_helper(struct drm_device *dev,
+static void drm_send_event_helper(struct drm_device *dev,
 			   struct drm_pending_event *e, ktime_t timestamp)
 {
 	assert_spin_locked(&dev->event_lock);
-- 
2.31.1

