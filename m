Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B49C40D9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbhIPM20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:28:26 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39596
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239363AbhIPM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:28:25 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 08FE93FE02
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631795224;
        bh=oruoXINM9lE6NQF44gguXgq2pHTP8iv51Cw7Sf30Jug=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DJPdjkvub6rKzh7w+p1NEC/Uz7PbxB2Pl4Zu56+SK2qnkpKx/qEEZmfF2sqI7X2gC
         tA5eiGXhfKJOzTQ3k8Sh8EkK6nc47AtIVFXPbdq23aajpGI6r6byTS5aHMa+HggfiK
         7oh+5f7O/mlkvSWV0GB611JMe5pdkpkqM+KRVdy2onr1R+CumolsvccJQJc0VGMgr0
         sK93ENyyk2UFtoZoQx2vDQcaQE+2YKCw0nh3kbAHKjS/DCIOVzvSs2tFz6MNHPZ3I3
         6FlnIqfCiQBwk4w84fbK5bbcJeNaAXZACF2l8eVF3s3ZuMVn2vK5Z5tTVabglotUul
         EArlSXEt205vQ==
Received: by mail-pj1-f72.google.com with SMTP id 41-20020a17090a0fac00b00195a5a61ab8so4635960pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oruoXINM9lE6NQF44gguXgq2pHTP8iv51Cw7Sf30Jug=;
        b=LHqyqABDVojUX/bYcg1iIUP/F0Y01reNEihzLE/vjNx9iejkfEp9qicoovCmyUItvx
         pDUYYqhGuw5R2Zlwp0BFnAL8gevjxpMwQfTGRVyuFZgO1vcDJWqn/4zSTQQzP9s58ZoL
         ei7cTizfs/YLwuCWDXxu7rfwq5btVGtyZcAd/JqFQk00uxIj79JkrQkZGs3u5R8A2O2n
         09fFZi63IzwonJH5IvP4WtFnJ3SZzUAYmr/9K5OtkZ33oaASin+8y1mDUzj+5g2IIk6y
         m7+WWBzeFoWsIle4UhOzJg9LAtvleKtYp/+PNIEvCnFr/OrnnHGsQzwVrrE0USFARlzI
         VWCg==
X-Gm-Message-State: AOAM530o95v62bp+oeqAx7xdv8okEpdfYMH/moGm5TQ+Dgo98kKvCj2g
        QX+iA1HjJazRu9Ieb99mQd3pds9ZYv/qcheSEZFSZTn7z/6AjHXIYIopIZ9hG33ZWLYaWiZrDls
        7P0Z0n+ByYv74QvCZhTkKC/srV+jNPq5pV8bRRrC2rg==
X-Received: by 2002:a17:902:7488:b0:13c:9740:3c13 with SMTP id h8-20020a170902748800b0013c97403c13mr4614644pll.76.1631795222566;
        Thu, 16 Sep 2021 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNDmpBb62DYJob9a3dod7hjLoK8Qzzsy/X+2T2gIfx2zDj4qcfTeyPuJyeL4eX5C+Fx5VmHA==
X-Received: by 2002:a17:902:7488:b0:13c:9740:3c13 with SMTP id h8-20020a170902748800b0013c97403c13mr4614631pll.76.1631795222361;
        Thu, 16 Sep 2021 05:27:02 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id s9sm2897369pfu.129.2021.09.16.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:27:02 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     tim.gardner@canonical.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915: use strscpy() to avoid buffer overrun
Date:   Thu, 16 Sep 2021 06:26:49 -0600
Message-Id: <20210916122649.12691-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <dc88e195-949c-bb46-b7d3-18e90df9b064@canonical.com>
References: <dc88e195-949c-bb46-b7d3-18e90df9b064@canonical.com>
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

Fix any possible overflows by using strscpy() which guarantees NULL termination.

Also correct 2 other strcpy() call sites with the same potential for Coverity
warnings or overruns.

v2 - Change $SUBJECT from "drm/i915: zero fill vma name buffer"
     Use strscpy() instead of strncpy(). Its a much simpler change.

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
 drivers/gpu/drm/i915/i915_gpu_error.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 9cf6ac575de1..7f246f51959d 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1015,7 +1015,7 @@ i915_vma_coredump_create(const struct intel_gt *gt,
 		return NULL;
 	}
 
-	strcpy(dst->name, name);
+	strscpy(dst->name, name, sizeof(dst->name));
 	dst->next = NULL;
 
 	dst->gtt_offset = vma->node.start;
@@ -1279,7 +1279,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
 	rcu_read_lock();
 	task = pid_task(ctx->pid, PIDTYPE_PID);
 	if (task) {
-		strcpy(e->comm, task->comm);
+		strscpy(e->comm, task->comm, sizeof(e->comm));
 		e->pid = task->pid;
 	}
 	rcu_read_unlock();
@@ -1323,7 +1323,7 @@ capture_vma(struct intel_engine_capture_vma *next,
 		return next;
 	}
 
-	strcpy(c->name, name);
+	strscpy(c->name, name, sizeof(c->name));
 	c->vma = vma; /* reference held while active */
 
 	c->next = next;
-- 
2.33.0

