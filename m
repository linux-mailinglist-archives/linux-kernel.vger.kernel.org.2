Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC936FCBC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhD3OqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhD3Op2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AFDC06138F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so14988107edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDyKLq5fjyeL62hL+6feutXGTzuTSzr50xAs4CUIRQM=;
        b=DvULl66FhxFEmYGhUNdSFUs5tQtELRovgPLvt+DtlLHAHvigE0E/B+BuvHHX45tkGP
         KJUczN2v1yy3p1lJKxq6kbTads7LXxp764TZ/oo/F31AM24cL/CsOc8b0UXEOgjbmkNa
         gX794wXRab97mz7leHe5ZTm+1AuR0NOcbllm2rmz+61ZuFXFH3v7UOHI+yPe8Euft7L/
         rU/rIFz9TrVVdWWtnyfyagyuyyxlA97KFFA9thNCjL21fFm84/miOfs6KReNjpGcSjAU
         bYThyNbGEFRHYIf5XsvGQxP4akVl6l7T692gSHj6YResk1oqtkLdWUS773YvYc/w+Fvg
         lpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDyKLq5fjyeL62hL+6feutXGTzuTSzr50xAs4CUIRQM=;
        b=Z203HuOm8DAIU/xf+3YB1CIgv/4/1NFuLGXsjZ98KMOgDfBuWFa4GK1+T2AkpRksA+
         DNYprVcXUPUULS2aLQ6N/DJGGqEjR0xyQMYwMZdZVm4SC9RCxF2wTiwymoz3vPTj2yZM
         5DvJDFRhdMXBq2jfUq3DjGg7OWiY+I1dV7zDHMBBP88GEod7QZVBM3w2RyhGIwCyxPFd
         OmfjVz0PQZ6+LS7q9dfoHzY9fyJlaNdAFF7hhpAlHAJLiZlnPM9nr/JIsOiBrlT1nAzN
         OMetCDIfJbQCHWuAIBzv64ozwMe6iV/wqyRYl+XSYrJZKaJvu0ZVTCy0FtUy7tZ0X7VF
         ho4g==
X-Gm-Message-State: AOAM5328qmDDVkpSt84dU5oFFLdA/k/P1m3lJ40taMFIzi20XAjvHfRv
        Q6QywCrdp2JjW/Q8i2Zum6AZ759qVLI=
X-Google-Smtp-Source: ABdhPJwBxIc8I+rD6O3w0xVT4Dn55M9OpjtCwOqCvoTcP9hXlFmgY0wtQamiYH+qxd4CTWpFEmMBKA==
X-Received: by 2002:a05:6402:8d3:: with SMTP id d19mr6389527edz.302.1619793878440;
        Fri, 30 Apr 2021 07:44:38 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id k5sm1623471edk.46.2021.04.30.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/43] staging: rtl8723bs: remove unused ASSERT macro
Date:   Fri, 30 Apr 2021 16:43:46 +0200
Message-Id: <08ae971f989010c85f0ae0196461671479cc3048.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused do nothing ASSERT macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 8ae9948fb0c6..78b9b4548dcb 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -92,7 +92,6 @@
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 #ifndef ASSERT
-	#define ASSERT(expr)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

