Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5AD36A06F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbhDXJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbhDXJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778ADC061756
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a26-20020a05600c225ab029013f5867af96so281986wmm.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/TJrGDj05Z5uJLXQBzCdRgNPqtzRz59d+0oYJlq47g=;
        b=WyKQ/elQXjGPgyqgPW5jZuS4l9bgmDHu0kpIEfZGNyOaK6azDr57ES2esfCGmSe6M/
         iO0P/K6wWcz9BVkV1U0Dt045hKlCmrUI2E/k/G/fZpiIwn1GLZ+Oz7viI7sQhznTnlSP
         fei+xWVz6vCBhrxwipRUHoQwBXHiCARqdxYODnPx18jEKJfv+ECU9VFxaEXCHsjq6j3n
         nBWr8Suyiuwbnpmpk3/A5njkSJnwzz1hTZCBbVJrdC3IotiUPvku1lRBqzzSlx0ULRRv
         A0U6tQQ8vGm6KtTif9ayC6BKaKqspADe5UK5Gat3o17rzMx7y6o4iiU1drTXlfKIs6Te
         KNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/TJrGDj05Z5uJLXQBzCdRgNPqtzRz59d+0oYJlq47g=;
        b=cYDsAiQ2FsdDUclvWyrw2tT53dkHyN4co6t0fFEFNVCMk5KWcOOods9+HDzYYDSebK
         8qx/GaBtC8Ydd9cercZerAzFf6TdpI/GhP/tKMHIGJ2n80d3DayjGZHfflwpyqJDMmlJ
         S+UliiBwJ5LYCl4RhhLxAmovl4IrOiYr5ewKUTeFojdBpua2b/+mmywouxWkEF+cR6At
         ebuQEkAHWXSk5ZbiB66mh/Kj+0VhvDv8BetBolpUBgZz6wfxvXEH8qPGK5CjckY/WoKE
         dXZ1u5YTjDEJFRdfbVUhOdLx9Mfafw4pUwijJU7GbXLFjBDB3+XoNl8C1s7MgHG4hvGq
         067Q==
X-Gm-Message-State: AOAM533DE7OSmwc/Q7r1QOlJIgJKN1tomK3FFSWGN4PVGOL7TJPk+RD1
        A1o3Q7+Yfmz+KgRVtAYDMBUfrk45205Q1w==
X-Google-Smtp-Source: ABdhPJxdOi8DVozRx/En8m8adE3yM9HeDzGwAHRv89n/l3GZQINsgOQQ2TlgW2xvcmf+lJIZ9ZruTQ==
X-Received: by 2002:a1c:2041:: with SMTP id g62mr6123060wmg.145.1619255036082;
        Sat, 24 Apr 2021 02:03:56 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id q20sm39471477wmq.2.2021.04.24.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 48/50] staging: rtl8723bs: remove unsed debug macros tied to no particular code debug
Date:   Sat, 24 Apr 2021 11:02:31 +0200
Message-Id: <a16431ce89e313029c09381f78bb0f58c23fd7e2.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
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

