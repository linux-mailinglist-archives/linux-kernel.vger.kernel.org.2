Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487DE356DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352668AbhDGNvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245755AbhDGNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E3C0613D9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x7so18066805wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qiGPwwug40UNnH5K1BDplcA3s5jT3Pjwy9PYy6X9bbM=;
        b=eV/EQHWAEdwBvEYpfn+Xe34b7weOWs25lzpjokgjdrYAVIL5DsGamqMWog/6F3yBYJ
         qGr3GTfqX9t13GH6+GUjdV7x8iMnvDlEtHZ1UfhiE+hvuyi6V/F2yl/mgDRt9sTiGsw0
         t3BJ4H2eu7XrM+HPfM4uTwwiYDq3yBKFyqhfhdevV/rjgp6rxe7SizBGTSOLtcrevAjT
         H/g8aP0XttXcCsMfOn19K79S3iDFuCN0UFBCtipf91gqUnWOk7vEM2lr32QP2OpwAILF
         7vXzkh7iyI2D7iLU6yK3hQf7x+LlMHRHkiFtU+MklscLPjGq/Z4RXjeXwVw6as5AAr5l
         /gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiGPwwug40UNnH5K1BDplcA3s5jT3Pjwy9PYy6X9bbM=;
        b=juAuu3pTuIFmRruMYCoF9Vt4kuGjnzS0ye0sDF4m/IS/NiD3dcP6daik0MrAezQJy6
         s3ei9gpU68vZ+VCBKe078z2bQi44iaP6x7f4IUjTggHt4qZ/rNABVCDOSyKDQl94zYip
         G/Z7sgj3j9Z49GW2ZIVntTtCfjQadFhQZb6s+HUx4jS1YXeBNyDOdde4HOMTyt5tLiFy
         80rc3OjHoY/w/FhWOlcA0R4M0Y7AAPTWeVr4ZKWE4toODzklAHl9WxwfZu5wTgASN9Id
         wcFMvTmwJnSJ8zB9Y0rQ7EFDD5IZKthlFhPYqUhcC1ixclojngRE1+pkHIoJbx5oCc/E
         SEjA==
X-Gm-Message-State: AOAM531DUbRTLueEpI0LaTkeHpi7MwdJaKKOEBGxf4saQXl6QswLb0HB
        UISTLsvE6qgLRbpe/DlqXvQ=
X-Google-Smtp-Source: ABdhPJxiFPCd7/peJv4Aez6qQgYYeoeW2ThiGdsNu1cLpoc2BFMbgBb2XfaIMtS/bIRseOj9ufHo5g==
X-Received: by 2002:adf:fa0a:: with SMTP id m10mr4568073wrr.147.1617803417357;
        Wed, 07 Apr 2021 06:50:17 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id v18sm8267009wmh.28.2021.04.07.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 13/19] staging: rtl8723bs: remove unnecessary parentheses in if condition
Date:   Wed,  7 Apr 2021 15:49:37 +0200
Message-Id: <3f5cf6b7b9aa5a0fa09b71278fdc361e9f113c41.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issue:

CHECK: Unnecessary parentheses around pcmdpriv->cmd_queue.queue
85: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:422:
+		if (list_empty(&(pcmdpriv->cmd_queue.queue)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index cc00bd4f4bc6..baf8b1e0f43c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -419,7 +419,7 @@ int rtw_cmd_thread(void *context)
 			break;
 		}
 
-		if (list_empty(&(pcmdpriv->cmd_queue.queue)))
+		if (list_empty(&pcmdpriv->cmd_queue.queue))
 			continue;
 
 		if (rtw_register_cmd_alive(padapter) != _SUCCESS)
-- 
2.20.1

