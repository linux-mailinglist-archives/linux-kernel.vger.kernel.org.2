Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF11423185
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhJEUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhJEUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:19:34 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB72C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:17:43 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id a9so510549qvf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hw6zQBB3a/F2ZAgG/KXWLByNsFS27rGehUO+SIvRQ4Q=;
        b=o9CDrrkODu+wta3WyPeh0D3N/zFw7tVgLZKNGjEHDkWJknzmsPiuQNguvSgXowtTfV
         /N2hv+AzfyBtt9LT6zfyPLctDdAuQLCQUzo3SkEu7blfSDcKT5nNY9CL+HpTPA/oFOuW
         fxGGsmUSY7zb3OKPsP75JlmkQMvG8Z/IqIleMgIF6KeSq015G74aY+dQr7lo0WQSAWnr
         eSrNyqCHhU6RNYVL28Wj2crxyNWzlQl9NKBkyeqyoOm/qONpiAlaiDWeFcqRqHtTYoSM
         U1SE0Ak8TxIteLUZMEvG/SVoUxJ9uMFX0eGUIKDUnNu5Xmw56I4TdEuYoaHRKQ/CTzjM
         un8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hw6zQBB3a/F2ZAgG/KXWLByNsFS27rGehUO+SIvRQ4Q=;
        b=m2XqgyIUPuFqo0MtGSyJ+YIIUYGEeOzpxdq89oq99PEysIsNWn/AT6LsAkO6YR6igU
         lULVJsdEPdj5R7G0alNjDIQofcpddAvV17jCCuZtWw5vXB6ZyZv504C4TIB9AxHyqQms
         qIqdt3MEHakk5YwV/C3LGkyWlgQF9JbtGJX58zG3kt5ppIstC7gTOLXLai7cuozdx3+Z
         djBYJljqMrd9Z7f5Pw4IrdkHbnYWurevThheyzWPQPvHGYMySM+wa4GejtULJHmRG2/U
         YoeogKXcr2ui8RfcVtMC7TCXJKDjq4aDsNgTJ4TgDxOJLiV3FbxdbBZlPGmoIwDVsxzz
         uShA==
X-Gm-Message-State: AOAM531orkKFYa97lFNoMgr42kySDuGyIncQyTNtcElbjWHfql53FP9u
        Ggw+pjxC9KldDSNqeomLR4g=
X-Google-Smtp-Source: ABdhPJzTpcgNw4xSMuq6xHMghK3hfM/f1yxE9eke26u2+bu+JQuPQWijqS4vmVLi6Fot9c37dfrZXw==
X-Received: by 2002:a0c:ea90:: with SMTP id d16mr24485qvp.18.1633465062843;
        Tue, 05 Oct 2021 13:17:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:9b98::1007])
        by smtp.googlemail.com with ESMTPSA id j2sm13056905qta.84.2021.10.05.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:17:42 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH 5/6] drm: vkms: Prepare `vkms_wb_encoder_atomic_check` to accept multiple formats
Date:   Tue,  5 Oct 2021 17:16:36 -0300
Message-Id: <20211005201637.58563-6-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005201637.58563-1-igormtorrente@gmail.com>
References: <20211005201637.58563-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the vkms atomic check only goes through the first position of
the `vkms_wb_formats` vector.

This change prepares the atomic_check to check the entire vector.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_writeback.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 5a3e12f105dc..56978f499203 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -30,6 +30,8 @@ static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
 {
 	struct drm_framebuffer *fb;
 	const struct drm_display_mode *mode = &crtc_state->mode;
+	bool format_supported = false;
+	int i;
 
 	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
 		return 0;
@@ -41,7 +43,14 @@ static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
 		return -EINVAL;
 	}
 
-	if (fb->format->format != vkms_wb_formats[0]) {
+	for (i = 0; i < ARRAY_SIZE(vkms_wb_formats); i++) {
+		if (fb->format->format == vkms_wb_formats[i]) {
+			format_supported = true;
+			break;
+		}
+	}
+
+	if (!format_supported) {
 		DRM_DEBUG_KMS("Invalid pixel format %p4cc\n",
 			      &fb->format->format);
 		return -EINVAL;
-- 
2.30.2

