Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9C3F380B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 04:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbhHUCSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 22:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 22:18:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA63BC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:17:34 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a10so4004625qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OCIVuS9zI++EEsPA3uUnO7KU3t3+UL0yTYSbrtGoE4=;
        b=FIX9331/2Q4VyOOdVGwhHaE3/sxJMllVEzX64MJdgxfxYt91tUWoVipj1bI0Z3AGhC
         xLyZx71Mj6OoKcHB2Q2JwTqLKMLzQn8uiq+0ntkqr8wNjSuoM0muh3OZ4OFWeNbzV6zt
         RNILgkCjaz2dbRJWS7dFajzDeFoK7gdYh6HqIduTtVqpV3OhJiZfKoBEnxN7YR98qYNo
         zQhHrK3/UKutPWkLgJzHVHdU5Sej7HY22qn1dV/65jr/LxY4BeOWkZ+VcmvK0nw9Mmv+
         nl7Cd7bxuXVQzdXLPonwLz9lfrt59pwB0wxswMTnVfwCKrNv5loN5exKjNOQ4SK6ZNDv
         IQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OCIVuS9zI++EEsPA3uUnO7KU3t3+UL0yTYSbrtGoE4=;
        b=LEt9YR5h9r7tNwbR0UdlB5jIl6j/Jw0x2yyPkR/0jUH4uNlRw+tBD+Z8fZxB1Jqtfa
         ICtxCUUFEvEd3RMFQXjqSMuJh+zrs4WRPmaWEYY0BygAjemWBU79Ivru9RxhIvvb5hRA
         PCmQFaWmsYMk3JA2F/7KioSDrLIIF4hPmxwAy5pKiUtZbCSx8IZUZ+5/2ZXmVzNYE+lQ
         zRtBjtVC3ZnOYTlbCiy7mIoRhtuPAH30ZFc9NCJMZowCS3nx+QYLKUa7bk/OYqTU3NMI
         7jNdghPEREEeDCPNz7AF60OWC0dfp+VOiboly/7PyUiSgoMu9cDmL0hQpGx8D9djgP4I
         9/SQ==
X-Gm-Message-State: AOAM530VkX/s/6beCFMALwSrYUMqcV2fiGfSwBXcPPBKurKD/a6LRXiZ
        y+BsdWuxrwvTY+2qNNT1sS4=
X-Google-Smtp-Source: ABdhPJwuASxcpD0bpLtGQK7V743nM6plS3XLJ+2FHKxZ2OwCEz5sffw+jgIvP1FGxhc3TsGdZjFSEg==
X-Received: by 2002:a37:a481:: with SMTP id n123mr10993217qke.111.1629512254235;
        Fri, 20 Aug 2021 19:17:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j3sm3585658qti.4.2021.08.20.19.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 19:17:33 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <luo.penghao@zte.com.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] serial: drop unneeded assignment
Date:   Fri, 20 Aug 2021 19:17:27 -0700
Message-Id: <20210821021727.27170-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo penghao <luo.penghao@zte.com.cn>

The first assignment is not used. In order to keep the code style
consistency of the whole file, the first 'offset' assignment should be
deleted.

The clang_analyzer complains as follows:

drivers/tty/nozomi.c:520:6: warning:
Although the value storedto 'offset' is used in the enclosing expression,
the value is never actually read from 'offset'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
---
 drivers/tty/nozomi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 0454c78..210a48f 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -517,7 +517,7 @@ static void nozomi_setup_memory(struct nozomi *dc)
 
 	/* Ctrl dl configuration */
 	dc->port[PORT_CTRL].dl_addr[CH_A] =
-				(offset += dc->config_table.dl_app2_len);
+				(offset + dc->config_table.dl_app2_len);
 	dc->port[PORT_CTRL].dl_size[CH_A] =
 				dc->config_table.dl_ctrl_len - buff_offset;
 
-- 
2.15.2


