Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D7398D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhFBOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:37:19 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40545 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhFBOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:29 -0400
Received: by mail-wm1-f47.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so3907735wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvuBm7KpIXmVjvwi2OsKGMdogxy/zdINv8FqDSEvNYM=;
        b=nH1tswbv/dRTxAbMVL2oQ+YkAIasGdidijupRDL7c3sCfVwK+oNtIhOPL0xok9gzVW
         t5+ceR05rXZ7uMo2uFij6BvFfqXaDmi0JMWGswWKDBNIILG5hLPYn20T6fCzdxolvyPX
         +XTqGQ5X5YYinYoN2/mYvDaKDcYXM0/IDw799rIPSAk/3ROkjHPygpnIc7Z8qekh7XqF
         ANhYI2NCG0tckEoHP506uUWeO9SDw2dESxg+EJ8Be80RUywMFpYsHwunvITnn9pQm8V5
         0tiSbn6+yxv5bdePKcmjb5leSF3Dh/kD4YgCPLWnT+gapDJbriqm67BYzq1bujgpWvBm
         NwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvuBm7KpIXmVjvwi2OsKGMdogxy/zdINv8FqDSEvNYM=;
        b=K6boYqxR9ZtI3QDFKIbxG9o3hQ9pi4xqmRcDt68Izy/ZyhQnDKbK8/ikYDB+wfHc/8
         /v3Nw1YeRMo9RBOXPzBXjnunSSlZUPOI/u9/ycqeZt+xseedIAIkdrkMDtWkJBpOQc0/
         bnUFEPB1Mg7K/Kfh1XqzsV7M2mbWuxcb+fRgi6kqs7kTfOwbL6+l9H/GVgeJcnkPmm+3
         +f7UWP0i7JJ077y+XoifMVwku3SsiouwiQJ4tlji6T6q4/OGJX2gwE3Z9kCRvbvUkZUZ
         hvQGIkwUyaLhP067abqn2WV23uv7A5k6qCeS4d9dI/sv26ehOwkzZc1ZGPQVlzWJeiHr
         LBWg==
X-Gm-Message-State: AOAM530BNKJCDfCFzPeoacutppPhYfB41G6Bn0o/aTSPoXVz2olJiHkQ
        NgR9xWoGTlhq/SHZmhJWrPM03Q==
X-Google-Smtp-Source: ABdhPJyUgla3FFfynuCl+ad/SpJvdCBqRlxX5f3USSzH6/SPYgduUsfipkbdGBvQZ5pWNouc43kgzw==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr5498913wma.60.1622644412785;
        Wed, 02 Jun 2021 07:33:32 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Adam Jackson <ajax@redhat.com>,
        Ben Widawsky <ben@bwidawsk.net>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [RESEND 22/26] drm/vgem/vgem_drv: Standard comment blocks should not use kernel-doc format
Date:   Wed,  2 Jun 2021 15:32:56 +0100
Message-Id: <20210602143300.2330146-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vgem/vgem_drv.c:47: warning: expecting prototype for This is vgem, a (non-hardware(). Prototype was for DRIVER_NAME() instead

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Adam Jackson <ajax@redhat.com>
Cc: Ben Widawsky <ben@bwidawsk.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index a0e75f1d5d016..bf38a7e319d14 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -25,7 +25,7 @@
  *	Ben Widawsky <ben@bwidawsk.net>
  */
 
-/**
+/*
  * This is vgem, a (non-hardware-backed) GEM service.  This is used by Mesa's
  * software renderer and the X server for efficient buffer sharing.
  */
-- 
2.31.1

