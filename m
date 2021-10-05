Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52442317F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhJEUTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbhJEUTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:19:15 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016A2C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:17:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d20so458304qvm.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiKFws1LTfnXE8+X4ABwTgmNjXHoNfEwbCSS8ItVQas=;
        b=co4EnEkfrgrh7fi6J4fu/8uhxJYKeXyHmth9reo9jbIBZbS+fSN/s8x2BbsDKciN7U
         PKafyY2LqLULq3yg6bbKD/RzLNdPdqAxvt5+IwTSD7kmQWpCXtrjerrzI/RmwSuHpi5n
         thMYBJMtNrz/hx0XzHIZY8wj4wXK/EzXVBc+2hj8fjgy1fCv+WnbdoOGp0rO8oXUGD7d
         uQlaGj69Gk1I34xp3N+T7dDrgwi0J9fHHNiJns3abwigQAA+2dSc0+zBqPFSDwWa8z7f
         ll8aciJHLnIoJoWh8IL7AaN/oQdYnzjv3rbstXUaummgWw0AK3AjQ8wv66d/+Rn6zTMX
         GQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiKFws1LTfnXE8+X4ABwTgmNjXHoNfEwbCSS8ItVQas=;
        b=dC/2G3dFo7KYuhPoj90/cA1gKjbK0psHtFsrIRHv0NyaJWwk1FXlx0qC7x3dqGolyH
         hVJhjwbrPhxXU4vHV1OVa5D24K4Hr8v3D3Eog/8mbW/9cEpDDYU5oznOodWZcgxByMBE
         uMZ+ebFdZJz90VFrznN4nEDWrBJUc/ZjtmG2sNSWr72J9kSHBItddCRQE6X+49ppm6qB
         oX+v8bYD2mptmeQZLA7Z0iloRQWEfQXrbLnAH9KX5uEtG5ao3++ku0xbYawD5okPXnq4
         uxYw7FEssfpIceMgZfU349IxFjZvOUMhUtF7OwL49edhRY0l1wnkdoPWMeuWmZ5R9tlQ
         fAjA==
X-Gm-Message-State: AOAM532ZsvATrOHgL/4l5cfajZVU3C1VsssH+EhLa2fb29dddtnAc08Y
        vEdCQZ8nWIh/iJSPrliJJao3jlT/+JQaAg==
X-Google-Smtp-Source: ABdhPJykS5ENlYXTGS/IxtP8RHgN1eD8BM3QPEdDjOciJhZSrdbmvO+fYM+ubtj3euqoGI4Ag4zl6A==
X-Received: by 2002:ad4:4d07:: with SMTP id l7mr2128853qvl.32.1633465044206;
        Tue, 05 Oct 2021 13:17:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:9b98::1007])
        by smtp.googlemail.com with ESMTPSA id j2sm13056905qta.84.2021.10.05.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:17:24 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH 2/6] drm: vkms: Alloc the compose frame using vzalloc
Date:   Tue,  5 Oct 2021 17:16:33 -0300
Message-Id: <20211005201637.58563-3-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005201637.58563-1-igormtorrente@gmail.com>
References: <20211005201637.58563-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the memory to the composition frame is being allocated using
the kzmalloc. This comes with the limitation of maximum size of one
page size(which in the x86_64 is 4Kb and 4MB for default and hugepage
respectively).

Somes test of igt (e.g. kms_plane@pixel-format) uses more than 4MB when
testing some pixel formats like ARGB16161616.

This problem is addessed by allocating the memory using kvzalloc that
circunvents this limitation.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 9e8204be9a14..82f79e508f81 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -180,7 +180,7 @@ static int compose_active_planes(void **vaddr_out,
 	int i;
 
 	if (!*vaddr_out) {
-		*vaddr_out = kzalloc(gem_obj->size, GFP_KERNEL);
+		*vaddr_out = kvzalloc(gem_obj->size, GFP_KERNEL);
 		if (!*vaddr_out) {
 			DRM_ERROR("Cannot allocate memory for output frame.");
 			return -ENOMEM;
@@ -263,7 +263,7 @@ void vkms_composer_worker(struct work_struct *work)
 				    crtc_state);
 	if (ret) {
 		if (ret == -EINVAL && !wb_pending)
-			kfree(vaddr_out);
+			kvfree(vaddr_out);
 		return;
 	}
 
@@ -275,7 +275,7 @@ void vkms_composer_worker(struct work_struct *work)
 		crtc_state->wb_pending = false;
 		spin_unlock_irq(&out->composer_lock);
 	} else {
-		kfree(vaddr_out);
+		kvfree(vaddr_out);
 	}
 
 	/*
-- 
2.30.2

