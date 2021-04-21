Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACF1367375
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhDUTc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhDUTcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:32:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34630C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:31:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g5so58451536ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foXVhnwT23D/qpAtyx2UOpz422ajD7V5LrdFOfsaVYc=;
        b=TFO2BuTEkby0ABFf1OkYK/1D90LhANve4lIJJ88/sKZDsAJPhoQCSO6f82qhRXN6ec
         CgCyxKIrUZTopeueP681KmvgiJ8Xrqm0WA7FASO/sO+pV5OxEEkbRVNqbAvDGYZQi23f
         x6FX3N+GdEEGDOfY323qyIWLzzEsmsepQ9XoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foXVhnwT23D/qpAtyx2UOpz422ajD7V5LrdFOfsaVYc=;
        b=FEgdMlb7Q/kPB8ZNTs3mqdWFmkH84UQcDc6GDU0RnlcziUVr0aFtGtOhiyQW0XemZQ
         qBEN9jIyDA0Tmx0PfGbheDQJUEvph4L66l25Nk3qYSYGP2dPTi12W8OYuUUCCE0UIQJo
         rBCzIv1eZJ5gA+0d/E19siXxCjW9HSL7zP02c7pQb9BJPCkU8RRoKcAm8WZZi7HoCtP+
         UzBSqg6RMvWvizemMgpzmRkA5giDhLgqaXswtXaE9pmjXZXIU2RaasCwFYodOLGda3wp
         DYjQgJM5fWy95BnugivZRBDLWLpyCnKDtjp775NJU7uzXgCuZqkOayIRE8DzX3thXu0t
         8qXw==
X-Gm-Message-State: AOAM53329GVT+f+rSA+ksviHSuLx7A8XhQofBg6/VUhiVNoSRwcezj88
        QSjykD5HsqyFBFt+eXPedXZcjQ==
X-Google-Smtp-Source: ABdhPJzrmiWm8xqN10Pgm6ApQ10O3qhZBNiRi56u9Q1ia2YUMP15g1RqZs30XvuXJlWLsHsUwui6Yg==
X-Received: by 2002:a17:906:3ec1:: with SMTP id d1mr8143866ejj.523.1619033509937;
        Wed, 21 Apr 2021 12:31:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id z6sm284781ejp.86.2021.04.21.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:31:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alex Kluver <alex.kluver@hpe.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi: cper: fix scnprintf() use in cper_mem_err_location()
Date:   Wed, 21 Apr 2021 21:31:46 +0200
Message-Id: <20210421193146.1539649-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last two if-clauses fail to update n, so whatever they might have
written at &msg[n] would be cut off by the final nul-termination.

That nul-termination is redundant; scnprintf(), just like snprintf(),
guarantees a nul-terminated output buffer, provided the buffer size is
positive.

And there's no need to discount one byte from the initial buffer;
vsnprintf() expects to be given the full buffer size - it's not going
to write the nul-terminator one beyond the given (buffer, size) pair.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/firmware/efi/cper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e15d484b6a5a..dfa0bd140bef 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -221,7 +221,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		return 0;
 
 	n = 0;
-	len = CPER_REC_LEN - 1;
+	len = CPER_REC_LEN;
 	if (mem->validation_bits & CPER_MEM_VALID_NODE)
 		n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
 	if (mem->validation_bits & CPER_MEM_VALID_CARD)
@@ -258,13 +258,12 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "responder_id: 0x%016llx ",
 			       mem->responder_id);
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
-			  mem->target_id);
+		n += scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
+			       mem->target_id);
 	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		scnprintf(msg + n, len - n, "chip_id: %d ",
-			  mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
+		n += scnprintf(msg + n, len - n, "chip_id: %d ",
+			       mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
 
-	msg[n] = '\0';
 	return n;
 }
 
-- 
2.29.2

