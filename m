Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E2306131
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhA0Qno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhA0QnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:43:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB300C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:42:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so2626487wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tAiaXaGj8nHlfWbqmlwZJ7XE36ne8Bkm3mEzlMeH+s=;
        b=P+0mGfun2o4zL7Q0f89TXYvYd/8EqS+VkEdJjuz4aONa0EX9u8YUrxBiTE8yFTvino
         W50gjZrMuri2xFbtqqkjMKKiFjxvzitXi+xOa/uqKK0TiWVZwbTMjAvK8xTbJPIuuNLH
         CyD29eEn7O+mLnegXf0cI5/vcu0enw/ZaJ9akwxT9dUZalQMoiITLHjtiAb0a8cnV4sb
         4xn9iUNaSjbrg2gAekgDuHewFyeo9K1iYuDXKdUEkC+fBjYhfeiKAXIm4qSTUaggkMat
         rGhN8g/tFFAf54nS+i/jDXqoiqOcQWY3TpPyPB4BPO+XySIzMXOSUShhfQewfzVGaXUF
         BjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1tAiaXaGj8nHlfWbqmlwZJ7XE36ne8Bkm3mEzlMeH+s=;
        b=uj2HBKC6pYOtmICoh0uY1pznLe+GtPZSFC1QO17LLmV55DCgRLjh7hbppFosthXNS3
         Txt4RPJhlmD7zlDSI9eVn/GwYPGvQvOVBbqUILVyoxIgGLnoitByh4jv/6Bp1Olqe0tp
         En88k1K3H4lxIY6etYELrQ/DyHNYoS+hIB3RMHfkefBuMFxFsL18QB/nCjYoCaSHnS96
         fKGTx3zD0ghUpb8VxdfPoKBQ88kc42Yl84uSblQwlOeHoaNv3NET0KdYxRQBSTqSqXhU
         TcufQ/ke2AwiGZ37nKKXyEBju+Ry2IU2nUzQVY5wdc/0ufSykOssVsdAokCjqqiaP8Cp
         iryg==
X-Gm-Message-State: AOAM530J/sVTEXXL/jFkovs/Y7Gg7bP3TLQeUzxC3k51+OWMKI3oOFCp
        qeBP9zH7Pi/BqTwo/JnHIz1A43HqVKae/g==
X-Google-Smtp-Source: ABdhPJxtdqyMIMNjxuXt5Qy5j/YH4GAJ7I8A9a2o9QOBjwTi7Ho4fnssoJ5ApYOm6FeiNjuL/XqSAQ==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr7998974wro.126.1611765753511;
        Wed, 27 Jan 2021 08:42:33 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t8sm3109580wmq.36.2021.01.27.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 08:42:32 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] vt: keyboard, use new API for keyboard_tasklet
Date:   Wed, 27 Jan 2021 17:42:22 +0100
Message-Id: <20210127164222.13220-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the keyboard_tasklet to use the new API in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

The new API changes the argument passed to the callback function, but
fortunately the argument isn't used so it is straight forward to use
DECLARE_TASKLET_DISABLED() rather than DECLARE_TASKLET_DISABLED_OLD().

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
v2: Rebased on Greg's tty/tty-next tree.
---
 drivers/tty/vt/keyboard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 9f2eaa104ebc..77638629c562 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -131,8 +131,8 @@ static const unsigned char max_vals[] = {
 
 static const int NR_TYPES = ARRAY_SIZE(max_vals);
 
-static void kbd_bh(unsigned long dummy);
-static DECLARE_TASKLET_DISABLED_OLD(keyboard_tasklet, kbd_bh);
+static void kbd_bh(struct tasklet_struct *unused);
+static DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh);
 
 static struct input_handler kbd_handler;
 static DEFINE_SPINLOCK(kbd_event_lock);
@@ -1245,7 +1245,7 @@ void vt_kbd_con_stop(int console)
  * handle the scenario when keyboard handler is not registered yet
  * but we already getting updates from the VT to update led state.
  */
-static void kbd_bh(unsigned long dummy)
+static void kbd_bh(struct tasklet_struct *unused)
 {
 	unsigned int leds;
 	unsigned long flags;
-- 
2.30.0

