Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA69352E56
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhDBRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhDBRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344CC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5409409wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4gSFe0DOErEwXm3jMgMd1VdZfPYQ5MK/WIOIxx48g4=;
        b=u5zESPr4xis7ZcOF9UIyGUt8KJF0nt9q/VSw94Ks/Bj4hgpi6uaJQ4gVWmYaik6B14
         KkwlGy65NnpvubQ7FZVat0Z0mEcbA9NUsyWGhGcs7Gn4BzSm5l0CjL8G+OKqI7mspuE8
         LUjG33pPWc63XCbq6I1a3P/jwmQ//oQSigwmpTMt0tADrn1tcDB8Uj443ujQizWrig5t
         BBIaUitTf4J5vHrjAKVqIQ7xpGzj9jxHC0i0MmrivdTQZPuO3ZE0rH6eA4Jq1wUPOJZr
         fAUJYq9ZeE+0jv0HgzMdEt7W8WVQjI2OZx0jQArS6OAFWjSLxn84+4bI1hU7w0HqsYR5
         NDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4gSFe0DOErEwXm3jMgMd1VdZfPYQ5MK/WIOIxx48g4=;
        b=owqYBt6f5kGgLcvRi/fAq2UXz8CHVgkBSyut2xvp/KP9CX8cDLsjwZHPYVfebGLd55
         l2PgX1+roZogETmfNRzJZ/05KxAeiFyoncHk/+oXjGUuxPDt/tyoD/fRbt7oAqvWutdZ
         jEsD0kI6sY5FIC6oIvuBrvmDBEL/RxjNkapWs83CHLjRBsZSYLDFCKORghDIaau0Ufv6
         GKIPYV8T3bq8JvNN40ydN8XQ7Q0FvDyWYDg11FQnmOjeEVKyrS9HLi1Y6lYxuD6d+RM3
         Qr3jGteTKk2Za8JgqkghKQvqyD3TYlb5CPoP2ACjed22+0S9lBCZjovyrrcLf0DatdEG
         lLhg==
X-Gm-Message-State: AOAM531WqEy5qY139GzzKLtHEbdo/pH9Upe1bexf7n6C9WLMhfBMS8aS
        TBXh9c5Ggkq/fzJwLeRy5zA=
X-Google-Smtp-Source: ABdhPJy4gh61j3zJslUmrsERM/NqkoD55anqpT/8nNJCg0Y4Iq0jjeZNi9rRnKmiN7GOwf5BemK1lw==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr13425514wmk.102.1617384638171;
        Fri, 02 Apr 2021 10:30:38 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id w6sm15221439wrl.49.2021.04.02.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 13/30] staging: rtl8723bs: remove unnecessary parentheses in if condition
Date:   Fri,  2 Apr 2021 19:29:55 +0200
Message-Id: <72afa4756d2af668ac47cd50aca6744ea8c20953.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post commit hook issue:

WARNING: Unnecessary parentheses
166: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2000:
+	if ((pcmd->res != H2C_SUCCESS))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 840b9da9f2d9..77c583c60343 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1997,7 +1997,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	if (pcmd->parmbuf == NULL)
 		goto exit;
 
-	if ((pcmd->res != H2C_SUCCESS))
+	if (pcmd->res != H2C_SUCCESS)
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
 	del_timer_sync(&pmlmepriv->assoc_timer);
-- 
2.20.1

