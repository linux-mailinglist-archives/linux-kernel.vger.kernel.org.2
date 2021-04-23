Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD536954B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbhDWO7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbhDWO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c4so9800776wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vp7TMpUXQWMqR3/UFW+ck6WgnuYX1oYQ9RhzEKAEBI=;
        b=F9Ury378KBUIEdGTqlKjeKYIrNEICi2NQdglru8UgdUZGvdK4jEXflSrT4WSa5A5Z2
         gANOfwTPcN1xtrHZs9MrZ0V+hosr3MGCEbueml2O9BGyXS+fvXpi4spsj9S2PofBdDpF
         UpeP+uY7kL1aRMwiHCHe4tT4ex4UspHuhq5Jl2FnTFoEUG1xYtkjk/MIbyKxWDGYj7uf
         qC0b3zO3/+qekB9B0iUu2REQoAcpWf5TzmWIIuJqXubscgYlNbn5wVUKFe2U8RT72DHM
         KrVVxvol9j9+km5+6oNkekDO6OiBQgVAdJd1zBYIrR2bohVIROzyunIrVEDFRc2yKEGK
         MeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vp7TMpUXQWMqR3/UFW+ck6WgnuYX1oYQ9RhzEKAEBI=;
        b=oD/n69h7oXJV61DWGIgDidnZRkdQnlwB0xbTSYgvjFDU/azGKqpyxsQT/7ONPu8Hwy
         dNu73vU9gC4bZlH1m4ezzHrDb6hVm0LK0hG6St4r2FuBNdlKf2wncz0HQZIzg/gRV0wT
         4x8X6G4HvTwCFkRCPZx3Ve3rVlGcKm3NCYgb2TU2ZqSw8up9I6lwcR1noqhnSSimxhw1
         0OOd7/BP2VgF3h1E+mf4TzIbV4xvyWoYy54eYi9ecwCM9i5CnC4373AcH7AGBeptZ1Yw
         hQTx4j7ywEmfaC3vIJJccJ0QlFvqdy+N4DAQeVZSm/xQXfvmvl5NIQk4iJm9nuINVhf2
         huWQ==
X-Gm-Message-State: AOAM532WasuyROFYhegou86W4YghOZ42lsOSz55dQ603lh0eOMxlJdNW
        w1PyeisOMMbv3g+glhSQjFlZ7Tr+Rk4=
X-Google-Smtp-Source: ABdhPJxDjD0T4qfYoGMZ8KqqRWFpercu8+Z+ZrEIOD72JHhHMJnsdsnT/8UfRQxHmx0/XxZvz3eWVQ==
X-Received: by 2002:adf:e607:: with SMTP id p7mr5199119wrm.381.1619189936471;
        Fri, 23 Apr 2021 07:58:56 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id s14sm9045432wrm.51.2021.04.23.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/49] staging: rtl8723bs: remove all defs related to _dbgdump macro
Date:   Fri, 23 Apr 2021 16:58:00 +0200
Message-Id: <666e88b9ef847519a5731c9b4ef18def6d4a2933.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
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

