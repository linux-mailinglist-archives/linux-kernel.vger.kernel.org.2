Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C940E32BE93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385857AbhCCRcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbhCCNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:52:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486A3C0698CF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so23757915wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZJKNhLRXc9aoEUlg60mpCU3bbdn2u+HfyOeJ90k/g4=;
        b=IwKQ0n8S1aPrrgbMmJrQkxt9jO0zGLong8mRdLUcm4bLTCRQCscWGXmbesP2pAaCj1
         KVQvWMt7U2Bh4XLHxlmDHJdRw510PtfXw1U0vG3Js+p2DL0DRvmm8YKtfVuQS5Us/3v+
         Id6LAkTfKW7yFddEx3M0+VzuBlePAZ0t+pzxJb/fRVoewrv5/U7PzFAwW4vBzmlsFU/V
         KZW8MFmUxaJ8fVujnwvdDa/2ht6IQ5yvOcXqYsljYx1sV1tKc9pKecEr5Chw8INcqHi5
         LBvh9ixQF6gSYz0Qxw/b1aCqym2pCLWTi68wISXhKkqlXr2+hgcyf0bFjPuPVOs8G03E
         6FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZJKNhLRXc9aoEUlg60mpCU3bbdn2u+HfyOeJ90k/g4=;
        b=MiL/0H0HnYcQNWcFhqzSYfuz2JDlA7J5RYA+Jwr1OuZ2yFoaTKFuDpD7szdmNyEk5j
         zXGnxz/ntRNMLdPwO2kfxMRdngtitTGeaQGfkg0v9dqBlxjptg/43gRv3lHWd6gAxbbX
         sSYsd0Mv1m8B4STrrJiZ+yNEzKTlBi6mNWyLVyuq+c8HDmFS81AozsVmiy8jYj5m5zPI
         lLGfTcKKh/UOB4A9BrO5I5VAGN2aKWS8h/QhFxtasgIZmlqZLw95tCWxD8QUW4DDFOQh
         /ZZbjr2FinmLnFx0vgTg+RftUaUph/FHtUxcHT3KiDkG4B7nZcKdXe2uv9nVzP/VN5ag
         gFCw==
X-Gm-Message-State: AOAM533ZFEpo7jTIE7l75v95e1jTno+k7cQ/g4v294G9/HgrvgJBrssR
        ePQ02u+7T+C0yobA20fKw6SOLg==
X-Google-Smtp-Source: ABdhPJwNpTbE4CpOl/WCCXL4tCN0hvpax+mSVBRm8rrn8WDuO4RzuyWynCmDiMQT7zoV4BLcbGV9+g==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr27653085wrv.209.1614779069069;
        Wed, 03 Mar 2021 05:44:29 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 52/53] drm/vmwgfx/vmwgfx_thp: Add description for 'vmw_thp_manager's member 'manager'
Date:   Wed,  3 Mar 2021 13:43:18 +0000
Message-Id: <20210303134319.3160762-53-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c:21: warning: Function parameter or member 'manager' not described in 'vmw_thp_manager'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-11-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c b/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
index e8e79de255cf7..eb63cbe64909d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
@@ -11,6 +11,7 @@
 /**
  * struct vmw_thp_manager - Range manager implementing huge page alignment
  *
+ * @manager: TTM resource manager.
  * @mm: The underlying range manager. Protected by @lock.
  * @lock: Manager lock.
  */
-- 
2.27.0

