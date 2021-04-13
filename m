Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E935E208
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbhDMO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbhDMO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:57:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF01C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so1487860wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzC9o1o0ixYi6KaDWY1ROlCOIjizjCzFaIisDwi93jA=;
        b=ZXQIvdG4cueOAiKgR1dkY2FHoGmDdDx9BW+DKkyuZ97q1zI0c+v6z451JaD2NnXLDT
         K6IAfC+jZwBYasLfkjvTxMsPUwHF9n3hhrcactyKDYaFmE9mpXvq6KqBVwZx/3cVWW1m
         Qd+0dhJitY5FTgFFh9jSpNU9F7pBSACp/WR152Zka1svmO/f28rUCa2v2wNpPk+Nx0by
         L996uBwmF1x6jNNcRtHB31pCiAo3HU5w092S08sBgSYJUz8OXjNhbo6p5sN0KAM4bkC8
         Yx+yAXNYRzhIRNfr2ORz6e2lOqCuKVtKKLwzDgEf1U0c33UA1/xN3c64UxknwOoNvarM
         WsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzC9o1o0ixYi6KaDWY1ROlCOIjizjCzFaIisDwi93jA=;
        b=NVxZUi7B7zdpOz3jahS7QxHuOHKGZg8IpTPK7BtrYIJRzYLu/7b+GdWEWd6+vkCrbd
         /+Q8flX1/xcGLgOaCDtJxUEcIJyJXpTJbLOOdP6QC3j9EI/LR/wEV8HcLq7bOibP8ymo
         cIHVcO8KXwPzlZyEczw4NAXQwPLISD0WXSsFIc4L0yaWnH12InRN86+ZTdFaVEYuHLI0
         abwnGk3PDofZWvtaPuWWFSjh04Lo7eoCl+cjzRdSh6MEIzr8ZeyBtqZZA4y2B4ok+oZW
         LMmJAzpelPkrob0OMrtWKIS11chN27NulScaJ/QF8a0KYoaHPduAWUsCcZRMMF5HEA6U
         4jZg==
X-Gm-Message-State: AOAM530kLd7wbqUIIybUB6F+KjjNsLjtqZ2xtOSHN/ZBxGh/LS5A1OuM
        h+goAuaPmzwJCNsXy1Osp4S1y4X8l1umNQ==
X-Google-Smtp-Source: ABdhPJz6wFcoch/aPfJrl+C6loZNKPNi5iIF+QptdhqBzlN9Rf41iqpn/4gd/SzHExuJWHPQS/awYw==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr406263wmj.152.1618325805971;
        Tue, 13 Apr 2021 07:56:45 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id b12sm1355799wmj.1.2021.04.13.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:56:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: rtl8723bs: remove DBG_871X_SEL_NL macro declaration
Date:   Tue, 13 Apr 2021 16:56:34 +0200
Message-Id: <ff741a820e15ccf1c56a2106af69928ef4e5c197.1618325614.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618325614.git.fabioaiuto83@gmail.com>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DBG_871X_SEL_NL obsolete macro declaration.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index f1b37d511f27..12873c3d801d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -181,15 +181,6 @@
 			seq_printf(sel, fmt, ##arg);			\
 	} while (0)
 
-/* dump message to selected 'stream' with driver-defined prefix */
-#define DBG_871X_SEL_NL(sel, fmt, arg...)				\
-	do {								\
-		if (sel == RTW_DBGDUMP)					\
-			DBG_871X_LEVEL(_drv_always_, fmt, ##arg);	\
-		else							\
-			seq_printf(sel, fmt, ##arg);			\
-	} while (0)
-
 #endif /* defined(_dbgdump) */
 
 void sd_f0_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

