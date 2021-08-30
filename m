Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54F03FB1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhH3HLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhH3HLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:11:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso13913743wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZJ/kXxj691OQQ1voEIVZ9kX56LFg3cAMVd4BWTgZhE=;
        b=A8pLfIdIUq8yUHMCd9UfQjFTXpwAaMNfBGA8geICD/zitzsgOusWH2Xbb8hoKywh3c
         QJAWdfxRx0yuPzwlha+JtFsHeabAizdXlm6pOvZcKWynuKxV4UAAA9RNUyda88QdwuJB
         qPYY5+zRxjVxArCZEo6BG1ZXFQLl8e0OQGq02D+Zx+whdNfQYZFYVULj4sqd6jE+/oUa
         CRPw7m6GBiCxe45hVlYkvWjR3rsdeX+iK/pmlub9TKtJASH8Vjpljvw6fo2cOk1Bx1LL
         DOvVq+b/QUGPmdJVpHnUNb0wcviQv7ESRdRa6Vz2ajDVy/rdxyPmIblRqbh6F4QeH+Bx
         D25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZJ/kXxj691OQQ1voEIVZ9kX56LFg3cAMVd4BWTgZhE=;
        b=qEAjVQOCaEIbT6zX3R45mOG+WDwuqRewDPQp8dNwJ2pP0IrRH2AN1PA6y8CfMYsFLE
         Mj4/rIEUrQWxPffL8dR/lbgI97+clI7GPn6czY+dUpXwxYZkmp0Ss4tSVhs+nEk9CmyW
         53GNxIW1HeX7oMByGOJChDgtDpkY7Qa2kDT0yXppag9AqZRjzlXqesaZzGZQKNCtLF4O
         kWwkJQY8CgnV0KV5EA4DSAeLCq1kOBHhXMJWstSKiBBQaS9AZNcj1wBr0JNDzfBE+mF8
         tOPwITvrAH6cxsXSjaXIWmnjMqFTRo5Ocy8yEXPvOIv4U99yWqj+XRnT3MUbL7zbGL6B
         2hFQ==
X-Gm-Message-State: AOAM532uESuxUSq0kHoeOQ2pOB9P5XDqaa9PHRzlBO6Ocf9LsMAaLa04
        s4JNWgrmykFdxWMORHenD3A=
X-Google-Smtp-Source: ABdhPJwSNN6UtDa5v+7z8zQrKN92cE1VtubMzJXBPEdV9JS8mAc9WOlnA9ZCY2TT4AB0Cr7wLvpUhg==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr20816713wmh.114.1630307419100;
        Mon, 30 Aug 2021 00:10:19 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id h15sm13561974wrb.22.2021.08.30.00.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:10:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: remove unnecessary parentheses
Date:   Mon, 30 Aug 2021 09:09:24 +0200
Message-Id: <de4fcdb3ff45671333713b27f1dcf376b22f3978.1630307025.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1630307025.git.fabioaiuto83@gmail.com>
References: <cover.1630307025.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following post commit hook checkpatch issues:

CHECK: Unnecessary parentheses around pcmdpriv->cmd_queue
103: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:169:
+	INIT_LIST_HEAD(&(pcmdpriv->cmd_queue).queue);

CHECK: Unnecessary parentheses around pcmdpriv->cmd_queue
104: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:170:
+	spin_lock_init(&(pcmdpriv->cmd_queue).lock);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 76418c525b5c..ca405dc76c2f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -166,8 +166,8 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
-	INIT_LIST_HEAD(&(pcmdpriv->cmd_queue).queue);
-	spin_lock_init(&(pcmdpriv->cmd_queue).lock);
+	INIT_LIST_HEAD(&pcmdpriv->cmd_queue.queue);
+	spin_lock_init(&pcmdpriv->cmd_queue.lock);
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 
-- 
2.20.1

