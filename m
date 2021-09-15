Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDF940CD22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhIOTY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:24:57 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49038
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230451AbhIOTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:24:56 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D83840192
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 19:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631733816;
        bh=reGZLIrkND9NmREfF+uJdu/zbEvtwF8yhm5BzYRS4EE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Y/8CpJlUnGk/rvwg/XmE0/iQzSkkVsvVnF/NYa/4uCJR6XVS9tW2es+e/qAhpAzQO
         QIZKS/DmJTSqmOKK2YuZDl7hK54f6C+kXpP+N47ed7STordYWmCKC8nA9VXY9C80xg
         Orig6ninBkJYEwFosdtr/koou63vgleNpAz6IbrylipKaM79Js9S6RbQjlLShaW3nT
         P/Xh5zQGd77FIzlwbfvBN1yigSI/Lf7DERPKjONbDZKtTLeE45G2j4MqXX9bL2mUw5
         OqemSaG9Z6mKuLnp0qDpjDZ/4zxaqi2saIyDBGrV3Bs/RNr1EizpNLGOTCVZbrsMSX
         9UYiP1Z5em+UA==
Received: by mail-pg1-f200.google.com with SMTP id u7-20020a632347000000b0026722cd9defso2507549pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=reGZLIrkND9NmREfF+uJdu/zbEvtwF8yhm5BzYRS4EE=;
        b=twKX+fBiY8okM123i6s0DB8ievzHIGUc6diivUwJtVb8+S2MzSjDEv/cAeDt1qJXea
         icp1kTf8KwpJObhxL2xRXex44N7845NPp8frD+q5vK+vQhxNgh8sgkGaXQCUIIDuRK3o
         PaCrZlnTpb7eQ+eAgFkfj2mjEhWzVAqffWnYEcumcBd/VKYilXAXgpq421X9BRW9JLpX
         tCdH75pPUJemL2MnLRut1JRqnk3Ok6So71UplMgfthBLnNxgXomGc9Rfhskp6rvlZJJV
         /Lc/cJZ0qFtlNO1Zg3+568K03kxIrhSJWl+oiI6IxI7xGBBvBEsGIGnDbTxq3LJ/rL4V
         zp6w==
X-Gm-Message-State: AOAM530nxMuofpGwPlSCuhWRYQfb7OEjg38rL7uF9uk8ySiRF5iAY0M8
        I/XgLGAyPg5PrLKcxHmMlMSOvmwDoJEX44iSfkxsLU5lqIyMRVJpjxPlagNpwsw/5ymDHcPxxQe
        nPcfj0fb/StrkcI4Kxet5qVee8XLbKSbU7TLKqSYf+Q==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr1100591pfl.57.1631733814766;
        Wed, 15 Sep 2021 12:23:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLv/mm48E1hK21/iAiUnlGrUqkaD1mVhXMQzwUCOu3vlwewW1pnR9aODuvrw5GmvbZX8djSA==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr1100566pfl.57.1631733814535;
        Wed, 15 Sep 2021 12:23:34 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id f144sm640405pfa.24.2021.09.15.12.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 12:23:34 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     tim.gardner@canonical.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: zero fill vma name buffer
Date:   Wed, 15 Sep 2021 13:23:18 -0600
Message-Id: <20210915192318.2061-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In capture_vma() Coverity complains of a possible buffer overrun. Even
though this is a static function where all call sites can be checked,
limiting the copy length could save some future grief.

CID 93300 (#1 of 1): Copy into fixed size buffer (STRING_OVERFLOW)
4. fixed_size_dest: You might overrun the 16-character fixed-size string c->name
   by copying name without checking the length.
5. parameter_as_source: Note: This defect has an elevated risk because the
   source argument is a parameter of the current function.
1326        strcpy(c->name, name);

Fix any possible overflows by using strncpy(). Zero fill the name buffer to
guarantee ASCII string NULL termination.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 9cf6ac575de1..154df174e2d7 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1297,10 +1297,11 @@ static bool record_context(struct i915_gem_context_coredump *e,
 	return simulated;
 }
 
+#define VMA_NAME_LEN 16
 struct intel_engine_capture_vma {
 	struct intel_engine_capture_vma *next;
 	struct i915_vma *vma;
-	char name[16];
+	char name[VMA_NAME_LEN];
 };
 
 static struct intel_engine_capture_vma *
@@ -1314,7 +1315,7 @@ capture_vma(struct intel_engine_capture_vma *next,
 	if (!vma)
 		return next;
 
-	c = kmalloc(sizeof(*c), gfp);
+	c = kzalloc(sizeof(*c), gfp);
 	if (!c)
 		return next;
 
@@ -1323,7 +1324,7 @@ capture_vma(struct intel_engine_capture_vma *next,
 		return next;
 	}
 
-	strcpy(c->name, name);
+	strncpy(c->name, name, VMA_NAME_LEN-1);
 	c->vma = vma; /* reference held while active */
 
 	c->next = next;
-- 
2.33.0

