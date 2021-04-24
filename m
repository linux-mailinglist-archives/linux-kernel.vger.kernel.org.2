Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7667936A044
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhDXJDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhDXJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A076C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p6so44010296wrn.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vK3QxmyEJ/kAAhKM5dk61kp8P7/wFJS5mqiWEFDpYHk=;
        b=aSqkcTD1MBNSxHVEflx3Cc2Ng72YamIFkOHC6F1H6VNu+T1pu1sidBhjvWc2t4YcB1
         TAONYeh7YNW2EqS7ZHKfvdZJIxYukcX2hknimdr7J8ropJWhDcV5ibv8ZL7FIDrW28bI
         mLKHxS77tflgRx46VHpaIDW0a3PJTacoctIFgR3asPn4XkJt9umb1HCRYDVHb5yr/eGz
         q6wUwRaGTvKj28WnuRgFUgs7PQ4ygSS1hPFkI8MhGOc7QP/mMOK/Euj8vzqGi5LM9xk1
         zns+OoKktUXOstmXqpXSatS/06S993fHeaC2i3HU8e/ZwzDv7Cewf+zZtAJRrBi+3G4H
         abHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vK3QxmyEJ/kAAhKM5dk61kp8P7/wFJS5mqiWEFDpYHk=;
        b=phaKzNE7R9ROmYWGiG9Q955qmzwgTYrux1fz3IHY+tLYxKMNUfClEL3rUNIOMejLPP
         sz572xIOMu9oeaYdCYRGf75sn7cB8X+Zmv5eg6TOEZXwP15V5A4bmepdTXOkMlGr9Sb8
         cMwnxIh1tDAgM/2HKMCiTTIGV0EYTHH2ZGDhuzmEl1GltN2W2UgqWbbZbQLruET54rfR
         Nl5u2oDZcoQVf056n7syEwEZP6JaOC73TsrIjGIQeLWs88W8o+u4oHxgkR+z4K4zY05v
         tKauGXbykRVN5OswprRP5yNHCDsYwgORezIcvWQfbrfcceTOfcFEwcgzrXSZnWw7BHGj
         w4nw==
X-Gm-Message-State: AOAM532x+IxwSXj+vBTHFyGiWfUf3RG2X7UcrUexepgXTjsDuPHQIc7h
        gG837eUnHsZgn8z9qgUDrOj8IaiVK3nv8Q==
X-Google-Smtp-Source: ABdhPJzTzbWqAjrG6MtNiFLG4UcKdH2q1gkOWLaE0PNBKxP5xzls41Av6F9KFM0D3TJrrJgHw0SSlA==
X-Received: by 2002:adf:ef8b:: with SMTP id d11mr9619707wro.107.1619254963938;
        Sat, 24 Apr 2021 02:02:43 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id b14sm12556480wrf.75.2021.04.24.02.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/50] staging: rtl8723bs: remove unused _DBG_871X_LEVEL macro
Date:   Sat, 24 Apr 2021 11:01:48 +0200
Message-Id: <83ff6acd438ad2107a9a1c9446cabb22a6c77f0a.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused _DBG_871X_LEVEL macro,
after DBG_871X_SEL deletion.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index fbae0d3b168c..fdd5933a3d5a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -144,18 +144,6 @@
 
 #if defined(_dbgdump)
 
-/* without driver-defined prefix */
-#undef _DBG_871X_LEVEL
-#define _DBG_871X_LEVEL(level, fmt, arg...)	   \
-	do {\
-		if (level <= GlobalDebugLevel) {\
-			if (level <= _drv_err_ && level > _drv_always_) \
-				_dbgdump("ERROR " fmt, ##arg);\
-			else \
-				_dbgdump(fmt, ##arg);\
-		} \
-	} while (0)
-
 #define RTW_DBGDUMP NULL /* 'stream' for _dbgdump */
 
 #endif /* defined(_dbgdump) */
-- 
2.20.1

