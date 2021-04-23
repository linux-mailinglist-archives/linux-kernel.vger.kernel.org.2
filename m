Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61700369AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhDWTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbhDWTMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:12:40 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E86C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o5so50703265qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PiGI3myDVeLMq9GsTguuYbk0A7yStjg2eQhCDVfOEQY=;
        b=DWzTq3eg0IbdDQvqfaFhQmhIGoIvmyqq6SW2iUme8FM7yZjWOixBh34TBi9My2y/cG
         xYYjK+Y4scVUxuF79TXAPOxnyhucsXgaHzlJv0YzaQXhEe+3TQ9oO7obCCoCjoI7IlHZ
         Vk0CLw0Isl2ZE9ZtHcawKjRZsWUixj+WM26qVsLinOQrozGuf7AnfzwBwkdqC3pkVv0j
         pPpSx791zPpHZx9ACX+6oZtf8xyF7KaShxjG9ARa8QJNOCBb54nA5l2NC5UdjPeUGU4J
         0qp3G65Q+VgzhA7XcxriT74sY/a+ShwNI9pV9HwAQQ27wdZXSZwCMO9xm9BM+GUrNrUv
         5dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PiGI3myDVeLMq9GsTguuYbk0A7yStjg2eQhCDVfOEQY=;
        b=jYseyeY8cjVZLV3CsgVOtGkblyjFI8OgNI9uyKyxns6MAZsjbgkDouHj+hgwShYfCD
         7iLfKJbMEh5mOhJvW/VNCS8nN9rf0oiuz0RCVrhQGMYKv0f+AWvNcgOWF0HYbg8CLoQV
         wMyKhRpMwDaAxSMVx3O4rQh9/AKqQpEmVS+EEyxW30WFTtemSuuKekvaDgwmSMUs2s74
         xAd6nkS2iiRXdkAe0mKa2Wo1kL0FMT3h1ioHOB14xsXba+BCmFQhmSefmddMqsZC/MpX
         /yUZA21CgJX7GQ5je1jXjG/30mNqc+EYmNb2izpYIetyohHzEAwteC85VhJdPfHgTdT/
         44Bw==
X-Gm-Message-State: AOAM532T2lE6lngIR+l8wx40KS3W6O0Fi9tGuiQvLYDH+gu3+YhkiKH/
        6pvdfhnaE980J3pOBYVr2V/CgQ==
X-Google-Smtp-Source: ABdhPJxw5CDCTryTzVXDnpMJOxRnGYQZZ8taSXNSMcv35dkh9kK80RXJyrGVHu6/4JO0czCsHoI80A==
X-Received: by 2002:a37:b947:: with SMTP id j68mr5634704qkf.108.1619205122814;
        Fri, 23 Apr 2021 12:12:02 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id a22sm4834630qtp.80.2021.04.23.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:12:02 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm/msm: remove unnecessary mmap logic for cached BOs
Date:   Fri, 23 Apr 2021 15:08:17 -0400
Message-Id: <20210423190833.25319-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210423190833.25319-1-jonathan@marek.ca>
References: <20210423190833.25319-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one knows what this is for anymore, so just remove it.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_gem.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index b199942266a2..09abda42d764 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -207,21 +207,12 @@ int msm_gem_mmap_obj(struct drm_gem_object *obj,
 	vma->vm_flags &= ~VM_PFNMAP;
 	vma->vm_flags |= VM_MIXEDMAP;
 
-	if (msm_obj->flags & MSM_BO_WC) {
+	if (msm_obj->flags & MSM_BO_WC)
 		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
-	} else if (msm_obj->flags & MSM_BO_UNCACHED) {
+	else if (msm_obj->flags & MSM_BO_UNCACHED)
 		vma->vm_page_prot = pgprot_noncached(vm_get_page_prot(vma->vm_flags));
-	} else {
-		/*
-		 * Shunt off cached objs to shmem file so they have their own
-		 * address_space (so unmap_mapping_range does what we want,
-		 * in particular in the case of mmap'd dmabufs)
-		 */
-		vma->vm_pgoff = 0;
-		vma_set_file(vma, obj->filp);
-
+	else
 		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	}
 
 	return 0;
 }
-- 
2.26.1

