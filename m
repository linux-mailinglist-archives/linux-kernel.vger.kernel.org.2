Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10DF34A3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCZJKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCZJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E8C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so4905955wrc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mH/dwYStT+su/I7fi8ps0q9leXB5uDo6M/V/p6K/BwE=;
        b=jMYN+/cywf2MvIRg+/Q1Y6lEWrmiDP9FUH8H2OH9O5CYYtAqyIXvH08HXt6hyOJOc+
         57Z92r+zb54GYycIBeD6AdfceTGO8ypGmD9am9nSCJVintpOHjJFQcYrm35qPVHjBzSz
         vEAkfL/9dAWEr+apJfWmWzM4e7XPrMMtog0NIJHp+J2lds0tLQfIY6Bbtue1oCZxPPpb
         bkVXxAvjsqj+Zuzb9dvVRjUqBVj/AUyRlSyGwrXDsKcK8Hj8LZjgFgwfZvYcne1hJZ9A
         rHkW6QR4lddhOa4AAnsMAg6CCbFXbBzSJ6nsRDcw8cB4+WmLvITNojhfr4+qeiUy0I5b
         F1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mH/dwYStT+su/I7fi8ps0q9leXB5uDo6M/V/p6K/BwE=;
        b=YakQuhtB1NARmg4vkrnMVWtHb8mw9E/BiQMsPcj7UWy7oph6O0v0C0gPCcdbNAioN2
         FwFpFXw2LzEXo/7HBxqqU+QQGdBO5phMcaZzyrLKU0NnTjQJFDd7MHOApBXAD1465jp8
         UwBIxCiJV10XcBMZQ2o0vO5DL0lecri1J1lO3Gj3LUrboqrSp+XZjMkVSP38GuXhQqc1
         uWevVzAyW+tsDY4OmCxLB4Qh7AVAs/B/+cGNrPuRaltdrA/3ztrTdk5up2rhM0QeKwj2
         12XW+/Jom+aT0soAcF/DdlgMOE2jAPxB24gz5x96/Bs7uhffe+1pdJrbsCZPNZ0DO9ys
         3Hag==
X-Gm-Message-State: AOAM533L/Dh0Ylc3gFBJ7+5XB5TKRC3Z3euZ3jNnAUK+fuGfAU60FZlB
        Raf9SrK84JTkaKL7jWNEg4A=
X-Google-Smtp-Source: ABdhPJyxdgyYqWY8czGdTqa4KnglCMlOmOIX42QOWjwETtVykzhj6yFHjq8hR41bxfoXe8sg2OTyww==
X-Received: by 2002:a5d:404f:: with SMTP id w15mr13890196wrp.106.1616749789034;
        Fri, 26 Mar 2021 02:09:49 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id x25sm11277320wmj.14.2021.03.26.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 05/15] staging: rtl8723bs: put parentheses on macros with complex values in include/drv_types.h
Date:   Fri, 26 Mar 2021 10:09:12 +0100
Message-Id: <fea98d1b0260494dc5cb0dfb7fc03d6f74d9acdf.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros with complex values should be enclosed in parentheses
279: FILE: drivers/staging/rtl8723bs/include/drv_types.h:279:
+#define KEY_ARG(x) ((u8 *)(x))[0], ((u8 *)(x))[1],
((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 1658450b386e..ead4cb9c1e5a 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -276,9 +276,9 @@ struct cam_entry_cache {
 };
 
 #define KEY_FMT "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
-#define KEY_ARG(x) ((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
+#define KEY_ARG(x) (((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
 	((u8 *)(x))[6], ((u8 *)(x))[7], ((u8 *)(x))[8], ((u8 *)(x))[9], ((u8 *)(x))[10], ((u8 *)(x))[11], \
-	((u8 *)(x))[12], ((u8 *)(x))[13], ((u8 *)(x))[14], ((u8 *)(x))[15]
+	((u8 *)(x))[12], ((u8 *)(x))[13], ((u8 *)(x))[14], ((u8 *)(x))[15])
 
 struct dvobj_priv {
 	/*-------- below is common data --------*/
-- 
2.20.1

