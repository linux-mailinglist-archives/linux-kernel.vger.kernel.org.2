Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98B73776CF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhEINo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhEINo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 09:44:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F8C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 06:43:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m37so11427583pgb.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ea5k4FOKx4SMEkuXC1Eve5YR4n5XkljuOnwvabyNaPs=;
        b=BtrreVjY7vVCqohnNnwGhZSGhbsdXm+mpP2hc9FNjdhxfCex+w25C/0qIaEXz9Dw46
         XYvKLE4otXOMZoboa0kMz8lSyZmC8bkoNuk84wQPtztCDYGeRvaKZzcQHneeLipM/Zsl
         4v8U7MQSYaKASoWlWy6Ski671jjU+RoxyYytNkAdchNzqk06Dt98HJvxddTDJQaCPVT8
         8RhfSSvCW/kydHCMAuiMLI/qSmnzHAEZsgaESDwXPiGjSizX5ssDlODsFjO3i/uOAQxI
         Mx7Xz7JY4s3/gpGY01ijtuZqLyT8QD8dmCbBtx74ks6xcjLmW/M0OOEtDdMUg6Zks1hq
         8weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ea5k4FOKx4SMEkuXC1Eve5YR4n5XkljuOnwvabyNaPs=;
        b=H4YxOptZ78T0VmnAMMuhWZa52epvKSt6JnjcfECcGhIPN0Z8Zm02UbMaGEwy455qoG
         ytYnAYGMQ+mhkXXxijUPYmcx2j9/oWdtn44WHu//uv6pWD2E3KZjKqpHqDdE1dA/TxOE
         AAWrCjcn1/rPAky3A3P732WAdR+HUBE2ljrQFaQO2i7YnVm04ZbbUqq3C0PRnt/eeATd
         FhOKxCIuoI72b64xOS83Xws9Lv2ANEgHzFfjhSj9U0agA/92ddpvfYmqY3aF9NiMpf0u
         4KetZmFZw1McSbXya1VqPvuFAsheMoGjBbjqtYSyUUFcvXKLC4+WgBje9tEDeVsnT/TX
         cCgw==
X-Gm-Message-State: AOAM530qUn+X9XrlGxQSSgF0XdF+DxohXiDBs7F03phqNoNOYvPje+D2
        /dLPd/TAWq3D30NWl5PDPRdM3uCrod9cCX7R
X-Google-Smtp-Source: ABdhPJwJqX5qVu1IBdKJD14HhHbw5xqUr7ouCvj9UYb2ojFD6cANJ0mWNtSmp6YWr7uKVI1UvpBvTw==
X-Received: by 2002:a62:d411:0:b029:2b5:fce4:7e64 with SMTP id a17-20020a62d4110000b02902b5fce47e64mr5797927pfh.15.1620567833038;
        Sun, 09 May 2021 06:43:53 -0700 (PDT)
Received: from novachrono.domain.name ([223.235.208.114])
        by smtp.gmail.com with ESMTPSA id i123sm9289433pfc.53.2021.05.09.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 06:43:52 -0700 (PDT)
From:   Rajat Asthana <thisisrast7@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rajat <thisisrast7@gmail.com>
Subject: [PATCH] drm: Declare drm_send_event_helper static.
Date:   Sun,  9 May 2021 19:12:52 +0530
Message-Id: <20210509134252.488157-1-thisisrast7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajat <thisisrast7@gmail.com>

Declare drm_send_event_helper as static to fix sparse warning:

> warning: symbol 'drm_send_event_helper' was not declared.
> Should it be static?

Signed-off-by: Rajat <thisisrast7@gmail.com>
---
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

