Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819BE3F7182
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhHYJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhHYJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:14:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA95C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:13:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so26221769qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDYYa36hmcU1+52wobsB0AhnmKTAEQPCAuaFYGhNwag=;
        b=SigNZmWDlT3HALfmvWtNmd97JzvjZOFZ1sFfu8VwFxV0o1Ft09eRB3CXup/ympRhDz
         CREkW69WIOqc1+MPVFzBDiD1E8V+8FoSX/pwppdEl4dul6VWdTG6PtRBGm+ClZnks507
         IjJQ5tfiOQwhHwiuctxAKaX0HMA8mwu5tY+qeNl2ZugHKaezFgpU/PFL4Ew5EoZ/hY2u
         HGfFrL/e9VVPfl167mlzWrcWpCtT67gQ17lBSfKtMNEhm1jl3qdZGSMaWPmin6Zu7uTg
         ERQej76GKc6IAim0BiCwbDwy/JIs82uhSpu1bKTr8tRgDNvXt867PbYhWriftlC5toUv
         PISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDYYa36hmcU1+52wobsB0AhnmKTAEQPCAuaFYGhNwag=;
        b=MNeVeCVdJbVjxdFafGN6uD55diPnsJzieNgNXaf4homCvn3W3HjSYlGlcCJzL0m2Yj
         q89vx7NpSF/saLxzpf7OIi5Oi7zuWFhDyPffNz8aptxpN+0PgYS1Cwzyu1CK0ERTDUzh
         VEPPDbyOR5sGhDVzMSp+hOrw2qTKZizkwAKF7nOiXFgSb0dijyTI+teJkJTbUmvGQdU9
         nujycRlaq5yr6pQcqSqlmnkRlpMw9k6yBjX2JEBsaJe50FpIwZiDV88r40nz2gqlDZho
         h6cEJ0WvqrLGmrtmVxa8DgAWbHXNRpXMh9lDnIV/gc6mTzUJQytf9eyPccKqJC3w+cQe
         AHcw==
X-Gm-Message-State: AOAM530FokdFYHiVox+MGscQCcJtmI8UC3ENAufMm5a2by7VcZNWGFgd
        jf6b+LV19m5ysOpGnfSBh28=
X-Google-Smtp-Source: ABdhPJwTq98JPs/lXojj4EXvm3vcKzzdaq5QuTVHNP8eI+gMqNvVexdp9Dg0kH1paqW0QoTX6T1LLw==
X-Received: by 2002:a37:741:: with SMTP id 62mr31809496qkh.490.1629882796020;
        Wed, 25 Aug 2021 02:13:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a22sm9824878qtw.59.2021.08.25.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:13:15 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915: remove duplicate include
Date:   Wed, 25 Aug 2021 02:13:01 -0700
Message-Id: <20210825091301.71544-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Clean up the following includecheck warning:

./drivers/gpu/drm/i915/selftests/mock_region.c: drm/ttm/ttm_placement.h
is included more than once.

No functional change.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/i915/selftests/mock_region.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/mock_region.c b/drivers/gpu/drm/i915/selftests/mock_region.c
index efa86df..7579300 100644
--- a/drivers/gpu/drm/i915/selftests/mock_region.c
+++ b/drivers/gpu/drm/i915/selftests/mock_region.c
@@ -6,8 +6,6 @@
 #include <drm/ttm/ttm_placement.h>
 #include <linux/scatterlist.h>
 
-#include <drm/ttm/ttm_placement.h>
-
 #include "gem/i915_gem_region.h"
 #include "intel_memory_region.h"
 #include "intel_region_ttm.h"
-- 
1.8.3.1


