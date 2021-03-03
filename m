Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE832BE64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385662AbhCCRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359153AbhCCNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570AEC061225
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n4so6385703wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3+jQ9deg+F+hwlthzV/g98whTMSIMZPgh43ftXDf7Y=;
        b=Lt9BZLEKeX6vZm5O1anyCQVHXnHAylqWnmLnxySRpm1uwZYBNJrww3+26dI4sP4eTZ
         3zZSDTnpns8MDlaOgJfHoN6qh+cm4BiWZzB1zBpqrWLL+E7kmxRHVKPXKqHib53fQIiD
         vhgBOjv906Y8rlLoQzee6gXFbwV4KGSgzl83yL9lO2lzIb4ewpLRrwJzPyeFn8nJb88x
         GM3CPy0U1XHTu697oiHMzETTXMJZjVYfe4oMQpLdhMuQ2LTsEoaqGxNeZLtU5stvUbeQ
         dlSdbiTfPzFjWFK3xqPiapITv1hmqABmayWWM7trUot3POqVeapO2PX4C25ehIPmg3ez
         rvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3+jQ9deg+F+hwlthzV/g98whTMSIMZPgh43ftXDf7Y=;
        b=N4ia685Iac0e02HDaCq+50Dg3Kg6KBVpOnKQ7xWkXsc1mhvOiNijDbAK94Z6ljWAnE
         hl1fs+P6CwmolR2uxI9VWhO6sARf6PsLfY8R2dj96fAh8su1gGspgsEvmLdu718xRZ7I
         8EmdPn9cHxLJ7fX3Kv7aOkG5gIQI3nKOl3f8N6rDe0QjiZv0vvpsEmxI1GqsQ9H2jQf+
         jHYo8RVaSfA7IAu96k4AiGKapoIfhVEKSKRAkKRjrBe6DKl4gN4Hn1guh6uxmqq/c0pk
         rwNRmdWWeZpQm4QaM6eTr1MNVsp8qoGDN5/OCYaKeBuVUcgQ6TXpf/M53dBXgZ/eQcbK
         VmrQ==
X-Gm-Message-State: AOAM531tOoAAHk6pVerLvcopwGZm0CxDsJDW7MHEVBno8YzcjIC5D4Ll
        FbOaZc6kIYMMmO9fEJFVJA7SWQ==
X-Google-Smtp-Source: ABdhPJxnR8YWXV0kvaiGo4Fnh/JzG/G0i6PnEYHzmg21U6zym4qPrzBpBFNjcyj/LMiLGdnMfETvwg==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr9540066wmq.159.1614779023095;
        Wed, 03 Mar 2021 05:43:43 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 12/53] drm/nouveau/nvkm/engine/gr/gf100: Demote non-conformant kernel-doc header
Date:   Wed,  3 Mar 2021 13:42:38 +0000
Message-Id: <20210303134319.3160762-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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

