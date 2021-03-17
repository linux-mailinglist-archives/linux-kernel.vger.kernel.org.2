Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A533EBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCQIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCQIwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:52:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61996C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:52:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g185so38087613qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Uuz84Yw1409dXslxoeVZS7YIkkm9dB1XdIK6tSjsNA=;
        b=lSwLNJBPPZTTe4AJDNYR0kSTs/YZBuY28ZN4+RvC59dHnMwYi4QRM0uVlAP4CDE1aw
         2sX4w5VUq7JUuS/Afe79kgQ/fCHhJhV+dsIQ4Vf9zgxSkK0KDh+j5vv1ETfmiYA13Sdy
         ed94J7Pp3yeUR+htYdZ+ppplEKaZBePN7Ew6ZvE7G1JtHLpbf8peZ44sxN4dgQ5hcLaF
         QrV58KPeryrHKRATGyg84TM3ssMYBvfiIKlOCjjNHl2Hnjnwek6NwxmWRrIZyQ3zYX5s
         03mAk/SC38SPxol0CCenQwJ3neyhgBpR2tbY76GFd0VfUctzg+7d1crNB8xvnabIaMgG
         xSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Uuz84Yw1409dXslxoeVZS7YIkkm9dB1XdIK6tSjsNA=;
        b=KeUBNdokGUQn8xd5shdRqzyGiovSonjNYb9xNKKjjx62ucKJlLz7/Cr0ZmnFzOURZS
         5Cn8dsXABDZ/8iNw7+Ssw4J/PFVE2gULV4jbmJXgf41uCg1HCzrfyYCG8y4BDz2pF9oM
         Iup8SthvE0Who8lpuCcdN+lMl0L559uRQ1Fs8Ql9n2gJhCVmfjifmcwj2xV97Pwanbxk
         0YNqc+aj9J4UmOEfTbXP+/X2D7IL8NqLxHrWBD/lLnOQOwMz86ipbHDKi4hAQgRLZEdE
         EFhkQ2XcJwx/7wmbkPGyZXPV752VYvTzOgRG18+UMuACmU9G83O+pLEH2bcaOi5ICoWd
         4tcg==
X-Gm-Message-State: AOAM533sn8qcEbLzvSePnnlg/9QDwIBOjSdpj7m2JkPFNMk18mw7V9d/
        WZtgePX/ToJZPFxIK8aYzpw=
X-Google-Smtp-Source: ABdhPJwwFVbF/eoxUOO3Pew3ehkXS5Du9ET/7izc3OH/eh0Dof6QFiHfheQXzlKK1tWgbnJZJLA1Aw==
X-Received: by 2002:a37:6796:: with SMTP id b144mr3578497qkc.432.1615971156520;
        Wed, 17 Mar 2021 01:52:36 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id f186sm17331260qkj.106.2021.03.17.01.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:52:36 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] gpu: drm: Rudimentary typo fix in the file drm_drv.c
Date:   Wed, 17 Mar 2021 14:22:10 +0530
Message-Id: <20210317085210.3788782-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/refence-count/reference-count/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 20d22e41d7ce..2bfc724e8e41 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -203,7 +203,7 @@ static void drm_minor_unregister(struct drm_device *dev, unsigned int type)

 /*
  * Looks up the given minor-ID and returns the respective DRM-minor object. The
- * refence-count of the underlying device is increased so you must release this
+ * reference-count of the underlying device is increased so you must release this
  * object with drm_minor_release().
  *
  * As long as you hold this minor, it is guaranteed that the object and the
--
2.30.2

