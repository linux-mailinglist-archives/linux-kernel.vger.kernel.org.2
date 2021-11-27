Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC91345FEF9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355223AbhK0N5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhK0NzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 08:55:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD274C061574
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 05:51:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id e3so50730826edu.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xMgI7UZ8bYorIpgxTWhGahpvFK7ny7kkXMTziiNej+0=;
        b=mWOd2DXuW5EN1i5DmFFqr4mBUn//G2o6ju7h9u5R1gXcTCkm/8cvRcG2fLSbPRJiX9
         dWeIGk9G7rg4jXYyOfiggm6Omhx1lh0DQJC0YvHCFAvK4kQQtO4ZKq1JJEc7/2BA+sBh
         /83RhpxwDMvwVR+hOI/pYKhs5+W0PTnLe4jXvfcFRrma8KA6ArQ3rDbGgVcuffErZmAA
         iOipJLrf3wOdzI8uy4QT6Op8Khy0QEEEz3K7ID0WnhoSjv3KUgDTLfXjAEyA/x0cdKNZ
         hAZ+zwDwX/lbrNCliRW2Z2pzFMEGoztnp9zXnkLR4lrRFy6MUKeMd5MPnFx2tj671SIb
         4x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xMgI7UZ8bYorIpgxTWhGahpvFK7ny7kkXMTziiNej+0=;
        b=VHzhMnXmdqKt/UH9QcZYmZ4/4c/wub9cNYGSO7f1+EjOVlCvoWDWNuB12WtpIJP5dP
         yEa4YJh26LowsH5TVZu2Z+U878r477zm6ZlL7tHNZtyUxfcrtxYFCvgXRcvaXiGHhWLd
         iuLgx1zcil79XebINU2kte1+GPzjlJjBVHiDM3nZ08HJQA+4EeNQhNk8moYCU67kmu6d
         4juqdAJ33P0zz92hdyDv3rjuk0es10QCDZ9WoQP2e9TJqDBkyLyAHwjz7RnFQ/9so9XF
         4AHn9jrCN7rBnIMQzfIvHvOZYDEfPEYaM4fL3hNm50677RYy6UvDuXBfVg9Fh7jyBETs
         MDIA==
X-Gm-Message-State: AOAM531lnyi5cOGR4soS7dXErkIaWcBkjepa8A2ngk+Y2hzwyKTIKwe5
        FYRLwElQ2Lt7T/gzZmkkOc0=
X-Google-Smtp-Source: ABdhPJxFLLHzOevdxL5qJx4Ca2r6IN4wTQVo/iuxdqvnR6jN2vvPussGQvrcHlBs84b9W0Qkv72hlw==
X-Received: by 2002:a05:6402:270b:: with SMTP id y11mr56960723edd.29.1638021109395;
        Sat, 27 Nov 2021 05:51:49 -0800 (PST)
Received: from localhost (host-82-63-56-77.business.telecomitalia.it. [82.63.56.77])
        by smtp.gmail.com with UTF8SMTPSA id kw10sm4391806ejc.71.2021.11.27.05.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 05:51:49 -0800 (PST)
From:   Alessandro Astone <ales.astone@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ales.astone@gmail.com, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs3: Fix showing umask option
Date:   Sat, 27 Nov 2021 14:51:05 +0100
Message-Id: <20211127135105.27795-1-ales.astone@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fmask and dmask are 16 bit unsigned, but without the explicit cast
printf sign-extends to 32 bit making it print fmask=37777600022
when it should print fmask=0022.

Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
---
 fs/ntfs3/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 29813200c7af..815a597a45ab 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -518,9 +518,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 	seq_printf(m, ",gid=%u",
 		  from_kgid_munged(user_ns, opts->fs_gid));
 	if (opts->fmask)
-		seq_printf(m, ",fmask=%04o", ~opts->fs_fmask_inv);
+		seq_printf(m, ",fmask=%04o", (u16)~opts->fs_fmask_inv);
 	if (opts->dmask)
-		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
+		seq_printf(m, ",dmask=%04o", (u16)~opts->fs_dmask_inv);
 	if (opts->nls)
 		seq_printf(m, ",iocharset=%s", opts->nls->charset);
 	else
-- 
2.33.1

