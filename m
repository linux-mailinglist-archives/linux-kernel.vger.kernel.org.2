Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877EC34176E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhCSIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbhCSIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq27so8274773ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3+jQ9deg+F+hwlthzV/g98whTMSIMZPgh43ftXDf7Y=;
        b=OnTiL+kaW2zPMVdE6HXbsGxQ56nJJiDEZgsDJm5nTCAM4F/hYTuXOK2NTbkdhYGdNn
         UZMIHFqal4fYkP7086YR1KXfPAi/0CN+sG8/46L+IAM8dNP1vslB5d59gCck8HYzsxBX
         8OThjxGNbudGNQnMUlKQnrHaV4SeVJNDrOTuMKO2LAtp6PnZ9U75IsnFx32iuV4wLwfR
         XWhNw0uh22NIzQJ2aYGDTtCC5F6jAkh2TdHE5uwhbYDJrmsIshJDfYDky345zQdyg1hr
         76QZn0QUO3HPNj3coc1puorPSUkz0ygttAur5sEkxr6gt0JwQXwqn3E7UHaUJ0x2BUI0
         zBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3+jQ9deg+F+hwlthzV/g98whTMSIMZPgh43ftXDf7Y=;
        b=J5fJKtfUuVimeNejmRXr6o8BFgWdgD/ep7ilZDz6zgYnteNrqVQp/rIQ6TBC8EiQw4
         osxIC08AJEVpzTHiGbn6Yv3Sdg9Q0uh5IvPJpluUu2U3Nf9emfcu/8kOY+k2zXp5FqS0
         nNjA+WklirrtWsOeMTZki2g6AaXoQkuvJ0odwkNUVYvkatNG+Yon03Hv8Hszz771WnQ1
         Xe6VMpGB+GiZMz3Phv2yF4Y7uZR+slQtSFCQav+6FNHo83tlWUapOSoZ7VjedhldM6Lo
         DiE6vcnY3uhUZk+iDvWl24UA1cFcHo6/6W9Wic/bs3y857oDGB9LhFO4zvM3o7COCehA
         uZ2w==
X-Gm-Message-State: AOAM532QdDGz09rNdxjE0mafwhPgGHpy2LgBa5YYl0qHll8GpJ85i0Xf
        4qC3n4GmeXRS+sSI8IJ3hyXQxQ==
X-Google-Smtp-Source: ABdhPJzRvstPWZ77izvKn3KAab+DmdytKTVll16/lNiRi658rs93jLltp05EkycgqyLl7Df3JOnGwA==
X-Received: by 2002:a17:907:2112:: with SMTP id qn18mr2967233ejb.220.1616142281401;
        Fri, 19 Mar 2021 01:24:41 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 09/19] drm/nouveau/nvkm/engine/gr/gf100: Demote non-conformant kernel-doc header
Date:   Fri, 19 Mar 2021 08:24:18 +0000
Message-Id: <20210319082428.3294591-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:992: warning: Function parameter or member 'gr' not described in 'gf100_gr_wait_idle'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 397ff4fe9df89..69e6008f99196 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -982,7 +982,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
 	}
 }
 
-/**
+/*
  * Wait until GR goes idle. GR is considered idle if it is disabled by the
  * MC (0x200) register, or GR is not busy and a context switch is not in
  * progress.
-- 
2.27.0

