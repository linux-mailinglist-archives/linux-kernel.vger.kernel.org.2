Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0593D475D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhGXKiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhGXKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 06:38:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ACFC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 04:19:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so7299640pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YtTx2F8aCtjxUTXqe0aUtd1QKwb/HSkiydeejpIB4k=;
        b=DvPcmCPEmDyLe3TGFTP1QJeVA2WB+aAXO8mtDMt92/tIWfVwoxyj/t+ohBnZhllumo
         FE8nIVjaonsiw5dBGIuKHq5HwvCS+RUy7HQLPgjUJ2OG2ki1X2sPyNz9OTIz5RDCj/Q0
         TULtxmO2p7V7NaIniuhDYieJ05ETRDTZNH06S96TDnJAYDgnwUyK56O6hTnJIBCrZzbz
         oE2sV1ptouoT+cunTJ6XEJvbfVFqHx6uyfCFZdyW/zYc0CLRjOcIxxstpi8unewZ8ZMw
         CcMBMYraxUKiFmoranTvKMp1CVTb6CaPaHx45wcC25uTJLdvQmxvvr3oWnzD4gXSggTr
         5YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YtTx2F8aCtjxUTXqe0aUtd1QKwb/HSkiydeejpIB4k=;
        b=DeDuFVo3p09VdE10e/GFezQBWUh5NQZq1hiERu2PqARXfkzzJo+9/Qm+jqWxcwDK1d
         p7NR6pr35fVJ/w36mqY8Kf7XTZsq703xirGZVCHtQJju069t4AQat62ZHRjtLXLHmUdz
         PpgFYs72Ch9hF3Uy4sh1BMv8632KUYWBvGG/MQPsGlOW8togXC7f0RG+e1PABTIrKGfI
         KBQ/rz6BIPQt7mq9h4vcrJFd3czW09xSG/aznYc10tSRb8KYSSiXmJMdOYpPfWrbVh5i
         JETmOP6cBntlygVBYOYlqhKtiZJLVaOKh3sDyfugDlc1GtaEfzveA54eOfkh9PO72g2e
         qa0g==
X-Gm-Message-State: AOAM533VcqfYUhWfqNGpRSRldCFNLxvGpiB4amt95jE1fdKtLC/augWD
        Y5QcPG6xYxyZ2eziz8N6b28=
X-Google-Smtp-Source: ABdhPJyrONu1cda28NLCVz+hXTIkL/SdYozfXqjGTiFBPvzVDezB4CPrSnB9KOd278Mq2Mi/gub3UQ==
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr17424928pjo.97.1627125556886;
        Sat, 24 Jul 2021 04:19:16 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id v15sm21310057pff.105.2021.07.24.04.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 04:19:16 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 1/3] drm: use the lookup lock in drm_is_current_master
Date:   Sat, 24 Jul 2021 19:18:22 +0800
Message-Id: <20210724111824.59266-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724111824.59266-1-desmondcheongzx@gmail.com>
References: <20210724111824.59266-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside drm_is_current_master, using the outer drm_device.master_mutex
to protect reads of drm_file.master makes the function prone to creating
lock hierarchy inversions. Instead, we can use the
drm_file.master_lookup_lock that sits at the bottom of the lock
hierarchy.

Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_auth.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index f00354bec3fb..9c24b8cc8e36 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -63,8 +63,9 @@
 
 static bool drm_is_current_master_locked(struct drm_file *fpriv)
 {
-	lockdep_assert_held_once(&fpriv->minor->dev->master_mutex);
-
+	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
+	 * should be held here.
+	 */
 	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
 }
 
@@ -82,9 +83,9 @@ bool drm_is_current_master(struct drm_file *fpriv)
 {
 	bool ret;
 
-	mutex_lock(&fpriv->minor->dev->master_mutex);
+	spin_lock(&fpriv->master_lookup_lock);
 	ret = drm_is_current_master_locked(fpriv);
-	mutex_unlock(&fpriv->minor->dev->master_mutex);
+	spin_unlock(&fpriv->master_lookup_lock);
 
 	return ret;
 }
-- 
2.25.1

