Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA63534B9AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhC0VpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 17:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhC0Vo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:44:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66831C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 14:44:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o10so12835714lfb.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3wg0RfDT7B12umkmZco55Pf5265Dscr2E2y7rSMHH4=;
        b=HZvJe+CdUE992BE0QCOrxokIQdt6paoBnnPGBEe0DrTB7tXBPJNPf/GgvJZ5Z5bBCd
         /RhnjCEYipC0dJlI06wBFMdXQchowkPZQcCcZxRtOGlXNryfqpJygascdEY/gMw07Heq
         rNTwGTEOZGK2Grptz2/ul0QcIW04y4NmCL8ahcI78drcEvQDyFuBX3/gkICircHctTW0
         OQnBgjW65GOqpIs6uk/6WUd5CHg7u+pis2u79QnZRokAOTAHyY8/8nFDL8tMs2SkNe/5
         E4BcT/rriWsYAKHb63LnuOqOWMCwSzcw43WgOfY2FmU7uTDIyzsxhCjyCrQhLxt5J1XW
         n/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3wg0RfDT7B12umkmZco55Pf5265Dscr2E2y7rSMHH4=;
        b=piplLEK/KjQOmp/+FuPFxfzouOOKNkV0bTeysw9ZGYX7Jelmtg3YuZeXCAgUDzYQhS
         m97lzNxC17nEjBbkk/uAUMaGQbelXlqfGItEJ79/IqvRqCCyX0875KXnKC8NdM+DtnFh
         wrTLCdyoilOPAzLxn8wWIyinYWrCILSCXw59xgf7pDbLc4sZhqXKKunMcd7GHTEOwFPb
         VQsUbNnF1W6yXeRFiQf8j/XU3O5XUm+7oafJdqBK98LuKQQTFv24kBfUv+zFlTciUcsB
         yYiLwjNvIZpWn2lYCpf5P2pju5vUJ68ewYVn9jEzASWIJ+DeGqL0h5s5Z661gB9PFg91
         xgQw==
X-Gm-Message-State: AOAM533ZSEewadzu07vWK5Wj8ibip8QRQroVL8w1au4c7ZM/57KFMhuo
        4rfL5IDoxiA1Zz4KpLqZAjo=
X-Google-Smtp-Source: ABdhPJwct+lVW+QjDdIY0f7p8L5CVWELm18ELwK3pnHu7XC1GiJwcdpR95BAFAXKj6wG3hbg1284Tw==
X-Received: by 2002:a19:ec1a:: with SMTP id b26mr11614441lfa.610.1616881496726;
        Sat, 27 Mar 2021 14:44:56 -0700 (PDT)
Received: from localhost.localdomain ([94.103.227.42])
        by smtp.gmail.com with ESMTPSA id l29sm1303347lfp.63.2021.03.27.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:44:56 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com
Subject: [PATCH] tty: fix memory leak in vc_deallocate
Date:   Sun, 28 Mar 2021 00:44:43 +0300
Message-Id: <20210327214443.21548-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported memory leak in tty/vt.
The problem was in VT_DISALLOCATE ioctl cmd.
After allocating unimap with PIO_UNIMAP it wasn't
freed via VT_DISALLOCATE, but vc_cons[currcons].d was
zeroed.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Reported-by: syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com
---
 drivers/tty/vt/vt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 284b07224c55..0cc360da5426 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1381,6 +1381,7 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 		atomic_notifier_call_chain(&vt_notifier_list, VT_DEALLOCATE, &param);
 		vcs_remove_sysfs(currcons);
 		visual_deinit(vc);
+		con_free_unimap(vc);
 		put_pid(vc->vt_pid);
 		vc_uniscr_set(vc, NULL);
 		kfree(vc->vc_screenbuf);
-- 
2.30.2

