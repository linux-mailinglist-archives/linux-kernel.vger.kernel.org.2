Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F243211E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBVIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBVIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:21:11 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE75C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 00:20:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o21so8690794qtr.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 00:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEsue70XIPQEInMMkgGoF4UA9sanH7a374aFWEVWsoQ=;
        b=Dfuv3wSOf9TNSmJ+wDsYfVCQx8U0hJku/qx541DETfjJYSEr7hA95MwV1cLnCr4p9A
         ZKMNnf7KhPsUagyaP5yvxAZhGYXIAJGi4h74GRjKRr4uuNb6t1g2AYf8OwJFbm/ztFAo
         DxejTTl+a1GO2OF4hf6UnoefACroXkwkLSPtE3TpfghWy+DVW6MNXAbJP3W/TB1IKC+r
         CuzU4Ah1WHiZsIWsSt9nlfEhrayGfJROckKejkL3hcB7+rCaVwN1+H5LXQwh8C9G89eZ
         y8geH5u5QKlQg5E/dYg6Q/XJpKFSbJ2VChZTIaqHfdlj5K1gpIggx0KblPkY01JpCeJo
         9gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEsue70XIPQEInMMkgGoF4UA9sanH7a374aFWEVWsoQ=;
        b=aKNAkv30fRS92Nprmwb816oSI1f/+zblwIZcPDC/G4U2Q+kznWwKaR6mAoEh0Xbiez
         pvvAqPrBQWYG+ljaS83ITkjsA92ND+4kvBzCFkiBcEJxU37Wu1SHq/L6HCmHsD8D0Rme
         voVpLpk63P36N9/DDseMT7ljdScUrNdE3OF6bwhqvQoJ2DG5uN7yv+xyvXe104aL3/dT
         DD6vn5FV9+qbZfgcpty1qa+nBuLXDpMMw+tYuhXd4pRm/xZJJ7W6q+V5QXmu6jG8ibUN
         J5KTNxu4kbnXfGvnLR66PX9VNDFBVPr92dpHAFxemLXlzsdMXuEB7t4Xqo6m9aVpDANf
         nmXA==
X-Gm-Message-State: AOAM530OogpJ+GfiT5phVBrHZwH+wAWz+4B7g/a32DTQ3FzDdIQMSmFi
        rWBue8qKBL6MYc3MgtpWd2c=
X-Google-Smtp-Source: ABdhPJw+6w74sHbYZbuUPQpqzjMte/UAu7Uu4isgDpuMj1BA2fUbg7ij1cTMu1Jdeg9pS8ny1lBxZA==
X-Received: by 2002:ac8:37c8:: with SMTP id e8mr4003871qtc.29.1613982030073;
        Mon, 22 Feb 2021 00:20:30 -0800 (PST)
Received: from localhost.localdomain ([143.244.44.214])
        by smtp.gmail.com with ESMTPSA id i13sm1074777qtv.95.2021.02.22.00.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 00:20:29 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jani.nikula@linux.intel.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: gnu: drm: i915: gvt: Fixed couple of spellings in the file gtt.c
Date:   Mon, 22 Feb 2021 13:48:38 +0530
Message-Id: <20210222081838.30328-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/negtive/negative/
s/possilbe/possible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 897c007ea96a..dc5834bf4de2 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1159,8 +1159,8 @@ static inline void ppgtt_generate_shadow_entry(struct intel_gvt_gtt_entry *se,
  * @vgpu: target vgpu
  * @entry: target pfn's gtt entry
  *
- * Return 1 if 2MB huge gtt shadowing is possilbe, 0 if miscondition,
- * negtive if found err.
+ * Return 1 if 2MB huge gtt shadowing is possible, 0 if miscondition,
+ * negative if found err.
  */
 static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	struct intel_gvt_gtt_entry *entry)
--
2.26.2

