Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5630398CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFBOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhFBOfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFABC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o2-20020a05600c4fc2b029019a0a8f959dso1825298wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjGrcIOD2Z+Nhsp7UBZvNxk73/3NibtTsjxqFhOCaZQ=;
        b=B5eapVtXzrPgrbyn1no4++7E3/uyzNNcp0YRodoZhe/7iVG9VhheW7sq8o0Dzo8HEA
         3wjS6sImWqTgA8oIi0ByjoXOWdJHZWqrr/kpZ8eahVhucaE7G3+jSzQj8/PT4wmA1JIa
         8kiJX7A9VyvvrE4EnRv2MC/NB59qqRHGMlYS0ZT0uMBt/X0N7wedWhDjtTIRx2bPXoP0
         8RQPuZjNoQaDXJRJgWwV8w56gPTIjO83KS4sEXfW2Y0RxRaXgg9Bya6ul5+hqjTL6xcl
         X/oHfcoGl02m4aT7q94NVz6FcJxSsW7wLw99FCanuuybwqMp1qO9QWVxv0w956JxGjcE
         NAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjGrcIOD2Z+Nhsp7UBZvNxk73/3NibtTsjxqFhOCaZQ=;
        b=WJhhPqBYE9iI6BV1qEQI53Kz++c9XRYe+1rwbH3sKoJNhIjhA8Rw6dre2EIbOsi8la
         DOFVma/Zbh9bm5vNdAHjRLK5MAfpjLP1b/U7s15RedDgJkqYK07R4DnxfobOgKm1LC6g
         5WJgWrDbHJnqgaBUJijCuRFpOOOa5wtxcjKOnYV4x7DBjRvyi0EfCLiZrLTjs0ovYje2
         X8jqMANhfWGMZxiDLb+E5+VIhWPYTVpDuF7YHxeg9gRkYG1Ib/Dy+X5U7K+4kiVAUW8Q
         KBaCP22pzEjUzndnPVqQIbZ1oVzVWvSdlA9+skqfOKml7rusyvkVmWQNbwbXvFFJMxod
         ywPA==
X-Gm-Message-State: AOAM532UxN1VZS232FgiKH5juSGQz87wXsxC/YnT8jqE+OhGPSJbBPok
        dO21roD+ybJtw0Tnjga1Gf27RQO4F63B/Q==
X-Google-Smtp-Source: ABdhPJwxPRXLmbCCUUch5fo3cAuuWEWS5/sxOyuVrPft+LO9FzDB58nFhNnDAbN4KR1KSBP0zTeO7A==
X-Received: by 2002:a05:600c:ad2:: with SMTP id c18mr21788160wmr.93.1622644395561;
        Wed, 02 Jun 2021 07:33:15 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 06/26] drm/sti/sti_hda: Provide missing function names
Date:   Wed,  2 Jun 2021 15:32:40 +0100
Message-Id: <20210602143300.2330146-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_hda.c:283: warning: expecting prototype for Search for a video mode in the supported modes table(). Prototype was for hda_get_mode_idx() instead
 drivers/gpu/drm/sti/sti_hda.c:301: warning: expecting prototype for Enable the HD DACS(). Prototype was for hda_enable_hd_dacs() instead
 drivers/gpu/drm/sti/sti_hda.c:383: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_hda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 5c2b650b561d5..03f3377f918c0 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -272,7 +272,7 @@ static void hda_write(struct sti_hda *hda, u32 val, int offset)
 }
 
 /**
- * Search for a video mode in the supported modes table
+ * hda_get_mode_idx - Search for a video mode in the supported modes table
  *
  * @mode: mode being searched
  * @idx: index of the found mode
@@ -292,7 +292,7 @@ static bool hda_get_mode_idx(struct drm_display_mode mode, int *idx)
 }
 
 /**
- * Enable the HD DACS
+ * hda_enable_hd_dacs - Enable the HD DACS
  *
  * @hda: pointer to HD analog structure
  * @enable: true if HD DACS need to be enabled, else false
@@ -380,7 +380,7 @@ static void hda_debugfs_init(struct sti_hda *hda, struct drm_minor *minor)
 }
 
 /**
- * Configure AWG, writing instructions
+ * sti_hda_configure_awg - Configure AWG, writing instructions
  *
  * @hda: pointer to HD analog structure
  * @awg_instr: pointer to AWG instructions table
-- 
2.31.1

