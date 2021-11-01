Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB75A441CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhKAOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhKAOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB1C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:32:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso17294537wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EC9+PWZIJ2fWzzebh2fDh481689iLmSpT4arYpu1u+Q=;
        b=b9P+aKyLf5aXI/gOZo2VxbJ5rloRHLZ0VlbnIKuoBKylSEsYQOL1yix0mYaPwJR9hs
         j3GPj2yr2Hun0KOYOoDdP8NJDr/IWDpTXFuMngqNKX/vVFdq44Tc1vTsYcFBoAAdOetP
         uNzTpiolPdch8LHf0eM+sXZ1eej4/sFPSkVDKdnwMXMQIkMcLo4v5ZyUVN5HOfJdQ0Fh
         MsO0NhrgsUt+PRxRLzDIIuwcMioR7IJkj2vugQXYgn6rA+29LT6YcLGkQ7gxzqIsz2A4
         p5+UVmbHaKpqKST/LbTHRaprELeiUZjaaLkWIaFkgYF+B1yOwqkISKHSjyM7PHObfqeu
         UbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EC9+PWZIJ2fWzzebh2fDh481689iLmSpT4arYpu1u+Q=;
        b=Z8Tw3G74Dqh0JLSdmmTggcvKeQXSzjy0baBiXxCv99t6CGqinXALr7A3pHu4mqhUWU
         PgqIo5WyA35J2W8sJO9JrcdMqRnmm/Gs7nZbN1WIXlUcPVp0QlUGeSaN4CQfgjuakoa/
         UGfl1Urk1jFYAsGREeGM8KlOw4LdEGEtEdcAdIr+YKG0IafqLx4my81QKeWTU5wJL294
         CWjr8s4fSUb815PRW+YJKmxzW5Moc0hM32pbsQQsj348JbHKfdafLzhcgVTxX7l3CxeS
         BU7ZHwtCFwNsJmcxCnARivl5Kv9PPJfDdUeG4GZPxtYM3l5UBC7vV2uQBeGEltUdrjce
         ahgg==
X-Gm-Message-State: AOAM533aOY4gAA0f1bI4uKPTpnuKGD4sOQcH7atMn9dQA+oqsuQXV0WM
        eGB84uXMXcbU+kCyA3ZbF+g=
X-Google-Smtp-Source: ABdhPJx3EL732+ULnFXkqRBD68q53lt0VKlw5ilVknui9Jjd8PfdOEJaQ9D8GflsxMHiMnZKSiyUKw==
X-Received: by 2002:a05:600c:3b27:: with SMTP id m39mr10513897wms.132.1635777149951;
        Mon, 01 Nov 2021 07:32:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l8sm17157721wry.43.2021.11.01.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:32:29 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>
Subject: [PATCH v2 7/8] staging: vt6655: Delete bogus check for `init_count` in AL2230
Date:   Mon,  1 Nov 2021 14:32:05 +0000
Message-Id: <ab98889e7330e64656253f4e2a1d9462355045ed.1635773681.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635773679.git.karolinadrobnik@gmail.com>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary check in `rf_write_wake_prog_syn` in `RF_AL2230S`
switch case. This `if` conditional will never be true as `init_count` is
equal to 17 and can't be bigger than `MISCFIFO_SYNDATASIZE - 0`, which
is equal to 21.

Suggested-by: Mike Rapoport <mike.rapoport@gmail.com>
Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 1fe073c5fb6f..a150f1df3824 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -697,8 +697,6 @@ bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
 		 /* Init Reg + Channel Reg (2) */
 		init_count = CB_AL2230_INIT_SEQ + 2;
 		sleep_count = 0;
-		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
-			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
 			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
-- 
2.30.2

