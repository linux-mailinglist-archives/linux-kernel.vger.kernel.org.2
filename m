Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D2B342F08
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCTSjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCTSjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:39:03 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9EC061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:39:02 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j17so6685945qvo.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M6lCP9ZQXqSKw2H5nPiVfJGz/VI9ebKiogBmatzcLK0=;
        b=jLe4yv8JhEnQh8u9zlv9ojXoeX7siCrANFXrEC2KqtuZWv1D9lHLRZFhhxEbWltg5L
         vsUYAQJB3lNkCeVJhs/ffv1t7dLCo4O2cRi9EwPjd+lJ+sEDdWh+UMdZ1MvO4jWMGUTZ
         Xlk4JXvZZ4EgZ+0yXIdNidwJ9sAwcF9HgUdgCDC0P60sihoJT0s0aC/Orf5cDvvjdUqh
         /nBVcfSIz4xEcOw+KlpzCupyGaGPBwudLJtZWjmtHkAmo61gHcLV3bNWIjlKBcvEcd5m
         /myijbP2la/KF/p+KOUwcsVXhIU2JV0vR2BDNt9MN3LhHLuqMJ1KrrjbADi+ta6t2LeS
         Soag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M6lCP9ZQXqSKw2H5nPiVfJGz/VI9ebKiogBmatzcLK0=;
        b=RGL9DdnsyjEXDtohXutiJhR7PK/nfyaarM1/VfMthqvCaohu3rqVDLjgsKxpCbInQZ
         VKcRbUNNYAKv6VAvI6Sq0biQIYpZ2Fj27ib6HJBldC/cNnnUDw5bGtF7TKYJXocT3Ciu
         1jq8LMZ0/ADl70uMTC1/+72jhat5CI+cnOsx7nhvH3YkxtKDyIy2hs4y1TC1KVc5bpHK
         HORVVNyZy5YLUnoNpBnnKZTUJ1NLT8QVvbic+l0Ew4ks9R5xRCDsYcOq8/Zm6XPIJd2t
         dQRMnOalOhA3vrNz4GuzAH7wNJEXqh3pH7ZK+x+05YXYUleAIGcXVXmPQwFZDmlccckV
         oMKA==
X-Gm-Message-State: AOAM5301PSTH4kYg8VI3NM8cfA5xlOn40g+qQby1uwu1zuOCcD+MkESu
        TPCPvSSg4Ih5ZYt0ciYvbcg=
X-Google-Smtp-Source: ABdhPJwzGPbMco6q3X62epIdFv94rQmQwe/KlKVnhpvRcQA7B9fZyDHIrCbMuF0c2UteJxdD9vBddQ==
X-Received: by 2002:a0c:c345:: with SMTP id j5mr3360366qvi.52.1616265542076;
        Sat, 20 Mar 2021 11:39:02 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id x10sm5879916qtw.17.2021.03.20.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 11:39:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drm/atomic: Couple of typo fixes
Date:   Sun, 21 Mar 2021 00:06:42 +0530
Message-Id: <20210320183642.10886-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/seralization/serialization/
s/parallism/parallelism/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/drm_atomic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index dda60051854b..e1e4500aaca4 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1148,7 +1148,7 @@ EXPORT_SYMBOL(drm_atomic_add_encoder_bridges);
  * This function walks the current configuration and adds all connectors
  * currently using @crtc to the atomic configuration @state. Note that this
  * function must acquire the connection mutex. This can potentially cause
- * unneeded seralization if the update is just for the planes on one CRTC. Hence
+ * unneeded serialization if the update is just for the planes on one CRTC. Hence
  * drivers and helpers should only call this when really needed (e.g. when a
  * full modeset needs to happen due to some change).
  *
@@ -1213,7 +1213,7 @@ EXPORT_SYMBOL(drm_atomic_add_affected_connectors);
  *
  * Since acquiring a plane state will always also acquire the w/w mutex of the
  * current CRTC for that plane (if there is any) adding all the plane states for
- * a CRTC will not reduce parallism of atomic updates.
+ * a CRTC will not reduce parallelism of atomic updates.
  *
  * Returns:
  * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
--
2.26.2

