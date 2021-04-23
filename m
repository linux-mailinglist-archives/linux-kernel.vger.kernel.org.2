Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4D369545
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbhDWO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbhDWO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D5C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m9so35966840wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vK3QxmyEJ/kAAhKM5dk61kp8P7/wFJS5mqiWEFDpYHk=;
        b=q4O46DWrQFNNffaoApkG0va+H+yW1aKCf1ly25izBSn1Ce19n6zgAOEuMHCHDKPvaJ
         cv52vVY1LEJcWFWU6zWnz9fH81g9/YvNlGzNxEblBt4XxDCvk4Q35xujPRPqlMUNyqVm
         DLUaqLZqr3UeoXKSLyWQuwv1KnI3Uft6gwaLwba7bhs65pDDXrF8D4HWXxEnkbMeeyXV
         Ru4sZMkQDUWjsOt8Pl/2v5MNeznHaIlcYk1Q6K0VS19/hjgK7UWozKg/+gqBF9XwW8uE
         jtLSIdkiqOoFQ5vHnXupex8BC1g7PALcQ0B5NYx9hBJnbzBUlU23L6kGUl+VFCauK8qN
         iIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vK3QxmyEJ/kAAhKM5dk61kp8P7/wFJS5mqiWEFDpYHk=;
        b=NYr8nkwyTkNGKuEzTvEzhrRxvEww69SXfjQFncFDRWuSO6kUQucLIar4QrUH1rfIZD
         e/V8vI6BR6mcpWNa1J9QVus7YKyb1Xm+3FvuJ+tuhy+9gNGyCdS+gYCoffXE/WUmOdqO
         0uWARbzl7JLdzk8LuXbROLPIbO5Nqp2tvsmBsnAn9sKqIpFzSUs8A5CE2ddJe3MvzTSN
         4NGCztn3bS+Z3qr1x1maQ2WsPEo8sg7T6DlXKYOR8lEGhphBMzPSby7RZ+SPZZwb5rlJ
         jAu0RiKQBqBur2WwHT1OUzTkiEFLUkQGJow9L/9T12feNdeW9NGUdcHlQOs+Gk2QN06e
         ws6g==
X-Gm-Message-State: AOAM5305sFVJUZuzyDUJKI/3lglWLx6KUHVRLgqF7D/TQBqptU1yLyku
        SDyBDQibHPCOKjXP2ldze+pCTgMhkZ8=
X-Google-Smtp-Source: ABdhPJz6yNPSyEmjK1Z8PkYydHS1u95chhhcoiyU2fl62/TpbeTEn/CTh9J2B4AHPUhI5GcZJEB32Q==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr5365706wrn.262.1619189928585;
        Fri, 23 Apr 2021 07:58:48 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id l9sm9561642wrz.7.2021.04.23.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/49] staging: rtl8723bs: remove unused _DBG_871X_LEVEL macro
Date:   Fri, 23 Apr 2021 16:57:55 +0200
Message-Id: <b3ce80406969921cde889f9f082ef9c858c3a3a8.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
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

