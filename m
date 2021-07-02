Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18B73BA479
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhGBTzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229676AbhGBTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625255585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KRoKHMQ/QYj7rUDlz3XNGWb+wy/iN7sUlepMrk5JPbo=;
        b=Nydsx++8zBb0qTeFmX6I+Kd8XMUmFHfAMI2OuMPPY/oL+6TgtqiH2IgrQQyY2kJxC3oAvM
        T1ESBU22ZG748WJEvcZtO+z6gHMuDyoN1ucDoeFYDDFeEbx5kmqJIuM9ylyQTtQY7RusfY
        IUsmXsFl26pUiEEAo+2AtxEPVdBwIvc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-QMhIpKLGPE2D9DetUfltUA-1; Fri, 02 Jul 2021 15:53:04 -0400
X-MC-Unique: QMhIpKLGPE2D9DetUfltUA-1
Received: by mail-oo1-f71.google.com with SMTP id l13-20020a4ae2cd0000b029024c17ace030so6119494oot.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRoKHMQ/QYj7rUDlz3XNGWb+wy/iN7sUlepMrk5JPbo=;
        b=NNbY8mT/pSAhWv527EpK8bxKB21BSsoFZ2jxiT35IOxu8clWBE+3gFE+gLO5LD/Zdq
         QG2wlJLJ4qRYY/LqzJJ+MjkvvwLPDxw5CmULjRTN0Gfu+6W6QLt2UGXHbrABkUZWFgY5
         gAtFIMYpWRGulNbnfPG7q3jPDJ4BhsGQZGETv3pKW5N80Qk/EhTH8UeM9Nf0jCVNSrU1
         mAwWqmiWKq/LDUwAK0zlEuzz20PMXKR3b+JXCgeOP1f8rV3yH6U4SL3Or/17j33gz8K2
         XIwrGXtNHYAUfXA8Xdw/svwpYzOXpzYqvMjAZkmpOQAPJnmaXe9OWggs37PjpNlQO1bx
         Znug==
X-Gm-Message-State: AOAM532BR5ukOElrq7S9Zu8jjQOGTmSHqh9qUUU7GzTvq0FN5U2LDaMs
        rO480t2EYHEVo7ii/NUV/mb9GTUqktZrfoA4DZVKosJBi6hrCser/bCfy7UPViS9u9Od68l7BKs
        aBbSYwziMdgBZPfUFHbBMVIb6
X-Received: by 2002:aca:4302:: with SMTP id q2mr932144oia.111.1625255583754;
        Fri, 02 Jul 2021 12:53:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeVRL/DQmiY8F2uMYWaBUYWtTORAPrUvyzc7HoM34TMuLz0GslVBRJe+SamgLTpcc4McWv6Q==
X-Received: by 2002:aca:4302:: with SMTP id q2mr932125oia.111.1625255583503;
        Fri, 02 Jul 2021 12:53:03 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l2sm810062otl.27.2021.07.02.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 12:53:03 -0700 (PDT)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, Dennis.Li@amd.com, guchun.chen@amd.com,
        luben.tuikov@amd.com, Stanley.Yang@amd.com, nirmoy.das@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: initialize amdgpu_ras_query_error_count() error count parameters
Date:   Fri,  2 Jul 2021 12:52:45 -0700
Message-Id: <20210702195245.1629908-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
amdgpu_ras.c:2324:2: warning: 2nd function call argument is an
  uninitialized value
        atomic_set(&con->ras_ce_count, ce_count);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ce_count is normally set by the earlier call to
amdgpu_ras_query_error_count().  But amdgpu_ras_query_error_count()
can return early without setting, leaving its error count parameters
in a garbage state.

Initialize the error count parameters earlier.

Fixes: a46751fbcde5 ("drm/amdgpu: Fix RAS function interface")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 875874ea745ec..c80fa545aa2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1056,6 +1056,12 @@ void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	unsigned long ce, ue;
 
+	if (ce_count)
+		*ce_count = 0;
+
+	if (ue_count)
+		*ue_count = 0;
+
 	if (!adev->ras_enabled || !con)
 		return;
 
-- 
2.26.3

