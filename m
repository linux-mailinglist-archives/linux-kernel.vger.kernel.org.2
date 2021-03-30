Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858A334E101
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhC3GJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC3GIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:08:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7D7C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:08:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so22996516ejs.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNbJX303TKj0bY08nTN0li+FCpaX3fkQH86qG6Fy4cY=;
        b=kCXfj4yojsaTUg2WjkiwZOb0nApyobIksGmDw2gUIj7sgOR1YC8VqnkPJrDYTzanUM
         owmndn0GmxBRPp3RUghzkdOdAZa/hI1Rn7vMTc5Df3Rbm1g9bHS3/mXN0NoVhcPnie7z
         sKysoVqz4CUGvQr2mUyVj041BzGXb5cQrV2gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNbJX303TKj0bY08nTN0li+FCpaX3fkQH86qG6Fy4cY=;
        b=QRPfreFWnPSGL49WiSS+ojbVL2LEMzCihiWkWZFv3QsEJmxdiydFb85ASTIjwmG9wX
         69tcYxYOBiCA36PGBlL2tgclQUBBq1LHKhAuo9UDA8UqITxpAyx+quAN+kl2hdw2dTrc
         c/P3Az+t7wlZQz3EXuWPakg8s9Vci4t6lCmI/+xlvlafWhlJniiiIKGOyvY7/5wxQYNg
         A0vK1XsTA/z8pdQ5QBYDgg0pBCDNxJ2COmQatLRW8CwQgKWLI9+ij9GOOyafFajtfZ2n
         CAeMH3HE8BFhCAHYXOojgFxRzocxzxF9DcQxvm365yRFBn0EQQXkrRQ82uh6VVpeI+t8
         i2sQ==
X-Gm-Message-State: AOAM531Y5kl+L6FF1w7+S3HbLu6t1RsmmAbnyUO5Fzt8bNqxXnDcuck1
        wLHInP5woCGn1RpaBKm87SWA048xTqX7qQ==
X-Google-Smtp-Source: ABdhPJxPQkHvFGwfmywaOTjQGaqLP8ZMq7LqqNUAJw1ZOTUagdIh8c31YduWn7v0Ti0IzPcqoX9yzw==
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr31570991ejo.546.1617084526916;
        Mon, 29 Mar 2021 23:08:46 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id d1sm9449679eje.26.2021.03.29.23.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 23:08:46 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] IMA: Fix error in comment
Date:   Tue, 30 Mar 2021 08:08:45 +0200
Message-Id: <20210330060845.18422-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ima_file_mprotect does not return EACCES but EPERM.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9ef748ea829f..716ea29cf897 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -409,7 +409,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  * this point.  Eliminate this integrity gap by denying the mprotect
  * PROT_EXECUTE change, if an mmap appraise policy rule exists.
  *
- * On mprotect change success, return 0.  On failure, return -EACESS.
+ * On mprotect change success, return 0.  On failure, return -EPERM.
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
-- 
2.31.0.291.g576ba9dcdaf-goog

