Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633AC36A04C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhDXJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbhDXJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1BDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j5so49708292wrn.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vzf/YgZItTJD9AAwq9y0zSWQfAI0RmMuyvnRYVtH28M=;
        b=Kv0kx7TrJDYFbEfxrZvVoDP7M9Yoq6sl07zJBgQGydB/bzLS5ybeBpoAX78Cm/am2z
         wezDpdNIw7A0gzXSgkCrYlBlMTZTdZISMf691sloHM20DbH0zYUKx+ZAMAaSkjOfl82J
         ZTDMMEVkrkEJXC3RDMGZZJ/RJSOIEM2vuwLZPXOmTOpjnml7RzWMsE8jnwodVPfT5ojm
         hICyu7yOkXUHetukMb/CV/ILlduQEzRrY3xOGRJTA6pR/yV7OV/+6AVNYJRoTPpKwn8l
         U+y37h7q77QUeRqkSin8UCy3VK9wRsiRH8V0K942BV9JTVwPdRtmvBorT89lIiDrTht1
         HlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vzf/YgZItTJD9AAwq9y0zSWQfAI0RmMuyvnRYVtH28M=;
        b=eYFTAESiZJf2hz3/T1YYiZSJVaJkuueHnqahVEwectfOFHhbLN7RYtvqOMZYacp4Gq
         zqOZn4lYNLydEIzn7v8x0YfLMRV9i1EYknIntwaBwUzCOIt7Ys6sxtSyT6+o58Ea2ObT
         NhJ7uNLk5qH2FRlxgWCDIcx+F0TDHxJfqntUjDRZSl8SuSWvZ96LShW0r4udJx9TIghn
         xv/N0NIq3IC5ZyEE7Bg+KJNtAtPMgbJ+HUNmc6MJ4z62rX7dzY/+4sZGK5aP1LmjpmEZ
         7ICEOkovG0gsW6fwb33JmJlGjs01FasU2YZY7t156CqoGn/VRZ3BTFCUu0brl7nzr/Gk
         2S5A==
X-Gm-Message-State: AOAM530o7Etlx2UbOp3jcHuFicMGThTC84OFTj61/5VRgERx/tIUm59d
        v8GHcleaSY0UtRsnKBIt12RN9ZCu1WP40A==
X-Google-Smtp-Source: ABdhPJxxRiOITxJaaBUB+rPLgyC6LY7iRlStyaxGUTdUDw8ahdZcKn5eKi88ECorGWrsQ942SIwEcA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr9603757wrn.43.1619254975546;
        Sat, 24 Apr 2021 02:02:55 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id u2sm12678741wmc.22.2021.04.24.02.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/50] staging: rtl8723bs: remove unneeded header file include
Date:   Sat, 24 Apr 2021 11:01:55 +0200
Message-Id: <b58b5edf820026f08cb7289c1461561ecc95d41f.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded header file include.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 579724e8fc2f..acf4deacd3a7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,8 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#include <linux/trace_seq.h>
-
 #define _drv_always_		1
 #define _drv_emerg_			2
 #define _drv_alert_			3
-- 
2.20.1

