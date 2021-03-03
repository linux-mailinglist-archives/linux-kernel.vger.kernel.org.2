Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9519432BE99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385924AbhCCRdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346041AbhCCNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:52:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B35CC0698D0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h98so23719410wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STeXZot7UNsWfWvi+ECfSVOes0yoTqiHgkq3rfNhNfU=;
        b=eIs+/oNLfkhdj6OT9dHSDH8W5WywMha6aMEKck0RmrxPz7iqr/11jJ4qds3prHui1K
         hck5bggU4m8/bTTDKgxh0Nkpf9mdXzbD9LK780fc9pZOuHC0aambtq3x8UULm1iZ5Zcz
         KrLopof08NjqlnH2p6jzv84EkH39sPi2gyq12F0LKblBEAiwfqPDkmSvMxK78bdvfnIW
         Jif+z9+EU+ox3nnMiPcVh8a7lg3Vdk6yO/f5wfBVB8XQtVBGQyPKJzmMFOapeMA3tH76
         0yMwbK/kOvDFwKk4rUoRv91R35GZiyl1tWhiQFEdbqjhFObsxQCXi61w0V5NM/ri0z/9
         ctVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STeXZot7UNsWfWvi+ECfSVOes0yoTqiHgkq3rfNhNfU=;
        b=da2KJPp0u4tdTD9eSqZck3KsucuY8Lz1JWTGSmNQBijB178bOhWkxyDvuvMAfL0Wcs
         kmV27AfgmpVMlqw83dUrGzBAoPWI78mf80BM3NGd3nHfS5Sd4DWjPC3xV9rehQ69IafX
         X6sGEo0NEEJp2GrhfBGxHBbWBxHwH3x4z/BSJfR57xkPu8grXmQFzuJdjCelVtGG0okJ
         Rrjxhvq4eOecrvrm7tCtxdYOPhV3CzipbeNRuHZmShoHd+78OrloN3wU8IZ8+wh2VU1w
         h78qPuocRdMuVkyWE7kzr0twp6NB+Z7z5fqllSZDT8slqsaUcKaxuZlknzuPSulfCbXT
         zVJg==
X-Gm-Message-State: AOAM530ypftp0PIMAil1TkFqfp3HaUEC/Ji+M8cw/l0O034TfwmfWhT1
        tc+OKlo4Pb5XW5QQPgpjHIqF3Q==
X-Google-Smtp-Source: ABdhPJx3ALBlSbPNO7VGAg22evCyZnjw0EKxLAj088hCAeuLI1iMyd0Gfp/X25XEIyWBUENSWyHtxg==
X-Received: by 2002:a5d:404f:: with SMTP id w15mr22820915wrp.106.1614779070093;
        Wed, 03 Mar 2021 05:44:30 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Rob Clark <rob.clark@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 53/53] drm/vmwgfx/ttm_object: Reorder header to immediately precede its struct
Date:   Wed,  3 Mar 2021 13:43:19 +0000
Message-Id: <20210303134319.3160762-54-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add missing description for 'refcount'

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/ttm_object.c:60: error: Cannot parse struct or union!

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-30-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index b3fdc630497cb..112394dd0ab6a 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -42,6 +42,14 @@
  */
 
 
+#define pr_fmt(fmt) "[TTM] " fmt
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/atomic.h>
+#include "ttm_object.h"
+
 /**
  * struct ttm_object_file
  *
@@ -55,16 +63,9 @@
  *
  * @ref_hash: Hash tables of ref objects, one per ttm_ref_type,
  * for fast lookup of ref objects given a base object.
+ *
+ * @refcount: reference/usage count
  */
-
-#define pr_fmt(fmt) "[TTM] " fmt
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
-#include <linux/atomic.h>
-#include "ttm_object.h"
-
 struct ttm_object_file {
 	struct ttm_object_device *tdev;
 	spinlock_t lock;
-- 
2.27.0

