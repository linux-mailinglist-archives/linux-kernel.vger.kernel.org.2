Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD8367398
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbhDUTnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245482AbhDUTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:43:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112D0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so33464931wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9YyDbXYbo/3ZkbS9vnMcM6O6QITgJOco3N63Yjdcu4=;
        b=R5lT7KlW09JoVMcjFqoMiMID8trNeIRJeuiU5SI2eCwg8yStG0uKB3CAvFRsEDB7Ci
         OifXxx3vlT3J5HEQLE8b6o7AVDH3tE0ev8kyNbSeDu/1Pd0z6Dec2fusd8ZGHJRYJv48
         9mFO/Lhg0/oz5Ka0TdMCVuW3LAwDLS4kcLpmX9wiQPD10lGwPNaaPzuqhmeVsbsSCET0
         CN3rsDYR4E7sJBLry/q7foKe3J45lE8YqxzUOy/Av12h5UnQmYIPGlpUQRR7rp2t9h0r
         oVzEP5mVg49yI8BXpCmUc+DIBZTX2P+Fcn5z07G84fY/mLrOoLdErASE0V1FvlNobCOz
         L13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9YyDbXYbo/3ZkbS9vnMcM6O6QITgJOco3N63Yjdcu4=;
        b=X9LrL2xRSGep72gzUgprHauf6Wu1fMCfE5KCUwS/vwjWWHgGCbCxwKWVnevIx+ou+5
         7xphkPUtsv+xE5FnTcaHOdJVZo6Aa1VujA5XEhpDtgpBBVDYrklztKOO0bGAJw94QXuG
         nOyKPyUc7CNSZT3lw4mZEvTa0+2poNc7X2LrJ+WltCpWlBJqcVCk4ZUzecJLDzU+rgO0
         qGKQU3zsGwgrdT8Uag+DPZCOLS+MX6ZG2zrz8XhNi7EA/yx9uQ7V4TlFMzr9mkd80xRQ
         U55mwEqgFPZGOkYtVtO8uJuLwpEYTsKuMAX7xqGFfu2e4ktmyCxA5taKqxfODKKd++LZ
         6kFQ==
X-Gm-Message-State: AOAM533uwxBMO4UshnmZGSPxyY7/mKz/HJ+mkyLIUqxWsQcdem9298RD
        9U9kn8IWSx1LGglXnFkqPO0=
X-Google-Smtp-Source: ABdhPJx59Ihii72tQbBOF8SKCYEdKYUyDEqSZFT+yDTqevDePXP9MKA20iQzUl8vP/Wbv45uB2Y7TA==
X-Received: by 2002:a05:6000:186d:: with SMTP id d13mr29115281wri.199.1619034177847;
        Wed, 21 Apr 2021 12:42:57 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id o4sm484163wrn.81.2021.04.21.12.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:42:55 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 3/3] drm: drm_connector.c: Use tabs for code indents
Date:   Wed, 21 Apr 2021 20:42:49 +0100
Message-Id: <0200474fbdb1149856308bccb8e467415f0b3d99.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove space and use tabs for indent the code to follow the
Linux kernel coding conventions.
Problem found by checkpatch

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 38 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 7631f76e7f34..38600c3a6ab2 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1958,11 +1958,11 @@ int drm_connector_set_path_property(struct drm_connector *connector,
 	int ret;
 
 	ret = drm_property_replace_global_blob(dev,
-	                                       &connector->path_blob_ptr,
-	                                       strlen(path) + 1,
-	                                       path,
-	                                       &connector->base,
-	                                       dev->mode_config.path_property);
+					       &connector->path_blob_ptr,
+					       strlen(path) + 1,
+					       path,
+					       &connector->base,
+					       dev->mode_config.path_property);
 	return ret;
 }
 EXPORT_SYMBOL(drm_connector_set_path_property);
@@ -1988,11 +1988,11 @@ int drm_connector_set_tile_property(struct drm_connector *connector)
 
 	if (!connector->has_tile) {
 		ret  = drm_property_replace_global_blob(dev,
-		                                        &connector->tile_blob_ptr,
-		                                        0,
-		                                        NULL,
-		                                        &connector->base,
-		                                        dev->mode_config.tile_property);
+							&connector->tile_blob_ptr,
+							0,
+							NULL,
+							&connector->base,
+							dev->mode_config.tile_property);
 		return ret;
 	}
 
@@ -2003,11 +2003,11 @@ int drm_connector_set_tile_property(struct drm_connector *connector)
 		 connector->tile_h_size, connector->tile_v_size);
 
 	ret = drm_property_replace_global_blob(dev,
-	                                       &connector->tile_blob_ptr,
-	                                       strlen(tile) + 1,
-	                                       tile,
-	                                       &connector->base,
-	                                       dev->mode_config.tile_property);
+					       &connector->tile_blob_ptr,
+					       strlen(tile) + 1,
+					       tile,
+					       &connector->base,
+					       dev->mode_config.tile_property);
 	return ret;
 }
 EXPORT_SYMBOL(drm_connector_set_tile_property);
@@ -2076,10 +2076,10 @@ int drm_connector_update_edid_property(struct drm_connector *connector,
 
 	ret = drm_property_replace_global_blob(dev,
 					       &connector->edid_blob_ptr,
-	                                       size,
-	                                       edid,
-	                                       &connector->base,
-	                                       dev->mode_config.edid_property);
+					       size,
+					       edid,
+					       &connector->base,
+					       dev->mode_config.edid_property);
 	if (ret)
 		return ret;
 	return drm_connector_set_tile_property(connector);
-- 
2.25.1

