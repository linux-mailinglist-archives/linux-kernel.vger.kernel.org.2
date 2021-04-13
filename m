Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C945935E204
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244724AbhDMO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbhDMO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:57:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB7DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so8913893wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuGgfLKupLbilqe/abvITO4+NbqEOUhJydw5ktosY2U=;
        b=JtikVqNzCVWPhSIuj8e73hDmbSRhwxEFds6eZ14gXvou4K4Ofl0Oyxt7YUQ3aDFseJ
         UbGAUFDYHrE1m1eZvX91G9qw+KbVGh+eAAgXSn3nNv3RvQygR0aHI2UXFUnNr0jqlR/k
         ciIgU7BPJp520GTV0Jbikc+RrjrP3L4yGRmtV8ECwVzmKG2avv5ZPyNX8PIB6h+MQgCq
         vP1AG1sWZcbZBvGnIFAvcIoXZeQwsaLNH+eciP0PMRN5ari0meqdvD1RjgylPggIMCav
         WG/THW9+e74p3OSEHgHFuqHbEl1Xd9OJUeMjIu6HSSD9nFJzrgV3BK+TkVFHz8EWKurL
         zvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuGgfLKupLbilqe/abvITO4+NbqEOUhJydw5ktosY2U=;
        b=X4V+UW+g1HC6etrzNuFfF7Z8iaAzatmOehBwsEHtEDvsgDTzt9BjyymZ5x7uhn1GZb
         sG2j/v6391X4MHoKm1tS/WYKEf6DnkgQyMg1XQeW6vY7oc1Y/9lraX1Ne+NG3MXp19jP
         fLL5LfIlfcpIPE2UWNyN4rpIyuGSuPy3s9wfzq8NXX0xrgbm82VFWfJiywENPKBmOnhS
         Zq3XwRM+5QgNXuHnSeRwf/HfVu07Z6M8E6j+SgD+zI+lzAcAFzh0Uhiw6CBI8KvGTVNJ
         PJW64uEz/zcoy4eOROSJzv9OSwYHIdl8Oy4RuJiQKteQXFTThY1yglBFjsrM2IPwRBvl
         xDcw==
X-Gm-Message-State: AOAM533hWG0uUPx5tisr5T0E0C4LV44ldy3VKwOgf0AcIAdVAKdbMiBr
        dCe0iH4czmbfSU/x/RW6UCUVThqkQQNfjA==
X-Google-Smtp-Source: ABdhPJycRHRBPJxQMUKwoCFVTOW+SGfPwd2DmIislYCi1LKVxB2NjrVRpRBQnwKcFFL64J79uCnZIA==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr440042wmi.48.1618325800163;
        Tue, 13 Apr 2021 07:56:40 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id v3sm2641828wmj.25.2021.04.13.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:56:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: rtl8723bs: remove unnecessary dump_drv_version() usage
Date:   Tue, 13 Apr 2021 16:56:30 +0200
Message-Id: <9ce6559cac69eaebfdb07206921d14e99d2b1967.1618325614.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618325614.git.fabioaiuto83@gmail.com>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary dump_drv_version() usage.

This prepares dump_drv_version() for removal, before
coccinelle script application.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index a9a9631dd23c..d5ff22ebbc5c 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -491,7 +491,6 @@ static int __init rtw_drv_entry(void)
 	int ret;
 
 	DBG_871X_LEVEL(_drv_always_, "module init start\n");
-	dump_drv_version(RTW_DBGDUMP);
 #ifdef BTCOEXVERSION
 	DBG_871X_LEVEL(_drv_always_, "rtl8723bs BT-Coex version = %s\n", BTCOEXVERSION);
 #endif /*  BTCOEXVERSION */
-- 
2.20.1

