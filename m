Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754DF36FCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhD3Op6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhD3Op0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF3C06138E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so105628793ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6sZe3osaLDDSPNYI5JYp+0cY5GbbYZW8NCqEYTYFpk=;
        b=kpYbP3v49ZrJXNwFUerq2hy9le+XzMitFt2alpXjW2HSr6gqoVABUkUrVDPHkflZma
         a8T1smhe3QwTby6/jtxzmRrGrKHWX5yL+cVC2Q4rETf9B3E7+k5VmvmvvoLgD4oPoV02
         Lt21ZLItPpencJ6U5/GMgKU/6zY2igXvHVZdYU5rqwXZJzg6UaIDte5jqeEDRcNrWBNn
         xzXHQtvIK4GAjTiV7hQ83ilqYYKO8shKFHMgUITs3kIWNLTGgjp9clfEMoVVc6QzRUas
         hXxIZbIoKcJAl2yrtXjwnGWapjNDvIfngvjiY7UyCHMIU2fG+TjDUA8dH7HOkph7BRdz
         19Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6sZe3osaLDDSPNYI5JYp+0cY5GbbYZW8NCqEYTYFpk=;
        b=LwEXYQYIwm3BjKPDxsgVAZDMpZ5z947ohsohU+CQmj/VbICN4m+wSsTVYQIzsG2Qe0
         ONNYbNRdPreCB6Z9dE2cTmoaVo1A7GSO8zqSpcZEHG0fP2ie6v8YsvdRSct0vc12k3v7
         kmdS/4MiJz2z7v302TGl0IDAQ7Uwl045BpbRJHaiysu07dfXm9NJXQlEz/JUwH8fb3Ou
         Tjl3m+xN1OjE9xhp2j6fHR1yAileDXcQgHovuhoRktRjtiE2J8S1UvWJP0c31aD0yiI6
         Pyza67rGtKemfkAETp/odnTROuIvP1lUj9oCtd9ThvrfwnvS+tMJWjZ6J5IuuHOVD1v1
         Okcw==
X-Gm-Message-State: AOAM5320qrugvLHZBur0g/Rt3Nbib5Lel1VLY4kXLMZ1sNQylSesMj4Q
        Vc+0l2okTzbvI4RGwu+r26lLSKBp4mk=
X-Google-Smtp-Source: ABdhPJy0Lz6O3LYFyKcHfI3WF1K3JbYsO1gUycGds5RHf+oQXAwlKtyyI4BRHUjxCGS5v8Bywyfl7w==
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr4774831ejf.131.1619793876943;
        Fri, 30 Apr 2021 07:44:36 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id bu8sm1536032edb.77.2021.04.30.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/43] staging: rtl8723bs: remove empty ifdef block
Date:   Fri, 30 Apr 2021 16:43:45 +0200
Message-Id: <21cb62753847caa30017b04004ead2b6d75b3191.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty ifdef block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index c359eabebb67..8ae9948fb0c6 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -95,10 +95,6 @@
 	#define ASSERT(expr)
 #endif
 
-#if DBG
-#else
-#endif
-
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.20.1

