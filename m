Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216ED38D841
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhEWCW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEWCWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:22:55 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEB0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:21:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v22so23745563oic.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6LZ1nOhRwzoOY76+a1FbKsP/eyCYJFZ+vHMVLGv3BQ=;
        b=MO3wfQN8QNjrYCGPOw6rn7zlKuW1zT444BXJ5yMVL9WZv/frfxMyeatWnFiLW71tr8
         /a82McSqPki/nIdeNGhMbUpCGl1WoremUWG7dTKg6rD2XM1tLW9PWDkDfabc5jwDajuZ
         tvrmsdBlD3n2oKx32ymz1kWcY4vwWcdRJhTvzvXp8BD3VdpWWqazrJFfzwa09/EKBDwZ
         GjqIF3Ix6diZ1NAjkdaR8NpB/u4BwEOtb7IS3WRyS0fx0jAT8zvG2p/Z2hbGEgkM8CiQ
         HpU8lPkJl1tjLfD/KpoJDMhmtJE9QIUqBWie3+T4YHTKgm+3H2zC61M1eYD5rhO9TJ1J
         scNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=U6LZ1nOhRwzoOY76+a1FbKsP/eyCYJFZ+vHMVLGv3BQ=;
        b=dFwO1LpJKEVdW2k49zyFND6t7wtHZ13VuubIqrIj/gHiP7G+PMeRDCkYZICUp8wiWk
         OmU8Vu2P0Zo54KyJKHPFPMpUQxSALm7tKXGT5LIw+vaoAJsTFUF9HsF6GAGv8K8nST4l
         Y0hd3VhbEFM4HIW/x/vb6jZ5HtdDo50X4HjaAvlX251/mJkkVxieGRNhoourVBYSg5B+
         +xEdry10uwFAHSU/8KrhU5olBNseaCkEIp2XQn+4O0tvVn7gPkNkTRzPPfoGhXdMSxiG
         akT759OiRkCz0/LItgm0uxpUVxPaU+SYR2Rqz32KO0CuWCph35TIPjNqK/GiFe5ycL5p
         N4qA==
X-Gm-Message-State: AOAM533qg6lSt4KI4EgaGAusoKFnklpSf9as4iriXGg6LUOcj7HMsjrY
        CYR7DHWw8Q1EstbCtxDcPlA4U4HmiRg=
X-Google-Smtp-Source: ABdhPJwaRu7doMHe/oCsHDDI5YU3j35+KQOMg97pQpgU82F6UZ7fuhO4/PAisIUok6qJGD8zEB+JUQ==
X-Received: by 2002:aca:ab50:: with SMTP id u77mr6796354oie.153.1621736488189;
        Sat, 22 May 2021 19:21:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e21sm1981779oii.23.2021.05.22.19.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 19:21:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] drm/i915/gem: Use list_entry to access list members
Date:   Sat, 22 May 2021 19:21:25 -0700
Message-Id: <20210523022125.853214-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use list_entry() instead of container_of() to access list members.
Also drop unnecessary and misleading NULL checks on the result of
list_entry().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index d4f883f35b95..4241af5074a9 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -148,7 +148,7 @@ static void dmabuf_gem_object_free(struct kref *kref)
 
 	if (vgpu && vgpu->active && !list_empty(&vgpu->dmabuf_obj_list_head)) {
 		list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-			dmabuf_obj = container_of(pos,
+			dmabuf_obj = list_entry(pos,
 					struct intel_vgpu_dmabuf_obj, list);
 			if (dmabuf_obj == obj) {
 				list_del(pos);
@@ -357,10 +357,8 @@ pick_dmabuf_by_info(struct intel_vgpu *vgpu,
 	struct intel_vgpu_dmabuf_obj *ret = NULL;
 
 	list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = container_of(pos, struct intel_vgpu_dmabuf_obj,
-						list);
-		if ((dmabuf_obj == NULL) ||
-		    (dmabuf_obj->info == NULL))
+		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
+		if (dmabuf_obj->info == NULL)
 			continue;
 
 		fb_info = (struct intel_vgpu_fb_info *)dmabuf_obj->info;
@@ -387,11 +385,7 @@ pick_dmabuf_by_num(struct intel_vgpu *vgpu, u32 id)
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
@@ -600,8 +594,7 @@ void intel_vgpu_dmabuf_cleanup(struct intel_vgpu *vgpu)
 
 	mutex_lock(&vgpu->dmabuf_lock);
 	list_for_each_safe(pos, n, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = container_of(pos, struct intel_vgpu_dmabuf_obj,
-						list);
+		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
 		dmabuf_obj->vgpu = NULL;
 
 		idr_remove(&vgpu->object_idr, dmabuf_obj->dmabuf_id);
-- 
2.25.1

