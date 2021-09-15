Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE86640CAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhIOQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhIOQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:42:01 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F2C0613E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:41 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a15so4272923iot.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qA3NUvyu2tGFNX7HOAxu/xgx9RqpGEBzMRUtatJOsnY=;
        b=ZA7WbZMWdvlReOmZg5VAjoX3Llx5z7hhLnLehyJPA1dIdO3kXdcH5ktrqlZ2b8KTBg
         3ynx0SaVeDQ6zclboCS28vdU+vSenXA6WhQBLGos65K77G6KmTc5X7H+HBFBIGRP+Lyh
         6muVwfzshVOY/bsII5VbXeNGBZL32D4cioswF/DexD4NAJIZOgLe4PXJ2+eEV6uRqi2B
         YR5FtuMGO64M95epTyJFHBY86Ao0Ou19/wiXvGI/0xZ/am4GcYEBp7cLlC+IX6N8bMm8
         11bp/+gIxqDZcC7OLOMdzXx+l4lyxqKSc9d/6vJmXWddynl8EORL7Iw1mW4V9qjdFA+8
         2F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qA3NUvyu2tGFNX7HOAxu/xgx9RqpGEBzMRUtatJOsnY=;
        b=RWtFczdokQSCqNGbQtUaePo6DX7fhRzvvEQjLZFYZrvsWEPibgX7VxIn+KbW+Unjfk
         yx/xlOGsPN7LkZZwp/9LM+igSoWhrJA71tCbsMDbkDLg0v/ndp5Zz7GWeMuHkIquiTH3
         Wu5km2t/POWakZYZs+uPMw7r8U6AgI1MUrZl3/OBYo9GDzF7LG2jIPX3VVW3HduXBgBm
         0Zg7V97jAqB5TpaS8DgVO+qzUI6UKd7wgv/yeQfBv75LRrgchovrzsux0S/GtCDs/clR
         mnD3Rh/SwGv1t3LZhGpV2o9Hws/aognP+5SjmoyizlpnUgomqo6QxIkT/+Jrx/kPNA94
         lM/w==
X-Gm-Message-State: AOAM533XIXDN53XZa8RhpnKkBa4VYn2xnX2F4vVJu/Z6o1bijbdWGizd
        H4u4i7zYjmmh4w4bAjxyvAQ=
X-Google-Smtp-Source: ABdhPJwiob+KURo47U02bjMK4Ia5YLfcFSgmPIO+vMOvLDaPOh5EBN3EFlEEzVGCYJDWJrkIrZAX/g==
X-Received: by 2002:a5e:d80a:: with SMTP id l10mr801842iok.36.1631724040419;
        Wed, 15 Sep 2021 09:40:40 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 09/16] drm: fix doc grammar error
Date:   Wed, 15 Sep 2021 10:39:50 -0600
Message-Id: <20210915163957.2949166-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no code changes, good for rc

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b439ae1921b8..ebb22166ace1 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -522,7 +522,7 @@ void *__devm_drm_dev_alloc(struct device *parent,
  * @type: the type of the struct which contains struct &drm_device
  * @member: the name of the &drm_device within @type.
  *
- * This allocates and initialize a new DRM device. No device registration is done.
+ * This allocates and initializes a new DRM device. No device registration is done.
  * Call drm_dev_register() to advertice the device to user space and register it
  * with other core subsystems. This should be done last in the device
  * initialization sequence to make sure userspace can't access an inconsistent
-- 
2.31.1

