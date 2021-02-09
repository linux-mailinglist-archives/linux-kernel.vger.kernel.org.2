Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D831515B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhBIOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBIOPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:15:40 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60151C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:14:59 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id u20so18002053qku.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfZAeOnHCXizMX0+jwteYMa2MAiUJ1xg5kMZiaqig+E=;
        b=RT25JklICDBgQERXWv9eCDL+RbFqW6yCiyOYYMKx36Lq/jBu5zXQv7zGsGCjQQUBmv
         rd1PnsBfXOijQtHZ6f80qNti5rr7E0HEOh3+JHa6O7ZU7nIQ9sWLtG13qIanZUTuTmdc
         dFJqWJFaXHrUHLinY91hGuN+MYkSW086Ll9qd18pxBOLP7PlZzZ1C50OThoQrBxSLrkx
         JrHuE/uQoOchsXFOxMH23gURkkNmIYsScQWSxOZOQ/eTIMhzKbQBaLQJnQoM2MlnKDmF
         ATIPVPgM2loP65YS1nEe667yyZfYaC+mHobpSQSZHnXyxPsCT0xDt8YfUIQ3XI9rd3DH
         uNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfZAeOnHCXizMX0+jwteYMa2MAiUJ1xg5kMZiaqig+E=;
        b=ndtvQVhP2liaG/1zSdTPbO5ljz26/NriUy3cHitKiVZGjH+gbPtsPpSKghuO8UyEXy
         bFISYCCeS0E1m+egGNEiD7/j8sBVQNtoN08PMqPingXbzk2sCw54hWTPewP9NKIBtp+O
         R+Uuct/y4+crUy6gOAtInKCk/Dz568LbRGRLL0cLgRuTzfaqjoFWhyYgCJQAQHJF9gm+
         KPnS7qywfjY1j9OnnuCFPBOhncGJ2vBHSw4Ls3XFoEMbqHAxyMFebsSuZhT+w/hg13Ol
         FNwVWBVZ8D3h+uyis3CLZ3k+UxDHa37h14CrTRyTf1rKiPwvbSvBpF1l/yE/s0QoqUU8
         khIg==
X-Gm-Message-State: AOAM531o2tYMDn++w34lubjTphtrA1YNMRJdDkiJrRrnvWR1ifUIfSC8
        B0xwD/XofxoDiEv0zAw5u8OGy+XXmq0gKa0h
X-Google-Smtp-Source: ABdhPJx/pvEWuk4ALx8Sf4/Eff5z+A/LyOFVyi9MH50+t1zaAOo3NZ+4b8EJ8r9htXzu7um1zWDcXg==
X-Received: by 2002:a05:620a:2236:: with SMTP id n22mr9527968qkh.47.1612880098343;
        Tue, 09 Feb 2021 06:14:58 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.186])
        by smtp.gmail.com with ESMTPSA id d5sm16587085qti.66.2021.02.09.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:14:56 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] include: uapi: linux: Fix the spelling simulatneous to simultaneous in the file capi.h
Date:   Tue,  9 Feb 2021 19:44:45 +0530
Message-Id: <20210209141445.3927167-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/simulatneous/simultaneous/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/uapi/linux/capi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/capi.h b/include/uapi/linux/capi.h
index 31f946f8a88d..4dcdb628d98b 100644
--- a/include/uapi/linux/capi.h
+++ b/include/uapi/linux/capi.h
@@ -24,7 +24,7 @@
  */

 typedef struct capi_register_params {	/* CAPI_REGISTER */
-	__u32 level3cnt;	/* No. of simulatneous user data connections */
+	__u32 level3cnt;	/* No. of simultaneous user data connections */
 	__u32 datablkcnt;	/* No. of buffered data messages */
 	__u32 datablklen;	/* Size of buffered data messages */
 } capi_register_params;
--
2.30.0

