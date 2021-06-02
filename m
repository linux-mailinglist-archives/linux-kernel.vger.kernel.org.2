Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C37398ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFBNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:39:56 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35613 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFBNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:39:55 -0400
Received: by mail-pg1-f171.google.com with SMTP id 133so2274418pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ggtixs2081NFyzFZjKHEZFg0tSmZqU1lORXP6WHti2M=;
        b=ha4c+/+xV2Tg8r7LY6CYQfILogLoM9qyX2AB2ENNR2Kj4tmR1Nxfwr9QXbdvsl7lBV
         YgyXtHX+5m8dZz8qw9WvIgH8OkFmaZAo/EXo9KjNSk59rfE710G/8ayFxEg7OAHbAccY
         /vULJvNphqg35q0iP8wZ/LXRTvhK3fiq+fqtCdYGP4SSk5pBR4Q8egi8U0KOroQwZAO6
         R9zigCUJy8hwOZWUNJAKfP4EIgVQaXPRrZlxjvD8zLilFXYYqt58eYz8jgfZXbOzfOyw
         VLYnBKTBzApZAJnBk+nksamtwa/aRXPm5FSbXerumTo4gGpr2eY8WcaluzV5LF/zHdsF
         o2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ggtixs2081NFyzFZjKHEZFg0tSmZqU1lORXP6WHti2M=;
        b=Y3KOp2gzPEGdtfDvJFADAzVoC+jiS9TAhyIgNcCY1cS1maAWsfbE9Ub0Pap16Kz08z
         8eApJBT+kcoqkOyLHV7KUxMl2iZSoVkmAPI5IGUcsUjHwBRnEPeQsd17rPS+Xg9wUJ52
         fzB18qu27NASNrJ9y5suTUb84HmSgto47L9pc0lHR/QEcCyxZvg7mIzWDeLdZaagjolR
         6AajYv4/YGvqVmxEcvsx8vOGFJ38l35b950HiZqCfbC9VJ+tp7d1Qxh1Lu1gmAm5bBo2
         i19/BWH/ZAMDmPSfzfZosiIsWkEG4rpuBRKBXyRSKQmr6pwTw8nTyo+YeUaSD62DTQTW
         pYGg==
X-Gm-Message-State: AOAM53325t86MbL2a9VQaR2dVdF7oWQQRS8x1qB0Y4tffURjD9m52BqX
        z4oL1Ly2W2dWzRfqe4GQhJs=
X-Google-Smtp-Source: ABdhPJxSyat2Sj5uimWbBNoh8uTFj0dKrTGy/R2BnSoK93NYDr6PicCHpALC/bNrjzyERuRv41XHpw==
X-Received: by 2002:a65:60c5:: with SMTP id r5mr14215853pgv.79.1622641032378;
        Wed, 02 Jun 2021 06:37:12 -0700 (PDT)
Received: from localhost.localdomain ([183.82.159.194])
        by smtp.googlemail.com with ESMTPSA id x6sm907000pfd.173.2021.06.02.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:37:12 -0700 (PDT)
From:   sh4nnu <manikishanghantasala@gmail.com>
Cc:     manikishanghantasala@gmail.com,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: fixed the coding style, labels should not be indented.
Date:   Wed,  2 Jun 2021 19:06:58 +0530
Message-Id: <20210602133659.46158-1-manikishanghantasala@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikishan Ghantasala <manikishanghantasala@gmail.com>

staging: greybus: gpio.c: Clear coding-style problem
"labels should not be indented" by removing indentation.

Signed-off-by: Manikishan Ghantasala <manikishanghantasala@gmail.com>
---
 drivers/staging/greybus/gpio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index 7e6347fe93f9..4661f4a251bd 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -20,9 +20,9 @@
 struct gb_gpio_line {
 	/* The following has to be an array of line_max entries */
 	/* --> make them just a flags field */
-	u8			active:    1,
-				direction: 1,	/* 0 = output, 1 = input */
-				value:     1;	/* 0 = low, 1 = high */
+	u8			active:1,
+				direction:1,	/* 0 = output, 1 = input */
+				value:1;	/* 0 = low, 1 = high */
 	u16			debounce_usec;
 
 	u8			irq_type;
-- 
2.25.1

