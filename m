Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E23622E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbhDPOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbhDPOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD04DC06134A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m3so32537182edv.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nl9Ia26K/OXp5QH7iR+CbZa0T1DkwvGhAbdA6rubQXU=;
        b=oRdDDVJnzU3oMYTdwqGq9oXyUcUTdpDa1cOLOtcv0eXH+IRscfrSxyE41XMoKgAynl
         ymX3w3afs7fC3P3KgCkr/gH01+c3nkSfjS0tJAv9h7srrtpvdGbujaFCQuzYffzvjJR6
         AYBhsbaS03ELNdlRIGdVO2wm/yA6LLFAujh4O3RUcl+pIhLax9HkuhTycdAsJK5Rh7Qb
         4NcL9vZZuLNrgSVcoPsDaw64oAa4gqBf+FwDOJepaoBBaxgAvFdEntsSh1aGplh0bKgt
         kZ7ytIwCvAADgk32eYBabFmahqZvK3qX5L7bFuh7Z01D2pTsDY+n4wUrcN6+JC7tGEoZ
         G84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nl9Ia26K/OXp5QH7iR+CbZa0T1DkwvGhAbdA6rubQXU=;
        b=BXriYc/6BwJzmivs2esjoN5TwA9zWcN/KAUqh9yS0yZfynFCNIRfYT6MHnCpWgh9Za
         LkEvVdA51GgnvwAku7Lwz3bc78818lLoP3o8hE0jwg+zGBCqC5J9tNNH9CO0nDWBSQBf
         SJ3kKbGb+ETJ522RgG4BBz5KvtSxkbgrcCyRn7yuVkm1w1TLafS+HdcMNYt0483mgomh
         TmH7Qq/cd5F4lAVYJkN7Tn8g/8nm7DF0vkGT1Y3jnW7yxzwTFGUMe6sWHg9z+hj3C4wB
         HpQnaBZqG3kkgb2zGHrvU5HXFC1MiqSTjDhGqkkY4XknfQAyO7EyWWNAvEegqAMPr35p
         760A==
X-Gm-Message-State: AOAM532RtJEME+x5FsYsPAFheVhxxXuFlfWJFwCR2eziMUhhEjzN3OOx
        IOFm9RI1krGmk+IGyVfUD831wQ==
X-Google-Smtp-Source: ABdhPJwPgmM7wgMTNVvKHslB4VCGOhOKe5VlAyEqYISlgKU0gq2jXg+T/USowGVX/n309irhgUvG+g==
X-Received: by 2002:a05:6402:3506:: with SMTP id b6mr10702102edd.175.1618583876478;
        Fri, 16 Apr 2021 07:37:56 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 25/40] drm/radeon/radeon_device: Provide function name in kernel-doc header
Date:   Fri, 16 Apr 2021 15:37:10 +0100
Message-Id: <20210416143725.2769053-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_device.c:1101: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index cc445c4cba2e3..46eea01950cb1 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1098,7 +1098,8 @@ static bool radeon_check_pot_argument(int arg)
 }
 
 /**
- * Determine a sensible default GART size according to ASIC family.
+ * radeon_gart_size_auto - Determine a sensible default GART size
+ *                         according to ASIC family.
  *
  * @family: ASIC family name
  */
-- 
2.27.0

