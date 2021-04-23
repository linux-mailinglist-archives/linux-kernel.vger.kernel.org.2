Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8D369578
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbhDWPCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbhDWPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:01:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A7C061364
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:00:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso1405065wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/TJrGDj05Z5uJLXQBzCdRgNPqtzRz59d+0oYJlq47g=;
        b=M/G+u2eAVb66uZ6uPLMa7JVEFc/VlZSxwEun4bYzU8pctXVzR0l1D/uakACu6kcvDk
         gWrmG8wS8bHJqRPKZPuDR0HFx+veyaR7nDKI7imS8YIDWftKM2KUOMNhHmFry0AsG+jB
         SY0juGFAPmkn1L+fp+jAl1mFmP7UmwZS0+jaqQGhnk3it6Y6fFveawzHCC7xAjt45BAO
         VAVodtv088CyvXj4WG1IcrcOttjA8NI96vPL9fjjj0m7La0cXOHgNfN1HvRjA54daNEP
         I1s7J+0bcQ6Nqxp+l6dMQVn2wjMv5ByvG7xSQMVJfOB/FDrS54qNOOEEuA3gDBBM5ugg
         5q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/TJrGDj05Z5uJLXQBzCdRgNPqtzRz59d+0oYJlq47g=;
        b=NTCMtyMV2WEaw+KvPI15HH8kMq/pmDiiwwlLRpKKqdE74ffyagAUqHG0dKBe+szSkc
         ydmIJWbYqWb0eCQkr+hkqmcP+ewIWwgVFSxNS4Kk8TuwPO7HENUHN6/NLR7dG82ERN9+
         ZOGdCpHfdza3JK3bsfoH9LotYs5+hQOcquoQZ+8yJCU+iOOXecNAlWLRFfVrLZHAMWSo
         +7Imx9v2UO58Jz1xXKJz7OBR3c28BnsQllSRIPLIOHQj3cCbzQ4yubTs9LS5mY2Mmz45
         riQYcjDiWJdQaoL7iNMepStXg4crFcVfqDOImfWhN+CVRPNujp6TknzvQAbyki5aliPf
         WueQ==
X-Gm-Message-State: AOAM531e7UMfA+VadRtXPt5I/Ht39akPnw99nK28DXAOYNku80k6QSOe
        wTQQmL5FVV8pumz+/4b8rO42aQhKFOY=
X-Google-Smtp-Source: ABdhPJyfpHJpr8wB56AVdcaIDqjelwuCdW1B04lxIGTzRcBqoeh1S6m3MCBEtPe9t04gzdYNlrpmbg==
X-Received: by 2002:a1c:f313:: with SMTP id q19mr4703267wmq.142.1619189999774;
        Fri, 23 Apr 2021 07:59:59 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id f1sm9394567wru.60.2021.04.23.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 47/49] staging: rtl8723bs: remove unsed debug macros tied to no particular code debug
Date:   Fri, 23 Apr 2021 16:58:38 +0200
Message-Id: <8a0e98c54988c5abf0669e261a6dc4eda63e4be1.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to no particular code debug

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 6b657190b124..c9f53c08efbb 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -11,11 +11,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL8192C_XMIT_C_
-	#define	_MODULE_DEFINE_	1
-#elif defined _RTL8723AS_XMIT_C_
-	#define	_MODULE_DEFINE_	1
-#elif defined _RTL8712_RECV_C_
+#if defined _RTL8712_RECV_C_
 	#define	_MODULE_DEFINE_	_module_rtl8712_recv_c_
 #elif defined _RTL8192CU_RECV_C_
 	#define	_MODULE_DEFINE_	_module_rtl8712_recv_c_
-- 
2.20.1

