Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1138DC28
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhEWRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 13:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhEWRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 13:24:36 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4520C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:23:08 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x15so24905965oic.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FoVSFWcUZWXRm7AD51E3dANi05UrgXiAjik3mpf5no=;
        b=RMSTz6qKC8La6YP28LsKEFerKiMRPKEO36aLvbKYOKBoTx2ndWptJB/hb5lmiWiOn1
         P7eLVaFFNfbJ96Yn12cdngBg5O7L+KKD9SOM9hWFZL4mzEtE9KSM1Ff2EsBfu4rT9s3z
         DUBxRuOE30by1mVJGwW1wTlq2bD28Q8PakzOk2U/jjJRkzzHWq4+6YMxKNElVvb1sUcR
         F36hLz+pS7Hryd1Blv55Q/+V94hkfHNJiDlrP0IZzoBRpi+jNJwTNu7X2KJOQnaIfhFK
         x/2KYVE/esYY6BOI+vTxogfb/X2t6D2VKHId7hPBIePEhk8PXg7xDFZu8JghGwF0tbEj
         o9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2FoVSFWcUZWXRm7AD51E3dANi05UrgXiAjik3mpf5no=;
        b=UnyCIGMOzgOhA0iytYXo5cZ/NvSXu/nfcG3PZWcQPaRjzqAC/kMWwkascOnca6izt2
         cLglET6XPRFor+mUtf07ug4ih2rYlN3JSv87hwwLvpN7je9UT0trl7FcG6Dd48M0l+0P
         MWFXAmvdlCVakJHPpgvhNHHzCkZmCPE+DL3O3iTgWg20xDy6tAhpGFkOLuKM8nnYqid1
         xWZCHl8TqlZGekJDbbqDvStUVzX9dweY086T4DYMtXHxjfP/Ncbhk2+Aa4aKbVmcKugM
         cD8ZsbkXlzzM+jkEyDrgu0jHcPp1iSLYVfI5SbBIovu9iwijVdLQjgP2fF+YXBM8FecF
         vCiA==
X-Gm-Message-State: AOAM532zZJR6vE8B5ODvYjbRCcFg7Po1Ll8UquzmuEWqDjuEX/M7b4mk
        /GT/HOPDDVSQQ7HXOVPhMCjjXeM8+Qg=
X-Google-Smtp-Source: ABdhPJwY480IlovPkjrgDpcAhRCpN2rSslgx5zzbp8togNhSlzBUSV60ajsWIZCURBGgHgy33kopPA==
X-Received: by 2002:a05:6808:98f:: with SMTP id a15mr8551245oic.29.1621790588083;
        Sun, 23 May 2021 10:23:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm2627421otn.44.2021.05.23.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:23:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] drm/i915/gem: Use list_entry to access list members
Date:   Sun, 23 May 2021 10:23:04 -0700
Message-Id: <20210523172304.3033229-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use list_entry() instead of container_of() to access list members.
Also drop unnecessary and misleading NULL checks on the result of
list_entry().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Checkpatch fixes:
    - Fix alignment
    - Replace comparison against NULL with !

 drivers/gpu/drm/i915/gvt/dmabuf.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index d4f883f35b95..e3f488681484 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -148,8 +148,7 @@ static void dmabuf_gem_object_free(struct kref *kref)
 
 	if (vgpu && vgpu->active && !list_empty(&vgpu->dmabuf_obj_list_head)) {
 		list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-			dmabuf_obj = container_of(pos,
-					struct intel_vgpu_dmabuf_obj, list);
+			dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
 			if (dmabuf_obj == obj) {
 				list_del(pos);
 				intel_gvt_hypervisor_put_vfio_device(vgpu);
@@ -357,10 +356,8 @@ pick_dmabuf_by_info(struct intel_vgpu *vgpu,
 	struct intel_vgpu_dmabuf_obj *ret = NULL;
 
 	list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = container_of(pos, struct intel_vgpu_dmabuf_obj,
-						list);
-		if ((dmabuf_obj == NULL) ||
-		    (dmabuf_obj->info == NULL))
+		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
+		if (!dmabuf_obj->info)
 			continue;
 
 		fb_info = (struct intel_vgpu_fb_info *)dmabuf_obj->info;
@@ -387,11 +384,7 @@ pick_dmabuf_by_num(struct intel_vgpu *vgpu, u32 id)
 	struct intel_vgpu_dmabuf_obj *ret = NULL;
 
 	list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = container_of(pos, struct intel_vgpu_dmabuf_obj,
-						list);
-		if (!dmabuf_obj)
-			continue;
-
+		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
 		if (dmabuf_obj->dmabuf_id == id) {
 			ret = dmabuf_obj;
 			break;
@@ -600,8 +593,7 @@ void intel_vgpu_dmabuf_cleanup(struct intel_vgpu *vgpu)
 
 	mutex_lock(&vgpu->dmabuf_lock);
 	list_for_each_safe(pos, n, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = container_of(pos, struct intel_vgpu_dmabuf_obj,
-						list);
+		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
 		dmabuf_obj->vgpu = NULL;
 
 		idr_remove(&vgpu->object_idr, dmabuf_obj->dmabuf_id);
-- 
2.25.1

