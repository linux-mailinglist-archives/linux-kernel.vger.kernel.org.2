Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AEF354839
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 23:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbhDEVkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhDEVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 17:40:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7FC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 14:40:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l123so7471587pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1OOeElLJtqxmaI+pmbJGchctTHLQGZdRDTjfg6sAm4=;
        b=fcsvE5gZMEtRQoNrL1qZvNS1XaF7mY940/71W4pChd9tvuoOiDMFALK0jXw3DLg1Jp
         n+KKwSOIwh+yu/Kl/c3tDm/kZBTE9wuRZ8L7jxMu21Y6im6+aL6XLT2PMn1BT7vKzQw0
         GzjlyI2Pm7f5bSQMYcMCMy7kx1LyTtTXoNZdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1OOeElLJtqxmaI+pmbJGchctTHLQGZdRDTjfg6sAm4=;
        b=bqjCozDmAegGg9M4QLTW5CggKWByaYx4/En9CJbGaIJ+/S4qd2KgYLEPcFAyF29tCb
         fwpvVvK8SDtcXUu9hZ2O0hmgB8CMJekfrc9OSIw5EuT80/RTanTyrHlvx/0EThGNpWf0
         RFc/mcwWoE4AbyB2v1FzL1bPVQrbQKzob4itLgPMAfe/2nmo4L3es6RE+/AY11MMtgdW
         SIMgErNLjzPLlIi5NrxFPVwUQxz5wCkpA3QMCKlcxuhbrWiwut0s+onst95oAbW3hilD
         Otslqy3FMcJlsazxkBzOKf+qtDI266xgPBLzfb3gQgqJCyF66SQrEbvBRXd4Z2z7qQJc
         PDbg==
X-Gm-Message-State: AOAM531tZJctC0Mn0N+64EnAndnn8zQ57yAcxjY7X3Uv+FKjwWonDa2b
        MaDENpDgGHEEdyfFs0nIAXhZYA==
X-Google-Smtp-Source: ABdhPJx2U2g2FDAJA2JpgZk/s0k4hf0/09WmFRWBYsLvS0D6tvzyNtrslCCYicVhHpuYv7G/YHwUIg==
X-Received: by 2002:a65:6704:: with SMTP id u4mr8926521pgf.169.1617658806418;
        Mon, 05 Apr 2021 14:40:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ot17sm328541pjb.50.2021.04.05.14.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 14:40:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: Make debugfs_allow RO after init
Date:   Mon,  5 Apr 2021 14:39:59 -0700
Message-Id: <20210405213959.3079432-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=58711bf15c0e3d60a203f252062cfd39ed293bd6; i=bbY0iH5I8KomiMHsHs/tYaXdbHEiZZjAT7b7i0+lbno=; m=WLVwuKvodnHsz31JSQm1T5rfca0iCIf22ffzZqGnC2w=; p=5YLdw0YVoPWUd3zp+Fs+gbtwzQ0zooOW0sEPonmTfuA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBrg68ACgkQiXL039xtwCYE2g//Z0L 4Uv1LqAMhFZpIDWu3Cx+ZxRbOvzXTjzOWSANfbordDCW3aFg+LgCYjdM7WsGBisHrU2E2LBqSzajG wp7Af0/VBClbmhD6Qw5Xf4V1zZv8zNW9IJAprd9h5PWRMJI4NgnWuCEnLPXQ40sCZ8P8E7NUMTjFw NMwK3hE+YQw8gi0Yce9rbIhz49wiBCddLub57aKcynY+5d1JQzqP6UUCa8urDckivndh4nghCQjqB FX5VvIq7uf1I9E2o+czzZB+0VwZe6cCbQAF1X4pl65cWfxs45qHtBdjiXX7Qrb4u93c/tbl+UmXCJ cI0dZ7/FtGdYnDk8z68BL/cHWsQcrNx7sXupTuTU+xz0/qIU0vDw5mxNoA4OBGTnQKQntrXuxa5MI RoHAU7ut07DXu/G/3CqDBLwH+RXKDE5xZ6QSrT8HcIUBSaY0zfoLDOuDH47/GD9trgsZT78CX89Z6 yY8aTshIJ8zihg4u2mVtoC9ARLhaakDgvB5IwzQsums/N5pRm8WDo7I771SExec/x7nAzHmB3MRw+ 6xRYoE+grnBhguZ+08OKchO1eBZ6OA5iU1KlU+4EjBh9UzW3hoq4sWZAxB/PuysXwL3udSq6hCFT8 aFliMbIYW5yLZebgMH79GYr5XUMAbXbofg8d8u3aKX/6YmUDKgjLzZ/pHhj/x430=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debugfs_allow is only set at boot time during __init, make it
read-only after being set.

Cc: Peter Enderborg <peter.enderborg@sony.com>
Fixes: a24c6f7bc923 ("debugfs: Add access restriction option")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 22e86ae4dd5a..1d252164d97b 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -35,7 +35,7 @@
 static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
-static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ALLOW_BITS;
+static unsigned int debugfs_allow __ro_after_init = DEFAULT_DEBUGFS_ALLOW_BITS;
 
 /*
  * Don't allow access attributes to be changed whilst the kernel is locked down
-- 
2.25.1

