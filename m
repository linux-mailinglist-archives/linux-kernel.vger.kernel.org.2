Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5E41CF97
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347237AbhI2XCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344976AbhI2XCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:02:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F6C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:00:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d81-20020a251d54000000b005b55772ca97so5435832ybd.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2C1roWzg0g1t9SJdsvhWjF7EJsfvlHyd4vOPAZE7CoI=;
        b=O+MmupE8fI7/r7LR80gJgtKAawE3aHAvqlPZjba4TXr+3/ROlzQqWpdYQjufuNIvwa
         CLrNA9c1X5+VvlGFyQWbz4gv7VMOLu7sUUu9/TWhTaQVor/CADKhgOAPA5WzOmAStNxR
         sAtcVixKl9hMqHGfHOIb53dh1FHQDqfc0wEi8eKKMkhtAGQmefOH/406zex1NU7eqoH7
         A4IU33wFhKluEKvhrztURWDQrddSjKDAgMr+x6HANgOc+C9Y+Bzp8rueUIRKfDi6Sd6C
         QlIKfLcD36ZADHFLjtqc2E9gdKi/U72kIsvdLbAxkftbPkIBwfMYBUP7wPjFXDU62l+g
         X2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2C1roWzg0g1t9SJdsvhWjF7EJsfvlHyd4vOPAZE7CoI=;
        b=CJx7QSlCAVQ7BMjEhnfuPQLfQya5sF5wPo2j7txxKDBta8CHP8EyfGidJ6+HDC+CDv
         me/jfHeK2TwQdv7bbyfjVNbyn0kWOkbqQMZzOzWtgYPF3dTfrSvTpMmQGLSQ0mkP0lEi
         K28Ml1nT/O/cDl9j/0S7qfU0dgMlwr96jt3ztiGPOJxdrUqy/S5t7dcpnNmRnC5FYwOy
         fvshUpuoaxUaasZ8bTIkMG9tt4oYp1y3cY9fVvZVYHJGmHBfjAP+5rtu2Y0hDQaVjO4+
         TJq9lUo1HaSCBx4g/NPTqxh4S035iQk6AXDfroIkGUHpn5YXKIx43D7YCPn6AvHGES60
         PTBw==
X-Gm-Message-State: AOAM530LhFoI8brK5tiQ1dHztBHOjvVbzzWrqK7mWrUwQHoGsGan/f/N
        cV6D57Ffren++O2Vg6lsmMi93ZU2jcFg
X-Google-Smtp-Source: ABdhPJzTf7z7tCB+PBeS7fuuzlbUSbpG8y8sOo1ZnIfLkNOe6rmfKSrRzOSOhMmGbx7AL/RMDXwLF+1q/idI
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:8a84:22eb:d7a2:bdba])
 (user=amistry job=sendgmr) by 2002:a25:7452:: with SMTP id
 p79mr2737243ybc.513.1632956420637; Wed, 29 Sep 2021 16:00:20 -0700 (PDT)
Date:   Thu, 30 Sep 2021 09:00:07 +1000
Message-Id: <20210930085932.1.I8043d61cc238e0168e2f4ca5f4783223434aa587@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] drm/prime: Fix use after free in mmap with drm_gem_ttm_mmap
From:   Anand K Mistry <amistry@google.com>
To:     dri-devel@lists.freedesktop.org
Cc:     nartemiev@google.com, Anand K Mistry <amistry@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_ttm_mmap() drops a reference to the gem object on success. If
the gem object's refcount == 1 on entry to drm_gem_prime_mmap(), that
drop will free the gem object, and the subsequent drm_gem_object_get()
will be a UAF. Fix by grabbing a reference before calling the mmap
helper.

This issue was forseen when the reference dropping was adding in
commit 9786b65bc61ac ("drm/ttm: fix mmap refcounting"):
  "For that to work properly the drm_gem_object_get() call in
  drm_gem_ttm_mmap() must be moved so it happens before calling
  obj->funcs->mmap(), otherwise the gem refcount would go down
  to zero."

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 drivers/gpu/drm/drm_prime.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 2a54f86856af..e1854fd24bb0 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -719,11 +719,13 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	if (obj->funcs && obj->funcs->mmap) {
 		vma->vm_ops = obj->funcs->vm_ops;
 
+		drm_gem_object_get(obj);
 		ret = obj->funcs->mmap(obj, vma);
-		if (ret)
+		if (ret) {
+			drm_gem_object_put(obj);
 			return ret;
+		}
 		vma->vm_private_data = obj;
-		drm_gem_object_get(obj);
 		return 0;
 	}
 
-- 
2.33.0.800.g4c38ced690-goog

