Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768B2423181
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhJEUT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhJEUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:19:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE47C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:17:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t2so322623qtx.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLpOU2gtDlN/t3YQqeM1ZuC76+nni+Jjgvk3fLJVQKY=;
        b=RwfG7yaYvor7iaI3TZc1YwftZ27vcx7i0037yizes8DSPwQ9lcL5MSDT9l0mqhKyDH
         iDX1hitbLAWnMbfQmw3tbHYlmxNMNVkmvzVUIzny978etjMoJ3e1qWgFHkDRtt8JwXA9
         i47D7HgfjzL2YD7gkhYn/54tIbtcy4aBVkRJGWDZ/OgtY57gOYWOUPAELR/PDh4hoxku
         eKZe0ahF45G8hlDXaxhqw58JImQGwL1d6aFoHNYUuUmFzpk2SRailTLrmUqbTjYvMn5c
         Ox7Kvr29srBP1p5VHj5DAZKpqPg7TfoAx1VHqBDbTlrRTnoDx1ctxptAu85c7Y7chNTL
         iO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLpOU2gtDlN/t3YQqeM1ZuC76+nni+Jjgvk3fLJVQKY=;
        b=Zyt+uCbB1m74MJKzPiWboSzpa0ISphEu/PZrbSHWQxcVyWrWTmneqpBaLq+Jq5xPiQ
         x9ctfmH94eWP+IBVjbHqjxxZasdRZ2UG0i5pmYzMz5Yej7Ok1xmgVW2kmL4o7NrybkQ7
         ZwShgcNCKYUMu6ymf2Mue4loFBTrcB9pNKADvsidMaoFnGgJN472TJghL4dTqbrkq4N6
         Qyht9FmpHgcfktbC4EcYcX55Yx7bEPfnjJ0FEpsKt6Tbu7gLJg7qv22XfGZhaUb8oqnh
         vrCuWTd99Feo7jQdaEavQRFSmPCKFD7cZeLD77dtnRmeWlQmTxJTt+AyxO6iF6cUzp6R
         Plvg==
X-Gm-Message-State: AOAM531By9YT+lnFr3QNH59juplVRwJBAEgZJTNTclckH21t6LMtHUkO
        MQxTpZTjpqHlNzsG2C4B5pw=
X-Google-Smtp-Source: ABdhPJyctVOHylaCsucvT+4OfzMwlJtBm8lqPYlWmlvb3RV4i5pAD1BpFisEj8qbW1OkcJN2waEaMA==
X-Received: by 2002:aed:27d9:: with SMTP id m25mr22303427qtg.85.1633465048127;
        Tue, 05 Oct 2021 13:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:9b98::1007])
        by smtp.googlemail.com with ESMTPSA id j2sm13056905qta.84.2021.10.05.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:17:27 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH 3/6] drm: vkms: Replace hardcoded value of `vkms_composer.map` to DRM_FORMAT_MAX_PLANES
Date:   Tue,  5 Oct 2021 17:16:34 -0300
Message-Id: <20211005201637.58563-4-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005201637.58563-1-igormtorrente@gmail.com>
References: <20211005201637.58563-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `map` vector at `vkms_composer` uses a hardcoded value to define its
size.

If someday the maximum number of planes increases, this hardcoded value
can be a problem.

This value is being replaced with the DRM_FORMAT_MAX_PLANES macro.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index d48c23d40ce5..64e62993b06f 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -28,7 +28,7 @@ struct vkms_writeback_job {
 struct vkms_composer {
 	struct drm_framebuffer fb;
 	struct drm_rect src, dst;
-	struct dma_buf_map map[4];
+	struct dma_buf_map map[DRM_FORMAT_MAX_PLANES];
 	unsigned int offset;
 	unsigned int pitch;
 	unsigned int cpp;
-- 
2.30.2

