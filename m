Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9830136A04A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhDXJED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhDXJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j5so49708204wrn.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vp7TMpUXQWMqR3/UFW+ck6WgnuYX1oYQ9RhzEKAEBI=;
        b=DmCw5el2sjzb2Ji4I4vkcqIT4YtIbR2ms+PMWKZnsqGFdcBtUkCKlyxTjy7Lu1tU2k
         KM+cs/Q6Ltlzl5XjE7PcH7ANuCcnRnCm4kVFzm6q6XhnKccRrB1lmUdSBx3vQT3g/XJq
         85OiSyCemOvkWsp8L001HnCtG9icZTJpInDqV00G1cx/zsoevd7+nGS8wb6TRQMeubT0
         AH8I5qJPc5jQTANfP8rzQfyQyKv6VjdGUXvlIy/cg4weAit6jXncEYtMos42d59aa+zR
         uQ/fKHFkMqG9xC5nLUqMNUxCr2GMLRvuSFccCWPJixYxFmqx+n0iDwYiF+UZZgOdHqQH
         SygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vp7TMpUXQWMqR3/UFW+ck6WgnuYX1oYQ9RhzEKAEBI=;
        b=e3EWywGFl0ASQDbh0hv1t8HBfAiXBVRvkdKI7WtLXwZVlE3fu+8btBD05ExaGlc4OL
         3oql+Se7CwqsOD/1we76h0Pm9MrnqiL06CEI1d9ZvJdbnCSctYMC2Rhy1G9Yk4uclrOb
         8VOJD0PLAiTzgy1bFZqoWjTKFYNWPJtz5yVgMGhLnIQqKYTBSA8vT2r3PifnQx8E/3RI
         Bw5DiUpmcfloCaoU3bmNBALtNIxDvEkCPxsIZXQt7C4PW6DLvEr3n4mRBIAEOCkeORFu
         +ZGgehshSz54OHJ4BkDjYhwDfwvM+iFvsrvG0Yzv6WkP9KaoFVN9oTsDJ4KKD3j2RTwn
         aFpg==
X-Gm-Message-State: AOAM531qi3LRfMg7OcnXrl+2nAcghH0uQ7YUngid/LkhmcmsfsTXrNdc
        FvW/egFa97pjXCcZ3LSREGzr4grfa2n1Iw==
X-Google-Smtp-Source: ABdhPJw003+WyuTNrIQi7WNVLyX0UWdsr352YujVuKbV8/v++Lz6hB+jZmNnSnppoQZKg5bey4ihdw==
X-Received: by 2002:adf:e647:: with SMTP id b7mr9603490wrn.43.1619254972233;
        Sat, 24 Apr 2021 02:02:52 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id d200sm9744983wmd.45.2021.04.24.02.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/50] staging: rtl8723bs: remove all defs related to _dbgdump macro
Date:   Sat, 24 Apr 2021 11:01:53 +0200
Message-Id: <d9eaace0a9312dbc9bc5b6775489dbbb64554ed2.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete _dbgdump macro definition, undef and
empty conditional code block.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index c7e8187ca7f5..2232a1014528 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,21 +131,13 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#undef _dbgdump
-
 #ifndef _RTL871X_DEBUG_C_
 	extern u32 GlobalDebugLevel;
 	extern u64 GlobalDebugComponents;
 #endif
 
-#define _dbgdump printk
-
 #define DRIVER_PREFIX "RTL8723BS: "
 
-#if defined(_dbgdump)
-
-#endif /* defined(_dbgdump) */
-
 void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(struct adapter *adapter);
 void rf_reg_dump(struct adapter *adapter);
-- 
2.20.1

