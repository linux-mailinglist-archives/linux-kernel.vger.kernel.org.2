Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7236FD07
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhD3O6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhD3O6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6146CC061348
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i24so23399942edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8g9oz5Ic1TCmyXqC+DaCK2PY+uamXld+Xrd0WiL5ARM=;
        b=VNnsSkqa3C2GF+kuQHpxyJtcU9VBgWTDsq7gFixF7D+6UNwn7hl7xWfiPDg3Qwe1si
         Cv5UEWeizDJ/GonRJtl2ypfzMbRuLeBJEpHBzK2Sr7cEixza6Y19IczfxyYzff41S4DI
         L8IYhAu0fMhzNc9JlHvnpSzhfeh2XRUhG56DIz+HCF+YrRzIQ2IXFNCcBmd1LLlAy4Jv
         29bNmBtaymWHVLn5fXJAbWA1voGs1/NTEb8HCQdll+c7pQGnS7NYUJxcBrGbMx6MCbHs
         1rlWKU/kUW12X263NkBRx/hXVg+a42g8Pm9hQIxXHltmNM9OzwF5j2vMCVDcsto/L2HA
         RY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g9oz5Ic1TCmyXqC+DaCK2PY+uamXld+Xrd0WiL5ARM=;
        b=FYLyVJzNkP0fvgE873LhxCfn3oySeI7zLIFDSYT8GFQhsOyaevbyn8F7ixaXz3k8dS
         vnnrp1XZbf0vdgv/usqQKL/n5XyJjiSLyeNyn5bvuf+w0cQ0PN50yaFfjwVEpSo0N15z
         WD25B5vLv2qM5vh10y0NY7CABrUGjJxNVDXlXf7MWMxh4CtBruvmyvLAOHA/cA7b4Tty
         HU2j7ToTy91QdBjPd66PvcKEUrkEyMk4/WE65UAL679jv9o9UJMBZn9J2NeUPmiC83VL
         +AtyMLdMh+t/LNiPbgwBo+498eCr1xNHM2++2PO6k8P1gzv/foYJk07aniwCAeC3vg0n
         DyKg==
X-Gm-Message-State: AOAM530OxZXWrOdwSvE+4+oxjWwMpxkzOixj4voJXe4iAr/lL+gUlZMX
        GFcuxaQ39XS9Csjycw2vkuyW3eUW69Y=
X-Google-Smtp-Source: ABdhPJwECoN8d9kjaWkC4rRv8kqHXqoQJEQYyNydwPtr4a0D2fwx5Obv0enK5Ej7nHLeEKh2XG6UHw==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr6330651edd.322.1619794649635;
        Fri, 30 Apr 2021 07:57:29 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id b8sm2164704ejc.29.2021.04.30.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/43] staging: rtl8723bs: remove unused ODM_dbg_exit macro
Date:   Fri, 30 Apr 2021 16:56:36 +0200
Message-Id: <84b76bc814f44e3b2da92318b05f101f59cf0889.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_exit macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 7c9a87fb8e51..c359eabebb67 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -97,7 +97,6 @@
 
 #if DBG
 #else
-#define ODM_dbg_exit()					do {} while (0)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

