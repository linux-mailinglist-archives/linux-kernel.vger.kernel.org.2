Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C043608AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhDOL4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:56:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:56:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w23so20624632ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAgKFkUbajfTwkiBbjHCwLbY8LqpQ8PBmh7VA/cwU0E=;
        b=m1wDMNbKQex77GuTlU5+skb5l8cZdzF7kNI3HPNE8cQmGFBDeoAAfO3z62VHp2W3S6
         g8hW0/7uNFuyEGt2cBpWlxY7pcdErauqg3dyEdRwrM0YzVCRm1joAJpAAV5NNdVsHQoF
         hahSKm6dCyKXf1Qc/eKCUHyZ69K7r1luODPcgcG5j0yP0ohshKObaq7m0ImYa5GWbCry
         9Al1nVGzFju2O2/uydbJISxb5xBQhjAZqCnMhAz9VcnbR6pq5rT9YQjA3ZD+kQvHIDEE
         6sfiAKFL4nt2J7KcscGOnWoI8wLfSRKUNDg4gXyWvv6+zlHwL+czM74h6/wzk/VJYSXm
         F+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAgKFkUbajfTwkiBbjHCwLbY8LqpQ8PBmh7VA/cwU0E=;
        b=BEkM7bzKBgqVtypGKDKk++6ZyQEyKjjURJyU+cQXR33eIcA3E3nxoNGp/1GjR7O1e+
         qPJHC+ElRqrLIWP+dG/9m03cTTtX8VCAfQkpQoIEeFq9Wbo5AVtLcTZphHVcEJyVE+SQ
         6hja7rZ6Hc4ZnDEQOepET4/BWDLL8jod2qkutXnYP8OtX0YYdfD8tim/4C3JLe/hJu2s
         NKhiBn+/UpLtTZZOr8y//yetLJQoEwO9KnzbeCco06QJTCBcqytg5Qa9NC2tARsArrDO
         WFd5lv1LwwSPN3V6iCSBmXrhh1+f96SpyOSoemsPh4jo4W5HBTwm0CjszzBWDrOMXFhj
         p3UQ==
X-Gm-Message-State: AOAM5303mR+wht31yvpiJD39jW8BGk9Xb1Qef738IMF6SXPpC3N+t/Ts
        QwviYp57WnvPmAFy8OkgpBI=
X-Google-Smtp-Source: ABdhPJwgvhGuyBEvsRLBj8pJVlv1MD8sM4alBQQIq3AaHw/fvXpcPyQjXZnukRoS19wBBYBX8H5fjg==
X-Received: by 2002:a17:906:524f:: with SMTP id y15mr2973184ejm.65.1618487785620;
        Thu, 15 Apr 2021 04:56:25 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3ba1:ccd9:cd93:a8ed])
        by smtp.gmail.com with ESMTPSA id s9sm2182461edd.16.2021.04.15.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:56:25 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     vbabka@suse.cz, daniel@ffwll.ch, ray.huang@amd.com,
        akpm@linux-foundation.org
Subject: [PATCH 1/2] mm/vmscan: add sync_shrinkers function
Date:   Thu, 15 Apr 2021 13:56:23 +0200
Message-Id: <20210415115624.2904-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to switch to a spinlock and reduce lock contention in the TTM
shrinker we don't want to hold a mutex while unmapping and freeing pages
from the pool.

But then we somehow need to prevent a race between (for example) the shrinker
trying to free pages and hotplug trying to remove the device which those pages
belong to.

Taking and releasing the shrinker semaphore on the write side after
unmapping and freeing all pages should make sure that no shrinker is running in
paralell any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/shrinker.h |  1 +
 mm/vmscan.c              | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123650e2..6b75dc372fce 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -92,4 +92,5 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
 extern int register_shrinker(struct shrinker *shrinker);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
+extern void sync_shrinkers(void);
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cbd7a1..46cd9c215d73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -408,6 +408,16 @@ void unregister_shrinker(struct shrinker *shrinker)
 }
 EXPORT_SYMBOL(unregister_shrinker);
 
+/**
+ * sync_shrinker - Wait for all running shrinkers to complete.
+ */
+void sync_shrinkers(void)
+{
+	down_write(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
+}
+EXPORT_SYMBOL(sync_shrinkers);
+
 #define SHRINK_BATCH 128
 
 static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
-- 
2.25.1

