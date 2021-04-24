Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF936A043
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhDXJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbhDXJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A70C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j5so49707920wrn.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAeg4inHkDxK0M8FI/mGa+6PBLw6yGrM2ERnE7fCtjI=;
        b=FJ0LmHVp61HQB1frczRqCYs8dvGxgUeD1hHbuvptty/aH0ql8qhBg8784TWDGdIN0i
         XIXYXiOFqNEjF95GM99G1MkxTg9+0AGKjlZwEdGaq1hgXOia2M5PsTaJEKPkoAeO0ccE
         +YzBPim/dEWkECBBKq08mr6mXspvdkYZD4/ZumZrJRsX9DZCCFm1FEbQVAru+72O2cg/
         PLT7U8wwIri1E6/qlDoduq1a9OkDEnOa9HALWf3K6MCEbGI0Ak6XCc8oJpVXsIKG/ap6
         uIvnYXf+OH3vllbt6kHk96QrZtwiYfOdEXWL6H3lSICzmS/KiXzJPGCwQL2cywEwKG+m
         dFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAeg4inHkDxK0M8FI/mGa+6PBLw6yGrM2ERnE7fCtjI=;
        b=Stmrjr7hv/8uNWQNq8FdxBVOKbn7NkTaHGGWv6Xy9sN55b/+uqWTgD7hgyWBoesbQ/
         4u5c0r7o/W269MObaFcJ2FS4fyu9OSVv33jfmb5Ybu/sZnOatx4qOgn9HybbmNCzNxWz
         keZnI6oRkWoL44Doah6ul6fzFMC0KLMKj46AiEmlSniMLkMj/+EaO5HRSjSGju1iZ8n+
         nCyEIKuFIdopNcmgtg3GrwZgzCJRuBuOY1NyZWu6znMcMJCtmum38gWOhMTCCS6y5KpP
         5yyhAbza7suPzGzh1v7cWwUrC6oK9mWoAvsj4asQWomk1ZKokWx/hNA2WKHLzwMUQd48
         8vGQ==
X-Gm-Message-State: AOAM532oNHn++SrB+pTmgrvKvQw19GzJ/Dc6hT9zcMmFWIhMK7X00E7r
        CCvWPaAwFnb8aHEhi4z8FkV/pWQbYIIGyA==
X-Google-Smtp-Source: ABdhPJwKoOp1mrEhDd56ZWIWP0r5t+qVFKHzcOOxf//UTIvz8e8gebk/0Oe+gg+2TyCrL8FglIrWBQ==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr9780083wrt.60.1619254962245;
        Sat, 24 Apr 2021 02:02:42 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id i9sm12674061wmg.2.2021.04.24.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/50] staging: rtl8723bs: remove DBG_871X_SEL macro declaration
Date:   Sat, 24 Apr 2021 11:01:47 +0200
Message-Id: <1a0949adfc352d2560e9a68d340df386d94a79e8.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DBG_871X_SEL macro declaration.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index ed75db1b16f8..fbae0d3b168c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -158,15 +158,6 @@
 
 #define RTW_DBGDUMP NULL /* 'stream' for _dbgdump */
 
-/* dump message to selected 'stream' */
-#define DBG_871X_SEL(sel, fmt, arg...)					\
-	do {								\
-		if (sel == RTW_DBGDUMP)					\
-			_DBG_871X_LEVEL(_drv_always_, fmt, ##arg);	\
-		else							\
-			seq_printf(sel, fmt, ##arg);			\
-	} while (0)
-
 #endif /* defined(_dbgdump) */
 
 void mac_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

