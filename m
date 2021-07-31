Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08243DC857
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhGaVme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhGaVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:42:32 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A02C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r18so15869291iot.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kmHsDnFQwSbOnRKSJ1vga0OhlV8P3CEw6FanKWDIy40=;
        b=U9BvI1glpc+yDSbM/DPm8s6F7ztnI0CJPlfd/CvD4PiMnHYiqRFdaAPiOIaj3wy9a5
         UBEUc1TXEMS6bFRQRXOsMekQ68EdjCQaKc1Mqogn1UN2W7+7XMdiMJ8AV4fH8sbcUjQm
         TdlL4IbV9HumLEKzoFkUwYDDZqQwBIhy4Iqwu6aG4l4Fqr+8NEGK5cfzaRd5VM4kHqA+
         /gmJNe4dJcAwy8rTTd2WHR5Rej9fhrpZ58dQzRMV///Mmj2uOm/zwHCn+E1CXjtXOvpr
         OGEBpaj0ipVFD35gduXa+vjXyJfLpFZdhimrND3VFeciLZywwIzpFhe2nqgYqRvnWEAu
         FqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmHsDnFQwSbOnRKSJ1vga0OhlV8P3CEw6FanKWDIy40=;
        b=JCoTZjOOxGxGQYhKqgTVDZYU/FXPEeR2ry/0xdagNQqTGMPMKScgjT3ekmCUjqcj7U
         0UJiUCvd6b5Id8jBncMUNTiaf3wn/e1QRj7t7FjkrDJNG3l+aPR7Q/ouvfh+FjUv0xFH
         DM4ChOHUDBXgPw7RDYiYkwHw2QkkL7UnW8Ij416juleKnz7ZF2y4Eaau7OQt51xkrGtV
         UD6thrJwkEtwtPdboFDNc01ZSc6Fv75y5hszhmMhSHUUdPrLQVgF3/j60r5nkBohnV8E
         SsbHlEpX1Fuv2zgsAs/eeePZiKcOmnvjsW9WRGQnC98x6aQbnDAPxm98clL5qrgY5LT9
         GwWQ==
X-Gm-Message-State: AOAM531rxw7A8JpU1EXSwE0bMdu0Vj6+PJX3+uP3Zwui2V543MoNaojE
        G07BWASsH5J1n/Y2ljK4YUs=
X-Google-Smtp-Source: ABdhPJwHNkMohciy9QMc9txPm4gNPWvEEssmPLZfOVFLAQW4UOPDVFX6Ry/jP25YRbLh9pAP7h24lA==
X-Received: by 2002:a5e:c006:: with SMTP id u6mr6101793iol.66.1627767745609;
        Sat, 31 Jul 2021 14:42:25 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id q10sm3721040ion.3.2021.07.31.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:42:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 1/7] drm/print: fixup spelling in a comment
Date:   Sat, 31 Jul 2021 15:41:58 -0600
Message-Id: <20210731214211.657280-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731214211.657280-1-jim.cromie@gmail.com>
References: <20210731214211.657280-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/prink/printk/ - no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 9b66be54dd16..15a089a87c22 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -327,7 +327,7 @@ static inline bool drm_debug_enabled(enum drm_debug_category category)
 /*
  * struct device based logging
  *
- * Prefer drm_device based logging over device or prink based logging.
+ * Prefer drm_device based logging over device or printk based logging.
  */
 
 __printf(3, 4)
-- 
2.31.1

