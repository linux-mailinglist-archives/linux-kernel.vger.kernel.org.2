Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC0330032
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCGK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhCGK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:59:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238DC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 02:59:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u4so14699617lfs.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fAA4TPPCDGkT+Tya7F36DqMx6N0BmhqLnwdwo3XPN1I=;
        b=j6atcfc1psN5Tz+4WxpRYvcbaOb5cUdpU2mTeXew96BDlBhCTI2zMLpiMZdpFW31kf
         Z3T7fGkK2wmlRamJ4ReGoJOGJniv/oc8Oy2X/ZlaqtmYRkRWRB8gc0natK8ctq/ud88r
         /ntGLH/i+02eCf4W1/U2z7cDulZkXVJMdg/Yk/GofqT2PDhwn88+toqYsZdNGJm5tolp
         knqkmaf3j7/lGJ63WuhZBR9G6OmoMsluPdD8jybF1rzmM3NeGlfZt/XAOlKphAkF/gTR
         TPkUCwiZQM5CsovCWOXe+IXVv7jnEp7wnYIWU0gnbsNybNemZHdWIlqEYxeiMlmm4qOj
         1g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fAA4TPPCDGkT+Tya7F36DqMx6N0BmhqLnwdwo3XPN1I=;
        b=MTj+5L8OWBuQysk93B/SCmWF/y2YUf1j3LifYxeBbrVCLv0VJFfnNnyDrve5VuwBI1
         ACNBH7OvauSJeQJr6WLPFCEkp8O1wxulcpEjw20t5SQ6FsYJigaVqLGIr4op0srspinU
         JczpJ32vEybVcUdmLczufNl1FxC+Q1BGsvxSwGs0MK34fkN9kXdGp9XNt+IWqxxNz7JN
         ryFRTjLZ5OJ4HR6ov0PzCOAYwxfd8cGid5YZCJJKlpGV0Z7NE0PnPbywxRaJxmRsDFp3
         AfnHINBOf+8xxhxUSUR/uNKVnOLrs6b6r+KDTHU2ggtI7yCtzs2cLRbeyWfdZ01xP4pK
         MsXA==
X-Gm-Message-State: AOAM533zpviNX7AjhCNtYQ/R7hM4y9uI8HVbrVI0mCaQpKh/tv46TbBU
        giYMjFkq4G0UvHu6Q25ZQGdqMh2RZi4=
X-Google-Smtp-Source: ABdhPJy+OsC5NwTORRSLVfXZvtFhxe1uPGBorKGwbuijT5Cg2P3OclGEYk92MH+ymBFTpnXfVGijDA==
X-Received: by 2002:a05:6512:39d5:: with SMTP id k21mr11067828lfu.142.1615114746056;
        Sun, 07 Mar 2021 02:59:06 -0800 (PST)
Received: from localhost.localdomain (cable-hki-50dc98-67.dhcp.inet.fi. [80.220.152.67])
        by smtp.gmail.com with ESMTPSA id e9sm1044213ljj.52.2021.03.07.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 02:59:05 -0800 (PST)
From:   Hassan Shahbazi <h.shahbazi.git@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Hassan Shahbazi <h.shahbazi.git@gmail.com>
Subject: [PATCH] drivers: tty: vt: vt.c: fix NULL dereference crash
Date:   Sun,  7 Mar 2021 12:56:43 +0200
Message-Id: <20210307105642.112572-1-h.shahbazi.git@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a NULL deference crash on hiding the cursor.

Reported by: syzbot
https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b

Signed-off-by: Hassan Shahbazi <h.shahbazi.git@gmail.com>
---
 drivers/tty/vt/vt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 284b07224c55..8c3e83c81341 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -904,7 +904,9 @@ static void hide_cursor(struct vc_data *vc)
 	if (vc_is_sel(vc))
 		clear_selection();
 
-	vc->vc_sw->con_cursor(vc, CM_ERASE);
+	if (vc->vc_sw)
+		vc->vc_sw->con_cursor(vc, CM_ERASE);
+
 	hide_softcursor(vc);
 }
 
-- 
2.26.2

