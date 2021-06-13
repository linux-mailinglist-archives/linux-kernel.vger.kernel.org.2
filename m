Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124743A5A5D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhFMUfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:35:30 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41706 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFMUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:35:29 -0400
Received: by mail-ot1-f49.google.com with SMTP id p5-20020a9d45450000b029043ee61dce6bso1764161oti.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a41MvSPgCm1M0enFLZ+3g8MXHz4465jE3VgNFVTduAk=;
        b=Wi/TNN1Y81MGFgrYnmIFlhLK8+WQsuvELapzcCVgXLnjqcsIXyTECchIZJm7xHo3BX
         dYTFcKjf/u06qA2/guyNgKnN/lqGVBIOEIf+jomBjk3zErADFyuWkxPzU7RfxNvH4lAu
         1T2qMYL4/f7uJV7l+rV0FDhnuEz/zipeKm92NicavRxIHIPH0RVQZg48eWn0FDg0xaNG
         zJUf3EVHh8GyCR0r2lhww2sJGP38f9R/JHpKBtKr6jJh7GGeLYRXCbkoku9zfINTX2HC
         uazX4gJIvuwwuUhGR4j6arNELi/8ppzqN8EW92ZatM8UNWni/hg4DYM1zCpsLTAW8wHm
         CsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a41MvSPgCm1M0enFLZ+3g8MXHz4465jE3VgNFVTduAk=;
        b=hctw18P2wKD+m+zs4rHzQJAYR+y9xFS1jBrzQC4K9rpXZKl/c7qrTc5iTyJtiqmN9O
         M38DzpureP2oKDMCtji8VGKfb0Rmg3cBqyVQMKmPOpXRwQc8pXOzqwbd8VDBeCXxjhSL
         PvS/UMw3qus9qIdidfCtbxjMqGWpXu0dwJIqyk/XRvm5Zi9Rhoo6DCb/I0Op4dCA1QXi
         I+KYdJmaM25+DdGKmP3v607g59AtSGqyNCSGQJmWraVSmVp4TJ1ulae5xnYUlnBYiUGG
         XSs2f6DY6vVNbYorBuIUD/Gb7BiGhrekf7lmv0zAhrUsdXnz5FxWzkLzrNa7mywYqRpk
         LrUw==
X-Gm-Message-State: AOAM532jZYf1zitr+aAH2hNNEXxEocmzLviLvqfn7KS6POyZVuAAl3yN
        +RWkkOWS3nhGZC2vYh8nVJI=
X-Google-Smtp-Source: ABdhPJwt7+bWUmXGvHX0y1GLyOp2t6WBnPrUbS/RrFRkuEdHZonOR+jEHbSk+zGQYKNPBHDbrqbuCg==
X-Received: by 2002:a9d:baa:: with SMTP id 39mr10809138oth.159.1623616334486;
        Sun, 13 Jun 2021 13:32:14 -0700 (PDT)
Received: from fedora.. ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id 111sm2869324otg.25.2021.06.13.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 13:32:14 -0700 (PDT)
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     jirislaby@kernel.org
Cc:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org,
        Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH] accessibility: braille: braille_console: fix whitespace style issues
Date:   Sun, 13 Jun 2021 14:30:32 -0600
Message-Id: <20210613203031.23721-1-majortomtosourcecontrol@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 drivers/accessibility/braille/braille_console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 9861302cc7db..a0656c6b595f 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -225,6 +225,7 @@ static int keyboard_notifier_call(struct notifier_block *blk,
 	case KBD_POST_KEYSYM:
 	{
 		unsigned char type = KTYP(param->value) - 0xf0;
+
 		if (type == KT_SPEC) {
 			unsigned char val = KVAL(param->value);
 			int on_off = -1;
@@ -264,6 +265,7 @@ static int vt_notifier_call(struct notifier_block *blk,
 {
 	struct vt_notifier_param *param = _param;
 	struct vc_data *vc = param->vc;
+
 	switch (code) {
 	case VT_ALLOCATE:
 		break;
@@ -272,6 +274,7 @@ static int vt_notifier_call(struct notifier_block *blk,
 	case VT_WRITE:
 	{
 		unsigned char c = param->c;
+
 		if (vc->vc_num != fg_console)
 			break;
 		switch (c) {
-- 
2.31.1

