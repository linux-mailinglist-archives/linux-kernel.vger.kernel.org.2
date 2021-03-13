Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5644233A1F2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 00:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhCMXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 18:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCMXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 18:41:07 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 15:41:06 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s2so6716126qtx.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 15:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaauSWzUpLOsODbT6HaLz3qxx/89yBXURj9FLriKyx8=;
        b=Cso7PFIOtKUO13jsdcf3hWoQeH8FWo+H4AyDDEfa67ekYraUTKEjGc/fA2DleLRnpb
         02+3uvPApkc/gviswxfLesSp1ej+ceJ5BWUrk6rfajNvlFbIL8L/EhkiAxhZNiauTiCB
         JiF/3xQgi748X0L7LYeGPSmUq4Bl+9drypIJ+x7cMZEVum9kob0MZxwFRteF2E1FSL2x
         MPmaD27h0qi1TEWrIL7o2/4UzxUYHHa8Kbc+roiBtGt5JakWC0NVAZkga3h5FiPm5o9B
         pUOd31zVO3wopRr315Lx8COrufKJQQkdFFxdRPy2pxC//pN3BR/o60cGPTxJ99bAJ19+
         I+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaauSWzUpLOsODbT6HaLz3qxx/89yBXURj9FLriKyx8=;
        b=lqozPjMnYBByR+MjA6Et3uck1NDQSyqWS9ufGy6sI3gjvvtw9MnrmDIePBrPJElx0a
         mqZrzgQWDlm3QN4eW2ZHVJPiIIj4Q4U5+OYXRCnFwlDGCkgwfpSpF99GnN9KM7unc15c
         Gmq224gwId8lJk1VGXf/fcbLGXvBUpmolh1bYKT/YXytC+w4NbhyWmCwueP2p33NXbLe
         QvRmXJmlMmSmZyMCY8/Rad06NzmQ1w6HE70XsME5xaQwBZfFfsDIr5H2tQ814+cMnWfe
         PdFdQMjUY4hAHog7UQrNCjSj5HxCaILpGOswkNbhHqPbeBpIYl1FDJK4SvLntWMdeD6S
         17tw==
X-Gm-Message-State: AOAM533oDpLKRNPzsupQc0KAJ6GkEVWseBSc9Vij7suyvt7vXvkB+DmR
        OZ9z5+qELpgIBQNU3lMjU9E=
X-Google-Smtp-Source: ABdhPJyXN6bycRoiH8BYv7pCXAe0yC689oYCN9kympBH4LHdz2PCyBpGzgxgPrVE73QG8TFLLWSVcg==
X-Received: by 2002:ac8:5b8a:: with SMTP id a10mr17791892qta.108.1615678860271;
        Sat, 13 Mar 2021 15:41:00 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.114])
        by smtp.gmail.com with ESMTPSA id y1sm7697099qki.9.2021.03.13.15.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 15:40:59 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, nico@fluxnic.net,
        unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] tty: vt: Mundane typo fix in the file vt.c
Date:   Sun, 14 Mar 2021 05:08:42 +0530
Message-Id: <20210313233842.12275-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/spurrious/spurious/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 284b07224c55..c29e16505dd9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4448,7 +4448,7 @@ void poke_blanked_console(void)
 	might_sleep();

 	/* This isn't perfectly race free, but a race here would be mostly harmless,
-	 * at worse, we'll do a spurrious blank and it's unlikely
+	 * at worse, we'll do a spurious blank and it's unlikely
 	 */
 	del_timer(&console_timer);
 	blank_timer_expired = 0;
--
2.26.2

