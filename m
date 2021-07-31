Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54373DC4FE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 10:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhGaI1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 04:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhGaI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 04:27:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC79C061798
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 01:27:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso24231558pjq.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7LF0TOJBi8g9oPoxvzY/IMHVXJRvIokqXJgW7n6wWU=;
        b=RJZ+rGSe9MjdSJpshgn6FdDtxzCLxvmvsad50TODML9WAleAKQiueuhET8/vduh88F
         S3Xqko1C4QRjj8UG4Wji5ctfC1UfiIV6IuBkUa5GVC4yIbAN60i2NkHaPW4XoZPQFS65
         4wCuYy5XdHd1w9ZYa+56L8c2ofiod/VTV1cZEhZYPokwnz/Q2slvJjtd+JnfbTNdC56v
         P9L35LIukKhPtFZLpaHXBWYCrD5hBpoQ+I7DZnlBVasE9yHb0zuJyTQeLEMrU/wbfaxy
         baMBSXRZ4aOnXooLgYsykXafJY5MUEZkh5g9EZ+m5U0yN9CCpWoRLru57HYs6wf6U7/E
         ERrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7LF0TOJBi8g9oPoxvzY/IMHVXJRvIokqXJgW7n6wWU=;
        b=q3At9al+i77Pdsc+wvWLQm6z/EAgHTxx+nhu5jDehnDsv+YnqkagQECUmHdzat1aJs
         4Lkt1KyX50Yldoar91PpgjJHfwE/IfLPGG+uhDHoG+tx+LqLMYqXtIQD+7KGlD2AVK6x
         3pBfeNfRr0VCipkWVA0cQg++7awpwLA+DLtM7fHDe6mbtSv/wjb+VGIQfY70vTC2d1TV
         2e5oejoLUYzqzS3EEzqXHf2f7+qIS7A18kCs/EfbfF+TzrsAxJ37srdby6Ry2OUifYyO
         zw65OTICKplWDK84OWZo0IUvlN08teIbmkZGtHEiFDIMoPPYpDrb6yCl1TJQdszwfqG2
         HHPQ==
X-Gm-Message-State: AOAM533DOJ6ouwlqIj7RLLsUBSAiYF5TGWaBbIyNIGyreo2ezfU4vsJq
        3Cf6WZviezr5rpn7uZ6RsEM=
X-Google-Smtp-Source: ABdhPJzd5bUpeB5fpe0qkJXVTRCMKBesE410MgSb6QJZrGqvamH8Z/gVzFKaP0OmfXbgFlYSkhMzWg==
X-Received: by 2002:a17:902:d293:b029:12c:8bb3:7997 with SMTP id t19-20020a170902d293b029012c8bb37997mr6015717plc.36.1627720024937;
        Sat, 31 Jul 2021 01:27:04 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id mq7sm3182124pjb.50.2021.07.31.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:27:04 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 2/2] drm: add lockdep assert to drm_is_current_master_locked
Date:   Sat, 31 Jul 2021 16:24:58 +0800
Message-Id: <20210731082458.1962043-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
References: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_is_current_master_locked, accessing drm_file.master should be
protected by either drm_file.master_lookup_lock or
drm_device.master_mutex. This was previously awkward to assert with
lockdep.

Following patch ("locking/lockdep: Provide lockdep_assert{,_once}()
helpers"), this assertion is now convenient. So we add in the
assertion and explain this lock design in the kerneldoc.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
---
 drivers/gpu/drm/drm_auth.c | 6 +++---
 include/drm/drm_file.h     | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 9c24b8cc8e36..6f4d7ff23c80 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -63,9 +63,9 @@
 
 static bool drm_is_current_master_locked(struct drm_file *fpriv)
 {
-	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
-	 * should be held here.
-	 */
+	lockdep_assert_once(lockdep_is_held(&fpriv->master_lookup_lock) ||
+			    lockdep_is_held(&fpriv->minor->dev->master_mutex));
+
 	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
 }
 
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 726cfe0ff5f5..a3acb7ac3550 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -233,6 +233,10 @@ struct drm_file {
 	 * this only matches &drm_device.master if the master is the currently
 	 * active one.
 	 *
+	 * To update @master, both &drm_device.master_mutex and
+	 * @master_lookup_lock need to be held, therefore holding either of
+	 * them is safe and enough for the read side.
+	 *
 	 * When dereferencing this pointer, either hold struct
 	 * &drm_device.master_mutex for the duration of the pointer's use, or
 	 * use drm_file_get_master() if struct &drm_device.master_mutex is not
-- 
2.25.1

